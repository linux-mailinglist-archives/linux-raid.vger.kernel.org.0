Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B9221D8C
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 09:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgGPHpB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 03:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPHpA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jul 2020 03:45:00 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFC0C061755
        for <linux-raid@vger.kernel.org>; Thu, 16 Jul 2020 00:45:00 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so4044451edq.8
        for <linux-raid@vger.kernel.org>; Thu, 16 Jul 2020 00:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I+NNH8aJt3a4dVWYXhMxYLASCjloRPyD//T42JKaaC8=;
        b=iblTULE0kIpwmH2M6rtBPVGXHDMgN4GtMOWq9+9+WoBVmv7ohn8dQDjn4XxYLOKGZA
         +/xoQPtQDGUYkw6vkjRI/rf3kDN9ssm+wMuTk2wsJQ9gR4vJxVPCr4NeN5dnHm6/21v0
         q3dz7F3WvPxoUYx/hMZSi20aLEjtXQooH6GM8/8+gc2HWcxe1t04LdGhLOONiRK79XXK
         2WImgYK4xn6gcU3fic/XagCy+LEa0trqtcbISRP+iOaNlUmBdGQC22oaxnbu2DQBi3DB
         f1fCJzUvH0UZmEUqF1rwb7JVrPDh+iP48cyid5xn0zTn7sd0IHJgQZPr2gZT1TjAngy2
         4Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I+NNH8aJt3a4dVWYXhMxYLASCjloRPyD//T42JKaaC8=;
        b=fupI7/7idRYeUZVvJmMVLZ6gABVSLsaKeCw/Av5eJZkXLexy02Ewtn81y/TGlRtZ46
         SAannpHZwJa804eiDjPPpmwZK3IFYQ/7PrvHwgYUea5jRihHQeZMzWz7nPo2vD2EgR+h
         NxKYFkwpHTzc5pjozXzjbHb8EvgydDhVHFC04K3iMO/FenB2ANA9qDKH3cYjnh0aXk0t
         iZSo60ZCkNtJ0Y3DIPYsGoPVRV8XI940xYFTzWXjmvMlYczEd9B//ivLdpzE3wUASuxP
         qBu1741qobr2wJm4fL1julfZ4Z55w3CEgBU+nEKsF+wwIFC5nwSKw8Bn7q1/ZB8sBnIF
         QdKQ==
X-Gm-Message-State: AOAM533BAM4Y6VmXsVrK0CM+wa9P0M34NeIISnD5oB6lrrXj6JF+sK61
        cjvLW/QypRzGzFst1u5wlCNl+eGuvzw=
X-Google-Smtp-Source: ABdhPJz4fAh7mVqLxsFCbkTcVpm/F7Swhj/EIfvMQVu2fMZZQ5a7RhyCpr73TwlR33/s0xMXASODMw==
X-Received: by 2002:a50:e801:: with SMTP id e1mr3177969edn.251.1594885498795;
        Thu, 16 Jul 2020 00:44:58 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4843:4a00:587:bfc1:3ea4:c2f6? ([2001:16b8:4843:4a00:587:bfc1:3ea4:c2f6])
        by smtp.gmail.com with ESMTPSA id o17sm4283245ejb.105.2020.07.16.00.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 00:44:58 -0700 (PDT)
Subject: Re: [PATCH 1/3] raid5: call clear_batch_ready before set
 STRIPE_ACTIVE
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW70kML70Xi3MhubCGBWnLDg0L7sPKwKe9HZHsQHwtzEEQ@mail.gmail.com>
 <407fa617-c86e-d63d-65ad-3f3058c5e40f@cloud.ionos.com>
 <CAPhsuW4J84iZWZkCCk8_8uJpPwmvrd2vvHEk-fLQF_HKGioECg@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <c4541de5-9eac-dc19-2681-4672d5a820e7@cloud.ionos.com>
Date:   Thu, 16 Jul 2020 09:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4J84iZWZkCCk8_8uJpPwmvrd2vvHEk-fLQF_HKGioECg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/26/20 2:16 AM, Song Liu wrote:
> On Thu, Jun 25, 2020 at 2:22 AM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>>
>>
>> On 6/24/20 1:58 AM, Song Liu wrote:
>>> On Tue, Jun 16, 2020 at 2:25 AM Guoqing Jiang
>>> <guoqing.jiang@cloud.ionos.com> wrote:
>>>> We tried to only put the head sh of batch list to handle_list, then the
>>>> handle_stripe doesn't handle other members in the batch list. However,
>>>> we still got the calltrace in break_stripe_batch_list.
>>>>
>>>> [593764.644269] stripe state: 2003
>>>> kernel: [593764.644299] ------------[ cut here ]------------
>>>> kernel: [593764.644308] WARNING: CPU: 12 PID: 856 at drivers/md/raid5.c:4625 break_stripe_batch_list+0x203/0x240 [raid456]
>>>> [...]
>>>> kernel: [593764.644363] Call Trace:
>>>> kernel: [593764.644370]  handle_stripe+0x907/0x20c0 [raid456]
>>>> kernel: [593764.644376]  ? __wake_up_common_lock+0x89/0xc0
>>>> kernel: [593764.644379]  handle_active_stripes.isra.57+0x35f/0x570 [raid456]
>>>> kernel: [593764.644382]  ? raid5_wakeup_stripe_thread+0x96/0x1f0 [raid456]
>>>> kernel: [593764.644385]  raid5d+0x480/0x6a0 [raid456]
>>>> kernel: [593764.644390]  ? md_thread+0x11f/0x160
>>>> kernel: [593764.644392]  md_thread+0x11f/0x160
>>>> kernel: [593764.644394]  ? wait_woken+0x80/0x80
>>>> kernel: [593764.644396]  kthread+0xfc/0x130
>>>> kernel: [593764.644398]  ? find_pers+0x70/0x70
>>>> kernel: [593764.644399]  ? kthread_create_on_node+0x70/0x70
>>>> kernel: [593764.644401]  ret_from_fork+0x1f/0x30
>>>>
>>>> As we can see, the stripe was set with STRIPE_ACTIVE and STRIPE_HANDLE,
>>>> and only handle_stripe could set those flags then return. And since the
>>>> stipe was already in the batch list, we need to return earlier before
>>>> set the two flags.
>>>>
>>>> And after dig a little about git history especially commit 3664847d95e6
>>>> ("md/raid5: fix a race condition in stripe batch"), it seems the batched
>>>> stipe still could be handled by handle_stipe, then handle_stipe needs to
>>>> return earlier if clear_batch_ready to return true.
>>>>
>>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>>> ---
>>>> Another alternative would be just not warn if STRIPE_ACTIVE is valid for
>>>> the batched list.
>>>>
>>>> What do you think?
>>>>
>>> This patch looks good to me (haven't tested yet). Let's try with this one.
>> Ok, pls let me know if there is issue during test.
>>
>> And do you want a new patch to reflect which I clarified for the line
>> number and kernel version?
> That's not necessary. If needed, I will make some change when I apply the patch.

May I know your decision about this?

Thanks,
Guoqing
