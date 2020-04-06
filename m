Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7419F9F4
	for <lists+linux-raid@lfdr.de>; Mon,  6 Apr 2020 18:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgDFQMc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Apr 2020 12:12:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35831 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgDFQMb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Apr 2020 12:12:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id r17so8758166lff.2
        for <linux-raid@vger.kernel.org>; Mon, 06 Apr 2020 09:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBLaGolg45ka9SyZed28sH+7OIhUcKM5eYLd0Umff6c=;
        b=HGoVlRcxRoU2jtkECeHt58sYbz5SPsed/ACbRDN7rN2sCFu6wJCeQeAhTQYlrnOAqB
         UehMdYYC9cNuVFSNJa3XJOma2VrWDwo0Hu33a2glITtEfZYPd7a1oQye+jutp+qHDAay
         jtbzqF72FMyH2eTwd8Fun15vpZKWqglzLrLz0Xlq+M/fxKZlUJpwKVfbJLpbt+uQUkl5
         B5FZ41siIA1Ap2d3BmUAps5wQLl3S/UA6XKKi3V9QX/sGL5Yz6lCGGTWIaf0+HKMR4nv
         cqkYiz/Fz+6cTbiNIU2wXmmC+4pV+L3jaysRM9WUUyQNW/BG9Yi+zryR2veGDxMKQVsH
         BYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBLaGolg45ka9SyZed28sH+7OIhUcKM5eYLd0Umff6c=;
        b=G0u0YLrmHC/s7KLTBYpbyhzU9E130zt9iNppuNFJ//tB58TaCEDWADGI+GgDfuOp+j
         XrEPCvDzv5FTvQbjXqfNwjsyIQ11wRQEuMOtq4Qm/7YETwxrWtPS39dJGkGhALJIEEjj
         q5Ib5ZTMcIG0hTfNpR1Au0IEj0vPw/BDokfPdX124a6olmSrcTO7QWloaENSHnMaAhji
         DAuT8PmR7qilcTlDj7TVzby4P8Foy+C6Ij/yJQ4OJSd4QA1J9Yj8oK53pU5UdaAuPFse
         28ACIcdL8InkUvv70ti0JI111Ccjg8QIz4hL/3WogWbjevIM3esDnquzug6QpJ5UMIKK
         eIHg==
X-Gm-Message-State: AGi0PuZdoQtePwINqoMTznug3IIHPF5coNGi0XQQYaT/87/FxL8ZNJAr
        mJSXDvoa9amrAJTYcZjmMMOriB7V9rxG5Pg9tWv4SGP1
X-Google-Smtp-Source: APiQypKrMY82dJrVAzaEIMAdSa4e7wy0ngCZFo803H3WnVtjhn9jRGItI6qpk5kYzddCIUNe17hn6gxDD2oCzizsqvo=
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr9299742lfo.152.1586189548274;
 Mon, 06 Apr 2020 09:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <24a0ef04-46a9-13ee-b8cb-d1a0a5b939fb@shenkin.org>
 <6b9b6d37-6325-6515-f693-0ff3b641a67a@shenkin.org> <3135fb29-cfaa-d8ac-264d-fd3110217370@shenkin.org>
In-Reply-To: <3135fb29-cfaa-d8ac-264d-fd3110217370@shenkin.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Mon, 6 Apr 2020 11:12:16 -0500
Message-ID: <CAAMCDecyr4R_z3-E8HYwYM4CyQtAY_nBmXdvvMkTgZCcCp7MjQ@mail.gmail.com>
Subject: Re: Raid-6 cannot reshape
To:     Alexander Shenkin <al@shenkin.org>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When I looked at your detailed files you sent a few days ago, all of
the reshapes (on all disks) indicated that they were at position 0, so
it kind of appears that the reshape never actually started at all and
hung immediately which is probably why it cannot find the critical
section, it hung prior to that getting done.   Not entirely sure how
to undo a reshape that failed like this.

On Mon, Apr 6, 2020 at 10:29 AM Alexander Shenkin <al@shenkin.org> wrote:
>
>
>
> On 4/4/2020 9:19 AM, Alexander Shenkin wrote:
> > On 4/1/2020 11:16 AM, Alexander Shenkin wrote:
> >> Hi all,
> >>
> >> I had a problem that caused my Ubuntu Server 14 to go down, and it now
> >> will not boot.  I added a drive to my raid1 (/dev/md0 -> /boot) + raid6
> >> (/dev/md2 -> /) setup.  I was previously running with /dev/md0 (raid1)
> >> assembled from /dev/sd[a-f]1, and /dev/md2 (raid6) assembled
> >> /dev/sd[a-f]3.  Both partitions from the new drive were successfully
> >> added to the two md arrays, and the raid1 (the smaller of the two)
> >> resync'd successfully it seemed (I think that resync is the correct word
> >> to use, meaning that mdadm is spreading out the data amongst the drives
> >> once an array has been grown).  When resyncing the larger raid6,
> >> however, the sync speed was quite slow (kb's/sec), and got slower and
> >> slower (7kb/sec... 5kb/sec... 3kb/sec... 1kb/sec...) until the system
> >> entirely halted and I eventually turned the power off.  It now will not
> >> boot.
> >>
> >> Thanks to Roger Heflin's help, I've booted into a livecd environment
> >> (ubuntu server 18) with all the necessary raid personalities available.
> >>
> >> When trying to --assemble md127 (raid6), i get the following error:
> >> "Failure to restore critical section for reshape, sorry.  Perhaps you
> >> needed to specify the --backup-file".  Needless to say, I didn't save a
> >> backup file when adding the drive.
> >>
> >> I have attached some diagnostic output here.  It seems that my raid6
> >> array is not being recognized as such.  I'm not sure what the next steps
> >> are - do I need to figure out how to get the resync up and running
> >> again?  Any help would be greatly appreciated.
> >>
> >> Many thanks,
> >>
> >> Allie
> >>
> >
> > Hello again,
> >
> > Reading through https://raid.wiki.kernel.org/index.php/Assemble_Run and
> > https://raid.wiki.kernel.org/index.php/RAID_Recovery, the advice seems
> > to be to force assemble the array given that my event counts are all the
> > same.  However, I don't want to do that until some experts have chimed
> > in.  I've seen some other threads about using overlays to avoid data
> > loss... not sure if that is still a recommended method.
> >
> > I'm including the dmesg and mdadm --examine output here...  any advice
> > much appreciated!
> >
> > Thanks,
> > Allie
> >
> > (note below - arrays are on /dev/md[a-g])
> >
> > root@ubuntu-server:/home/ubuntu-server# mdadm -A --scan --verbose
> > mdadm: looking for devices for further assembly
> > mdadm: Cannot assemble mbr metadata on /dev/sdh1
> > mdadm: Cannot assemble mbr metadata on /dev/sdh
> > mdadm: no recogniseable superblock on /dev/md/bobbiflekman:0
> > mdadm: no recogniseable superblock on /dev/sdf4
> > mdadm: /dev/sdf3 is busy - skipping
> > mdadm: no recogniseable superblock on /dev/sdf2
> > mdadm: /dev/sdf1 is busy - skipping
> > mdadm: Cannot assemble mbr metadata on /dev/sdf
> > mdadm: no recogniseable superblock on /dev/sdg4
> > mdadm: /dev/sdg3 is busy - skipping
> > mdadm: no recogniseable superblock on /dev/sdg2
> > mdadm: /dev/sdg1 is busy - skipping
> > mdadm: Cannot assemble mbr metadata on /dev/sdg
> > mdadm: no recogniseable superblock on /dev/sde4
> > mdadm: /dev/sde3 is busy - skipping
> > mdadm: no recogniseable superblock on /dev/sde2
> > mdadm: /dev/sde1 is busy - skipping
> > mdadm: Cannot assemble mbr metadata on /dev/sde
> > mdadm: cannot open device /dev/sr1: No medium found
> > mdadm: cannot open device /dev/sr0: No medium found
> > mdadm: no recogniseable superblock on /dev/sdd4
> > mdadm: /dev/sdd3 is busy - skipping
> > mdadm: no recogniseable superblock on /dev/sdd2
> > mdadm: /dev/sdd1 is busy - skipping
> > mdadm: Cannot assemble mbr metadata on /dev/sdd
> > mdadm: no recogniseable superblock on /dev/sdc4
> > mdadm: /dev/sdc3 is busy - skipping
> > mdadm: no recogniseable superblock on /dev/sdc2
> > mdadm: /dev/sdc1 is busy - skipping
> > mdadm: Cannot assemble mbr metadata on /dev/sdc
> > mdadm: no recogniseable superblock on /dev/sdb4
> > mdadm: /dev/sdb3 is busy - skipping
> > mdadm: no recogniseable superblock on /dev/sdb2
> > mdadm: /dev/sdb1 is busy - skipping
> > mdadm: Cannot assemble mbr metadata on /dev/sdb
> > mdadm: no recogniseable superblock on /dev/sda4
> > mdadm: /dev/sda3 is busy - skipping
> > mdadm: no recogniseable superblock on /dev/sda2
> > mdadm: /dev/sda1 is busy - skipping
> > mdadm: Cannot assemble mbr metadata on /dev/sda
> > mdadm: no recogniseable superblock on /dev/loop7
> > mdadm: no recogniseable superblock on /dev/loop6
> > mdadm: no recogniseable superblock on /dev/loop5
> > mdadm: no recogniseable superblock on /dev/loop4
> > mdadm: no recogniseable superblock on /dev/loop3
> > mdadm: no recogniseable superblock on /dev/loop2
> > mdadm: no recogniseable superblock on /dev/loop1
> > mdadm: no recogniseable superblock on /dev/loop0
> > mdadm: No arrays found in config file or automatically
> >
>
> Hi again all,
>
> Apologies for all the self-followed-up emails.  I realized my previous
> --examine was done without stopping the array in question.  When stopped
> and reexamined, the critical bit seems to be this:
>
> mdadm: /dev/sdf3 is identified as a member of /dev/md/ubuntu:2, slot 4.
> mdadm: /dev/sdg3 is identified as a member of /dev/md/ubuntu:2, slot 6.
> mdadm: /dev/sde3 is identified as a member of /dev/md/ubuntu:2, slot 5.
> mdadm: /dev/sdd3 is identified as a member of /dev/md/ubuntu:2, slot 3.
> mdadm: /dev/sdc3 is identified as a member of /dev/md/ubuntu:2, slot 2.
> mdadm: /dev/sdb3 is identified as a member of /dev/md/ubuntu:2, slot 1.
> mdadm: /dev/sda3 is identified as a member of /dev/md/ubuntu:2, slot 0.
> mdadm: /dev/md/ubuntu:2 has an active reshape - checking if critical
> section needs to be restored
> mdadm: No backup metadata on device-6
> mdadm: Failed to find backup of critical section
> mdadm: Failed to restore critical section for reshape, sorry.
>        Possibly you needed to specify the --backup-file
>
> That is, it thinks there is an active reshape.
>
> Thanks,
> Allie
>
>
> root@ubuntu-server:/home/ubuntu-server# mdadm -A --scan --verbose
> mdadm: looking for devices for further assembly
> mdadm: Cannot assemble mbr metadata on /dev/sdh1
> mdadm: Cannot assemble mbr metadata on /dev/sdh
> mdadm: no recogniseable superblock on /dev/md/bobbiflekman:0
> mdadm: no recogniseable superblock on /dev/sdf4
> mdadm: No super block found on /dev/sdf2 (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sdf2
> mdadm: /dev/sdf1 is busy - skipping
> mdadm: No super block found on /dev/sdf (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sdf
> mdadm: No super block found on /dev/sdg4 (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sdg4
> mdadm: No super block found on /dev/sdg2 (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sdg2
> mdadm: /dev/sdg1 is busy - skipping
> mdadm: No super block found on /dev/sdg (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sdg
> mdadm: No super block found on /dev/sde4 (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sde4
> mdadm: No super block found on /dev/sde2 (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sde2
> mdadm: /dev/sde1 is busy - skipping
> mdadm: No super block found on /dev/sde (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sde
> mdadm: cannot open device /dev/sr1: No medium found
> mdadm: cannot open device /dev/sr0: No medium found
> mdadm: No super block found on /dev/sdd4 (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sdd4
> mdadm: No super block found on /dev/sdd2 (Expected magic a92b4efc, got
> 9c6196f1)
> mdadm: no RAID superblock on /dev/sdd2
> mdadm: /dev/sdd1 is busy - skipping
> mdadm: No super block found on /dev/sdd (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sdd
> mdadm: No super block found on /dev/sdc4 (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sdc4
> mdadm: No super block found on /dev/sdc2 (Expected magic a92b4efc, got
> 9c6196f1)
> mdadm: no RAID superblock on /dev/sdc2
> mdadm: /dev/sdc1 is busy - skipping
> mdadm: No super block found on /dev/sdc (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sdc
> mdadm: No super block found on /dev/sdb4 (Expected magic a92b4efc, got
> 53425553)
> mdadm: no RAID superblock on /dev/sdb4
> mdadm: No super block found on /dev/sdb2 (Expected magic a92b4efc, got
> 9c6196f1)
> mdadm: no RAID superblock on /dev/sdb2
> mdadm: /dev/sdb1 is busy - skipping
> mdadm: No super block found on /dev/sdb (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sdb
> mdadm: No super block found on /dev/sda4 (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sda4
> mdadm: No super block found on /dev/sda2 (Expected magic a92b4efc, got
> 9c6196f1)
> mdadm: no RAID superblock on /dev/sda2
> mdadm: /dev/sda1 is busy - skipping
> mdadm: No super block found on /dev/sda (Expected magic a92b4efc, got
> 00000000)
> mdadm: no RAID superblock on /dev/sda
> mdadm: No super block found on /dev/loop7 (Expected magic a92b4efc, got
> 72756769)
> mdadm: no RAID superblock on /dev/loop7
> mdadm: No super block found on /dev/loop6 (Expected magic a92b4efc, got
> 69622f21)
> mdadm: no RAID superblock on /dev/loop6
> mdadm: No super block found on /dev/loop5 (Expected magic a92b4efc, got
> 14ea0a05)
> mdadm: no RAID superblock on /dev/loop5
> mdadm: No super block found on /dev/loop4 (Expected magic a92b4efc, got
> 1824ef5d)
> mdadm: no RAID superblock on /dev/loop4
> mdadm: No super block found on /dev/loop3 (Expected magic a92b4efc, got
> 1e993ae9)
> mdadm: no RAID superblock on /dev/loop3
> mdadm: No super block found on /dev/loop2 (Expected magic a92b4efc, got
> cb4d8c8e)
> mdadm: no RAID superblock on /dev/loop2
> mdadm: No super block found on /dev/loop1 (Expected magic a92b4efc, got
> d2964063)
> mdadm: no RAID superblock on /dev/loop1
> mdadm: No super block found on /dev/loop0 (Expected magic a92b4efc, got
> e7e108a6)
> mdadm: no RAID superblock on /dev/loop0
> mdadm: /dev/sdf3 is identified as a member of /dev/md/ubuntu:2, slot 4.
> mdadm: /dev/sdg3 is identified as a member of /dev/md/ubuntu:2, slot 6.
> mdadm: /dev/sde3 is identified as a member of /dev/md/ubuntu:2, slot 5.
> mdadm: /dev/sdd3 is identified as a member of /dev/md/ubuntu:2, slot 3.
> mdadm: /dev/sdc3 is identified as a member of /dev/md/ubuntu:2, slot 2.
> mdadm: /dev/sdb3 is identified as a member of /dev/md/ubuntu:2, slot 1.
> mdadm: /dev/sda3 is identified as a member of /dev/md/ubuntu:2, slot 0.
> mdadm: /dev/md/ubuntu:2 has an active reshape - checking if critical
> section needs to be restored
> mdadm: No backup metadata on device-6
> mdadm: Failed to find backup of critical section
> mdadm: Failed to restore critical section for reshape, sorry.
>        Possibly you needed to specify the --backup-file
> mdadm: looking for devices for further assembly
> mdadm: /dev/sdf1 is busy - skipping
> mdadm: /dev/sdg1 is busy - skipping
> mdadm: /dev/sde1 is busy - skipping
> mdadm: /dev/sdd1 is busy - skipping
> mdadm: /dev/sdc1 is busy - skipping
> mdadm: /dev/sdb1 is busy - skipping
> mdadm: /dev/sda1 is busy - skipping
> mdadm: No arrays found in config file or automatically
