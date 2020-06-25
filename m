Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D1209BD2
	for <lists+linux-raid@lfdr.de>; Thu, 25 Jun 2020 11:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403830AbgFYJWu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 25 Jun 2020 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390836AbgFYJWu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 25 Jun 2020 05:22:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62DEC061573
        for <linux-raid@vger.kernel.org>; Thu, 25 Jun 2020 02:22:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so2424573edy.1
        for <linux-raid@vger.kernel.org>; Thu, 25 Jun 2020 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c2MzEvGWD9N68uWCqb5PvAtkdOvrhF5kTBQsnG7qjz4=;
        b=LYb+/RRO/+TNuE9K10M+eEY/a86VT2KlVjpJzGGTGhtiobbrv51/KbSnOMr7nSMlhY
         dYKlR35TNaMTcR5znXLfSVquH3PxQhmaXWswBun7dxCAhaOP9FIMrsQEm/VbJnBzNeXy
         E/VOniGYMhTxKYTAq52XwQQ/QYlvb+UTB40nlryT+XsRsTApBDtsRlvvpWF0K1t4bwR/
         Oo924JGCVHDEY5/ui9HpDsQ+ANqTE9QoE3+H6GYf/V1e7wujyVGbASPfK1IqNZ2EZK/y
         bSxXTT0pw2CDwc61vaVcsUlRAnUN2ITXr5GQpOEiT3klLikFZlQxUToeZ74ungUIlHce
         J0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c2MzEvGWD9N68uWCqb5PvAtkdOvrhF5kTBQsnG7qjz4=;
        b=Q1QVCjXVPbF1eVGhT1K7pmLzwlrwrQSO85MMdPbJG0V2NymZECZAN0PxbAvJxh9kwl
         ojgsDizZ0xd9OOFDOpVIX2EqIayKVJhgf3W8uo1PlaHfjOmSnjVC6xHIVsplDwiqcpyW
         4SmQ0gXwRwWBl5QV6b1mTG4qSnf8vXHJcekbcR0OVfok/D0VAuM8PQZg0Hin5uUGPiag
         BlmJo2uSezY4BURb/XLY16r4vs8B8VugG3Y4CgP7YydECMOM3CCm9ZcAye61IJ4oX/4o
         ZTYXRYhSLyAh6yPLnWSk8KbCoGvz1sSglZmtEvvpmTKlQa05QB8wsOSrA84SNPHBs16T
         q0GQ==
X-Gm-Message-State: AOAM530/Gjc7+7BFfZNYphduo+rLgDUdcMk0TvtQIQG32pSf+ZKO1cUD
        iN2fSauTcCzxO5nBv1l6zBfiZzXtH/EDrq8h
X-Google-Smtp-Source: ABdhPJzFdOa2lKsvY5fwTbv0ctdw73UfVsonYl9cDvGto5LFmXy3HVBAK9mzmxAJ1rE2EXDJN5o76Q==
X-Received: by 2002:a50:d785:: with SMTP id w5mr30128170edi.212.1593076968013;
        Thu, 25 Jun 2020 02:22:48 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:898:8772:ff54:afa? ([2001:1438:4010:2540:898:8772:ff54:afa])
        by smtp.gmail.com with ESMTPSA id bs18sm2777981edb.38.2020.06.25.02.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 02:22:47 -0700 (PDT)
Subject: Re: [PATCH 1/3] raid5: call clear_batch_ready before set
 STRIPE_ACTIVE
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW70kML70Xi3MhubCGBWnLDg0L7sPKwKe9HZHsQHwtzEEQ@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <407fa617-c86e-d63d-65ad-3f3058c5e40f@cloud.ionos.com>
Date:   Thu, 25 Jun 2020 11:22:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW70kML70Xi3MhubCGBWnLDg0L7sPKwKe9HZHsQHwtzEEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 6/24/20 1:58 AM, Song Liu wrote:
> On Tue, Jun 16, 2020 at 2:25 AM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>> We tried to only put the head sh of batch list to handle_list, then the
>> handle_stripe doesn't handle other members in the batch list. However,
>> we still got the calltrace in break_stripe_batch_list.
>>
>> [593764.644269] stripe state: 2003
>> kernel: [593764.644299] ------------[ cut here ]------------
>> kernel: [593764.644308] WARNING: CPU: 12 PID: 856 at drivers/md/raid5.c:4625 break_stripe_batch_list+0x203/0x240 [raid456]
>> [...]
>> kernel: [593764.644363] Call Trace:
>> kernel: [593764.644370]  handle_stripe+0x907/0x20c0 [raid456]
>> kernel: [593764.644376]  ? __wake_up_common_lock+0x89/0xc0
>> kernel: [593764.644379]  handle_active_stripes.isra.57+0x35f/0x570 [raid456]
>> kernel: [593764.644382]  ? raid5_wakeup_stripe_thread+0x96/0x1f0 [raid456]
>> kernel: [593764.644385]  raid5d+0x480/0x6a0 [raid456]
>> kernel: [593764.644390]  ? md_thread+0x11f/0x160
>> kernel: [593764.644392]  md_thread+0x11f/0x160
>> kernel: [593764.644394]  ? wait_woken+0x80/0x80
>> kernel: [593764.644396]  kthread+0xfc/0x130
>> kernel: [593764.644398]  ? find_pers+0x70/0x70
>> kernel: [593764.644399]  ? kthread_create_on_node+0x70/0x70
>> kernel: [593764.644401]  ret_from_fork+0x1f/0x30
>>
>> As we can see, the stripe was set with STRIPE_ACTIVE and STRIPE_HANDLE,
>> and only handle_stripe could set those flags then return. And since the
>> stipe was already in the batch list, we need to return earlier before
>> set the two flags.
>>
>> And after dig a little about git history especially commit 3664847d95e6
>> ("md/raid5: fix a race condition in stripe batch"), it seems the batched
>> stipe still could be handled by handle_stipe, then handle_stipe needs to
>> return earlier if clear_batch_ready to return true.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>> Another alternative would be just not warn if STRIPE_ACTIVE is valid for
>> the batched list.
>>
>> What do you think?
>>
> This patch looks good to me (haven't tested yet). Let's try with this one.

Ok, pls let me know if there is issue during test.

And do you want a new patch to reflect which I clarified for the line
number and kernel version?

Thanks,
Guoqing
