Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083FC19803B
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 17:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgC3PyD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 11:54:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40940 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgC3PyD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Mar 2020 11:54:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so14592358lfe.7
        for <linux-raid@vger.kernel.org>; Mon, 30 Mar 2020 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faC3OkBg0HJOO7jztekbrX8a3HqpbJpAPMqOj0Ra7Yk=;
        b=s189qCFFGH5zaFNZcT3guwxMZZ1P1EA0F79eeQ8aWaDquMn2e53haf8FZ9VGOLc3Ri
         SvY458uor8BeToMEXW20xeVdggIWjhIWIOUM70cN4khFZPWIuZCZs67YosR0IoTmNJ94
         jIW0mHWXYA6Z7AHvt0RgeQW4QWlKwvlQPY+YhCyP9kW7EYC00LJc87RRlalWCZ5mj3jo
         k+20v58Ddi+5NngtayX7Yu2IrVXCAK0Du1obahyBxz9i9Oej8sVBGA9gJ8xMXKDKUWNi
         7JipbsAa4/PSwsbGdrzZbTkBNzcsPWt9KXEgr3E/Dv0DgeXupASwQCaO8Jis1SK2lVHJ
         zx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faC3OkBg0HJOO7jztekbrX8a3HqpbJpAPMqOj0Ra7Yk=;
        b=UEgSWqrUT4b5PFvFviayv7V3m9xhkTI4gcmUOj5CXsuOUsRWEDUHVAYDrXrTW0I3al
         /Zv3pjNbAVwAaKInW61xQsxK9bpwmAsFTEpwBQXUkO3ZfV570fwLZGGDzK5uzdXcR0mI
         9lSFm6enF4HwQt57s8FQzMuYBi7F3kcRd+/DQnY21n3tVcQX55kY9sa930E+MSvBwaIg
         hHwwsWtTAk6u+aPQZxQLqIAiAPzC0aYkcpR+iR/cn7VhUQN3vG74IikGT7s8Z28dZjvh
         iCvEDYeEzyr/2VTYJC5zJ4L8hx5KbqRhCSo97A8gAgIUl5grdcHFZHD0bvOodouqeuLd
         86yQ==
X-Gm-Message-State: AGi0PuaoBw8AoEfTrl/43WSm3m0fzOoUFFdcUBpJeSCrsLMJ3or6Onhy
        cgzdlVzZhI4COQQ4xZC98Ll5ilyU1K3ZKdiqZ36siJux
X-Google-Smtp-Source: APiQypKpSzjD3kzXyod3oeYJWRb4IFBe4wWWEuY7xkV9N8r3vSXgSLUUAb4Mdbc2SYCwgImyBzZjPujaiKvX/mfdQmI=
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr8457233lfr.152.1585583640027;
 Mon, 30 Mar 2020 08:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
 <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk> <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
 <CAAMCDee6TcJ_wR6rkQw5V02KyqPQ+xDf+bK+pQPbbfaptO_Tvg@mail.gmail.com>
 <1f393884-dc48-c03e-f734-f9880d9eed96@shenkin.org> <CAAMCDedj7TQAAGzSfQgAftKSmrjNmzHgQUs-X2mQZyFPG62_-A@mail.gmail.com>
 <c8185f80-837e-9654-ee19-611a030a0d54@shenkin.org>
In-Reply-To: <c8185f80-837e-9654-ee19-611a030a0d54@shenkin.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Mon, 30 Mar 2020 10:53:48 -0500
Message-ID: <CAAMCDefr2FakGTz5ok-qvTZiDNTj87vQSWP9ynM_bxtnB=-fkw@mail.gmail.com>
Subject: Re: Raid-6 won't boot
To:     Alexander Shenkin <al@shenkin.org>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

That seems really odd.  Is the raid456 module loaded?

On mine I see messages like this for each disk it scanned and
considered as maybe possibly being an array member.
 kernel: [   83.468700] md/raid:md13: device sdi3 operational as raid disk 5
and messages like this:
 md/raid:md14: not clean -- starting background reconstruction

You might look at /etc/mdadm.conf on the rescue cd and see if it has a
DEVICE line that limits what is being scanned.

On Mon, Mar 30, 2020 at 10:13 AM Alexander Shenkin <al@shenkin.org> wrote:
>
> Thanks Roger,
>
> that grep just returns the detection of the raid1 (md127).  See dmesg
> and mdadm --detail results attached.
>
> Many thanks,
> allie
>
> On 3/28/2020 1:36 PM, Roger Heflin wrote:
> > Try this grep:
> > dmesg | grep "md/raid", if that returns nothing if you can just send
> > the entire dmesg.
> >
> > On Sat, Mar 28, 2020 at 2:47 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>
> >> Thanks Roger.  dmesg has nothing in it referring to md126 or md127....
> >> any other thoughts on how to investigate?
> >>
> >> thanks,
> >> allie
> >>
> >> On 3/27/2020 3:55 PM, Roger Heflin wrote:
> >>> A non-assembled array always reports raid1.
> >>>
> >>> I would run "dmesg | grep md126" to start with and see what it reports it saw.
> >>>
> >>> On Fri, Mar 27, 2020 at 10:29 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>>>
> >>>> Thanks Wol,
> >>>>
> >>>> Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
> >>>> reported.  The first (md126) in reported as inactive with all 7 disks
> >>>> listed as spares.  The second (md127) is reported as active
> >>>> auto-read-only with all 7 disks operational.  Also, the only
> >>>> "personality" reported is Raid1.  I could go ahead with your suggestion
> >>>> of mdadm --stop array and then mdadm --assemble, but I thought the
> >>>> reporting of just the Raid1 personality was a bit strange, so wanted to
> >>>> check in before doing that...
> >>>>
> >>>> Thanks,
> >>>> Allie
> >>>>
> >>>> On 3/26/2020 10:00 PM, antlists wrote:
> >>>>> On 26/03/2020 17:07, Alexander Shenkin wrote:
> >>>>>> I surely need to boot with a rescue disk of some sort, but from there,
> >>>>>> I'm not sure exactly when I should do.  Any suggestions are very welcome!
> >>>>>
> >>>>> Okay. Find a liveCD that supports raid (hopefully something like
> >>>>> SystemRescueCD). Make sure it has a very recent kernel and the latest
> >>>>> mdadm.
> >>>>>
> >>>>> All being well, the resync will restart, and when it's finished your
> >>>>> system will be fine. If it doesn't restart on its own, do an "mdadm
> >>>>> --stop array", followed by an "mdadm --assemble"
> >>>>>
> >>>>> If that doesn't work, then
> >>>>>
> >>>>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
> >>>>>
> >>>>> Cheers,
> >>>>> Wol
