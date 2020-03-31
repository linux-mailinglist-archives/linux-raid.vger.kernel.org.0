Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDDAA1989A4
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 03:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgCaBsU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 21:48:20 -0400
Received: from atl.turmel.org ([74.117.157.138]:48733 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbgCaBsU (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Mar 2020 21:48:20 -0400
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jJ60o-0006V9-Oe; Mon, 30 Mar 2020 21:48:18 -0400
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Daniel Jones <dj@iowni.com>, antlists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk>
 <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org>
Date:   Mon, 30 Mar 2020 21:48:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Daniel,

{ Convention on all kernel.org lists is to avoid top-posting and to trim 
unnecessary quoted material.  Please do so going forward. }

On 3/30/20 8:51 PM, Daniel Jones wrote:
> Greetings Wol,
> 
>> Don't even THINK of --create until the experts have chimed in !!!

Unfortunately, your new motherboard or your distro appears to have 
reacted to the presence of whole-disk raid members by establishing Gnu 
Partition Tables on them, blowing away those drives' superblocks.

Personally, I like the idea of whole-disk raid members, and did so for a 
while, until reports like yours made me change my ways.  Sorry.

You absolutely will need to use --create in this situation.  Much of the 
data necessary is available from the one remaining superblock, which you 
nicely included in your original report.

Since a --create will be needed, I recommend adjusting offsets to work 
with new partitions on each drive that start at a 1MB offset.

> Yes, I have had impure thoughts, but fortunately (?) I've done nothing
> yet to intentionally write to the drives.

Thank you.  This makes it much easier to help you.

[trim /]

>> The lsdrv information is crucial - that recovers pretty much all the config information that is available
> 
> Attached.
> 
> $ ./lsdrv
> PCI [pata_marvell] 02:00.0 IDE interface: Marvell Technology Group
> Ltd. 88SE6101/6102 single-port PATA133 interface (rev b2)
> └scsi 0:x:x:x [Empty]
> PCI [ahci] 00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10
> Family) SATA AHCI Controller
> ├scsi 2:0:0:0 ATA      M4-CT256M4SSD2   {0000000012050904283E}
> │└sda 238.47g [8:0] Partitioned (dos)
> │ ├sda1 500.00m [8:1] xfs {8ed274ce-4cf6-4804-88f8-0213c002a716}
> │ │└Mounted as /dev/sda1 @ /boot
> │ └sda2 237.99g [8:2] PV LVM2_member 237.92g used, 64.00m free
> {kn8lMS-0Cy8-xpsR-QRTk-CTRG-Eh1J-lmtfws}
> │  └VG centos_hulk 237.98g 64.00m free {P5MVrD-UMGG-0IO9-zFNq-8zd2-lycX-oYqe5L}
> │   ├dm-2 185.92g [253:2] LV home xfs {39075ece-de0a-4ace-b291-cc22aff5a4b2}
> │   │└Mounted as /dev/mapper/centos_hulk-home @ /home
> │   ├dm-0 50.00g [253:0] LV root xfs {68ffae87-7b51-4392-b3b8-59a7aa13ea68}
> │   │└Mounted as /dev/mapper/centos_hulk-root @ /
> │   └dm-1 2.00g [253:1] LV swap swap {f2da9893-93f0-42a1-ba86-5f3b3a72cc9b}
> ├scsi 3:0:0:0 ATA      WDC WD100EMAZ-00 {1DGVH01Z}
> │└sdb 9.10t [8:16] Partitioned (gpt)
> ├scsi 4:0:0:0 ATA      WDC WD100EMAZ-00 {2YJ2XMPD}
> │└sdc 9.10t [8:32] MD raid5 (4) inactive 'hulk:0'
> {423d9a8e-636a-5f08-56ec-bd90282e478b}
> ├scsi 5:0:0:0 ATA      WDC WD100EMAZ-00 {2YJDR8LD}
> │└sdd 9.10t [8:48] Partitioned (gpt)
> └scsi 6:0:0:0 ATA      WDC WD100EMAZ-00 {JEHRKH2Z}
>   └sde 9.10t [8:64] Partitioned (gpt)

No shocks here.  But due to the incomplete array, useful details are 
missing.  In particular, knowledge of the filesystem or nested structure 
(LVM?) present on the array will be needed to identify the real data 
offsets of the three mangled members.  (lsdrv is really intended to 
document critical details of a healthy system to minimize this kind of 
uncertainty when it eventually breaks.)

Please tell us what you can.  If it was another LVM volume group, please 
look for backups of the LVM metadata, typically in /etc/lvm/backup/.

Or we can make educated guesses until read-only access presents working 
or near-working content.

> Cheers,
> DJ

Regards,

Phil
