Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1A1226DFE
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 20:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389260AbgGTSJ3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jul 2020 14:09:29 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:39655 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389231AbgGTSJY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Jul 2020 14:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595268561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9U8tJrKWgJ/uGfk3MXcMbXvPBT8f2XV1fRJB4sdtmlM=;
        b=FTms5SoX6kijPSk6Nq4Sob1WI/VBhMqqrGhKItQikSrphxop1stU4Lu8tmUHzcup6y+XbU
        zI+8CIbdUGK47DgXbS1QWfVluLAE/vM0Z/ry0XpP+ys/QPldOl04FORy/vqBhm/fcJL1SY
        iG65uXtIVfBdDtSbN1imtt6LJTWI6Fw=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-3-iCXjW1biNkaj3rOQqGmVow-1;
 Mon, 20 Jul 2020 20:09:20 +0200
X-MC-Unique: iCXjW1biNkaj3rOQqGmVow-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1GMnUz+/NkXe9cr4Bh4VZkGSD12ii9oI89pniMACK0FxSFTMH3TXxd3mI89OvF/N4nvVKSgwFgdOkwClHusp9k/htoILhrl3C1MTjW6u7tXA6d41w0uwC5k+lZRg2YaqhQswi85sKgF/rVHjs/swh34RwRBna1mqRTbc4A6UCeX30i2rLtihwtU7QXmkwGkK4P+hVqZbt+WKVvmFm2CsE9tiZowqgoNSL82kX8AQJjYyOzB9w7001T2X9y+7MphUcJGx+5hVHm56UeW93sLt3drDQxZDAcAnGLCw4U2TL3InSumnbDsp21zkXSSiFztH+FJDl4gBTzPqdcUJ4xF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U8tJrKWgJ/uGfk3MXcMbXvPBT8f2XV1fRJB4sdtmlM=;
 b=UqUTkJXIWvWflg1iY6K2yqehqXdVfW/CI5quPq8YZm7PtaPY/l1FcV7VBKZkQEf96U6YAj7rXY2GOGEwx0Dz+4RxTtY4+EkfS+cbLYvi3Esloyw/EI0qZD8OrSVNZLNIzeQXzMfMFfnqm1ypzIqLd9A0CbwbqXOHa6rbTQM3XyleSaTiPs2TBC94dRM7QquBfdo9BbrHcmZgc5zfiG45TaDbHvQhJ5CEGh0uQc/5raBWaEfNsnykSm/7V+Wz2nms3aAslQjEQiu+uQCXksEU5Ee23+2e27ex66AN3lTQhqpIgYsxpQkXPjL7ncAXf7cWlZLHoznHlSkhzUBCDmqaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB5978.eurprd04.prod.outlook.com (2603:10a6:10:8c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Mon, 20 Jul 2020 18:09:18 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:09:18 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com, song@kernel.org
Subject: [PATCH v5 0/2] md_cluster: bugs fix
Date:   Tue, 21 Jul 2020 02:08:51 +0800
Message-Id: <1595268533-7040-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 18:09:16 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be8b7a0b-7675-42c9-fbd6-08d82cd8049e
X-MS-TrafficTypeDiagnostic: DB7PR04MB5978:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5978A74124FEAB824547F4DD977B0@DB7PR04MB5978.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPfXtNwoAFZjyTixL9fBtbLxxCvyDYKkJtpxi8gVEw0GwgjvwItE2438dTpLoFnZxuv3m3iQA6j78jZ8QChkCHpMx9yuC33+A/qoLEwvlmglSj3d0itSvMODWA54yxl1Ls3Jl4mJpfq4MIWfNck+fV8DUbSrFoTC+GX/bnv066RPT0kEUT0j/3dRKTRnzmxD35zEoFRMe8bkvOyZ9ko5k1tTiUS9/9W0eaaF4AZt2V3rb0mvC/jgSHDXRi7NnvsBycZNiMBfGDZEbbRT4P4xF8VekRBG/S9yn78VBfzM+YInMdErBxhsLAYCksbUo39cXdT7/TYGnKHcgH55+y94IGDDnltxkyCYTIHocY9Q9KuAKAopPqnQwKscn/1YQzKt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(396003)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(4744005)(6506007)(956004)(5660300002)(478600001)(36756003)(6512007)(2616005)(4326008)(26005)(86362001)(8936002)(52116002)(6486002)(2906002)(83380400001)(8676002)(66476007)(66946007)(66556008)(8886007)(6916009)(316002)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7O9fF85+A9HdPdGrGyPqFq/nBH0BaZTUNx8PkIKdGWTmNDOk9FIdizqgNuJzvfX18GZ6QFQjnXV6PU0XXYORzx6y6+rKCPACV7iqM9xjjuwdQFDbOW20PH3lAJ2sCtOTK1NhNu++tFh+QZKhHq0TLufJk/aAQkJWOcPO3ssavL2dY4Z6Lu394tkn/Hjlz5eHZ12Xqj3/nzXPLsaJbY+X+asXZHvcf3xaHwObGL3dg4NRp6OG0lAGSFx5xsRieuSlE8QMYGRF4+v+DOYFjiGTRmwzqivpe3BfZJsE86rysyK9bjqBouEbPz0P43TqgrXU0VnOy+Q2bawzBxuAqDXNT4IyCMa01vckMX+cWD787pOkFs121Q1iqR0eeTBbnp/sJlVz2HS9tQv8zUDpCKUQfOj/63NgapSPAUx/oB/7VIlh29GCB+Ldeh8fu4h20uOFQOusB9iLFETemj9cEtHndE8FgpBmh0K/HP+MM0fqbNw=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8b7a0b-7675-42c9-fbd6-08d82cd8049e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:09:17.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zouY/nY/kmzHbuWJop2PhtMlda9/LcwwljLoonnJl7OsbdkBcua5g6ayZoYxRUHwiRXIOoCvW3ejNKOG7lJAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5978
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

v5:
- change safemode_delay patch code by neil's comments.
- modify safemode_delay patch comments:
  - remove useless analysis
  - limit line in 75 chars
- add neil's reviewd info in rmmod patch.

v4:
- add new patch 'fix rmmod issue when md_cluster convert bitmap to none'
- add cover leter
- modify both patches comments.

v3:
- add restoring path for error case
- modify comments

v2:
- change setting path from location_store to md_setup_cluster
- add restoring path

v1:
- create: fix safemode_delay value when converting to clustered bitmap

Zhao Heming (2):
  md-cluster: fix safemode_delay value when converting to clustered
    bitmap
  md-cluster: fix rmmod issue when md_cluster convert bitmap to none

 drivers/md/md.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.25.0

