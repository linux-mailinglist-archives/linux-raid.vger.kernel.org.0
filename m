Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A78BA1B9
	for <lists+linux-raid@lfdr.de>; Sun, 22 Sep 2019 12:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfIVKG4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Sun, 22 Sep 2019 06:06:56 -0400
Received: from mail.ugal.ro ([193.231.148.6]:51755 "EHLO MAIL.ugal.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbfIVKG4 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 22 Sep 2019 06:06:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by MAIL.ugal.ro (Postfix) with ESMTP id 2823F13A2F54A;
        Sun, 22 Sep 2019 10:06:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ugal.ro
Received: from MAIL.ugal.ro ([127.0.0.1])
        by localhost (mail.ugal.ro [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FXE2bG4K5Lb7; Sun, 22 Sep 2019 13:06:46 +0300 (EEST)
Received: from LPETCU (unknown [10.11.10.80])
        (Authenticated sender: lpetcu)
        by MAIL.ugal.ro (Postfix) with ESMTPA id 5EA4813A2F444;
        Sun, 22 Sep 2019 13:06:46 +0300 (EEST)
Reply-To: <Liviu.Petcu@ugal.ro>
From:   "Liviu Petcu" <Liviu.Petcu@ugal.ro>
To:     "'Sarah Newman'" <srn@prgmr.com>
Cc:     "'John Stoffel'" <john@stoffel.org>, <linux-raid@vger.kernel.org>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro> <23940.1755.134402.954287@quad.stoffel.home> <094701d56f7c$95225260$bf66f720$@ugal.ro> <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com> <23941.15337.175082.79768@quad.stoffel.home> <001e01d5705d$b1785360$1468fa20$@ugal.ro> <8a277324-d9b8-f2c9-bec0-5ed90c6e3eb4@prgmr.com> <004f01d570aa$48705410$d950fc30$@ugal.ro> <006301d570c4$f0353f20$d09fbd60$@ugal.ro> <65e41893-8f77-1bbe-ed58-328364a87f3d@prgmr.com>
In-Reply-To: <65e41893-8f77-1bbe-ed58-328364a87f3d@prgmr.com>
Subject: RE: RAID 10 with 2 failed drives
Date:   Sun, 22 Sep 2019 13:06:27 +0300
Organization: =?utf-8?Q?Universitatea_=E2=80=9EDunarea_de_Jos=E2=80=9D_d?=
        =?utf-8?Q?in_Gala=3Fi?=
Message-ID: <009a01d5712d$65f54ee0$31dfeca0$@ugal.ro>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLQ1+hi3KIqiub/RHQRSTvcyI2F0wLfsDrkAugv2EMBTTr/eQIDR3BRAZijxEMB9pN1IQH07GyeAc9ve1QBiwO4z6Sw6LWQ
Content-Language: ro
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>On 9/21/19 2:38 PM, Liviu Petcu wrote:
>> 
>> # mdadm --assemble --force /dev/md1 /dev/loop0p2 /dev/loop1p2 /dev/loop2p2 /dev/loop3p2 /dev/loop4p2 /dev/loop5p2
>> mdadm: cannot open device /dev/loop0p2: No such file or directory
>> mdadm: /dev/loop0p2 has no superblock - assembly aborted
>> 
>> It is wrong? Or something I broke?

>You need to run kpartx -av on each loopback device and then access the partitions in /dev/mapper.

I used kpartx like this:

#kpartx -avr /mnt/usb/discX.img

The results:
# ls -al /dev/mapper/

total 0
drwxr-xr-x  2 root root     260 Sep 22 12:16 .
drwxr-xr-x 19 root root   10440 Sep 22 12:16 ..
crw-------  1 root root 10, 236 Sep 22 07:05 control
lrwxrwxrwx  1 root root       7 Sep 22 12:15 loop0p1 -> ../dm-0
lrwxrwxrwx  1 root root       7 Sep 22 12:15 loop0p2 -> ../dm-1
lrwxrwxrwx  1 root root       7 Sep 22 12:15 loop1p1 -> ../dm-2
lrwxrwxrwx  1 root root       7 Sep 22 12:15 loop1p2 -> ../dm-3
lrwxrwxrwx  1 root root       7 Sep 22 12:16 loop2p1 -> ../dm-4
lrwxrwxrwx  1 root root       7 Sep 22 12:16 loop2p2 -> ../dm-5
lrwxrwxrwx  1 root root       7 Sep 22 12:16 loop3p1 -> ../dm-6
lrwxrwxrwx  1 root root       7 Sep 22 12:16 loop3p2 -> ../dm-7
lrwxrwxrwx  1 root root       7 Sep 22 12:16 loop4p1 -> ../dm-8
lrwxrwxrwx  1 root root       7 Sep 22 12:16 loop4p2 -> ../dm-9

#cat /proc/mdstat

Personalities : [linear] [raid0] [raid1] [raid10] [raid6] [raid5] [raid4] [multipath]
md126 : active raid1 dm-8[6](F) dm-6[0] dm-4[7](F) dm-2[8](F)
      4193216 blocks [6/1] [U_____]

md127 : inactive dm-9[3](S) dm-7[0](S) dm-5[5](S) dm-3[4](S) dm-1[2](S)
      9746595840 blocks

unused devices: <none>

But comparing with the mdadm status at the time of failure, it looks different:

#cat mdstat.txt

Personalities : [raid1] [raid10] 
md1 : active raid10 sdb2[0] sda2[5] sdf2[4] sde2[3] sdd2[6](F) sdc2[7](F)
      5835374592 blocks 256K chunks 2 offset-copies [6/4] [U__UUU]
      
md0 : active raid1 sdb1[0] sda1[5] sdf1[4] sde1[3] sdd1[6](F) sdc1[7](F)
      4193216 blocks [6/4] [U__UUU]

My question is: is it possible that these differences are due to the fact that I initially started the system with a live cd to copy the discs? 
I saw then that it tried to start the raid and then I shutdown the system and removed the disks and installed them on another computer to copy them...

Thank you.



