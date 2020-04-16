Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C231ABF28
	for <lists+linux-raid@lfdr.de>; Thu, 16 Apr 2020 13:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506048AbgDPL2T (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Apr 2020 07:28:19 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:59994 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632855AbgDPLQ3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Apr 2020 07:16:29 -0400
Received: from [81.157.200.200] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jP2V2-000826-7y; Thu, 16 Apr 2020 12:16:05 +0100
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     "David C. Rankin" <drankinatty@suddenlinkmail.com>,
        mdraid <linux-raid@vger.kernel.org>
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <5E95C698.1030307@youngman.org.uk>
 <461be4bb-a86b-dca0-605f-cda13bc1602d@suddenlinkmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E983E73.8010309@youngman.org.uk>
Date:   Thu, 16 Apr 2020 12:16:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <461be4bb-a86b-dca0-605f-cda13bc1602d@suddenlinkmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 16/04/20 02:50, David C. Rankin wrote:
> On 04/14/2020 09:20 AM, Wols Lists wrote:
>> That's true, but is it worth it? RAM is cheap, max out your motherboard,
>> and try and avoid falling into swap at all. I have one swap partition
>> per disk, but simply set them up as equal priority so the kernel does
>> its own raid-0 stripe across them. Yes a disk failure would kill any
>> apps swapped on to that disk, but my system rarely swaps...
> 
> That's a neat approach, I do it just the opposite and care RAID1 partitions
> for swap (though I rarely swap as well). I've never had an issue restarting
> after a failure (or me doing something dumb like hitting the wrong button on
> the UPS)
> 
> So that I'm understanding, you simply create a swap partition on each disk not
> part of an array, swapon both and let the kernel decide?
> 
Don't forget the mount option "pri=1" ... the following is the relevant
lines from my fstab ...

# /dev/sda2             none            swap            sw,pri=1        0 0
UUID=184b6322-eb42-405e-b958-e55014ce3691       none    swap    sw,pri=1
       0 0
# /dev/sdb2             none            swap            sw,pri=1        0 0
UUID=48913c8d-e4c4-482d-9733-e44be3889f07       none    swap    sw,pri=1
       0 0
# /dev/sdc2             none            swap            sw,pri=1        0 0

If you don't use the priority option, each partition is allocated a
different priority and it fills them up one after the other (raid
linear). Make them all equal priority, and it'll stripe them.

Cheers,
Wol

