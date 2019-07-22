Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0467059D
	for <lists+linux-raid@lfdr.de>; Mon, 22 Jul 2019 18:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfGVQko (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jul 2019 12:40:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731069AbfGVQkn (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 22 Jul 2019 12:40:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3F2EAD55;
        Mon, 22 Jul 2019 16:40:41 +0000 (UTC)
Subject: Re: slow BLKDISCARD on RAID10 md block devices
To:     Lennert Buytenhek <buytenh@wantstofly.org>,
        linux-raid@vger.kernel.org
References: <20190717090200.GD2080@wantstofly.org>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <3a8e5b2e-e1a4-8023-f489-0813668a5f8a@suse.de>
Date:   Tue, 23 Jul 2019 00:40:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717090200.GD2080@wantstofly.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2019/7/17 5:02 下午, Lennert Buytenhek wrote:
> Hello!
> 
> I've been running into an issue with background fstrim on large xfs
> filesystems on RAID10d SSDs taking a lot of time to complete and
> starving out other I/O to the filesystem.  There seem to be a few
> different issues involved here, but the main one appears to be that
> BLKDISCARD on a RAID10 md block device sends many small discard
> requests down to the underlying component devices (while this doesn't
> seem to be an issue for RAID0 or for RAID1).
> 
> It's quite easy to reproduce this with just using in-memory loop
> devices, for example by doing:
> 
>         cd /dev/shm
>         touch loop0
>         touch loop1
>         touch loop2
>         touch loop3
>         truncate -s 7681501126656 loop0
>         truncate -s 7681501126656 loop1
>         truncate -s 7681501126656 loop2
>         truncate -s 7681501126656 loop3
>         losetup /dev/loop0 loop0
>         losetup /dev/loop1 loop1
>         losetup /dev/loop2 loop2
>         losetup /dev/loop3 loop3
> 
>         mdadm --create -n 4 -c 512 -l 0 --assume-clean /dev/md0 /dev/loop[0123]
>         time blkdiscard /dev/md0
> 
>         mdadm --stop /dev/md0
> 
>         mdadm --create -n 4 -c 512 -l 1 --assume-clean /dev/md0 /dev/loop[0123]
>         time blkdiscard /dev/md0
> 
>         mdadm --stop /dev/md0
> 
>         mdadm --create -n 4 -c 512 -l 10 --assume-clean /dev/md0 /dev/loop[0123]
>         time blkdiscard /dev/md0
> 

Hi Lennert,

> This simulates trimming RAID0/1/10 arrays with 4x7.68TB component
> devices, and the blkdiscard completion times are as follows:
> 
>         RAID0   0m0.213s

For raid0, see commit 29efc390b946 ("md/md0: optimize raid0 discard
handling"), Shaohua did magic code to combine huge number of small split
DISCARD bios into much less bigger ones (from 512KB to 4GB) in ideal
condition.

>         RAID1   0m2.667s

For raid1, see commit fd76863e37fe ("RAID1: a new I/O barrier
implementation to remove resync window"), which sets
BARRIER_UNIT_SECTOR_SIZE to 64MB, so 4GB DISCARD bio size will be split
into 64MB. Comparing to 4GB DISCARD bio size, 64MB is smaller, but
comparing to 512KB DISCARD bio size, it is much bigger.

>         RAID10  10m44.814s
> 

For raid10, neither DISCARD nor barrier bucket optimization exists,
upper layer 4GB DISCARD bio will be split into 512KB small bio due to
the raid0 chunk size. For a large SSD device, processing such huge
number of small bio in serial order will take a lot of time.


> For the RAID10 case, it spends almost 11 minutes pegged at 100% CPU
> (in the md0_raid10 and loop[0123] threads), and as expected, the
> completion time is somewhat inversely proportional to the RAID chunk
> size.  Doing this on actual 4x7.68TB or 6x7.68TB SSD arrays instead
> of with loop devices takes many many hours.
> 
> Any ideas on what I can try to speed this up?  I'm seeing this on
> 4.15 and on 5.1.
> 

Try to port the following ideas into raid10 code,
- commit 29efc390b946 ("md/md0: optimize raid0 discard handling")
- commit fd76863e37fe ("RAID1: a new I/O barrier implementation to
remove resync window")
- commit 824e47daddbf ("RAID1: avoid unnecessary spin locks in I/O
barrier code")

For the first patch, I still have no idea how to port it to md raid10
code, which is really smart code IMHO.

-- 

Coly Li
