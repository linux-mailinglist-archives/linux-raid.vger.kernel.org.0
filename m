Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2E1BBBDC
	for <lists+linux-raid@lfdr.de>; Tue, 28 Apr 2020 13:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgD1LEG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Apr 2020 07:04:06 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:59118 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD1LEG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Apr 2020 07:04:06 -0400
Received: from srv.home ([10.8.0.1] ident=heh11414)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1jTO0z-0004Vk-BA
        for linux-raid@vger.kernel.org; Tue, 28 Apr 2020 19:03:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject; bh=OssSEhSUtGhKb4UkF/gmBqP6xmajKlTiZl0K7Ts7sqo=;
        b=iTqoaJ8pzmJuNZsBEOH+AfwEvtQxoFg8zLkMD2J9QputKI31hQrbIydfD0QU3ss0KEvg1BT0OywrbwkD5tJmja8wbRofFb2lbKVhqp3Zwjwr5lMy8/qYxRHzFGL2AbnhkFOzBqnNfV3SmSoL7vpVss2tY5+f0pXdOlbYedlH+vA=;
Subject: Re: Does a "check" of a RAID6 actually read all disks in a stripe?
From:   Brad Campbell <lists2009@fnarfbargle.com>
To:     linux-raid@vger.kernel.org
References: <18271293-9866-1381-d73e-e351bf9278fd@fnarfbargle.com>
Message-ID: <1ccd57ba-9d9a-d10e-4efd-dc0e8a5cf162@fnarfbargle.com>
Date:   Tue, 28 Apr 2020 19:02:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <18271293-9866-1381-d73e-e351bf9278fd@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 28/4/20 2:47 pm, Brad Campbell wrote:
> G'day all,
> 
> I have a test server with some old disks I use for beating up on. Bear in mind the disks are old and dicey which is *why* they live in a test server. I'm not after reliability, I'm more interested in finding corner cases.
> 
> One disk has a persistent read error (pending sector). This can be identified easily with dd on a specific or whole disk basis.
> 
> The array has 9 2TB drives in a RAID6 :
> 
> md3 : active raid6 sdh[12] sdm[8] sdc[10] sde[6] sdj[9] sdk[4] sdl[11] sdg[13]
>        13673684416 blocks super 1.2 level 6, 64k chunk, algorithm 2 [9/8] [UU_UUUUUU]
>        bitmap: 0/15 pages [0KB], 65536KB chunk
> 
> Ignore the missing disk, it's out right now being secure erased, but it was in for the tests.
> 
> The read error is on sdj, about 23G into the disk :
> 
> [Sun Apr 26 15:05:30 2020] sd 4:0:4:0: [sdj] tag#229 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
> [Sun Apr 26 15:05:30 2020] sd 4:0:4:0: [sdj] tag#229 Sense Key : 0x3 [current]
> [Sun Apr 26 15:05:30 2020] sd 4:0:4:0: [sdj] tag#229 ASC=0x11 ASCQ=0x0
> [Sun Apr 26 15:05:30 2020] sd 4:0:4:0: [sdj] tag#229 CDB: opcode=0x28 28 00 03 39 d8 08 00 20 00 00
> [Sun Apr 26 15:05:30 2020] blk_update_request: critical medium error, dev sdj, sector 54126096 op 0x0:(READ) flags 0x80700 phys_seg 37 prio class 0
> 
> Trigger a "check" :
> [Mon Apr 27 18:51:15 2020] md: data-check of RAID array md3
> [Tue Apr 28 03:42:21 2020] md: md3: data-check done.
> 
> Just to be sure it's still there :
> [Tue Apr 28 14:13:33 2020] sd 4:0:4:0: [sdj] tag#100 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
> [Tue Apr 28 14:13:33 2020] sd 4:0:4:0: [sdj] tag#100 Sense Key : 0x3 [current]
> [Tue Apr 28 14:13:33 2020] sd 4:0:4:0: [sdj] tag#100 ASC=0x11 ASCQ=0x0
> [Tue Apr 28 14:13:33 2020] sd 4:0:4:0: [sdj] tag#100 CDB: opcode=0x28 28 00 03 39 e6 10 00 00 08 00
> [Tue Apr 28 14:13:33 2020] blk_update_request: critical medium error, dev sdj, sector 54126096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> 
> So I can read from the disk with dd and trigger a read error each and every time, but a RAID6 "check" appears to skip over it without triggering the read error.
> 
> For completeness, the complete log :
> [Sun Apr 26 15:05:30 2020] sd 4:0:4:0: [sdj] tag#229 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
> [Sun Apr 26 15:05:30 2020] sd 4:0:4:0: [sdj] tag#229 Sense Key : 0x3 [current]
> [Sun Apr 26 15:05:30 2020] sd 4:0:4:0: [sdj] tag#229 ASC=0x11 ASCQ=0x0
> [Sun Apr 26 15:05:30 2020] sd 4:0:4:0: [sdj] tag#229 CDB: opcode=0x28 28 00 03 39 d8 08 00 20 00 00
> [Sun Apr 26 15:05:30 2020] blk_update_request: critical medium error, dev sdj, sector 54126096 op 0x0:(READ) flags 0x80700 phys_seg 37 prio class 0
> [Sun Apr 26 21:15:47 2020]  sdd: sdd1 sdd2
> [Mon Apr 27 18:51:15 2020] md: data-check of RAID array md3
> [Tue Apr 28 03:42:21 2020] md: md3: data-check done.
> [Tue Apr 28 09:39:18 2020] md/raid:md3: Disk failure on sdi, disabling device.
>                             md/raid:md3: Operation continuing on 8 devices.
> [Tue Apr 28 14:13:33 2020] sd 4:0:4:0: [sdj] tag#100 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
> [Tue Apr 28 14:13:33 2020] sd 4:0:4:0: [sdj] tag#100 Sense Key : 0x3 [current]
> [Tue Apr 28 14:13:33 2020] sd 4:0:4:0: [sdj] tag#100 ASC=0x11 ASCQ=0x0
> [Tue Apr 28 14:13:33 2020] sd 4:0:4:0: [sdj] tag#100 CDB: opcode=0x28 28 00 03 39 e6 10 00 00 08 00
> [Tue Apr 28 14:13:33 2020] blk_update_request: critical medium error, dev sdj, sector 54126096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [Tue Apr 28 14:13:35 2020] sd 4:0:4:0: [sdj] tag#112 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
> [Tue Apr 28 14:13:35 2020] sd 4:0:4:0: [sdj] tag#112 Sense Key : 0x3 [current]
> [Tue Apr 28 14:13:35 2020] sd 4:0:4:0: [sdj] tag#112 ASC=0x11 ASCQ=0x0
> [Tue Apr 28 14:13:35 2020] sd 4:0:4:0: [sdj] tag#112 CDB: opcode=0x28 28 00 03 39 e6 10 00 00 08 00
> [Tue Apr 28 14:13:35 2020] blk_update_request: critical medium error, dev sdj, sector 54126096 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [Tue Apr 28 14:13:35 2020] Buffer I/O error on dev sdj, logical block 6765762, async page read
> 
> Examine on the suspect disk :
> 
> test:/home/brad# mdadm --examine /dev/sdj
> /dev/sdj:
>            Magic : a92b4efc
>          Version : 1.2
>      Feature Map : 0x1
>       Array UUID : dbbca7b5:327751b1:895f8f11:443f6ecb
>             Name : test:3  (local to host test)
>    Creation Time : Wed Nov 29 10:46:21 2017
>       Raid Level : raid6
>     Raid Devices : 9
> 
>   Avail Dev Size : 3906767024 (1862.89 GiB 2000.26 GB)
>       Array Size : 13673684416 (13040.24 GiB 14001.85 GB)
>    Used Dev Size : 3906766976 (1862.89 GiB 2000.26 GB)
>      Data Offset : 262144 sectors
>     Super Offset : 8 sectors
>     Unused Space : before=262056 sectors, after=48 sectors
>            State : clean
>      Device UUID : f1a39d9b:fe217c62:26b065e3:0f859afd
> 
> Internal Bitmap : 8 sectors from superblock
>      Update Time : Tue Apr 28 09:39:23 2020
>    Bad Block Log : 512 entries available at offset 72 sectors
>         Checksum : cb44256b - correct
>           Events : 177156
> 
>           Layout : left-symmetric
>       Chunk Size : 64K
> 
>     Device Role : Active device 5
>     Array State : AA.AAAAAA ('A' == active, '.' == missing, 'R' == replacing)
> 
> test:/home/brad# mdadm --detail /dev/md3
> /dev/md3:
>          Version : 1.2
>    Creation Time : Wed Nov 29 10:46:21 2017
>       Raid Level : raid6
>       Array Size : 13673684416 (13040.24 GiB 14001.85 GB)
>    Used Dev Size : 1953383488 (1862.89 GiB 2000.26 GB)
>     Raid Devices : 9
>    Total Devices : 8
>      Persistence : Superblock is persistent
> 
>    Intent Bitmap : Internal
> 
>      Update Time : Tue Apr 28 09:39:23 2020
>            State : clean, degraded
>   Active Devices : 8
> Working Devices : 8
>   Failed Devices : 0
>    Spare Devices : 0
> 
>           Layout : left-symmetric
>       Chunk Size : 64K
> 
>             Name : test:3  (local to host test)
>             UUID : dbbca7b5:327751b1:895f8f11:443f6ecb
>           Events : 177156
> 
>      Number   Major   Minor   RaidDevice State
>        12       8      112        0      active sync   /dev/sdh
>        13       8       96        1      active sync   /dev/sdg
>         4       0        0        4      removed
>        11       8      176        3      active sync   /dev/sdl
>         4       8      160        4      active sync   /dev/sdk
>         9       8      144        5      active sync   /dev/sdj
>         6       8       64        6      active sync   /dev/sde
>        10       8       32        7      active sync   /dev/sdc
>         8       8      192        8      active sync   /dev/sdm
> 
> test:/home/brad# uname -a
> Linux test 5.4.11 #49 SMP Wed Jan 15 11:23:38 AWST 2020 x86_64 GNU/Linux
> 
> So the read error is well into the array member, yet a "check" doesn't hit it. Does that sound right?
> These disks grow bad sectors not infrequently, and so a check quite often forces a repair on a block of 8 sectors, but it has persistently missed this one.
> 
> Regards,
> Brad


So after reinserting /dev/sdi, the bad sectors were picked up during the rebuild :

[Tue Apr 28 17:23:16 2020] md: recovery of RAID array md3
[Tue Apr 28 17:29:09 2020] sd 4:0:4:0: [sdj] tag#131 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
[Tue Apr 28 17:29:09 2020] sd 4:0:4:0: [sdj] tag#131 Sense Key : 0x3 [current]
[Tue Apr 28 17:29:09 2020] sd 4:0:4:0: [sdj] tag#131 ASC=0x11 ASCQ=0x0
[Tue Apr 28 17:29:09 2020] sd 4:0:4:0: [sdj] tag#131 CDB: opcode=0x28 28 00 03 39 e5 a0 00 04 00 00
[Tue Apr 28 17:29:09 2020] blk_update_request: critical medium error, dev sdj, sector 54126096 op 0x0:(READ) flags 0x4000 phys_seg 114 prio class 0
[Tue Apr 28 17:29:20 2020] sd 4:0:4:0: [sdj] tag#175 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
[Tue Apr 28 17:29:20 2020] sd 4:0:4:0: [sdj] tag#175 Sense Key : 0x3 [current]
[Tue Apr 28 17:29:20 2020] sd 4:0:4:0: [sdj] tag#175 ASC=0x11 ASCQ=0x0
[Tue Apr 28 17:29:20 2020] sd 4:0:4:0: [sdj] tag#175 CDB: opcode=0x28 28 00 03 39 e6 10 00 00 08 00
[Tue Apr 28 17:29:20 2020] blk_update_request: critical medium error, dev sdj, sector 54126096 op 0x0:(READ) flags 0x4000 phys_seg 1 prio class 0
[Tue Apr 28 17:29:20 2020] md/raid:md3: read error corrected (8 sectors at 54126592 on sdj)
[Tue Apr 28 17:29:20 2020] md/raid:md3: read error corrected (8 sectors at 54126600 on sdj)
[Tue Apr 28 17:29:20 2020] md/raid:md3: read error corrected (8 sectors at 54126608 on sdj)
[Tue Apr 28 17:29:20 2020] md/raid:md3: read error corrected (8 sectors at 54126616 on sdj)
[Tue Apr 28 17:29:20 2020] md/raid:md3: read error corrected (8 sectors at 54126624 on sdj)
[Tue Apr 28 17:29:20 2020] md/raid:md3: read error corrected (8 sectors at 54126632 on sdj)
[Tue Apr 28 17:29:20 2020] md/raid:md3: read error corrected (8 sectors at 54126640 on sdj)
[Tue Apr 28 17:29:20 2020] md/raid:md3: read error corrected (8 sectors at 54126648 on sdj)
[Tue Apr 28 17:29:20 2020] md/raid:md3: read error corrected (8 sectors at 54126656 on sdj)
[Tue Apr 28 17:29:20 2020] md/raid:md3: read error corrected (8 sectors at 54126664 on sdj)

This would imply that a RAID "check" scrub does not actually read every block on every stripe of a RAID6, and thus has the potential to miss a dodgy sector under the wrong circumstances. When I get a minute, I'll try and put some test scenarios together with hdparm to create bad blocks and try to characterize the issue further.

Regards,
Brad
