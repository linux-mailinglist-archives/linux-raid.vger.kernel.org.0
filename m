Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C20222635
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGPOvK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 10:51:10 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:28655 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgGPOvK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Jul 2020 10:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594911067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lkCAJ/BvwQUosHemGYkxCV4ekJY7oSeBczVo/B5VHkE=;
        b=KIfcyRDOS/JTCxQ7c9G3rLkDFuzie3HDVG4LLRgs0j9vUMmM9shhZ0gEyQmUnXHcSEy/8W
        T6ppttsLjxKzc0es9lkOzJ/sQ7vlVgLflL+b8kfw81783QKeZ+kiVIEDYIQwTJu6rsl2eg
        54SXDah8vYdyP0qnbuBvEDVl91FU6UE=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2050.outbound.protection.outlook.com [104.47.1.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-8-FPdClgCyOROU--g9tRoepg-1;
 Thu, 16 Jul 2020 16:51:05 +0200
X-MC-Unique: FPdClgCyOROU--g9tRoepg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFLuUuUN4E5/wuAjA92HLIa2kJrY3fhaXXi4wpBW2k60hIqSm+L/cwzq2ixfvc0PM6geloHNaSPGXYkJtx2cd280g0iQrEfk3Z4JjMksu8QG32Et1Sg2QRFBpdZ0afrjikpp90JDRzhMMzKxnBZVe2IpS+BcI06CGy+zNR8CEB6M2fmJOSsZ5ge/MCd+464twmkCg2wK+B35pqnzx91+FqKL0SWWPeoOABA2ck1V1eBNs4DWPjMXvry5pWOp5ggHCmDqHgDv2MytsuJSDgum7W7f8ZbcPhmNfa4sRlSx1iEtc6VIBA2VaZqnou77bTlcGQDS7O0gjJUdpbw921TJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkCAJ/BvwQUosHemGYkxCV4ekJY7oSeBczVo/B5VHkE=;
 b=cezLwYLt9EFdJo6B/V60JXxWW9Ak+EsKRlL08vAqI21rmiPnZD/NAstKu4qemNC5T20+W4Yx4b5fIs5hHt0JpDr2c59oxOtYnLB+H6NGZV2bz//1gjZqbslxSlfCR7LWyPEzk5Uy3CdrczJyp7bK6utxVvi71OOP1rOabz1z8Zk0PGfLNmbgO1ifoxq+6kDpo3CVk0xYxe4AQSfgkH7eVF4xPQb5qYD2KLJpyvk6zx7VLoTYcJpKKButmDW5c4H3lG6fqeC4HSzgLXoS9ZC31Nogn+f2C4sOaOz9fqbqIoKooHH4K3ZkqrlEoFMHcGxjcDNLZyHpzqZxg0+9UKuaQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (2603:10a6:8:c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Thu, 16 Jul 2020 14:51:03 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 14:51:03 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com, song@kernel.org
Subject: [PATCH v2] md-cluster: fix safemode_delay value when converting to clustered bitmap
Date:   Thu, 16 Jul 2020 22:50:43 +0800
Message-Id: <1594911043-16956-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:202:16::12) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.128.9) by HK2PR02CA0128.apcprd02.prod.outlook.com (2603:1096:202:16::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 14:51:00 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.128.9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe977cfd-5c1a-4281-d526-08d82997a92b
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3673:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB36734E68007F5E789A706A1F977F0@DB3PR0402MB3673.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVLgMW/0QqS78TZf2RlRqktaVY5ElnLLilnCpsZDQYSzc5qILRgDMnHLDlRhfDppGwBpKyveYf/sADgeK8FbWMArvZyzio1a+GrxMZMpMXcswDSPGojZ8USSDKsgBQlQdp7m3MbtYQg2cbp+mxy17Ql9MUhg22CVAxpCFt38HXYHZ1rAy3ahJiwu8kdYLCZN0G8uKlHgbNH/BN1lb9S/gdiaysCmuWBaCE40+aCjQEDqqHLezrRHytTSPST0MsiyMJjZbuUu19bIozTq3Zy0tsik4wLuOZnMY9THFPkFwYQ8bUd9kLWK/ya7cxGY+KXyxOhi1S0quwPW+zxJ9+Qo1zBhY0E/NlMP/hZ6WaFXGWDSBNHAko8AbliMyvU2TwfT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(136003)(346002)(366004)(6506007)(956004)(6486002)(36756003)(4326008)(5660300002)(6512007)(186003)(66556008)(16526019)(2616005)(86362001)(26005)(478600001)(8936002)(66476007)(8886007)(66946007)(6666004)(6916009)(83380400001)(52116002)(316002)(8676002)(2906002)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MPknvJB5FaARHc2YVLCg1Nila2KxG+SkoS1J/CrbjjwGBh++FUBV1F519lzOMOvElSxBMsY/rsZi1Vk9vN0eN5Yyey92mwGFUhjO7s4P+NjRSEZ17Ev/DdmHrigNF01c6KPojpVxGf7C5ruaZvSYWPljxqV3UMiafIlG4o/R3ceuXPOau5MIk0RHDPktbhJ1S7s0F//ygMiv/4mdBk5g+v8HWEd/DQBeL1/ROk/YVhgkpw3UjQFol91WuU6PP6SO8ls/EMZDGUSbrLIKYQLG64Cprg9G11PP3OTAu7awDG+P/MQmqVSJpbTOb0T8JHBJ57AvgJinPNuhOJ7qQM+WCp/YQANH5eFvi3E6muHjAouyeC/NC+5TTcKMO9/SjMbnW+PEFnNpGFKbvGgqoOHThotfNmW0aecVA715A+U6w00ngVGS0dHEotpXavZEg5xM5p0yNL7gPB7KIbcJH6KVCl96H/ZFLLZGavxs5zRQn4k=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe977cfd-5c1a-4281-d526-08d82997a92b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 14:51:03.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6BxE9hT9CBtrE+B3HryqQ/L+tLA/cfTpAiusEdWEIgs4MFPWJGGtvcTmv8/0nimhfMoO5a6GFFEyntPVfwSIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
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
but md_cluster_stop are not pair for restoring.
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

---
 drivers/md/md.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f53..f082f5c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -101,6 +101,8 @@ static int remove_and_add_spares(struct mddev *mddev,
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
 
-- 
1.8.3.1

