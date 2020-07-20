Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022DC226918
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbgGTQDZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jul 2020 12:03:25 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:23581 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732440AbgGTQDX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Jul 2020 12:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595261000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPCSK5esa++CReslbbbJl9TJU4EB+wgkbrl9hjesA/A=;
        b=j7SS2jw5Di1UNNWrjo5YMA4ULXue1Elc6i2U/LAX5GyFdVqGQxDPpnDwvK8S4tPXnPrnHD
        /CSpqZooN9/EPfkfBr46VaJ4s2DEiJBAItyFyqKd5sjSwsBQOzdCDpafdblHkAg0rEtFvm
        Fyux49v31/2INA3GX/z9GfQoifkWhtM=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2052.outbound.protection.outlook.com [104.47.0.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-SSiqNvY1MKmSfnCtkau_TQ-1; Mon, 20 Jul 2020 18:03:19 +0200
X-MC-Unique: SSiqNvY1MKmSfnCtkau_TQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y82bLE/VVO+F6/dCtMoRtllN6bMMEW1TBCfxA64OonVbFmnr89Fh8hq5lljNkpyeHsgYZTMaDMrWdQtXQXwA9XtUJTUBMD5DxMXFClZLuFZUkNty8yHDNTiOAC/TMj6t3UN8nG0RTFziS0ShREMaUF25/07+NR+6Jlco5SSNMJhBzQxLxB5H8eb8vsULS0zl4N+jDGBwVEnjg+ZNJXh/X9WxzZbKmI78BSx5gFORtfXm1qTa90DTjxfAYUUTFtdLbGuWBap2Libmf1x7sJPWQfJF5iVMGf5AAByYzbnnRsMcJOO39bpWjWYxnosjkfyEOIbmd6FJtjjwK8Eu7qJDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPCSK5esa++CReslbbbJl9TJU4EB+wgkbrl9hjesA/A=;
 b=J2W6YwL5Fxd7T/oE9iB1HfUlZYzcObDOekpcC4TXFp9z/zZo4pM78vzNfLiPilkMFGXdh0v4+yMAZHEqU4d+dyjqDkM4shaal1MrfuLdrEUUnC2ST1eVo2MvCjHdC/p+hbVPR7KFnPzRHg7+6pMkdu3tPVoTp1Zw8pZMWh2xydeJzjnTAbRoansrjdhDg5H9huIcp6ply3MJ8btPmDR17wWW8QpqnbwaWJAQwssnBXAUDU/W5i78Twrt4pAWse3W3WqMh5rmoiPU5ykY4BssIarNz5WbqTVYd6LGHgyvQNB/58vglYaRlWn35YYSyUyxo3Y50Y/ZzIwL4G9YqqqMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB4442.eurprd04.prod.outlook.com (2603:10a6:5:35::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Mon, 20 Jul 2020 16:03:17 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 16:03:17 +0000
Subject: Re: [PATCH v4 1/2] md-cluster: fix safemode_delay value when
 converting to clustered bitmap
To:     NeilBrown <neil@brown.name>, linux-raid@vger.kernel.org
Cc:     neilb@suse.com
References: <1595156920-31427-1-git-send-email-heming.zhao@suse.com>
 <1595156920-31427-2-git-send-email-heming.zhao@suse.com>
 <87k0yzw0km.fsf@notabene.neil.brown.name>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <dac17854-04e6-de79-f0a1-e6a200a13771@suse.com>
Date:   Tue, 21 Jul 2020 00:03:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87k0yzw0km.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 16:03:15 +0000
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d860a086-98c4-477d-c352-08d82cc66a15
X-MS-TrafficTypeDiagnostic: DB7PR04MB4442:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB44421B31AA5C5EF43CEF1E15977B0@DB7PR04MB4442.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnNjjZoX98+Fbzy9Fdb4HpfxdZgKGuzvyvsRfWiCJBCoBxVW2oSpEj0feXA9QAoDr4keaMkOGf0v+3h5leJrmP5odn3+aK8tqZ5GxOzO0Zg7mqweAwGksRBvy3fuF4b+HXQIvMAOfC8BQ3qdsrd0GJebMYt/qiJUbgcVPov9K/QgsCCPpiDwJbHSd0QuwoS48Q6Z8X5HHtC67rbvV7WYsCaoYYYeaaZHgYErJ1M73QgTzJpGFaSo1Ndzbjuzlrk0Vo76Lgz+wGcmzWqScNkD3xgpdWXBFfegap+GG+HNGP+N7+4Ml/gUYzsy3MN49WfQR7py7s2zSDJbPadEBFyfBCpHv9KN9izbe+Wv/pDX2RX/HefFV90EUOzgKUJW72GfqUw8TmFFnC0v7sWNmyfKSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(376002)(366004)(346002)(136003)(8676002)(36756003)(16526019)(86362001)(8936002)(2906002)(66946007)(26005)(6486002)(186003)(8886007)(5660300002)(83380400001)(316002)(4326008)(2616005)(956004)(478600001)(53546011)(6512007)(6506007)(66556008)(66476007)(31696002)(31686004)(52116002)(107886003)(6666004)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7XedcrVwlnEbXf+uv9L+tUn/L/a0sQdRebQr695JC9KL9WZpm9PQ4r2i3Kp7iMUiz5opwXOk3Pzhl1oHMbxlp1hu8VZ5hfThx914+a5YpjRMKKRQvZOfgzrSxtIL24TK7/E6KIwh507V1ux0OvwYmSrYSRl5mAbb8FWlx1UHQQfEPEdSBg8UU2qkm9OcoQNIok7ugge2IG6mSdyhDDTY6+Jnu+ZXgSa1geKpcSq5JIE9UVaqEn28Y2DebtQRD+xTxUSheJ0pNALNXYn6BBgrEfaH4poXCMiKlhakTLK/TiCsltiBd/ztEkvXSJMitN1qHITA5WkQfh4HlxCuSPSQ8uq11H7DqhFd1imCUSxhTBQbLSn01QhzFi+99ofP67dBW17LeE14Evytg+SUacV/UJRjhBpuCv2D/VPpN2XgyOLsEotOx/Q4Fo1ic1kU91OPTu8taJz3DTh6rzyeGzECtJaIZpGZR/2XY7D68BgUSHg=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d860a086-98c4-477d-c352-08d82cc66a15
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 16:03:16.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwBuT+e0HPhCwkDnSNjH25OwTa/URCKX75/zL0HmSWr3seHhFCDN1MVygv8D/YU7jZjnkU6I4nTuYr932Qr0ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4442
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/20/20 7:24 AM, NeilBrown wrote:
> On Sun, Jul 19 2020, Zhao Heming wrote:
> 
>> When array convert to clustered bitmap, the safe_mode_delay doesn't clean and vice versa.
>> the /sys/block/mdX/md/safe_mode_delay keep original value after changing bitmap type.
>> in safe_delay_store(), the code forbids setting mddev->safemode_delay when array is clustered.
>> So in cluster-md env, the expected safemode_delay value should be 0.
>>
>> reproduction steps:
>> ```
>> node1 # mdadm --zero-superblock /dev/sd{b,c,d}
>> node1 # mdadm -C /dev/md0 -b internal -e 1.2 -n 2 -l mirror /dev/sdb /dev/sdc
>> node1 # cat /sys/block/md0/md/safe_mode_delay
>> 0.204
>> node1 # mdadm -G /dev/md0 -b none
>> node1 # mdadm --grow /dev/md0 --bitmap=clustered
>> node1 # cat /sys/block/md0/md/safe_mode_delay
>> 0.204  <== doesn't change, should ZERO for cluster-md
>>
>> node1 # mdadm --zero-superblock /dev/sd{b,c,d}
>> node1 # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sdb /dev/sdc
>> node1 # cat /sys/block/md0/md/safe_mode_delay
>> 0.000
>> node1 # mdadm -G /dev/md0 -b none
>> node1 # cat /sys/block/md0/md/safe_mode_delay
>> 0.000  <== doesn't change, should default value
>> ```
>>
>> md_setup_cluster() is a good place for setting, but md_cluster_stop is
>> good for clean job when md_setup_cluster return err.
>>
>> see below flow:
>> (user space)
>> mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda /dev/sdb
>> mdadm --grow /dev/md0 -b none
>> (kernel space)
>> SET_ARRAY_INFO
>>   update_array_info
>>    + mddev->bitmap_info.nodes = 0;
>>    + md_cluster_ops->leave(mddev)
>>    + md_bitmap_destroy
>>       md_bitmap_free //won't trigger md_cluster_stop() because above set 0.
>>
>> Signed-off-by: Zhao Heming <heming.zhao@suse.com>
>> ---
>>   drivers/md/md.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index f567f536b529..e20f1d5a5261 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -101,6 +101,8 @@ static void mddev_detach(struct mddev *mddev);
>>    * count by 2 for every hour elapsed between read errors.
>>    */
>>   #define MD_DEFAULT_MAX_CORRECTED_READ_ERRORS 20
>> +/* Default safemode delay: 200 msec */
>> +#define DEFAULT_SAFEMODE_DELAY ((200 * HZ)/1000 +1)
>>   /*
>>    * Current RAID-1,4,5 parallel reconstruction 'guaranteed speed limit'
>>    * is 1000 KB/sec, so the extra system load does not show up that much.
>> @@ -5982,7 +5984,7 @@ int md_run(struct mddev *mddev)
>>   	if (mddev_is_clustered(mddev))
>>   		mddev->safemode_delay = 0;
>>   	else
>> -		mddev->safemode_delay = (200 * HZ)/1000 +1; /* 200 msec delay */
>> +		mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
>>   	mddev->in_sync = 1;
>>   	smp_wmb();
>>   	spin_lock(&mddev->lock);
>> @@ -7361,6 +7363,7 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
>>   
>>   				mddev->bitmap_info.nodes = 0;
>>   				md_cluster_ops->leave(mddev);
>> +				mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
>>   			}
>>   			mddev_suspend(mddev);
>>   			md_bitmap_destroy(mddev);
>> @@ -8366,6 +8369,7 @@ int md_setup_cluster(struct mddev *mddev, int nodes)
>>   	}
>>   	spin_unlock(&pers_lock);
>>   
>> +	mddev->safemode_delay = 0;
>>   	return md_cluster_ops->join(mddev, nodes);
> 
> I still don't think you should change safemode_delay here until after
> ->join succeeds.
> 
> NeilBrown
you are right, it makes a gap to set delay to zero before join().
I will following your comments.
> 
>>   }
>>   
>> @@ -8375,6 +8379,7 @@ void md_cluster_stop(struct mddev *mddev)
>>   		return;
>>   	md_cluster_ops->leave(mddev);
>>   	module_put(md_cluster_mod);
>> +	mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
>>   }
>>   
>>   static int is_mddev_idle(struct mddev *mddev, int init)
>> -- 
>> 2.25.0

