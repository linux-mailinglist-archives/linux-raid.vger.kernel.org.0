Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0942128AA8
	for <lists+linux-raid@lfdr.de>; Sat, 21 Dec 2019 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfLURms (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Dec 2019 12:42:48 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:46233 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLURms (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 21 Dec 2019 12:42:48 -0500
Received: by mail-ed1-f42.google.com with SMTP id m8so11629990edi.13
        for <linux-raid@vger.kernel.org>; Sat, 21 Dec 2019 09:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/+T5MTcfuhRXWPVf2j9A5UcLTnutKlCImISz9QhvsQ=;
        b=ANgiEjVAzJmTNZELeYQbJrF0N6t7r8m++RjQ8aaxjX/gH3MnEzhDr0/ahs+aug2zGa
         wlLH0eK7/ejfYMHQ6hbbkFpepbCBlXy5yOaS5fhFixudU3xXDlQ028YfN/enEBZQCCfe
         8Gc96FlbS8eeYqT5YL0DasnWxODhIxHuzdxSpXPLfNJr6Dv6Y2JmYzEL3fnojCLiI67I
         S3Y3OAexLyNkfK8osHOAsi43Je/QAv1s0lNVN4X3PafWZbBIh56BmWeWDjo9CS3tJYKu
         pqXuQC2Oa+EDBPa0Vc2TjAUINMSwhfpM5tXF6SGhZ9OyO2hvrMNhimAfBPuewccVD0lu
         3Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/+T5MTcfuhRXWPVf2j9A5UcLTnutKlCImISz9QhvsQ=;
        b=SGsnjTm5vOk+GlILl2UOcG7IG7somNMamJr0/EoVmckT4rIPSUH62fOeK+ZN+rfjYU
         f0P6RixkuA8pTjyn3FMYVFnjJShafY24k2sjQOBPRr0aSK5ZezN5U/UP/MyYiIfpxbyM
         HAw0u8wbjm2TbGeVnXDG6c+KmsHOVCkm0moxEaYGZCEExS2yj6C2zkZgUlUntgSmLmol
         UGy9kspaWWzus0RBBfk9cUFTs+O7cXBXul/Pg4I4W5g/fN5+liJbNY+vfVfPR2pry2Lw
         eIH0o2k3zDJ9e0KZnJMuaGRAoLkYlFnjQ103A7WW7ThEsue+e7Xt0Xy7i/cVAXdEtJrK
         m68g==
X-Gm-Message-State: APjAAAXZRnNwRh7r/mnsWrh8NI61cC73Yo2/MarGBqobPo5hbvXHuJNB
        0g6ihl4CoYRwFq9Aics44RvN0s6UzzSi2f5XBfMfgijffM8=
X-Google-Smtp-Source: APXvYqy7/Muecoyp8cri2YQ0MEGVfdUsStwPnF8ibom49gTPAonInwO2DIsWiAFdB3roAw/d1qSrZSbG94TylNCOM7c=
X-Received: by 2002:aa7:d1d0:: with SMTP id g16mr23707485edp.56.1576950165712;
 Sat, 21 Dec 2019 09:42:45 -0800 (PST)
MIME-Version: 1.0
References: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
 <20191217182509.GA16121@metamorpher.de>
In-Reply-To: <20191217182509.GA16121@metamorpher.de>
From:   Patrick Pearcy <patrick.pearcy@gmail.com>
Date:   Sat, 21 Dec 2019 12:42:35 -0500
Message-ID: <CAM-0FgOpi4EGuhM7DXSutRtxRSJ4nb9kLzM0U_3LZi-jxUDVWQ@mail.gmail.com>
Subject: Re: WD MyCloud PR4100 RAID Failure
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Andreas,

Sorry for late reply (e-mail was in SPAM folder).   Here is the
results of MDADM on partition #2.   Thanks for your assistance!!!

- Best Regards Patrick.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``

/dev/sda2:
          Magic : a92b4efc
        Version : 1.0
    Feature Map : 0x1
     Array UUID : 85b920ec:ad30b4b9:e6fea107:6a14bcf6
           Name : 1
  Creation Time : Thu Feb  2 03:28:56 2017
     Raid Level : raid5
   Raid Devices : 4
 Avail Dev Size : 15619661552 (7448.04 GiB 7997.27 GB)
     Array Size : 46858984320 (22344.11 GiB 23991.80 GB)
  Used Dev Size : 15619661440 (7448.04 GiB 7997.27 GB)
   Super Offset : 15619661808 sectors
          State : clean
    Device UUID : 00e63dcc:6ef28f57:fef06206:f60ddc6b
Internal Bitmap : 2 sectors from superblock
    Update Time : Thu Nov 21 15:11:27 2019
       Checksum : 821d602f - correct
         Events : 36
         Layout : left-symmetric
     Chunk Size : 64K
    Array Slot : 0 (empty, empty, 2, 3, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed)
   Array State : __uu 380 failed
/dev/sdb2:
          Magic : a92b4efc
        Version : 1.0
    Feature Map : 0x1
     Array UUID : 85b920ec:ad30b4b9:e6fea107:6a14bcf6
           Name : 1
  Creation Time : Thu Feb  2 03:28:56 2017
     Raid Level : raid5
   Raid Devices : 4
 Avail Dev Size : 15619661552 (7448.04 GiB 7997.27 GB)
     Array Size : 46858984320 (22344.11 GiB 23991.80 GB)
  Used Dev Size : 15619661440 (7448.04 GiB 7997.27 GB)
   Super Offset : 15619661808 sectors
          State : clean
    Device UUID : 7442af2a:e3ad9816:8ae564b4:ee70262b
Internal Bitmap : 2 sectors from superblock
    Update Time : Thu Nov 21 15:11:27 2019
       Checksum : ce3cf9d - correct
         Events : 36
         Layout : left-symmetric
     Chunk Size : 64K
    Array Slot : 1 (empty, empty, 2, 3, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed)
   Array State : __uu 380 failed
/dev/sdc2:
          Magic : a92b4efc
        Version : 1.0
    Feature Map : 0x1
     Array UUID : 85b920ec:ad30b4b9:e6fea107:6a14bcf6
           Name : 1
  Creation Time : Thu Feb  2 03:28:56 2017
     Raid Level : raid5
   Raid Devices : 4
 Avail Dev Size : 15619661552 (7448.04 GiB 7997.27 GB)
     Array Size : 46858984320 (22344.11 GiB 23991.80 GB)
  Used Dev Size : 15619661440 (7448.04 GiB 7997.27 GB)
   Super Offset : 15619661808 sectors
          State : clean
    Device UUID : 6daba591:58037e27:243658e8:98cb746e
Internal Bitmap : 2 sectors from superblock
    Update Time : Thu Nov 21 15:11:27 2019
       Checksum : fc013950 - correct
         Events : 36
         Layout : left-symmetric
     Chunk Size : 64K
    Array Slot : 2 (empty, empty, 2, 3, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed)
   Array State : __Uu 380 failed
/dev/sdd2:
          Magic : a92b4efc
        Version : 1.0
    Feature Map : 0x1
     Array UUID : 85b920ec:ad30b4b9:e6fea107:6a14bcf6
           Name : 1
  Creation Time : Thu Feb  2 03:28:56 2017
     Raid Level : raid5
   Raid Devices : 4
 Avail Dev Size : 15619661552 (7448.04 GiB 7997.27 GB)
     Array Size : 46858984320 (22344.11 GiB 23991.80 GB)
  Used Dev Size : 15619661440 (7448.04 GiB 7997.27 GB)
   Super Offset : 15619661808 sectors
          State : clean
    Device UUID : 321fb3b3:93f4b66d:3e0d6f9d:a980741a
Internal Bitmap : 2 sectors from superblock
    Update Time : Thu Nov 21 15:11:27 2019
       Checksum : c55e2a7c - correct
         Events : 36
         Layout : left-symmetric
     Chunk Size : 64K
    Array Slot : 3 (empty, empty, 2, 3, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed, failed, failed, failed, failed, failed, failed, failed,
failed)
   Array State : __uU 380 failed


On Tue, Dec 17, 2019 at 1:25 PM Andreas Klauer
<Andreas.Klauer@metamorpher.de> wrote:
>
> On Tue, Dec 17, 2019 at 11:54:43AM -0500, Patrick Pearcy wrote:
> > MDADM Examine:
> > /dev/sda1:
> >           Magic : a92b4efc
> >         Version : 00.90.00
> >            UUID : 3593a169:b2495fbf:90fa7060:4cac0d65
> >   Creation Time : Tue Dec 17 10:56:15 2019
>
> This was re-created...
>
> >      Raid Level : raid1
>
> ...with Level 1 (Mirror)...
>
> >   Used Dev Size : 2097088 (2048.28 MiB 2147.42 MB)
> >      Array Size : 2097088 (2048.28 MiB 2147.42 MB)
> >    Raid Devices : 4
>
> ...across 4 devices? With that all data would be gone,
> cause it would have replicated anything on disk #1 to
> the other disks.
>
> Oh, it's just 2GiB. A firmware/boot partition, maybe?
>
> Do you have examine for the data partitions?
>
> Regards
> Andreas Klauer
