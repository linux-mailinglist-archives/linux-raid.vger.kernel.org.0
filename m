Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE142196A4
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jul 2020 05:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGID34 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jul 2020 23:29:56 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:26422 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgGID3z (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 Jul 2020 23:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594265392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0S4D70ADuMJf7tT1pxkj0qcRzGu03d1G3qhEoIw9l+k=;
        b=n1MDeLX2UsFJnInvv3XuyyWZvGzf3d19qiASeHhZniq9eCWrR5PLPU6yFP5qVhVk1Qlbul
        phRoLEZ3mXVawB0xYU7xK+2D+36m9eKitvsxKx5owfeiYkb9RjvX1DjvLKQrCAlcbzwqTp
        VtbougJXC6DY2L4uE66ZMZwyu57YY+Q=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-MyZdAiXfMqKMeg_6P8Lyng-1; Thu, 09 Jul 2020 05:29:50 +0200
X-MC-Unique: MyZdAiXfMqKMeg_6P8Lyng-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEEEFnkCIg/lOPdLrYN5LllDRLE9yjEM2kB/OsfkdZViNOnOlCKQbGLTwyrO8fTSkXC+h8hHDcev0m+Z7g0+NHicy1TP1mLNzrL1dHr/yQqJG0qurECle85xDFJ/3diSZIVlKaBhRVUyqg+M4PU+M9FdF4bhaG/Lu6XxUcy75eI2srr11IPSmSWqeF6UkPc849CL5BvwBz7slPIktwlQU6lZFaPk83kC0mRTthf2z2d9xtP6Goshd4/x13+T7DGlxuNF+vbe1Ri4QyXA8vl9KzKRXCe9BLMDA24/c6gXsE1etCU+8VlOlNPv5DtHiPIpQzU1QWuc8g53RzJw8Gm+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S4D70ADuMJf7tT1pxkj0qcRzGu03d1G3qhEoIw9l+k=;
 b=EneufrHqrMipbXiaYeds7CDF8tbehlJCWZ1qBbiXFmdlMx3f//ZiGPPvTuqJnwLFC+SjJYuzQ1wtYOoY9Foq0m+asoCXOTJHkw6bH4bvajIz83qBkRG6fhTZWpX7My0/FW7kEwHSTBYH5cuD4D0xMKiZG8rIuLNhVDUYzgsj4Sl09yxmdV+xY+tevmeKXq01GIvtvCZZF2DbLk+Wb/mon9Ab7Kxzsd/hhi3WoekF5L03I1kjTnFiGIzMKxf8015ilSugnb+jlp5IPXwpoDuFlbSlZ0Fcv0QUmGPRaidDVBNdRHnJjx1TiBZSmQexx+TliCquBqvUp3JV95WZ6WpRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB4268.eurprd04.prod.outlook.com (2603:10a6:5:24::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Thu, 9 Jul 2020 03:29:49 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::e5c2:f444:edb6:3c52]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::e5c2:f444:edb6:3c52%4]) with mapi id 15.20.3153.031; Thu, 9 Jul 2020
 03:29:49 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>
Subject: [PATCH] md-cluster: fix wild pointer of unlock_all_bitmaps()
Date:   Thu,  9 Jul 2020 11:29:29 +0800
Message-Id: <1594265369-9468-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.128.31) by HK2PR0302CA0002.apcprd03.prod.outlook.com (2603:1096:202::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend Transport; Thu, 9 Jul 2020 03:29:48 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.128.31]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 421d2881-55c3-4a83-af3e-08d823b855b2
X-MS-TrafficTypeDiagnostic: DB7PR04MB4268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4268C54904A19B563BE79EFE97640@DB7PR04MB4268.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:143;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJkI7dZAp9zvqndrnzMJp3sE1h5rTf5vRihkHz0TbIWP+593QV0wxwULVP6cRtrR30L4U4KJbM81UwiA2W5x7E2r3hF9iRugw/H2G2E7U5n8p4a2ycjclmRn1VR5wDXxe7HqC+x8KT143dhTwrIae1CO8EHaP7Vq8iUyRWjMKec2gexuq1qxOq2YH0fJ0iPNuWoK512q4VSvOKOcQVGNW4GrxAFjv+/wriEJiZqIoYaOTTDHyWYB+FZXlTeoFShQ78OhcbOgdU9pioAxOEeRiZFOkMMZPQ+GLnTCCel9qvH1tafXc2Ml6EfwnVOFLGufJv4xZS5Z0c0UkmR9YcEVbfoQMgkcVxAl4K88iSDLcLmbyMlhayfyHw0+2cCWk49w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(376002)(346002)(396003)(186003)(8676002)(26005)(6506007)(8886007)(6666004)(83380400001)(2616005)(66556008)(66476007)(66946007)(16526019)(5660300002)(956004)(36756003)(6486002)(86362001)(2906002)(6512007)(107886003)(478600001)(316002)(52116002)(8936002)(6916009)(4326008)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SBpU8GFbr/D8nEZGqTx3KYWrMPEIpc18vwJYyyjTfggRAdlNXuxmYOYJLmIUjINQz3PIQ+UyxkF88KlSI3qX9Xorft/sl9v29Avmngx+JWFXip8ErBeBnBRDVVIvOd2YBVHlpGP/PGWVZ6JpWSHW7PjbsKNWsf3ucfd6i3xzxqQBdu9t6zqt+M4gfXpRu2wKBvSEN8j0uFqo1qYsAyDIVUyq6kG7U2ZVPOin/8jyxzReYXJySZm1/cactS1SPJhwYAZ5r2ttgPHbN8rDcFEr9A8QOm1AmwjMuXpeivKu7NwG8E8lekv8AZVWhJrPcNfXXgHMovTsWkuPsDQ0UUpNnJaE30CfhoJNXGlygPZlrJAazgx2pVWhbvdQE98Tt8JvN9XEd4i7OFuD3lAMMBiyCwD8yI+jUfwiLMqH5iH7OjAoTijPApksdfz0jIYcGOnDQOniL7KWTQe8tOKvZTbxN3tRsZFdjpV6ZAzoNRc9Lgs=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421d2881-55c3-4a83-af3e-08d823b855b2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 03:29:49.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge4j83OdFrY8xLxjwvuXRI7i9wajp4ukU7Ug/AYTR3fW8QrMJE8qMhnDytKY2eVqxMFWjyOb1UZfV5e8/bsPSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4268
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

reproduction steps:
```
node1 # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda
/dev/sdb
node2 # mdadm -A /dev/md0 /dev/sda /dev/sdb
node1 # mdadm -G /dev/md0 -b none
mdadm: failed to remove clustered bitmap.
node1 # mdadm -S --scan
^C  <==== mdadm hung & kernel crash
```

kernel stack:
```
[  335.230657] general protection fault: 0000 [#1] SMP NOPTI
[...]
[  335.230848] Call Trace:
[  335.230873]  ? unlock_all_bitmaps+0x5/0x70 [md_cluster]
[  335.230886]  unlock_all_bitmaps+0x3d/0x70 [md_cluster]
[  335.230899]  leave+0x10f/0x190 [md_cluster]
[  335.230932]  ? md_super_wait+0x93/0xa0 [md_mod]
[  335.230947]  ? leave+0x5/0x190 [md_cluster]
[  335.230973]  md_cluster_stop+0x1a/0x30 [md_mod]
[  335.230999]  md_bitmap_free+0x142/0x150 [md_mod]
[  335.231013]  ? _cond_resched+0x15/0x40
[  335.231025]  ? mutex_lock+0xe/0x30
[  335.231056]  __md_stop+0x1c/0xa0 [md_mod]
[  335.231083]  do_md_stop+0x160/0x580 [md_mod]
[  335.231119]  ? 0xffffffffc05fb078
[  335.231148]  md_ioctl+0xa04/0x1930 [md_mod]
[  335.231165]  ? filename_lookup+0xf2/0x190
[  335.231179]  blkdev_ioctl+0x93c/0xa10
[  335.231205]  ? _cond_resched+0x15/0x40
[  335.231214]  ? __check_object_size+0xd4/0x1a0
[  335.231224]  block_ioctl+0x39/0x40
[  335.231243]  do_vfs_ioctl+0xa0/0x680
[  335.231253]  ksys_ioctl+0x70/0x80
[  335.231261]  __x64_sys_ioctl+0x16/0x20
[  335.231271]  do_syscall_64+0x65/0x1f0
[  335.231278]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
```

Signed-off-by: Zhao Heming <heming.zhao@suse.com>
---
 drivers/md/md-cluster.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 813a99ffa86f..73fd50e77975 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1518,6 +1518,7 @@ static void unlock_all_bitmaps(struct mddev *mddev)
 			}
 		}
 		kfree(cinfo->other_bitmap_lockres);
+		cinfo->other_bitmap_lockres = NULL;
 	}
 }
 
-- 
2.16.4

