Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2119665C
	for <lists+linux-raid@lfdr.de>; Sat, 28 Mar 2020 14:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgC1Ngq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 28 Mar 2020 09:36:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47072 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1Ngq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 28 Mar 2020 09:36:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id q5so10127893lfb.13
        for <linux-raid@vger.kernel.org>; Sat, 28 Mar 2020 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HD3X6pQkcXjdDoAIu3LDk0wMknBV0MfQTqnpaI7fK9Q=;
        b=IUbjR9NaGg3vDIbH84i/TRr0QKZ9jzm1+JNoAH3abPRWLDvtAB2zK88HBQDgHjcYYC
         vAsZxXOTDAUsVM04AwAMCAedogdcPDS3J9djbrgAvu3OQV2dSvjN7XMtnXLdnt5bmQhH
         d6goeOZu1Pl+Jhg0sc5YomIxLK6uAOnzFr5FphdD/UGHnGJz0DQZT4xCaHpuiPtDJtXo
         Rm95aCrHFeoPlgjdO/pk1mUeyUFdkLOZatalWs4FT2j1MF+6d8DBHSj3PV/XBsGqc3Al
         7fTq373UtNG56nHJF/OBEWENXNKBUV4vo7Vbs6I4r6ftXbFFQsfoXscKAJ+psJqVc9DD
         zNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HD3X6pQkcXjdDoAIu3LDk0wMknBV0MfQTqnpaI7fK9Q=;
        b=E/AIBnp7Gt/PFPsf0z6vDRPW7YAkJ+X3omK9ez8NaukP2TJSIru84BZmvoV9v8eg/b
         n9rMnzY5DESwo8sF8jCvLhX50Zf8s2m572489QMSixum+Je6WQph0k9ipklKLCBlWmsE
         igvzHhVtx+fnVQ580jL6AaQTAm9roK254Dy8pETQlubXYaPMtfVeFY/VfmTCg1bw4pVt
         yncBLWFiPbtSu+wxt6lawLpe9YE0Nudq+Ze8ba9XV6DqnSHb8GXYtoH4HgCRlsmibOOG
         kEcNFvYWP4qFhC5e+I+n8OVRP7Al6GJpnouC1zKxDzNU0o4v+7eQGrKJhAFDst3kVpEV
         Mw+w==
X-Gm-Message-State: AGi0PuaBS9oeLK5gaRkWXcOk1UhQzl9VfJNvnWVBSdoZMQ6ID/PZvlEa
        vBxt0KHvMbD2XA3WtQCqbrukFV13vZjkh1bqRYscl6aZ0fo=
X-Google-Smtp-Source: APiQypJVTgznOWew30Gy5OfbN4uM4KvWg1DqaiX3Wy22/7fOP3DgBM0XRZxG0sx0CGPJzxvLmDM17G9o3nUJmXIvYfU=
X-Received: by 2002:a05:6512:3eb:: with SMTP id n11mr2660893lfq.32.1585402603997;
 Sat, 28 Mar 2020 06:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
 <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk> <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
 <CAAMCDee6TcJ_wR6rkQw5V02KyqPQ+xDf+bK+pQPbbfaptO_Tvg@mail.gmail.com> <1f393884-dc48-c03e-f734-f9880d9eed96@shenkin.org>
In-Reply-To: <1f393884-dc48-c03e-f734-f9880d9eed96@shenkin.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Sat, 28 Mar 2020 08:36:32 -0500
Message-ID: <CAAMCDedj7TQAAGzSfQgAftKSmrjNmzHgQUs-X2mQZyFPG62_-A@mail.gmail.com>
Subject: Re: Raid-6 won't boot
To:     Alexander Shenkin <al@shenkin.org>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Try this grep:
dmesg | grep "md/raid", if that returns nothing if you can just send
the entire dmesg.

On Sat, Mar 28, 2020 at 2:47 AM Alexander Shenkin <al@shenkin.org> wrote:
>
> Thanks Roger.  dmesg has nothing in it referring to md126 or md127....
> any other thoughts on how to investigate?
>
> thanks,
> allie
>
> On 3/27/2020 3:55 PM, Roger Heflin wrote:
> > A non-assembled array always reports raid1.
> >
> > I would run "dmesg | grep md126" to start with and see what it reports it saw.
> >
> > On Fri, Mar 27, 2020 at 10:29 AM Alexander Shenkin <al@shenkin.org> wrote:
> >>
> >> Thanks Wol,
> >>
> >> Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
> >> reported.  The first (md126) in reported as inactive with all 7 disks
> >> listed as spares.  The second (md127) is reported as active
> >> auto-read-only with all 7 disks operational.  Also, the only
> >> "personality" reported is Raid1.  I could go ahead with your suggestion
> >> of mdadm --stop array and then mdadm --assemble, but I thought the
> >> reporting of just the Raid1 personality was a bit strange, so wanted to
> >> check in before doing that...
> >>
> >> Thanks,
> >> Allie
> >>
> >> On 3/26/2020 10:00 PM, antlists wrote:
> >>> On 26/03/2020 17:07, Alexander Shenkin wrote:
> >>>> I surely need to boot with a rescue disk of some sort, but from there,
> >>>> I'm not sure exactly when I should do.  Any suggestions are very welcome!
> >>>
> >>> Okay. Find a liveCD that supports raid (hopefully something like
> >>> SystemRescueCD). Make sure it has a very recent kernel and the latest
> >>> mdadm.
> >>>
> >>> All being well, the resync will restart, and when it's finished your
> >>> system will be fine. If it doesn't restart on its own, do an "mdadm
> >>> --stop array", followed by an "mdadm --assemble"
> >>>
> >>> If that doesn't work, then
> >>>
> >>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
> >>>
> >>> Cheers,
> >>> Wol
