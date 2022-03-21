Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BBB4E265D
	for <lists+linux-raid@lfdr.de>; Mon, 21 Mar 2022 13:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347335AbiCUMai (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 21 Mar 2022 08:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347362AbiCUMah (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 21 Mar 2022 08:30:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D238B12AC0
        for <linux-raid@vger.kernel.org>; Mon, 21 Mar 2022 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647865749; x=1679401749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n6OcYj1V8RD9Ie+lh2zLjrW3Sv1/WvMJhf4uHfVR10Q=;
  b=SVs8f3w+fsG/qca40TUbapDtuK05N6U8EgjeasLlU+l09ruCW4MgO2n7
   duGB0Q7GKmhVwmDUUS1MZZ6X0HXiJG+aAm4tWJ8MUky1/RKw1fxusKihz
   Saxjea0Psm23jXruoUK5dwksCuGVAmXhbsZoo2xqTgOkedkERjzXdgYqg
   OesYpsnpzq8BvobxEyTHovLyVoSfORmnd9V5di+OIcx7GaCGaJDl0ciPj
   g+eZa4OW8AdMoOv82hhIoiqHkMj5rQv/vY+92pmMeBVgzHqLs3zcyvr0U
   9xTkUVpYrMDFj8BR3rnVhwrx7OE8LxBaKBr6mPuFoGmN8NwuODbA+OfD5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="238141482"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="238141482"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:29:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="518417632"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.102.97])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2022 05:29:07 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de
Subject: [PATCH] Mdmonitor: Fix segfault and improve logging
Date:   Mon, 21 Mar 2022 13:32:34 +0100
Message-Id: <20220321123234.28769-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Oleksandr Shchirskyi <oleksandr.shchirskyi@linux.intel.com>

Check that devices passed to mdmonitor are md arrays.
Also, change logging, so mdmonitor in verbose mode will report its
configuration.

Signed-off-by: Oleksandr Shchirskyi <oleksandr.shchirskyi@intel.com>
Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
---
 Monitor.c | 36 ++++++++++++++++++++++++------------
 mdadm.h   |  1 +
 mdopen.c  | 17 +++++++++++++++++
 util.c    |  2 +-
 4 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/Monitor.c b/Monitor.c
index f5412299..bd417d04 100644
--- a/Monitor.c
+++ b/Monitor.c
@@ -137,24 +137,27 @@ int Monitor(struct mddev_dev *devlist,
 	struct mddev_ident *mdlist;
 	int delay_for_event = c->delay;
 
-	if (!mailaddr) {
+	if (!mailaddr)
 		mailaddr = conf_get_mailaddr();
-		if (mailaddr && ! c->scan)
-			pr_err("Monitor using email address \"%s\" from config file\n",
-			       mailaddr);
-	}
-	mailfrom = conf_get_mailfrom();
 
-	if (!alert_cmd) {
+	if (!alert_cmd)
 		alert_cmd = conf_get_program();
-		if (alert_cmd && !c->scan)
-			pr_err("Monitor using program \"%s\" from config file\n",
-			       alert_cmd);
-	}
+
+	mailfrom = conf_get_mailfrom();
+
 	if (c->scan && !mailaddr && !alert_cmd && !dosyslog) {
 		pr_err("No mail address or alert command - not monitoring.\n");
 		return 1;
 	}
+
+	if (c->verbose) {
+		pr_err("Monitor is started with delay %ds\n", c->delay);
+		if (mailaddr)
+			pr_err("Monitor using email address %s\n", mailaddr);
+		if (alert_cmd)
+			pr_err("Monitor using program %s\n", alert_cmd);
+	}
+
 	info.alert_cmd = alert_cmd;
 	info.mailaddr = mailaddr;
 	info.mailfrom = mailfrom;
@@ -183,6 +186,10 @@ int Monitor(struct mddev_dev *devlist,
 				continue;
 			if (strcasecmp(mdlist->devname, "<ignore>") == 0)
 				continue;
+
+			if (!is_mddev(mdlist->devname))
+				return 1;
+
 			st = xcalloc(1, sizeof *st);
 			if (mdlist->devname[0] == '/')
 				st->devname = xstrdup(mdlist->devname);
@@ -204,7 +211,12 @@ int Monitor(struct mddev_dev *devlist,
 		struct mddev_dev *dv;
 
 		for (dv = devlist; dv; dv = dv->next) {
-			struct state *st = xcalloc(1, sizeof *st);
+			struct state *st;
+
+			if (!is_mddev(dv->devname))
+				return 1;
+
+			st = xcalloc(1, sizeof *st);
 			mdlist = conf_get_ident(dv->devname);
 			st->devname = xstrdup(dv->devname);
 			st->next = statelist;
diff --git a/mdadm.h b/mdadm.h
index 8f8841d8..03151c34 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -1607,6 +1607,7 @@ extern int create_mddev(char *dev, char *name, int autof, int trustworthy,
 #define	FOREIGN	2
 #define	METADATA 3
 extern int open_mddev(char *dev, int report_errors);
+extern int is_mddev(char *dev);
 extern int open_container(int fd);
 extern int metadata_container_matches(char *metadata, char *devnm);
 extern int metadata_subdev_matches(char *metadata, char *devnm);
diff --git a/mdopen.c b/mdopen.c
index 245be537..d18c9319 100644
--- a/mdopen.c
+++ b/mdopen.c
@@ -475,6 +475,23 @@ int open_mddev(char *dev, int report_errors)
 	return mdfd;
 }
 
+/**
+ * is_mddev() - check that file name passed is an md device.
+ * @dev: file name that has to be checked.
+ * Return: 1 if file passed is an md device, 0 if not.
+ */
+int is_mddev(char *dev)
+{
+	int fd = open_mddev(dev, 1);
+
+	if (fd >= 0) {
+		close(fd);
+		return 1;
+	}
+
+	return 0;
+}
+
 char *find_free_devnm(int use_partitions)
 {
 	static char devnm[32];
diff --git a/util.c b/util.c
index cdf1da24..003b2f86 100644
--- a/util.c
+++ b/util.c
@@ -268,7 +268,7 @@ int md_array_active(int fd)
 		 * GET_ARRAY_INFO doesn't provide access to the proper state
 		 * information, so fallback to a basic check for raid_disks != 0
 		 */
-		ret = ioctl(fd, GET_ARRAY_INFO, &array);
+		ret = md_get_array_info(fd, &array);
 	}
 
 	return !ret;
-- 
2.26.2

