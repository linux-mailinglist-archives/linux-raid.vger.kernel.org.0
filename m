Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D8A13A1A0
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jan 2020 08:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgANHYD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jan 2020 02:24:03 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:64610 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbgANHYD (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Jan 2020 02:24:03 -0500
Received: from [81.135.72.163] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1irGYR-0006l1-8d; Tue, 14 Jan 2020 07:24:00 +0000
Subject: Re: Debian Squeeze raid 1 0
To:     Rickard Svensson <myhex2020@gmail.com>, linux-raid@vger.kernel.org
References: <CAC4UdkbjUVSpkBM88HB0UJMqXh+Pd7CRLaya=s81xMGs-9+m_Q@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5E1D6C8E.8030607@youngman.org.uk>
Date:   Tue, 14 Jan 2020 07:23:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAC4UdkbjUVSpkBM88HB0UJMqXh+Pd7CRLaya=s81xMGs-9+m_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 13/01/20 23:34, Rickard Svensson wrote:
> Hi all
> 
> One disk in my raid 1 0 failed the other night.
> It has been running for +8 years, on my server, a Debian Squeeze.

8 years old, debian squeeze, what version of mdadm is that.

> (And yes, I was just about to update them, bought the HD's and everything)
> 
Great. First things first, ddrescue all drives on to the new ones! I
think recovering your data won't be too hard, so might as well back up
the data on to your new drives then recover that.

> I thought that i would be able to backup the data, but i got ext4
> error aswell, and when i tried to repair that with fsck i got:
> "
> # fsck -n /dev/md0
> fsck.ext4: Attempt to read block from filesystem resulted in short
> read while trying to open /dev/md0
> Could this be a zero-length partition?
> "
My fu isn't good here but I strongly suspect the read failed with an
"array not running" problem ...
> 
> So i am wondering if my mdadm raid is okay.
> The "State  [clean|active]" and "Array State : AA.."    is not so easy
> to interpret, tried to read parts of the threads, but at the same time
> is worried that more disks should failt... And I'm starting to get
> really stressed :(

All the more reason to ddrescue your disks ...
> 
> All the disk are the same type.  And apparently does not support SCT,
> which I was not aware of before.
> /dev/sde2  seems to be gone.
> 
Can you check the drive in another system? Is it the drive, or is it a
controller issue?

The fact that the three event counts we have are near-identical is a
good sign. The worry is that sde2 disappeared a long time ago - have you
been monitoring the system? If you ddrescue it will it give an event
count almost the same as the others? If it does, that makes me suspect a
controller issue has knocked two drives out, one of which has recovered
and the other hasn't ...
> "
> cat /proc/mdstat
> Personalities : [raid10]
> md0 : active raid10 sda2[0] sde2[3](F) sdc2[2](F) sdb2[1]
>       5840999424 blocks super 1.2 512K chunks 2 near-copies [4/2] [UU__]
> "

<snip>
> 
> 
> I really hope someone can help me!
> 
https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn

Note that when it says "use the latest version of mdadm" it means it - I
suspect your version may be well out-of-date.

Give us a bit more information, especially the version of mdadm you're
using. See if you can ddrescue /dev/sde, and what that tells us, and I
strongly suspect a forced assembly of (copies of) your surviving disks
will recover almost everything.

Cheers,
Wol


