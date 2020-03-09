Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B9517D843
	for <lists+linux-raid@lfdr.de>; Mon,  9 Mar 2020 04:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCID0M (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 8 Mar 2020 23:26:12 -0400
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:42845 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbgCID0M (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 8 Mar 2020 23:26:12 -0400
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Mon,  9 Mar 2020 03:25:03 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 9 Mar 2020 03:25:00 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 9 Mar 2020 03:24:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJJZ6RGcVTWV2hJftODJt9tmLh7lRcER7Wsrr0rq11zmFz/nHah1c5kt5cUWjcs2EygBq6+zJ94BwISXGarlKfyenFXUhKxa6uqS11cnO37qIaWEpnBpCOHZqDJPpqQ5A11Xw3H4fWEQ/8w5SAI/6fadchkVteVAqvof2ETRHWX7rwNplM9L3jNbekANxhqhmmRdWgg4ptdYbnwIY1Onw9hgz7SUA7e6HYpCQIHmQnvHvRaHCblflIVnlI5vSRlInCsGXlUYZC5GVshMBhTHIZeYR+0I+/GPHlMdJ/ghIrkLbUj4r+csND/5xaX384mx0MgLKh3SxI//yBNa5XuFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62bCS9WzuYdIKVTjN6WEG6gYUuixuJ1rdEnNVlxriiM=;
 b=O6o1Rm6cuqaQtkGH8fiLef59Q5k20rPggjOebf9w80LyK7K6dmNp2i0MqnqxuFmv1n9BnJXHRhNCTK6NxZdL9TsD1GDpn3QcMgBKLo17Jmb1IBFg0zuRsHT1GCVw+YpN2zGJfIMdktudPnD8e4x493UC52qG5H7d+l44fOCMtmR9qh2plQTNa53qh/uD5yxFcat1TOwpROizk6pgvHstZsu6PQcPw6RyePGGxwIWiBo05aUIjLK/f1vOsNK+cvvCFoXS5iUKDiKUh+PkNFCgS5Fr+u1jGD42p7w//wGZsMXpT6Em8KkAkg3iV2ut2SsPn5NBgc3h/9Ml51mloiHKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from DM5PR18MB2150.namprd18.prod.outlook.com (2603:10b6:4:b8::35) by
 DM5PR18MB1434.namprd18.prod.outlook.com (2603:10b6:3:bc::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 03:24:58 +0000
Received: from DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::5572:55be:b57b:dea]) by DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::5572:55be:b57b:dea%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 03:24:58 +0000
From:   Lidong Zhong <lidong.zhong@suse.com>
To:     <jsorensen@fb.com>
CC:     <linux-raid@vger.kernel.org>
Subject: [PATCH] Monitor: remove autorebuild pidfile when it exits
Date:   Mon, 9 Mar 2020 11:24:36 +0800
Message-ID: <20200309032436.5902-1-lidong.zhong@suse.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: DM5PR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:3:5d::31) To DM5PR18MB2150.namprd18.prod.outlook.com
 (2603:10b6:4:b8::35)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-rzeb.suse (39.64.187.231) by DM5PR06CA0045.namprd06.prod.outlook.com (2603:10b6:3:5d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Mon, 9 Mar 2020 03:24:56 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [39.64.187.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91663f8f-f49b-4b5b-e3e9-08d7c3d97191
X-MS-TrafficTypeDiagnostic: DM5PR18MB1434:
X-Microsoft-Antispam-PRVS: <DM5PR18MB143449743DCD91008707E17FF8FE0@DM5PR18MB1434.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(5660300002)(66556008)(66476007)(478600001)(956004)(66946007)(26005)(186003)(16526019)(316002)(2616005)(8936002)(36756003)(81166006)(81156014)(8676002)(86362001)(4326008)(6916009)(6486002)(6512007)(2906002)(8886007)(6506007)(1076003)(6666004)(52116002)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR18MB1434;H:DM5PR18MB2150.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmUgXOMS98PQO9H3LzaQVJc7hpAMRy6QFpuXUJpW0/LEgbxmcbGCg+5cDZpcEZRI490ff31F++FIGLXFnZV71CITEz8JAgONPg0sw5pbDA1GQNKzUGJDv8sP+zWLSkzHWUCg8++c32ZZmlthy8Gbo+X2zCvpM/scIKt+yYs/SlP587je9P746DJv6rvrkQNEiARBHGbjQhYsVUofrmvosoGZZQILVn+mcwEAnVWYcN6MHcvFhQVBZouj3GSib4c/9l6CREhnJ5MdfsXlvv9w1jmnTxXOYOoCG5x43mTps5jOR58VroIzi8KdtIPR4zkWHQttWsRV9UwgCxXfxdr/YlfuSaNW01BnfpnolQdHHTgGgaabbnCPfYPIncQNrLPKc5DxasyV8m1hZb3qKxjfNiKTz8uPYMmQFd2MXGO5pfIgnsWoic+Y+cV0kTuYyUlv
X-MS-Exchange-AntiSpam-MessageData: PMRvkHja8g6WBLnm7t5NT+BMk+lv0ydPQRq4W0e3OvnGNxFufSfDupwBSPzxRtxcxBKSSKJCgm4ZOfp95sL0ntTiDX2/qA2MVHsKE0xFau04QQnZgbWen08VowhwgLLWfGi3c0KX97adSAhFTYRpAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91663f8f-f49b-4b5b-e3e9-08d7c3d97191
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 03:24:58.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXcwdoIIsE/IP80rlxKzCw/xStSU65i75DU1QRlh1MtJI69NDtD70fP8AeJ7Er3ajGLPETYEiWPHjGfO8dNAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1434
X-OriginatorOrg: suse.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Though the mdadm monitor is supposed to run in background and never
exit, user may want to restart it and kill the daemon forcefully. If
the pid stored in autorebuild.pid is taken by some other process, it
reports that
"mdadm: Only one autorebuild process allowed in scan mode, aborting"
even though no autorebuild process exists. With this patch this file
will be removed at the end to fix this error.

Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
---
Hi Jes, 

could you please share your opinion about this patch? TIA.
---
 Monitor.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Monitor.c b/Monitor.c
index b527165..4cb113d 100644
--- a/Monitor.c
+++ b/Monitor.c
@@ -62,6 +62,7 @@ struct alert_info {
 	int dosyslog;
 };
 static int make_daemon(char *pidfile);
+static int cleanup_sharer_pidfile();
 static int check_one_sharer(int scan);
 static void alert(char *event, char *dev, char *disc, struct alert_info *info);
 static int check_array(struct state *st, struct mdstat_ent *mdstat,
@@ -71,6 +72,12 @@ static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist,
 			  int test, struct alert_info *info);
 static void try_spare_migration(struct state *statelist, struct alert_info *info);
 static void link_containers_with_subarrays(struct state *list);
+static volatile sig_atomic_t finished = 0;
+
+static void _exit_handler(int sig)                                                                                               
+{
+	finished= 1;
+}
 
 int Monitor(struct mddev_dev *devlist,
 	    char *mailaddr, char *alert_cmd,
@@ -123,7 +130,6 @@ int Monitor(struct mddev_dev *devlist,
 
 	struct state *statelist = NULL;
 	struct state *st2;
-	int finished = 0;
 	struct mdstat_ent *mdstat = NULL;
 	char *mailfrom;
 	struct alert_info info;
@@ -157,6 +163,11 @@ int Monitor(struct mddev_dev *devlist,
 		if (rv >= 0)
 			return rv;
 	}
+	
+	signal(SIGTERM, &_exit_handler);  
+	signal(SIGKILL, &_exit_handler);  
+	signal(SIGINT, &_exit_handler);
+	signal(SIGQUIT, &_exit_handler);
 
 	if (share)
 		if (check_one_sharer(c->scan))
@@ -260,6 +271,8 @@ int Monitor(struct mddev_dev *devlist,
 
 	if (pidfile)
 		unlink(pidfile);
+	if (cleanup_sharer_pidfile())
+		pr_err("Cannot remove autorebuild.pidfile\n");
 	return 0;
 }
 
@@ -299,6 +312,30 @@ static int make_daemon(char *pidfile)
 	return -1;
 }
 
+static int cleanup_sharer_pidfile()
+{
+	int pid, rv;
+	FILE *fp;
+	char path[100];
+	char dir[20];
+	struct stat buf;
+	sprintf(path, "%s/autorebuild.pid", MDMON_DIR);
+	fp = fopen(path, "r");
+	if (fp) {
+		if (fscanf(fp, "%d", &pid) != 1)
+			pid = -1;
+		sprintf(dir, "/proc/%d", pid);
+		rv = stat(dir, &buf);
+		if (rv != -1) {
+			fclose(fp);
+			unlink(path);
+		} else
+			return 1;
+	}
+
+	return 0;
+}
+
 static int check_one_sharer(int scan)
 {
 	int pid, rv;
-- 
2.16.4

