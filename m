Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE1212CEB0
	for <lists+linux-raid@lfdr.de>; Mon, 30 Dec 2019 11:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfL3KUm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Dec 2019 05:20:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43439 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfL3KUm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Dec 2019 05:20:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so32157304edb.10
        for <linux-raid@vger.kernel.org>; Mon, 30 Dec 2019 02:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=9f8im4uf7ZjK3SqdGQJDcLDy22HVrB8MehkQnMZItZ4=;
        b=RSYzFEcHQcaAzqm+Fo1inQAuQkML/ROpy+wF/VcY0qkaakob7G2T+Kb90GyZXTDAdl
         PH4BP1WFNSvsozhecvzqqmlATPeqt856Xj3ztz73Chz2rvJolZ+m1cwMgMyfGdk5PBNh
         O3WmSpZbkolXrFzRmQyJj3jVZI2gCqsPyZxW/k/M1LEDWP/ixgCWDxSZqpOCQJoQS8W5
         mSVMutuIBnGR3bfBOQ1IrYIwwuIG9rn9IoyobLaGcv7diq7DrlD8CLulTS0Mk5F8ex3c
         T6gni+hBM7NRIryB8EGsKo5D5KOGd+wzOEwvw2iADGAXmodsWO7q8ebltXrPyIPS8HGe
         kswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9f8im4uf7ZjK3SqdGQJDcLDy22HVrB8MehkQnMZItZ4=;
        b=GP8+4miqmizl/ZX81p4bq//jTG1tedrlTw5tGkJVBY/7qjKpBsz7RmnX2wYRmUxA8J
         aK/+XkozJMDvUzIzMMwfHkTWyMx/LOlNcA7oXWV5JP+OlPFqqlNU18PuI5Vt1QoHAv/A
         e2Qme0PU4zIQQNslEuQC+78khUSq/tPXMq4ehSkXTdZDqrXGc4L/A5GpAHh1gCi5Hh0s
         Jku6WPl04OE+OFrgg9aU/MQmJ0AP9n8OMvj98KqPfKiJwAGTL+9EUWi6G916++L08j/I
         1Bjh/pMzGz/cyN/545JGykXf9FIyikv9zjDt/PamAbvhO60n2H1jSfK3p99+n+cUnYd/
         VgXw==
X-Gm-Message-State: APjAAAWHDMFtxTnsKtrJNrAc2SzPggf6fVnJ6nGr9IviomBh9rrpzp+j
        rcyZF4akptxst6dcg/hZRhJabQ==
X-Google-Smtp-Source: APXvYqwDWWM0z3rRJywLVeu5UJH4s4V+GKO6MrStPznD9HOz5RRD8m+kekPF9Kg+T10v1kS19b1+fQ==
X-Received: by 2002:a05:6402:298:: with SMTP id l24mr69925686edv.70.1577701240544;
        Mon, 30 Dec 2019 02:20:40 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:cc3c:f5dc:892d:b573? ([2001:1438:4010:2540:cc3c:f5dc:892d:b573])
        by smtp.gmail.com with ESMTPSA id y11sm5195611edw.73.2019.12.30.02.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 02:20:39 -0800 (PST)
Subject: Re: hung-task panic in raid5_make_request
To:     Alexander Lyakas <alex.bolshoy@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>, liu.song.a23@gmail.com
References: <CAGRgLy4Yi1HNqNO0MLq5xjRRgWe7EaByRYF5sA3fFVa1tmpNvA@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <09e8a682-3f91-6b34-58a0-235dbb130901@cloud.ionos.com>
Date:   Mon, 30 Dec 2019 11:20:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAGRgLy4Yi1HNqNO0MLq5xjRRgWe7EaByRYF5sA3fFVa1tmpNvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 12/24/19 9:18 PM, Alexander Lyakas wrote:
> Greetings,
>
> We are hitting the following hung-task panic[1] with raid5 in kernel
> 4.14.99. It is happening every couple of days.
>
> The raid5 in question contains three devices and has been created with command:
> mdadm --create /dev/md5 --force  --raid-devices=3 --size=1522566M
> --chunk=64 --level=raid5 --bitmap=internal --name=5
> --uuid=47952090192D4408BDABC9628E16FD06 --run --auto=md --metadata=1.2
> --homehost=zadara_vc --verbose --verbose /dev/dm-13 /dev/dm-14
> /dev/dm-15
>
> The array is not undergoing any kind of rebuild or reshape.
>
> Similar issue for kernel 4.14.37 was reported in
> https://bugzilla.kernel.org/show_bug.cgi?id=199539.
>
> We recently moved to kernel 4.14 (long term kernel) from kernel 3.18.
> With kernel 3.18 we haven't seen this issue.
>
> Looking at the code, raid5_make_request seems to be stuck waiting for
> a free stripe via raid5_make_request => raid5_get_active_stripe =>
> wait_event_lock_irq().
> Looking with gdb:
>
> (gdb) l *raid5_make_request+0x1b7
> 0xa697 is in raid5_make_request (./include/linux/compiler.h:183).
> 178     })
> 179
> 180     static __always_inline
> 181     void __read_once_size(const volatile void *p, void *res, int size)
> 182     {
> 183             __READ_ONCE_SIZE;
> 184     }
> 185
> 186     #ifdef CONFIG_KASAN
> 187     /*
>
> The READ_ONCE call seems to be used by list_empty, which is called
> from wait_event_lock_irq [2]
>
> How can this be debugged further?
>
> Thanks,
> Alex.
>
> [1]
> [155653.946408] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [155653.947333] kworker/u4:94   D    0  6178      2 0x80000000
> [155653.949159] Call Trace:
> [155653.949576]  ? __schedule+0x290/0x8a0
> [155653.950052]  ? blk_flush_plug_list+0xc1/0x250
> [155653.950688]  schedule+0x2f/0x90
> [155653.951173]  raid5_make_request+0x1b7/0xb10 [raid456]
> [155653.951765]  ? wait_woken+0x80/0x80
> [155653.952216]  ? wait_woken+0x80/0x80
> [155653.952673]  md_handle_request+0x131/0x1a0 [md_mod]
> [155653.953310]  md_make_request+0x65/0x170 [md_mod]
> [155653.953963]  generic_make_request+0x123/0x320
> [155653.954473]  ? submit_bio+0x6c/0x140
> [155653.954981]  submit_bio+0x6c/0x140
>
> [2]
>
> if (!sh) {
> set_bit(R5_INACTIVE_BLOCKED,
> &conf->cache_state);
> r5l_wake_reclaim(conf->log, 0);
> wait_event_lock_irq(
> conf->wait_for_stripe,
> !list_empty(conf->inactive_list + hash) &&
> (atomic_read(&conf->active_stripes)
> < (conf->max_nr_stripes * 3 / 4)
> || !test_bit(R5_INACTIVE_BLOCKED,
>       &conf->cache_state)),
> *(conf->hash_locks + hash));

Assuming the hung is due to empty inactive_list,  can you try the change?

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f0fc538bfe59..897dd167b8d4 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -655,6 +655,7 @@ raid5_get_active_stripe(struct r5conf *conf, 
sector_t sector,
                                 set_bit(R5_INACTIVE_BLOCKED,
                                         &conf->cache_state);
                                 r5l_wake_reclaim(conf->log, 0);
+ md_wakeup_thread(conf->mddev->thread);
                                 wait_event_lock_irq(
                                         conf->wait_for_stripe,
!list_empty(conf->inactive_list + hash) &&


Thanks,
Guoqing
