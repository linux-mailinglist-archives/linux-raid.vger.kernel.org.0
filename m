Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61451BA9EC
	for <lists+linux-raid@lfdr.de>; Mon, 27 Apr 2020 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgD0QRH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Apr 2020 12:17:07 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:35590 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728156AbgD0QRH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 Apr 2020 12:17:07 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.146) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Mon, 27 Apr 2020 16:14:54 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 27 Apr 2020 16:15:24 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 27 Apr 2020 16:15:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSHBPAOvizxVEDiU8JZ3P1VYNbS5VAL5mFLEYckrMcHjQ4YhuzMNTO2QLyRCepmwRLxcsMo0y/qk8YjdNcsgACDF0YIdh7mwW+1qU4BcCsgNDe8E4bLw4l3hSXuIJWy8gh5eQPoGhkl9tJLG8PeH0yNEfeQ2beL89vhdfY0G0rWmMJ2hBGi5BDxj+1j6lhOKrKt0U/nawsj1tzB6jwBBhIQSzeb+2s/sDHCwRTIAL9IslS6X6XkzVza3ivED7DwQTGoM2alQgVpo0Qyv0WsUcrrU5XoLDPt/BekjQyrhmfUu7yAdE0k1ZkWCLXWDkyzMT6fZSS3WzJTSv4h4dA42aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3+1l7IVZqTcEw/VpwZ22CPBtBZ0GVxUdA2di/aO2So=;
 b=IZNyek0gxuctGkPmwcOG3bUvnL77RqpkvUYPRATGrc4NGIr4X3DupabUlH2094tP0rJOnyr2tyI7JWQPGjeyCwSO1cMDIwnQrso1GM5g6f9GROAIUyWXA1NpqXCKvnU+qmcAsHgbJnj3fNJPixRzXyyXTsbueSDUqyjuBW8/yyJuBpHZ446Rwcwy1eKktIrvm2q31sXUSlcJq8gWag36nNzMNEwfon+jW4Q8huuU4gWRvZfERIrH5D44zXO7m/3DrRDjziV66a975wfKLQ6zZVOfWA83fwoRxdri5Wpri9T8203L6/WxLv20N+e6pL5/Gx2o0FGc7ohpk1LUnTztOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lidong.zhong@suse.com; 
Received: from BN6PR1801MB1985.namprd18.prod.outlook.com
 (2603:10b6:405:66::32) by BN6PR1801MB1859.namprd18.prod.outlook.com
 (2603:10b6:405:66::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 16:15:23 +0000
Received: from BN6PR1801MB1985.namprd18.prod.outlook.com
 ([fe80::a471:16c0:7214:f206]) by BN6PR1801MB1985.namprd18.prod.outlook.com
 ([fe80::a471:16c0:7214:f206%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 16:15:23 +0000
From:   Lidong Zhong <lidong.zhong@suse.com>
To:     <linux-raid@vger.kernel.org>, <jes@trained-monkey.org>
CC:     <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2] Detail: adding sync status for cluster device
Date:   Tue, 28 Apr 2020 00:14:38 +0800
Message-ID: <20200427161438.20296-1-lidong.zhong@suse.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0107.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::23) To BN6PR1801MB1985.namprd18.prod.outlook.com
 (2603:10b6:405:66::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-rzeb.suse (39.91.1.129) by LO2P265CA0107.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend Transport; Mon, 27 Apr 2020 16:15:21 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [39.91.1.129]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b9e8549-a6b2-49db-710b-08d7eac6302d
X-MS-TrafficTypeDiagnostic: BN6PR1801MB1859:
X-Microsoft-Antispam-PRVS: <BN6PR1801MB1859540FE942D9E236CF22DBF8AF0@BN6PR1801MB1859.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1801MB1985.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(81156014)(956004)(8676002)(6666004)(8936002)(52116002)(2616005)(66556008)(66946007)(8886007)(4326008)(66476007)(478600001)(5660300002)(86362001)(6506007)(186003)(6512007)(44832011)(36756003)(16526019)(26005)(1076003)(2906002)(6486002)(316002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXtPAVfqDK212Wb9v0FMLT9vk0KppGwFcWrJRy+Yj7cqde7qYie+9jYP+6VcoxdscXuMB+1XDC/zzizOwIomOBz9XfvgMb/NWAM9oCCMrVyrLxS/2EXC2LHbUj9BybrAlGiMEypcz/b7jpR9rbrgaGv4LT5czMvzaH3Y2vA7OMGxyX3q/gWZVjRZ3+rBQz4okid1pahTceq0T4b8FHyyTaxcbD+ls4Vv7w+id0ySa/k5oZSYOoyjzpxz975Q0o60WXrQ8slFcUjQ/NBrI5/95vVJwukeTR/se0TKNRjClO7v6fB/nOQB9e4Dtnac3iYZe2WwjQpDfP8iZO1kYD3uJqFHIzGRF5EiMu61Tn5Ni0j3yXGpJvaAuqq2UcnUCjvKvRLLKALBcCaRVNWoT/KQgN65C6LqeFfr9Uul5S6pEgHKQkWrhxPqTkftkgxGNu3I
X-MS-Exchange-AntiSpam-MessageData: kBupAt/qDCpW7BYLmO60rXOJFq+gau4GXi+ZgrKaZObAp9NGjzd9C4SYm0t8TidNx1NdWtSgt2Rq9uzD1krYRrC8IZY1hi7BLDJcUsWRqL7G1Ls3EpFbTX6y+xxKdKEzWZInHsxeCDrcaOSMl/CJXLkMCzKBr9JmfJCOM0d/zmVek/6Vasta3CQs3b2otY/NqFlspHGFAko/uXMEv4LA9mbBzQd0RnZSvZ/he6kBae7o2M6i01OQAm8FASIyXqQtCUNaBM/iS7K8uBUFmoep+THlWFd7pn/HPUuU1piBuLcTPQ4JSJAqUR184MJZNs6ekFCWhEPaB3La+ClhYTVAZjmrYwpIH3N5nDskgaZwC6CIG8S4hj0E6sb9h27TK2wyn/PWlzWwBIXqz/65++UsNqYw1tM8QXko66KytaP1+aPmqz3YZhCEJPU9bpKErWpJ8cU+4x1tDqaLc8tSxZJmahU8MFBZMHFN35CfIqGjAtFjC3VpamDy/Xqsa8/FT61tMbOf8iO7qqqzrSxakEpenIh3DSHHl0r/2S+L3bIAzRBOVCpb/TTNzvb1myNAKhc1k4acpBJrItaGM8d4DmsbSctuGVJQH2WoO/mGtcZM0NJnNJYN0FRmUVTvR7+bydBFtf2YVg8rt3h336djlGj1yCnlb0QP+/w4Kp9BAC7qUSKoQXs1orYySMSRMQz3GmbZ04Dgu6FSU4LkWnwQ+2asuDGkTIR/wdmJoFQWeyccTevzSk9AkoGPbBLrkGlz9jy7RS+yTf/GBs+1xH+zQ8ktmFsYGPkFVU/Adq1MuSaF+x8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9e8549-a6b2-49db-710b-08d7eac6302d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 16:15:23.1721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qfClfP8dFDIfvDHKPgsf4WXko0NZYZxgoDVPIG0F7Xg+3KehxGwExADeu69X61qiWQ/eBZAgjk//oS/mI9Z1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1801MB1859
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

