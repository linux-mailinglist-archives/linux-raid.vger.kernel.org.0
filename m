Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4409E1A748D
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 09:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406522AbgDNHUi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 03:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406487AbgDNHUf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Apr 2020 03:20:35 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13771C0A3BDC
        for <linux-raid@vger.kernel.org>; Tue, 14 Apr 2020 00:20:35 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e5so15725224edq.5
        for <linux-raid@vger.kernel.org>; Tue, 14 Apr 2020 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ms6bstZHIq4DoYcHgbbjL32E4X0Twvk1eD9o2rLUILU=;
        b=QCzuFi/XmqmsZ7fPLjbNKAe0+BGKKL5GHhp/Jr9tuT067NIjoi6Fhc2/ZJxkoM3JMR
         RlLp+Ot9EBlXBKcgK6wx1giXO9cDgUSxUG04ID1TA+3VDUvoxtF0ooecbXCdi2tMVF14
         CBLtWD/UQcS1YOX/Syf8rKumUigJL/WvkUfLufnyQrIDbBGFBNDKsc6KBrtZFxJXXPH2
         WqSjavBja0+1t1rnmr+wpCnoYD656/pTsWbk4gxrvWxSb8ZjLQXqTXOtcP8BTVzpulyo
         ZUkSLnRzY+MjiUkAtz1/qrvgPTpMDUW60K8DoQDCPfLFBTe5x45ayrvMl9hT6TrhgFjp
         j0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ms6bstZHIq4DoYcHgbbjL32E4X0Twvk1eD9o2rLUILU=;
        b=J9VpYXqO38XIwD6WkKUeV5FZy9E+Srl0WGouN73ZPK/USPY6wgHyq3AEL5vkFBZ2An
         Otk0X1wJO4wFgyVFjimaq6ATWvLKtwjljg7y+Hb5I5O4Cx/AY9DzCHpuZfi+BfvWRPA2
         0ZITtL2SmIuNkGGPkEf0tBqBa6aAsm84ILn6w8eNOI8bR6xl/61YzSn3sIR/xGUvyUXo
         4JsHDWCmY03lGDUF70r9E17EUobDJcrqDLjBR7EMc5JXezPUNpkyWOEhyJHEKvFWGwd9
         3oOOo9pxPOYJj1l827Si6ESR5VU22csGpoRcA1o4qJj6On06XjM0LV3E8iarrQCrDAsQ
         0qDQ==
X-Gm-Message-State: AGi0PuYCsMgF6cGdNccYabfV5zq3PJ3vsOsi5FAvCDa3FjQhEGmXljxE
        fwdPII7+jzVvy+PFg7u0JXikI8D2uLo=
X-Google-Smtp-Source: APiQypK/UsKD1EPFm3sGC4Hz74rLTXuQvkJqILAl7CMD4rSHb6T+amENCURDcpsUu/1oqsspFgLrjQ==
X-Received: by 2002:aa7:c701:: with SMTP id i1mr12089896edq.184.1586848833606;
        Tue, 14 Apr 2020 00:20:33 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4871:9b00:34d4:fc5b:d862:dbd2? ([2001:16b8:4871:9b00:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id rk25sm1959314ejb.14.2020.04.14.00.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 00:20:32 -0700 (PDT)
Subject: Re: [PATCH 0/4] md: fix lockdep warning
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>, linux-raid <linux-raid@vger.kernel.org>
References: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW4rWa_ZCX=3eW9Xk_jtZdu+uKX4HZtbfEJfS9ms4a+OSg@mail.gmail.com>
 <76835eb0-d3a7-c5ea-5245-4dcf21a40f7c@cloud.ionos.com>
 <DA29BDF5-4B14-48AF-8B21-3B6A82857B7C@fb.com>
 <11131DC5-A7DA-450B-86D9-803EAE8099A2@fb.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <c32c65e2-5803-7543-6ac9-e6f005d8ecb2@cloud.ionos.com>
Date:   Tue, 14 Apr 2020 09:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <11131DC5-A7DA-450B-86D9-803EAE8099A2@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11.04.20 00:34, Song Liu wrote:
>
>> On Apr 9, 2020, at 5:32 PM, Song Liu <songliubraving@fb.com> wrote:
>>
>>
>>
>>> On Apr 9, 2020, at 2:47 PM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>>>
>>> On 09.04.20 09:25, Song Liu wrote:
>>>> Thanks for the fix!
>>>>
>>>> On Sat, Apr 4, 2020 at 3:01 PM Guoqing Jiang
>>>> <guoqing.jiang@cloud.ionos.com> wrote:
>>>>> Hi,
>>>>>
>>>>> After LOCKDEP is enabled, we can see some deadlock issues, this patchset
>>>>> makes workqueue is flushed only necessary, and the last patch is a cleanup.
>>>>>
>>>>> Thanks,
>>>>> Guoqing
>>>>>
>>>>> Guoqing Jiang (5):
>>>>>   md: add checkings before flush md_misc_wq
>>>>>   md: add new workqueue for delete rdev
>>>>>   md: don't flush workqueue unconditionally in md_open
>>>>>   md: flush md_rdev_misc_wq for HOT_ADD_DISK case
>>>>>   md: remove the extra line for ->hot_add_disk
>>>> I think we will need a new workqueue (2/5). But I am not sure about
>>>> whether we should
>>>> do 1/5 and 3/5. It feels like we are hiding errors from lock_dep. With
>>>> some quick grep,
>>>> I didn't find code pattern like
>>>>
>>>>        if (work_pending(XXX))
>>>>                flush_workqueue(XXX);
>>> Maybe the way that md uses workqueue is quite different from other subsystems ...
>>>
>>> Because, this is the safest way to address the issue. Otherwise I suppose we have to
>>> rearrange the lock order or introduce new lock, either of them is tricky and could
>>> cause regression.
>>>
>>> Or maybe it is possible to  flush workqueue in md_check_recovery, but I would prefer
>>> to make less change to avoid any potential risk.
> After reading it a little more, I guess this might be the best solution for now.
> I will keep it in a local branch for more tests.

Thanks for your effort, if there is any issue then just let me know.

Regards,
Guoqing
