Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE71C242000
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 20:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgHKS5Y (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 14:57:24 -0400
Received: from mail.thelounge.net ([91.118.73.15]:29003 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKS5Y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Aug 2020 14:57:24 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4BR2Bm5Ps3zXNr;
        Tue, 11 Aug 2020 20:57:15 +0200 (CEST)
Subject: Re: Recommended filesystem for RAID 6
To:     Roman Mamedov <rm@romanrm.net>, George Rapp <george.rapp@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
 <20200811212305.02fec65a@natsu>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <ea7232af-a411-6b16-d03e-6b21c14cc5be@thelounge.net>
Date:   Tue, 11 Aug 2020 20:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811212305.02fec65a@natsu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 11.08.20 um 18:23 schrieb Roman Mamedov:
> On Tue, 11 Aug 2020 00:42:33 -0400
> George Rapp <george.rapp@gmail.com> wrote:
> 
>> Use case is long-term storage of many small files and a few large ones
>> (family photos and videos, backups of other systems, working copies of
>> photo, audio, and video edits, etc.)? Current usable space is about
>> 10TB but my end state vision is probably upwards of 20TB. I'll
>> probably consign the slowest working disks in the server to an archive
>> filesystem, either RAID 1 or RAID 5, for stuff I care less about and
>> backups; the archive part can be ignored for the purposes of this
>> exercise.
>>
>> My question is: what filesystem type would be best practice for my use
>> case and size requirements on the big array? (I have reviewed
>> https://raid.wiki.kernel.org/index.php/RAID_and_filesystems, but am
>> looking for practitioners' recommendations.)  I've run ext4
>> exclusively on my arrays to date, but have been reading up on xfs; is
>> there another filesystem type I should consider? Finally, are there
>> any pitfalls I should know about in my high-level design?
> 
> Whichever filesystem you choose, you will end up with a huge single point of
> failure, and any trouble with that FS or the underlying array put all your
> data instantly at risk. 

calling an array where you can lose *two* disks as
single-point-of-failure is absurd

no raid can replace backups anyways

> Most likely you do not. And the RAID's main purpose in that case is to just
> have a unified storage pool, for the convenience of not having to manage free
> space across so many drives. But given the above, I would suggest leaving the
> drives with their individual FSes, and just running MergerFS on top: 
> https://www.teknophiles.com/2018/02/19/disk-pooling-in-linux-with-mergerfs/

you just move the complexity to something not used by many people for
what exactly to gain? the rives are still in the same machine

"Secondly -- if all of this... is BACKED UP ANYWAY, why even run RAID?"
is pure nosense! the best backups are the ones you never need and before
i setup up something where a dying drive take smore actions then swap
iot i would commit suicide
