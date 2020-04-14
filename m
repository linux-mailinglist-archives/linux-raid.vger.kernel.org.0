Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC31A8433
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 18:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbgDNQIf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 12:08:35 -0400
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:43544 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388269AbgDNQIe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Apr 2020 12:08:34 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2020 12:08:33 EDT
Received: from [192.168.50.137] ([24.64.114.53])
        by shaw.ca with ESMTPA
        id ONysjQWcg7t92ONz2jPrpy; Tue, 14 Apr 2020 10:00:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shaw.ca;
        s=s20180605; t=1586880020;
        bh=6ghhk8Yc/ekjHAstADL0vqtajCLu3BNMjEOTzIdHlXM=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=m6PRy6mOCQR+ihOwjM1uie0P0aBTgQ+cItjH+tyLLw+Ri0Ki5nzEcWYb+YuwzcoKc
         ZNEhuEa0HN4JMiS/wDYhlIj0eSPSqNocuvk9pBDz34EgI1N4Bpmk12P0nUYZcbeFDd
         1DPOS+5BF8lkxmqFApdaW6NAYVLCGxflp2yyq7Z+qrEfo7QouvCw2t+ktaJviGQ3cJ
         4ggowyeE/kT8Dq1IhX4FcJT0T4fXBOuIAIPvZyts5DOkaNvM06ZJW8xj5bbFmtdUbp
         RhF6Oz6vPZHZcBE5DobOjxHALCzeQLwTqWZz5Lhp9iR5dW3SdKQpj3QB/cR5XTvkuF
         5D4RLhe3d5wmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shaw.ca;
        s=s20180605; t=1586880020;
        bh=6ghhk8Yc/ekjHAstADL0vqtajCLu3BNMjEOTzIdHlXM=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=m6PRy6mOCQR+ihOwjM1uie0P0aBTgQ+cItjH+tyLLw+Ri0Ki5nzEcWYb+YuwzcoKc
         ZNEhuEa0HN4JMiS/wDYhlIj0eSPSqNocuvk9pBDz34EgI1N4Bpmk12P0nUYZcbeFDd
         1DPOS+5BF8lkxmqFApdaW6NAYVLCGxflp2yyq7Z+qrEfo7QouvCw2t+ktaJviGQ3cJ
         4ggowyeE/kT8Dq1IhX4FcJT0T4fXBOuIAIPvZyts5DOkaNvM06ZJW8xj5bbFmtdUbp
         RhF6Oz6vPZHZcBE5DobOjxHALCzeQLwTqWZz5Lhp9iR5dW3SdKQpj3QB/cR5XTvkuF
         5D4RLhe3d5wmw==
X-Authority-Analysis: v=2.3 cv=Os7UNx3t c=1 sm=1 tr=0
 a=aoFTOZhfXO3lFit9ECvAag==:117 a=aoFTOZhfXO3lFit9ECvAag==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=ZRtV1N-EfgzegkHkkGoA:9
 a=QEXdDO2ut3YA:10
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
From:   G <garboge@shaw.ca>
Message-ID: <f9f2f479-2899-6774-eb20-bf81ed24bc7b@shaw.ca>
Date:   Tue, 14 Apr 2020 10:00:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfEoEqIsjyilgyNAlFwYa+uQwAj4ivyoCyXZ2Ba2JB/bzWKIcg52xYGMq4nL8zX3JqVwjn6M5StRywwH5xGmqnJ+CMgciLu6KRUJKeaQMrSiC+tEmXCdy
 j6T1fbbNJnDOtZZYwmeIRrEZmqPWuY9T1HRv7u5Shpw5OdtgEJpGjapx/iHJLk7VAU2q/pkcLYyqeZ9lfgwVolkXgRh1qPfVJUSQ1pwz50AMXut+wbs2SbrI
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020-04-14 7:02 a.m., Stefanie Leisestreichler wrote:
> Hi List.
> I want to set up a new server. Data should be redundant that is why I 
> want to use RAID level 1 using 2 HDs, each having 1TB. Like suggested 
> in the wiki, I want to have the RAID running on a partition which has 
> TOTAL_SIZE - 100M allocated for smoother replacement of an array-disk 
> in case of failure.
>
> The firmware is UEFI, Partitioning will be made using GPT/gdisk.
>
> Boot manager should be GRUB (not legacy).
>
> To be safe on system updates I want to use LVM snapshots. I like to 
> make a LVM-based snapshot when the system comes up, do the system 
> updates, perform the test and dicide either to go with the updates 
> made or revert to the original state.
>
> I have read that - when using UEFI - the EFI-System-Partition (ESP) 
> has to reside in a own native partition, not in a RAID nor LVM block 
> device.
>
> Also I read a recommendation to put SWAP in a seperate native 
> partition and raid it in case you want to avoid a software crash when 
> 1 disk fails.
>
> I wonder, how I should build up this construct. I thought I could 
> build one partition with TOTAL_SIZE - 100M, Type FD00, on each device, 
> take these two (sda1 + sdb1) and build a RAID 1 array named md0. Next 
> make md0 the physical volume of my LVM (pvcreate /dev/md0) and after 
> that add a volume group in which I put my logical volumes:
> - swap - type EF00
> - /boot - with filesystem fat32 for uefi
> - /home - ext4
> - /tmp - ext4
> - / - ext4
> - /var/lib/mysql - ext4 with special mount options
> - /var/lib/vmimages - ext4 with special mount options
>
> Is this doable or is it not working since UEFI will not find my 
> bootimage, because in this config it is sitting not in an own native 
> partition?
>
> If it is not doable, do you see any suitable setup to archive my 
> goals? I do not want to use btrfs.
>
> Thanks,
> Steffi
>
>
Hi Stefanie

I don't quite understand your portioning requirements; 100M raid for 
what? Is the remaining larger partition on each disk just LVM'd without 
redundancy. If so 100M is probably minimum for a 'boot' partition with 
the OS residing on the non-redundant lvm.

Since you are running disks less than 2TB I would suggest a more 
rudimentary setup using legacy bios booting. This setup will not allow 
disks greater than 2TB because they would not be partitioned GPT. There 
would still be an ability to increase total storage using more disks. 
There would be raid redundancy with the ability for grub to boot off 
either disk.

Two identical partitions on each disk using mbr partition tables.

200-250M 'boot' partition raid1 metadata 0.9 formatted ext2 (holds linux 
images)

remainder 'root' (and data and possibly 'swapfile' (with ability to 
shrink and grow to a max size)) partition raid1 metadata 1.2 formatted 
ext4 (for mirrored redundancy or no raid for non-raid BOD)

Create raids and filesystems before install using live cd from command 
line. Use -m 1 option in mkfs for reduced 1% system reserved space 
instead of the default 5%.

Of course there could be different partitioning layouts (eg separate 
'home partition')

Install OS using manual partitioner to be able to use partitions as 
required. Install grub to both disks.

Hope this may help

