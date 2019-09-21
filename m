Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2AEB9FC9
	for <lists+linux-raid@lfdr.de>; Sat, 21 Sep 2019 23:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfIUVjM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Sat, 21 Sep 2019 17:39:12 -0400
Received: from mail.ugal.ro ([193.231.148.6]:10686 "EHLO MAIL.ugal.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfIUVjM (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 21 Sep 2019 17:39:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by MAIL.ugal.ro (Postfix) with ESMTP id 3279C13A2F4EF;
        Sat, 21 Sep 2019 21:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ugal.ro
Received: from MAIL.ugal.ro ([127.0.0.1])
        by localhost (mail.ugal.ro [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 74veSpblXIN3; Sun, 22 Sep 2019 00:39:02 +0300 (EEST)
Received: from LPETCU (unknown [10.11.10.80])
        (Authenticated sender: lpetcu)
        by MAIL.ugal.ro (Postfix) with ESMTPA id 6BD3613A2ED6A;
        Sun, 22 Sep 2019 00:39:02 +0300 (EEST)
Reply-To: <Liviu.Petcu@ugal.ro>
From:   "Liviu Petcu" <Liviu.Petcu@ugal.ro>
To:     "'Sarah Newman'" <srn@prgmr.com>
Cc:     "'John Stoffel'" <john@stoffel.org>, <linux-raid@vger.kernel.org>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro> <23940.1755.134402.954287@quad.stoffel.home> <094701d56f7c$95225260$bf66f720$@ugal.ro> <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com> <23941.15337.175082.79768@quad.stoffel.home> <001e01d5705d$b1785360$1468fa20$@ugal.ro> <8a277324-d9b8-f2c9-bec0-5ed90c6e3eb4@prgmr.com> <004f01d570aa$48705410$d950fc30$@ugal.ro>
In-Reply-To: <004f01d570aa$48705410$d950fc30$@ugal.ro>
Subject: RE: RAID 10 with 2 failed drives
Date:   Sun, 22 Sep 2019 00:38:42 +0300
Organization: =?utf-8?Q?Universitatea_=E2=80=9EDunarea_de_Jos=E2=80=9D_d?=
        =?utf-8?Q?in_Gala=3Fi?=
Message-ID: <006301d570c4$f0353f20$d09fbd60$@ugal.ro>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLQ1+hi3KIqiub/RHQRSTvcyI2F0wLfsDrkAugv2EMBTTr/eQIDR3BRAZijxEMB9pN1IQH07GyepMrvQAA=
Content-Language: ro
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/21/19 2:19 AM, Liviu Petcu wrote:
>>> Yes. Only one of the 2 disks reported by mdadm as failed, is broken. I
>>> almost finished making images of all the discs, and for the second "failed"
>>> disc ddrescue reported error-free copying. I intend to use the images to
>>> recreate the array. I haven't done this before, but I hope I can handle
>>> it...

>>If by recreate you mean run mdadm --create, you really shouldn't start with that - it's easy to get wrong.

>>You can almost certainly use mdadm --assemble --force per
>https://raid.wiki.kernel.org/index.php/RAID_Recovery

>Yes, I'll do that and all other attempts, with disk images as read only attached loop devices.
>Liviu


Sorry. I can not handle it. Here's what I did:
#losetup --find --show -r /mnt/usb/discX.img
# losetup --list
NAME         SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO
/dev/loop1           0      0         0  1 /mnt/usb/disc3.img            0
/dev/loop253         0      0         0  0 /m.sqfs (deleted)             0
/dev/loop4           0      0         0  1 /mnt/usb/disc6.img            0
/dev/loop2           0      0         0  1 /mnt/usb/disc4.img            0
/dev/loop254         0      0         0  0 /run/PMAGIC_2016_10_18.SQFS   0
/dev/loop0           0      0         0  1 /mnt/usb/disc2.img            0
/dev/loop252         0      0         0  0 /fu.sqfs (deleted)            0
/dev/loop3           0      0         0  1 /mnt/usb/disc5.img            0

So /dev/loop[01234] are now read only drives

#fdisk -l

Disk /dev/loop0: 1.8 TiB, 2000398934016 bytes, 3907029168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A95A32BD-3198-4C9B-8445-BAC177AA5B31

Device         Start        End    Sectors  Size Type
/dev/loop0p1    2048    8388641    8386594    4G Linux RAID
/dev/loop0p2 8390656 3907029134 3898638479  1.8T Linux RAID


Disk /dev/loop1: 1.8 TiB, 2000398934016 bytes, 3907029168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A95A32BD-3198-4C9B-8445-BAC177AA5B31

Device         Start        End    Sectors  Size Type
/dev/loop1p1    2048    8388641    8386594    4G Linux RAID
/dev/loop1p2 8390656 3907029134 3898638479  1.8T Linux RAID


Disk /dev/loop2: 1.8 TiB, 2000398934016 bytes, 3907029168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A95A32BD-3198-4C9B-8445-BAC177AA5B31

Device         Start        End    Sectors  Size Type
/dev/loop2p1    2048    8388641    8386594    4G Linux RAID
/dev/loop2p2 8390656 3907029134 3898638479  1.8T Linux RAID


Disk /dev/loop3: 1.8 TiB, 2000398934016 bytes, 3907029168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A95A32BD-3198-4C9B-8445-BAC177AA5B31

Device         Start        End    Sectors  Size Type
/dev/loop3p1    2048    8388641    8386594    4G Linux RAID
/dev/loop3p2 8390656 3907029134 3898638479  1.8T Linux RAID


Disk /dev/loop4: 1.8 TiB, 2000398934016 bytes, 3907029168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A95A32BD-3198-4C9B-8445-BAC177AA5B31

Device         Start        End    Sectors  Size Type
/dev/loop4p1    2048    8388641    8386594    4G Linux RAID
/dev/loop4p2 8390656 3907029134 3898638479  1.8T Linux RAID


# mdadm --assemble --force /dev/md1 /dev/loop0p2 /dev/loop1p2 /dev/loop2p2 /dev/loop3p2 /dev/loop4p2 /dev/loop5p2
mdadm: cannot open device /dev/loop0p2: No such file or directory
mdadm: /dev/loop0p2 has no superblock - assembly aborted

It is wrong? Or something I broke? 

Thanks.
Liviu



