Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6B35B04F2
	for <lists+linux-raid@lfdr.de>; Wed,  7 Sep 2022 15:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIGNPP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 7 Sep 2022 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIGNOs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 7 Sep 2022 09:14:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6321F2DD
        for <linux-raid@vger.kernel.org>; Wed,  7 Sep 2022 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662556475; x=1694092475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOST9iQ8rHxkjb8KNzZlhd8hj822S3rRksaZcZiA5Ig=;
  b=OSwi+L71m66jcX5WvhcilR4WrbxSjsTl7S4YpzcjAVUfcXK2ZrnN+/ka
   fL3kVDxBBZ75EB3n5Dmq91G7SKi9wnz0cOJVuuop5SuWlQ9flY3YQpXJ1
   Igg1c8/liN01vhWwHQXpJm7OMUYuXsOQFrAzv5QIma7zqs7/TbTkCt4ga
   Ia5bnNbxn8KUAzvYMFXFVYAgNRLKcnvAC3NmL719jNyPk7ZKioK+OMMkg
   EsCShyB6rLbDny4lRLCiSO4oi22SP4pIwwsxTG3JYcbojRokdVE4aHAUs
   UMRjB0dR8YBVm/D9i1T43Nj+zxZRveHcczqZoWayJ0QeVICH1asbA3L9T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296865394"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="296865394"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 06:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="644608675"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.105.50])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2022 06:14:32 -0700
From:   Mateusz Grzonka <mateusz.grzonka@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org
Subject: [PATCH 8/9] Mdmonitor: Improve udev event handling
Date:   Wed,  7 Sep 2022 14:56:56 +0200
Message-Id: <20220907125657.12192-9-mateusz.grzonka@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220907125657.12192-1-mateusz.grzonka@intel.com>
References: <20220907125657.12192-1-mateusz.grzonka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Mdmonitor is waiting for udev queue to become empty.
Even if the queue becomes empty, udev might still be processing last event.
However we want to wait and wake up mdmonitor when udev finished
processing events.

Also, the udev queue interface is considered legacy and should not be
used outside of udev.

Use udev monitor instead, and wake up mdmonitor on every event triggered
by udev for md block device.

We need to generate more change events from kernel, because they are
missing in some situations, for example, when rebuild started.
This will be addressed in a separate patch.

Move udev specific code into separate functions, and place them in udev.c file.
Also move use_udev() logic from lib.c into newly created file.

Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
---
 Makefile  |   3 +-
 Manage.c  |   3 +-
 Monitor.c | 137 +++++++++++++++++++-------------------------------
 lib.c     |  13 -----
 mdadm.h   |   1 -
 mdopen.c  |   7 +--
 udev.c    | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 udev.h    |  36 +++++++++++++
 8 files changed, 241 insertions(+), 106 deletions(-)
 create mode 100644 udev.c
 create mode 100644 udev.h

diff --git a/Makefile b/Makefile
index bf126033..ed371006 100644
--- a/Makefile
+++ b/Makefile
@@ -124,6 +124,7 @@ LDLIBS = -ldl
 # To explicitly disable libudev, set -DNO_LIBUDEV in CXFLAGS
 ifeq (, $(findstring -DNO_LIBUDEV,  $(CXFLAGS)))
 	LDLIBS += -ludev
+	OBJS = udev.o
 endif
 
 INSTALL = /usr/bin/install
@@ -145,7 +146,7 @@ else
 	ECHO=:
 endif
 
-OBJS =  mdadm.o config.o policy.o mdstat.o  ReadMe.o uuid.o util.o maps.o lib.o \
+OBJS += mdadm.o config.o policy.o mdstat.o  ReadMe.o uuid.o util.o maps.o lib.o \
 	Manage.o Assemble.o Build.o \
 	Create.o Detail.o Examine.o Grow.o Monitor.o dlink.o Kill.o Query.o \
 	Incremental.o Dump.o \
diff --git a/Manage.c b/Manage.c
index f789e0c1..dae09901 100644
--- a/Manage.c
+++ b/Manage.c
@@ -25,6 +25,7 @@
 #include "mdadm.h"
 #include "md_u.h"
 #include "md_p.h"
+#include "udev.h"
 #include <ctype.h>
 
 int Manage_ro(char *devname, int fd, int readonly)
@@ -472,7 +473,7 @@ done:
 			sysfs_uevent(mdi, "change");
 	}
 
-	if (devnm[0] && use_udev()) {
+	if (devnm[0] && udev_is_available()) {
 		struct map_ent *mp = map_by_devnm(&map, devnm);
 		remove_devices(devnm, mp ? mp->path : NULL);
 	}
diff --git a/Monitor.c b/Monitor.c
index aa79cf6c..dd3ea347 100644
--- a/Monitor.c
+++ b/Monitor.c
@@ -23,18 +23,17 @@
  */
 
 #include	"mdadm.h"
+#include	"udev.h"
 #include	"md_p.h"
 #include	"md_u.h"
 #include	<sys/wait.h>
 #include	<limits.h>
 #include	<syslog.h>
-#ifndef NO_LIBUDEV
-#include	<libudev.h>
-#endif
 
 #define TASK_COMM_LEN 16
 #define EVENT_NAME_MAX 32
 #define AUTOREBUILD_PID_PATH MDMON_DIR "/autorebuild.pid"
+#define FALLBACK_DELAY 5
 
 struct state {
 	char *devname;
@@ -119,12 +118,11 @@ struct event_data {
 static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist);
 static int check_array(struct state *st, struct mdstat_ent *mdstat, int increments, char *prefer);
 static int check_one_sharer(int scan);
-#ifndef NO_LIBUDEV
-static int check_udev_activity(void);
-#endif
 static void link_containers_with_subarrays(struct state *list);
 static int make_daemon(char *pidfile);
 static void try_spare_migration(struct state *statelist);
+static void wait_for_events(int *delay_for_event, int c_delay);
+static void wait_for_events_mdstat(int *delay_for_event, int c_delay);
 static int write_autorebuild_pid(void);
 
 int Monitor(struct mddev_dev *devlist,
@@ -310,32 +308,12 @@ int Monitor(struct mddev_dev *devlist,
 		if (!new_found) {
 			if (oneshot)
 				break;
-			else if (!anyredundant) {
+			if (!anyredundant) {
 				pr_err("No array with redundancy detected, stopping\n");
 				break;
 			}
-			else {
-#ifndef NO_LIBUDEV
-				/*
-				 * Wait for udevd to finish new devices
-				 * processing.
-				 */
-				if (mdstat_wait(delay_for_event) &&
-				    check_udev_activity())
-					pr_err("Error while waiting for UDEV to complete new devices processing\n");
-#else
-				int wait_result = mdstat_wait(delay_for_event);
-				/*
-				 * Give chance to process new device
-				 */
-				if (wait_result != 0) {
-					if (c->delay > 5)
-						delay_for_event = 5;
-				} else
-					delay_for_event = c->delay;
-#endif
-				mdstat_close();
-			}
+
+			wait_for_events(&delay_for_event, c->delay);
 		}
 		info.test = 0;
 
@@ -359,6 +337,49 @@ int Monitor(struct mddev_dev *devlist,
 	return 0;
 }
 
+/**
+ * wait_for_events() - Waits for events on md devices.
+ * @delay_for_event: pointer to current event delay
+ * @c_delay: delay from config
+ */
+static void wait_for_events(int *delay_for_event, int c_delay)
+{
+#ifndef NO_LIBUDEV
+	if (udev_is_available()) {
+		if (udev_wait_for_events(*delay_for_event) == UDEV_STATUS_ERROR)
+			pr_err("Error while waiting for udev events.\n");
+		return;
+	}
+#endif
+	wait_for_events_mdstat(delay_for_event, c_delay);
+}
+
+/**
+ * wait_for_events_mdstat() - Waits for events on mdstat.
+ * @delay_for_event: pointer to current event delay
+ * @c_delay: delay from config
+ */
+static void wait_for_events_mdstat(int *delay_for_event, int c_delay)
+{
+	int wait_result = mdstat_wait(*delay_for_event);
+
+	if (wait_result < 0) {
+		pr_err("Error while waiting for events on mdstat.\n");
+		return;
+	}
+
+	/*
+	 * Give chance to process new device
+	 */
+	if (wait_result != 0) {
+		if (c_delay > FALLBACK_DELAY)
+			*delay_for_event = FALLBACK_DELAY;
+	} else {
+		*delay_for_event = c_delay;
+	}
+	mdstat_close();
+}
+
 static int make_daemon(char *pidfile)
 {
 	/* Return:
@@ -1222,64 +1243,6 @@ static void link_containers_with_subarrays(struct state *list)
 				}
 }
 
-#ifndef NO_LIBUDEV
-/* function: check_udev_activity
- * Description: Function waits for udev to finish
- * events processing.
- * Returns:
- *		1 - detected error while opening udev
- *		2 - timeout
- *		0 - successfull completion
- */
-static int check_udev_activity(void)
-{
-	struct udev *udev = NULL;
-	struct udev_queue *udev_queue = NULL;
-	int timeout_cnt = 30;
-	int rc = 0;
-
-	/*
-	 * In rare cases systemd may not have udevm,
-	 * in such cases just exit with rc 0
-	 */
-	if (!use_udev())
-		goto out;
-
-	udev = udev_new();
-	if (!udev) {
-		rc = 1;
-		goto out;
-	}
-
-	udev_queue = udev_queue_new(udev);
-	if (!udev_queue) {
-		rc = 1;
-		goto out;
-	}
-
-	if (udev_queue_get_queue_is_empty(udev_queue))
-		goto out;
-
-	while (!udev_queue_get_queue_is_empty(udev_queue)) {
-		sleep(1);
-
-		if (timeout_cnt)
-			timeout_cnt--;
-		else {
-			rc = 2;
-			goto out;
-		}
-	}
-
-out:
-	if (udev_queue)
-		udev_queue_unref(udev_queue);
-	if (udev)
-		udev_unref(udev);
-	return rc;
-}
-#endif
-
 /* Not really Monitor but ... */
 int Wait(char *dev)
 {
diff --git a/lib.c b/lib.c
index 7e3e3d47..10a6ae40 100644
--- a/lib.c
+++ b/lib.c
@@ -483,19 +483,6 @@ int check_env(char *name)
 	return 0;
 }
 
-int use_udev(void)
-{
-	static int use = -1;
-	struct stat stb;
-
-	if (use < 0) {
-		use = ((stat("/dev/.udev", &stb) == 0 ||
-			stat("/run/udev", &stb) == 0) &&
-		       check_env("MDADM_NO_UDEV") == 0);
-	}
-	return use;
-}
-
 unsigned long GCD(unsigned long a, unsigned long b)
 {
 	while (a != b) {
diff --git a/mdadm.h b/mdadm.h
index 9183ee70..3c08f826 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -1559,7 +1559,6 @@ extern char *conf_line(FILE *file);
 extern char *conf_word(FILE *file, int allow_key);
 extern void print_quoted(char *str);
 extern void print_escape(char *str);
-extern int use_udev(void);
 extern unsigned long GCD(unsigned long a, unsigned long b);
 extern int conf_name_is_free(char *name);
 extern int conf_verify_devnames(struct mddev_ident *array_list);
diff --git a/mdopen.c b/mdopen.c
index 245be537..53da4d96 100644
--- a/mdopen.c
+++ b/mdopen.c
@@ -23,6 +23,7 @@
  */
 
 #include "mdadm.h"
+#include "udev.h"
 #include "md_p.h"
 #include <ctype.h>
 
@@ -176,7 +177,7 @@ int create_mddev(char *dev, char *name, int autof, int trustworthy,
 	char devnm[32];
 	char cbuf[400];
 
-	if (!use_udev())
+	if (!udev_is_available())
 		block_udev = 0;
 
 	if (chosen == NULL)
@@ -383,7 +384,7 @@ int create_mddev(char *dev, char *name, int autof, int trustworthy,
 	 * If we cannot detect udev, we need to make
 	 * devices and links ourselves.
 	 */
-	if (!use_udev()) {
+	if (!udev_is_available()) {
 		/* Make sure 'devname' exists and 'chosen' is a symlink to it */
 		if (lstat(devname, &stb) == 0) {
 			/* Must be the correct device, else error */
@@ -490,7 +491,7 @@ char *find_free_devnm(int use_partitions)
 			continue;
 		if (!conf_name_is_free(devnm))
 			continue;
-		if (!use_udev()) {
+		if (!udev_is_available()) {
 			/* make sure it is new to /dev too, at least as a
 			 * non-standard */
 			dev_t devid = devnm2devid(devnm);
diff --git a/udev.c b/udev.c
new file mode 100644
index 00000000..18055bfc
--- /dev/null
+++ b/udev.c
@@ -0,0 +1,147 @@
+/*
+ * mdadm - manage Linux "md" devices aka RAID arrays.
+ *
+ * Copyright (C) 2022 Mateusz Grzonka <mateusz.grzonka@intel.com>
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include	"mdadm.h"
+#include	"udev.h"
+#include	"md_p.h"
+#include	"md_u.h"
+#include	<sys/wait.h>
+#include	<signal.h>
+#include	<limits.h>
+#include	<syslog.h>
+#include	<libudev.h>
+
+static struct udev *udev;
+static struct udev_monitor *udev_monitor;
+
+/**
+ * udev_is_available() - Checks for udev in the system.
+ *
+ * Function looks whether udev binaries are available and MDADM_NO_UDEV env defined.
+ *
+ * Return:
+ * true if udev is available,
+ * false if not
+ */
+bool udev_is_available(void)
+{
+	struct stat stb;
+
+	if (stat("/dev/.udev", &stb) != 0 &&
+	    stat("/run/udev", &stb) != 0)
+		return false;
+	if (check_env("MDADM_NO_UDEV") == 1)
+		return false;
+	return true;
+}
+
+/**
+ * udev_initialize() - Initializes udev and udev_monitor structures.
+ *
+ * Function initializes udev, udev_monitor, and sets udev_monitor filter for block devices.
+ *
+ * Return:
+ * UDEV_STATUS_SUCCESS on success
+ * UDEV_STATUS_ERROR on error
+ * UDEV_STATUS_ERROR_NO_UDEV when udev not available
+ */
+enum udev_status udev_initialize(void)
+{
+	if (!udev_is_available()) {
+		pr_err("No udev.\n");
+		return UDEV_STATUS_ERROR_NO_UDEV;
+	}
+
+	udev = udev_new();
+	if (!udev) {
+		pr_err("Cannot initialize udev.\n");
+		return UDEV_STATUS_ERROR;
+	}
+
+	udev_monitor = udev_monitor_new_from_netlink(udev, "udev");
+	if (!udev_monitor) {
+		pr_err("Cannot initialize udev monitor.\n");
+		udev = udev_unref(udev);
+		return UDEV_STATUS_ERROR;
+	}
+
+	if (udev_monitor_filter_add_match_subsystem_devtype(udev_monitor, "block", 0) < 0) {
+		pr_err("Cannot add udev monitor event filter for md devices.\n");
+		udev_release();
+		return UDEV_STATUS_ERROR;
+	}
+	if (udev_monitor_enable_receiving(udev_monitor) < 0) {
+		pr_err("Cannot enable receiving udev events through udev monitor.\n");
+		udev_release();
+		return UDEV_STATUS_ERROR;
+	}
+	atexit(udev_release);
+	return UDEV_STATUS_SUCCESS;
+}
+
+/**
+ * udev_wait_for_events() - Waits for events from udev.
+ * @seconds: Timeout in seconds.
+ *
+ * Function waits udev events, wakes up on event or timeout.
+ *
+ * Return:
+ * UDEV_STATUS_SUCCESS on detected event
+ * UDEV_STATUS_TIMEOUT on timeout
+ * UDEV_STATUS_ERROR on error
+ */
+enum udev_status udev_wait_for_events(int seconds)
+{
+	int fd;
+	fd_set readfds;
+	struct timeval tv;
+	int ret;
+
+	if (!udev || !udev_monitor) {
+		ret = udev_initialize();
+		if (ret != UDEV_STATUS_SUCCESS)
+			return ret;
+	}
+
+	fd = udev_monitor_get_fd(udev_monitor);
+	if (fd < 0) {
+		pr_err("Cannot access file descriptor associated with udev monitor.\n");
+		return UDEV_STATUS_ERROR;
+	}
+
+	FD_ZERO(&readfds);
+	FD_SET(fd, &readfds);
+	tv.tv_sec = seconds;
+	tv.tv_usec = 0;
+
+	if (select(fd + 1, &readfds, NULL, NULL, &tv) > 0 && FD_ISSET(fd, &readfds))
+		if (udev_monitor_receive_device(udev_monitor))
+			return UDEV_STATUS_SUCCESS; /* event detected */
+	return UDEV_STATUS_TIMEOUT;
+}
+
+/**
+ * udev_release() - Drops references of udev and udev_monitor.
+ */
+void udev_release(void)
+{
+	udev_monitor_unref(udev_monitor);
+	udev_unref(udev);
+}
diff --git a/udev.h b/udev.h
new file mode 100644
index 00000000..515366e7
--- /dev/null
+++ b/udev.h
@@ -0,0 +1,36 @@
+/*
+ * mdadm - manage Linux "md" devices aka RAID arrays.
+ *
+ * Copyright (C) 2022 Mateusz Grzonka <mateusz.grzonka@intel.com>
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef MONITOR_UDEV_H
+#define MONITOR_UDEV_H
+
+enum udev_status {
+	UDEV_STATUS_ERROR_NO_UDEV = -2,
+	UDEV_STATUS_ERROR,
+	UDEV_STATUS_SUCCESS = 0,
+	UDEV_STATUS_TIMEOUT
+};
+
+bool udev_is_available(void);
+enum udev_status udev_initialize(void);
+enum udev_status udev_wait_for_events(int seconds);
+void udev_release(void);
+
+#endif
-- 
2.26.2

