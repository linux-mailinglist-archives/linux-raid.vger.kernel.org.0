Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38DCF7A7B6
	for <lists+linux-raid@lfdr.de>; Tue, 30 Jul 2019 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfG3MI4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jul 2019 08:08:56 -0400
Received: from mail.thelounge.net ([91.118.73.15]:21629 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfG3MI4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Jul 2019 08:08:56 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45yb1x6YHYzXQV;
        Tue, 30 Jul 2019 14:08:48 +0200 (CEST)
Subject: Re: RAID-1 from SAS to SSD
To:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <CAJH6TXjer-gs4bwOCLkdi4xXm-g17ZLMZT1zCHig2Cip5Xokmw@mail.gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <89fb870c-bd03-ac7c-e83d-469f6b1296c4@thelounge.net>
Date:   Tue, 30 Jul 2019 14:08:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJH6TXjer-gs4bwOCLkdi4xXm-g17ZLMZT1zCHig2Cip5Xokmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 30.07.19 um 13:07 schrieb Gandalf Corvotempesta:
> as I need more space and I have some free slots on the server, can I
> replace 1 by 1 (by adding a new disk and removing the old one from the
> array when done), with some SSDs ?
> 
> Something like this:
> 
> # Sync disk partitions
> sfdisk --dump /dev/sda | sfdisk /dev/sdc
> sfdisk --dump /dev/sdb | sfdisk /dev/sdd
> 
> # Rebuild array
> mdadm /dev/md0 --add /dev/sdc1
> mdadm /dev/md0 --replace /dev/sda1 --with /dev/sdc1
> mdadm /dev/md0 --add /dev/sdd1
> mdadm /dev/md0 --replace /dev/sdb1 --with /dev/sdd1
> 
> This should replace, with no loss of redundancy, sda with sdc and sdb with sdd.
> Then I have to re-install the bootloaded on new disks and reboot to
> run from the SSDs
> 
> Any thoughts ? What about LVM ?  By syncing the disk partitions and
> the undelying array, LVM should be up & running on next reboot
> automatically, even if moved from SAS to SSD, right?

mdraid don't care and LVM can't care because it sees just block devices

for BIOS setups i use that script for years now to clone the MBR and
install the bootloader on the replaced disk on several machines while my
home machine  got 2 out of 4 repalced with SSD two years ago and last
summer the remaining two where replaced by Samsung Evo860 2 TB

[root@srv-rhsoft:/downloads]$ LANG=C df
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/md1       ext4   29G  7.4G   22G  26% /
/dev/md0       ext4  485M   44M  437M  10% /boot
/dev/md2       ext4  3.6T  1.7T  2.0T  46% /mnt/data

--------------------------

[root@srv-rhsoft:/downloads]$ cat /scripts/raid-recovery.sh
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
