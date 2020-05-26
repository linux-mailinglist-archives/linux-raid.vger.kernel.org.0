Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE4199B93
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgCaQao (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Mar 2020 12:30:44 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:42344 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgCaQao (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 31 Mar 2020 12:30:44 -0400
Received: by mail-lf1-f42.google.com with SMTP id s13so6677498lfb.9
        for <linux-raid@vger.kernel.org>; Tue, 31 Mar 2020 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xy3LQqtNfkaEV/JtxPeKR7J5m1efgz5AAtW+DjxUceE=;
        b=R6N3xRaB5IdzjLfYP4w9Zjz8IrFHzpZilDHkCUt19TaRkBk/5FkyDX9G1Gbc5PezCW
         7Jszkx2HiMer4cCUIKST5D7rbzKg5z+nTctePqCrh7/CaX43M90/oTdSAVJM8ShW2502
         tFy4Zuu4q7o2azCrh95qYl76m3yYkIF28eLCLGNzmK6yj4DDU7h4REjpihWejBHb+1Uh
         o1DVD05A7/StSC5e29JB0HbcBRpnojFjTq2MxD1H7thedQ7MZxbMj68pba1mWv2lI1H2
         XYhyvCLxSk0XQyrfzCK5iS3ePwoa/KZ1UM+CoSH+uB2r1rnvmgLV91tH0sLUQm8HNiLy
         p8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xy3LQqtNfkaEV/JtxPeKR7J5m1efgz5AAtW+DjxUceE=;
        b=Bue0sONvNROmZSZZ3WfRlhakr+amu3R7qF6WioWjJFF99ChOqezhlIBTn7MsHqDvWB
         87pxI43wRACkHtxOnQbI/DQooM9kADhi9mB+33m3U+YhwOTV56VHbJO0120CQDVmGx41
         V1Yt5jEYZSGF2fGz/SVMP7f7FI7aPH/OhLOvAtZVuV8280QeXvpkLI+sxNB1YChv8vmc
         5cuSZnLhaKV8vG4SqEcrogTWPfU+X/TB1SGKk0ujAHH1WqXABS/DfIivGyE4DUzPrd4E
         RyB5SJY1W2m+Cg5J7CKGV5TLENR3APo9mjz/NvxHQgX2Rs7JpmQ7O78kksApk9PwcU6M
         1yRA==
X-Gm-Message-State: AGi0PuZwZPx15KN0TKbswTUdfH+swDET8RO7b8eLOGIrkUVgqczkFOmE
        bIKeoF/z52srUHZuPCCTct6j9rBFOZ3yS0cq4XGyHuB3
X-Google-Smtp-Source: APiQypIXKZ+n78uyjajUuly1uRqhOVyICRR19Be4ED69MOVMwf1C7zIwRy+qqHUvBDYQT1mNvgAr5hHeIyX8/fmtxnI=
X-Received: by 2002:a05:6512:3eb:: with SMTP id n11mr11691917lfq.32.1585672241281;
 Tue, 31 Mar 2020 09:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
 <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk> <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
 <CAAMCDee6TcJ_wR6rkQw5V02KyqPQ+xDf+bK+pQPbbfaptO_Tvg@mail.gmail.com>
 <1f393884-dc48-c03e-f734-f9880d9eed96@shenkin.org> <CAAMCDedj7TQAAGzSfQgAftKSmrjNmzHgQUs-X2mQZyFPG62_-A@mail.gmail.com>
 <c8185f80-837e-9654-ee19-611a030a0d54@shenkin.org> <CAAMCDefr2FakGTz5ok-qvTZiDNTj87vQSWP9ynM_bxtnB=-fkw@mail.gmail.com>
 <fa7e9b6d-28f3-8c9f-0901-eeac761e382f@shenkin.org> <CAAMCDefXygV4CZdxadfRFAV+HeEqnY8nWG1hpsVi4tBf1PYYww@mail.gmail.com>
 <740b37a3-83fa-a03f-c253-785bb286cefc@shenkin.org> <CAAMCDecv1-rY9Rt1puDn6WPYxGZ1=Qzje1ju=7aEOonBzkekVw@mail.gmail.com>
 <98b9aff4-978c-5d8d-1325-bda26bf7997f@shenkin.org> <0354b224-b762-915e-5f89-61c485fa0ec4@shenkin.org>
 <CAAMCDefL4GWY0+eCGk=Q3qjgVPHc8am4hy+8VWb8XL_MUM00dA@mail.gmail.com> <2e8dc7c0-434b-e759-c7e8-36791cd297d6@shenkin.org>
In-Reply-To: <2e8dc7c0-434b-e759-c7e8-36791cd297d6@shenkin.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Tue, 31 Mar 2020 11:30:29 -0500
Message-ID: <CAAMCDec5rMrkFL6fL9s8ANZ937xfXsqoodLDtppn=UFdoL49QQ@mail.gmail.com>
Subject: Re: Raid-6 won't boot
To:     Alexander Shenkin <al@shenkin.org>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

If you did not use external files, you are better off, it only
requires the external files in a subset of cases.  I think there is a
way to start a reshape, someone should know how to do that now that we
can at least find your raid and see it with activation failing.  You
may want to start a new thread with how to resume a reshape after it
aborted (with a summary of the original and the error you are now
getting).   You may want to use the newest fedora livecd you can find
as the original issue may have been a bug in your old kernel.   If you
can get the reshape going I would let it finish on that livecd so that
the old system does not have to do a reshape with what may be a buggy
kernel.

I also have typically avoided the rescue cd's and stayed with full
livecd's because of the limited tool sets and functionality on the
dedicated rescue ones.  Usually I pick a random fedora liivecd to use
as a rescue disk and that in general has worked very well in a wide
variety of ancient OS'es (compared to the really new fedora livecd).

On Tue, Mar 31, 2020 at 11:20 AM Alexander Shenkin <al@shenkin.org> wrote:
>
> Yes, I had added a drive and it was busy copying data to the new drive
> when the reshape slowed down gradually, and eventually the system locked
> up.  I didn't change raid configurations or anything like that - just
> added a drive.  I didn't use any external files, so not sure if i'd be
> able to recover any... i suspect not...
>
> thanks,
> allie
>
> On 3/31/2020 5:16 PM, Roger Heflin wrote:
> > were you doing a reshape when it was rebooted?    And if so did you
> > have to use an external file when doing the reshape and were was that
> > file?   I think there is a command to restart a reshape using an
> > external file.
> >
> > On Tue, Mar 31, 2020 at 11:13 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>
> >> quick followup: trying a stop and assemble results in the message that
> >> it "Failed to restore critical section for reshape, sorry".
> >>
> >> On 3/31/2020 11:08 AM, Alexander Shenkin wrote:
> >>> Thanks Roger,
> >>>
> >>> It seems only the Raid1 module is loaded.  I didn't find a
> >>> straightforward way to get that module loaded... any suggestions?  Or,
> >>> will I have to find another livecd that contains raid456?
> >>>
> >>> Thanks,
> >>> Allie
> >>>
> >>> On 3/30/2020 9:45 PM, Roger Heflin wrote:
> >>>> They all seem to be there, all seem to report all 7 disks active, so
> >>>> it does not appear to be degraded. All event counters are the same.
> >>>> Something has to be causing them to not be scanned and assembled at
> >>>> all.
> >>>>
> >>>> Is the rescue disk a similar OS to what you have installed?  If it is
> >>>> you might try a random say fedora livecd and see if it acts any
> >>>> different.
> >>>>
> >>>> what does fdisk -l /dev/sda look like?
> >>>>
> >>>> Is the raid456 module loaded (lsmod | grep raid)?
> >>>>
> >>>> what does cat /proc/cmdline look like?
> >>>>
> >>>> you might also run this:
> >>>> file -s /dev/sd*3
> >>>> But I think it is going to show us the same thing as what the mdadm
> >>>> --examine is reporting.
> >>>>
> >>>> On Mon, Mar 30, 2020 at 3:05 PM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>
> >>>>> See attached.  I should mention that the last drive i added is on a new
> >>>>> controller that is separate from the other drives, but seemed to work
> >>>>> fine for a bit, so kinda doubt that's the issue...
> >>>>>
> >>>>> thanks,
> >>>>>
> >>>>> allie
> >>>>>
> >>>>> On 3/30/2020 6:21 PM, Roger Heflin wrote:
> >>>>>> do this against each partition that had it:
> >>>>>>
> >>>>>>  mdadm --examine /dev/sd***
> >>>>>>
> >>>>>> It seems like it is not seeing it as a md-raid.
> >>>>>>
> >>>>>> On Mon, Mar 30, 2020 at 11:13 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>>> Thanks Roger,
> >>>>>>>
> >>>>>>> The only line that isn't commented out in /etc/mdadm.conf is "DEVICE
> >>>>>>> partitions"...
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>>
> >>>>>>> Allie
> >>>>>>>
> >>>>>>> On 3/30/2020 4:53 PM, Roger Heflin wrote:
> >>>>>>>> That seems really odd.  Is the raid456 module loaded?
> >>>>>>>>
> >>>>>>>> On mine I see messages like this for each disk it scanned and
> >>>>>>>> considered as maybe possibly being an array member.
> >>>>>>>>  kernel: [   83.468700] md/raid:md13: device sdi3 operational as raid disk 5
> >>>>>>>> and messages like this:
> >>>>>>>>  md/raid:md14: not clean -- starting background reconstruction
> >>>>>>>>
> >>>>>>>> You might look at /etc/mdadm.conf on the rescue cd and see if it has a
> >>>>>>>> DEVICE line that limits what is being scanned.
> >>>>>>>>
> >>>>>>>> On Mon, Mar 30, 2020 at 10:13 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>>>>> Thanks Roger,
> >>>>>>>>>
> >>>>>>>>> that grep just returns the detection of the raid1 (md127).  See dmesg
> >>>>>>>>> and mdadm --detail results attached.
> >>>>>>>>>
> >>>>>>>>> Many thanks,
> >>>>>>>>> allie
> >>>>>>>>>
> >>>>>>>>> On 3/28/2020 1:36 PM, Roger Heflin wrote:
> >>>>>>>>>> Try this grep:
> >>>>>>>>>> dmesg | grep "md/raid", if that returns nothing if you can just send
> >>>>>>>>>> the entire dmesg.
> >>>>>>>>>>
> >>>>>>>>>> On Sat, Mar 28, 2020 at 2:47 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>>>>>>> Thanks Roger.  dmesg has nothing in it referring to md126 or md127....
> >>>>>>>>>>> any other thoughts on how to investigate?
> >>>>>>>>>>>
> >>>>>>>>>>> thanks,
> >>>>>>>>>>> allie
> >>>>>>>>>>>
> >>>>>>>>>>> On 3/27/2020 3:55 PM, Roger Heflin wrote:
> >>>>>>>>>>>> A non-assembled array always reports raid1.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I would run "dmesg | grep md126" to start with and see what it reports it saw.
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Fri, Mar 27, 2020 at 10:29 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>>>>>>>>> Thanks Wol,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
> >>>>>>>>>>>>> reported.  The first (md126) in reported as inactive with all 7 disks
> >>>>>>>>>>>>> listed as spares.  The second (md127) is reported as active
> >>>>>>>>>>>>> auto-read-only with all 7 disks operational.  Also, the only
> >>>>>>>>>>>>> "personality" reported is Raid1.  I could go ahead with your suggestion
> >>>>>>>>>>>>> of mdadm --stop array and then mdadm --assemble, but I thought the
> >>>>>>>>>>>>> reporting of just the Raid1 personality was a bit strange, so wanted to
> >>>>>>>>>>>>> check in before doing that...
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>> Allie
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On 3/26/2020 10:00 PM, antlists wrote:
> >>>>>>>>>>>>>> On 26/03/2020 17:07, Alexander Shenkin wrote:
> >>>>>>>>>>>>>>> I surely need to boot with a rescue disk of some sort, but from there,
> >>>>>>>>>>>>>>> I'm not sure exactly when I should do.  Any suggestions are very welcome!
> >>>>>>>>>>>>>> Okay. Find a liveCD that supports raid (hopefully something like
> >>>>>>>>>>>>>> SystemRescueCD). Make sure it has a very recent kernel and the latest
> >>>>>>>>>>>>>> mdadm.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> All being well, the resync will restart, and when it's finished your
> >>>>>>>>>>>>>> system will be fine. If it doesn't restart on its own, do an "mdadm
> >>>>>>>>>>>>>> --stop array", followed by an "mdadm --assemble"
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> If that doesn't work, then
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Cheers,
> >>>>>>>>>>>>>> Wol
