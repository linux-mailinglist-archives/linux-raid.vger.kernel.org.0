Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9AE226DDB
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389269AbgGTSJb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jul 2020 14:09:31 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:38486 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389254AbgGTSJa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Jul 2020 14:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595268568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jATA04hHFJfDVgkjXms5/7A1qWkan+zfGJi5eiixN1k=;
        b=W67v0zhjdNHzdqIp4LmP1u52Qfy3IhWRRweqHEf8Sko3g6+eNAUR31jYg/FkGtAz9rFJKc
        I7GZ6WshMnG7aJqUbXtO4iCI73+Imw1/GLNrxxmM6EmcYX0SUJzJjrf1kACz+8uST18kfe
        D46TP7v56prPLkPrCBxpkEIU8A7UT44=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-eFU4IWa6P5iUkQvwkHSj8A-1; Mon, 20 Jul 2020 20:09:26 +0200
X-MC-Unique: eFU4IWa6P5iUkQvwkHSj8A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUPmL3F7A1GixC6D5YZUwjqEcBN5ioeEk6KZ392B3zYxcZBmtwAt5rGLqqssG9fUQ0LQHV149fe+l/OuMN2ccRrLIunaXw/YkIWh3tcGU5rDIPtNPfhAZwnqtzaKeLZxkJWRM7J6NxGF90g6AduNa7q7fJHjcHGRa7TOJms8QNAjc6u6Vw257KkB6UuVlg0dPjfTSEDWf/yUdkDPqCuGxIiNj5y+C7+891hC0cIS9ceviFMNRm4g1ziEvUuk+aClFoI4MhvZ0HPmhIU7bytI0qPwWG/J+/z45rSq2iWMG9sLlEC/53cwvZpMtYVzJ8SnO203OYxLcBJYxweL3yaNzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jATA04hHFJfDVgkjXms5/7A1qWkan+zfGJi5eiixN1k=;
 b=aTp72RWCKN6puRKpBo6tpwLzvAmaG7/8DjNIJfDd3/GtkfFqgZ+bMdSahP10m8LTKwKBw/LaVsB0mFPtyzEZqtxqou8cptrf97WUSRB44fLOTgdXsqNqWV9CpNmwruyzZFEf0UegH5amAssNUwYhxowsN3YFyyAnanF6desHL24a3/SaSwR/CXqDfFAbxI6W0+BbpSFWRlKN9H42H1a2y/ekf8U+tSNiNYrbtaA1vgcZBEjYBVrB8cwK8zASTZTNVtu4dWJy0Fbzyk/FzlHLCNyCgpEwqtECO9LALU+XME4jL2N8h7Imf0/z9OnFyrwa+ySTV2iNkH05EXmhgfl1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB5978.eurprd04.prod.outlook.com (2603:10a6:10:8c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Mon, 20 Jul 2020 18:09:25 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:09:25 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com, song@kernel.org
Subject: [PATCH v5 2/2] md-cluster: fix rmmod issue when md_cluster convert bitmap to none
Date:   Tue, 21 Jul 2020 02:08:53 +0800
Message-Id: <1595268533-7040-3-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595268533-7040-1-git-send-email-heming.zhao@suse.com>
References: <1595268533-7040-1-git-send-email-heming.zhao@suse.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 18:09:24 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beaefb97-941d-4861-9253-08d82cd80965
X-MS-TrafficTypeDiagnostic: DB7PR04MB5978:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB597869330C5BAB70CB8D6203977B0@DB7PR04MB5978.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LDF/ADriRQBQ4aJqGEvLcYFFC9y+lJQYw2zt8d0Q11f3eV+BnkJm4CfKq+JA7KHe+uEJ7ZkzPvF7jerJOghdgrVwzomajBVQfM0gSxtljQn70m3QEwz3RPBf2a6044jgvztyVHGVaookbG161H6rsLsUHRyrRIIhOdLr6tpUW/gW/ZqeEcx8o+9UiNHoQd/n/h+euUoXp787w+R/Qouj2T+o54wJ+87Ke+h3dggBCGNNc6AdhALN2PimAvkURxSG0V1aUngRWowgECzSf/1tWVobpt2Hy8st1YtbQESHrIGqCLr9s8eU6/IiATPD0eA737Jit3xu0E/1qovbIDG2uub6VZsty3mWmZZmGn5BZOnN23dht188y1PTC5oHFRJ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(396003)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6506007)(956004)(5660300002)(478600001)(36756003)(6512007)(2616005)(4326008)(26005)(86362001)(8936002)(52116002)(6486002)(2906002)(83380400001)(8676002)(66476007)(66946007)(66556008)(8886007)(6916009)(316002)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rRO9VKdbZqHNFC4P6jSrt7iBBXnBwO3mwo8OzCGlr7rpOBCBJzTNrHF/OMcz4f3NIBeYFnEXKWA2oOmP0hONTa5ETGZaROfzg4ZffwFR0+Atlwkr2S8mFNH0YIxlp3T8c9fvzaeyrPQl9Ugdb822/GnWA1AgBiLYxBMdpsheXLcWhn36v2ybcmokpQC4EZYLwNyKKPbCRYpVaOK6SQ+duKewjEA0rxtwg1iyeINiyUGF4DRQkX12r2P/lOraKxIpiCKg0Cf4BdvdcVqIroe3zwDkETY9o1+RPiPHAe6WfZrFBf7lJiPhBk52kc+sh+Goe9JrikmvUt3RIgiIlDwhY+qMubKhj3Ei4EA8EQclavHiiXM6qgIkKeMrLBrrVXg0pqfiNc6RViNofeB+KXr09JotcrW16ksVkAgWeXAm5gFtUuUgrQWcpz5CH03+lwBGnDE4Dy3UFX4aZZ00NdHJbFmKxWrgNjxyxQlSiW/s2is=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beaefb97-941d-4861-9253-08d82cd80965
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:09:25.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqPG6tyF8eEz216jM2/JuiPdTvT92qCd9bT68UHlLRq+WvNZE/VdGoDaMvDCLOwAtjVcgwZ1c8TbIhu2D1O94w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5978
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

update_array_info misses calling module_put when removing cluster bitmap.

steps to reproduce:
```
node1 # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda
/dev/sdb
mdadm: array /dev/md0 started.
node1 # lsmod | egrep "dlm|md_|raid1"
md_cluster             28672  1
dlm                   212992  14 md_cluster
configfs               57344  2 dlm
raid1                  53248  1
md_mod                176128  2 raid1,md_cluster
node1 # mdadm -G /dev/md0 -b none
node1 # lsmod | egrep "dlm|md_|raid1"
md_cluster             28672  1 <== should be zero
dlm                   212992  9 md_cluster
configfs               57344  2 dlm
raid1                  53248  1
md_mod                176128  2 raid1,md_cluster
node1 # mdadm -G /dev/md0 -b clustered
node1 # lsmod | egrep "dlm|md_|raid1"
md_cluster             28672  2 <== increase
dlm                   212992  14 md_cluster
configfs               57344  2 dlm
raid1                  53248  1
md_mod                176128  2 raid1,md_cluster
node1 # mdadm -G /dev/md0 -b none
node1 # mdadm -G /dev/md0 -b clustered
node1 # lsmod | egrep "dlm|md_|raid1"
md_cluster             28672  3 <== increase
dlm                   212992  14 md_cluster
configfs               57344  2 dlm
raid1                  53248  1
md_mod                176128  2 raid1,md_cluster
```

Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Zhao Heming <heming.zhao@suse.com>
---
 drivers/md/md.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1bde3df3fa18..502f0d100a96 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7363,6 +7363,7 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 
 				mddev->bitmap_info.nodes = 0;
 				md_cluster_ops->leave(mddev);
+				module_put(md_cluster_mod);
 				mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
 			}
 			mddev_suspend(mddev);
-- 
2.25.0

