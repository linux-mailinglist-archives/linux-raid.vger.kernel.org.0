Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F83223726
	for <lists+linux-raid@lfdr.de>; Fri, 17 Jul 2020 10:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgGQIgD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Jul 2020 04:36:03 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:36935 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbgGQIgC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 Jul 2020 04:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594974960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pMueL2RoQUujAgQKjKbu8r+qjfpifGW5Uf9bkE7iz3I=;
        b=aEODy57apIg0bGhCD9YlpqDH4/FEm3y3sg15QtGshwNhC1vLnleC3i/cwqaVEw2lvexnkF
        PxnYx4F/3r3eaQPTjV1Z+yATb8gvhAbZ4yKVLMgHxouIwK5kbsGMeGk1dGoQU6xtHuWHcj
        o3+KSmfU+xPl51bAaJojZll1Kbf4Ows=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2058.outbound.protection.outlook.com [104.47.1.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-FuHh3MJ4OmaVPf8-ftZvww-1; Fri, 17 Jul 2020 10:34:36 +0200
X-MC-Unique: FuHh3MJ4OmaVPf8-ftZvww-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfKN9iLvBhopmbiWsEYrb3Q6qry73mknYedVqZntgvWaYXyYk2GQ4pFB7PkP/SRhqd5E6p1UszXcM5Oq1XKLXI3mMhtVsE6ea9by61oPIyTlrLqmZNNe19rbF6BdD3BT8x6lvm9x2VxxP6/dnLH4TZhYEwS5Y8jGyaWMe/CFleKAzkD0JusJm1psCogjs9R0mv94IT3tFU75L9zESz1wA16RgYWFZOB13srlDDcvaZjquXTtnN/JCK8TOA/lcNUm0HMMBpr9vRQVm3TGcbHaIKIgcsssTPSbMXI1vJoiNCanJQLPmOiD9cuMtlERH95RAKZnZylem1DQYjjnp8PYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMueL2RoQUujAgQKjKbu8r+qjfpifGW5Uf9bkE7iz3I=;
 b=U5B6HB73xmJfWuJh8+gh8hDSqKJ89VT6RlEbvcjncwWaaDBvxxm0CYFqYoozhvk4ajqZnwVRvtoi5VjzCtownoN9z0uqeH4VXSPmJeFg8qFVvCRgD0fTBHM94JtqIUyJnCL0oDoaMHRBCoLukyXxE04AOxWTAjSw2fppnhhTPE9HHWKuowRmsyRe03OFfoFyt60AsVz0Qy5kPsrXPOIr4SsxNGVjK4cEDDfWZdA0mdppx9gXCSDBObXsCrQME1u2eArCxxLu7wvLLOP+6AftG9M1wMkT/dgs92UZIZ/AbQBNevpNx6i+X8q5FKxs9rZugSfo+G/xfY9r2z6oi8q0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB6PR0401MB2279.eurprd04.prod.outlook.com (2603:10a6:4:49::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Fri, 17 Jul 2020 08:34:32 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 08:34:32 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com, song@kernel.org
Subject: [PATCH v3] md-cluster: fix safemode_delay value when converting to clustered bitmap
Date:   Fri, 17 Jul 2020 16:34:20 +0800
Message-Id: <1594974860-12917-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR02CA0175.apcprd02.prod.outlook.com (2603:1096:201:21::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 08:34:30 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f57ac10-36a7-47b1-1770-08d82a2c3a98
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2279:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB22799C28671DA0F049A0CD91977C0@DB6PR0401MB2279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ak9Z/cZhnARuW6JNDJDDAs9QSwJY715Ws3eoS2Zpu7uo6yme8EWez3MRrlOaWnJMr7RCmM9mcMtN20IcmDxcRkSut4zlR0cf9A08rV1WrWXhblR6OcXjEkST8zvXLQ4zYVQ79Df3IRAm/FqaOCHYiatkOF4VQmrTuAiqkBPsyd96pnF8p2CzqFxoPKRTwC7uuvgplJDPtxa2j7FUtZplMQVH7j5i/k57b8mrBaCfjisTFytwgC72Nlq+dQnQttiGF3DKzCgifqcDDB+cEfeI2LLeRd1nymWmnjdNhOeoyd7Om59Y7yurPZsQMmySm4QUsis5/hEn0yIOGRMMH97USI6HUSHuoJQnP77OuOrVhSOy20poWx8SKI9E0LnJYJmS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(396003)(136003)(39860400002)(36756003)(8936002)(5660300002)(478600001)(6486002)(86362001)(8886007)(6916009)(4326008)(6512007)(83380400001)(52116002)(186003)(26005)(16526019)(66946007)(2906002)(8676002)(956004)(316002)(66556008)(66476007)(6506007)(6666004)(2616005)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YCTX7sS4zWbFs8zp5+YpyVxga/V2q+WnpXSfMgXkcfMb7pz1iHqK1596jXpjMnlDsQmOiemU/3enTCTXNEyyYpujOoovJPQyZZStfRuGFn+Gbq7jTkVeJbZsXeeer2SNXByrnrBvgOT0FFfwkYS6Hby0eCvW6cRmfe/u4tkHPd8brqEIJrmZ/i3f7ROMgjiRp1rz4iVVXGr5erCsgfJkENsqnU+hTwwSZTtH1Fg/vwibalRr9vaz1gzUF5W7TnmcQIyPhxa8slMzvFqYQp1eeluvaTf48qq7gUIcrz6HoqNuEc2fqwKJk1QvlMiMgNfxl9qWCszi0bhPLhgrnz9A44HypPdjDMJNHmMMqKhnWhkg93DQI/NaVVzryOL5d04tvna9/E4uR9C1hn3PeaQt2GHyab9RiLhT1Lw1nVkFpcfM30PZVDbuUapRS3QlhdWXYCFH2SDEaDmlGxcQXQk/iS8Iy8GTvlQ5FDH/bCI/QXA=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f57ac10-36a7-47b1-1770-08d82a2c3a98
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 08:34:32.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qO1eVBDlFnMkmFylapriT5A88jvUxIBNtzKPtuI6xhFlvTXrGpM+9d8KkQf42iMnvV0pW6UIOVO4GxKMUjX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2279
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

Neil said md_setup_cluster/md_cluster_stop are good places to fix.
After investigation, md_setup_cluster() is a good place for setting,
but md_cluster_stop is good for cleaning job when md_setup_cluster return err.

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
v2:
- change setting path from location_store to md_setup_cluster
- add restoring path
v3:
- add restoring path for error case
- modify comments

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

