Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4947E1A75FD
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436765AbgDNI0J (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 04:26:09 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:47800 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436753AbgDNI0G (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Apr 2020 04:26:06 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Tue, 14 Apr 2020 08:23:51 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 14 Apr 2020 08:20:14 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 14 Apr 2020 08:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1am1TZ4yJSaep7h+aHlg3YMmmvETDKZOwXk6eCbp9HS5niMRAgXbSyoA5pztPEkuEgI2GFdVp3tr/awsSzY37C88t2QcaBmUDJ+ymWKJc1FHQ3fn5ZgM/nHhjyJozNuEA7vJVbU9gM2XiB7e4RzYIPrNsb0PHaliIf+PawqTp0p1T7pQSHyhmHDSf6hCevFiL3f7G9xvNdJhR+2zRHh/RtRmva35gItCqBrndGM0CDlGNibhMbUQn0p43Rrmm0E5ytpuhvuXys8b7RS4jZd1Gj/9xcR/bzrVf+aC48ZJPuHKWdFmCwsbJ0r+DiDH8c0dQweb0QHXd0CfG2yjtycxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3+1l7IVZqTcEw/VpwZ22CPBtBZ0GVxUdA2di/aO2So=;
 b=iiskJNi9npI2ANof9JH46hVcGjyv9MFGA8ArOt2Wl8WRxz4zUC90QktNYFybOe148xKlvslZtR2Z2CnrjTj50mQuW5PCExjPcejpECtCVSDEyTVEli8NXgDsPgloD2GKFduEIwnT7uUcqEeFqQkoyniXXYR3Cjil5DCBE8TE+Zi0hzz68qIyFRs6i2Kzeg5bkFMlg8VK7zQ7B1SravAJAf98gB/bu0g+pd2v3Dw1zn3/8heGy33lG+JHutPRUE60gNSgBTpcT3GXh+N4GK2v4PkPmsaCYfyYUcsTXa6MgzfVwdx0jjBo1TJUmtGNwKoexz2v6yB3zz1OIrlpI50N8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from DM5PR18MB2150.namprd18.prod.outlook.com (2603:10b6:4:b8::35) by
 DM5PR18MB1354.namprd18.prod.outlook.com (2603:10b6:3:14b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Tue, 14 Apr 2020 08:20:13 +0000
Received: from DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::4de6:2be:d5a:60b0]) by DM5PR18MB2150.namprd18.prod.outlook.com
 ([fe80::4de6:2be:d5a:60b0%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 08:20:13 +0000
From:   Lidong Zhong <lidong.zhong@suse.com>
To:     <jes@trained-monkey.org>, <linux-raid@vger.kernel.org>
CC:     <guoqing.jiang@cloud.ionos.com>,
        Lidong Zhong <lidong.zhong@suse.com>
Subject: [PATCH] Detail: adding sync status for cluster device
Date:   Tue, 14 Apr 2020 16:19:41 +0800
Message-ID: <20200414081941.6577-1-lidong.zhong@suse.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0443.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::23) To DM5PR18MB2150.namprd18.prod.outlook.com
 (2603:10b6:4:b8::35)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-rzeb.suse (39.78.17.73) by LO2P265CA0443.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 08:20:11 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [39.78.17.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5b83d1a-d2de-4c1c-9a6d-08d7e04ca798
X-MS-TrafficTypeDiagnostic: DM5PR18MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR18MB1354209D252E913B4FEFA1CDF8DA0@DM5PR18MB1354.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB2150.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(2906002)(316002)(6506007)(8676002)(36756003)(8936002)(52116002)(81156014)(26005)(186003)(16526019)(86362001)(2616005)(956004)(44832011)(478600001)(66476007)(66556008)(6512007)(66946007)(4326008)(1076003)(6666004)(8886007)(5660300002)(6486002)(107886003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eFtgWj4lyYGkTPYo17Jdg3bIljN1heZgDhhusIU5tJhGNFZlAYBJko0DkWl8pMuamW4THLA49ZjnmwX1s/ZDEmYaqbr+CFpivliTCSsNNNZviPlh9RBVEwcMGX3i+GiOdDCG8270b1WVwwEdV8MD9mflrQHXmMIUP5+mjY14mX243smNCc74CrJg/suoUP/IBnJFGqUvcVGi2dPBkI7oBNl6O9ccmIQQClB3B5XiQY8UkNg7vT+Oi69oc+REPVbuoaMg1hn0GKZ3kIQM/TU59oIXQ5B8NhWeT2TGSA0h+zw3XOF6bw06Qzs/gydtRtDbq2xfNKogFx8FbYJ7a82cOadDO0DhSXtyyuaSp+JWcERr1cW0ZPqyTyM5ZBT4Og+3dkjni7J6AxddPO+74uGAIvSgHerzt5U1rU6CHZ76SL7qpK4tcLqWJ8mOVBj5lSU
X-MS-Exchange-AntiSpam-MessageData: U75ZRWlFNy3CyP7Uf57rtWAA4+yC+W+a3ZbWUohMINpwhqQ0iwu3WYVCWL+MMRNABJtaSmfbwjiv5lsLgswggsCGwKpPVKltAitbO0VhJLHZWFg2a4GLueeDVrni4nrB23DDke/lAKYGfwoON2i4Ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b83d1a-d2de-4c1c-9a6d-08d7e04ca798
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 08:20:13.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPONKefQKUXp2XB5avkbtmPaLLICbffm5uFjccOltJKpltxPSPRVqkL5/0CksZCTg/GehM6H/MeqAiChTBGuMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1354
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

Let's change the 'State' of 'mdadm -Q -D' accordingly
State : clean, degraded
With this patch, it will be
State : clean, degraded, recovering (REMOTE)

Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
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

