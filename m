Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A32194E74
	for <lists+linux-raid@lfdr.de>; Fri, 27 Mar 2020 02:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgC0BaL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 26 Mar 2020 21:30:11 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:45727 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgC0BaL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 26 Mar 2020 21:30:11 -0400
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Fri, 27 Mar 2020 01:29:17 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 27 Mar 2020 01:30:03 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 27 Mar 2020 01:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+KT9vAbS1pHdOWgQsZAGWSyqUnSXXQBpPtvHlNM0W9sCShkSQG1k0OuKx909ULM0gwGrsw7lZJ5hafh89hUXr8kTAzVHIewDbqj6TeRNmDtKGSDRVCZ4AzXO1qfjB2B45bHB/U1OogFFtDBECwyfsLilqa+jAZ/sWD9EppnF52wwLTgc5N/+kqJyJp6fpCkqrj5JDOdW9Us8JjBVFRXXFpnmRroVOOELo+51PmtiJDRrAqe/Ea6CZK/v6U07KAhIZHFoblkeMgFNMouP3MXT60UpwYDRFxuNMet/uzwPnM3HK2txsULZU3y34/k/UZg0KM74MXnoeEwpFnawgfigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHzh7B2V/YOFpXJUo1OKN9qxTuttMJ6+ZqMHDW74tQE=;
 b=b1ij6WqiI/tf53oNUJCDGgECTidGqKFF7FilL7tjVKsbYyKwJGF7MlLHZOgcUFNef7GWSH/z/vTSarZ2Bq9q7nR5utNf3sOjnB2cvYDvY+sMXCgIbvPXsASyctCXEJgggM/o87UZ+u29bSfPmVVK16ZG44+CgFVuPYG9SHzcFlueMKAr8ySbWkghS1TZUv1a4L/9gJRGdBTqdqUusUcRpF98F2CkAsrV3iRe6IGxZetEn7gRhuRE+qWmjTJ82fgvLv7uaAcIPfKQBXA3SVUXJnuLzTreILb8Hlvf2h5P+6+bhrRyEABEhOWdIiIF/vN3izhkX6e3z8YojJUs6a2XOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from DM5PR18MB2150.namprd18.prod.outlook.com (2603:10b6:4:b8::35) by
 DM5PR18MB1531.namprd18.prod.outlook.com (2603:10b6:3:149::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 27 Mar 2020 01:30:01 +0000
Received: from DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::5572:55be:b57b:dea]) by DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::5572:55be:b57b:dea%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 01:30:01 +0000
From:   Lidong Zhong <lidong.zhong@suse.com>
To:     <jes@trained-monkey.org>
CC:     <linux-raid@vger.kernel.org>, Lidong Zhong <lidong.zhong@suse.com>
Subject: [PATCH] Monitor: remove autorebuild pidfile when it exits
Date:   Fri, 27 Mar 2020 09:28:54 +0800
Message-ID: <20200327012854.5654-1-lidong.zhong@suse.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0111.namprd12.prod.outlook.com
 (2603:10b6:802:21::46) To DM5PR18MB2150.namprd18.prod.outlook.com
 (2603:10b6:4:b8::35)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-rzeb.suse (39.78.17.73) by SN1PR12CA0111.namprd12.prod.outlook.com (2603:10b6:802:21::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Fri, 27 Mar 2020 01:29:59 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [39.78.17.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d988386-b4fd-464d-edb6-08d7d1ee5e14
X-MS-TrafficTypeDiagnostic: DM5PR18MB1531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR18MB15317F2E6845B8022B45550EF8CC0@DM5PR18MB1531.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(26005)(1076003)(316002)(52116002)(478600001)(186003)(81166006)(8936002)(8676002)(16526019)(66946007)(2906002)(6916009)(81156014)(66556008)(66476007)(107886003)(4326008)(8886007)(6512007)(5660300002)(6486002)(86362001)(36756003)(6666004)(6506007)(44832011)(956004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR18MB1531;H:DM5PR18MB2150.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kLLnS/L5tpuLLX4iCh74xqxeDBjE/9SIk012+NxPMKEmClx9MeS3Csv4r6o4z0BvzKo2J6bb0Oh1IemG4IP6LPH3YZklPP13b5E5585p+UGs0yA2+TkM5K/3epL8O9JVJMwdnFfQxYjL29bu26f3AaJqjvzpRYSC4JnPFTlRgmqZVLr8VX5DPAyi3b4bvSzktAnjMfzCE0zmtcX3Iv3aJyhX4YPhCWwtSyvy3ILKd4BM6YU6N5LGB9U1R4AdkFQfiMDO5EXyOBn8JsIWYyjmQVANy39yAm3laE+8uajEL86AASFuYIYJ+zXVY/bY7y3j6SIyzUzjD1GnDWpunYCIiyaCRVotNoTk5oiH3xSNuZ8FVJznztojYLt/+8UcjXThEeav2DS4Q406a8hm8rqyisVqWwadTT0Yaiznop2P6S6/IOfBD2ud1sXowXOujN0
X-MS-Exchange-AntiSpam-MessageData: 3/RspZKdW2DXQvvaz2vqiI36TP6d+rR5VUa0CObXGhBt7H9V/i671VNT+O7I0ADZoUMJkzTQT/zueOUfeSh4xXqFy598jMp17c8E+FHiDHA9oJBMWfdhMKpzRcbZfQXYk8WigXt6gP+5yef+Ua0+kQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d988386-b4fd-464d-edb6-08d7d1ee5e14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 01:30:01.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmB/tYCcnxOKGds+E3y/hzyIhIQRqdOheGhU+O75Q+2grD0UsFwLJPSKTAi0BIBnbJDBwyjknO7UDO4gqWA5aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1531
X-OriginatorOrg: suse.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

mdadm monitor is supposed to run in background and never exit. However
if it is killed by accident and the pid stored in autorebuild.pid is 
taken by some other process, it reports an error when restarting
"mdadm: Only one autorebuild process allowed in scan mode, aborting"
even though no autorebuild process exists. With the patch, this file
will be removed at the end to fix this scenario.

Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
---
Hi Jes, 

Sorry to ping you, but could you please share your opinion about this patch? TIA.
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

