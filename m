Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5893C10D49A
	for <lists+linux-raid@lfdr.de>; Fri, 29 Nov 2019 12:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfK2LPh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 Nov 2019 06:15:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41559 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2LPh (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 29 Nov 2019 06:15:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id n24so4079419edo.8
        for <linux-raid@vger.kernel.org>; Fri, 29 Nov 2019 03:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wc4UdE/y3hiWs45SlEnpdcsx3c2UyoG8MxxT4Dpqq1s=;
        b=Nsb5dYIwcBI9Z2+psT1oP2bNMnaC5eIKT//3MuKeOa+GhMwGM/kWiSZCmfBY3s7RHS
         zLczewnwiR8W3paVnidaIRcbmtSl6EiTPBn6nEtO0l1DecUg/h38yK20vhWl0i/CJoFC
         Fqai0OJAvcpTOcXwLHE+HE7vwFICLqrAZ6IfEm46tdBtBO4vtS1vtDKvT2CGQLKhm7HC
         wib4bqghtXI51afUbH5wgabMTsoygCg4k2hBQ8FuzjZPayh+SV6HhWdYy9WTDC1C24wS
         a+S6WwMbr2TtcEwPb3PGS9DgnhRSRCvPgwIAntXj/z1kdXaIw2YdKAk1YcxfIRzragol
         TCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wc4UdE/y3hiWs45SlEnpdcsx3c2UyoG8MxxT4Dpqq1s=;
        b=NoDWy+g/ReRu7ZJqO/I7ye/FZecN+0i4Jc9R8LUAYX0z4LUab+DC+gQwtlGkpU1EYB
         DS+t7CJHMKzANk6IHcB2G61tGNsuz8ah+qVZDQq1YsG5FDLLShJSr6Nb31Ce1aAuy/mQ
         P70KtYkEFMlZlGP3Mbdth5NdjnfLk7BRUO+n4ODwt/q6WpBKA/CkBjXkRvl71TT+8AJG
         isVMC6zi5xuRQxAuj0eH9M59fOuhK12sMJ+4xuo6p/YhNXxirdeCOVcCHSFbDf5moKDm
         HoiJxK0+o/1HLN8tYoNqUCHJwgjWV9mqc6cETa0DrTZJmQi1ErD0VoNhFgzY/l2d/h1g
         8SXg==
X-Gm-Message-State: APjAAAXjv9E5PtowLTc1+pErazcSdCqnj+6lQO7T3kbW1S9j9tsmt4XG
        JdHPo+A2S06R2xN86j0/bLzkpw==
X-Google-Smtp-Source: APXvYqx8ZYihkd/OhFY2IewFUvGXx5y7EhNGLTLQXoP8Dizk86zzZBy7+XmM/Ah8yYyXPfqTvG7SXw==
X-Received: by 2002:a17:906:7c5:: with SMTP id m5mr59619474ejc.231.1575026135918;
        Fri, 29 Nov 2019 03:15:35 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:4017:9af3:167b:9d3? ([2001:1438:4010:2540:4017:9af3:167b:9d3])
        by smtp.gmail.com with ESMTPSA id e24sm983286edc.13.2019.11.29.03.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 03:15:35 -0800 (PST)
Subject: Re: About raid5 lock up
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-raid <linux-raid@vger.kernel.org>
Cc:     shinrairis@gmail.com, colyli@suse.de,
        Song Liu <liu.song.a23@gmail.com>
References: <a9f64be8-0f57-83f7-e7dd-2d6d4386a6f4@cloud.ionos.com>
Message-ID: <a96ba13a-6400-06cd-76be-fec12ebbc5e8@cloud.ionos.com>
Date:   Fri, 29 Nov 2019 12:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a9f64be8-0f57-83f7-e7dd-2d6d4386a6f4@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/21/19 3:14 PM, Guoqing Jiang wrote:
>
> My understanding is that there could be two possible reasons for lockup:
>
> 1. There is deadlock inside raid5 code somewhere which should be fixed.
> 2. Since spin_lock/unlock_irq are called in raid5_get_active_stripe, 
> then if the function need to
> handle massive IOs, could it possible hard lockup was triggered due to 
> IRQs are disabled more
> than 10s? If so, maybe we need to touch nmi watchdog before disable irq.
>
> Coly and Dennis had reported raid5 lock up issues with different 
> kernel versions (4.2.8, 4.7.0-rc7
> and 4.8-rc5), not sure it they are related or not, but I guess it is 
> not fixed in latest code.
>
> Any thoughts?
>
> [1]. https://marc.info/?l=linux-raid&m=150348807422853&w=2
> [2]. https://marc.info/?l=linux-raid&m=146883211430999&w=2

Hmm, looks release_stripe_plug is lock free, means it could add sh to 
plug list whether it is already
in other lists. For example, the same sh could be handled by 
raid5_release_stripe which is also lock
free, it does two things in case "sh->count == 1":

1.  add sh to released_stripes

Or

2. go to slow path if sh is already set with ON_RELEASE_LIST.

Either 1 or 2 could trigger do_release_stripe finally, this function 
mainly move sh->lru to different lists
such as delayed_list, handle_list or temp_inactive_list etc.

So list is corrupted since one node could in different lists, which 
makes raid5_unplug could stick in the
while loop with hold device_lock, means raid5_get_active_stripe doesn't 
have chance to get device_lock,
then calltrace happens.

Call Trace:
[<ffffffff81598060>] _raw_spin_lock+0x20/0x30
[<ffffffffa0230b0a>] raid5_get_active_stripe+0x1da/0x5250 [raid456]
[<ffffffff8112d165>] ? mempool_alloc_slab+0x15/0x20
[<ffffffffa0231174>] raid5_get_active_stripe+0x844/0x5250 [raid456]
[<ffffffff812d5574>] ? generic_make_request+0x24/0x2b0
[<ffffffff810938b0>] ? wait_woken+0x90/0x90
[<ffffffff814a2adc>] md_make_request+0xfc/0x250
[<ffffffff812d5867>] submit_bio+0x67/0x150


If the analysis is correct, we at least need to add more checks like:

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 09d4caf674e0..caab91ce60ec 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5482,7 +5482,9 @@ static void release_stripe_plug(struct mddev *mddev,
                         INIT_LIST_HEAD(cb->temp_inactive_list + i);
         }

-       if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
+       if (atomic_read(&sh->count) != 0 &&
+           !test_bit(STRIPE_ON_RELEASE_LIST, &sh->state) &&
+           !test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
                 list_add_tail(&sh->lru, &cb->list);
         else
                 raid5_release_stripe(sh);

Thoughts?

Thanks,
Guoqing
