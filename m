Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B108120860
	for <lists+linux-raid@lfdr.de>; Mon, 16 Dec 2019 15:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfLPOQW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Dec 2019 09:16:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36945 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfLPOQW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 16 Dec 2019 09:16:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id cy15so5169068edb.4
        for <linux-raid@vger.kernel.org>; Mon, 16 Dec 2019 06:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PZOSXT0OE0/aJrWXDS4M048rMwyQOUpigDG/ZhFhaXc=;
        b=AjST85HRMQx2PltKkB5f1Kcb6u2fLh6cpV+u+hWZ5F4MDEqPVWLGpQHlHdjtvkGR2S
         XlA4JEX27seAFCpGN1Hd6bF5pap3/QTZsVkRw9OuDxOalxvDHk4wST7nrA7QYE4joOy9
         ClyrRyUTJAcLMt1dK4VrfaZmKDd97z80B3yvOwgIjk1bzVuB0PMjbeZI+1OVhFxyN0Vq
         qEky1dCutr8VQfVCWK8vgyVm3zf9yRDu2nKh/nf3L9G9To91Wots2Xw4JYL+UsGGyPaI
         F9XOshs3iFPDrC2Q4/Mx2UbHsvXNWB7F6t81oDmdQArDrjJCupkN3TMhr6TPHfhVJiBK
         ntVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PZOSXT0OE0/aJrWXDS4M048rMwyQOUpigDG/ZhFhaXc=;
        b=XFk3kWS3iI9t0FjdDK4fk4n0ArjUUh5tAiDftFFSQ3XB0o1meMCa9X8qhHJ+FiL6rU
         Idh4Gu+IkPTzfNlDaUIYzDge0pUztx83k3L/akYAL126FTvcG/4di3cwVBE3xmAnw1ui
         qqss5I3WHo5/OhEz/7X4EzrHuxaj8RqMEYHLNa3QxAYLpwLEC/SqvSzR+SPifsAYZL9u
         CiJWphiREW3+RZQH/JVkD3cntaXqJCHpYAfDShevu/qnrbXmAhRIXyB+Mo9C9AcI8yAN
         dsbbtMAyk3diIb0fehDQQAz0zNbAuU+39sN1XY4W9z1NaHjJf8hNXEFrS/vSs6qrmmWe
         oOvg==
X-Gm-Message-State: APjAAAVAsR4SUaKxBUCk0yw5YcFYGPbtuEKXtUKCFNdbGvJWrENKHV+l
        XfZCkgLn0WioxQLnIbixQjf1qTxL4TY=
X-Google-Smtp-Source: APXvYqyDlCgpN7tZbPFRnVTQ5bPOrcOrPd1jzW12BZFFyZbAFfHie4YBRJfYACJUiH9nNW9ibI3gZA==
X-Received: by 2002:a05:6402:221c:: with SMTP id cq28mr7011294edb.110.1576505781146;
        Mon, 16 Dec 2019 06:16:21 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:4c47:b6f1:9ffc:1fb? ([2001:1438:4010:2540:4c47:b6f1:9ffc:1fb])
        by smtp.gmail.com with ESMTPSA id la19sm98715ejb.76.2019.12.16.06.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:16:20 -0800 (PST)
Subject: Re: [PATCH] raid5: add more checks before add sh->lru to plug cb list
To:     linux-raid@vger.kernel.org
Cc:     liu.song.a23@gmail.com
References: <20191216135840.10898-1-guoqing.jiang@cloud.ionos.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <e318a4a4-a4cf-a997-15ba-9373be1cfc75@cloud.ionos.com>
Date:   Mon, 16 Dec 2019 15:16:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191216135840.10898-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 12/16/19 2:58 PM, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> release_stripe_plug adds lru to unplug list, then raid5_unplug
> iterates unplug list and release the stripe in the list. But
> sh->lru could exist in another list as well since there is no
> protection of the race since release_stripe_plug is lock free.
>
> For example, the same sh could be handled by raid5_release_stripe
> which is lock free too, it does two things in case "sh->count == 1".
>
> 1. add sh to released_stripes.
> Or
> 2. go to slow path if sh is already set with ON_RELEASE_LIST.
>
> Either 1 or 2 could trigger do_release_stripe finally, and this
> function mainly move sh->lru to different lists such as delayed_list,
> handle_list or temp_inactive_list etc.
>
> Then the same node could be in different lists, which causes
> raid5_unplug sticks with "while (!list_empty(&cb->list))", and
> since spin_lock_irq(&conf->device_lock) is called before, it
> causes:
>
> 1. hard lock up in [1], [2] and [3] since irq is disabled.
> 2. raid5_get_active_stripe can't get device_lock and calltrace
> happens as follows.
> [<ffffffff81598060>] _raw_spin_lock+0x20/0x30
> [<ffffffffa0230b0a>] raid5_get_active_stripe+0x1da/0x5250 [raid456]
> [<ffffffff8112d165>] ? mempool_alloc_slab+0x15/0x20
> [<ffffffffa0231174>] raid5_get_active_stripe+0x844/0x5250 [raid456]
> [<ffffffff812d5574>] ? generic_make_request+0x24/0x2b0
> [<ffffffff810938b0>] ? wait_woken+0x90/0x90
> [<ffffffff814a2adc>] md_make_request+0xfc/0x250
> [<ffffffff812d5867>] submit_bio+0x67/0x150
>
> So add two more checkings before add sh->lru to cb->list to avoid
> potential list corruption.
>
> 1. the sh should not be handling by do_release_stripe.
> 2. ensure the sh is not release list.

Forgot to paste the links.

[1]. https://marc.info/?l=linux-raid&m=150348807422853&w=2
[2]. https://marc.info/?l=linux-raid&m=146883211430999&w=2
[3]. https://marc.info/?l=linux-raid&m=157434565331673&w=2

  Thanks,
Guoqing
