Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2190225189
	for <lists+linux-raid@lfdr.de>; Sun, 19 Jul 2020 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgGSLJQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Jul 2020 07:09:16 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:40303 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726073AbgGSLJP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 19 Jul 2020 07:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595156953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5qwUjgS5wwPk7Kev34vUp0JYTEUdrGrp+3kxLsT1ke0=;
        b=VJQEt46nW0ezvtroHx3KoEv0zo3rLTZTzLZyZOTN/GhN8Lc9+Mhgye49r4bMzxrMpQmR3G
        ea27YGoHy1wv33lhIwslVIawzc8kSGlqocURu+4/p0jNJdYASVFFYd/AjEzFEfH6oHctCr
        W+ACQr3ciuxOy9c7iWDLNqiOLQGQA4E=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-5-DZQm30_7NN6XHP-YxhAupA-1;
 Sun, 19 Jul 2020 13:09:12 +0200
X-MC-Unique: DZQm30_7NN6XHP-YxhAupA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf+bKK3GGaTS6DBCuEKgu0G5M9Et7sVMhUlnk+zMGR5iLxjdYwf2E+aSNfr0IDzDT9jYMM6OVI4Kv/VRZ2VZwuPv2r2BKdtC3unCJMWDVHvCrQAOmv+bIIteXNxEuhOcmcuYZ7ZcWm0Qj8DRnJ+YKuIIdS/ABVS3BjnD+8OP9GrPFJ4tjDZHkX8y7Bsr8KOwXpWAYmenTcs+kTUrYdJD1WI3uZp9ldEeazXbAt+egzXp2avXkgMO1BWN/s8YenhTfUZXfF0K/VAUlhxBFN3m6aaGSKqYelSpdcDXzX47kNzIunHQaY+nCjBeYbtgShPjW6sxT3eG5fO21gdb/u5J9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qwUjgS5wwPk7Kev34vUp0JYTEUdrGrp+3kxLsT1ke0=;
 b=cR/lvBiC71FyoYvsvKnQh5eHjDLOXXgar26fvTaZL5LHCqqmCYRiTXBg83wZpTx4W+coOWBTtUVuIe/yg2qzQP+x+UrHsQiIWoix+MWy/jZMwzw+QMC3TQYTMIW75IkwNJckKNMgBcFvSSU0I1U5CFl9esVleZJkyx+Gt80Z+rD725r6ww8yKqniJetscFEK71cA+NBkht1R7SU6MFpD3UxT5V/CkZcvxih8ucMmAA/uOxg/Gq7j74xOxNw//68DM6xy2SOkf7v9zJXNdFBpEA1kvs3wVkQWxQNIL7PnKf3yc9QPeK1fWd+mv3geaKWhymIG9hm5JkkTMZs0WVlq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB8PR04MB5817.eurprd04.prod.outlook.com (2603:10a6:10:a3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Sun, 19 Jul 2020 11:09:11 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.023; Sun, 19 Jul 2020
 11:09:11 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com,
        jes@trained-monkey.org
Subject: [PATCH v4 2/2] md-cluster: fix rmmod issue when md_cluster convert bitmap to none
Date:   Sun, 19 Jul 2020 19:08:40 +0800
Message-Id: <1595156920-31427-3-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595156920-31427-1-git-send-email-heming.zhao@suse.com>
References: <1595156920-31427-1-git-send-email-heming.zhao@suse.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0188.apcprd02.prod.outlook.com
 (2603:1096:201:21::24) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR02CA0188.apcprd02.prod.outlook.com (2603:1096:201:21::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Sun, 19 Jul 2020 11:09:09 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8ecceec-c61e-4b79-7593-08d82bd42a06
X-MS-TrafficTypeDiagnostic: DB8PR04MB5817:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5817AE85E33853438E29732D977A0@DB8PR04MB5817.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dA3m7lq/kenrYmB8jjZMLodsz2XadPgYcijktvVTcGzQO7a/fbS3urhm0c23XpmTjfqlZO/IlRTEPgzc0kxWqmEEtnrcT6CeyJ3UlSKfzaqQ3dJlFs8UoFCong6wZ9j+Mva/zs1v7HHKN+AcUCBvN8K3VMghU2UW7bDaqMy0bzSA7WNRlSDE5Hj7x8cpxf6GWm9kjJF7g8xXzFNuMy0KdvpmvVXiLW0aa6LV3CYRFvK151y9gktgRxH3+LSj9p5Wb4SiZYt69tR9DX6kYBYIMWptN6o31hJGb3pib6GW4lYAD2rBOG8NKeA+vm2a4U9BW5gfycwszoG/G7v2eR5iGZaI7dLPizMA4uS8bp7p32ryieRbHrBqPE7QNmooWUbp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(6486002)(26005)(8936002)(6916009)(478600001)(36756003)(2906002)(66946007)(66476007)(66556008)(6512007)(86362001)(6506007)(5660300002)(6666004)(186003)(83380400001)(52116002)(8886007)(316002)(2616005)(956004)(8676002)(4326008)(16526019)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kwYmETYtOaMQeuqvzeKr77vAP4g5jqbw6IrRdcJmuR3Roix3J0yis1nDLg9DfvGCuSPKZBNVVvcj20uc1EBxjK4v8kW62kk6d3JEmVUMv2ENJEMjyFWgm+60cu7mC9gygXT+tVZrwHku3nXW1i6KWnXLuvI7w4UV/2UP2NTEt8il5mXVBPwtKa1X2F32qCAbEgs9+/L4SLA6HzK+G2W0aHMUkrqN68nf+lV4FGxXRTT0Jou67RBM63+dOgDGIGYarcTIOhbGAGL+/3LM273J9Z9EshXy5M0savQgk/7AyaS5SaQZI9Uzl1m8ZI8WQr8odiFtDa6efekmOEH2bPs5+wEndKbQkYrF7rD+xYWVOHzsan1TxzSsYialu/sgKqDJIYx84trE8498VEpdIgKmViWCgoNfc70m+Y8vCTqsSafMiifNv+WICdJmeX5LOl9TGo3CHJr/n2I4yVKkMNDwoG2qKRpvX4sxgIOBE8PuEvk=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ecceec-c61e-4b79-7593-08d82bd42a06
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 11:09:11.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c16jz0ArdpGKosQzQIj7WDTU6j/K9uJsS0hSUP2lKBNoijvP4xdP/PAnusg9dytWrCcLGXYAd1O1I7sqWLG4CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5817
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

Signed-off-by: Zhao Heming <heming.zhao@suse.com>
---
 drivers/md/md.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e20f1d5a5261..ca791387e54d 100644
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

