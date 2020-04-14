Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED871A8BED
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 22:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505485AbgDNUF0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 16:05:26 -0400
Received: from mail-out-auth3.hosts.co.uk ([85.233.191.1]:28757 "EHLO
        mail-out-auth3.hosts.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2505445AbgDNUF0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Apr 2020 16:05:26 -0400
X-Greylist: delayed 8994 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2020 16:05:25 EDT
Received: from [81.157.200.200] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jORoB-0006tD-C8; Tue, 14 Apr 2020 21:05:24 +0100
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <875ze23pfm.fsf@vps.thesusis.net>
 <f415cfb3-9612-d29d-17c1-d34405233519@peter-speer.de>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <13d82398-337f-6dae-cfe8-5f23ae413c23@youngman.org.uk>
Date:   Tue, 14 Apr 2020 21:05:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f415cfb3-9612-d29d-17c1-d34405233519@peter-speer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/04/2020 20:00, Stefanie Leisestreichler wrote:
>>> I have read that - when using UEFI - the EFI-System-Partition (ESP) has
>>> to reside in a own native partition, not in a RAID nor LVM block device.
>>
>> Correct.

> This is exactly the point which I do not understand. So it is implicitly 
> saying that it makes no sense to raid the 2 EFI-System-Partitions (sda1 
> + sdb1), i.e. as /dev/md124, as GRUB can not write to a RAID device and 
> instead uses /dev/sda1 and no automatic sync will happen?
> 
> If that is true, I wonder how to setup a system using RAID 1 where you 
> can - frankly spoken - remove one or the other disk and boot it :-(

Because you haven't got to grips with how EFI boots a computer.

The CPU starts, jumps into the mobo rom, and then looks for an EFI 
partition on the disk. Because it understands VFAT, it then reads the 
EFI boot loader from the partition.

I don't quite get this myself, but this is where it gets confusing. EFI 
I think offers you a choice of bootloaders, which CAN include grub, 
which then offers you a choice of operating systems. But EFI can offer 
you a list of operating systems, too, which is why I said why did you 
want to use grub?

The whole point here is nothing to do with "grub can or can't write to a 
raid" - grub doesn't write to the disk! The point is that EFI is active 
BEFORE grub or linux even get a look-in. So if EFI writes to the efi 
partition, then that's before grub or linux even get a chance to do 
anything!

A lot of EFI is managed from the operating system. So if you do a v0.9 
or v1.0 raid-1, anything you do from within linux will be mirrored, and 
there's no problem. The problem is if anything modifies the efi 
partition outside of linux we have a problem. And because the whole 
point of efi is to be there before linux even starts, then it's 
*probable* that something will come along and do just that!

Cheers,
Wol
