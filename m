Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFB124205D
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHKTdK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 15:33:10 -0400
Received: from rin.romanrm.net ([51.158.148.128]:40914 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgHKTdJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 11 Aug 2020 15:33:09 -0400
X-Greylist: delayed 11396 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2020 15:33:08 EDT
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id D882B42E;
        Tue, 11 Aug 2020 19:33:05 +0000 (UTC)
Date:   Wed, 12 Aug 2020 00:33:05 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     George Rapp <george.rapp@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: Recommended filesystem for RAID 6
Message-ID: <20200812003305.6628dd6e@natsu>
In-Reply-To: <ea7232af-a411-6b16-d03e-6b21c14cc5be@thelounge.net>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
 <20200811212305.02fec65a@natsu>
 <ea7232af-a411-6b16-d03e-6b21c14cc5be@thelounge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, 11 Aug 2020 20:57:15 +0200
Reindl Harald <h.reindl@thelounge.net> wrote:

> > Whichever filesystem you choose, you will end up with a huge single point of
> > failure, and any trouble with that FS or the underlying array put all your
> > data instantly at risk. 
> 
> calling an array where you can lose *two* disks as
> single-point-of-failure is absurd

As noted before, not just *disks* can fail, plenty of other things to fail in
a storage server, and they can easily take down, say, a half of all disks, or
random portions of them in increments of four. Even if temporarily -- that
surely will be "unexpected" to that single precious 20TB filesystem. How will
it behave, who knows. Do you know? For added fun, reconnect the drives back 30
seconds later. Oh, let's write to linux-raid for how to bring back a half of
RAID6 from the Spare (S) status. Or find some HOWTO suggesting a random
--create without --assume-clean. And if the FS goes corrupt, now you suddenly
need *all* your backups, not just 1 drive worth of them.

> no raid can replace backups anyways

All too often I've seen RAID being used as an implicit excuse to be lenient
about backups. Heck, I know from personal experience how enticing that can be.

> > Most likely you do not. And the RAID's main purpose in that case is to just
> > have a unified storage pool, for the convenience of not having to manage free
> > space across so many drives. But given the above, I would suggest leaving the
> > drives with their individual FSes, and just running MergerFS on top: 
> > https://www.teknophiles.com/2018/02/19/disk-pooling-in-linux-with-mergerfs/
> 
> you just move the complexity to something not used by many people for
> what exactly to gain? the rives are still in the same machine

To gain total independence of drives from each other, you can pull any drive
out of the machine, plug it in somewhere else, and it will have a proper
filesystem and readable files on it. Writable, even.

Compared to a 16-drive RAID6, where you either have a whopping 14 disks
present, connected, powered, spinning, healthy, online, OR you have useless
binary junk instead of any data.

Of course I do not insist my way is the best for everyone, but I hope now you
can better understand the concerns and reasons for choosing it. :)

-- 
With respect,
Roman
