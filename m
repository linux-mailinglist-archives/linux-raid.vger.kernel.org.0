Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085F522132D
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGORE3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 13:04:29 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:42952 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgGORE1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Jul 2020 13:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594832665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sdtpTPcyz4GogCsHpdIqGs5orRczrGM0H6mIgG1cBm8=;
        b=DAkVWhUHfRIH4IIFfdtDJ0KNFVMfwCZJyY5zAG+wdf3JrEmoFT92PV1tz4aQYO9fr6ufhN
        gRIi2Uc6PSIxv2XOMxZcWx3iFkTZhu1QgSwpa83I+QsePYpuRsZgEp8KX2ow4UPj8eiyut
        piE9tWUZBttHgOUguoBhED9j4VZTrCw=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-SG5PMAsaPFC5qVjdMdxPJg-1; Wed, 15 Jul 2020 19:04:24 +0200
X-MC-Unique: SG5PMAsaPFC5qVjdMdxPJg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYo3V/tp8mE78ebA6RyienE8QF2jK4k8ZeQwB9lRY9nkDzMBpLYJwu4UNZ0Avk9IpDho7NupzYt4bEKGGw/wBD3r5yJBrMisfRT4WTZp3KuL++DU6qWILgndwBHTSxooQHKiWjHxR4QjQNeTL6GyvEfr3OpP4CEtwciD9jTuCWaJgGWIqjC+7+OB9eosM6/hP2ff/rjd6e514pedHEGw6nMAWwLF6/Y3HwxKtzo/IGJnpvO8IcnAFAOvY+WlVF2u0fDkSXQy5jFl2n1Bv0Ck1zzEEIJX8VUsjKBSo0GKVRAlugS9+Sz22DeVzLWz/XZQ9o6QpwVIyOrla3cX7lsjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdtpTPcyz4GogCsHpdIqGs5orRczrGM0H6mIgG1cBm8=;
 b=AcfbkhDsE+p1TI6KmY5i494cLIEf83i6RJUjRBbqDqZDX0hltmhQN2o++sBpT3mnaD1CPLBGuSPEploh/oiUXbEXjacEUVnDjILkXLgQEvB7JEUShyBq05/nYJVgCpbZPzy+I9CBC64ay/HNQ91arWSuyk2crssQgdPowIV2QqOlDBYYpQnD5u+dsiQqEML8IjvIATUVIWffS0AC0IRT7KlUAn8knlM4MlitGK6b95ky0r2HbuXj8BQJhrfsNhgOrul6fpx6vBOKzuibpR+sNfyplzkM18WkhlcgqCst0RJPwWaRaAUnOw5ORsZvb8xOHUTR3MhJritR9HKf0TAhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB5452.eurprd04.prod.outlook.com (2603:10a6:10:84::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Wed, 15 Jul 2020 17:04:23 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 17:04:23 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>
Subject: [PATCH] md-cluster: fix safemode_delay non-zero when bitmap switch to clustered
Date:   Thu, 16 Jul 2020 01:04:04 +0800
Message-Id: <1594832644-8837-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.128.9) by HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 17:04:22 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.128.9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d51a1e8-18af-4162-62a8-08d828e11f6c
X-MS-TrafficTypeDiagnostic: DB7PR04MB5452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5452BC58A662567917B4A641977E0@DB7PR04MB5452.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZdzhVNrMvjUU3we+fBo/h6rDSMABOC+9Dpv0OaEa2SLamXpLNsOGCloZkU0aV/IqskYFtdeAIFHP2nSv32mF3/SNI9s/YrV0B5sNhkp4rsnR/qB/EcPjaHnGb/p0ZiyJ5WUCmzWKAIvfbSIxzx/GJeXvnCKSFoJYDusb1aKVTuFafUQWJih3oZmBC5mEVpvxwxiSDOhLQsRmCztkp54nzRHzyli6pXoky/RLVCdDOCyaGAzcR3uClGLRWm4paBHtjDVadXcoEvNXccMMTXOiReKnYorwhpgx5/UWwtntwduDr44PbuWx99mhfg5q1WZ6iwKsGV4GmyvmC+A9s/Sbr80p0ys46puRr71k2kM0prtL8z+UZvX8bImBjjKwm9F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(346002)(136003)(376002)(366004)(478600001)(16526019)(316002)(8886007)(6916009)(6666004)(66946007)(83380400001)(86362001)(956004)(2616005)(66476007)(5660300002)(66556008)(4744005)(107886003)(6486002)(6506007)(36756003)(186003)(2906002)(26005)(4326008)(8936002)(52116002)(6512007)(8676002)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gIaVXddSaXxtE7gh1rJFxthzjAJKgt7yN/1cGzbBb7qame5i+ZlNQ0gCuJZS9o5QYzSncDu93ZQXmrjp/6VUWKuMatWpZ9Z8rRVJ4a0yGnybzyz+FCoMDmJD+6Pm6QdNHImLH3uSzmk/Wn467CG1I+/1oDiXE4n7vh6D+W7oZO3X6/ok/MZ5Oa9jsO46/uTqni7Moz5v29SfThzSmVeboWk2GVuKR7SZBBS2GGjjN4shllGka5Ega64eLIXXYMtTxoY89RKw/qrscerlT3t3ZjlxMFRlVx2xBDUeYEbrQqaisTqev6sXP/dGjZJZNVxamMdP437KscrbFZcrnQds4bin+Icy/R8XKrqG+acuMPYxmGY/QrHtjDnYgROTRgNYKW9W4yAi3yulQtSUVezxGciB4LHP21PkadY4ikcwJ0tZl1Tda0G8jep/acQjuBAYAmnCXFDoLB5w1KieJH6cp4gJ2GZBQddPKRPzyavPqTY=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d51a1e8-18af-4162-62a8-08d828e11f6c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 17:04:23.6692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04DDOdDOaqOUYOZrLRmZZwNXTpuLj2l5iZulB08WAlY34TpjeTY1rWHW39qsajZFpJ2mC7P7xrBTV7TcKuuiNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5452
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

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
```

Signed-off-by: Zhao Heming <heming.zhao@suse.com>
---
 drivers/md/md-bitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 95a5f3757fa3..547adea1d1e6 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2344,6 +2344,8 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 					mddev_resume(mddev);
 					goto out;
 				}
+				if (mddev_is_clustered(mddev))
+					mddev->safemode_delay = 0;
 				mddev_resume(mddev);
 			}
 		}
-- 
2.16.4

