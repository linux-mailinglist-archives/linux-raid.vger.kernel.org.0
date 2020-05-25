Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BB1E140D
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 20:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389242AbgEYSY7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbgEYSY6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 14:24:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82372C061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 11:24:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x13so3233352wrv.4
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=REeV1qbmWSONwQYrjbcS0gyMiGXuoaG15yTELFCw2hs=;
        b=p8UHONMX92UFZUzgaPDh6eVYvVdqEqivV01rgxRNwtKzXLCFKDLxvmEr/+TzqUOxWq
         n9M3H3dMP2uE25774J2tFMOP0e7hTZbxmy1U9DPbOxngVfPVhhaUn0XsbFPPQUdKSth1
         gQHWsGp6n0tTifLS/HwUrWpKzUhKoG8og8bWwqTX5EAUEUHrFYOJ6lZASeVI2w4QP8X6
         hlms4NqaQQ8cDY2oUoawV+DothLkGkh/xXu0YxYCUG4iTpVBq7nxNG+rKn60xQ6mNK35
         K3Gau2r6tkHxsSqeVxtrOG4MyQ8zet5dFAaA+UbLLAQ7wd7VU3sPCE5+jOuIgc+3dthZ
         IPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=REeV1qbmWSONwQYrjbcS0gyMiGXuoaG15yTELFCw2hs=;
        b=A/cXmzr9DOz80H0HCdHgeTsLk6CuKZUJaZyi4QHbpygfmYVXHrWYJ+s5rT24hTtdMn
         aUqpRPqzu1hPlLyf6qfLG4r+bYwZESSRrESvsySwJhgvWAlC4yxG513wyDRno/KK6gxL
         g8PnbF5JWMfGMvNM7Etk3kuorw/4Jvsa6wkpShhAnzj14B48ETHzyxFUyI5XrbpSktU5
         J9eVS2JtuYZGatorFlWW5CV7wystAQmuuzi9Q7rx7gskh1pzMMpDujl821droYhuGu9/
         zUC0Xr+Yl/KUindivU7VSw6trw2vcU/wj7UZAXB8CjGmI7O7VVXF5HNszl+qeAQycAg/
         AfxA==
X-Gm-Message-State: AOAM5307d9PRzoP29ppYB1ERuw3a31DN9Mww3buAfZs8oXXyPNy1pp1L
        AdZ+sGnefHVK9rn1XhzMy6WZLI7xZyw=
X-Google-Smtp-Source: ABdhPJwAKVqge/Qbj+MvNufWVvRBvn0eqLX3ivGsmAtVy3OX+YX24gju2xGrKFdCJaZsz4cGSyYGeA==
X-Received: by 2002:a5d:4490:: with SMTP id j16mr6788119wrq.276.1590431096946;
        Mon, 25 May 2020 11:24:56 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id q144sm19796581wme.0.2020.05.25.11.24.56
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 11:24:56 -0700 (PDT)
Subject: Re: help requested for mdadm grow error
To:     linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
From:   Thomas Grawert <thomasgrawert0282@gmail.com>
Message-ID: <b4bfd58e-dea0-a7e3-5555-2e819aaf17e1@gmail.com>
Date:   Mon, 25 May 2020 20:24:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5ECC09D6.1010300@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>
> Especially
>
> https://raid.wiki.kernel.org/index.php/Asking_for_help
>
> More will follow but we need this info.
>
> Cheers,
> Wol

And the output of examine:
root@nas:~# mdadm -E /dev/sda1
/dev/sda1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x5
      Array UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
            Name : nas:0  (local to host nas)
   Creation Time : Sun May 17 00:23:42 2020
      Raid Level : raid5
    Raid Devices : 5

  Avail Dev Size : 23437504512 (11175.87 GiB 12000.00 GB)
      Array Size : 46875009024 (44703.49 GiB 48000.01 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262056 sectors, after=0 sectors
           State : active
     Device UUID : 64b8c8bd:400cf9d1:d5161aac:4b8ac29a

Internal Bitmap : 8 sectors from superblock
   Reshape pos'n : 0
   Delta Devices : 1 (4->5)

     Update Time : Mon May 25 16:05:38 2020
   Bad Block Log : 512 entries available at offset 72 sectors
        Checksum : d9c3b859 - correct
          Events : 38602

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 0
    Array State : AAAAA ('A' == active, '.' == missing, 'R' == replacing)

======================================

root@nas:~# mdadm -E /dev/sdb1
/dev/sdb1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x5
      Array UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
            Name : nas:0  (local to host nas)
   Creation Time : Sun May 17 00:23:42 2020
      Raid Level : raid5
    Raid Devices : 5

  Avail Dev Size : 23437504512 (11175.87 GiB 12000.00 GB)
      Array Size : 46875009024 (44703.49 GiB 48000.01 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262056 sectors, after=0 sectors
           State : active
     Device UUID : d1f20899:f22a1267:6525deb0:e109960c

Internal Bitmap : 8 sectors from superblock
   Reshape pos'n : 0
   Delta Devices : 1 (4->5)

     Update Time : Mon May 25 16:05:38 2020
   Bad Block Log : 512 entries available at offset 72 sectors
        Checksum : c0b49f9e - correct
          Events : 38602

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 1
    Array State : AAAAA ('A' == active, '.' == missing, 'R' == replacing)

=========================================

root@nas:~# mdadm -E /dev/sdc1
/dev/sdc1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x5
      Array UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
            Name : nas:0  (local to host nas)
   Creation Time : Sun May 17 00:23:42 2020
      Raid Level : raid5
    Raid Devices : 5

  Avail Dev Size : 23437504512 (11175.87 GiB 12000.00 GB)
      Array Size : 46875009024 (44703.49 GiB 48000.01 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262056 sectors, after=0 sectors
           State : active
     Device UUID : 6e6c5cd4:0f3d0695:fac0399d:060554d8

Internal Bitmap : 8 sectors from superblock
   Reshape pos'n : 0
   Delta Devices : 1 (4->5)

     Update Time : Mon May 25 16:05:38 2020
   Bad Block Log : 512 entries available at offset 72 sectors
        Checksum : e215c214 - correct
          Events : 38602

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 2
    Array State : AAAAA ('A' == active, '.' == missing, 'R' == replacing)

============================================

root@nas:~# mdadm -E /dev/sdd1
/dev/sdd1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x5
      Array UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
            Name : nas:0  (local to host nas)
   Creation Time : Sun May 17 00:23:42 2020
      Raid Level : raid5
    Raid Devices : 5

  Avail Dev Size : 23437504512 (11175.87 GiB 12000.00 GB)
      Array Size : 46875009024 (44703.49 GiB 48000.01 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262056 sectors, after=0 sectors
           State : active
     Device UUID : 999c5ee2:180dc99f:7c65cac5:d46fac89

Internal Bitmap : 8 sectors from superblock
   Reshape pos'n : 0
   Delta Devices : 1 (4->5)

     Update Time : Mon May 25 16:05:38 2020
   Bad Block Log : 512 entries available at offset 72 sectors
        Checksum : d4c3d19a - correct
          Events : 38602

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 3
    Array State : AAAAA ('A' == active, '.' == missing, 'R' == replacing)

===============================================

root@nas:~# mdadm -E /dev/sde1
/dev/sde1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x5
      Array UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
            Name : nas:0  (local to host nas)
   Creation Time : Sun May 17 00:23:42 2020
      Raid Level : raid5
    Raid Devices : 5

  Avail Dev Size : 23437504512 (11175.87 GiB 12000.00 GB)
      Array Size : 46875009024 (44703.49 GiB 48000.01 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262056 sectors, after=0 sectors
           State : active
     Device UUID : 29cfb720:59627867:f11153ce:443a6395

Internal Bitmap : 8 sectors from superblock
   Reshape pos'n : 0
   Delta Devices : 1 (4->5)

     Update Time : Mon May 25 16:05:38 2020
   Bad Block Log : 512 entries available at offset 72 sectors
        Checksum : ef0bd050 - correct
          Events : 38602

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 4
    Array State : AAAAA ('A' == active, '.' == missing, 'R' == replacing)

========================


root@nas:~# mdadm -E /dev/sda
/dev/sda:
    MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)
root@nas:~# mdadm -E /dev/sdb
/dev/sdb:
    MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)
root@nas:~# mdadm -E /dev/sdc
/dev/sdc:
    MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)
root@nas:~# mdadm -E /dev/sdd
/dev/sdd:
    MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)
root@nas:~# mdadm -E /dev/sde
/dev/sde:
    MBR Magic : aa55
Partition[0] :   4294967295 sectors at            1 (type ee)


