Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF17C8CF6
	for <lists+linux-raid@lfdr.de>; Fri, 13 Oct 2023 20:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjJMSQa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Oct 2023 14:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjJMSQ3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 13 Oct 2023 14:16:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2018.outbound.protection.outlook.com [40.92.18.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39797D7
        for <linux-raid@vger.kernel.org>; Fri, 13 Oct 2023 11:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C88HcX2XSDpaqzWjl31LNc6XIz086obOimOtT/fU5TV/ILSDYArTWGOGS8hZuv6aHBH6Wl3ecbgxnI/0HUSwBLyOCucVbWndDOHB5mn+d/8ydvdty/8/iGvrpq8eIqRhlLlMHA/YgJWcWw0uMZl26driMiS7EyTWvuPYZhjUBZ1e5HZpJE1sg/ugt5mf1zK+PkU7FqQ5qL09iZq7aKKBS04iFcWehjNrEgLsEgGoSo5oXrwIpkSc1xFtpvgdKEjadRNO0+TDHVvqJjtfyCkiWmFTQ6XPwY7bXpkJU3oJFKDIPJAxHUDXq74N0ocQ0k3u6IJUik5Z6XCZU1JZwpjj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ64g0tr+8l5t9RYmzWX1hIsdXFL1lQQnTPxuaeASog=;
 b=YfwXCrvt7UYkGM3qcMl0tHvqjqlzXOWdl8NtfBMOxsX671abwlBnCA1yqTxW6ZVSC9RuxL45nOFacMsqEpXm3BowvjXtsleQDhdMoFY5mMQ54lGiAr5hl2Ot0RhcU4XFPU/ruMAPDAbzFLUsa5uXWoOSbU4OCO1wrmD7mcW2uJDJZIl0f0dku2qS/TkNQftN0W5wOGmrOiwotXyZ0JPqwvKtzht7WIXy0BDDVo9YFlFRmYR7DQAqrtBJb+KgJeF1keRWCnP77hFcN6PWNv5eU0v6hjEJMXtcm6PBHr9VtVex9pEhbQtVZTvI1MwOrer+gA/UcQ4N1Wnot/ywmMxLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ64g0tr+8l5t9RYmzWX1hIsdXFL1lQQnTPxuaeASog=;
 b=lGxMI3FMnOJcchnhd6Cfh1Sd+bgO3Jj1ZtAPGHMBIkOtRB7MvCUD0Rm1Yddy18Bp6oza9EUpzpLBcf33i7netfQDrEg7u7lXWiFBelEJx9hFJPPdUbKO3M34DyY7WyhqvnwrUM4kD1nGdMFOwgK4UGuvppxMcek3Ngpykv5FsSveP5dRUOlq55JuyVvMuSmmSJZHOuke8AehMU2r+Infe/psxrHqif7/5YwKO4wfuD2FAMQ2bPmQLeqK/5gPfZi9BBM29GgN0kHjGM9b+lHC9futVi/+ioR3JOfuKWnWT0VmMFKFSKbvSS5aGiiPSgxMiuCvO5Hox7HacAXEo+8pBA==
Received: from DM4PR20MB6481.namprd20.prod.outlook.com (2603:10b6:8:18a::8) by
 SJ2PR20MB6623.namprd20.prod.outlook.com (2603:10b6:a03:4d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Fri, 13 Oct 2023 18:16:24 +0000
Received: from DM4PR20MB6481.namprd20.prod.outlook.com
 ([fe80::ccef:68db:5a3a:bf65]) by DM4PR20MB6481.namprd20.prod.outlook.com
 ([fe80::ccef:68db:5a3a:bf65%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 18:16:24 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Confirm receipt of this mail
To:     Recipients <Gong.Zhengyang1@outlook.com>
From:   "Mr. Gong Zhengyang" <Gong.Zhengyang1@outlook.com>
Date:   Fri, 13 Oct 2023 11:16:16 -0700
Reply-To: gongzhengyang49@gmail.com
X-TMN:  [5f/zt1eZ8FM/ysxspthZFa/Ks0LQQbwI]
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To DM4PR20MB6481.namprd20.prod.outlook.com
 (2603:10b6:8:18a::8)
Message-ID: <DM4PR20MB64816AD0EEBAB20FE3564BC3ADD2A@DM4PR20MB6481.namprd20.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR20MB6481:EE_|SJ2PR20MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: f58796d7-5fcb-45c2-f422-08dbcc18817f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/4nGKkxzjVq1NmtvjWy9jBCpGp1KS6uojb45hE1D9gw/xIsDTyAL9PBn2oAztaI8R0V/HjjgXSpYX8nwddEVhzVmGTD0KnS9TYQZezftO20WHIAFUzmv7bBI8RyhoslDvj7fc8ET+kYWJht18FTRB7DBpnAq+KvPHRPoRsCVs//L8+MDhyGRbWXRIe7c1xi8JKZ64xAFCNfutMrdNQLdCagVtJyoBFdEICi/UFRRdqV3qjUpbtjxp/1Xl2GaFabBgAmGy7d8BYQURImmzV6tIIVHtxB3Sn0byrjsTTdICVByJ+hQnOP5BSACxn6tHqyTImDWJ5FH+6oHxxhYxFDqiQAeiWgyoXivtQUtS74RuNg/rgwG9Q1ndKPf9r6tGT/16R+a77exp4/CxdUVX335Rg8c3eW4Dtf73b4xfTa4PpcmwVJFJdPbDRLdWQ0WhhIa2SlniAefECmOPG1FIWQDyQpDBMyEgFr2/ICCMfRdMcm19lrLKBYyt+I52VC7a6+u4D6WBRkA/UGiMYcA/xXpyEWtpt9QodvVTrdTsjG2t/DOweMyUR0I4p/dC1ECQh1BJJ0a9fF3Z2m9vQfynJBebLC69z07rbXrp8V38RHlxr9Ox5era9TNfIjJLGtCceV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FiB6OoeFkfdRYBLUbnKL9jCB2r6nNGl2CabkUq8x6Md70NoRK6aUcKjJ3D?=
 =?iso-8859-1?Q?EuNMVAjxHGSEQj0feBhRub3hcQQE36W8IMjcA2/feS1TBZ1eP0k91oayft?=
 =?iso-8859-1?Q?GOGv4P0nU5YV8SRkzfTy3RO2XiHpJKsfTZX1zyjDOF9DrkyYItgu45OSXn?=
 =?iso-8859-1?Q?i37Y+997aUPoRhRGXEKJuggkA9hIKWYomwdNtr/UyLd+nqIAx5/H+7/umY?=
 =?iso-8859-1?Q?8QHLX8Xs2thRK5V57G6qusqELIwDzj0VyZ40EMUAysJdL/0ZZTQxhAbg8U?=
 =?iso-8859-1?Q?CSmKR5yR6guXTVnSoQ1Q4i/rRTJxBWoc8czvN4sjN99BMHtkNDa8tAYqiT?=
 =?iso-8859-1?Q?b5kSCoI9dPwUk+Z4NhUkncI4XFC6FRm0wkXJjKt2ONhyevYBESDU2fiJV6?=
 =?iso-8859-1?Q?Yoa8xaLZs+/jaXObXo4/yqe9kpqVHTc9vtlQ54CNOs73q3ZXQQzBOaPikR?=
 =?iso-8859-1?Q?zKBOSXid/GsG+Ct9jzRLhlWFWnLHKvGpojsVBu+ZhWOzuMLOKfgD8nAlkw?=
 =?iso-8859-1?Q?CvlWxl54Dr2UnftBwk+Wl2a70lW1hRmkDy3EGEbvkis3p2vk4HrIUkca/m?=
 =?iso-8859-1?Q?jjD9y4lt1ROXs1IZCvMAQdDpEq4uWZN8Kqu3i69cfDhuQowvQlf3DWgV1q?=
 =?iso-8859-1?Q?i0LqkXognwKIvga0sWSxbPnNJTuxsFY543MIbJm02ONWyHO8qxzDBg265f?=
 =?iso-8859-1?Q?rrnhVGVOMcRm/5vusSLSwQNMl/OgjEdevW7sFgOxelazTqswXAIT7oZiwZ?=
 =?iso-8859-1?Q?bxfd9J9HRsEq8x5bAC5PjrIVvLE4GEPFtJXRlDjPVpDddRORx65PH3vwtp?=
 =?iso-8859-1?Q?MZ9r/4VfP4PX78T7zmKw3iwzh+jvL/Pt7lNBHEwMebU4xbe3y3pPvt891I?=
 =?iso-8859-1?Q?Kiy6Nf+f3xVtqPKjThvbHLG5eyC/yhzTcfJljl8VVevPmmfnIGCxo0DgAl?=
 =?iso-8859-1?Q?LJNV6IXo986DEBQ8iKxp1yMlodWhZImHRa0nl/qWlGCd+92Bx8oo+kRBIw?=
 =?iso-8859-1?Q?nfhkMSO8GhcWFNyG8q8ou3Kre7f5S1CsFhzGl/iYw3PWdXRR37lHl2vjFq?=
 =?iso-8859-1?Q?4SLD0hmjVoxYlsLu7RPnfKK+/A2AY7pesa0ZZXPZseWLRe+irW6DYMZ8MC?=
 =?iso-8859-1?Q?kPoQtyd1ck+E6LZnYncayJNByNRmnSSTd6geAnPGl504oqxdsclbC4KmZb?=
 =?iso-8859-1?Q?q4TesAyjersYaacJMsAntJpg3rFTOGAf8DI0uq4bF6nEn3ToV2bMagUlZK?=
 =?iso-8859-1?Q?4ClmrZfLcafm9CoUq6Y8BdwDlc7s7ss4rdbSfN0/A=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58796d7-5fcb-45c2-f422-08dbcc18817f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR20MB6481.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 18:16:24.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB6623
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello

I am Mr. Gong Zhengyang, Assistant General Manager & Deposit Management Hea=
d at Bank of Singapore.

I wish to share a viable proposition with you which must be held in trust. =
I understand we have never met before, and one has to be circumspect before=
 responding to matters of this sort. All this will be addressed upon your r=
eply, given the conditions I shall highlight in my detailed request for you=
r sincere collaboration.

Your prompt response is most appreciated in giving you a briefing on this s=
ubject.

With kind regards,
Gong Zhengyang.
