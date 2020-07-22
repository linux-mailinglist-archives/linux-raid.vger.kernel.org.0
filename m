Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD9229205
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbgGVHU1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 03:20:27 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:37217 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732020AbgGVHU0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 03:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595402422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUgDpyqi49W2nuYam3+xPPs27O+0SNZt9LVskOsqyRA=;
        b=m1AmU9bdSLyQCrRwqoQOc5u7YjtIWbSevy2PMXCCLRVybF1b6OtV/rqDVQlCOTkUHhNaAw
        XdmN2TcillQbY495jqYYEU2b9CKxzMBV0Cb8hfs3dUQP+gH6pamynlz6wMPJOICWxE44vP
        0pCxGlRvem8DsSdvz7zy3iajcjV+SEY=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-TCXVifE5NjWXQwqUs9YObg-2; Wed, 22 Jul 2020 09:20:21 +0200
X-MC-Unique: TCXVifE5NjWXQwqUs9YObg-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/ObgU3wL3x2WR8q5PX9SGMgPzY91U6InWptpAz9NnxDOzwhp7HU6vTGgUB56WL49BbjuGmJYzCnxhrVBALhvMHa0quwXkBPhyOXi5jMawYakCkeqAVcu5bwVPHACZVP9ySEYGSHZWcD/ob/3tHHj614PSThtSNjdtxO15tW7sGJgFkKEKMt60YD9kTxOufCMH2u/MQ1pd7z5boWzLUDTIwxaMI5zcblcED2ae0YaurNZCnsaXE2YE1JkIg9IdbVXu/1bdLLGdebby7ydKdC7sAle+4MHo4s1UUsSKv+B7a0eFkHQJpczBBH2YKFvUSfs+qSVnn6UgCv8kEucfkzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUgDpyqi49W2nuYam3+xPPs27O+0SNZt9LVskOsqyRA=;
 b=bxYUpV+q8+fhdCSj/3UBYJRcDmx3V6tzirt/FgVqTA6vU4GS/Nt6tJQWo+d1ooRa/MzO2uxKvgA/k7mcsTMXfO5YogSZ+lomeK78WyjaEbsADwvGsYXoAsgG6DAhSBFFj+6tKdF3QwtNGviovctz8OfcwWvCDmDPHwISEYHZ2QlPlqn0HFfEjc65uw0PbpXzZWxcGTPzA+DM80ZIh1GqYx0QfR58bheGgHlhhhz4/v5H0HD2TP+jgkcLIoZKNcqhc8ytnvGOJZWC5SFdlba9Q/Eu2CzXDEv4PJqgg1Tmm4xJdhXONZqvLR7pxXCZcfCp6vUlxpW8SK643G4xslLbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: trained-monkey.org; dkim=none (message not signed)
 header.d=none;trained-monkey.org; dmarc=none action=none
 header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB6PR0401MB2440.eurprd04.prod.outlook.com (2603:10a6:4:34::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.23; Wed, 22 Jul 2020 07:20:17 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 07:20:17 +0000
Subject: Re: [PATCH v2] mdadm/Detail: show correct state for cluster-md array
To:     linux-raid@vger.kernel.org
Cc:     neilb@suse.com, jes@trained-monkey.org
References: <1595401905-3459-1-git-send-email-heming.zhao@suse.com>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <7697b7eb-76f9-8102-a490-1684e5f18acf@suse.com>
Date:   Wed, 22 Jul 2020 15:20:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1595401905-3459-1-git-send-email-heming.zhao@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:203:c8::7) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HKAPR03CA0002.apcprd03.prod.outlook.com (2603:1096:203:c8::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.17 via Frontend Transport; Wed, 22 Jul 2020 07:20:15 +0000
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d62a216d-6ab3-442b-330d-08d82e0faf48
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2440:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2440E6D5FAB939A6474EC25397790@DB6PR0401MB2440.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kj00YeSR3LqaLxcEJl3PjLlx6zyvxmbnrI2RoyM9LnSUg3P3b+Lcry3R9p+6Bzzv+wSkBZC//M9VncZUtEOsqWpKodBCqii5VhnZrxAS76GrFDfSCpMnRcrJdj2oRojG8moWWIB/1G2SyteGP6Laj6pI0s9vIFh6udP8NHBJQhZcIb7d8L8RKISQxaBdX11PK4tvmV7U1rbKYLDvswPxzHdzMb7i6O6CG06GVVnRSpSTBWBaj8qQIWk7ARGY3GvrgaOYdHNq00GRD9SwSiSqnryEP96tOWaqLNItI3eOvauXtv6B4u8k5OnyTrsTLsQ6WCSP/+oVe6Y1ZUULFNAwngwf5HIPOaP/DMhmURE7SOq3KCzj5A92voaik/LKWuEcdWJcWsXqa0HD8ZVi6LcrPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(39850400004)(136003)(376002)(396003)(5660300002)(6486002)(16526019)(66556008)(31686004)(66476007)(66946007)(31696002)(36756003)(6666004)(2906002)(26005)(478600001)(8886007)(8676002)(8936002)(6506007)(86362001)(316002)(53546011)(6512007)(956004)(4326008)(186003)(2616005)(6916009)(52116002)(4744005)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hCFMsjsvB2/Wjf/NaYjnlAHLTuSyNtLNEwug/kBPXH82wUSipgHr5IKXuO71IP4q6GHsn6XAPlEt1nON16kPwG8O8W67g45qDlgCMlpvvcKGt8MEpWCNpebkMNDXD2TwXQxl6/+uTrZLLjK1//zU5xAANmRBGIf24unfu68epvesrIabNimqu05BrOh3mz1tys26HFNYAXKBWjAme73QGWNRX5ziR2OdWTSIGFCo9p6gwwnGLJyDoCU3H19KjTVpEXSYtc2tXjyBa3TBWCyAQoE18aKH4s+kmX/odTdG+F27LX6+KVFCcbTBlX9MMSRVqloAjYdoq4nF1NXiJfjITzVGBsUlM7970hbJwSzmddgAbKlhUZnUiX7fFUleEd/y9rZRb2sdOq63vqGQTTAHaCLkP0kMNTlcJpWYlx63azSqg9Fq+k6NPIw/xQBVQirSainB23Pbx2dY8t3TShYBWYtkpS0EXdWcxgv3mSEYy3c=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62a216d-6ab3-442b-330d-08d82e0faf48
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 07:20:17.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4vSgz3LbZOmc8G2oG6KZr+eoihP06Y3VX1BrKX4wNfV8zriXrulcAY3PRtIozCqjfoQmo3dTax4v3EJInUlhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2440
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

During I was creating patch, I found the ExamineBitmap() has memory leak issue.
I am not sure whether the leak issue should be fixed.
(Because when mdadm cmd finish, all leaked memory will be released).
The IsBitmapDirty() used some of ExamineBitmap() code, and I only fixed leaked issue in IsBitmapDirty().

Thanks,
heming

On 7/22/20 3:11 PM, Zhao Heming wrote:
> After kernel md module commit 480523feae581, in md-cluster env,
> mddev->in_sync always zero, it will make array.state never set
> up MD_SB_CLEAN. it causes "mdadm -D /dev/mdX" show state 'active'
> all the time.
> 
> bitmap.c: add a new API IsBitmapDirty() to support inquiry bitmap
> dirty or clean.
> 
> Signed-off-by: Zhao Heming <heming.zhao@suse.com>
> ---
> v2:
> - Detail.c: change to read only one device.
> - bitmap.c: modify IsBitmapDirty() to check all bitmap on the selected device.
> 

