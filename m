Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D98B242127
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 22:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgHKUMg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 16:12:36 -0400
Received: from mail.thelounge.net ([91.118.73.15]:57297 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKUMg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Aug 2020 16:12:36 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4BR3sZ0zcnzXNr;
        Tue, 11 Aug 2020 22:12:29 +0200 (CEST)
Subject: Re: Recommended filesystem for RAID 6
To:     Roman Mamedov <rm@romanrm.net>
Cc:     George Rapp <george.rapp@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
 <20200811212305.02fec65a@natsu>
 <ea7232af-a411-6b16-d03e-6b21c14cc5be@thelounge.net>
 <20200812003305.6628dd6e@natsu>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <5e6cc7ab-2013-6c52-2fb2-09c88bbe3319@thelounge.net>
Date:   Tue, 11 Aug 2020 22:12:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812003305.6628dd6e@natsu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 11.08.20 um 21:33 schrieb Roman Mamedov:
> On Tue, 11 Aug 2020 20:57:15 +0200
> Reindl Harald <h.reindl@thelounge.net> wrote:
> 
>>> Whichever filesystem you choose, you will end up with a huge single point of
>>> failure, and any trouble with that FS or the underlying array put all your
>>> data instantly at risk. 
>>
>> calling an array where you can lose *two* disks as
>> single-point-of-failure is absurd
> 
> As noted before, not just *disks* can fail, plenty of other things to fail in
> a storage server, and they can easily take down, say, a half of all disks, or
> random portions of them in increments of four. Even if temporarily -- that
> surely will be "unexpected" to that single precious 20TB filesystem.

a sun storm can wipe everything

> How will
> it behave, who knows. Do you know? For added fun, reconnect the drives back 30
> seconds later. Oh, let's write to linux-raid for how to bring back a half of
> RAID6 from the Spare (S) status. Or find some HOWTO suggesting a random
> --create without --assume-clean. And if the FS goes corrupt, now you suddenly
> need *all* your backups, not just 1 drive worth of them.

i have not lost any bit on a raid in my whole lifetime but faced a ton
of drives dying

>> no raid can replace backups anyways
> 
> All too often I've seen RAID being used as an implicit excuse to be lenient
> about backups. Heck, I know from personal experience how enticing that can be.
> 
>>> Most likely you do not. And the RAID's main purpose in that case is to just
>>> have a unified storage pool, for the convenience of not having to manage free
>>> space across so many drives. But given the above, I would suggest leaving the
>>> drives with their individual FSes, and just running MergerFS on top: 
>>> https://www.teknophiles.com/2018/02/19/disk-pooling-in-linux-with-mergerfs/
>>
>> you just move the complexity to something not used by many people for
>> what exactly to gain? the rives are still in the same machine
> 
> To gain total independence of drives from each other, you can pull any drive
> out of the machine, plug it in somewhere else, and it will have a proper
> filesystem and readable files on it. Writable, even.

i have not lost any bit on a raid in my whole lifetime but faced a ton
of drives dying
