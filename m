Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D53CD3C8BE
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405310AbfFKKVF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 06:21:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405303AbfFKKVF (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 11 Jun 2019 06:21:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AEF713A4D;
        Tue, 11 Jun 2019 10:21:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 660A1100033E;
        Tue, 11 Jun 2019 10:21:02 +0000 (UTC)
Subject: Re: RAID-6 aborted reshape
To:     ColtBoyd@Gmail.com, linux-raid@vger.kernel.org
References: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
 <008b01d52000$d1628040$742780c0$@Gmail.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <039a6e10-b3f7-a803-2895-98068ea9de06@redhat.com>
Date:   Tue, 11 Jun 2019 18:21:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <008b01d52000$d1628040$742780c0$@Gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 11 Jun 2019 10:21:05 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 06/11/2019 10:53 AM, Colt Boyd wrote:
> Is there anything that can be done?
>
> -----Original Message-----
> From: Colt Boyd <coltboyd@gmail.com>
> Sent: Saturday, June 8, 2019 10:48 AM
> To: linux-raid@vger.kernel.org
> Subject: RAID-6 aborted reshape
>
> I was resizing a raid6 array with a internal write intent bitmap from
> 5 3TB drives (in RAID6) to 6 drives. It was aborted very early in reshape via reboot and then reassembled with:
> 'mdadm -A /dev/md0 --force --verbose --update=revert-reshape --invalid-backup /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1 /dev/sdg1'

Does this command finish? I tried this myself with this command. The 
filesystem is good after this command.
I interrupt the reshape by `mdadm -S /dev/md0` before assembling it.

Then I did another test. I interrupted the reshape by `echo b > 
/proc/sysrq-trigger`. Then tried to assemble the raid
by your command. It gave the error message:

[root@dell-per720-08 home]# mdadm -A /dev/md0 --force --verbose 
--update=revert-reshape --invalid-backup /dev/loop[0-4]
mdadm: looking for devices for /dev/md0
mdadm: Reshape position is not suitably aligned.
mdadm: Try normal assembly and stop again


Then I used this command to try to assemble it:
mdadm -A /dev/md0  --verbose  --invalid-backup /dev/loop[0-4]

The filesystem is good too.

By the way I used the latest upstream version.

Regards
Xiao
>
> When I reassembled it this way I incorrectly thought the backup file was zero bytes. It wasn't. I still have the intact backup file.
>
> I’ve also since tried to reassemble it with the following create but the XFS fs is not accessible:
> 'mdadm --create /dev/md0 --data-offset=1024 --level=6 --raid-devices=5 --chunk=1024K --name=OMV:0 /dev/sdb1 /dev/sde1 /dev/sdc1 /dev/sdd1
> /dev/sdf1 --assume-clean --readonly'
>
> I can see the XFS FS on the drives, example:
> root@OMV1:~# dd if=/dev/sde1 bs=512k count=5 | hexdump -C <snip>
> 00200000  58 46 53 42 00 00 10 00  00 00 00 00 82 f2 c3 00  |XFSB............|
> 00200010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 00200020  4e 2b 04 64 e8 1b 49 d9  a5 20 b5 74 79 94 52 f8  |N+.d..I.. .ty.R.| <snip>
>
> This is what it looked like immediately following the aborted reshape and before attempting to recreate it. This is from the drive that was being added at the time.
>
> /dev/sdg1:
>            Magic : a92b4efc
>          Version : 1.2
>      Feature Map : 0x1
>       Array UUID : f8fdf8d4:d173da32:eaa97186:eaf88ded
>             Name : OMV:0
>    Creation Time : Mon Feb 24 18:19:36 2014
>       Raid Level : raid6
>     Raid Devices : 6
>
>   Avail Dev Size : 5858529280 (2793.56 GiB 2999.57 GB)
>       Array Size : 11717054464 (11174.25 GiB 11998.26 GB)
>    Used Dev Size : 5858527232 (2793.56 GiB 2999.57 GB)
>      Data Offset : 2048 sectors
>     Super Offset : 8 sectors
>     Unused Space : before=1960 sectors, after=2048 sectors
>            State : clean
>      Device UUID : 92e022c9:ee6fbc26:74da4bcc:5d0e0409
>
> Internal Bitmap : 8 sectors from superblock
>      Update Time : Thu Jun  6 10:24:34 2019
>    Bad Block Log : 512 entries available at offset 72 sectors
>         Checksum : 8f0d9eb9 - correct
>           Events : 1010399
>
>           Layout : left-symmetric
>       Chunk Size : 1024K
>
>     Device Role : Active device 5
>     Array State : AAAAAA ('A' == active, '.' == missing, 'R' == replacing)
>
> Where can I go from here to get this back?
>

