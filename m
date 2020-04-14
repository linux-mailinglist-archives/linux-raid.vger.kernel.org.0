Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532E81A88E5
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 20:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503638AbgDNSO1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 14:14:27 -0400
Received: from vps.thesusis.net ([34.202.238.73]:42664 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503655AbgDNSOX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Apr 2020 14:14:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 784732C0B3;
        Tue, 14 Apr 2020 14:14:21 -0400 (EDT)
Received: from vps.thesusis.net ([IPv6:::1])
        by localhost (ip-172-26-1-203.ec2.internal [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id KWTpvtRAyTZb; Tue, 14 Apr 2020 14:14:21 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 35E912C0B6; Tue, 14 Apr 2020 14:14:21 -0400 (EDT)
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Phillip Susi <phill@thesusis.net>
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
In-reply-to: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
Date:   Tue, 14 Apr 2020 14:14:21 -0400
Message-ID: <875ze23pfm.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Stefanie Leisestreichler writes:

> To be safe on system updates I want to use LVM snapshots. I like to make 
> a LVM-based snapshot when the system comes up, do the system updates, 
> perform the test and dicide either to go with the updates made or revert 
> to the original state.

Tradditional LVM snapshots were not suitable for keeping multiple, long
lived snapshots around.  They were really only for temporary use, such
as taking a snapshot to do a dump of without having to shut down
services.  I seem to remember they were developing a new multi snapshot
dm backend that would address some of these shortcomings, but I can't
find anything about that now in the google machine.

> I have read that - when using UEFI - the EFI-System-Partition (ESP) has 
> to reside in a own native partition, not in a RAID nor LVM block device.

Correct.

> I wonder, how I should build up this construct. I thought I could build 
> one partition with TOTAL_SIZE - 100M, Type FD00, on each device, take 
> these two (sda1 + sdb1) and build a RAID 1 array named md0. Next make 
> md0 the physical volume of my LVM (pvcreate /dev/md0) and after that add 
> a volume group in which I put my logical volumes:
> - swap - type EF00

EF00 is a GPT partition type.  Since this is a logical volume rather
than a GPT partition, there is no EF00.

> - /boot - with filesystem fat32 for uefi

Like you mentioned above, this needs to be a native partition, not a
logical volume.  Actually you only need /boot/EFI in a native fat32
partition, not all of /boot.

