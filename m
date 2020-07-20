Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9687D22634A
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGTP17 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jul 2020 11:27:59 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:32133 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgGTP17 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Jul 2020 11:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595258875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bk1l69xhgKld3MSMU6XI5JxsUY4phmifrobCxG2KB1w=;
        b=TGOFXapr2XtUTwH0hpgH0wHAfTkOSsdTQkuOmd78S2Om/k9u/7lZUVN13bSC9ioILa4HKN
        JahHBT+Vc0xot3JUoPdwGYG2njTvcaC+NdDOuwc8ZHCJH5lpWDVEFYh+fUwWzbR4BHCspY
        aq3PenDRlaJfPtxSWsbHT2rKvcFG1wE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-9wwlwSd0Mf6LbbTwWnTTvw-1; Mon, 20 Jul 2020 17:27:53 +0200
X-MC-Unique: 9wwlwSd0Mf6LbbTwWnTTvw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eciezvBtzLV1/1x7tU7NzXjF7zwVqKt2/MuR/W8spjXL/Pm3IXu8CYXFXtVb69sH6dpW9i4PIoLDhwrvEXovzZbSfKCeerWvxmqSf+Dn9r6JxJWCm3ENwqP0JZWab8aBOfKLbkKMNGGW6dU6LUlW86CIguX+a90Jsal+4TukGcZgcL5rIqwfZ/KgZxYeDS4p8t0Bx5Pn72sfgd4PwiNEhfQeEasJ6aZoDoQT5j0SFF7NYV7t7d9kaPjJLRjzv94cjdlnG8eONoLLDzpTZeUtqh+0H3MtT0vA7PI5KrhLjisfPq78wfR40gKmsbKPTlPFMxtdDzM6Fk/eKr69mKtLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk1l69xhgKld3MSMU6XI5JxsUY4phmifrobCxG2KB1w=;
 b=JspWmaJ4RfiRwCfpuXSW3bDNWJsTbyi+n/KcPEsrALf1mWfes+UqDdLXZmhLbbo3S3AkNWX+E1snM4adbFJWzEzQ/+3Q+gQ//9G9cO6/4g9NhjpPJW6cjdsyBu+dNTiaOt1FGFb/Xvs7TgLL2B4ghmQgSzIqKAOWZ+SO/u7oiddyaB9JjgpvA2uOLaJHFcrFYR8FngHDpEAklenOWnBI0uYPjRFb1peKwvWs9ziEPzLUGxyNuEsz3FPY4LmmpxIpCT5xcLPuylyLClp9+P5WcDzJ9UHbzVyOJrCSMQUiRWtTALTcjE2jQ4UWUkFPIcmKBx5MT/2Qf06UAw+u+pEeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: trained-monkey.org; dkim=none (message not signed)
 header.d=none;trained-monkey.org; dmarc=none action=none
 header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18; Mon, 20 Jul 2020 15:27:51 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 15:27:51 +0000
Subject: Re: [PATCH v4 2/2] md-cluster: fix rmmod issue when md_cluster
 convert bitmap to none
To:     NeilBrown <neil@brown.name>, linux-raid@vger.kernel.org
Cc:     neilb@suse.com, jes@trained-monkey.org
References: <1595156920-31427-1-git-send-email-heming.zhao@suse.com>
 <1595156920-31427-3-git-send-email-heming.zhao@suse.com>
 <87h7u3w0gj.fsf@notabene.neil.brown.name>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <5152d463-01ca-4a9f-21bf-25ec0af8589e@suse.com>
Date:   Mon, 20 Jul 2020 23:27:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87h7u3w0gj.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14 via Frontend Transport; Mon, 20 Jul 2020 15:27:49 +0000
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 035c703a-0d11-4728-7c6a-08d82cc1775c
X-MS-TrafficTypeDiagnostic: DB7PR04MB4666:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB466616DA26FBB7DD47822524977B0@DB7PR04MB4666.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2y/33qqyziJepWEG01WIuGAqAhCeZmqomhkW2elYnDeso8IswtbfjjBlF1vWOdLJJe1rcwCXrgUGe036ynsrmEtPIH+WJOKqp5HRPyRaI823lud6it3EsAIWCP392LCzwmgUOq+mZRMMMUTRkSQiA+OSBX3jAjFKz+O4HUgyjeZbf77bztAIR1fMiyMfWfDg3Ywa71JF6OxJo8hGMPz/rW6pnn75sjnU5xY/sONGFqrsY8DzJnrI0rM/cpPSCqBGbrtjnBUabdkgDfXLegb16f7+O0qOXYYzm5Ye1xAaeaL/Qk/W9VfKQCe82rGcH6pW++tKr+lI1FnmxgWL4EXG4Styv7XCbd5iWLFiZyzfo1ncb4nd+C9Riz1v8ckNhkLYizcriB+D3SGLeVt86IoquQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(396003)(136003)(346002)(366004)(66946007)(66476007)(66556008)(956004)(83380400001)(478600001)(8676002)(2616005)(8886007)(4326008)(5660300002)(6512007)(53546011)(8936002)(31686004)(186003)(6506007)(6486002)(36756003)(31696002)(316002)(52116002)(26005)(16526019)(6666004)(2906002)(86362001)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JtizhLXSKQntqI+EeNUByOWhsQCiViR2Rle5mjm2K1aFnLauLfvRo0HBrLqtp7ULOJhohl53F5Iq7gNTZdpC68kjIVk1w0s0DjHVeQIbzAewZBg/Mp6UALHtee4ZAIPqnWEkSf2lWbAH1QXueoVDZjjl06fd/NIRTAnC6HbxchOLGVNoA5Rzgwak5yTPsh8HzjZXoL+hPaUcMVL0zdQ//nrh0TyWTgDxs/xvox8+rT6uyYIhbstr1WEGgzYVW3WPt8QFWHPh/zXE1yDe66lLP0Qhas6bizCrlrXCTLw6wYfxpHkjM9FwrJFsuCugMqfzFUDOWKIekg2ISlSCBp4ZoJfTeXwVRXk4SItD3NphQ+EuMxvlMC5skh3uU96FinCSJ8W1ye+ri/r5UK+XRoWy6/Noi0Svu6Vo1cjZ2a3SuLCpO1RKcuo4sGPHsdL9BpqXNYAbDRdjgS7sbnJGWLD5sPzAA1xN6PeP3wMfcWLifQA=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035c703a-0d11-4728-7c6a-08d82cc1775c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 15:27:51.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqEqbJjSBBKitT74i8SntcXuKSBedDEdeKeMouTIAA1+8rl4Ow/QBMQ6ivARTNLNrOgKRccDLL4+3H+cQAh/1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4666
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/20/20 7:26 AM, NeilBrown wrote:
> On Sun, Jul 19 2020, Zhao Heming wrote:
> 
>> update_array_info misses calling module_put when removing cluster bitmap.
>>
>> steps to reproduce:
>> ```
>> node1 # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda
>> /dev/sdb
>> mdadm: array /dev/md0 started.
>> node1 # lsmod | egrep "dlm|md_|raid1"
>> md_cluster             28672  1
>> dlm                   212992  14 md_cluster
>> configfs               57344  2 dlm
>> raid1                  53248  1
>> md_mod                176128  2 raid1,md_cluster
>> node1 # mdadm -G /dev/md0 -b none
>> node1 # lsmod | egrep "dlm|md_|raid1"
>> md_cluster             28672  1 <== should be zero
>> dlm                   212992  9 md_cluster
>> configfs               57344  2 dlm
>> raid1                  53248  1
>> md_mod                176128  2 raid1,md_cluster
>> node1 # mdadm -G /dev/md0 -b clustered
>> node1 # lsmod | egrep "dlm|md_|raid1"
>> md_cluster             28672  2 <== increase
>> dlm                   212992  14 md_cluster
>> configfs               57344  2 dlm
>> raid1                  53248  1
>> md_mod                176128  2 raid1,md_cluster
>> node1 # mdadm -G /dev/md0 -b none
>> node1 # mdadm -G /dev/md0 -b clustered
>> node1 # lsmod | egrep "dlm|md_|raid1"
>> md_cluster             28672  3 <== increase
>> dlm                   212992  14 md_cluster
>> configfs               57344  2 dlm
>> raid1                  53248  1
>> md_mod                176128  2 raid1,md_cluster
>> ```
>>
>> Signed-off-by: Zhao Heming <heming.zhao@suse.com>
>> ---
>>   drivers/md/md.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index e20f1d5a5261..ca791387e54d 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -7363,6 +7363,7 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
>>   
>>   				mddev->bitmap_info.nodes = 0;
>>   				md_cluster_ops->leave(mddev);
>> +				module_put(md_cluster_mod);
>>   				mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
> 
> I would make this a call to "md_cluster_stop()", and move the reset of
> ->safemode_delay" in there, but either way this is correct and needed.
> 
>    Reviewed-by: NeilBrown <neilb@suse.de>
> 
> Thanks,
> NeilBrown
> 
Thank you for your review.
If put module_put() in md_cluster_stop(), "mddev->bitmap_info.nodes = 0" also needs to put in md_cluster_stop().
the "bitmap_info.nodes = 0" makes mddev_is_clustered() false and will close the door to call md_cluster_stop().

> 
>>   			}
>>   			mddev_suspend(mddev);
>> -- 
>> 2.25.0

