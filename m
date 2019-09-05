Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39ACAA757
	for <lists+linux-raid@lfdr.de>; Thu,  5 Sep 2019 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390456AbfIEP3I (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Sep 2019 11:29:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388218AbfIEP3I (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 5 Sep 2019 11:29:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D11330821EC
        for <linux-raid@vger.kernel.org>; Thu,  5 Sep 2019 15:29:08 +0000 (UTC)
Received: from [10.3.118.53] (ovpn-118-53.phx2.redhat.com [10.3.118.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B2E419C69
        for <linux-raid@vger.kernel.org>; Thu,  5 Sep 2019 15:29:08 +0000 (UTC)
Subject: Re: raid6 with dm-integrity should not cause device to fail
From:   Nigel Croxon <ncroxon@redhat.com>
To:     linux-raid@vger.kernel.org
References: <9dd94796-4398-55c5-b4b6-4adfa2b88901@redhat.com>
 <fc3391a1-2337-4f9a-1f09-8a0882000084@redhat.com>
Message-ID: <7429a69e-0b27-53de-2ad8-01d8ebbc2bb4@redhat.com>
Date:   Thu, 5 Sep 2019 11:29:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fc3391a1-2337-4f9a-1f09-8a0882000084@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 05 Sep 2019 15:29:08 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/5/19 7:35 AM, Nigel Croxon wrote:
> On 6/20/19 7:31 AM, Nigel Croxon wrote:
>> Hello All,
>>
>> When RAID6 is set up on dm-integrity target that detects massive 
>> corruption, the leg will be ejected from the array.  Even if the 
>> issue is correctable with a sector re-write and the array has 
>> necessary redundancy to correct it.
>>
>> The leg is ejected because it runs up the rdev->read_errors beyond 
>> conf->max_nr_stripes (600).
>>
>> The return status in dm-crypt when there is a data integrity error is 
>> BLK_STS_PROTECTION.
>>
>> I propose we don't increment the read_errors when the bi->bi_status 
>> is BLK_STS_PROTECTION.
>>
>>
>>  drivers/md/raid5.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index b83bce2beb66..ca73e60e33ed 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -2526,7 +2526,8 @@ static void raid5_end_read_request(struct bio * 
>> bi)
>>          int set_bad = 0;
>>
>>          clear_bit(R5_UPTODATE, &sh->dev[i].flags);
>> -        atomic_inc(&rdev->read_errors);
>> +        if (!(bi->bi_status == BLK_STS_PROTECTION))
>> +            atomic_inc(&rdev->read_errors);
>>          if (test_bit(R5_ReadRepl, &sh->dev[i].flags))
>>              pr_warn_ratelimited(
>>                  "md/raid:%s: read error on replacement device 
>> (sector %llu on %s).\n",
>
>
> I'm up against this wall again.  We should continue to count errors 
> returned by the lower layer,
>
> but if those errors are -EILSEQ, instead of -EIO, MD should not mark 
> the device as failed.
>
>
https://securitypitfalls.wordpress.com/2018/05/08/raid-doesnt-work/

