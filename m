Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653D917688A
	for <lists+linux-raid@lfdr.de>; Tue,  3 Mar 2020 00:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCBX5Q (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Mar 2020 18:57:16 -0500
Received: from mail-vk1-f169.google.com ([209.85.221.169]:37657 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCBX5Q (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Mar 2020 18:57:16 -0500
Received: by mail-vk1-f169.google.com with SMTP id t192so374860vkb.4
        for <linux-raid@vger.kernel.org>; Mon, 02 Mar 2020 15:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SCluOxJwM6SY3CYGySdEwrtY7nrMrBfakmNkRaxm2w=;
        b=IAzBvmvVs/C54E3c3ecXWXTh0nbDnSAFtyuUwcueFyQ9s48/ZyGKD8La6TkscMvhHy
         xH+KLlSxbDfpLD1yU2aVTu73uLiZ9oqym619mAUngHKKECgbIGM+dK5frO1dAxRLWFnu
         k0xZ91RCk/nW3BWUBIeP0MQ/Skh3cVEx6yFjLUmpgQzCcGF5WEkO+heXySIXXUpeATOk
         HxvV++6DTfINeiU3uAnFYw8wKxHKonfQk+Pt07UkpKilwb8SwerNd0qk++XMrliaqoP7
         Dy+5aMIuJq/1/7lIRBqyWzCgqqJ0dW3/Ea74VfreRf34xa+n2DTB8YFajdw+HFKMdx1p
         UypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SCluOxJwM6SY3CYGySdEwrtY7nrMrBfakmNkRaxm2w=;
        b=azl33xR5imbyI0aDg8PA+E2VrstsmFy5HbKiJjB7jBqRFWIFi1+xXSs1v3n9ZhcNSx
         QldR0AxRkTJf9Ix+TirsX2YoFGPZciWvEex9FFAQfpJheF4AzCEzs8/XSA/gCh4+zyDv
         pa/gnVBGHVLNyq0mnw18XbVk9dUFpRtjiQ/FOTvhq/APQetSeDRpjpCw6O2iBUu1uhKM
         HjNFUSEzs0J11m0RdZn4Ck418WpYQiSGJTem3eWjWsFfaE1yUqdp7XG68qdjuJTDtjzi
         /zlII4LC8BOkFPQfsdn7QGBYgOX2Gq9ruAxJ1g00avl6p50exxaHft1dWKJb8o23zuCq
         opSg==
X-Gm-Message-State: ANhLgQ3INXdGkLd1JSLQl6UqaTsFw5pHhw9WyOmmbn4zHBVSK9n9KGHm
        ckVyQaNhBpzQiCyeP0GCbn/TXPkvwBpqPHngg8XsJQs6
X-Google-Smtp-Source: ADFU+vsM+hYr+WS4jzZMoUWCIIRDjQEwYrbDsH4DQMsJS151G1kpMxj9pq4DY8wLdEbZo3oaSbCTKS0BVXiW5ENNDi0=
X-Received: by 2002:a1f:9948:: with SMTP id b69mr1408178vke.13.1583193434418;
 Mon, 02 Mar 2020 15:57:14 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW7C30Z6bccQLXLPf8zYuM=aBVZ_hLgW3i5gqZFVsLRpfA@mail.gmail.com>
 <fa393999-3f56-0bcf-b097-462a209f1eae@youngman.org.uk> <20200302004806.54852908@natsu>
 <cf69979e-8df7-31f4-a2f0-a6187aef6f6d@youngman.org.uk>
In-Reply-To: <cf69979e-8df7-31f4-a2f0-a6187aef6f6d@youngman.org.uk>
From:   William Morgan <therealbrewer@gmail.com>
Date:   Mon, 2 Mar 2020 17:57:03 -0600
Message-ID: <CALc6PW5RuDMk3YAc24FcAeXR1=rPd2tuSrTcWw3a8Vk6Otfd9w@mail.gmail.com>
Subject: Re: Grow array and convert from raid 5 to 6
To:     antlists <antlists@youngman.org.uk>
Cc:     Roman Mamedov <rm@romanrm.net>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Well, while I was contemplating my options, a power outage caused my
array to fail to a degraded state. One of the drives is now marked as
a spare and i can't figure out how to get it back into the array. Does
it have to be completely rebuilt?

bill@bill-desk:~$ sudo mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Sat Sep 22 19:10:10 2018
        Raid Level : raid5
        Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
     Used Dev Size : 7813893120 (7451.91 GiB 8001.43 GB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Mon Mar  2 17:41:32 2020
             State : clean, degraded
    Active Devices : 3
   Working Devices : 4
    Failed Devices : 0
     Spare Devices : 1

            Layout : left-symmetric
        Chunk Size : 64K

Consistency Policy : bitmap

              Name : bill-desk:0  (local to host bill-desk)
              UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
            Events : 10407

    Number   Major   Minor   RaidDevice State
       0       8      129        0      active sync   /dev/sdi1
       1       8      145        1      active sync   /dev/sdj1
       2       8      161        2      active sync   /dev/sdk1
       -       0        0        3      removed

       4       8      177        -      spare   /dev/sdl1
bill@bill-desk:~$ sudo mdadm --examine /dev/sdi1
/dev/sdi1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x9
     Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
           Name : bill-desk:0  (local to host bill-desk)
  Creation Time : Sat Sep 22 19:10:10 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 15627786240 (7451.91 GiB 8001.43 GB)
     Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=264112 sectors, after=0 sectors
          State : clean
    Device UUID : ab1323e0:9c0426cf:3e168733:b73e9c5c

Internal Bitmap : 8 sectors from superblock
    Update Time : Mon Mar  2 17:41:16 2020
  Bad Block Log : 512 entries available at offset 40 sectors - bad
blocks present.
       Checksum : f197b17c - correct
         Events : 10407

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 0
   Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
bill@bill-desk:~$ sudo mdadm --examine /dev/sdj1
/dev/sdj1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
           Name : bill-desk:0  (local to host bill-desk)
  Creation Time : Sat Sep 22 19:10:10 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 15627786240 (7451.91 GiB 8001.43 GB)
     Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=264112 sectors, after=0 sectors
          State : clean
    Device UUID : c875f246:ce25d947:a413e198:4100082e

Internal Bitmap : 8 sectors from superblock
    Update Time : Mon Mar  2 17:41:32 2020
  Bad Block Log : 512 entries available at offset 40 sectors
       Checksum : 7e0f516 - correct
         Events : 10749

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 1
   Array State : AAA. ('A' == active, '.' == missing, 'R' == replacing)
bill@bill-desk:~$ sudo mdadm --examine /dev/sdk1
/dev/sdk1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x1
     Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
           Name : bill-desk:0  (local to host bill-desk)
  Creation Time : Sat Sep 22 19:10:10 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 15627786240 (7451.91 GiB 8001.43 GB)
     Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=264112 sectors, after=0 sectors
          State : clean
    Device UUID : fd0634e6:6943f723:0e30260e:e253b1f4

Internal Bitmap : 8 sectors from superblock
    Update Time : Mon Mar  2 17:41:32 2020
  Bad Block Log : 512 entries available at offset 40 sectors
       Checksum : bf2f13f2 - correct
         Events : 10749

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : Active device 2
   Array State : AAA. ('A' == active, '.' == missing, 'R' == replacing)
bill@bill-desk:~$ sudo mdadm --examine /dev/sdl1
/dev/sdl1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x9
     Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
           Name : bill-desk:0  (local to host bill-desk)
  Creation Time : Sat Sep 22 19:10:10 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 15627786240 (7451.91 GiB 8001.43 GB)
     Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=264112 sectors, after=0 sectors
          State : clean
    Device UUID : 8c628aed:802a5dc8:9d8a8910:9794ec02

Internal Bitmap : 8 sectors from superblock
    Update Time : Mon Mar  2 17:41:32 2020
  Bad Block Log : 512 entries available at offset 40 sectors - bad
blocks present.
       Checksum : 7b89f1e6 - correct
         Events : 10749

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : spare
   Array State : AAA. ('A' == active, '.' == missing, 'R' == replacing)
