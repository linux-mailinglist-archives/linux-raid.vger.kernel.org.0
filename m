Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704F81E1741
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 23:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbgEYVmg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 17:42:36 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:26258 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgEYVmf (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 25 May 2020 17:42:35 -0400
Received: from [81.154.111.47] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jdKVe-00099Q-7p; Mon, 25 May 2020 22:19:46 +0100
Subject: Re: help requested for mdadm grow error
To:     Thomas Grawert <thomasgrawert0282@gmail.com>
Cc:     linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
 <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
 <103b80fa-029f-ecdc-d470-5cc591dc8dd0@gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <e1a4a609-2068-b084-59a6-214c88798966@youngman.org.uk>
Date:   Mon, 25 May 2020 22:19:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <103b80fa-029f-ecdc-d470-5cc591dc8dd0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 25/05/2020 21:30, Thomas Grawert wrote:
> 
> Am 25.05.2020 um 21:33 schrieb Mikael Abrahamsson:
>> On Mon, 25 May 2020, Thomas Grawert wrote:
>>
>>> The Debian 10 is the most recent one. Kernel version is 
>>> 4.9.0-12-amd64. mdadm-version is v3.4 from 28th Jan 2016 - seems to 
>>> be the latest, because I can´t upgrade to any newer one using apt 
>>> upgrade.
>>
>> Are you sure about this? From what I can see debian 10 ships with 
>> mdadm v4.1 and newer kernels than 4.9.
>>
> Thanks to Mikael to hit my nose :)
> 
> System is now at Debian 10 with Kernel 5.5.0.0.bpo.2-amd64. mdadm is at 
> 4.1:
> 
> root@nas:~# cat /etc/os-release
> PRETTY_NAME="Debian GNU/Linux 10 (buster)"
> NAME="Debian GNU/Linux"
> VERSION_ID="10"
> VERSION="10 (buster)"
> VERSION_CODENAME=buster
> ID=debian
> HOME_URL="https://www.debian.org/"
> SUPPORT_URL="https://www.debian.org/support"
> BUG_REPORT_URL="https://bugs.debian.org/"
> 
> root@nas:~# uname -r
> 5.5.0-0.bpo.2-amd64
> 
> root@nas:~# mdadm -V
> mdadm - v4.1 - 2018-10-01
> 
> root@nas:~# mdadm -D /dev/md0
> /dev/md0:
>             Version : 1.2
>       Creation Time : Sun May 17 00:23:42 2020
>          Raid Level : raid5
>       Used Dev Size : 18446744073709551615
>        Raid Devices : 5
>       Total Devices : 5
>         Persistence : Superblock is persistent
> 
>         Update Time : Mon May 25 16:05:38 2020
>               State : active, FAILED, Not Started
>      Active Devices : 5
>     Working Devices : 5
>      Failed Devices : 0
>       Spare Devices : 0
> 
>              Layout : left-symmetric
>          Chunk Size : 512K
> 
> Consistency Policy : unknown
> 
>       Delta Devices : 1, (4->5)
> 
>                Name : nas:0  (local to host nas)
>                UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
>              Events : 38602
> 
>      Number   Major   Minor   RaidDevice State
>         -       0        0        0      removed
>         -       0        0        1      removed
>         -       0        0        2      removed
>         -       0        0        3      removed
>         -       0        0        4      removed
> 
>         -       8        1        0      sync   /dev/sda1
>         -       8       81        4      sync   /dev/sdf1
>         -       8       65        3      sync   /dev/sde1
>         -       8       49        2      sync   /dev/sdd1
>         -       8       33        1      sync   /dev/sdc1
> 
> root@nas:~#
> 
> 
> It seems, mdadm.conf or anything else is broken?
> 
I don't think I've got an mdadm.conf ... and everything to me looks okay 
but just not working.

Next step - how far has the reshape got? I *think* you might get that 
from "cat /proc/mdstat". Can we have that please ... I'm *hoping* it 
says the reshape is at 0%.

Cheers,
Wol
