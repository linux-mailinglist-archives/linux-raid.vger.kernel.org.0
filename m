Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566D865221
	for <lists+linux-raid@lfdr.de>; Thu, 11 Jul 2019 08:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfGKG7R (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 11 Jul 2019 02:59:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:60427 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbfGKG7R (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 11 Jul 2019 02:59:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 23:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="171149182"
Received: from linux-h5ai.igk.intel.com ([10.102.102.116])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2019 23:59:15 -0700
From:   Blazej Kucman <blazej.kucman@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     Jes.Sorensen@gmail.com, Blazej Kucman <blazej.kucman@intel.com>
Subject: [PATCH] imsm: Change in --detail-platform for NVMe devices
Date:   Thu, 11 Jul 2019 08:59:11 +0200
Message-Id: <20190711065911.3237-1-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Change NVMe controller path to device node path
in mdadm --detail-platform and print serial number.

Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
---
 super-intel.c | 75 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/super-intel.c b/super-intel.c
index 520abf5d..23ea4f92 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -2283,58 +2283,59 @@ static int ahci_enumerate_ports(const char *hba_path, int port_count, int host_b
 	return err;
 }
 
-static int print_vmd_attached_devs(struct sys_dev *hba)
+static int print_nvme_info(struct sys_dev *hba)
 {
+	char buf[1024];
 	struct dirent *ent;
 	DIR *dir;
-	char path[292];
-	char link[256];
-	char *c, *rp;
-
-	if (hba->type != SYS_DEV_VMD)
-		return 1;
+	char *rp;
+	int fd;
 
-	/* scroll through /sys/dev/block looking for devices attached to
-	 * this hba
-	 */
-	dir = opendir("/sys/bus/pci/drivers/nvme");
+	dir = opendir("/sys/block/");
 	if (!dir)
 		return 1;
 
 	for (ent = readdir(dir); ent; ent = readdir(dir)) {
-		int n;
-
-		/* is 'ent' a device? check that the 'subsystem' link exists and
-		 * that its target matches 'bus'
-		 */
-		sprintf(path, "/sys/bus/pci/drivers/nvme/%s/subsystem",
-			ent->d_name);
-		n = readlink(path, link, sizeof(link));
-		if (n < 0 || n >= (int)sizeof(link))
-			continue;
-		link[n] = '\0';
-		c = strrchr(link, '/');
-		if (!c)
-			continue;
-		if (strncmp("pci", c+1, strlen("pci")) != 0)
-			continue;
-
-		sprintf(path, "/sys/bus/pci/drivers/nvme/%s", ent->d_name);
-
-		rp = realpath(path, NULL);
-		if (!rp)
-			continue;
+		if (strstr(ent->d_name, "nvme")) {
+			sprintf(buf, "/sys/block/%s", ent->d_name);
+			rp = realpath(buf, NULL);
+			if (!rp)
+				continue;
+			if (path_attached_to_hba(rp, hba->path)) {
+				fd = open_dev(ent->d_name);
+				if (fd < 0) {
+					free(rp);
+					continue;
+				}
 
-		if (path_attached_to_hba(rp, hba->path)) {
-			printf(" NVMe under VMD : %s\n", rp);
+				fd2devname(fd, buf);
+				if (hba->type == SYS_DEV_VMD)
+					printf(" NVMe under VMD : %s", buf);
+				else if (hba->type == SYS_DEV_NVME)
+					printf("    NVMe Device : %s", buf);
+				if (!imsm_read_serial(fd, NULL, (__u8 *)buf))
+					printf(" (%.*s)\n", MAX_RAID_SERIAL_LEN,
+					       buf);
+				else
+					printf("()\n");
+				close(fd);
+			}
+			free(rp);
 		}
-		free(rp);
 	}
 
 	closedir(dir);
 	return 0;
 }
 
+static int print_vmd_attached_devs(struct sys_dev *hba)
+{
+	if (hba->type != SYS_DEV_VMD)
+		return 1;
+
+	return print_nvme_info(hba);
+}
+
 static void print_found_intel_controllers(struct sys_dev *elem)
 {
 	for (; elem; elem = elem->next) {
@@ -2558,7 +2559,7 @@ static int detail_platform_imsm(int verbose, int enumerate_only, char *controlle
 		if (entry->type == SYS_DEV_NVME) {
 			for (hba = list; hba; hba = hba->next) {
 				if (hba->type == SYS_DEV_NVME)
-					printf("    NVMe Device : %s\n", hba->path);
+					print_nvme_info(hba);
 			}
 			printf("\n");
 			continue;
-- 
2.16.4

