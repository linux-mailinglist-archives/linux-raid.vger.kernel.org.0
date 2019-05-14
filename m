Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7811CDFF
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 19:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfENRaW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 13:30:22 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58807 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfENRaW (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 May 2019 13:30:22 -0400
Received: from [192.168.28.40] (unknown [86.74.176.27])
        (Authenticated sender: julien.robin28)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id A0056B005BB;
        Tue, 14 May 2019 19:25:12 +0200 (CEST)
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     eric.valette@free.fr, linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <b4c92096-3096-63ff-24ea-b2745b20942c@free.fr>
 <27ab1f31-f125-4043-e417-6942a1d57965@free.fr>
From:   Julien ROBIN <julien.robin28@free.fr>
Message-ID: <cb0ab61f-788a-2c7d-ed17-5588726793fe@free.fr>
Date:   Tue, 14 May 2019 19:25:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <27ab1f31-f125-4043-e417-6942a1d57965@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I made the same situation here to find and test the solution

Just tried with the spare already into the array (/dev/loop4) before the 
3rd member (/dev/loop2) disappearing, and I have the same problem:

mdadm --assemble /dev/md0 /dev/loop0 /dev/loop1 /dev/loop3 /dev/loop4
mdadm: /dev/md0 assembled from 3 drives and 1 spare - need all 4 to 
start it (use --run to insist).

mdadm --assemble /dev/md0 /dev/loop0 /dev/loop1 /dev/loop3 /dev/loop4 --run

     Number   Major   Minor   RaidDevice State
        0       7        0        0      active sync set-A   /dev/loop0
        1       7        1        1      active sync set-B   /dev/loop1
        -       0        0        2      removed
        3       7        3        3      active sync set-B   /dev/loop3

        5       7        4        -      spare   /dev/loop4

I found this and tried:
https://serverfault.com/questions/676638/mdadm-drive-replacement-shows-up-as-spare-and-refuses-to-sync

echo idle > /sys/block/md0/md/sync_action

mdadm --detail /dev/md0
/dev/md0:
         Version : 1.2
   Creation Time : Tue May 14 18:32:41 2019
      Raid Level : raid10
      Array Size : 3143680 (3.00 GiB 3.22 GB)
   Used Dev Size : 1571840 (1535.00 MiB 1609.56 MB)
    Raid Devices : 4
   Total Devices : 4
     Persistence : Superblock is persistent

     Update Time : Tue May 14 19:21:33 2019
           State : clean, degraded, recovering
  Active Devices : 3
Working Devices : 4
  Failed Devices : 0
   Spare Devices : 1

          Layout : near=2
      Chunk Size : 512K

  Rebuild Status : 26% complete

            Name : Octocrobe:0  (local to host Octocrobe)
            UUID : b81ed231:11636921:fb6e5c51:7003143d
          Events : 88

     Number   Major   Minor   RaidDevice State
        0       7        0        0      active sync set-A   /dev/loop0
        1       7        1        1      active sync set-B   /dev/loop1
        5       7        4        2      spare rebuilding   /dev/loop4
        3       7        3        3      active sync set-B   /dev/loop3


And it's good again, loop4 sha1sum result is correct !
Strange that mdadm does not want to take the spare without asking user 
to enter "echo idle > /sys/block/md0/md/sync_action" command!

This should make your system running fine waiting for your future new 
disk (which would be placed as spare once added).



On 5/14/19 7:16 PM, Eric Valette wrote:
> On 14/05/2019 18:55, Julien ROBIN wrote:
>> Hi !
> 
> 
> Hi. Thanks a lot for yopur time.
> 
>> I just did a test for you (and for being sure myself for future, and 
>> before saying anything wrong).
> 
> Thanks. I do not want to wipe anything or my kinds will annoy me for the 
> rest of the month
>>
>> Created 4 files of 1536 MB (into a 8GB RAM Disk so it's faster than 
>> ever) + 1 for the coming replacement:
>>
>> dd if=/dev/zero of=R1.img bs=1024k status=progress count=1536
>> dd if=/dev/zero of=R2.img bs=1024k status=progress count=1536
>> dd if=/dev/zero of=R3.img bs=1024k status=progress count=1536
>> dd if=/dev/zero of=R4.img bs=1024k status=progress count=1536
>> dd if=/dev/zero of=R5.img bs=1024k status=progress count=1536
>>
>> Made them available as block devices:
>>
>> losetup /dev/loop0 /home/user/RAMFS/R1.img
>> losetup /dev/loop1 /home/user/RAMFS/R2.img
>> losetup /dev/loop2 /home/user/RAMFS/R3.img
>> losetup /dev/loop3 /home/user/RAMFS/R4.img
>> losetup /dev/loop4 /home/user/RAMFS/R5.img
>>
>> Created my RAID 10 with 4 disks:
>> mdadm --create /dev/md0 --level=10 --raid-devices=4 /dev/loop0 
>> /dev/loop1 /dev/loop2 /dev/loop3
> 
> Compared to this, I added /dev/loop4 as spare before the failure so I 
> have one spare device in my array already (I have 5 data disk slots and 
> one system disk slot).
> 
> 
>> Which gives:
>>
>> oot@Octocrobe:/home/user/RAMFS# mdadm --detail /dev/md0
>> /dev/md0:
>>          Version : 1.2
>>    Creation Time : Tue May 14 17:59:28 2019
>>       Raid Level : raid10
>>       Array Size : 3143680 (3.00 GiB 3.22 GB)
>>    Used Dev Size : 1571840 (1535.00 MiB 1609.56 MB)
>>     Raid Devices : 4
>>    Total Devices : 4
>>      Persistence : Superblock is persistent
>>
>>      Update Time : Tue May 14 18:05:55 2019
>>            State : clean
>>   Active Devices : 4
>> Working Devices : 4
>>   Failed Devices : 0
>>    Spare Devices : 0
>>
>>           Layout : near=2
>>       Chunk Size : 512K
>>
>>             Name : Octocrobe:0  (local to host Octocrobe)
>>             UUID : f9876be6:2a574cf3:3824348e:2438479e
>>           Events : 17
>>
>>      Number   Major   Minor   RaidDevice State
>>         0       7        0        0      active sync set-A   /dev/loop0
>>         1       7        1        1      active sync set-B   /dev/loop1
>>         2       7        2        2      active sync set-A   /dev/loop2
>>         3       7        3        3      active sync set-B   /dev/loop3
>>
>> I wrote something to the RAID (do not do this over valuable filesystem 
>> or data!) in order to have a way to control data integrity later.
>> shred -n 1 -v /dev/md0
>>
>> Checked the sha1 resulting values of data available on the array, then 
>> members data area (with 2048 sectors data offset, so 1 MB to skip)
>> 887db7d3f046242e9f99dd330cc628d2b3f7a5f9  /dev/md0
>>
>> dd if=/home/user/RAMFS/R1.img bs=1024k skip=1 | sha1sum: 
>> 954497d3e591bdb3998e5ccf35a639d2c2894bb8
>> dd if=/home/user/RAMFS/R2.img bs=1024k skip=1 | sha1sum: 
>> 954497d3e591bdb3998e5ccf35a639d2c2894bb8
>> dd if=/home/user/RAMFS/R3.img bs=1024k skip=1 | sha1sum: 
>> 1fad602e67a218391406dafa04c7ecba000ecaf7
>> dd if=/home/user/RAMFS/R4.img bs=1024k skip=1 | sha1sum: 
>> 1fad602e67a218391406dafa04c7ecba000ecaf7
>>
>> For the still not used one: 23543e573e0e1fbfcec24dc7441395c50dd61bd6
>>
>> Failed the 3rd member:
>> mdadm --manage /dev/md0 --fail /dev/loop2
> 
> 
> It is here that I started requiring help : I cannot fail the faulty 
> device by name : /dev/sdd was representing device 2 at the time of the 
> failure but now it represents device 3
> 
> 
>> Not mandatory: trying to stop and assemble back the array, just to see:
>> mdadm --stop /dev/md0
>> mdadm --assemble /dev/md0 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
>> mdadm: /dev/md0 has been started with 3 drives (out of 4).
> 
> As per previous mail answer I tried:
> 
> mdadm --assemble -o /dev/md0
> mdadm: /dev/md0 has been started with 3 drives (out of 4) and 1 spare.
> 
> which looks correct, i even received by mail a notification of degraded 
> array
> 
> root@nas2:~# mdadm --details
> mdadm: unrecognized option '--details'
> Usage: mdadm --help
>    for help
> root@nas2:~# mdadm --detail
> mdadm: No devices given.
> root@nas2:~# mdadm --detail /dev/md0
> /dev/md0:
>             Version : 1.2
>       Creation Time : Wed Jun 20 23:56:59 2012
>          Raid Level : raid10
>          Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>       Used Dev Size : 2930134016 (2794.39 GiB 3000.46 GB)
>        Raid Devices : 4
>       Total Devices : 4
>         Persistence : Superblock is persistent
> 
>         Update Time : Wed May  8 11:39:40 2019
>               State : clean, degraded
>      Active Devices : 3
>     Working Devices : 4
>      Failed Devices : 0
>       Spare Devices : 1
> 
>              Layout : near=2
>          Chunk Size : 512K
> 
> Consistency Policy : resync
> 
>                Name : nas2:0  (local to host nas2)
>                UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>              Events : 1193
> 
>      Number   Major   Minor   RaidDevice State
>         0       8       17        0      active sync set-A   /dev/sdb1
>         1       8       33        1      active sync set-B   /dev/sdc1
>         -       0        0        2      removed
>         3       8       49        3      active sync set-B   /dev/sdd1
> 
>         4       8       65        -      spare   /dev/sde1
> 
> So I only need to make sure the spare is rebuilding as in you rexemple 
> below.
> 
> Removing the -o may be sufficient? I did mdadm --assemble -o /dev/md0
> 
>>
>> Details: /dev/loop2 disappeared from mdadm --detail, but it's still 
>> working the exact same way.
>>      Number   Major   Minor   RaidDevice State
>>         0       7        0        0      active sync set-A   /dev/loop0
>>         1       7        1        1      active sync set-B   /dev/loop1
>>         -       0        0        2      removed
>>         3       7        3        3      active sync set-B   /dev/loop3
>>
>> Added the new one:
>>
>> mdadm --manage /dev/md0 --add /dev/loop4
>>
>> Details:
>>
>>   Rebuild Status : 78% complete
>>
>>             Name : Octocrobe:0  (local to host Octocrobe)
>>             UUID : b81ed231:11636921:fb6e5c51:7003143d
>>           Events : 36
>>
>>      Number   Major   Minor   RaidDevice State
>>         0       7        0        0      active sync set-A   /dev/loop0
>>         1       7        1        1      active sync set-B   /dev/loop1
>>         4       7        4        2      spare rebuilding   /dev/loop4
>>         3       7        3        3      active sync set-B   /dev/loop3
>>
>> Then it seems to be fine:
>> dd if=/home/user/RAMFS/R5.img bs=1024k skip=1 | sha1sum : 
>> 1fad602e67a218391406dafa04c7ecba000ecaf7
>>
>> root@Octocrobe:/home/user/RAMFS# mdadm --detail /dev/md0
>> /dev/md0:
>>          Version : 1.2
>>    Creation Time : Tue May 14 17:59:28 2019
>>       Raid Level : raid10
>>       Array Size : 3143680 (3.00 GiB 3.22 GB)
>>    Used Dev Size : 1571840 (1535.00 MiB 1609.56 MB)
>>     Raid Devices : 4
>>    Total Devices : 5
>>      Persistence : Superblock is persistent
>>
>>      Update Time : Tue May 14 18:29:01 2019
>>            State : clean
>>   Active Devices : 4
>> Working Devices : 4
>>   Failed Devices : 1
>>    Spare Devices : 0
>>
>>           Layout : near=2
>>       Chunk Size : 512K
>>
>>             Name : Octocrobe:0  (local to host Octocrobe)
>>             UUID : f9876be6:2a574cf3:3824348e:2438479e
>>           Events : 37
>>
>>      Number   Major   Minor   RaidDevice State
>>         0       7        0        0      active sync set-A   /dev/loop0
>>         1       7        1        1      active sync set-B   /dev/loop1
>>         4       7        4        2      active sync set-A   /dev/loop4
>>         3       7        3        3      active sync set-B   /dev/loop3
>>
>> Another way is:
>>
>> mdadm /dev/md0 --re-add /dev/yourFailedDrive
>> mdadm --manage /dev/md0 --add /dev/yourNewDrive --replace 
>> /dev/yourFailedDrive --with /dev/yourNewDrive
> 
> Here I have the same issue with device name that were chnaged during 
> reboot. Next time, I will use permanent names...
> 
>>
>> At the end, the new drive content is conform too. This way is supposed 
>> to attempt reading over the replaced drive instead of reading over the 
>> others ones, but I guess your failed drive won't be available anymore ;)
> 
> 
> I already ordered a new one indeed...
> 
> Thanks a lot for your help. I think I just need to say "rebuild the 
> spare" after mdadm --assemble /dev/md0
> 
> But maybe without the -o it will be automatic?
> 
> 
>> On 5/14/19 5:48 PM, Eric Valette wrote:
>>> I have a dedicated hardware nas that runs a self maintained debian 10.
>>>
>>> before the hardware disk problem (before/after)
>>>
>>> sda : system disk OK/OK no raid
>>> sdb : first disk of the raid10 array OK/OK
>>> sdc : second disk of the raid10 array OK/OK
>>> sdd : third disk of the raid10 array OK/KO
>>> sde : fourth disk of the raid10 array OK/OK but is now sdd
>>> sdf : spare disk for the array is now sde
>>>
>>> After the failure the BIOS does not detect the original third disk. 
>>> Disk are renamed and I think sde has become sdd and sdf -> sde
>>>
>>> Below are more detailed info. Feel free to ask for other things as I 
>>> can log into the machine via ssh
>>>
>>> So I have several questions :
>>>
>>>      1) How to I repair the raid10 array using the spare disk without 
>>> replacing the faulty one immediately?
>>>      2) What should I do once I receive the new disk (hopefully soon)
>>>      3) Is there a way to use persistent naming for disk array?
>>>
>>> Sorry to annoy you but my kid wants to see a film on the nas and 
>>> annoys me badly. And I prefer to ask rather than doing mistakes.
>>>
>>> Thanks for any
>>>
>>>
>>>
>>> mdadm --examine /dev/sdb
>>> /dev/sdb:
>>>     MBR Magic : aa55
>>> Partition[0] :   4294967295 sectors at            1 (type ee)
>>> root@nas2:~# mdadm --examine /dev/sdb
>>> /dev/sdb:
>>>     MBR Magic : aa55
>>> Partition[0] :   4294967295 sectors at            1 (type ee)
>>> root@nas2:~# mdadm --examine /dev/sdb1
>>> /dev/sdb1:
>>>            Magic : a92b4efc
>>>          Version : 1.2
>>>      Feature Map : 0x0
>>>       Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>>>             Name : nas2:0  (local to host nas2)
>>>    Creation Time : Wed Jun 20 23:56:59 2012
>>>       Raid Level : raid10
>>>     Raid Devices : 4
>>>
>>>   Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>>>       Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>>>    Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>>>      Data Offset : 262144 sectors
>>>     Super Offset : 8 sectors
>>>     Unused Space : before=262064 sectors, after=911 sectors
>>>            State : clean
>>>      Device UUID : ce9d878a:37a4f3a3:936bd905:c4ed9970
>>>
>>>      Update Time : Wed May  8 11:39:40 2019
>>>         Checksum : cf841c9f - correct
>>>           Events : 1193
>>>
>>>           Layout : near=2
>>>       Chunk Size : 512K
>>>
>>>     Device Role : Active device 0
>>>     Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
>>> root@nas2:~# mdadm --examine /dev/sdc
>>> /dev/sdc:
>>>     MBR Magic : aa55
>>> Partition[0] :   4294967295 sectors at            1 (type ee)
>>> root@nas2:~# mdadm --examine /dev/sdc1
>>> /dev/sdc1:
>>>            Magic : a92b4efc
>>>          Version : 1.2
>>>      Feature Map : 0x0
>>>       Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>>>             Name : nas2:0  (local to host nas2)
>>>    Creation Time : Wed Jun 20 23:56:59 2012
>>>       Raid Level : raid10
>>>     Raid Devices : 4
>>>
>>>   Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>>>       Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>>>    Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>>>      Data Offset : 262144 sectors
>>>     Super Offset : 8 sectors
>>>     Unused Space : before=262064 sectors, after=911 sectors
>>>            State : clean
>>>      Device UUID : 8c89bdf8:4f3f8ace:c15b5634:7a874071
>>>
>>>      Update Time : Wed May  8 11:39:40 2019
>>>         Checksum : 97744edb - correct
>>>           Events : 1193
>>>
>>>           Layout : near=2
>>>       Chunk Size : 512K
>>>
>>>     Device Role : Active device 1
>>>     Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
>>> root@nas2:~# mdadm --examine /dev/sdd
>>> /dev/sdd:
>>>     MBR Magic : aa55
>>> Partition[0] :   4294967295 sectors at            1 (type ee)
>>> root@nas2:~# mdadm --examine /dev/sdd1
>>> /dev/sdd1:
>>>            Magic : a92b4efc
>>>          Version : 1.2
>>>      Feature Map : 0x0
>>>       Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>>>             Name : nas2:0  (local to host nas2)
>>>    Creation Time : Wed Jun 20 23:56:59 2012
>>>       Raid Level : raid10
>>>     Raid Devices : 4
>>>
>>>   Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>>>       Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>>>    Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>>>      Data Offset : 262144 sectors
>>>     Super Offset : 8 sectors
>>>     Unused Space : before=262064 sectors, after=911 sectors
>>>            State : clean
>>>      Device UUID : c97b767a:84d2e7e2:52557d30:51c39784
>>>
>>>      Update Time : Wed May  8 11:39:40 2019
>>>         Checksum : 3d08e837 - correct
>>>           Events : 1193
>>>
>>>           Layout : near=2
>>>       Chunk Size : 512K
>>>
>>>     Device Role : Active device 3
>>>     Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
>>> root@nas2:~# mdadm --examine /dev/sde
>>> /dev/sde:
>>>     MBR Magic : aa55
>>> Partition[0] :   4294967295 sectors at            1 (type ee)
>>> root@nas2:~# mdadm --examine /dev/sde1
>>> /dev/sde1:
>>>            Magic : a92b4efc
>>>          Version : 1.2
>>>      Feature Map : 0x0
>>>       Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>>>             Name : nas2:0  (local to host nas2)
>>>    Creation Time : Wed Jun 20 23:56:59 2012
>>>       Raid Level : raid10
>>>     Raid Devices : 4
>>>
>>>   Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>>>       Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>>>    Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>>>      Data Offset : 262144 sectors
>>>     Super Offset : 8 sectors
>>>     Unused Space : before=262064 sectors, after=911 sectors
>>>            State : clean
>>>      Device UUID : 82667e81:a6158319:85e0282e:845eec1c
>>>
>>>      Update Time : Wed May  8 11:00:29 2019
>>>         Checksum : 10ac3349 - correct
>>>           Events : 1193
>>>
>>>           Layout : near=2
>>>       Chunk Size : 512K
>>>
>>>     Device Role : spare
>>>     Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
>>> root@nas2:~#
>>>
>>> mdadm --detail /dev/md0
>>> /dev/md0:
>>>             Version : 1.2
>>>          Raid Level : raid0
>>>       Total Devices : 4
>>>         Persistence : Superblock is persistent
>>>
>>>               State : inactive
>>>     Working Devices : 4
>>>
>>>                Name : nas2:0  (local to host nas2)
>>>                UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>>>              Events : 1193
>>>
>>>      Number   Major   Minor   RaidDevice
>>>
>>>         -       8       65        -        /dev/sde1
>>>         -       8       49        -        /dev/sdd1
>>>         -       8       33        -        /dev/sdc1
>>>         -       8       17        -        /dev/sdb1
>>>
>>> cat /proc/mdstat
>>> Personalities : [raid10]
>>> md0 : inactive sdc1[1](S) sdb1[0](S) sde1[4](S) sdd1[3](S)
>>>        11720537886 blocks super 1.2
>>>
>>> unused devices: <none>
>>>
> 
> 
