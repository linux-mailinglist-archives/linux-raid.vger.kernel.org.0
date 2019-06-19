Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8034B085
	for <lists+linux-raid@lfdr.de>; Wed, 19 Jun 2019 05:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFSDyt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 23:54:49 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:36222 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSDyt (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Tue, 18 Jun 2019 23:54:49 -0400
Received: from linux-fcij.suse (prva10-snat226-1.provo.novell.com [137.65.226.35])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 18 Jun 2019 21:54:40 -0600
Subject: Re: [PATCH 1/5] md/raid1: fix potential data inconsistency issue with
 write behind device
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190614091039.32461-1-gqjiang@suse.com>
 <20190614091039.32461-2-gqjiang@suse.com>
 <CAPhsuW6eYaqxmHzHeu8UzXXx+DH-2FkEtQcWfvHp-YKTVe2U6Q@mail.gmail.com>
 <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com>
 <6d5373a4-7aeb-336a-a234-3b386f9e2ef4@suse.com>
 <CAPhsuW4YBhixhdGkvue5evnLwRU_wEmEgOcEiLA0urePcWTq0w@mail.gmail.com>
From:   Guoqing Jiang <gqjiang@suse.com>
Message-ID: <543a63e4-5b8a-2b11-9201-32f935c9b175@suse.com>
Date:   Wed, 19 Jun 2019 11:54:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4YBhixhdGkvue5evnLwRU_wEmEgOcEiLA0urePcWTq0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 6/18/19 10:39 PM, Song Liu wrote:
> On Tue, Jun 18, 2019 at 1:35 AM Guoqing Jiang <gqjiang@suse.com> wrote:
>>
>>
>>
>> On 6/18/19 11:41 AM, Guoqing Jiang wrote:
>>>>>
>>>>> +static int check_and_add_wb(struct md_rdev *rdev, sector_t lo,
>>>>> sector_t hi)
>>>>> +{
>>>>> +       struct wb_info *wi;
>>>>> +       unsigned long flags;
>>>>> +       int ret = 0;
>>>>> +       struct mddev *mddev = rdev->mddev;
>>>>> +
>>>>> +       wi = mempool_alloc(mddev->wb_info_pool, GFP_NOIO);
>>>>> +
>>>>> +       spin_lock_irqsave(&rdev->wb_list_lock, flags);
>>>>> +       list_for_each_entry(wi, &rdev->wb_list, list) {
>>>> This doesn't look right. We should allocate wi from mempool after
>>>> the list_for_each_entry(), right?
>>>
>>> Good catch, I will use an temp variable in the iteration since
>>> mempool_alloc
>>> could sleep.
>>
>> After a second thought, I think it should be fine since wi is either
>> reused to record the sector range or freed after the iteration.
>>
>> Could you elaborate your concern? Thanks.
> 
> First, we allocated wb_info and stored the ptr to wi. Then we use
> same wi in list_for_each_entry(), where the original value of wi is
> overwritten:
> 
> #define list_for_each_entry(pos, head, member)                          \
>          for (pos = list_first_entry(head, typeof(*pos), member);        \
>               &pos->member != (head);                                    \
>               pos = list_next_entry(pos, member))
> 
> So we are leaking the original wi from mempool_alloc, right?

Yes, you are right, thanks for the details.

> And we probably over writing one element on wb_list.

Will change it to:

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 93dff41c4ff9..f1ea17b14b6e 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -85,7 +85,7 @@ static void lower_barrier(struct r1conf *conf, 
sector_t sector_nr);

  static int check_and_add_wb(struct md_rdev *rdev, sector_t lo, 
sector_t hi)
  {
-       struct wb_info *wi;
+       struct wb_info *wi, *temp_wi;
         unsigned long flags;
         int ret = 0;
         struct mddev *mddev = rdev->mddev;
@@ -93,9 +93,9 @@ static int check_and_add_wb(struct md_rdev *rdev, 
sector_t lo, sector_t hi)
         wi = mempool_alloc(mddev->wb_info_pool, GFP_NOIO);

         spin_lock_irqsave(&rdev->wb_list_lock, flags);
-       list_for_each_entry(wi, &rdev->wb_list, list) {
+       list_for_each_entry(temp_wi, &rdev->wb_list, list) {
                 /* collision happened */
-               if (hi > wi->lo && lo < wi->hi) {
+               if (hi > temp_wi->lo && lo < temp_wi->hi) {
                         ret = -EBUSY;
                         break;
                 }


BRs,
Guoqing
