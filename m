Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D8C1CD20
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 18:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfENQhV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 12:37:21 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:60732 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfENQhU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 May 2019 12:37:20 -0400
Received: from [192.168.8.29] ([86.214.62.250])
        by mwinf5d07 with ME
        id CGdH200065Px8Mi03GdHka; Tue, 14 May 2019 18:37:17 +0200
X-ME-Helo: [192.168.8.29]
X-ME-Auth: ZXJpYy52YWxldHRlNkB3YW5hZG9vLmZy
X-ME-Date: Tue, 14 May 2019 18:37:17 +0200
X-ME-IP: 86.214.62.250
Reply-To: eric.valette@free.fr
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     Feng Zhang <prod.feng@gmail.com>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <CA+hhoHkuVw+JvLMeeJV_2eqY3tUd7k3qo4DEYwokRfnstoGtDw@mail.gmail.com>
From:   Eric Valette <eric.valette@free.fr>
Organization: HOME
Message-ID: <35bc5124-02b8-57b7-7b28-08d356241d9e@free.fr>
Date:   Tue, 14 May 2019 18:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+hhoHkuVw+JvLMeeJV_2eqY3tUd7k3qo4DEYwokRfnstoGtDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/05/2019 18:28, Feng Zhang wrote:

> after the sdd failure, you rebooted your server?

Well the disk refused to start at a power on. But since then yes I 
rebooted because its headless and I needed to add monitor and keyboard.

> Do you have /etc/mdadm.conf(or in other location) that explicitly list
> the sdb1 , sdd1 etc as the md0? If so, maybe you can comment it and
> then rescan the devices. If the spare disk is defined at the
> beginning, or added afterward as "spare", it should start rebuilding
> right away after a disk failure.

I have the file but if you look at the provided info I think it is clear 
via following line

Device Role : Active device x or spare.

So as said I broke active device 2



cat /etc/mdadm/mdadm.conf
# mdadm.conf
#
# Please refer to mdadm.conf(5) for information about this file.
#

# by default (built-in), scan all partitions (/proc/partitions) and all
# containers for MD superblocks. alternatively, specify devices to scan, 
using
# wildcards if desired.
DEVICE /dev/sd[bcdef]1

# auto-create devices with Debian standard permissions
CREATE owner=root group=disk mode=0660 auto=yes

# automatically tag new arrays as belonging to the local system
HOMEHOST <system>

# instruct the monitoring daemon where to send mail alerts
MAILADDR eric.valette@free.fr

# definitions of existing MD arrays
ARRAY /dev/md0 metadata=1.2 spares=1 name=nas2:0 
UUID=6abe1f20:90c629de:fadd8dc0:ca14c928
> The comands to rescan  may look like:
> mdadm --stop /dev/md0
> mdadm --assemble --scan

> You can use UUID instead of sdb, or sdc, etc.
> 
> Other experts on the list may give you more helpful info.

Thanks anyway.

> On Tue, May 14, 2019 at 11:49 AM Eric Valette <eric.valette@free.fr> wrote:
>>
>> I have a dedicated hardware nas that runs a self maintained debian 10.
>>
>> before the hardware disk problem (before/after)
>>
>> sda : system disk OK/OK no raid
>> sdb : first disk of the raid10 array OK/OK
>> sdc : second disk of the raid10 array OK/OK
>> sdd : third disk of the raid10 array OK/KO
>> sde : fourth disk of the raid10 array OK/OK but is now sdd
>> sdf : spare disk for the array is now sde
>>
>> After the failure the BIOS does not detect the original third disk. Disk
>> are renamed and I think sde has become sdd and sdf -> sde
>>
>> Below are more detailed info. Feel free to ask for other things as I can
>> log into the machine via ssh
>>
>> So I have several questions :
>>
>>          1) How to I repair the raid10 array using the spare disk without
>> replacing the faulty one immediately?
>>          2) What should I do once I receive the new disk (hopefully soon)
>>          3) Is there a way to use persistent naming for disk array?
>>
>> Sorry to annoy you but my kid wants to see a film on the nas and annoys
>> me badly. And I prefer to ask rather than doing mistakes.
>>
>> Thanks for any
>>
>>
>>
>> mdadm --examine /dev/sdb
>> /dev/sdb:
>>      MBR Magic : aa55
>> Partition[0] :   4294967295 sectors at            1 (type ee)
>> root@nas2:~# mdadm --examine /dev/sdb
>> /dev/sdb:
>>      MBR Magic : aa55
>> Partition[0] :   4294967295 sectors at            1 (type ee)
>> root@nas2:~# mdadm --examine /dev/sdb1
>> /dev/sdb1:
>>             Magic : a92b4efc
>>           Version : 1.2
>>       Feature Map : 0x0
>>        Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>>              Name : nas2:0  (local to host nas2)
>>     Creation Time : Wed Jun 20 23:56:59 2012
>>        Raid Level : raid10
>>      Raid Devices : 4
>>
>>    Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>>        Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>>     Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>>       Data Offset : 262144 sectors
>>      Super Offset : 8 sectors
>>      Unused Space : before=262064 sectors, after=911 sectors
>>             State : clean
>>       Device UUID : ce9d878a:37a4f3a3:936bd905:c4ed9970
>>
>>       Update Time : Wed May  8 11:39:40 2019
>>          Checksum : cf841c9f - correct
>>            Events : 1193
>>
>>            Layout : near=2
>>        Chunk Size : 512K
>>
>>      Device Role : Active device 0
>>      Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
>> root@nas2:~# mdadm --examine /dev/sdc
>> /dev/sdc:
>>      MBR Magic : aa55
>> Partition[0] :   4294967295 sectors at            1 (type ee)
>> root@nas2:~# mdadm --examine /dev/sdc1
>> /dev/sdc1:
>>             Magic : a92b4efc
>>           Version : 1.2
>>       Feature Map : 0x0
>>        Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>>              Name : nas2:0  (local to host nas2)
>>     Creation Time : Wed Jun 20 23:56:59 2012
>>        Raid Level : raid10
>>      Raid Devices : 4
>>
>>    Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>>        Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>>     Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>>       Data Offset : 262144 sectors
>>      Super Offset : 8 sectors
>>      Unused Space : before=262064 sectors, after=911 sectors
>>             State : clean
>>       Device UUID : 8c89bdf8:4f3f8ace:c15b5634:7a874071
>>
>>       Update Time : Wed May  8 11:39:40 2019
>>          Checksum : 97744edb - correct
>>            Events : 1193
>>
>>            Layout : near=2
>>        Chunk Size : 512K
>>
>>      Device Role : Active device 1
>>      Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
>> root@nas2:~# mdadm --examine /dev/sdd
>> /dev/sdd:
>>      MBR Magic : aa55
>> Partition[0] :   4294967295 sectors at            1 (type ee)
>> root@nas2:~# mdadm --examine /dev/sdd1
>> /dev/sdd1:
>>             Magic : a92b4efc
>>           Version : 1.2
>>       Feature Map : 0x0
>>        Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>>              Name : nas2:0  (local to host nas2)
>>     Creation Time : Wed Jun 20 23:56:59 2012
>>        Raid Level : raid10
>>      Raid Devices : 4
>>
>>    Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>>        Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>>     Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>>       Data Offset : 262144 sectors
>>      Super Offset : 8 sectors
>>      Unused Space : before=262064 sectors, after=911 sectors
>>             State : clean
>>       Device UUID : c97b767a:84d2e7e2:52557d30:51c39784
>>
>>       Update Time : Wed May  8 11:39:40 2019
>>          Checksum : 3d08e837 - correct
>>            Events : 1193
>>
>>            Layout : near=2
>>        Chunk Size : 512K
>>
>>      Device Role : Active device 3
>>      Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
>> root@nas2:~# mdadm --examine /dev/sde
>> /dev/sde:
>>      MBR Magic : aa55
>> Partition[0] :   4294967295 sectors at            1 (type ee)
>> root@nas2:~# mdadm --examine /dev/sde1
>> /dev/sde1:
>>             Magic : a92b4efc
>>           Version : 1.2
>>       Feature Map : 0x0
>>        Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>>              Name : nas2:0  (local to host nas2)
>>     Creation Time : Wed Jun 20 23:56:59 2012
>>        Raid Level : raid10
>>      Raid Devices : 4
>>
>>    Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>>        Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>>     Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>>       Data Offset : 262144 sectors
>>      Super Offset : 8 sectors
>>      Unused Space : before=262064 sectors, after=911 sectors
>>             State : clean
>>       Device UUID : 82667e81:a6158319:85e0282e:845eec1c
>>
>>       Update Time : Wed May  8 11:00:29 2019
>>          Checksum : 10ac3349 - correct
>>            Events : 1193
>>
>>            Layout : near=2
>>        Chunk Size : 512K
>>
>>      Device Role : spare
>>      Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
>> root@nas2:~#
>>
>> mdadm --detail /dev/md0
>> /dev/md0:
>>              Version : 1.2
>>           Raid Level : raid0
>>        Total Devices : 4
>>          Persistence : Superblock is persistent
>>
>>                State : inactive
>>      Working Devices : 4
>>
>>                 Name : nas2:0  (local to host nas2)
>>                 UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>>               Events : 1193
>>
>>       Number   Major   Minor   RaidDevice
>>
>>          -       8       65        -        /dev/sde1
>>          -       8       49        -        /dev/sdd1
>>          -       8       33        -        /dev/sdc1
>>          -       8       17        -        /dev/sdb1
>>
>> cat /proc/mdstat
>> Personalities : [raid10]
>> md0 : inactive sdc1[1](S) sdb1[0](S) sde1[4](S) sdd1[3](S)
>>         11720537886 blocks super 1.2
>>
>> unused devices: <none>
>>
>> --
>>      __
>>     /  `                         Eric Valette
>>    /--   __  o _.                6 rue Paul Le Flem
>> (___, / (_(_(__                 35740 Pace
>>
>> Tel: +33 (0)2 99 85 26 76       Fax: +33 (0)2 99 85 26 76
>> E-mail: eric.valette@free.fr
>>
>>
>>


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



