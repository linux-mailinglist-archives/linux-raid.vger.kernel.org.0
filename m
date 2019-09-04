Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C66A7953
	for <lists+linux-raid@lfdr.de>; Wed,  4 Sep 2019 05:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfIDDdB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 23:33:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38227 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfIDDdA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 23:33:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so20954442edo.5
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 20:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVLBAhcd/E5OX18sKHzo7GNTodkmqz0z5AYPl/dldQI=;
        b=kOHWACuiXPwAcAdhOXX4edx+Oi67wWNdS2iarUArOpxKCZBJ0QXLOR3lv0P0EiCta0
         e5hTfNARB8AdgDG5icoSsqcF1HI4uU6dTNK2LOs1H+tzbAt68mW5E2vHGUyzx5mkRxgg
         +9nuPyXHl2vmrw1XEMZtq+4Vsbar13/JEz6Nvcgox5JLEM8+X2m2NKG3w9ZbHwHUMwT+
         pqRa7ezw08tLa/f/agL/FKSc2KivcfT09O15/Msel/yVqma6Hyek/UJt4jlUHNytIQzp
         2KfhQ3oZ1r9hmlS5v/SWLpu0mBknP6Bm2+P1D30E5Uj1JoZSOEPCLGUp8Z4ylfp1jXA3
         FOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVLBAhcd/E5OX18sKHzo7GNTodkmqz0z5AYPl/dldQI=;
        b=DXmmVro5AOs81qakcSks537LmY9Awd6oFaHRZwbsTjlV1EAGQ1zjp1vsKrbYVxbBrr
         SvErzJGbIhoo5F8moIU4AsrN4DKYZcuhGYH6fdMA4cC0GL2CWgVtmz89UMf6m9uG3zVK
         qR+v+SbZJZE95/y0IoZK/lEEeA7M8dQM0j1D87iPcjKE/YjsGa+4FygKp71YPu8OIRrb
         10bE9p6ViMQ89Y3hheVGdux193cqTc56hxqMs9xGSLmKwDdthkK5PxClvVR4NR6jgtjs
         Qf1g9OAf+Vnf9ti71u8r6KvHY5eQO/OOUqUNFO5TwnC8nUuLXzXciPjZUoUSS8PuxYuN
         l04Q==
X-Gm-Message-State: APjAAAUNoFgmwmzIydz6Szkv7D3lq/YhLzfKk3Zm0qMtbqyus16VFHW0
        q/XRamRlaMMmQn8eBQOsnAW9XfTZPMh2mRK0AbQC0Iopm24=
X-Google-Smtp-Source: APXvYqw3sl+cdq02XnP1ClYRUtUNT4yeKVu6UjJLhf0dYErQ7MLvvE8AyQv1KEVpOAmp7lCd19D3nbGaM7vK9lcZFos=
X-Received: by 2002:a05:6402:347:: with SMTP id r7mr14743583edw.41.1567567979178;
 Tue, 03 Sep 2019 20:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
 <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
 <5D6CF46B.8090905@youngman.org.uk> <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com>
 <2ce6bd67-d373-e0fc-4dba-c6220aa4d8cb@turmel.org> <CA+ojRwmnpg6eLbzvXU51sLUmUVUdZnpbF71oafKtvdoApX3e1Q@mail.gmail.com>
 <87h85udyfs.fsf@notabene.neil.brown.name> <CA+ojRwnB8sm1WyFbwGpb8t7drPmTC9TqwzhwzUKtYy=D75c8YA@mail.gmail.com>
 <d9a08687-0225-407f-dff0-f7f440786654@turmel.org> <CA+ojRw=f6_7uOd_6uAt_kcGL3_5-SFdDWtCYBJ-K0rwUQdnmow@mail.gmail.com>
In-Reply-To: <CA+ojRw=f6_7uOd_6uAt_kcGL3_5-SFdDWtCYBJ-K0rwUQdnmow@mail.gmail.com>
From:   =?UTF-8?Q?Krzysztof_Jak=C3=B3bczyk?= <krzysiek.jakobczyk@gmail.com>
Date:   Wed, 4 Sep 2019 05:32:34 +0200
Message-ID: <CA+ojRwkfQnNo2J=swQUsGxGD_ikTSjs4=Fx-R9T2C4LqoP_NiA@mail.gmail.com>
Subject: Re: Fwd: mdadm RAID5 to RAID6 migration thrown exceptions, access to
 data lost
To:     Phil Turmel <philip@turmel.org>
Cc:     NeilBrown <neilb@suse.de>, Neil F Brown <nfbrown@suse.com>,
        linux-raid@vger.kernel.org, Wols Lists <antlists@youngman.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Good morning Phil,

Please find some updates below.

> I think the situation looks worse now. The reshape finished and resync
> has begun. During the resync I've found many errors concerning
> /dev/sdf which is the part of the md127. Example below:

The resync operation actually completed and the details of md127 looks
as follows:

[root@sysresccd ~]# mdadm --detail /dev/md127
/dev/md127:
        Version : 1.2
  Creation Time : Thu Dec 25 12:15:20 2014
     Raid Level : raid6
     Array Size : 7813771264 (7451.79 GiB 8001.30 GB)
  Used Dev Size : 3906885632 (3725.90 GiB 4000.65 GB)
   Raid Devices : 4
  Total Devices : 4
    Persistence : Superblock is persistent

  Intent Bitmap : Internal

    Update Time : Wed Sep  4 03:15:29 2019
          State : clean
 Active Devices : 4
Working Devices : 4
 Failed Devices : 0
  Spare Devices : 0

         Layout : left-symmetric
     Chunk Size : 512K

           Name : debnas:0
           UUID : a3d7766c:aeb658d3:8e2d29b7:4de30dab
         Events : 223869

    Number   Major   Minor   RaidDevice State
       5       8        1        0      active sync   /dev/sda1
       4       8       49        1      active sync   /dev/sdd1
       3       8       81        2      active sync   /dev/sdf1
       6       8       97        3      active sync   /dev/sdg1

`dmesg` didn't report any more read errors in /dev/sdf and the
`smartctl -a` for this drive looks unchanged in terms of
current_pending_sectors.

>
> The contents of `/proc/mdstat` are the following:
>

Right now it looks as follows:

[root@sysresccd ~]# cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4]
md127 : active raid6 sda1[5] sdg1[6] sdd1[4] sdf1[3]
      7813771264 blocks super 1.2 level 6, 512k chunk, algorithm 2 [4/4] [UUUU]
      bitmap: 0/30 pages [0KB], 65536KB chunk

unused devices: <none>

> Is the data in danger in this state?

The data seems to be intact. I've collected the log from `dmesg` to
review later what was the files at the corrected and uncorrected
sectors to see if they are still correct.

Also, answering the question from your previous mail:

> Uhm?  Why are you running perf during this reshape?

I did not run it on purpose. It has been executed by SystemRescueCD. I
don't know what it exactly is and what may be the consequences of it
running during the reshape. Quick Google search didn't result in much
more information than it's a module to control the performance.

Best regards,
Krzysztof Jakobczyk
