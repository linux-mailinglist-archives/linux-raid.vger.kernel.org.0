Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E78225188
	for <lists+linux-raid@lfdr.de>; Sun, 19 Jul 2020 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgGSLJL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Jul 2020 07:09:11 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:28876 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbgGSLJK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 19 Jul 2020 07:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595156946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAw6PGDdcXaJPdp3SX/34G4xBt2oT/24ih6XD+m1bq4=;
        b=Qvf9Qor4LKTfnU2MTPM/a1zmyYC6YEZNBlWC1XLMU/PKWqA5kon5xyTFLxG4+58j9Nmr2P
        XNV1gMJOaFCeBAfLpHdiqNWcAR30bl5+u3Do8I6y9diLVYpO4l1nXBsFVxqK3BnlytwcTP
        wRigpKp1Slpa5giBAL+JPAhe6TY3jy0=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-jvPdzBWFMGWyTaJaUZYjGA-1;
 Sun, 19 Jul 2020 13:09:05 +0200
X-MC-Unique: jvPdzBWFMGWyTaJaUZYjGA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm2BrhhEEdVX1FnVw/1yqUgcNBBnLqZ35isgMVRiFbO0PiClmYLqk8JvvVSkHShIzYBRjKPLASiAQjDiyS2in6I8MlGYtk3qPlVveQ0HZFY6ld8OLLRt8p6XJUVZGqDiNbjHrK4VukKQ8gjawihKRBanYtd7CtHFeHd3psiZg7Va6QNbIWrtR4LX76zoyEtqbrSr2pztCajYk4c7x2WJze60IF8QdqqzVVVXcKRmccrVFCAhiMuoHjDH8eoi5tV/NPgyxCrGfYv+cYjbwArwRSmzj9ahf0X7NNoqQ8lMM8G9qaCkIPkGK6M2FejedbxQ5I4rrBBua+3TeRQkk01WXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAw6PGDdcXaJPdp3SX/34G4xBt2oT/24ih6XD+m1bq4=;
 b=jeAPNjU1uvn0sLLSL8qHKdxkX+PRNb6ykDOcJ0RdkozH//smmphKwlFmTM6bwx/ZlEyVguRDXpeERuAOKk2SjqzcIHButckzNP8KOfQuDhNEi8GCZnJFeww9Uc4XLQ0qVIMCE5tGoOXZiq1uCDjtQ8hJUZo/KoGXimMzvA9bF/LEtxSiUsBUAmBussDXPJocMvrZsVH0oXyNNGzyb4XzErE3ZMpl8PK12kS3sWdkotFWGG+3iPOD7Uh5eQIChx6j3+cgp2qRqnl8RdPFqUiRHupUwyfpVduDHO4Q+vqHI0tQISdRIMxSvurNDvKAmegXErlYYSXfRsm8+n8W4HTM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB8PR04MB5817.eurprd04.prod.outlook.com (2603:10a6:10:a3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Sun, 19 Jul 2020 11:09:05 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.023; Sun, 19 Jul 2020
 11:09:05 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com,
        jes@trained-monkey.org
Subject: [PATCH v4 1/2] md-cluster: fix safemode_delay value when converting to clustered bitmap
Date:   Sun, 19 Jul 2020 19:08:39 +0800
Message-Id: <1595156920-31427-2-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595156920-31427-1-git-send-email-heming.zhao@suse.com>
References: <1595156920-31427-1-git-send-email-heming.zhao@suse.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0188.apcprd02.prod.outlook.com
 (2603:1096:201:21::24) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR02CA0188.apcprd02.prod.outlook.com (2603:1096:201:21::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Sun, 19 Jul 2020 11:09:03 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d83202ee-aecf-4fdf-3e76-08d82bd42657
X-MS-TrafficTypeDiagnostic: DB8PR04MB5817:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB581764BE58DFF7A068C9F58C977A0@DB8PR04MB5817.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvOhVVWMTtNxrmQ+GF8+qrmhoGJH43YF6duTX46TC0pGr1W/TA5ZEGPCsiEQlDdQ8adDGwhvgkTQHRiIsv3I/GcTtuqXZJgxaaGwr+kkFY9d6NnWoB0rpmxBf6wvRweG8S7eRt5FGB9dtv0H4WeEaRgDOdEH3qgFTeW5b6TCd7XPgubW6lvmT7p3BpBV3Spw7zE9MdJbDvqPKaonTIsVHtbZ+Zo/59oKnu9WG/lmoEqJ1/4eri1MFb7/PDaW5xTkOwADS4+em59lBsEdqYLxMqBZHUbpkd7aL6pTT5BFnb0AtMdfSAxnE8ao0oc+9hTYEtSHCjZsbVTzRTmN+jKl4EHS+wdlFe2nWcnaaklLfapyUKkB8DkoCeswjJOg1gWI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(6486002)(26005)(8936002)(6916009)(478600001)(36756003)(2906002)(66946007)(66476007)(66556008)(6512007)(86362001)(6506007)(5660300002)(6666004)(186003)(83380400001)(52116002)(8886007)(316002)(2616005)(956004)(8676002)(4326008)(16526019)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VkQETmOh2zmCk/i2ax69wK+4xwin691yVqK4xToutcH2V6yQIwkKNH2aoG2pRFMTX1OGPjRENfw90ciMfigNZHk1+vx3DW3QLlyc+/YTqEl41rkeymteHbXiC6DdhIwrb8SCvNb9ndw1lRLAS3Ebpuxd2o3aOWnP8H+M8F+kxLeFGsRar6ndlytqHyI1+Xj1Oz/J4uy+FcACzDQ38KSI84qzRbJt7LG9183MCtv+ORyG1YRt5OmlboHF6kpPziuAaZQOdt9xp0LQd/69f5f6dJB00eDocCMNZAAsYu7RYRkPVSkYr/5usBUY5zoi+u/Y1x1KSNKfQyNEfSjtktMjM75zDfHE6acbCwqdmppWF7zNtnOsA1fwVz+8in2LBO28iuj4ujvPsiq1unnarRlti+JTV0T9adLqukyMpsV4NCHMmlPddS4ZsSDJy32l9CTqaAggqxVCrhks+t/Zcy56kWAmMWapE1f+aH76ahUYw2A=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83202ee-aecf-4fdf-3e76-08d82bd42657
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 11:09:05.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEeoXWVVK7g50+tK1jEjq4xIT0qMVnBliIsU1wApwkWR0NJxV+t8kGrUccClJinhd+P40Lx1h29BS4Z9pFHWQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5817
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When array convert to clustered bitmap, the safe_mode_delay doesn't clean and vice versa.
the /sys/block/mdX/md/safe_mode_delay keep original value after changing bitmap type.
in safe_delay_store(), the code forbids setting mddev->safemode_delay when array is clustered.
So in cluster-md env, the expected safemode_delay value should be 0.

reproduction steps:
```
node1 # mdadm --zero-superblock /dev/sd{b,c,d}
node1 # mdadm -C /dev/md0 -b internal -e 1.2 -n 2 -l mirror /dev/sdb /dev/sdc
node1 # cat /sys/block/md0/md/safe_mode_delay
0.204
node1 # mdadm -G /dev/md0 -b none
node1 # mdadm --grow /dev/md0 --bitmap=clustered
node1 # cat /sys/block/md0/md/safe_mode_delay
0.204  <== doesn't change, should ZERO for cluster-md

node1 # mdadm --zero-superblock /dev/sd{b,c,d}
node1 # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sdb /dev/sdc
node1 # cat /sys/block/md0/md/safe_mode_delay
0.000
node1 # mdadm -G /dev/md0 -b none
node1 # cat /sys/block/md0/md/safe_mode_delay
0.000  <== doesn't change, should default value
```

md_setup_cluster() is a good place for setting, but md_cluster_stop is 
good for clean job when md_setup_cluster return err.

see below flow:
(user space)
mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda /dev/sdb
mdadm --grow /dev/md0 -b none
(kernel space)
SET_ARRAY_INFO
 update_array_info
  + mddev->bitmap_info.nodes = 0;
  + md_cluster_ops->leave(mddev)
  + md_bitmap_destroy
     md_bitmap_free //won't trigger md_cluster_stop() because above set 0.

Signed-off-by: Zhao Heming <heming.zhao@suse.com>
---
 drivers/md/md.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f536b529..e20f1d5a5261 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -101,6 +101,8 @@ static void mddev_detach(struct mddev *mddev);
  * count by 2 for every hour elapsed between read errors.
  */
 #define MD_DEFAULT_MAX_CORRECTED_READ_ERRORS 20
+/* Default safemode delay: 200 msec */
+#define DEFAULT_SAFEMODE_DELAY ((200 * HZ)/1000 +1)
 /*
  * Current RAID-1,4,5 parallel reconstruction 'guaranteed speed limit'
  * is 1000 KB/sec, so the extra system load does not show up that much.
@@ -5982,7 +5984,7 @@ int md_run(struct mddev *mddev)
 	if (mddev_is_clustered(mddev))
 		mddev->safemode_delay = 0;
 	else
-		mddev->safemode_delay = (200 * HZ)/1000 +1; /* 200 msec delay */
+		mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
 	mddev->in_sync = 1;
 	smp_wmb();
 	spin_lock(&mddev->lock);
@@ -7361,6 +7363,7 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 
 				mddev->bitmap_info.nodes = 0;
 				md_cluster_ops->leave(mddev);
+				mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
 			}
 			mddev_suspend(mddev);
 			md_bitmap_destroy(mddev);
@@ -8366,6 +8369,7 @@ int md_setup_cluster(struct mddev *mddev, int nodes)
 	}
 	spin_unlock(&pers_lock);
 
+	mddev->safemode_delay = 0;
 	return md_cluster_ops->join(mddev, nodes);
 }
 
@@ -8375,6 +8379,7 @@ void md_cluster_stop(struct mddev *mddev)
 		return;
 	md_cluster_ops->leave(mddev);
 	module_put(md_cluster_mod);
+	mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
 }
 
 static int is_mddev_idle(struct mddev *mddev, int init)
-- 
2.25.0

