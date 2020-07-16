Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4020A221C2D
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 07:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgGPFw3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 01:52:29 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:44860 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgGPFw2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Jul 2020 01:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594878744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPe9nL1JW7VitHaLGEOqJBN2LQ93t54W3n+j++c7oyo=;
        b=A7yBMTYk2Bxk3qezBsaYPERBu4gETEj6Jlhl1Duadx0F4WjEiLx5Z/fGARS5bUmwRnz0M9
        eHoRDlHIJ4bEZ7zCMKa7SHh0kv3gmMAYIBX3Ncmdqj4AUrRbDs6a7m2eEvzH463VIKJYIF
        Q4zCB0f1uGDH5KlETFUFgCFpweRM36A=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-Png8QS0_Nl6-TSAZ1EjpnA-2; Thu, 16 Jul 2020 07:52:23 +0200
X-MC-Unique: Png8QS0_Nl6-TSAZ1EjpnA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxg6bqPmo63Wmofu0oEWVCLmwlNmmnGwaSsgu24w/MPo7GobvAnMSujmwGN7zOPSaPnUl9bybJafi0pNDUfBFvQ90wV10mdBVnfRngC0vZHdOFk3+95GcIVSthT2NzQYr3wW6BLm5SdIIvVM48EIHkFxqHXI7aQy1EuDRrNUO2TmSZmDcYvWw+ZoUtzILT4mq7Y/XJ/RUOuNQ4jRnSrMdZG2nFGxXe8YQvTj8iTQsleubJBejUQiVI8vBU73VAbMT5UDNDRIB2Nq3rmk8Gq83/2aAqO+G/gxa09DRwqKBBHoN0c5imtfkXqGdb+50C2ovMYepY+n7yU99T6acjSqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPe9nL1JW7VitHaLGEOqJBN2LQ93t54W3n+j++c7oyo=;
 b=DN+g8AlQAp9knEuChTWGxGi5vTVegK30PZNqCdvBKQFR5xvW2KSDQdZLvJAvdnPkZJDoiT/AI1Bukt+sUzb6NIfN5xI7Bt0D0510BrUglDjlUGncKwUdmjAhDfW4sNsdBYLvHfEs3COVxeGOgAM34B88taq+WUmYdaIFEtCaWndcIyt5Q7AjWbeJAoD4xxlDDIYxjABxiKkXVmS5DrPrbHxum0ql0pSPeOcN8rUqQdj5/LL14H9mxEhDzzjUiXGb4NqXPG6QDAzFOoW1UaTFH4j+mjYeqDE6v9ZvB6bxM0E5Gs7Qk3LQ1uXJSV5PA4XRjjBTexBqDYiO6+lRERzGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB4059.eurprd04.prod.outlook.com (2603:10a6:5:17::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18; Thu, 16 Jul 2020 05:52:20 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 05:52:20 +0000
Subject: Re: cluster-md mddev->in_sync & mddev->safemode_delay may have bug
To:     NeilBrown <neil@brown.name>, linux-raid@vger.kernel.org
Cc:     neilb@suse.com, guoqing.jiang@cloud.ionos.com
References: <a29f8374-cc64-cc87-71cb-507c43aff503@suse.com>
 <87zh80wa71.fsf@notabene.neil.brown.name>
From:   "heming.zhao@suse.com" <heming.zhao@suse.com>
Message-ID: <149fa87e-2c77-ec44-af15-b0ffc996c3df@suse.com>
Date:   Thu, 16 Jul 2020 13:52:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <87zh80wa71.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:c8::13) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.128.9) by HKAPR03CA0008.apcprd03.prod.outlook.com (2603:1096:203:c8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend Transport; Thu, 16 Jul 2020 05:52:18 +0000
X-Originating-IP: [123.123.128.9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab3b2e42-8e18-4ae6-d9b7-08d8294c6778
X-MS-TrafficTypeDiagnostic: DB7PR04MB4059:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB40595AA0F1F55EF067F06660977F0@DB7PR04MB4059.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ma5uFyeCJQiZzfRTeUkU0DBPEXr3oyF+reOBtreGZesGTZqcKYO9sTKU8EKDmXIRKYN9XJHYluENL02rrG9lqzCD2KaHSD5hkxOzRj134f1ZEJaJgaFHQ9RPdjYb+nx1kVWeLJMMZvQy5aXuDIm2yZbxIIJhYQpYaGJazo0GVMYO6fScT5kBpfr1l43Hp4crgEwLnautSmqxA/1JHzpQ1g/WQW5O61uAt9o8v7K1pM7LcL8L2DG01XwR6UJmfUrPZPtbHRuyAO3XODfAzDSC0qc965DiRu/wFSHcJ+HUjz6B01cJJwCs6NO+A6Ctq4o3m7LH/TYYX3f1e4kP+60yj/R5td3avUafQSO35JBjngn+FRvcqnN6Mx3Af/jQ+kgqMYDM9gg1ZE1mQrOWqeCLFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(83380400001)(6666004)(186003)(16526019)(31696002)(36756003)(31686004)(8936002)(8676002)(86362001)(956004)(6486002)(26005)(53546011)(2616005)(6506007)(52116002)(5660300002)(478600001)(4326008)(2906002)(8886007)(6512007)(66476007)(66556008)(66946007)(316002)(9126004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vbzvL3lKRZMRVMvdqbDOvRkqsZVzZ1PrwjxIsRLnrfR9XeMLKxePSv9TbOUuna6kxtVCGXgzXlgGhfen4O9lTEbSIpMix7fx3TPnHv5048al3OO7xZw1XQrOamrkc52ho8mtJQ49kqLRSpkFYLYF2RzVj7Qly10JJ1z1al9Wri4ZJXkquLgm4RyOy9jh+08sfmjutm+h88AOeqy3qaE6tEo2ZLxy0d+j3nnMZogxTcmx736JXcAB2/tg1OPp/CsZ3Y9xjDFlR7Gw4h9tbAH29GGZgdwFUXxh51FSc7hIXrEa7N9jprpPtrg0E0tZpO913KPLSidNSIMmGzBuZBumefEZum7qo0NCg2zWW3TdE4+e2OuEVGfVpsLRDDZvGpbXFGhbO8XUXSdJ+t7m0Uy2dbgidh+PZsucKoG7Goi9VJYCL0/O7DqpBtYNM8V7Pf1kQycuPeheg4GM4cTMmhUNRGQqcl40mdnwfeAuCkq5rRk=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3b2e42-8e18-4ae6-d9b7-08d8294c6778
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 05:52:20.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flOeGzbgzwp1R7pIHEMQ2SfZKIEN3I0Gj/OWGs6ioWqTg8utPTGmC0NyOOWeUBLklz4fjv5dFM1/amCg4kXk6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4059
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Neil,

Thank you for your comments, you gave me great help.
I will file new patches according to your comments.

On 7/16/20 8:54 AM, NeilBrown wrote:
> On Wed, Jul 15 2020, heming.zhao@suse.com wrote:
> 
>> Hello List,
>>
>>
>> @Neil  @Guoqing,
>> Would you have time to take a look at this bug?
>>
>> This mail replaces previous mail: commit 480523feae581 may introduce a bug.
>> Previous mail has some unclear description, I sort out & resend in this mail.
>>
>> This bug was reported from a SUSE customer.
> 
> I think my answer would be that this is not a bug.
> 
> The "active" state is effectively a 1-bit bitmap of active regions of
> the array.   When there is no full bitmap, this can be useful.
> When this is a bit map, it is of limited use.  It is just a summary of
> the bitmap.  i.e. if all bits in the bitmap are clear, then the 'active'
> state can be clear.  If any bit is set, then the 'active' state must be
> set.
> 
> With a clustered array, there are multiple bitmaps which can be changed
> asynchronously by other nodes.  So reporting that the array not "active"
> is either unreliable or expensive.
> 
> Probably the best "fix" would be to change mdadm to not report the
> "active" flag if there is a bitmap.  Instead, examine the bitmaps
> directly and see if any bits are set.
> 
> So if MD_SB_CLEAN is set, report "clean".
> If not, examine all bitmaps and if they are all clean, report "clean"
> else report active (and optionally report % of bits set).
> 
> I would recommend against the kernel code change that you suggest.
> 
> For the safemode issue when converting to clustered bitmap, it would
> make sense for md_setup_cluster() to set ->safemode_delay to zero
> on success.  Similarly md_cluster_stop() could set it to the default
> value.
> 
> NeilBrown
> 
> 
>>
>> In cluster-md env, after below steps, "mdadm -D /dev/md0" shows "State: active" all the time.
>> ```
>> # mdadm -S --scan
>> # mdadm --zero-superblock /dev/sd{a,b}
>> # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda /dev/sdb
>>
>> # mdadm -D /dev/md0
>> /dev/md0:
>>              Version : 1.2
>>        Creation Time : Mon Jul  6 12:02:23 2020
>>           Raid Level : raid1
>>           Array Size : 64512 (63.00 MiB 66.06 MB)
>>        Used Dev Size : 64512 (63.00 MiB 66.06 MB)
>>         Raid Devices : 2
>>        Total Devices : 2
>>          Persistence : Superblock is persistent
>>
>>        Intent Bitmap : Internal
>>
>>          Update Time : Mon Jul  6 12:02:24 2020
>>                State : active <==== this line
>>       Active Devices : 2
>>      Working Devices : 2
>>       Failed Devices : 0
>>        Spare Devices : 0
>>
>> Consistency Policy : bitmap
>>
>>                 Name : lp-clustermd1:0  (local to host lp-clustermd1)
>>         Cluster Name : hacluster
>>                 UUID : 38ae5052:560c7d36:bb221e15:7437f460
>>               Events : 18
>>
>>       Number   Major   Minor   RaidDevice State
>>          0       8        0        0      active sync   /dev/sda
>>          1       8       16        1      active sync   /dev/sdb
>> ```
>>
>> with commit 480523feae581 (author: Neil Brown), the try_set_sync never true, so mddev->in_sync always 0.
>>
>> the simplest fix is bypass try_set_sync when array is clustered.
>> ```
>>    void md_check_recovery(struct mddev *mddev)
>>    {
>>       ... ...
>>           if (mddev_is_clustered(mddev)) {
>>               struct md_rdev *rdev;
>>               /* kick the device if another node issued a
>>                * remove disk.
>>                */
>>               rdev_for_each(rdev, mddev) {
>>                   if (test_and_clear_bit(ClusterRemove, &rdev->flags) &&
>>                           rdev->raid_disk < 0)
>>                       md_kick_rdev_from_array(rdev);
>>               }
>> +           try_set_sync = 1;
>>           }
>>       ... ...
>>    }
>> ```
>> this fix makes commit 480523feae581 doesn't work when clustered env.
>> I want to know what impact with above fix.
>> Or does there have other solution for this issue?
>>
>>
>> --------
>> And for mddev->safemode_delay issue
>>
>> There is also another bug when array change bitmap from internal to clustered.
>> the /sys/block/mdX/md/safe_mode_delay keep original value after changing bitmap type.
>> in safe_delay_store(), the code forbids setting mddev->safemode_delay when array is clustered.
>> So in cluster-md env, the expected safemode_delay value should be 0.
>>
>> reproduction steps:
>> ```
>> # mdadm --zero-superblock /dev/sd{b,c,d}
>> # mdadm -C /dev/md0 -b internal -e 1.2 -n 2 -l mirror /dev/sdb /dev/sdc
>> # cat /sys/block/md0/md/safe_mode_delay
>> 0.204
>> # mdadm -G /dev/md0 -b none
>> # mdadm --grow /dev/md0 --bitmap=clustered
>> # cat /sys/block/md0/md/safe_mode_delay
>> 0.204  <== doesn't change, should ZERO for cluster-md
>> ```
>>
>> thanks

