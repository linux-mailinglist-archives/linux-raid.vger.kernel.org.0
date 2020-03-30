Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7751985C0
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 22:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgC3UpX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 16:45:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39893 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgC3UpX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Mar 2020 16:45:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id h6so9643462lfp.6
        for <linux-raid@vger.kernel.org>; Mon, 30 Mar 2020 13:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7EVzgTJU60406LS5XjDnfe0d44yTDm7pcaeWOthoDw=;
        b=pJWkOo/Equ8gUgX2k7bXmKsicigp0dCeo6BBe3qYi0bWxW9trgs7jmZMe34lOunmCY
         GFydVYqFsWvbDVVjZq8+YZ2JAnzfKrcZDtf6gP0ONdGayjxD9hIfvhRq1blY4v9+LGKc
         pICz5NPKmMnA3FarDZrHRDC/8fFoNogHVCj7EPHnZHkWzA7m8Fk4MF7CfxyjuAkLdcqm
         rlQm42UkF+936r4wF9OHRq3iX6z13aA4c3PMLk0JdVKZZ+Ijsjp4BzmtxKqJjpjvqg65
         j3OhojCFdMmUBp43fqlgem438CwVs2O0KLywt7EmHy0gKi3H9fQhqNA9Qphi8ldMMBNM
         uZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7EVzgTJU60406LS5XjDnfe0d44yTDm7pcaeWOthoDw=;
        b=eBO5ciMA4LJSpyCkaZl5uZrhgo/OgTcavni8X64YaQ/NQo7dnTDrfGXnC+pV/Bl+DP
         bObePH7sJSe2ny852oqDZEmDWeSykxCmw0rNyMcx8xPgeQ3o8MdUhmWjAlzwZS22jXcS
         Rw1iac42Pki4U2E5dVsDpeMdaDfEa/Aq39DyGFhY1D4OnxolSxuz1ipnOPItk8JycfcM
         s5TJhlcSGGIniCb2Rzq3/4t4mArVCwaSs4BVU79IYab9HeaNIzd1YjPh2E4WnB+Hz+0W
         mjx4K/jwhJsvdEroG1lRkSRgHMFaW8HpOVXUrmSCuMFt7GsbqQQKCvjx234PCNeKXxa4
         IoNQ==
X-Gm-Message-State: AGi0PuZkltAgWDAma49U3E2L+PXPfjh3nnMp6pixscdenrO5vOOdESS1
        XIrAECptTpEf1xG6tyS0bOrlots335QcXK203IU=
X-Google-Smtp-Source: APiQypK2XBtEPNKbdMWMfdY0XGKhzw4rVfLFl0oYuaa4qK4I+qSFGLoFiOlPdaAUqFNLC9G8dah2uaZnlgtPnmjDD/E=
X-Received: by 2002:a19:2391:: with SMTP id j139mr8936360lfj.147.1585601120676;
 Mon, 30 Mar 2020 13:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
 <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk> <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
 <CAAMCDee6TcJ_wR6rkQw5V02KyqPQ+xDf+bK+pQPbbfaptO_Tvg@mail.gmail.com>
 <1f393884-dc48-c03e-f734-f9880d9eed96@shenkin.org> <CAAMCDedj7TQAAGzSfQgAftKSmrjNmzHgQUs-X2mQZyFPG62_-A@mail.gmail.com>
 <c8185f80-837e-9654-ee19-611a030a0d54@shenkin.org> <CAAMCDefr2FakGTz5ok-qvTZiDNTj87vQSWP9ynM_bxtnB=-fkw@mail.gmail.com>
 <fa7e9b6d-28f3-8c9f-0901-eeac761e382f@shenkin.org> <CAAMCDefXygV4CZdxadfRFAV+HeEqnY8nWG1hpsVi4tBf1PYYww@mail.gmail.com>
 <740b37a3-83fa-a03f-c253-785bb286cefc@shenkin.org>
In-Reply-To: <740b37a3-83fa-a03f-c253-785bb286cefc@shenkin.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Mon, 30 Mar 2020 15:45:09 -0500
Message-ID: <CAAMCDecv1-rY9Rt1puDn6WPYxGZ1=Qzje1ju=7aEOonBzkekVw@mail.gmail.com>
Subject: Re: Raid-6 won't boot
To:     Alexander Shenkin <al@shenkin.org>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

They all seem to be there, all seem to report all 7 disks active, so
it does not appear to be degraded. All event counters are the same.
Something has to be causing them to not be scanned and assembled at
all.

Is the rescue disk a similar OS to what you have installed?  If it is
you might try a random say fedora livecd and see if it acts any
different.

what does fdisk -l /dev/sda look like?

Is the raid456 module loaded (lsmod | grep raid)?

what does cat /proc/cmdline look like?

you might also run this:
file -s /dev/sd*3
But I think it is going to show us the same thing as what the mdadm
--examine is reporting.

On Mon, Mar 30, 2020 at 3:05 PM Alexander Shenkin <al@shenkin.org> wrote:
>
> See attached.  I should mention that the last drive i added is on a new
> controller that is separate from the other drives, but seemed to work
> fine for a bit, so kinda doubt that's the issue...
>
> thanks,
>
> allie
>
> On 3/30/2020 6:21 PM, Roger Heflin wrote:
> > do this against each partition that had it:
> >
> >  mdadm --examine /dev/sd***
> >
> > It seems like it is not seeing it as a md-raid.
> >
> > On Mon, Mar 30, 2020 at 11:13 AM Alexander Shenkin <al@shenkin.org> wrote:
> >> Thanks Roger,
> >>
> >> The only line that isn't commented out in /etc/mdadm.conf is "DEVICE
> >> partitions"...
> >>
> >> Thanks,
> >>
> >> Allie
> >>
> >> On 3/30/2020 4:53 PM, Roger Heflin wrote:
> >>> That seems really odd.  Is the raid456 module loaded?
> >>>
> >>> On mine I see messages like this for each disk it scanned and
> >>> considered as maybe possibly being an array member.
> >>>  kernel: [   83.468700] md/raid:md13: device sdi3 operational as raid disk 5
> >>> and messages like this:
> >>>  md/raid:md14: not clean -- starting background reconstruction
> >>>
> >>> You might look at /etc/mdadm.conf on the rescue cd and see if it has a
> >>> DEVICE line that limits what is being scanned.
> >>>
> >>> On Mon, Mar 30, 2020 at 10:13 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>> Thanks Roger,
> >>>>
> >>>> that grep just returns the detection of the raid1 (md127).  See dmesg
> >>>> and mdadm --detail results attached.
> >>>>
> >>>> Many thanks,
> >>>> allie
> >>>>
> >>>> On 3/28/2020 1:36 PM, Roger Heflin wrote:
> >>>>> Try this grep:
> >>>>> dmesg | grep "md/raid", if that returns nothing if you can just send
> >>>>> the entire dmesg.
> >>>>>
> >>>>> On Sat, Mar 28, 2020 at 2:47 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>> Thanks Roger.  dmesg has nothing in it referring to md126 or md127....
> >>>>>> any other thoughts on how to investigate?
> >>>>>>
> >>>>>> thanks,
> >>>>>> allie
> >>>>>>
> >>>>>> On 3/27/2020 3:55 PM, Roger Heflin wrote:
> >>>>>>> A non-assembled array always reports raid1.
> >>>>>>>
> >>>>>>> I would run "dmesg | grep md126" to start with and see what it reports it saw.
> >>>>>>>
> >>>>>>> On Fri, Mar 27, 2020 at 10:29 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>>>> Thanks Wol,
> >>>>>>>>
> >>>>>>>> Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
> >>>>>>>> reported.  The first (md126) in reported as inactive with all 7 disks
> >>>>>>>> listed as spares.  The second (md127) is reported as active
> >>>>>>>> auto-read-only with all 7 disks operational.  Also, the only
> >>>>>>>> "personality" reported is Raid1.  I could go ahead with your suggestion
> >>>>>>>> of mdadm --stop array and then mdadm --assemble, but I thought the
> >>>>>>>> reporting of just the Raid1 personality was a bit strange, so wanted to
> >>>>>>>> check in before doing that...
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Allie
> >>>>>>>>
> >>>>>>>> On 3/26/2020 10:00 PM, antlists wrote:
> >>>>>>>>> On 26/03/2020 17:07, Alexander Shenkin wrote:
> >>>>>>>>>> I surely need to boot with a rescue disk of some sort, but from there,
> >>>>>>>>>> I'm not sure exactly when I should do.  Any suggestions are very welcome!
> >>>>>>>>> Okay. Find a liveCD that supports raid (hopefully something like
> >>>>>>>>> SystemRescueCD). Make sure it has a very recent kernel and the latest
> >>>>>>>>> mdadm.
> >>>>>>>>>
> >>>>>>>>> All being well, the resync will restart, and when it's finished your
> >>>>>>>>> system will be fine. If it doesn't restart on its own, do an "mdadm
> >>>>>>>>> --stop array", followed by an "mdadm --assemble"
> >>>>>>>>>
> >>>>>>>>> If that doesn't work, then
> >>>>>>>>>
> >>>>>>>>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
> >>>>>>>>>
> >>>>>>>>> Cheers,
> >>>>>>>>> Wol
