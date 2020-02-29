Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 071F51743CC
	for <lists+linux-raid@lfdr.de>; Sat, 29 Feb 2020 01:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgB2A3m (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 28 Feb 2020 19:29:42 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:48181 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgB2A3m (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 28 Feb 2020 19:29:42 -0500
X-Greylist: delayed 1040 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 19:29:42 EST
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP
 FOR linux-raid@vger.kernel.org;
 Sat, 29 Feb 2020 00:29:00 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 29 Feb 2020 00:12:17 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Sat, 29 Feb 2020 00:12:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOiwoz8HG8/frB0YqU1Fv6szUAnsDTNgP/YXHO+MgORW+jSPZCvky8C8DNrmH5zR+gnsvHtcV/ocp+Ik730/9Pw8V4iCvdLNSmGFlY30PMqth3gP6QvekpbwQRU5Bw1OQIGOubhdyxXCEzbpM7zOZh2XG7hnpUB7Cg50SP7RVXQJJB9Gsfiaqdrn9+f0Fb5it7Z116YyjLgxs8I2jmlGt7Zby2MPhwINkymEmW4V6XJK/U2I+niB+ayEKWn2uBwCbW8KPQBqq1kjMJaYNFrXDlffVmF2BluQDQcqieBgGfRcOh93fCzdpi64BlQ+JPyr67lErb22bIxf38pjNi1jMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcECxH3V6MBQszxrWMfsTq//qRyNZpe0tpPIYArsL/8=;
 b=KGa6e020QroYbPfgQ9xLhIdJOYHFRUSrmN6wkp9IL2J/r/+79YdvXwnSU1/JOhkyI8LKPgW50cnZ+RCeqK8bxDsbWBCTUJqvkL+DyFN0Sk+8ChOrh5LjWhE+0djTkK7fZy8BNx9c0drgizkTifVCKpREroOunl6sGTr006KTSxP/P/dXNFxWTPlj2P19nPyMm5Ok+J6n7QtwLTsg/URv9cupXdEsB36E8nUqcOA6+O8xA1VQ+Ipvdi4gzaIz49P05jlSB3UwNKveO75y2nxPjIe9rvOYkZMnS/twZkTOPuKbJsSc80A1bldcNbLqZRNYXFMg8NT29C9zzs9i405ksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from DM5PR18MB2150.namprd18.prod.outlook.com (2603:10b6:4:b8::35) by
 DM5PR18MB1354.namprd18.prod.outlook.com (2603:10b6:3:14b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Sat, 29 Feb 2020 00:12:15 +0000
Received: from DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::5572:55be:b57b:dea]) by DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::5572:55be:b57b:dea%7]) with mapi id 15.20.2750.021; Sat, 29 Feb 2020
 00:12:15 +0000
From:   Lidong Zhong <lidong.zhong@suse.com>
To:     <linux-raid@vger.kernel.org>
Subject: [PATCH] Monitor: remove autorebuild pidfile when it exits
Date:   Sat, 29 Feb 2020 08:11:42 +0800
Message-ID: <20200229001142.26957-1-lidong.zhong@suse.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: DM5PR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:3:ed::15) To DM5PR18MB2150.namprd18.prod.outlook.com
 (2603:10b6:4:b8::35)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-rzeb.suse (112.232.245.190) by DM5PR21CA0029.namprd21.prod.outlook.com (2603:10b6:3:ed::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.2 via Frontend Transport; Sat, 29 Feb 2020 00:12:13 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [112.232.245.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b78bc3d-30a7-4125-3d4d-08d7bcac07a4
X-MS-TrafficTypeDiagnostic: DM5PR18MB1354:
X-Microsoft-Antispam-PRVS: <DM5PR18MB1354B0DAC10888EFF2992983F8E90@DM5PR18MB1354.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03283976A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(316002)(6512007)(5660300002)(1076003)(478600001)(6916009)(6506007)(8936002)(6666004)(36756003)(26005)(52116002)(8886007)(66946007)(44832011)(66556008)(66476007)(16526019)(186003)(2906002)(956004)(8676002)(2616005)(81156014)(81166006)(86362001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR18MB1354;H:DM5PR18MB2150.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9EYKzLB1udt+x7zIFnNSqvDYzqgk0l/YkkfWzBlJjcoJP5+dDZnozBZFKuGjXj7yN+k9nSE09/qyYjx64guFQlGnohYh1m9fFV3OZcYvqidRS9M1l38Y/le3bmVLY87PjOcLMZcmj8VgniAfzbSMrcjeCP9vZufbJEteCwbv0toWxnk7MhD7XHUCa3gpKY3D2V4TrBvJeUyScnoKjcaR89EDu9hPnSL9Tn7/TwrcV3WshZJtLVTwjoA8QAx7N0gb2+Wx/jAxLuoDn/SZwHlN1GLzk3k1VsiLPNyJ/+2Og/vtZ4P5s/VY1eiHDCLNLIhn1lJnyWsXte49zGc3JJgnPDOttQifo4HtyspuHo4ITZFHF8WxfJakSmLPfe2c1FeVABHd4g0/6D9VJ7OVGz5hRGOlLZe09As9oIqDt+4BHgNgDJfKh8tQlcxWMfpGKVb
X-MS-Exchange-AntiSpam-MessageData: Izf5oKAvdUgmumIRWAAbmuGMQIErg3lRxffLx9R33em1NmJcMANAuynF6PAqS6NkFrs9jb2ltsKIETW/VlOFC6vOcBj4jZjSIA/W8b89kQsiUsrx/pBhiKWZSodnptlpO6Hc1MfFW5rjIG9REo9+VA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b78bc3d-30a7-4125-3d4d-08d7bcac07a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2020 00:12:15.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FLsDgclmWeVYJsae1PJzrjePa4KpDOXKOXPOw97J1F84wsWON2anrldOW1k4j7PUlE50Ury5rxkdl4c27mm1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1354
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

