Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A4819B519
	for <lists+linux-raid@lfdr.de>; Wed,  1 Apr 2020 20:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgDASHu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Apr 2020 14:07:50 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45916 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbgDASHu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 1 Apr 2020 14:07:50 -0400
Received: by mail-vk1-f194.google.com with SMTP id b187so124688vkh.12
        for <linux-raid@vger.kernel.org>; Wed, 01 Apr 2020 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iowni-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iefAXez1aOGwIUcSN+ObMoBPKGk338uhkxDZiq4L3M4=;
        b=lYWMAwyfCq3pcVzhiPd2ASDCAziYqImz5yqtPtufQ1blSZBSMMt1ojV/G8yxAtpcp6
         PACEQbkRulx2Dgrbi3q0AQEl28kxMWePeA37wqsUw0MHU3e2Cseq9AVfj/FrmpB1Lqpb
         wIz9ggsVeHLf8J+0dhFqLbz4ykUYghvPAghqSjsSdGO9hdVvX+7uHy/EC2Drvl/twMRP
         9cZMcEnPkkzEV2ZIW0aNQSbdmKefNfAbdN7Ptd2hDmxkGXy0R8tF5sLSDB63u5jTJJuX
         HGo7+Kv2j2bPdh/M1dC86NbSzhPKQ2pwN/zOhqVwb9/ZKz6/u7vlqnEHby32x71oMS9z
         NyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iefAXez1aOGwIUcSN+ObMoBPKGk338uhkxDZiq4L3M4=;
        b=lsfgvXod+TIbdSLE2wofyIGNXv909karFvBYCLePd5iekZzKs6Xtt6tQMMG5aSIoA2
         fgDZvblRpU3A8sgcMAzy58LHKA9Jsgfr4Nr7yr5xiH8T4EutT/GXX35pI653plGyqlFj
         Tvp++wSiICGR+8Es4m93TCJJABnJx5LJnIY5yYCGlt5ilCsA5QcosCDVrEyvq3JAlTcK
         PtoNrT4g6Pu+eXivBisN4Qa1+5d7ojl5dMsTZnsEN4O8BX13N/A8vHJsUIW6zda6TSbE
         nibiOolZteObb4n8dHnsjbPE/VWoZano0W/2AxEYM3iZM72QOsrz90H1W/a5xsZ8BXb3
         UxhQ==
X-Gm-Message-State: AGi0PuaVG6NkEc4a7uNGv1qU6NVB32QE8Z1mzWdnHjGHDiiM28UyAAXw
        0JlxFhcFE2De3sh1wDKNZMUCyOE4JAJPbDnC8kmx8g==
X-Google-Smtp-Source: APiQypJ14G4DIAJVaw6O19TylqtFj+QgPML7ixiYTuoMNBAW1JmA0vT51wcwc+zhbPXvn+36NmIhGg8AVI4RXoCMOeg=
X-Received: by 2002:a1f:1846:: with SMTP id 67mr2915640vky.32.1585764468035;
 Wed, 01 Apr 2020 11:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk> <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org> <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
 <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org> <CAB00BMj5kihqwOY-FOXv-tqG1b2reMnUVkdmB9uyNAeE7ESasw@mail.gmail.com>
 <061b695a-2406-fc00-dd6d-9198b85f3b1b@turmel.org> <CAB00BMi3zhfVGpeE_AyyKiu1=MY2icYgfey0J3GeO8z9ZDAQbg@mail.gmail.com>
 <5E8485DA.2050803@youngman.org.uk> <9a303b9b-52b8-f0c6-4288-120338c6572f@turmel.org>
 <CAB00BMig177NjEbBQgfjQ5gZE3QPTR-B6FD9i8oczHqf7mMqcg@mail.gmail.com>
 <1f4b8c74-4c38-6ea4-6868-b28f9e5c4a10@turmel.org> <e75f80f4-70d4-e283-b3bc-c78bd0d55a8a@turmel.org>
In-Reply-To: <e75f80f4-70d4-e283-b3bc-c78bd0d55a8a@turmel.org>
From:   Daniel Jones <dj@iowni.com>
Date:   Wed, 1 Apr 2020 12:07:35 -0600
Message-ID: <CAB00BMhU76rjvQv9v-HxM8Harc9ssLBANWfPsW9abbSRNgwoUQ@mail.gmail.com>
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Phil Turmel <philip@turmel.org>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Phil,

So far so good.

1: I have run gdisk on each physical drive to create a new partition.

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048     19532873694   9.1 TiB     8300  Linux filesystem

2: Everything from here is on overlays. I tested many combinations of
--create. This appears to be the correct one:

mdadm --create /dev/md0 --assume-clean --data-offset=129536 --level=5
--chunk=512K --raid-devices=4 missing /dev/mapper/sdc1
/dev/mapper/sdd1 /dev/mapper/sde1

Data offset was calculated to be (261120-2048)/2 since my mdadm
expects it in kB.
All six combinations of device orders were tested, bcde was the only
one that fsck liked.
Array was tested in configs of bcde, Xcde, bcXe, bcdX (where X is missing).
Configs that passed fsck were mounted and data inspected.

  bcde = did not contain last files known to be written to array
  Xcde = **did** contain last files known to be written to array
  bcXe = fsck 400,000+ errors
  bcdX = did not contain last files known to be written to array

3: I then attempted to add the removed drive (still using overlay).

# mdadm --manage /dev/md0 --re-add /dev/mapper/sdb1
mdadm: --re-add for /dev/mapper/sdb1 to /dev/md0 is not possible

# mdadm --manage /dev/md0 --add /dev/mapper/sdb1
mdadm: added /dev/mapper/sdb1

It did this for a short while

# cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4]
md0 : active raid5 dm-3[4] dm-6[3] dm-5[2] dm-4[1]
      29298917376 blocks super 1.2 level 5, 512k chunk, algorithm 2 [4/3] [_UUU]
      [>....................]  recovery =  0.0% (457728/9766305792)
finish=18089.5min speed=8997K/sec
      bitmap: 0/73 pages [0KB], 65536KB chunk

Then ended in this state:

# cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4]
md0 : active raid5 dm-3[4](F) dm-6[3] dm-5[2] dm-4[1]
      29298917376 blocks super 1.2 level 5, 512k chunk, algorithm 2 [4/3] [_UUU]
      bitmap: 2/73 pages [8KB], 65536KB chunk

unused devices: <none>

# mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Wed Apr  1 11:34:26 2020
        Raid Level : raid5
        Array Size : 29298917376 (27941.63 GiB 30002.09 GB)
     Used Dev Size : 9766305792 (9313.88 GiB 10000.70 GB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Wed Apr  1 11:41:27 2020
             State : clean, degraded
    Active Devices : 3
   Working Devices : 3
    Failed Devices : 1
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : bitmap

              Name : hulk:0  (local to host hulk)
              UUID : 29e8195c:1da9c101:209c7751:5fc7d1b9
            Events : 37

    Number   Major   Minor   RaidDevice State
       -       0        0        0      removed
       1     253        4        1      active sync   /dev/dm-4
       2     253        5        2      active sync   /dev/dm-5
       3     253        6        3      active sync   /dev/dm-6

       4     253        3        -      faulty   /dev/dm-3


# mdadm -E /dev/mapper/sd[bcde]1
mdadm: No md superblock detected on /dev/mapper/sdb1.
/dev/mapper/sdc1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 29e8195c:1da9c101:209c7751:5fc7d1b9
           Name : hulk:0  (local to host hulk)
  Creation Time : Wed Apr  1 11:34:26 2020
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 19532612575 sectors (9313.88 GiB 10000.70 GB)
     Array Size : 29298917376 KiB (27941.63 GiB 30002.09 GB)
  Used Dev Size : 19532611584 sectors (9313.88 GiB 10000.70 GB)
    Data Offset : 259072 sectors
   Super Offset : 8 sectors
   Unused Space : before=258992 sectors, after=991 sectors
          State : clean
    Device UUID : 683a2ac8:e9242cda:e522c872:f86ca9b5

Internal Bitmap : 8 sectors from superblock
    Update Time : Wed Apr  1 11:41:27 2020
  Bad Block Log : 512 entries available at offset 48 sectors
       Checksum : 1e17785b - correct
         Events : 37

         Layout : left-symmetric
     Chunk Size : 512K

   Device Role : Active device 1
   Array State : .AAA ('A' == active, '.' == missing, 'R' == replacing)
/dev/mapper/sdd1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 29e8195c:1da9c101:209c7751:5fc7d1b9
           Name : hulk:0  (local to host hulk)
  Creation Time : Wed Apr  1 11:34:26 2020
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 19532612575 sectors (9313.88 GiB 10000.70 GB)
     Array Size : 29298917376 KiB (27941.63 GiB 30002.09 GB)
  Used Dev Size : 19532611584 sectors (9313.88 GiB 10000.70 GB)
    Data Offset : 259072 sectors
   Super Offset : 8 sectors
   Unused Space : before=258992 sectors, after=991 sectors
          State : clean
    Device UUID : 63885fec:40e5f57f:59f73757:958d5cf6

Internal Bitmap : 8 sectors from superblock
    Update Time : Wed Apr  1 11:41:27 2020
  Bad Block Log : 512 entries available at offset 48 sectors
       Checksum : d397bbf - correct
         Events : 37

         Layout : left-symmetric
     Chunk Size : 512K

   Device Role : Active device 2
   Array State : .AAA ('A' == active, '.' == missing, 'R' == replacing)
/dev/mapper/sde1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 29e8195c:1da9c101:209c7751:5fc7d1b9
           Name : hulk:0  (local to host hulk)
  Creation Time : Wed Apr  1 11:34:26 2020
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 19532612575 sectors (9313.88 GiB 10000.70 GB)
     Array Size : 29298917376 KiB (27941.63 GiB 30002.09 GB)
  Used Dev Size : 19532611584 sectors (9313.88 GiB 10000.70 GB)
    Data Offset : 259072 sectors
   Super Offset : 8 sectors
   Unused Space : before=258992 sectors, after=991 sectors
          State : clean
    Device UUID : ad3fa4d3:20a0582a:098b31d1:38f2b248

Internal Bitmap : 8 sectors from superblock
    Update Time : Wed Apr  1 11:41:27 2020
  Bad Block Log : 512 entries available at offset 48 sectors
       Checksum : 6b30e63c - correct
         Events : 37

         Layout : left-symmetric
     Chunk Size : 512K

   Device Role : Active device 3
   Array State : .AAA ('A' == active, '.' == missing, 'R' == replacing)

4: Summary

The drives have had physical partitions written.
I think I've found the correct offset and device order to use --create
to restore the array to the degraded state it was in before the
superblocks were overwritten.
I'm not sure why the --add doesn't work.

Thanks so much for your help this far.

Regards,
DJ
