Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0DB27EA9F
	for <lists+linux-raid@lfdr.de>; Wed, 30 Sep 2020 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgI3OJI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Sep 2020 10:09:08 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:11286 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbgI3OJI (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 30 Sep 2020 10:09:08 -0400
Received: from host86-157-96-171.range86-157.btcentralplus.com ([86.157.96.171] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1kNcn3-000Byq-9h; Wed, 30 Sep 2020 15:09:05 +0100
Subject: Re: RAID5->RAID6 reshape remains stuck at 0% (does nothing, not even
 start)
To:     David Madore <david+ml@madore.org>
Cc:     Linux RAID mailing-list <linux-raid@vger.kernel.org>
References: <20200930014032.pd4csjwu3m7uihin@achernar.gro-tsen.net>
 <5F740390.7050005@youngman.org.uk>
 <20200930090031.6lzrs336fr4inpz4@achernar.gro-tsen.net>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <90338e5b-9ed4-c86e-fa35-8acdd6768ca7@youngman.org.uk>
Date:   Wed, 30 Sep 2020 15:09:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930090031.6lzrs336fr4inpz4@achernar.gro-tsen.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30/09/2020 10:00, David Madore wrote:
> On Wed, Sep 30, 2020 at 05:03:28AM +0100, Wols Lists wrote:
>> uname -a ???
> 
> Linux vega.stars 4.9.237-vega #1 SMP Tue Sep 29 23:52:36 CEST 2020 x86_64 GNU/Linux
> 
> This is a stock 4.9.237 kernel that I compiled with gcc version 4.8.4
> (Debian 4.8.4-1).  RAID-related options in the config are:
> 
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_AUTODETECT=y
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=y
> CONFIG_MD_RAID1=y
> CONFIG_MD_RAID10=m
> CONFIG_MD_RAID456=m
> CONFIG_MD_MULTIPATH=m
> CONFIG_MD_FAULTY=m
> # CONFIG_MD_CLUSTER is not set
> CONFIG_ASYNC_RAID6_RECOV=m
> CONFIG_RAID6_PQ=m
> 
> (I can, of course, put the full config somewhere).
> 
>> mdadm --version ???
> 
> mdadm - v3.4 - 28th January 2016
> 
> (This is the version from Debian 9.13 "stretch" (aka oldstable).)
> 
>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn

So my guess was spot on :-)

You'll guess that this is a common problem, with a well-known solution...

https://raid.wiki.kernel.org/index.php/Easy_Fixes#Debian_9_and_Ubuntu
> 
> I should have clarified that I suffered no data loss.  Since the
> attempt to reshape simply does nothing (and the underlying filesystem
> was read-only just in case), I was able to simply recreate the RAID5
> array with --assume-clean.  But I'd really like to convert to RAID6.
> 
> I can, of course, provide detailed information on the disks, but since
> I can reproduce the problem on loopback devices, I imagine this isn't
> too relevant.
> 
>> I'm guessing you're on an older version of Ubuntu / Debian ?
> 
> Yes, Debian 9.13 "stretch" (aka oldstable).
> 
That web page tells you, but basically it's what I call the 
"frankenkernel problem" - the kernel has been updated to buggery, mdadm 
is out-of-date, and they are not regression-tested. The reshape gets 
stuck trying to start.

So the fix is to use an up-to-date rescue disk with matched kernel and 
mdadm to do the reshape.

Oh - and once you're all back up and running, I'd build the latest mdadm 
and upgrade to that. And don't try to reshape the array again, unless 
you've upgraded your distro to something recent :-)

Cheers,
Wol
