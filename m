Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87758235A8B
	for <lists+linux-raid@lfdr.de>; Sun,  2 Aug 2020 22:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgHBUiJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Aug 2020 16:38:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:47531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgHBUiI (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 2 Aug 2020 16:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596400683;
        bh=6uDnfbmjpzfEQ99DfP2pzuwVj1NXW0NN1vY3kbyDFCI=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=XQqKsPRD9rcehPXvzMbEFpep0IhI7iBQeNn8zTM9I5Hf/j434wPqGzVZq6d1qz/Zc
         zo8+OfkcVoe1TyiR2uCjgcueFC2OVl07EItrRCmhDThOUlRT6WTQPwE6PUwxe5DGhJ
         6rYsWy6eRW704W7QzCiNh1gK8luxzwbh/baISzeU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.8.10] ([46.127.167.108]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1krgXk3XQE-00sbOu; Sun, 02
 Aug 2020 22:38:02 +0200
Subject: Re: Restoring a raid0 for data rescue
From:   tyranastrasz@gmx.de
To:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <S1726630AbgHBR6v/20200802175851Z+2001@vger.kernel.org>
 <68c39e83-1155-0c8d-96a9-0418bdaf850d@gmx.de>
 <7437ab4d-9cd1-fe53-a17a-fc9e966ccd92@youngman.org.uk>
 <d8f9d16d-b6a2-77ba-bff2-a56c62dac5df@gmx.de>
Message-ID: <057b0c58-3876-0f03-af33-86f3b266a18a@gmx.de>
Date:   Sun, 2 Aug 2020 22:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d8f9d16d-b6a2-77ba-bff2-a56c62dac5df@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dckAU7C0P5xlqy0+O163HptztgBKi0a8SdZmVd6YBzspeF03zup
 gM655Zoejoi7VLfk2j6ws6LuxyxRfB+RaZ99rtSuWyipuYb9xvVWll6vOzhqpE8gbA89E5W
 2KMpsLEt19YTJV/8+nDx9dlKOwfqoQNsWRsy6g6yBIG8+OOVidIROC4AYSdmI3kQUu65u2L
 VBTP0xuMWB0fChf7x7WKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7hCo+ufQSEE=:vOxZD+Dfmk5V9a0AFVXhkW
 neux0NqCZOj4wXzaZE8D/4mPjPSXv7yMDBfh3tvcTT0Cq/P78kK4oxRxLx3rHIDxBURtkwtiF
 6U9s9111fIx/O368gDtcuzid9t11b4FV32/13XmDkXU8KdZ9vI5jt3ZGDZLCjQMHFRZdVPW/u
 /3dqC2hyFa8+10n1qFONoRKR3lNJW5FrpDKA7duOgHhhLe0QY5eWJPlQDMmChP2hPMZIEHzPh
 Zyg9g/+8tIZLAPMRJnLtNMADTVwe1IMiPsKdm5uXnS38R7Mwd3LLkhQDZnq0aVlpljey23RIT
 coNK9BseQY19hrHlzEwrEzcVxQvum4yXvsFsCxAbtwTi0q3h6jF64+SUnNLJSGxqDJxZ5vEEp
 WJMHUh/xWOEYkHMq8NVUlRJMk2la7yziw/L66dy5jnagw8pc6TNhblcCGYg52631r9RzGxdh0
 Ggqn785gHKu0htJusd98ESwZt3L+xupsWw7dto7Cvfs42HRJDBBhxznS/UFBzYoHXcyYES7c6
 nZ1ZYKNCJHJVERwJ1EDezxhTkEtr4p/Z7xDZg3lbmgbSlWA2A+ZOeD8Cjn6GTpTsgBcZRSnFh
 gk9qaxE+UXyU9PDi+fJ/DtbqghwjzVIS7DHvNvkFxC17kbMjcj+HBYTexlekvfECrWLC+Lgao
 SOLCTuR3uZU4uk95VGcDOdOIOQvy54IZzwy5YrIrGdsevXVjrRRm3DjtPZXrJVCrJCTkeNQYs
 dRXuC6l4T/Aauat6UrAFhTfQngcN1qxZoyARYMnmnblPc8lm0A6BktkouXlE1VGpAdnS5x9vz
 5ON23WWL4RfgcRnb468RoHwTBWs+vt11vqlHNSoNxWSO6tFILlgWlYe7+95j6ogfU8PBVds44
 iR8gD7vc1gOdZrmytx8jd4VXkJtETqDxLWY63D6YU3R5oZmExfjJIUhIM010zXtvfU+GLxwGm
 u+15ipZIcvDsD6ac0402Qr/q373wyG1TzuJ44KYeqd525NUVN8x43nFlDQ5ukZNsJaK/Qg+LX
 8iVC2YuM4WOki5sCCXPDOhUpgO3ct+cTdDj/yvL3qFXMKi+lZusgd0LEuaAdh4EDmMGyka8jJ
 UK2PEYALYYow49+jA/emZhtzRIuzCtHPgDiN5IS94CUc+n7/8K1oyfvSGNjfqJwVtzQ4Octak
 GnUMF15C4Gek9Ui4uP3XTHwdCIQxqAHQUjIl8UlIVFHcFatrn9zKJ14+3h0x5nunepOz49q8S
 luBvMpZhEbhScxrvXvk5YvyeePzJgoKddZoF7R+00HdQDx5N5U3m+lnG4fcaytUV9hdlXT7ad
 7UXavuro/JcC3o+OCanXtSxF10kigilN5HsndbU2m04rvt9KVGSNI4vJQOZgy7sNp0Rekk/gF
 dwGbnO9H9KjQCXKPaHkeA==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 02.08.20 21:24, tyranastrasz@gmx.de wrote:
> On 02.08.20 21:01, antlists wrote:
>> On 02/08/2020 19:09, tyranastrasz@gmx.de wrote:
>>> Hello
>>>
>>> I've a problem with my raid0.
>>> The probelmatic disks (2x 1TB wdred) were in usage in my server, now
>>> they got replaced with 3x 4TB seagate in a raid5.
>>>
>>> Before I turned them off, I made a backup on an external drive (normal
>>> hdd via USB) via rsync -avx /source /mnt/external/
>>>
>>> Whatever happens in the night, the backup isn't complete and I miss
>>> files.
>>> So I put the old raid again into the server and wanted to start, but t=
he
>>> Intel Raid Controller said that one of the disks are no member of a
>>> raid.
>>>
>>> My server mainboard is from Gigabyte a MX11-PC0.
>>>
>>> Well I made some mdadm examines, smartctl, mdstat, lsdrv logfiles and
>>> attached them to the mail.
>>>
>> Ow...
>>
>> This is still the same linux on the server? Because mdstat says no raid
>> personalities are installed. Either linux has changed or you've got
>> hardware raid. in which case you'll need to read up on the motherboard
>> manual.
>>
>> I'm not sure what they're called, but try "insmod raid1x" I think it is=
.
>> Could be raid0x. If that loads the raid0 driver, cat /proc/mdstat shoul=
d
>> list raid0 as a personality. Once that's there, mdadm may be able to
>> start the array.
>>
>> Until you've got a working raid driver in the kernel, I certainly can't
>> help any further. But hopefully reading the mobo manual might help. The
>> other thing to try is an up-to-date rescue disk and see if that can rea=
d
>> the array.
>>
>> Cheers,
>> Wol
>
> No, I have the disks in my pc.
> The server can't boot the disks because Intel Storage says the raid has
> a failure, because one of the disks has no raid information. But as I
> read them both yesterday they had, now (see the last attachment) one of
> them has none.
> It makes no sense... I need the files
>
> Intel means "yeah make a new raid, with data loss" that's no option.
>
> Nara


I tried something what was told here
https://askubuntu.com/questions/69086/mdadm-superblock-recovery

root@Nibler:~# mdadm --create /dev/md0 -v -f -l 0 -c 128 -n 2 /dev/sdd
/dev/sdb
mdadm: /dev/sdd appears to be part of a raid array:
        level=3Dcontainer devices=3D0 ctime=3DThu Jan  1 01:00:00 1970
mdadm: partition table exists on /dev/sdb
mdadm: partition table exists on /dev/sdb but will be lost or
        meaningless after creating array
Continue creating array? yes
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.


root@Nibler:~# mdadm --examine /dev/sdb
/dev/sdb:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : db01d7d9:e46ce30a:792e1d3a:31618e71
            Name : Nibler:0  (local to host Nibler)
   Creation Time : Sun Aug  2 22:13:10 2020
      Raid Level : raid0
    Raid Devices : 2

  Avail Dev Size : 1953260976 (931.39 GiB 1000.07 GB)
     Data Offset : 264192 sectors
    Super Offset : 8 sectors
    Unused Space : before=3D264112 sectors, after=3D0 sectors
           State : clean
     Device UUID : 0ea95638:7e83e76b:848ff6d2:e264029b

     Update Time : Sun Aug  2 22:13:10 2020
   Bad Block Log : 512 entries available at offset 8 sectors
        Checksum : 1b2cf600 - correct
          Events : 0

      Chunk Size : 128K

    Device Role : Active device 1
    Array State : AA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)
root@Nibler:~# mdadm --examine /dev/sdd
/dev/sdd:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : db01d7d9:e46ce30a:792e1d3a:31618e71
            Name : Nibler:0  (local to host Nibler)
   Creation Time : Sun Aug  2 22:13:10 2020
      Raid Level : raid0
    Raid Devices : 2

  Avail Dev Size : 1953260976 (931.39 GiB 1000.07 GB)
     Data Offset : 264192 sectors
    Super Offset : 8 sectors
    Unused Space : before=3D264112 sectors, after=3D0 sectors
           State : clean
     Device UUID : cef9d210:a794ef1e:6e37ee0e:34e10c52

     Update Time : Sun Aug  2 22:13:10 2020
   Bad Block Log : 512 entries available at offset 8 sectors
        Checksum : 99b37c22 - correct
          Events : 0

      Chunk Size : 128K

    Device Role : Active device 0
    Array State : AA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D re=
placing)


But I have no access to /dev/md0 or /dev/md0p1 or /dev/md0p2

root@Nibler:~# mount -o ro /dev/md0p1 /mnt/raid
NTFS signature is missing.
Failed to mount '/dev/md0p1': Invalid argument
The device '/dev/md0p1' doesn't seem to have a valid NTFS.
Maybe the wrong device is used? Or the whole disk instead of a
partition (e.g. /dev/sda, not /dev/sda1)? Or the other way around?


What can I do now?
Even if it costs money...

Nara


