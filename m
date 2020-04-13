Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747861A6845
	for <lists+linux-raid@lfdr.de>; Mon, 13 Apr 2020 16:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgDMOnG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Apr 2020 10:43:06 -0400
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:60709 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728557AbgDMOnF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 13 Apr 2020 10:43:05 -0400
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Mon, 13 Apr 2020 14:41:29 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 13 Apr 2020 14:42:03 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 13 Apr 2020 14:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVqEjyUpt7ejak2grTbtq311HoALlNQFfS3iTRSZaKvT/fu/H33aKE5AvIiIyadJ+bWzJMbpdyN8qI3BgxudwYH0seo8NqrTag6jvsqctxylPr0mqq4+PLXCWyKqNOC6DL69rLa0CZRpN7YJcFrkyIfQgUG+YD7U6TJwA50ZvuPJN9EGzZGWA0CKF7u2rqa6Jp7iGI94UScIXBW8m/EcmCT/NlHgENcZy2ngcbShdVIpkbCm9lnfB7Nf8+NIOKx9LgYLh6Uy2WiFgv2yRPCsnN13P44zyrlN7oB1xlSh4lA48VvQxeRG9g37QESXLD38gNSnOASG2HW4sxPJGqcHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl7NDqgJJiftuCt8MeMT/gcnBGMo6BpQkyTjRCpsPmc=;
 b=f2gJ90T7cxUvvz39J3La7tmiwm2HTdp3LMnxgN8Cvj9TEjNrBt81Ce99SA70ANoyBm/uGUBhJNkBTA9Xc5CibunQcBAf39MHG0Fj/zZtAbRiiGRjjpu1b0amcuVJYDFgp4ozI7DRV3HaiY3mxS4HwRD2Yq194/HGNLcEFZZG/e/jzPJMaIFpp00UpfAB0GRZ6s+1od8fys52zRKaU1kR/0A5I8pLedLuA/9M8A4yAeY6AC3vyp3S3KppHS+sJmeDRTvfU15vnj4AMOqVCWO85SwKnOipPVoL2c0RH63MPV/LnMxiaH+ZYrTB1L12Vle9RF/51N+tuEAXZBMXWAaE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from MW2PR18MB2154.namprd18.prod.outlook.com (2603:10b6:907:2::31)
 by MW2PR18MB2171.namprd18.prod.outlook.com (2603:10b6:907:7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 13 Apr
 2020 14:42:02 +0000
Received: from MW2PR18MB2154.namprd18.prod.outlook.com
 ([fe80::5136:34cf:5e74:ed13]) by MW2PR18MB2154.namprd18.prod.outlook.com
 ([fe80::5136:34cf:5e74:ed13%3]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 14:42:02 +0000
From:   Lidong Zhong <lidong.zhong@suse.com>
To:     <jes@trained-monkey.org>, <linux-raid@vger.kernel.org>
CC:     <guoqing.jiang@cloud.ionos.com>,
        Lidong Zhong <lidong.zhong@suse.com>
Subject: [PATCH] Detail: adding sync status for cluster device
Date:   Mon, 13 Apr 2020 22:41:28 +0800
Message-ID: <20200413144128.26177-1-lidong.zhong@suse.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To MW2PR18MB2154.namprd18.prod.outlook.com
 (2603:10b6:907:2::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-rzeb.suse (39.78.17.73) by HK0PR03CA0099.apcprd03.prod.outlook.com (2603:1096:203:b0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 14:42:00 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [39.78.17.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1547c73a-044b-4896-1223-08d7dfb8d3ef
X-MS-TrafficTypeDiagnostic: MW2PR18MB2171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR18MB2171E533EC347D00BB32ABC5F8DD0@MW2PR18MB2171.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR18MB2154.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(4326008)(8936002)(6512007)(5660300002)(2906002)(6666004)(6486002)(316002)(107886003)(186003)(66946007)(16526019)(66476007)(66556008)(86362001)(26005)(956004)(478600001)(2616005)(44832011)(8676002)(8886007)(81156014)(1076003)(52116002)(6506007)(36756003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+uz+HM8s0/jubi8wsJKUevwrB9kPP8vEJp4llJHpSc2cX+NZX8LhJX3YDuak8sWQyGIRdTam9COcpyD9dWDXMDZ8UPWavNASML5czDPWTMnitrA/7QY0yh6NspheaiQirrUHjtBF3d/6gmPirETa9paoKiC8IPN/zQcv4hho7u69KdC4XEkHpqOHYW18nKs71t0pkrl/JS1RYqCs0Fqg7LYrmUmLSFBu23O91rVgeb1y3bv+IZu/gXneM6f0pMAZ8r86lBzkEZIIq/bC47IvwOw49nvPhvzyNIlQ1ouWp5dbHX+6uZv3zvHTGCtbBNcrEwAtBTXy1ta2W/KzTfNXB+KwsCnWLebZgBXIsDsatlqW536P1Itf+V84+fBu8bAtaaK7XI2tsNlw6+oHUSAKpvsjpVUVUqO0Mwt4wg/Tmfbg140zgV0s4cOnFbzZtbd
X-MS-Exchange-AntiSpam-MessageData: uAwPAe4N7bhOXxM51GapZOe3qRj4XbAR9WZzo3xZ5Y53LQShm8KFEYP/nnNIpMhTVJfDptMFoXh273I4bSyuCHshOIWDupb7qbljWpDHxi6e8+knTrgxOVHOdshCGbN+F7LyD7I3Km1aHbtFtN5K7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1547c73a-044b-4896-1223-08d7dfb8d3ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 14:42:02.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vM52rbgsWmkpRHHKqGEa2GKi1IygvfH9CBSv1a2IsbPpKNpB3WpfTrOdkIZ55a92Jj8l79MTMIYMdmLbiksCDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR18MB2171
X-OriginatorOrg: suse.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On the node with /proc/mdstat is

Personalities : [raid1]
md0 : active raid1 sdb[4] sdc[3] sdd[2]
      1046528 blocks super 1.2 [3/2] [UU_]
        recover=REMOTE
      bitmap: 1/1 pages [4KB], 65536KB chunk

the 'State' of 'mdadm -Q -D' is accordingly
State : clean, degraded
With this patch, it will be
State : clean, degraded, recovering (REMOTE)

Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
---
 Detail.c | 9 ++++++---
 mdadm.h  | 3 ++-
 mdstat.c | 2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Detail.c b/Detail.c
index 832485f..03d5e04 100644
--- a/Detail.c
+++ b/Detail.c
@@ -496,17 +496,20 @@ int Detail(char *dev, struct context *c)
 			} else
 				arrayst = "active";
 
-			printf("             State : %s%s%s%s%s%s \n",
+			printf("             State : %s%s%s%s%s%s%s \n",
 			       arrayst, st,
 			       (!e || (e->percent < 0 &&
 				       e->percent != RESYNC_PENDING &&
-				       e->percent != RESYNC_DELAYED)) ?
+				       e->percent != RESYNC_DELAYED &&
+				       e->percent != RESYNC_REMOTE)) ?
 			       "" : sync_action[e->resync],
 			       larray_size ? "": ", Not Started",
 			       (e && e->percent == RESYNC_DELAYED) ?
 			       " (DELAYED)": "",
 			       (e && e->percent == RESYNC_PENDING) ?
-			       " (PENDING)": "");
+			       " (PENDING)": "",
+			       (e && e->percent == RESYNC_REMOTE) ?
+			       " (REMOTE)": "");
 		} else if (inactive && !is_container) {
 			printf("             State : inactive\n");
 		}
diff --git a/mdadm.h b/mdadm.h
index d94569f..399478b 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -1815,7 +1815,8 @@ enum r0layout {
 #define RESYNC_NONE -1
 #define RESYNC_DELAYED -2
 #define RESYNC_PENDING -3
-#define RESYNC_UNKNOWN -4
+#define RESYNC_REMOTE  -4
+#define RESYNC_UNKNOWN -5
 
 /* When using "GET_DISK_INFO" it isn't certain how high
  * we need to check.  So we impose an absolute limit of
diff --git a/mdstat.c b/mdstat.c
index 7e600d0..20577a3 100644
--- a/mdstat.c
+++ b/mdstat.c
@@ -257,6 +257,8 @@ struct mdstat_ent *mdstat_read(int hold, int start)
 					ent->percent = RESYNC_DELAYED;
 				if (l > 8 && strcmp(w+l-8, "=PENDING") == 0)
 					ent->percent = RESYNC_PENDING;
+				if (l > 7 && strcmp(w+l-7, "=REMOTE") == 0)
+					ent->percent = RESYNC_REMOTE;
 			} else if (ent->percent == RESYNC_NONE &&
 				   w[0] >= '0' &&
 				   w[0] <= '9' &&
-- 
2.16.4

