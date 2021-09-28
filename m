Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10941AA32
	for <lists+linux-raid@lfdr.de>; Tue, 28 Sep 2021 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhI1H5b (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Sep 2021 03:57:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:38231 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239355AbhI1H5b (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Sep 2021 03:57:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="204131764"
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="204131764"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 00:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="478601137"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 28 Sep 2021 00:55:41 -0700
Received: from [10.213.3.81] (mtkaczyk-MOBL1.ger.corp.intel.com [10.213.3.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CFD8E5807C8;
        Tue, 28 Sep 2021 00:55:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] md, raid1, raid10: Set MD_BROKEN for RAID1 and RAID10
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20210917153452.5593-1-mariusz.tkaczyk@linux.intel.com>
 <20210917153452.5593-2-mariusz.tkaczyk@linux.intel.com>
 <CAPhsuW5bV+Bz=Od9jomNHoedaEMFAXymN11J80G62GVPwSp41g@mail.gmail.com>
 <CAPhsuW4HZFaPgKx68mDeWE0F7SAjpnXmHL0TzN1SuZD6_Kds-w@mail.gmail.com>
 <83f06776-891f-dffa-7449-4128c419ada9@linux.intel.com>
 <CAPhsuW7mi9KZBVH8YuUvvbCv8k-82tb=jJnkxU0RJXhj+OxXjg@mail.gmail.com>
 <d41df432-e4e1-9567-b0e6-14736407d808@linux.intel.com>
Message-ID: <5fc3bc1c-8e12-8d85-64c2-81cd44016073@linux.intel.com>
Date:   Tue, 28 Sep 2021 09:55:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d41df432-e4e1-9567-b0e6-14736407d808@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 28.09.2021 09:33, Tkaczyk, Mariusz wrote:
> Hi Song,
> 
> On 28.09.2021 00:59, Song Liu wrote:
>>>>>> +               if (!test_bit(Faulty, &rdev->flags) &&
>>>>>> +                    !test_bit(MD_BROKEN, &mddev->flags) &&
>>>>>> +                    (bio->bi_opf & MD_FAILFAST)) {
>>>>>
>>>>> So with MD_BROKEN, we will not try to update the SB?
>>> Array is dead, is there added value in writing failed state?
>>
>> I think there is still value to remember this. Say a raid1 with 2 drives,
>> A and B. If B is unpluged from the system, we would like to update SB
>> on A to remember that. Otherwise, if B is pluged back later (maybe after
>> system reset), we won't tell which one has the latest data.
>>
>> Does this make sense?
> 
> Removing one drive from raid1 array doesn't cause raid failure.
> So, removing B will be recorded on A.
> Raid1 is not good example because to fail array we need to remove
> all members, so MD_BROKEN doesn't matter because
> !test_bit(Faulty, &rdev->flags) is true.
is false.

Oh, I messed it up. There is no faulty flag in this case, we cannot remove
last drive. Since member is (physically) gone then there is no change to
update metadata, even if it is requested.

> 
> Let say that we have raid10 with member A, B, C, D. Member A is removed,
> and it is recorded correctly (we are degraded now). Next, member B is
> removed which causes array failure.
> W/ my patch:
> member B failure is not saved on members C and D. Raid is failed but
> it is not recorded in metadata.
> w/o my patch:
> member B failure is saved on C and D, and metadata is in failed state.
>>>>>
>>>>>>                           set_bit(MD_SB_NEED_REWRITE, &mddev->sb_flags);
>>>>>>                           set_bit(LastDev, &rdev->flags);
>>>>>>                   }
>>>>>> @@ -2979,7 +2980,8 @@ state_store(struct md_rdev *rdev, const char *buf, 
>>>>>> size_t len)
>>>>>>           int err = -EINVAL;
>>>>>>           if (cmd_match(buf, "faulty") && rdev->mddev->pers) {
>>>>>>                   md_error(rdev->mddev, rdev);
>>>>>> -               if (test_bit(Faulty, &rdev->flags))
>>>>>> +
>>>>>> +               if (!test_bit(MD_BROKEN, &rdev->mddev->flags))
>>>>>
>>>>> I don't think this makes much sense. EBUSY for already failed array
>>>>> sounds weird.
>>>>> Also, shall we also set MD_BROKEN here?
>>>>>
>>>> Actually, we just called md_error above, so we don't need to set MD_BROKEN 
>>>> here.
>>>> But we shouldn't return EBUSY in such cases, right?
>>>>
>>> About EBUSY:
>>> This is how it is implemented in mdadm, we are expecting it in
>>> case of failure. See my fix[2].
>>> I agree that it can be confusing, but this is how it is working.
>>> Do you want to change it across mdadm and md?
>>> This will break compatibility.
>>>
>>> About MD_BROKEN:
>>> As you see we are determining failure by checking rdev state, if "Faulty"
>>> in flags after md_error() is not set, then it assumes that array is
>>> failed and EBUSY is returned to userspace.
>>
>> This changed the behavior for raid0, no?
>>
>> W/o the change mdadm --fail on raid0 will get EBUSY. W/ this change,
>> it will get 0, and the device is NOT marked as faulty, right?
>>
> See commit mentioned in description. MD_BROKEN is used for raid0,
> so EBUSY is returned, same as w/o patch.
> 
> Thanks,
> Mariusz

