Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D75225187
	for <lists+linux-raid@lfdr.de>; Sun, 19 Jul 2020 13:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgGSLJD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Jul 2020 07:09:03 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:33960 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbgGSLJC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 19 Jul 2020 07:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595156939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=629ZjQmaSzQo4RwD+Z+v2VWzz1M+q20PJ/8HxtgQzaU=;
        b=MNnLtX5HfEkhLrb5xCjO68GJQ81Q9ppdtCTGBAO/EmJPyd78fGd6rOA0v8DjZPpVMgvZud
        WwSm6zEFbdKtRuZOXlMK7e5F+kO/Eo0goDitgU8PxbLVY6qJ6/9bY0RLwtDcDNbzCQs1f3
        zsCeOS84bIxmBLGBWqTMnYl9r5MOPR8=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-AwK5Tg1_NAmZPtXGKRmEgA-1; Sun, 19 Jul 2020 13:08:58 +0200
X-MC-Unique: AwK5Tg1_NAmZPtXGKRmEgA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDCn1ibKxZiuCWV6Oh7L117yYpfIsTPKQ1rITbXNXeQx26qQO8lkfjS0GlptWB2++HSm9cD+z+wuc8Sevv4DLWVdXZDcUaKDwKZBV5tkcpX9cAPB7sKjv2smnvdiZn/doR43pRH3q25khKnD0EZ7opqSm6w29vui5FHakhjxpeR71In3/wyy8sXKGsfvmH+RikBmlIgYvk3IOpTOoA4az7gvQgOhYaXqYPNhj4LYjYA0aY9aMI95NVa6MG5kxLnotHOdplAgXP1ySnoBuQYUMVtHF8H8CrsWYeVXwVWwjrmPz5S9EDLPsjEjogpRoDxbCL2XKrzrw0ujwHzFeSPHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=629ZjQmaSzQo4RwD+Z+v2VWzz1M+q20PJ/8HxtgQzaU=;
 b=H+varb5gRdxIPH3lb6CV0ppGnnGXrmrBMl2V+DxheJUjPDEDyNijBYe3wkko07ZPgF7hoPQ3F0Y/kVBl6AfnLGuzyZJzerNa3ovK+D206/euiWSE0cWdzkR57NPB82kjchSbmLQD3WB/m1pfkpNLabJOc6AFxQwpog4kGP5+z9z6jLj0YLQzsqJuf2lDt74bz3RuvTe5wRk1qrszbYqERNh5vU1XJdY09KEYY5/CV8ALaQamPd1ex+njSG44kWPIphF0R5cfWat4EC4lD+jFO8y/Vi6hmP/i77VRj0kB4y/42tDsnlhunsBPx8orwiLoJgpRcIjDxJcbldp1683DeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB8PR04MB5817.eurprd04.prod.outlook.com (2603:10a6:10:a3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Sun, 19 Jul 2020 11:08:55 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.023; Sun, 19 Jul 2020
 11:08:55 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com,
        jes@trained-monkey.org
Subject: [PATCH v4 0/2] md_cluster: bugs fix
Date:   Sun, 19 Jul 2020 19:08:38 +0800
Message-Id: <1595156920-31427-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0188.apcprd02.prod.outlook.com
 (2603:1096:201:21::24) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR02CA0188.apcprd02.prod.outlook.com (2603:1096:201:21::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Sun, 19 Jul 2020 11:08:53 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d1e370e-7b7a-4ecc-b975-08d82bd420b6
X-MS-TrafficTypeDiagnostic: DB8PR04MB5817:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB581758B83257352ABE112BB6977A0@DB8PR04MB5817.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkCvjQkmCRKYOT1K0CFKANT121aAKIXZNhhrkkeE/OruxPujoGIfQ3Ap4dxy/R3YJ8KGCpoFDwqU7T7XI8DMvK249ybyyPPTfh7eJlkU9RPZseLsRFC3VDu8SCwGnLd+tDuU5Yg0cTZNKMlqmJRYtpJMQtlrpRc+84A8VwwNIas1Iagl0tSZznJwzPru+zjgFD3fgwdeHDIyGGTpq8RrSW3aYaMRoB9oOzV5IPNg3ifXuV02SyaFpJrubBvOmXcfTdJHIrk7drRxNYjN4vcDtdt5cMdpkYmnTxYsJ6LFxAg8Svn0oKecXqP9q3mjYnY70d362lcji4UhnkL8E66B5ztlN5jb1A79SDOHWE3IUTEXcV0BiUgUGZk2PEKT69F0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(6486002)(26005)(8936002)(6916009)(478600001)(36756003)(2906002)(66946007)(66476007)(66556008)(6512007)(86362001)(6506007)(5660300002)(6666004)(186003)(83380400001)(52116002)(8886007)(316002)(2616005)(4744005)(956004)(8676002)(4326008)(16526019)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WJvfIkjPRskRfIHV+CxEouFTCQ/cqY3xMG56n7/pZnmeZ7WyKupbNYyI9VQM0TC/mIIJYb3ptk+wlJB1lV+emMBNolLPLrVyPNvkgKKeMQYUtIo5UHDkSl0DmkHeznZNjEfmA2/wWDbDUHWHtoXkuKLdtc09YfoEPzCNcT+dNKUiRbc70PdJYceceS0/IHOkM7ctJ+S8WNIWqLHvANosqyUQNfS3Pju+5Xjg2gJNMXHrBIJfpsZSUN1YrCtRHI0jcm1khwJL/etm5HqXyV2y/gqtBbJcecd+8GEXR9vbeks3wjFAij+zjK0WSeBupx/6BDH2tZfOZn71otVFK2OWAXASyw95v32vMzJj2Px0OKQDOkMxN4i3YgYlXuZ0M1yaLIc4h3JoFEl0Uky1kWlBGBRjmWNQxPY3jwxsS6C8Z/TRro7hXmAfL48qSgrPNYy5T+zfbz2uxmHP5VkqRbSjf8h6fzBqNdHGY/h6bLz4E1Q=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1e370e-7b7a-4ecc-b975-08d82bd420b6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 11:08:55.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aBuOGsyVzuj8RZ/XWA9p9vobAFdR0sZg83m/4wuE3uRTxJU4LPBkO485GWisoQs6zrnInVbSDqDYwN6gQh+/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5817
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

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

 drivers/md/md.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.25.0

