Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E78F8E0D84
	for <lists+linux-raid@lfdr.de>; Tue, 22 Oct 2019 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfJVUvX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 22 Oct 2019 16:51:23 -0400
Received: from secmail.pro ([146.185.132.44]:37308 "EHLO secmail.pro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfJVUvX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 22 Oct 2019 16:51:23 -0400
Received: by secmail.pro (Postfix, from userid 33)
        id 83D2DDF91E; Tue, 22 Oct 2019 20:49:21 +0000 (UTC)
Received: from secmailw453j7piv.onion (localhost [IPv6:::1])
        by secmail.pro (Postfix) with ESMTP id 5C8001F34AB;
        Tue, 22 Oct 2019 13:51:20 -0700 (PDT)
Received: from 127.0.0.1
        (SquirrelMail authenticated user hhardly@secmail.pro)
        by giyzk7o6dcunb2ry.onion with HTTP;
        Tue, 22 Oct 2019 13:51:20 -0700
Message-ID: <436ad5949675c156e4062fb23e27c482.squirrel@giyzk7o6dcunb2ry.onion>
In-Reply-To: <aff61b6a-15e1-555a-e507-f8dcfcfd3135@intel.com>
References: <0a32d9235127ec7760334c3308ee6384.squirrel@giyzk7o6dcunb2ry.onion>
    <aff61b6a-15e1-555a-e507-f8dcfcfd3135@intel.com>
Date:   Tue, 22 Oct 2019 13:51:20 -0700
Subject: Re: How to assemble Intel RST Matrix volumes?
From:   hhardly@secmail.pro
To:     "Artur Paszkiewicz" <artur.paszkiewicz@intel.com>
Cc:     linux-raid@vger.kernel.org
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Greetings Artur thank you very much for helping me. See reply inline:

> On 10/20/19 10:44 PM, hhardly@secmail.pro wrote:
>> With only the parent container assembled I have this:
>>
>> # cat /proc/mdstat
>> Personalities :
>> md0 : inactive sdc[0](S)
>>       5201 blocks super external:imsm
>>
>> Is "inactive" a problem? Adding --run to the --assemble makes no
>> difference. Is the small block count only for the superblocks?
>>
>> How can I assemble and access those Intel Matrix volumes?
>
> The "inactive" state is normal for containers. Try doing this now:
>
> # IMSM_NO_PLATFORM=1 mdadm --incremental /dev/md0 --run
>
> It should assemble both volumes as degraded. If that doesn't work, please
> send
> the output from "mdadm -E /dev/sdc".

Adding --run didn't help:

# IMSM_NO_PLATFORM=1 mdadm --incremental -e imsm -v /dev/md0 --run
mdadm: /dev/md0 is not part of an md array.

Here is the output you asked for, which shows does show the volumes. Any
further assistance is greatly appreciated.

# IMSM_NO_PLATFORM=1 mdadm -E /dev/sdc
/dev/sdc:
          Magic : Intel Raid ISM Cfg Sig.
        Version : 1.3.00
    Orig Family : ca956afe
         Family : ca956afe
     Generation : 00110f9d
     Attributes : All supported
           UUID : 4724d742:24d8ea31:7b833d5c:b82367ca
       Checksum : a52d91d6 correct
    MPB Sectors : 2
          Disks : 2
   RAID Devices : 2

[Volume1]:
           UUID : 7eb953ee:f73f5b59:46d4cb8c:0b6911e0
     RAID Level : 1
        Members : 2
          Slots : [_U]
    Failed disk : 0
      This Slot : ?
    Sector Size : 512
     Array Size : 524288000 (250.00 GiB 268.44 GB)
   Per Dev Size : 524288264 (250.00 GiB 268.44 GB)
  Sector Offset : 0
    Num Stripes : 2048000
     Chunk Size : 64 KiB
       Reserved : 0
  Migrate State : idle
      Map State : degraded
    Dirty State : clean
     RWH Policy : off

[Volume2]:
           UUID : 941025e0:208ad897:1c941c20:2e5bd48e
     RAID Level : 1
        Members : 2
          Slots : [_U]
    Failed disk : 0
      This Slot : ?
    Sector Size : 512
     Array Size : 452474880 (215.76 GiB 231.67 GB)
   Per Dev Size : 452475144 (215.76 GiB 231.67 GB)
  Sector Offset : 524292360
    Num Stripes : 1767480
     Chunk Size : 64 KiB
       Reserved : 0
  Migrate State : idle
      Map State : degraded
    Dirty State : dirty
     RWH Policy : off

  Disk00 Serial : 500WH18HEAL:0:0
          State : active failed
             Id : ffffffff
    Usable Size : 976762766 (465.76 GiB 500.10 GB)

  Disk01 Serial : TF0501WH1NXL0Q
          State : active
             Id : 00000001
    Usable Size : 976762766 (465.76 GiB 500.10 GB)

