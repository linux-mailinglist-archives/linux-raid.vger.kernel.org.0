Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B937D12D9CA
	for <lists+linux-raid@lfdr.de>; Tue, 31 Dec 2019 16:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLaPZu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Dec 2019 10:25:50 -0500
Received: from mail.freakix.de ([89.238.76.166]:38620 "EHLO mail.freakix.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaPZu (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 31 Dec 2019 10:25:50 -0500
Received: from Norberts-MacBook-Pro.local (unknown [37.120.66.148])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.freakix.de (Postfix) with ESMTPSA id 96A23E8CDB
        for <linux-raid@vger.kernel.org>; Tue, 31 Dec 2019 16:25:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=freakix.de; s=mail;
        t=1577805948; bh=viWBN03nt7lZ2srM/krhsWetB+Zrx9KYiz3YZJkeN2s=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=cDoOLgpxcYLPFwhwzF7EI+VWyI+vLW3C2lpYtXUeEsHeC9DUtZOE4fivXbgawZ2BP
         TcNcFheVaTI4BKC6wpeIH/H+qH/BK49WQxC4Pi3qPejlkkUQKj4t/RxipolIq9Gb2T
         BOrrTXAk7kRC5eNAQQLQwf7gBIH+/d6BoTSKnqV8=
Subject: Re: md*_raid5 keeps writing to disks
From:   Norbert Weinhold <lrko@freakix.de>
To:     linux-raid@vger.kernel.org
References: <0930b5c8-17b7-39fb-b6e6-10689a23aa1c@freakix.de>
Message-ID: <928e24c0-bac0-8868-0a62-3042b9483630@freakix.de>
Date:   Tue, 31 Dec 2019 16:25:42 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <0930b5c8-17b7-39fb-b6e6-10689a23aa1c@freakix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

short update:
Seems nothing is wrong here, except I didn't look carefully enough and missed that ext4lazyinit is actually
still running and thus causing those writes. I assume, once it finishes its job everything will be as expected.

Sorry for the noise.

Happy New Year.

Thanks,
Norbert

Am 30.12.19 um 04:11 schrieb Norbert Weinhold:
> Hi,
> 
> I currently experience a "problem" with a raid5 I built. As soon as I have mounted the filesystem on it (ext4)
> a md127_raid5 process will do writes every few seconds to all the members:
> 
> md127_raid5(4044): WRITE block 16 on sdb1 (8 sectors)
> md127_raid5(4044): WRITE block 16 on sdc1 (8 sectors)
> md127_raid5(4044): WRITE block 16 on sda1 (8 sectors)
> md127_raid5(4044): WRITE block 16 on sdg1 (8 sectors)
> md127_raid5(4044): WRITE block 16 on sdh1 (8 sectors)
> md127_raid5(4044): WRITE block 8 on sdb1 (1 sectors)
> md127_raid5(4044): WRITE block 8 on sdc1 (1 sectors)
> md127_raid5(4044): WRITE block 8 on sda1 (1 sectors)
> md127_raid5(4044): WRITE block 8 on sdg1 (1 sectors)
> md127_raid5(4044): WRITE block 8 on sdh1 (1 sectors)
> 
> Disabling the journal of the filesystem does not make a difference. Same for changing the bitmap to none for
> the RAID. I'm wondering what is happening here that keeps my drives active. This only stops when unmounting
> the filesystem. There are no logged writes/reads to the md devices itself at the same time.
> 
> I'm currently running Kernel 4.9.0-11
> 
> /dev/md127:
>         Version : 1.2
>   Creation Time : Sat Dec 21 22:20:21 2019
>      Raid Level : raid5
>      Array Size : 19534553088 (18629.60 GiB 20003.38 GB)
>   Used Dev Size : 4883638272 (4657.40 GiB 5000.85 GB)
>    Raid Devices : 5
>   Total Devices : 5
>     Persistence : Superblock is persistent
> 
>   Intent Bitmap : Internal
> 
>     Update Time : Mon Dec 30 03:31:26 2019
>           State : clean
>  Active Devices : 5
> Working Devices : 5
>  Failed Devices : 0
>   Spare Devices : 0
> 
>          Layout : left-symmetric
>      Chunk Size : 512K
> 
>            Name : mediapc:myraid5  (local to host mediapc)
>            UUID : 386efd19:1cc165f6:937ac197:810a3afa
>          Events : 68301
> 
>     Number   Major   Minor   RaidDevice State
>        0       8      113        0      active sync   /dev/sdh1
>        1       8       97        1      active sync   /dev/sdg1
>        3       8        1        2      active sync   /dev/sda1
>        5       8       17        3      active sync   /dev/sdb1
>        4       8       33        4      active sync   /dev/sdc1
> 
> Thanks,
> Norbert
> 

