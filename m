Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98C6226DFF
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 20:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgGTSKp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jul 2020 14:10:45 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:30216 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389252AbgGTSJ2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Jul 2020 14:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595268565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x2ZcAcwjDeLyUGwRgytoXG9ocEdtH8bY1zq8HQk4H+Y=;
        b=FTySJWPoq1Q4VO4jIKsL79EA121593t7PMRG2+tk3pr22JlG47/4f79Z0wm5YjVDko4JVw
        BH4Ml7hXQvsGG3LGf/eA+EyPshzJJhi3qvTEs2wwsIesPfOUSlbArFXIZ19VTMqXjNabHJ
        W+6zaS6dYkSjBEG0r5f83jn+UTZk8lA=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-22LjCGNPNted5c66Q1V1tQ-1; Mon, 20 Jul 2020 20:09:23 +0200
X-MC-Unique: 22LjCGNPNted5c66Q1V1tQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wff6tApnmYIKi2fk8EWXoLCHeZDkqK1vBiECjbafatb0RxrWR81Kfn4LhRtGw7SIhr59OaAW4tdd7UduyhJ9GConEy8JXEfPeXAeKHRyYukoNd8QBERWdHI4ouHnqUnRnGZgmBK6XxcJDqH30jBr6ri0YH8cOWW70bpMHskOHdprDhoknMgrhJlqJ9mMqxA+IakFo8cQqr0Z5RgDsyH6UhQyh0uX6gPQGEo/wtahOUJh7uHvjzM8B7rwjkvSycVp4g0wRDnn/vDMzU7ErcIT+jupboz8WRPUgnvlTrJ4zPHCuoTS8i2fqAyJhX9daUucHy+3fxRD43XrdWYlrHv/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2ZcAcwjDeLyUGwRgytoXG9ocEdtH8bY1zq8HQk4H+Y=;
 b=NXKj7cBtpbCUfVg0ioINolcldM2OusnlichDG9+eN9Fc7z8cxRpSJxMtYDLUHAxaX0b5+IlnZ+zrXqiGkk/Cr7LY58RcBWuNvoL7SF8njMU7O8vGLkaW87+drElTFPA/1S2C85RRtlKCta1X7cPpIb3WHXN2pXguTG9A6EfS6hT4USZhdg9SpmdH5osjBPY4FLD999/zL3ln1E0+e/h+rCV4noSdl+eSGGdqV/xCahVD75NN/9XmJED+0qmkdt5SwxaMv5GZhZdtt2qK1tfZ2W60GiRXJ+YnuT7f0AIsE62e0n4RHb+C4lPE292yrcPEJqEINKAqUPqn89+/IMnhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB5978.eurprd04.prod.outlook.com (2603:10a6:10:8c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Mon, 20 Jul 2020 18:09:22 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:09:22 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com, song@kernel.org
Subject: [PATCH v5 1/2] md-cluster: fix safemode_delay value when converting to clustered bitmap
Date:   Tue, 21 Jul 2020 02:08:52 +0800
Message-Id: <1595268533-7040-2-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595268533-7040-1-git-send-email-heming.zhao@suse.com>
References: <1595268533-7040-1-git-send-email-heming.zhao@suse.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 18:09:20 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5e25f0a-6beb-40c1-7c60-08d82cd80787
X-MS-TrafficTypeDiagnostic: DB7PR04MB5978:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5978F2A2820B7217669733AB977B0@DB7PR04MB5978.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2AM/6MIiKChObhxVhwe5cYpj4ZaL1iKqr2c+4pImeEaSFeI4I5agEtgAEic/SuZ+j1x0G4eWLDHWzJIrtgeJvWcmV6vcEMvA3rJ8VZxsa86t2NQPTaP6DAVrYr2+InrAiBWzaoGcwZOm6zqcsqrHGkAULNWd3lel87XIuUK6IjNabWa8OauCUZV4bVlJEzajrynyvL+YejXbmL7dDpj+o0ncm+Snf44JBDcw3df89cB8yVSFoXDYFXirbaJzafX2hFc/0+22EAyJX/TuNgIzW+6oKQaDKE1S2H/FacBXvuf3vYTudXqWHN2SXi3QTGzsH2UlTTqQhyYQGKm1avk3aZQwlLFQyO0u8KVahVgmil/2ODY+XkpSzOecC9Zcbpx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(396003)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6506007)(956004)(5660300002)(478600001)(36756003)(6512007)(2616005)(4326008)(26005)(86362001)(8936002)(52116002)(6486002)(2906002)(83380400001)(8676002)(66476007)(66946007)(66556008)(8886007)(6916009)(316002)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JW4cGYZQGoO1tQnq71nJZoSkW4MUcN6LNC3KvEZ760hjruMxOpdPLeL0B+LbPlAfldfQJ5qu1piWbloMDB6jtmABf2wwzlEFWuNNuEmWP+b6GDszh9owlXAC5olby24QooTJTl27vTEnuPcm0oXIPGheMLS+4gjLgpefAxWv1p+orrVGOdtJMR8vE5QbxoRzhKf1c2CNfRC6UTp5rBf+9o7k+6pEmxHGpGzVvNtn2q3C5dLal4SamEE+37Qb7j6GG518qF2dqFmw23zlVucVIxULynmgX0uOUK0OpoG2TsQylkT3ispnvloFxrgEC7u0v6ClyS6BVT6Lh2SN1SuVvHySiquwpqRqmEQVmMLT5I1SGGTeEw7V4aKnIxRWD630Z6pefw5KiFbHZtVfa9asLKIjG0glIIB+PPS6MNLRej6ebMQUn/TwPS1PBEfX5WgKUkTLcHgbThNkgwU6oOYp42nZbwETsLlUIQeysv6VBME=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e25f0a-6beb-40c1-7c60-08d82cd80787
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:09:22.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XOQ9ZjgfRIY3LFXcsj60Kjic8OZVJN2w6lEUgnLuu4ukyPfVzgFqhXbsY5M9SEDWJHabwoZA2U98kzxKo4JzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5978
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When array convert to clustered bitmap, the safe_mode_delay doesn't
clean and vice versa. the /sys/block/mdX/md/safe_mode_delay keep original
value after changing bitmap type. In safe_delay_store(), the code forbids
setting mddev->safemode_delay when array is clustered. So in cluster-md
env, the expected safemode_delay value should be 0.

Reproducible steps:
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

Signed-off-by: Zhao Heming <heming.zhao@suse.com>
---
 drivers/md/md.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f536b529..1bde3df3fa18 100644
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
@@ -8355,6 +8358,7 @@ EXPORT_SYMBOL(unregister_md_cluster_operations);
 
 int md_setup_cluster(struct mddev *mddev, int nodes)
 {
+	int ret;
 	if (!md_cluster_ops)
 		request_module("md-cluster");
 	spin_lock(&pers_lock);
@@ -8366,7 +8370,10 @@ int md_setup_cluster(struct mddev *mddev, int nodes)
 	}
 	spin_unlock(&pers_lock);
 
-	return md_cluster_ops->join(mddev, nodes);
+	ret = md_cluster_ops->join(mddev, nodes);
+	if (!ret)
+		mddev->safemode_delay = 0;
+	return ret;
 }
 
 void md_cluster_stop(struct mddev *mddev)
-- 
2.25.0

