Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A61E14B7
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 21:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389909AbgEYTUn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 15:20:43 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:51989 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389460AbgEYTUm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 25 May 2020 15:20:42 -0400
Received: from [81.154.111.47] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jdIeN-0005pp-9L; Mon, 25 May 2020 20:20:40 +0100
Subject: Re: help requested for mdadm grow error
To:     Thomas Grawert <thomasgrawert0282@gmail.com>,
        linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Cc:     Phil Turmel <philip@turmel.org>
Message-ID: <5ECC1A86.3010104@youngman.org.uk>
Date:   Mon, 25 May 2020 20:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 25/05/20 20:05, Thomas Grawert wrote:
> The EFAX had me worried a moment, but these are 12TB Reds? That's fine.
>> A lot of the smaller drives are now shingled, ie not fit for purpose!
>>
>> Debian 10 - I don't know my Debians - how up to date is that? Is it a
>> new kernel with not much backports, or an old kernel full of backports?
>>
>> What version of mdadm?
>>
>>
>> That said, everything looks good. There are known problems - WITH FIXES
>> - growing a raid 5 so I suspect you've fallen foul of one. I'd sort out
>> a rescue disk that you can boot off as you might need it. Once we know a
>> bit more the fix is almost certainly a rescue disk and resume the
>> reshape, or a revert-reshape and then reshaping from a rescue disk. At
>> which point, you'll get your array back with everything intact.
> 
> yes, that´s the 12TB WD-Red - I´m using five pieces of it.
> 
> The Debian 10 is the most recent one. Kernel version is 4.9.0-12-amd64.
> mdadm-version is v3.4 from 28th Jan 2016 - seems to be the latest,
> because I can´t upgrade to any newer one using apt upgrade.

OW! OW! OW!

The newest mdadm is 4.1 or 4.2. UPGRADE NOW. Just download and build it
from the master repository - the instructions are in the wiki.

And if Debian 10 is the latest, kernel 4.9 will be a
franken-patched-to-hell-kernel ... I believe the latest kernel is 5.6?
> 
> I don´t think I need a rescue disk, because the raid isn´t bootable.
> It´s simply a big storage.
> 
Okay, the latest mdadm *might* fix your problem. However, you probably
need a proper up-to-date kernel as well, so you DO need a rescue disk.
Unless Debian has the option of upgrading the kernel to a 5.x series
kernel which hopefully isn't patched to hell and back?

This looks like the classic "I'm running ubuntu with a franken-kernel
and raid administration no longer works" problem.

I'm guessing (an educated "probably right" guess) that your reshape has
hung at 0% complete. So the fix is to get your rescue disk, use the
latest mdadm to do a revert-reshape, then use the latest kernel and
mdadm to do the reshape, before booting back in to your old Debian and
carrying as if nothing had happened.

Cheers,
Wol

