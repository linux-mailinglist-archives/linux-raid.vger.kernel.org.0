Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14F21A7E0E
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbgDNNaG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 09:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732257AbgDNNaC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Apr 2020 09:30:02 -0400
X-Greylist: delayed 1679 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 06:30:02 PDT
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFC7C061A0C
        for <linux-raid@vger.kernel.org>; Tue, 14 Apr 2020 06:30:02 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jOLCU-0004eG-0g; Tue, 14 Apr 2020 15:02:02 +0200
To:     linux-raid@vger.kernel.org
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Subject: Setup Recommendation on UEFI/GRUB/RAID1/LVM
Message-ID: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
Date:   Tue, 14 Apr 2020 15:02:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1586871002;72319d0f;
X-HE-SMSGID: 1jOLCU-0004eG-0g
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi List.
I want to set up a new server. Data should be redundant that is why I 
want to use RAID level 1 using 2 HDs, each having 1TB. Like suggested in 
the wiki, I want to have the RAID running on a partition which has 
TOTAL_SIZE - 100M allocated for smoother replacement of an array-disk in 
case of failure.

The firmware is UEFI, Partitioning will be made using GPT/gdisk.

Boot manager should be GRUB (not legacy).

To be safe on system updates I want to use LVM snapshots. I like to make 
a LVM-based snapshot when the system comes up, do the system updates, 
perform the test and dicide either to go with the updates made or revert 
to the original state.

I have read that - when using UEFI - the EFI-System-Partition (ESP) has 
to reside in a own native partition, not in a RAID nor LVM block device.

Also I read a recommendation to put SWAP in a seperate native partition 
and raid it in case you want to avoid a software crash when 1 disk fails.

I wonder, how I should build up this construct. I thought I could build 
one partition with TOTAL_SIZE - 100M, Type FD00, on each device, take 
these two (sda1 + sdb1) and build a RAID 1 array named md0. Next make 
md0 the physical volume of my LVM (pvcreate /dev/md0) and after that add 
a volume group in which I put my logical volumes:
- swap - type EF00
- /boot - with filesystem fat32 for uefi
- /home - ext4
- /tmp - ext4
- / - ext4
- /var/lib/mysql - ext4 with special mount options
- /var/lib/vmimages - ext4 with special mount options

Is this doable or is it not working since UEFI will not find my 
bootimage, because in this config it is sitting not in an own native 
partition?

If it is not doable, do you see any suitable setup to archive my goals? 
I do not want to use btrfs.

Thanks,
Steffi

