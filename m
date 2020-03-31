Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99163199B29
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgCaQQb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Mar 2020 12:16:31 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:34425 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgCaQQb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 31 Mar 2020 12:16:31 -0400
Received: by mail-lf1-f54.google.com with SMTP id e7so17826922lfq.1
        for <linux-raid@vger.kernel.org>; Tue, 31 Mar 2020 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYMeLAqy/yfwvkNvj9SBNUDFemqXQYqkVJZxtFI6Zq4=;
        b=vav7TJEjXZllX3Dn877WN6XxwnaR4EuRv8CcWMh6+9f9Aikje0YYydfytLhSouIDUO
         fN5Qr+4JCLNFc6b6o0mWfomnAu5PSzw5U5ZKsqSlm02f+7/H/EbfVaYsodcTnnDOfh5j
         2eHt7hdhCoUMZPYAwUCeVVqrVb5IML0ghBqu6dqhfcibaD5QaLqwIpUQiubJqHBncYec
         u38OypyfR+onblXyGVeMd6QAGfWa0m/HFxArd5HnmWZVuiumn3SGCiRmjn5MvAatakZF
         AnNClVUw/Y2zKtdYDSEMIoIoyVnelrJ3VILGQn8lFNN8uoTMW0P0DCgD3VtmNjrW4mN+
         35QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYMeLAqy/yfwvkNvj9SBNUDFemqXQYqkVJZxtFI6Zq4=;
        b=NK6OqxKsksU5Z7TDaEJ5eod9Wf2O8pah2IRKtG3R1NYOWQiVjIoi4Pj2nbe5m5d9kJ
         DOU4/vCHYdFQ5h0CuO6p/oPYn+Gm8WSFx4aMnGV8wt6SZTglcYqMjIELA2PztmgAcRWG
         r/pLPNJMs+EE0A2rf4cSCECBu2CJWNM1H09xQGALLQWOqgJg2tNV0XNNn6AKCtzP5vTh
         UcpqfiTM9tVGRiztsQPctdOMV6HjKxVz9eEa7W/3ioqkyoOt3dMyOQk2SVB76LWo+5dC
         oYXRQ+6Df/6XSELVXWRkAbx/OJrtcR6zMM68wdMnGupaGwlJwtk4DpKZPAIjo32iubLo
         Xk7g==
X-Gm-Message-State: AGi0PuZTsgP0kNND3p5v8BcM6oS5PM55HQSEj8oRV0KFAaxDhHefv6Av
        KAAQ2Tp7ObA+xe4kfGkFN1TH05Npni0Q+k706LKlD1cj
X-Google-Smtp-Source: APiQypKgfi3NkG7q2+8eZ8CLZNE4rnWpRZrSc28svBbVCSzypSLaQpxB+FT2QMUd+GtgYJgg09m1uF4w0M9DO1jwLbo=
X-Received: by 2002:a19:89d4:: with SMTP id l203mr11674235lfd.45.1585671387114;
 Tue, 31 Mar 2020 09:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
 <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk> <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
 <CAAMCDee6TcJ_wR6rkQw5V02KyqPQ+xDf+bK+pQPbbfaptO_Tvg@mail.gmail.com>
 <1f393884-dc48-c03e-f734-f9880d9eed96@shenkin.org> <CAAMCDedj7TQAAGzSfQgAftKSmrjNmzHgQUs-X2mQZyFPG62_-A@mail.gmail.com>
 <c8185f80-837e-9654-ee19-611a030a0d54@shenkin.org> <CAAMCDefr2FakGTz5ok-qvTZiDNTj87vQSWP9ynM_bxtnB=-fkw@mail.gmail.com>
 <fa7e9b6d-28f3-8c9f-0901-eeac761e382f@shenkin.org> <CAAMCDefXygV4CZdxadfRFAV+HeEqnY8nWG1hpsVi4tBf1PYYww@mail.gmail.com>
 <740b37a3-83fa-a03f-c253-785bb286cefc@shenkin.org> <CAAMCDecv1-rY9Rt1puDn6WPYxGZ1=Qzje1ju=7aEOonBzkekVw@mail.gmail.com>
 <98b9aff4-978c-5d8d-1325-bda26bf7997f@shenkin.org> <0354b224-b762-915e-5f89-61c485fa0ec4@shenkin.org>
In-Reply-To: <0354b224-b762-915e-5f89-61c485fa0ec4@shenkin.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Tue, 31 Mar 2020 11:16:15 -0500
Message-ID: <CAAMCDefL4GWY0+eCGk=Q3qjgVPHc8am4hy+8VWb8XL_MUM00dA@mail.gmail.com>
Subject: Re: Raid-6 won't boot
To:     Alexander Shenkin <al@shenkin.org>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

were you doing a reshape when it was rebooted?    And if so did you
have to use an external file when doing the reshape and were was that
file?   I think there is a command to restart a reshape using an
external file.

On Tue, Mar 31, 2020 at 11:13 AM Alexander Shenkin <al@shenkin.org> wrote:
>
> quick followup: trying a stop and assemble results in the message that
> it "Failed to restore critical section for reshape, sorry".
>
> On 3/31/2020 11:08 AM, Alexander Shenkin wrote:
> > Thanks Roger,
> >
> > It seems only the Raid1 module is loaded.  I didn't find a
> > straightforward way to get that module loaded... any suggestions?  Or,
> > will I have to find another livecd that contains raid456?
> >
> > Thanks,
> > Allie
> >
> > On 3/30/2020 9:45 PM, Roger Heflin wrote:
> >> They all seem to be there, all seem to report all 7 disks active, so
> >> it does not appear to be degraded. All event counters are the same.
> >> Something has to be causing them to not be scanned and assembled at
> >> all.
> >>
> >> Is the rescue disk a similar OS to what you have installed?  If it is
> >> you might try a random say fedora livecd and see if it acts any
> >> different.
> >>
> >> what does fdisk -l /dev/sda look like?
> >>
> >> Is the raid456 module loaded (lsmod | grep raid)?
> >>
> >> what does cat /proc/cmdline look like?
> >>
> >> you might also run this:
> >> file -s /dev/sd*3
> >> But I think it is going to show us the same thing as what the mdadm
> >> --examine is reporting.
> >>
> >> On Mon, Mar 30, 2020 at 3:05 PM Alexander Shenkin <al@shenkin.org> wrote:
> >>>
> >>> See attached.  I should mention that the last drive i added is on a new
> >>> controller that is separate from the other drives, but seemed to work
> >>> fine for a bit, so kinda doubt that's the issue...
> >>>
> >>> thanks,
> >>>
> >>> allie
> >>>
> >>> On 3/30/2020 6:21 PM, Roger Heflin wrote:
> >>>> do this against each partition that had it:
> >>>>
> >>>>  mdadm --examine /dev/sd***
> >>>>
> >>>> It seems like it is not seeing it as a md-raid.
> >>>>
> >>>> On Mon, Mar 30, 2020 at 11:13 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>> Thanks Roger,
> >>>>>
> >>>>> The only line that isn't commented out in /etc/mdadm.conf is "DEVICE
> >>>>> partitions"...
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> Allie
> >>>>>
> >>>>> On 3/30/2020 4:53 PM, Roger Heflin wrote:
> >>>>>> That seems really odd.  Is the raid456 module loaded?
> >>>>>>
> >>>>>> On mine I see messages like this for each disk it scanned and
> >>>>>> considered as maybe possibly being an array member.
> >>>>>>  kernel: [   83.468700] md/raid:md13: device sdi3 operational as raid disk 5
> >>>>>> and messages like this:
> >>>>>>  md/raid:md14: not clean -- starting background reconstruction
> >>>>>>
> >>>>>> You might look at /etc/mdadm.conf on the rescue cd and see if it has a
> >>>>>> DEVICE line that limits what is being scanned.
> >>>>>>
> >>>>>> On Mon, Mar 30, 2020 at 10:13 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>>> Thanks Roger,
> >>>>>>>
> >>>>>>> that grep just returns the detection of the raid1 (md127).  See dmesg
> >>>>>>> and mdadm --detail results attached.
> >>>>>>>
> >>>>>>> Many thanks,
> >>>>>>> allie
> >>>>>>>
> >>>>>>> On 3/28/2020 1:36 PM, Roger Heflin wrote:
> >>>>>>>> Try this grep:
> >>>>>>>> dmesg | grep "md/raid", if that returns nothing if you can just send
> >>>>>>>> the entire dmesg.
> >>>>>>>>
> >>>>>>>> On Sat, Mar 28, 2020 at 2:47 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>>>>> Thanks Roger.  dmesg has nothing in it referring to md126 or md127....
> >>>>>>>>> any other thoughts on how to investigate?
> >>>>>>>>>
> >>>>>>>>> thanks,
> >>>>>>>>> allie
> >>>>>>>>>
> >>>>>>>>> On 3/27/2020 3:55 PM, Roger Heflin wrote:
> >>>>>>>>>> A non-assembled array always reports raid1.
> >>>>>>>>>>
> >>>>>>>>>> I would run "dmesg | grep md126" to start with and see what it reports it saw.
> >>>>>>>>>>
> >>>>>>>>>> On Fri, Mar 27, 2020 at 10:29 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>>>>>>> Thanks Wol,
> >>>>>>>>>>>
> >>>>>>>>>>> Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
> >>>>>>>>>>> reported.  The first (md126) in reported as inactive with all 7 disks
> >>>>>>>>>>> listed as spares.  The second (md127) is reported as active
> >>>>>>>>>>> auto-read-only with all 7 disks operational.  Also, the only
> >>>>>>>>>>> "personality" reported is Raid1.  I could go ahead with your suggestion
> >>>>>>>>>>> of mdadm --stop array and then mdadm --assemble, but I thought the
> >>>>>>>>>>> reporting of just the Raid1 personality was a bit strange, so wanted to
> >>>>>>>>>>> check in before doing that...
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks,
> >>>>>>>>>>> Allie
> >>>>>>>>>>>
> >>>>>>>>>>> On 3/26/2020 10:00 PM, antlists wrote:
> >>>>>>>>>>>> On 26/03/2020 17:07, Alexander Shenkin wrote:
> >>>>>>>>>>>>> I surely need to boot with a rescue disk of some sort, but from there,
> >>>>>>>>>>>>> I'm not sure exactly when I should do.  Any suggestions are very welcome!
> >>>>>>>>>>>> Okay. Find a liveCD that supports raid (hopefully something like
> >>>>>>>>>>>> SystemRescueCD). Make sure it has a very recent kernel and the latest
> >>>>>>>>>>>> mdadm.
> >>>>>>>>>>>>
> >>>>>>>>>>>> All being well, the resync will restart, and when it's finished your
> >>>>>>>>>>>> system will be fine. If it doesn't restart on its own, do an "mdadm
> >>>>>>>>>>>> --stop array", followed by an "mdadm --assemble"
> >>>>>>>>>>>>
> >>>>>>>>>>>> If that doesn't work, then
> >>>>>>>>>>>>
> >>>>>>>>>>>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
> >>>>>>>>>>>>
> >>>>>>>>>>>> Cheers,
> >>>>>>>>>>>> Wol
