Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD4A1A2442
	for <lists+linux-raid@lfdr.de>; Wed,  8 Apr 2020 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgDHOsJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Apr 2020 10:48:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:2362 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbgDHOsJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 8 Apr 2020 10:48:09 -0400
IronPort-SDR: 8jIVcd+AULvAFzVGqiGoVIhJedhL7WAjw9h6/klcsv/IQfd0h20GA/MdDX9ImDxlLdH1x+ZCi6
 DpbyMv+hRv/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 07:48:09 -0700
IronPort-SDR: I1+FE9XDAAq9D41XH0utL8TaWVSs4xQkRdmz1Y1mPSQOWG9ZovDY6NC4IA9dvWL+KEXjPLmy+K
 2u2o5rgSumBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,358,1580803200"; 
   d="scan'208";a="286566474"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2020 07:48:08 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] Manage, imsm: Write metadata before add
Date:   Wed,  8 Apr 2020 16:47:58 +0200
Message-Id: <20200408144758.19360-1-mariusz.tkaczyk@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

New drive in container always appears as spare. Manager is able to
handle that, and queues appropriative update to monitor.
No update from mdadm side has to be processed, just insert the drive and
ping the mdmon. Metadata has to be written if no mdmon is running (case
for Raid0 or container without arrays).

If bare drive is added very early on startup (by custom bare rule),
there is possiblity that mdmon was not restarted after switch root. Old
one is not able to handle new drive. New one fails because there is
drive without metadata in container and metadata cannot be loaded.

To prevent this, write spare metadata before adding device
to container. Mdmon will overwrite it (same case as spare migration,
if drive appears it writes the most recent metadata).
Metadata has to be written only on new drive before sysfs_add_disk(),
don't race with mdmon if running.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
---
 Manage.c      |  6 +----
 super-intel.c | 67 +++++++++++++++++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/Manage.c b/Manage.c
index b22c3969..0a5f09b3 100644
--- a/Manage.c
+++ b/Manage.c
@@ -994,17 +994,13 @@ int Manage_add(int fd, int tfd, struct mddev_dev *dv,
 
 		Kill(dv->devname, NULL, 0, -1, 0);
 		dfd = dev_open(dv->devname, O_RDWR | O_EXCL|O_DIRECT);
-		if (mdmon_running(tst->container_devnm))
-			tst->update_tail = &tst->updates;
 		if (tst->ss->add_to_super(tst, &disc, dfd,
 					  dv->devname, INVALID_SECTORS)) {
 			close(dfd);
 			close(container_fd);
 			return -1;
 		}
-		if (tst->update_tail)
-			flush_metadata_updates(tst);
-		else
+		if (!mdmon_running(tst->container_devnm))
 			tst->ss->sync_metadata(tst);
 
 		sra = sysfs_read(container_fd, NULL, 0);
diff --git a/super-intel.c b/super-intel.c
index c9a1af5b..bc5412aa 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -5799,6 +5799,9 @@ int mark_spare(struct dl *disk)
 	return ret_val;
 }
 
+
+static int write_super_imsm_spare(struct intel_super *super, struct dl *d);
+
 static int add_to_super_imsm(struct supertype *st, mdu_disk_info_t *dk,
 			     int fd, char *devname,
 			     unsigned long long data_offset)
@@ -5928,9 +5931,13 @@ static int add_to_super_imsm(struct supertype *st, mdu_disk_info_t *dk,
 		dd->next = super->disk_mgmt_list;
 		super->disk_mgmt_list = dd;
 	} else {
+		/* this is called outside of mdmon
+		 * write initial spare metadata
+		 * mdmon will overwrite it.
+		 */
 		dd->next = super->disks;
 		super->disks = dd;
-		super->updates_pending++;
+		write_super_imsm_spare(super, dd);
 	}
 
 	return 0;
@@ -5969,15 +5976,15 @@ static union {
 	struct imsm_super anchor;
 } spare_record __attribute__ ((aligned(MAX_SECTOR_SIZE)));
 
-/* spare records have their own family number and do not have any defined raid
- * devices
- */
-static int write_super_imsm_spares(struct intel_super *super, int doclose)
+
+static int write_super_imsm_spare(struct intel_super *super, struct dl *d)
 {
 	struct imsm_super *mpb = super->anchor;
 	struct imsm_super *spare = &spare_record.anchor;
 	__u32 sum;
-	struct dl *d;
+
+	if (d->index != -1)
+		return 1;
 
 	spare->mpb_size = __cpu_to_le32(sizeof(struct imsm_super));
 	spare->generation_num = __cpu_to_le32(1UL);
@@ -5990,28 +5997,42 @@ static int write_super_imsm_spares(struct intel_super *super, int doclose)
 	snprintf((char *) spare->sig, MAX_SIGNATURE_LENGTH,
 		 MPB_SIGNATURE MPB_VERSION_RAID0);
 
-	for (d = super->disks; d; d = d->next) {
-		if (d->index != -1)
-			continue;
+	spare->disk[0] = d->disk;
+	if (__le32_to_cpu(d->disk.total_blocks_hi) > 0)
+		spare->attributes |= MPB_ATTRIB_2TB_DISK;
 
-		spare->disk[0] = d->disk;
-		if (__le32_to_cpu(d->disk.total_blocks_hi) > 0)
-			spare->attributes |= MPB_ATTRIB_2TB_DISK;
+	if (super->sector_size == 4096)
+		convert_to_4k_imsm_disk(&spare->disk[0]);
 
-		if (super->sector_size == 4096)
-			convert_to_4k_imsm_disk(&spare->disk[0]);
+	sum = __gen_imsm_checksum(spare);
+	spare->family_num = __cpu_to_le32(sum);
+	spare->orig_family_num = 0;
+	sum = __gen_imsm_checksum(spare);
+	spare->check_sum = __cpu_to_le32(sum);
 
-		sum = __gen_imsm_checksum(spare);
-		spare->family_num = __cpu_to_le32(sum);
-		spare->orig_family_num = 0;
-		sum = __gen_imsm_checksum(spare);
-		spare->check_sum = __cpu_to_le32(sum);
+	if (store_imsm_mpb(d->fd, spare)) {
+		pr_err("failed for device %d:%d %s\n",
+			d->major, d->minor, strerror(errno));
+		return 1;
+	}
+
+	return 0;
+}
+/* spare records have their own family number and do not have any defined raid
+ * devices
+ */
+static int write_super_imsm_spares(struct intel_super *super, int doclose)
+{
+	struct dl *d;
+	int res;
+
+	for (d = super->disks; d; d = d->next) {
+		if (d->index != -1)
+			continue;
 
-		if (store_imsm_mpb(d->fd, spare)) {
-			pr_err("failed for device %d:%d %s\n",
-				d->major, d->minor, strerror(errno));
+		if (write_super_imsm_spare(super, d))
 			return 1;
-		}
+
 		if (doclose) {
 			close(d->fd);
 			d->fd = -1;
-- 
2.25.0

