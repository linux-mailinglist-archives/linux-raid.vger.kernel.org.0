Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F180BDDBE2
	for <lists+linux-raid@lfdr.de>; Sun, 20 Oct 2019 03:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfJTBy7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 19 Oct 2019 21:54:59 -0400
Received: from mail.thelounge.net ([91.118.73.15]:32097 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfJTBy6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 19 Oct 2019 21:54:58 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 46wjWg3hxdzXLw;
        Sun, 20 Oct 2019 03:54:50 +0200 (CEST)
Subject: Re: Degraded RAID1
To:     curtis@npc-usa.com, linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
 <5DA5165E.8070609@youngman.org.uk>
 <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
 <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
 <be94147a-a244-6f71-5f6a-7c6da8515cf9@youngman.org.uk>
 <1a20554d-1a40-f226-28bc-c3d38f8c7014@npc-usa.com>
 <5DA648B9.7030506@youngman.org.uk>
 <006efea0-ec71-3eaf-a456-7fcc2efe4916@npc-usa.com>
 <5212dd1b-b67d-f7fd-a96b-6281f0501740@youngman.org.uk>
 <ac4a6b63-b886-1c0c-3aad-f77b54246226@npc-usa.com>
 <9864d7bd-f2f7-b25e-fa6d-9ca06a9e6b87@youngman.org.uk>
 <5a153cf6-e53d-35d9-6775-e09028799721@npc-usa.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <1b33414d-dd79-6cb1-0f24-d7eed407e490@thelounge.net>
Date:   Sun, 20 Oct 2019 03:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5a153cf6-e53d-35d9-6775-e09028799721@npc-usa.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 20.10.19 um 02:06 schrieb Curtis Vaughan:
> After updates I decided to reboot, but it would never reboot until I
> removed the new drive. I'm wondering if it has something to do with
> needing to installl grub on the new drive?

surely, a workaround would have been switch the cables so that the first
disk is the one which still has grub

grub is at the begin of the drive outisde the array itself and so for
real working redundacy and i posted you days ago my script for drive
replacemnets which clearly installs grub on the new one

[root@srv-rhsoft:~]$ cat /scripts/raid-recovery.sh
#!/usr/bin/bash

GOOD_DISK="/dev/sda"
BAD_DISK="/dev/sdd"

# --------------------------------------------------------------------------

echo "NOT NOW"
exit

# --------------------------------------------------------------------------

# clone MBR
dd if=$GOOD_DISK of=$BAD_DISK bs=512 count=1

# force OS to read partition tables
partprobe $BAD_DISK

# start RAID recovery
mdadm /dev/md0 --add ${BAD_DISK}1
mdadm /dev/md1 --add ${BAD_DISK}2
mdadm /dev/md2 --add ${BAD_DISK}3

# print RAID status on screen
sleep 5
cat /proc/mdstat

# install bootloader on replacement disk
grub2-install "$BAD_DISK"
