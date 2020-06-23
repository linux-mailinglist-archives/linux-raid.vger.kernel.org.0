Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E78206824
	for <lists+linux-raid@lfdr.de>; Wed, 24 Jun 2020 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbgFWXQz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 19:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbgFWXQy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Jun 2020 19:16:54 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795EEC061573
        for <linux-raid@vger.kernel.org>; Tue, 23 Jun 2020 16:16:54 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 64so153894oti.5
        for <linux-raid@vger.kernel.org>; Tue, 23 Jun 2020 16:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UFD6lKIxMW1L6uFOJA+XY/n0qW/Y4XpRV1I9TRxi8kM=;
        b=MBxB+aAufdlvgtvp6LJ/eKno6mTiu1pcM5YCJgO0LBOWphyvxFlHyoSeJz5WyaObI/
         uE22thX4NGPbLM24+bixe+2vwR7HFmwUbtl7EY1uRcFk2oaL1ifVB13IKfW//su6CDNP
         wIx0CR/WWqNjDK/cxMJKEnrZUOm35LUVqP5WixBK774SGmKZoTl/J/2FOrEbcnERuGy/
         jR/FdA52z5BurU9mrwMO2z8R2UVvM9VtYr/yiytlndXhwO06xAZsQ5AoNGxn99Bt2/sr
         6XTxSPskTq3NCwQoad/rjJv5FvbHekIIzqdwLY6qM28BlQpo+Js5ty88abKVxRAP1ItJ
         lNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UFD6lKIxMW1L6uFOJA+XY/n0qW/Y4XpRV1I9TRxi8kM=;
        b=Bc0MkujElmvpscT572+ilrxxOm/LIaR1Q3wM8fBqsRUXt1Aay2+6ISTzYiKyDyi5w0
         PNJpvNb/UmIDL03PqvQ71qRzEP1WJw5odQgwqk2llS0vQz2J/s978QsYiyxWOANTezj/
         BPJ+h6+EsJjPYysL8olE+rcl+bV17uTxi/T1AbGK+Yx4MLH9xGiNTotI0JZ2G4FJ08EG
         yxuNooXIRV6ZuclJjgd24/yHd2DWOSGhTEc7OJdlh1QbYU7pXEerB4cIyd5u6vI0YeRa
         R/MQms9wLzm8lytB8JPhkKu8gukG0pWOysJTXQmgeVtsOqGLi2aqtOFnwop0gURm3wWQ
         1XDg==
X-Gm-Message-State: AOAM530zjBgngJrt0Qa52yS81Kz6MeAH/tb13pc2NWiBYlBf8RPCqZqC
        AZtoJ2/slw8koRIDwY+bmE5cJ/rg
X-Google-Smtp-Source: ABdhPJwCAGsp87EI/aPJVM1Ok7USZ5r23WMZd78H4B7Rzmaqz7NUDJmwEFIMXeoE7Mr7PLNlKNZ9dw==
X-Received: by 2002:a9d:f07:: with SMTP id 7mr19844786ott.46.1592954213225;
        Tue, 23 Jun 2020 16:16:53 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c8b:a4fa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id i16sm4413132otc.33.2020.06.23.16.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 16:16:52 -0700 (PDT)
Subject: Re: RAID types & chunks sizes for new NAS drives
To:     John Stoffel <john@stoffel.org>
Cc:     linux-raid@vger.kernel.org
References: <rco1i8$1l34$1@ciao.gmane.io>
 <24305.24232.459249.386799@quad.stoffel.home>
 <1ba7c1be-4cb1-29a5-d49c-bb26380ceb90@gmail.com>
 <24306.29793.40893.422618@quad.stoffel.home>
From:   Ian Pilcher <arequipeno@gmail.com>
Message-ID: <40bf8a08-61a6-2b50-b9c6-240e384de80d@gmail.com>
Date:   Tue, 23 Jun 2020 18:16:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <24306.29793.40893.422618@quad.stoffel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/23/20 4:30 PM, John Stoffel wrote:
> Well, as you add LVM volumes to a VG, I don't honestly know offhand if
> the areas are pre-allocated, or not, I think they are pre-allocated,
> but if you add/remove/resize LVs, you can start to get fragmentation,
> which will hurt performance.

LVs are pre-allocated, and they definitely can become fragmented.
That's orthogonal to whether the VG is on a single RAID device or a
set of smaller adjacent RAID devices.

> No, you still do not want the partitioned setup, becuase if you lose a
> disk, you want to rebuild it entirely, all at once.  Personally, 5 x
> 8Tb disks setup in RAID10 with a hot spare sounds just fine to me.
> You can survive a two disk failure if it doesn't hit both halves of
> the mirror.  But the hot spare should help protect you.

It depends on what sort of failure you're trying to protect against.  If
you lose the entire disk (because of an electronic/mechanical failure,
for example) your doing either an 8TB rebuild/resync or (for example)
16x 512GB rebuild/resyncs, which is effectively the same thing.

OTOH, if you have a patch of sectors go bad in the partitioned case,
the RAID layer is only going to automatically rebuild/resync one of the
partition-based RAID devices.  To my thinking, this will reduce the
chance of a double-failure.

I think it's important to state that this NAS is pretty actively
monitored/managed.  So if such a failure were to occur, I would
absolutely be taking steps to retire the drive with the failed sectors.
But that's something that I'd rather do manually, rather than kicking
off (for example) and 8TB rebuild with a hot-spare.

> One thing I really like to do is mix vendors in my array, just so I
> dont' get caught by a bad batch.  And the RAID10 performance advantage
> over RAID6 is big.  You'd only get 8Tb (only! :-) more space, but much
> worse interactive response.

Mixing vendors (or at least channels) is one of those things that I
know that I should do, but I always get impatient.

But do I need the better performance.  Choices, choices ...  :-)

> Physics sucks, don't it?  :-)

LOL!  Indeed it does!
> 
> What I do is have a pair of mirrored SSDs setup to cache my RAID1
> arrays, to give me more performance.  Not really sure if it's helping
> or hurting really.  dm-cache isn't really great at reporting stats,
> and I never bothered to test it hard.

I've played with both bcache and dm-cache, although it's been a few
years.  Neither one really did much for me, but that's probably because
I was using write-through caching, as I didn't trust "newfangled" SSDs
at the time.

> My main box is an old AMD Phenom(tm) II X4 945 Processor, which is now
> something like 10 years old.  It's fast enough for what I do.  I'm
> more concerned with data loss than I am performance.

Same here.  I mainly want to feel comfortable that I haven't crippled my
performance by doing something stupid, but as long as the NAS can stream
a movie to media room it's good enough.

My NAS has an Atom D2550, so it's almost certainly slower than your
Phenom.

> Get a bigger case then.  :-)

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
