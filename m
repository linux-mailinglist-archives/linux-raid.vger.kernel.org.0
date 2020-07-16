Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45C6221C8E
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 08:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGPGXR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 02:23:17 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:30392 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726547AbgGPGXQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Jul 2020 02:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594880593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vI+oNWOggBmWyv/T5dtCtbpvpRJ9EqJ+m1GcNsRL4So=;
        b=beMFWFh/L8Mn0fZgbeM17MVXZ1s88hw18gff9FDePx8HiHye7vDEqs1G/aWsapNaDEESL2
        No077R2dgFJtya7/8hfJ2NUO58xrPBvr+PLlkWOt6yLZxxX1upl+dH3IA8iRJTD6o/1RiX
        CTlgi4Y8fPcRfZSke2XCYLUy/XqT9AM=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-8-oz-7uYw9Pp6YDOP6llbh0w-1;
 Thu, 16 Jul 2020 08:23:12 +0200
X-MC-Unique: oz-7uYw9Pp6YDOP6llbh0w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVmCbyqTixLB/s/yOuaVZOG5eqzPE/QI8Od3LDexiJ8MaYf6Bg/K7qWrvbel9FQX3K+m7R8PMyqpxWW+DkcABvGzh2eBVXUPP8PKRjWnLSrloyux7SqMhCGM5GbMtc2D9W+VOAV27Z9+1iA7JY3PKeEu7iLVpqs8EcKMesvez95w+DnFv0jdqEnS6VGekAkwmtZHr6D3T3h6zMJ1VWJ6BaNSwG6ht+PGr4XFMgdSTOW5fTLDduC1Hwc5MYsNBXtabIsYxwGqKKDim962d3fnIL3SMl18ueQShTQ6NgowKiiElakWmF9+wVZoTtNLwuaWgmI3kOKiBEgR8cBg4bnBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI+oNWOggBmWyv/T5dtCtbpvpRJ9EqJ+m1GcNsRL4So=;
 b=coiqnloA15Qa1ScrRFJiINKk0uk6CtHR+EBH6h1/gw3HSXq/Bp1gBFquBVevXk5ZJgCUsJA5d7VjS9Ydf7IB2m37J8t/eWj8Abluz9WbaYJJiKF5IPu2vFwm0RvHW/sYgvnB3xQ9ub4DTC7HvZppB0zyE3Dq1w3pMQYJ15BGOnSo4vExJXdBm3qstds2w0+n7DxpTej3KtUAWfZ1ebE2XchDKszlUXNAec8o4yyPZO0vm57vs0K7i86pPtYqNObSFjGUJwXSQAXHhzA4+MJv3lY4Wdil2R3dirPWKwVg1l5Qx0WYt9bgEkN8I4MlU61rpP5PkFbGDpwiSv9T88UWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB4890.eurprd04.prod.outlook.com (2603:10a6:10:1a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18; Thu, 16 Jul 2020 06:23:10 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 06:23:10 +0000
Subject: Re: cluster-md mddev->in_sync & mddev->safemode_delay may have bug
To:     Song Liu <song@kernel.org>
Cc:     NeilBrown <neil@brown.name>,
        linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <a29f8374-cc64-cc87-71cb-507c43aff503@suse.com>
 <87zh80wa71.fsf@notabene.neil.brown.name>
 <149fa87e-2c77-ec44-af15-b0ffc996c3df@suse.com>
 <CAPhsuW5SYO5B-DifzwpFvrnhe8UFuJ0Ds5kwspj1zAA7B6XHQA@mail.gmail.com>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <157669d7-0095-293c-3126-79f941f4318a@suse.com>
Date:   Thu, 16 Jul 2020 14:22:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <CAPhsuW5SYO5B-DifzwpFvrnhe8UFuJ0Ds5kwspj1zAA7B6XHQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.128.9) by HK2PR02CA0168.apcprd02.prod.outlook.com (2603:1096:201:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 06:23:07 +0000
X-Originating-IP: [123.123.128.9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bf6e6d3-ad80-482e-5847-08d82950b5e1
X-MS-TrafficTypeDiagnostic: DB7PR04MB4890:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4890FD02E6CCC9A72DC4379A977F0@DB7PR04MB4890.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcRks8TMs4pnQqBchjI0+MrzYMD/y7siigGwZKuGwq3mSSEvP0PfrVnEg86/DsEWwZqLa8VUUElJ1xeTs+svV6ZJI7J7NVtyONjAOLYy5w/tvE+MXFkJgfxG9WRb9GTnGiVXfykfkWw41iK8PH5eycolHjbuTTohNmythBNOjXptsbwmIyhNaiwMkZz0HRlpoCiPTCrMYKMweNcQLt4NDKE0QO9RoBSK11/tLAzOQdKmAwdFx2bWTPRCaz7hZK4Z3BXf5GOB5k0gsCtd9lbAGhTzjVU6rKVheQvUQY58RBQSne74y0YiPX5497Sg9M4XjlJg8MUKSH9/yvqGQKJlND/v5zIMZ1/4EpY0WTBUx5pP9iHbWZssj9BB6dR7Nrw98erHdke+Sdvy3jhHu2Tdww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(366004)(376002)(39860400002)(136003)(6512007)(66946007)(8936002)(66556008)(53546011)(956004)(6506007)(4744005)(8676002)(52116002)(2616005)(66476007)(36756003)(4326008)(31686004)(8886007)(16526019)(31696002)(186003)(5660300002)(6666004)(6916009)(478600001)(316002)(6486002)(2906002)(26005)(86362001)(54906003)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PRpD3Mz7fiiY0htRm7ZbMeHiD7m9cH11hE1pApoiAV0H4/CANvpHdm1MeG5yRr/fMAWmreXEaXnUEqYwAE+Ya0mt6m9Oa2cXNaSX5rDRRe6b0a8Mj9ffrHYCVcxARsBBV1ReUhY+pKizeJ9sCtL2V+mKznQfKLudTDI3Tl+UzNXsLnpHcyABalnkjgRe9FB+eyjjQTShq1DRDF5IQeeMui5cLXJhCOLwBslQebJUEAVjNFBYybWtwk6xMj/O5qDIkm//Ldm0jQYPAhhVyQExug1XTU6zglQsnKgnnXHQXTgaITwvsfVQRx93cT1G3dG0xXNDnekj1a+pY2eWgjrMOta9eAlIR+x6QGCRNg1AeJdMDFiIeY2ZXC6zxoBBl+uj5KQUUDOGziJUzK/JKxuhWTEFipeDTDjQb6q8TAzLeLj4s3IXSMzg5JLWgbgzy53Epaf1//VT4+7eiEdp6vNljlsDAKJeZjIU8CvWB4DHFqA=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf6e6d3-ad80-482e-5847-08d82950b5e1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 06:23:10.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nams5w3h0uKmjMlxXJNmWede2A5L+FqvqXazmUEEvVO+3lBBZJolnUcShOnnLYHV78/kO2hQ5e8ToOqDbcjOFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4890
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Ok. thank you for the information.

On 7/16/20 2:10 PM, Song Liu wrote:
> On Wed, Jul 15, 2020 at 10:53 PM heming.zhao@suse.com
> <heming.zhao@suse.com> wrote:
>>
>> Hello Neil,
>>
>> Thank you for your comments, you gave me great help.
>> I will file new patches according to your comments.
> 
> Thanks to Neil and Guoqing for these insightful inputs.
> 
> Hi Heming,
> 
> As Guoqing mentioned, I cover kernel part of the md work. For patches in
> mdadm, please CC Jes Sorensen.
> 
> Thanks,
> Song
> 
> [...]
> 

