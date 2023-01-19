Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA286673AB6
	for <lists+linux-raid@lfdr.de>; Thu, 19 Jan 2023 14:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjASNtX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Jan 2023 08:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjASNtL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Jan 2023 08:49:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91621458BA
        for <linux-raid@vger.kernel.org>; Thu, 19 Jan 2023 05:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674136147; x=1705672147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E7tj72jxWq/d4a2U1QZ3uDzvUDBXojSxWHBNZDw2ZMM=;
  b=kyjoGknLMZU/jzmohtFD7VD/xh3lRKwsubAF18/f3PXIHAF7BAGi9X1W
   U6RIeuB1aC6d1fEgmuU1xBFzhZpO2oT3jVGLZyIq6KvjfnrWUPhXGibC5
   iOLmIV7oAv/xFtzt12Px8toROUa+TBB2SIoXPc/3tYM6RfDU81u5Xs3Qc
   iRQUfSlVOQNLmwE/H2VW0vWNhoHBHvFbkacZaWi6AidOgxyJozHpwce0x
   ejtCLjdYb8hVhjhEta5cLBlWl5kmINh654PqQDm3hg+eGGuaTmq9tlsD2
   I2xv8oOPeA9xNAsqS4fX1BQeLkZL0rqA1wG1SxWTc+Sm9FqXzfwkXjjIv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323973358"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="323973358"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 05:49:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="768221935"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="768221935"
Received: from unknown (HELO localhost.elements.local) ([10.102.104.85])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2023 05:49:01 -0800
From:   Mateusz Grzonka <mateusz.grzonka@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org
Subject: [PATCH 1/8] Mdmonitor: Make alert_info global
Date:   Thu, 19 Jan 2023 14:30:02 +0100
Message-Id: <20230119133009.12696-2-mateusz.grzonka@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230119133009.12696-1-mateusz.grzonka@intel.com>
References: <20230119133009.12696-1-mateusz.grzonka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Move information about --test flag and hostname into alert_info.

Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
---
 Monitor.c | 124 +++++++++++++++++++++++++++---------------------------
 1 file changed, 61 insertions(+), 63 deletions(-)

diff --git a/Monitor.c b/Monitor.c
index 188cb8be..9ef4dab8 100644
--- a/Monitor.c
+++ b/Monitor.c
@@ -58,21 +58,20 @@ struct state {
 };
 
 struct alert_info {
+	char hostname[HOST_NAME_MAX];
 	char *mailaddr;
 	char *mailfrom;
 	char *alert_cmd;
 	int dosyslog;
-};
+	int test;
+} info;
 static int make_daemon(char *pidfile);
 static int check_one_sharer(int scan);
 static void write_autorebuild_pid(void);
-static void alert(const char *event, const char *dev, const char *disc, struct alert_info *info);
-static int check_array(struct state *st, struct mdstat_ent *mdstat,
-		       int test, struct alert_info *info,
-		       int increments, char *prefer);
-static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist,
-			  int test, struct alert_info *info);
-static void try_spare_migration(struct state *statelist, struct alert_info *info);
+static void alert(const char *event, const char *dev, const char *disc);
+static int check_array(struct state *st, struct mdstat_ent *mdstat, int increments, char *prefer);
+static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist);
+static void try_spare_migration(struct state *statelist);
 static void link_containers_with_subarrays(struct state *list);
 static void free_statelist(struct state *statelist);
 #ifndef NO_LIBUDEV
@@ -132,7 +131,6 @@ int Monitor(struct mddev_dev *devlist,
 	int finished = 0;
 	struct mdstat_ent *mdstat = NULL;
 	char *mailfrom;
-	struct alert_info info;
 	struct mddev_ident *mdlist;
 	int delay_for_event = c->delay;
 
@@ -166,6 +164,13 @@ int Monitor(struct mddev_dev *devlist,
 	info.mailaddr = mailaddr;
 	info.mailfrom = mailfrom;
 	info.dosyslog = dosyslog;
+	info.test = c->test;
+
+	if (gethostname(info.hostname, sizeof(info.hostname)) != 0) {
+		pr_err("Cannot get hostname.\n");
+		return 1;
+	}
+	info.hostname[sizeof(info.hostname) - 1] = '\0';
 
 	if (share){
 		if (check_one_sharer(c->scan))
@@ -241,8 +246,7 @@ int Monitor(struct mddev_dev *devlist,
 		mdstat = mdstat_read(oneshot ? 0 : 1, 0);
 
 		for (st = statelist; st; st = st->next) {
-			if (check_array(st, mdstat, c->test, &info,
-					increments, c->prefer))
+			if (check_array(st, mdstat, increments, c->prefer))
 				anydegraded = 1;
 			/* for external arrays, metadata is filled for
 			 * containers only
@@ -255,15 +259,14 @@ int Monitor(struct mddev_dev *devlist,
 
 		/* now check if there are any new devices found in mdstat */
 		if (c->scan)
-			new_found = add_new_arrays(mdstat, &statelist, c->test,
-						   &info);
+			new_found = add_new_arrays(mdstat, &statelist);
 
 		/* If an array has active < raid && spare == 0 && spare_group != NULL
 		 * Look for another array with spare > 0 and active == raid and same spare_group
 		 * if found, choose a device and hotremove/hotadd
 		 */
 		if (share && anydegraded)
-			try_spare_migration(statelist, &info);
+			try_spare_migration(statelist);
 		if (!new_found) {
 			if (oneshot)
 				break;
@@ -294,7 +297,7 @@ int Monitor(struct mddev_dev *devlist,
 				mdstat_close();
 			}
 		}
-		c->test = 0;
+		info.test = 0;
 
 		for (stp = &statelist; (st = *stp) != NULL; ) {
 			if (st->from_auto && st->err > 5) {
@@ -412,7 +415,7 @@ static void write_autorebuild_pid()
 	}
 }
 
-static void execute_alert_cmd(const char *event, const char *dev, const char *disc, struct alert_info *info)
+static void execute_alert_cmd(const char *event, const char *dev, const char *disc)
 {
 	int pid = fork();
 
@@ -424,15 +427,14 @@ static void execute_alert_cmd(const char *event, const char *dev, const char *di
 		pr_err("Cannot fork to execute alert command");
 		break;
 	case 0:
-		execl(info->alert_cmd, info->alert_cmd, event, dev, disc, NULL);
+		execl(info.alert_cmd, info.alert_cmd, event, dev, disc, NULL);
 		exit(2);
 	}
 }
 
-static void send_event_email(const char *event, const char *dev, const char *disc, struct alert_info *info)
+static void send_event_email(const char *event, const char *dev, const char *disc)
 {
 	FILE *mp, *mdstat;
-	char hname[256];
 	char buf[BUFSIZ];
 	int n;
 
@@ -442,14 +444,13 @@ static void send_event_email(const char *event, const char *dev, const char *dis
 		return;
 	}
 
-	gethostname(hname, sizeof(hname));
 	signal(SIGPIPE, SIG_IGN);
-	if (info->mailfrom)
-		fprintf(mp, "From: %s\n", info->mailfrom);
+	if (info.mailfrom)
+		fprintf(mp, "From: %s\n", info.mailfrom);
 	else
 		fprintf(mp, "From: %s monitoring <root>\n", Name);
-	fprintf(mp, "To: %s\n", info->mailaddr);
-	fprintf(mp, "Subject: %s event on %s:%s\n\n", event, dev, hname);
+	fprintf(mp, "To: %s\n", info.mailaddr);
+	fprintf(mp, "Subject: %s event on %s:%s\n\n", event, dev, info.hostname);
 	fprintf(mp, "This is an automatically generated mail message. \n");
 	fprintf(mp, "A %s event had been detected on md device %s.\n\n", event, dev);
 
@@ -501,37 +502,36 @@ static void log_event_to_syslog(const char *event, const char *dev, const char *
 		syslog(priority, "%s event detected on md device %s", event, dev);
 }
 
-static void alert(const char *event, const char *dev, const char *disc, struct alert_info *info)
+static void alert(const char *event, const char *dev, const char *disc)
 {
-	if (!info->alert_cmd && !info->mailaddr && !info->dosyslog) {
+	if (!info.alert_cmd && !info.mailaddr && !info.dosyslog) {
 		time_t now = time(0);
 
 		printf("%1.15s: %s on %s %s\n", ctime(&now) + 4,
 		       event, dev, disc?disc:"unknown device");
 	}
-	if (info->alert_cmd)
-		execute_alert_cmd(event, dev, disc, info);
+	if (info.alert_cmd)
+		execute_alert_cmd(event, dev, disc);
 
-	if (info->mailaddr && (strncmp(event, "Fail", 4) == 0 ||
+	if (info.mailaddr && (strncmp(event, "Fail", 4) == 0 ||
 			       strncmp(event, "Test", 4) == 0 ||
 			       strncmp(event, "Spares", 6) == 0 ||
 			       strncmp(event, "Degrade", 7) == 0)) {
-		send_event_email(event, dev, disc, info);
+		send_event_email(event, dev, disc);
 	}
 
-	if (info->dosyslog)
+	if (info.dosyslog)
 		log_event_to_syslog(event, dev, disc);
 }
 
 static int check_array(struct state *st, struct mdstat_ent *mdstat,
-		       int test, struct alert_info *ainfo,
 		       int increments, char *prefer)
 {
 	/* Update the state 'st' to reflect any changes shown in mdstat,
 	 * or found by directly examining the array, and return
 	 * '1' if the array is degraded, or '0' if it is optimal (or dead).
 	 */
-	struct { int state, major, minor; } info[MAX_DISKS];
+	struct { int state, major, minor; } disks_info[MAX_DISKS];
 	struct mdinfo *sra = NULL;
 	mdu_array_info_t array;
 	struct mdstat_ent *mse = NULL, *mse2;
@@ -545,8 +545,8 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
 	int is_container = 0;
 	unsigned long redundancy_only_flags = 0;
 
-	if (test)
-		alert("TestMessage", dev, NULL, ainfo);
+	if (info.test)
+		alert("TestMessage", dev, NULL);
 
 	retval = 0;
 
@@ -595,7 +595,7 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
 	 */
 	if (sra->array.level == 0 || sra->array.level == -1) {
 		if (!st->err && !st->from_config)
-			alert("DeviceDisappeared", dev, " Wrong-Level", ainfo);
+			alert("DeviceDisappeared", dev, " Wrong-Level");
 		st->err++;
 		goto out;
 	}
@@ -612,7 +612,7 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
 		st->percent = RESYNC_NONE;
 		new_array = 1;
 		if (!is_container)
-			alert("NewArray", st->devname, NULL, ainfo);
+			alert("NewArray", st->devname, NULL);
 	}
 
 	if (st->utime == array.utime && st->failed == sra->array.failed_disks &&
@@ -625,14 +625,14 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
 	}
 	if (st->utime == 0 && /* new array */
 	    mse->pattern && strchr(mse->pattern, '_') /* degraded */)
-		alert("DegradedArray", dev, NULL, ainfo);
+		alert("DegradedArray", dev, NULL);
 
 	if (st->utime == 0 && /* new array */ st->expected_spares > 0 &&
 	    sra->array.spare_disks < st->expected_spares)
-		alert("SparesMissing", dev, NULL, ainfo);
+		alert("SparesMissing", dev, NULL);
 	if (st->percent < 0 && st->percent != RESYNC_UNKNOWN &&
 	    mse->percent >= 0)
-		alert("RebuildStarted", dev, NULL, ainfo);
+		alert("RebuildStarted", dev, NULL);
 	if (st->percent >= 0 && mse->percent >= 0 &&
 	    (mse->percent / increments) > (st->percent / increments)) {
 		char percentalert[18];
@@ -647,7 +647,7 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
 			snprintf(percentalert, sizeof(percentalert),
 				 "Rebuild%02d", mse->percent);
 
-		alert(percentalert, dev, NULL, ainfo);
+		alert(percentalert, dev, NULL);
 	}
 
 	if (mse->percent == RESYNC_NONE && st->percent >= 0) {
@@ -660,9 +660,9 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
 			snprintf(cnt, sizeof(cnt),
 				 " mismatches found: %d (on raid level %d)",
 				 sra->mismatch_cnt, sra->array.level);
-			alert("RebuildFinished", dev, cnt, ainfo);
+			alert("RebuildFinished", dev, cnt);
 		} else
-			alert("RebuildFinished", dev, NULL, ainfo);
+			alert("RebuildFinished", dev, NULL);
 	}
 	st->percent = mse->percent;
 
@@ -671,13 +671,13 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
 		mdu_disk_info_t disc;
 		disc.number = i;
 		if (md_get_disk_info(fd, &disc) >= 0) {
-			info[i].state = disc.state;
-			info[i].major = disc.major;
-			info[i].minor = disc.minor;
+			disks_info[i].state = disc.state;
+			disks_info[i].major = disc.major;
+			disks_info[i].minor = disc.minor;
 			if (disc.major || disc.minor)
 				remaining_disks --;
 		} else
-			info[i].major = info[i].minor = 0;
+			disks_info[i].major = disks_info[i].minor = 0;
 	}
 	last_disk = i;
 
@@ -700,13 +700,13 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
 		int change;
 		char *dv = NULL;
 		disc.number = i;
-		if (i < last_disk && (info[i].major || info[i].minor)) {
-			newstate = info[i].state;
-			dv = map_dev_preferred(info[i].major, info[i].minor, 1,
+		if (i < last_disk && (disks_info[i].major || disks_info[i].minor)) {
+			newstate = disks_info[i].state;
+			dv = map_dev_preferred(disks_info[i].major, disks_info[i].minor, 1,
 					       prefer);
 			disc.state = newstate;
-			disc.major = info[i].major;
-			disc.minor = info[i].minor;
+			disc.major = disks_info[i].major;
+			disc.minor = disks_info[i].minor;
 		} else
 			newstate = (1 << MD_DISK_REMOVED);
 
@@ -716,14 +716,14 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
 		change = newstate ^ st->devstate[i];
 		if (st->utime && change && !st->err && !new_array) {
 			if ((st->devstate[i]&change) & (1 << MD_DISK_SYNC))
-				alert("Fail", dev, dv, ainfo);
+				alert("Fail", dev, dv);
 			else if ((newstate & (1 << MD_DISK_FAULTY)) &&
 				 (disc.major || disc.minor) &&
 				 st->devid[i] == makedev(disc.major,
 							 disc.minor))
-				alert("FailSpare", dev, dv, ainfo);
+				alert("FailSpare", dev, dv);
 			else if ((newstate&change) & (1 << MD_DISK_SYNC))
-				alert("SpareActive", dev, dv, ainfo);
+				alert("SpareActive", dev, dv);
 		}
 		st->devstate[i] = newstate;
 		st->devid[i] = makedev(disc.major, disc.minor);
@@ -747,13 +747,12 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
 
  disappeared:
 	if (!st->err && !is_container)
-		alert("DeviceDisappeared", dev, NULL, ainfo);
+		alert("DeviceDisappeared", dev, NULL);
 	st->err++;
 	goto out;
 }
 
-static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist,
-			  int test, struct alert_info *info)
+static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist)
 {
 	struct mdstat_ent *mse;
 	int new_found = 0;
@@ -806,8 +805,8 @@ static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist,
 			} else
 				st->parent_devnm[0] = 0;
 			*statelist = st;
-			if (test)
-				alert("TestMessage", st->devname, NULL, info);
+			if (info.test)
+				alert("TestMessage", st->devname, NULL);
 			new_found = 1;
 		}
 	return new_found;
@@ -971,7 +970,7 @@ static dev_t container_choose_spare(struct state *from, struct state *to,
 	return dev;
 }
 
-static void try_spare_migration(struct state *statelist, struct alert_info *info)
+static void try_spare_migration(struct state *statelist)
 {
 	struct state *from;
 	struct state *st;
@@ -1030,8 +1029,7 @@ static void try_spare_migration(struct state *statelist, struct alert_info *info
 				if (devid > 0 &&
 				    move_spare(from->devname, to->devname,
 					       devid)) {
-					alert("MoveSpare", to->devname,
-					      from->devname, info);
+					alert("MoveSpare", to->devname, from->devname);
 					break;
 				}
 			}
-- 
2.26.2

