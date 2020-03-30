Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69ECE19821E
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 19:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgC3RVk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 13:21:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34847 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgC3RVk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Mar 2020 13:21:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id t16so14048717lfl.2
        for <linux-raid@vger.kernel.org>; Mon, 30 Mar 2020 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llQcf1OWpa6AAdcpHA+8S/LIe8qTSTlZ82wLon4tWrI=;
        b=ffohiI/8rRrzSbxgY8q5lJO1ag8eidbhSS7soST12vkd+wiDEfVqzcNU0AgZSI18Mb
         GER1YKEWZh75Lwt5xnuUzHi4ihqazAMPWwUmo3DY91QbNFHdFreu0R74E1/xuT330/xS
         h30jJuD6fvzT2+DgWwQdcZ56IRAN0hGqyj2ItBf4lTiS60tV6V/GHA8wy/oR3GfgaD03
         ir2XD2yG9EUnwCQR0s/6rd/pU35UkSGPfJLHSaR43g9EkezODwj9b4dhNdToDi978Ms8
         DEOH5LQnzZtJBfXiwcx11S2oAaVgwEnGROJJv3i10+7+fIOCopi7sTS1Zez2p76TuZOx
         v7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llQcf1OWpa6AAdcpHA+8S/LIe8qTSTlZ82wLon4tWrI=;
        b=Ih6tF4Edppqlhy+ilQP+WMkHTMiz2kAVw9SgGnbzdEsuUKnjMwzAmQiyBF7E+MOlkY
         AEzIKyN4icr9qTO8e5we74m6d5mQ1csOfN5AIZjdGw250749CKRnyg5ML8EWeJuI9TzA
         2OCptiLAg+TXkGB8PyVGpgCAys/MyjgQIR/2YgcQryDL9Sh/3fczSi5kjjzYFX7E1W85
         eN79/6eOcDAbOpy3N9+jK9lcuVEkHQgcnbuKerxUw1/ZNcrKH0+Bx9sbi6iXFfG+wwXR
         wYDIv3F5do9Tu4wLSrnnAd6QAX8V8Mpls+eHk6a07VG72kTO70k6EFV/MXV+hjn1Mv/v
         VVEA==
X-Gm-Message-State: AGi0PuYYDFuWXhSa5WchV7OuGK20kf4RMx4KMj4Io3ZzJC6/vYzUIQXu
        pYyLrj5pOh9OJ4haGG2FdOgYUNiqy7svzjlSr876oUXHx7g=
X-Google-Smtp-Source: APiQypKbwGp71M6ggLNtW82KBkRw46JhE0fr5laoL7HzEwV3zsPh6fcUKOuQkjC7fe8P6D7viFbd8rzTDknEF2Yj/XY=
X-Received: by 2002:a19:ac8:: with SMTP id 191mr8701323lfk.77.1585588896103;
 Mon, 30 Mar 2020 10:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
 <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk> <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
 <CAAMCDee6TcJ_wR6rkQw5V02KyqPQ+xDf+bK+pQPbbfaptO_Tvg@mail.gmail.com>
 <1f393884-dc48-c03e-f734-f9880d9eed96@shenkin.org> <CAAMCDedj7TQAAGzSfQgAftKSmrjNmzHgQUs-X2mQZyFPG62_-A@mail.gmail.com>
 <c8185f80-837e-9654-ee19-611a030a0d54@shenkin.org> <CAAMCDefr2FakGTz5ok-qvTZiDNTj87vQSWP9ynM_bxtnB=-fkw@mail.gmail.com>
 <fa7e9b6d-28f3-8c9f-0901-eeac761e382f@shenkin.org>
In-Reply-To: <fa7e9b6d-28f3-8c9f-0901-eeac761e382f@shenkin.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Mon, 30 Mar 2020 12:21:24 -0500
Message-ID: <CAAMCDefXygV4CZdxadfRFAV+HeEqnY8nWG1hpsVi4tBf1PYYww@mail.gmail.com>
Subject: Re: Raid-6 won't boot
To:     Alexander Shenkin <al@shenkin.org>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

do this against each partition that had it:

 mdadm --examine /dev/sd***

It seems like it is not seeing it as a md-raid.

On Mon, Mar 30, 2020 at 11:13 AM Alexander Shenkin <al@shenkin.org> wrote:
>
> Thanks Roger,
>
> The only line that isn't commented out in /etc/mdadm.conf is "DEVICE
> partitions"...
>
> Thanks,
>
> Allie
>
> On 3/30/2020 4:53 PM, Roger Heflin wrote:
> > That seems really odd.  Is the raid456 module loaded?
> >
> > On mine I see messages like this for each disk it scanned and
> > considered as maybe possibly being an array member.
> >  kernel: [   83.468700] md/raid:md13: device sdi3 operational as raid disk 5
> > and messages like this:
> >  md/raid:md14: not clean -- starting background reconstruction
> >
> > You might look at /etc/mdadm.conf on the rescue cd and see if it has a
> > DEVICE line that limits what is being scanned.
> >
> > On Mon, Mar 30, 2020 at 10:13 AM Alexander Shenkin <al@shenkin.org> wrote:
> >> Thanks Roger,
> >>
> >> that grep just returns the detection of the raid1 (md127).  See dmesg
> >> and mdadm --detail results attached.
> >>
> >> Many thanks,
> >> allie
> >>
> >> On 3/28/2020 1:36 PM, Roger Heflin wrote:
> >>> Try this grep:
> >>> dmesg | grep "md/raid", if that returns nothing if you can just send
> >>> the entire dmesg.
> >>>
> >>> On Sat, Mar 28, 2020 at 2:47 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>> Thanks Roger.  dmesg has nothing in it referring to md126 or md127....
> >>>> any other thoughts on how to investigate?
> >>>>
> >>>> thanks,
> >>>> allie
> >>>>
> >>>> On 3/27/2020 3:55 PM, Roger Heflin wrote:
> >>>>> A non-assembled array always reports raid1.
> >>>>>
> >>>>> I would run "dmesg | grep md126" to start with and see what it reports it saw.
> >>>>>
> >>>>> On Fri, Mar 27, 2020 at 10:29 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>>> Thanks Wol,
> >>>>>>
> >>>>>> Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
> >>>>>> reported.  The first (md126) in reported as inactive with all 7 disks
> >>>>>> listed as spares.  The second (md127) is reported as active
> >>>>>> auto-read-only with all 7 disks operational.  Also, the only
> >>>>>> "personality" reported is Raid1.  I could go ahead with your suggestion
> >>>>>> of mdadm --stop array and then mdadm --assemble, but I thought the
> >>>>>> reporting of just the Raid1 personality was a bit strange, so wanted to
> >>>>>> check in before doing that...
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Allie
> >>>>>>
> >>>>>> On 3/26/2020 10:00 PM, antlists wrote:
> >>>>>>> On 26/03/2020 17:07, Alexander Shenkin wrote:
> >>>>>>>> I surely need to boot with a rescue disk of some sort, but from there,
> >>>>>>>> I'm not sure exactly when I should do.  Any suggestions are very welcome!
> >>>>>>> Okay. Find a liveCD that supports raid (hopefully something like
> >>>>>>> SystemRescueCD). Make sure it has a very recent kernel and the latest
> >>>>>>> mdadm.
> >>>>>>>
> >>>>>>> All being well, the resync will restart, and when it's finished your
> >>>>>>> system will be fine. If it doesn't restart on its own, do an "mdadm
> >>>>>>> --stop array", followed by an "mdadm --assemble"
> >>>>>>>
> >>>>>>> If that doesn't work, then
> >>>>>>>
> >>>>>>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
> >>>>>>>
> >>>>>>> Cheers,
> >>>>>>> Wol
