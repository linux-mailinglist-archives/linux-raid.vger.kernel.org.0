Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF66810E7FA
	for <lists+linux-raid@lfdr.de>; Mon,  2 Dec 2019 10:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLBJwJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Dec 2019 04:52:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:49058 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfLBJwJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Dec 2019 04:52:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 01:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="241877986"
Received: from linux-myjy.igk.intel.com ([10.102.102.116])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2019 01:52:08 -0800
From:   Blazej Kucman <blazej.kucman@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
Subject: [PATCH] imsm: Change the way of printing nvme drives in detail-platform.
Date:   Mon,  2 Dec 2019 10:52:05 +0100
Message-Id: <20191202095205.16308-1-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Change NVMe controller path to device node path
in mdadm --detail-platform and print serial number.
The method imsm_read_serial always trimes serial to
MAX_RAID_SERIAL_LEN, added parameter 'serial_buf_len'
will be used to check the serial fit
to passed buffor, if not, will be trimed.

Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
---
 super-intel.c | 97 ++++++++++++++++++++++++++++-------------------------------
 1 file changed, 46 insertions(+), 51 deletions(-)

diff --git a/super-intel.c b/super-intel.c
index a103a3fc..0d2eea29 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -2182,7 +2182,8 @@ static void brief_detail_super_imsm(struct supertype *st)
 	printf(" UUID=%s", nbuf + 5);
 }
 
-static int imsm_read_serial(int fd, char *devname, __u8 *serial);
+static int imsm_read_serial(int fd, char *devname, __u8 *serial,
+			    size_t serial_buf_len);
 static void fd2devname(int fd, char *name);
 
 static int ahci_enumerate_ports(const char *hba_path, int port_count, int host_base, int verbose)
@@ -2328,8 +2329,9 @@ static int ahci_enumerate_ports(const char *hba_path, int port_count, int host_b
 		else {
 			fd2devname(fd, buf);
 			printf("          Port%d : %s", port, buf);
-			if (imsm_read_serial(fd, NULL, (__u8 *) buf) == 0)
-				printf(" (%.*s)\n", MAX_RAID_SERIAL_LEN, buf);
+			if (imsm_read_serial(fd, NULL, (__u8 *)buf,
+					     sizeof(buf)) == 0)
+				printf(" (%s)\n", buf);
 			else
 				printf(" ()\n");
 			close(fd);
@@ -2352,52 +2354,45 @@ static int ahci_enumerate_ports(const char *hba_path, int port_count, int host_b
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
+				if (!imsm_read_serial(fd, NULL, (__u8 *)buf,
+						      sizeof(buf)))
+					printf(" (%s)\n", buf);
+				else
+					printf("()\n");
+				close(fd);
+			}
+			free(rp);
 		}
-		free(rp);
 	}
 
 	closedir(dir);
@@ -2612,7 +2607,7 @@ static int detail_platform_imsm(int verbose, int enumerate_only, char *controlle
 					char buf[PATH_MAX];
 					printf(" I/O Controller : %s (%s)\n",
 						vmd_domain_to_controller(hba, buf), get_sys_dev_type(hba->type));
-					if (print_vmd_attached_devs(hba)) {
+					if (print_nvme_info(hba)) {
 						if (verbose > 0)
 							pr_err("failed to get devices attached to VMD domain.\n");
 						result |= 2;
@@ -2627,7 +2622,7 @@ static int detail_platform_imsm(int verbose, int enumerate_only, char *controlle
 		if (entry->type == SYS_DEV_NVME) {
 			for (hba = list; hba; hba = hba->next) {
 				if (hba->type == SYS_DEV_NVME)
-					printf("    NVMe Device : %s\n", hba->path);
+					print_nvme_info(hba);
 			}
 			printf("\n");
 			continue;
@@ -3992,11 +3987,11 @@ static int nvme_get_serial(int fd, void *buf, size_t buf_len)
 extern int scsi_get_serial(int fd, void *buf, size_t buf_len);
 
 static int imsm_read_serial(int fd, char *devname,
-			    __u8 serial[MAX_RAID_SERIAL_LEN])
+			    __u8 *serial, size_t serial_buf_len)
 {
 	char buf[50];
 	int rv;
-	int len;
+	size_t len;
 	char *dest;
 	char *src;
 	unsigned int i;
@@ -4039,13 +4034,13 @@ static int imsm_read_serial(int fd, char *devname,
 	len = dest - buf;
 	dest = buf;
 
-	/* truncate leading characters */
-	if (len > MAX_RAID_SERIAL_LEN) {
-		dest += len - MAX_RAID_SERIAL_LEN;
-		len = MAX_RAID_SERIAL_LEN;
+	if (len > serial_buf_len) {
+		/* truncate leading characters */
+		dest += len - serial_buf_len;
+		len = serial_buf_len;
 	}
 
-	memset(serial, 0, MAX_RAID_SERIAL_LEN);
+	memset(serial, 0, serial_buf_len);
 	memcpy(serial, dest, len);
 
 	return 0;
@@ -4100,7 +4095,7 @@ load_imsm_disk(int fd, struct intel_super *super, char *devname, int keep_fd)
 	char name[40];
 	__u8 serial[MAX_RAID_SERIAL_LEN];
 
-	rv = imsm_read_serial(fd, devname, serial);
+	rv = imsm_read_serial(fd, devname, serial, MAX_RAID_SERIAL_LEN);
 
 	if (rv != 0)
 		return 2;
@@ -5808,7 +5803,7 @@ int mark_spare(struct dl *disk)
 		return ret_val;
 
 	ret_val = 0;
-	if (!imsm_read_serial(disk->fd, NULL, serial)) {
+	if (!imsm_read_serial(disk->fd, NULL, serial, MAX_RAID_SERIAL_LEN)) {
 		/* Restore disk serial number, because takeover marks disk
 		 * as failed and adds to serial ':0' before it becomes
 		 * a spare disk.
@@ -5859,7 +5854,7 @@ static int add_to_super_imsm(struct supertype *st, mdu_disk_info_t *dk,
 	dd->fd = fd;
 	dd->e = NULL;
 	dd->action = DISK_ADD;
-	rv = imsm_read_serial(fd, devname, dd->serial);
+	rv = imsm_read_serial(fd, devname, dd->serial, MAX_RAID_SERIAL_LEN);
 	if (rv) {
 		pr_err("failed to retrieve scsi serial, aborting\n");
 		if (dd->devname)
-- 
2.16.4

