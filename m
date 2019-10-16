Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8DD9C2C
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 23:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437351AbfJPVDx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 17:03:53 -0400
Received: from mail.thelounge.net ([91.118.73.15]:62961 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfJPVDw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 16 Oct 2019 17:03:52 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 46tlCB03vFzXLw;
        Wed, 16 Oct 2019 23:03:49 +0200 (CEST)
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
 <cec07a1f-8497-1589-52ef-e89550630956@npc-usa.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <2c3fc7f6-9bdf-4e94-dc45-7b74e3176916@thelounge.net>
Date:   Wed, 16 Oct 2019 23:03:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cec07a1f-8497-1589-52ef-e89550630956@npc-usa.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 16.10.19 um 23:01 schrieb Curtis Vaughan:
> Switched out bad hard drive and added a brand new one.
> 
> Now I thought I should just run:
> 
> sudo mdadm --add /dev/md1 /dev/sda2
> sudo mdadm --add /dev/md1 /dev/sda1
> 
> and the raid would be back up and running (RAID1, btw). But I think it
> won't add sda1 or sda2 cause they don't exist. So it seems I need to
> first partition the drive? But how do I partition EXACTLY like the
> other? Or is there another way?

if the disks are *not* GPT it's easy, the script below is from a 4 disk
RAID10 and the exit is there by intention to not call it by accident

[root@srv-rhsoft:~]$ df
Dateisystem    Typ  Größe Benutzt Verf. Verw% Eingehängt auf
/dev/md1       ext4   29G    7,3G   22G   26% /
/dev/md0       ext4  485M     47M  435M   10% /boot
/dev/md2       ext4  3,6T    1,7T  2,0T   46% /mnt/data

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
