Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB264E42
	for <lists+linux-raid@lfdr.de>; Thu, 11 Jul 2019 00:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfGJWAK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 10 Jul 2019 18:00:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38754 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfGJWAJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 10 Jul 2019 18:00:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id v186so2879646oie.5
        for <linux-raid@vger.kernel.org>; Wed, 10 Jul 2019 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDdKxwtGSchgASXxVoS+hj2DxlkmMDBwID8dO1MhkrQ=;
        b=aa0eanr+HhgZF76eB+6O0D+gKdjKdLojZn1bGjCefRz8LqCHL790PDcMJNJcge10YT
         6wjFcNOjKE8PK4p4x3AzxbI3SVDMXfP7Qs7siUyLvLZGbhNF49678VAcvqoHSGCvEMNv
         o+95usNoakTyV18E0pp7bz4mpwkr/xRKHtxOQVJB9Ogbv0+UpfeAGSppYti2jJDI7qGR
         xrJQwJ7aDLCib4Q93JsR1ye9gM+5oLsmqNQOalX1mUuqDNfLScMJuo3NXAen2sLU/UQ0
         7hbtivbiDbjjh7euBu4/8/wfe4MvBkcJFvAOstYCpJxaE+38a3aq+pJ/9TTZa0bsGaLz
         321g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDdKxwtGSchgASXxVoS+hj2DxlkmMDBwID8dO1MhkrQ=;
        b=bI67FIshC5b8WEWVOwailmM3LwK6OKowrJW8QCDT8a6AMdMOIPfyRuq9FikwApRSYS
         9HOGuPnVv0r9ZgmiRo42tZImKHGMp3M9pcxr6gyf/7A3Jp9rzzTPCJnmshKC2HiL0ZEb
         rkdWvdhzw7HC/jPfYeWmcMR2iINHIzLjd6PV8EhMjAWtW1wX4XPzdxz/SfDfw5Sb5V8O
         PXVd1zzublUIoEG4sbhG9lgOsPysqJmub50of3bazCOVDYlXmDMa5B84uPcE0mnin7lm
         nbjsVb2t+JX402LdXUAKdqGJMSok4VNFw6208l4wt0XCt1QxuRf9wz8O/gK/b4uXyRnP
         MYMg==
X-Gm-Message-State: APjAAAXBmlPqCvRp1X4e7HX+HUlPxaIIyWL2yUwfSKTV837DAJ7UZeKL
        Y4PJ4ZrKU6RA0jJxpkAirne0ihhhIZIojdRO8ZE=
X-Google-Smtp-Source: APXvYqxu8fW0srgEVc3AUIsJtmyw652SPRxDdWyydQHO5ZWE4eeear3rSi1f2ypioBX0xPR/+cId1XkT62bAhgCngGw=
X-Received: by 2002:aca:6102:: with SMTP id v2mr345703oib.41.1562796008481;
 Wed, 10 Jul 2019 15:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <2504385.aUmv4P13uU@d-allen> <55824370.7nbRXrPP5B@linux-spw6> <CAJR39ExwJ2TWfU_y4qk_AqrqTaKUkzaTwx9CRCs_bOYgc3Hrzg@mail.gmail.com>
In-Reply-To: <CAJR39ExwJ2TWfU_y4qk_AqrqTaKUkzaTwx9CRCs_bOYgc3Hrzg@mail.gmail.com>
From:   Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Date:   Wed, 10 Jul 2019 22:59:56 +0100
Message-ID: <CAJR39EyQKbVPfzAV431w7C2Mo7XzM4iWQ7kF+YpMA69ySicL=w@mail.gmail.com>
Subject: Re: Regression in mdadm breaks assembling of array
To:     Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Cc:     linux-raid@vger.kernel.org, jsorensen@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, 8 Jul 2019 at 13:26, Mariusz Dabrowski
<mariusz.dabrowski@intel.com> wrote:
>
> On Saturday, July 6, 2019 5:13:14 PM CEST Stephan Diestelhorst wrote:
> > (Off list, please keep me in CC, thx!)
> > Hi there,
> >
> > TL;DR:
> > https://github.com/neilbrown/mdadm/commit611d95290dd41d73bd8f9cc06f7ec293a40
> > b819e regresses mdadm and does not let me assemble my main drive due to
> > kernel error
> >
> > md: invalid array_size 125035870 > default size 125035776
> >
> > caused by changed reservation size in mdadm, and thus reduced "Usable
> > Size" being reduced too much (smaller than 0.5 * Array Size).
> >
> > Full write-up with logs etc here:
> > https://forum.manjaro.org/t/mdadm-issues-live-cd-works-existing-install-bre
> > aks-fakeraid-imsm/93613
> >
> > I chased through both 4.0 mdadm (which works, e.g., from a Live image),
> > and the new 4.1 version (from Manjaro update), and the same disk in the
> > same machine works with the older, and refuses to work with the newer
> > mdadm.
> >
> > The kernel message suggests that the kernel refuses to assemble the
> > array, and tracing the computation back through both versions (4.0 and
> > GIT head 3c9b46cf9ae15a9be98fc47e2080bd9494496246 ) reveals that both
> > versions end up using the default for reserved space, which is
> > MPB_SECTOR_CNT + IMSM_RESERVED_SECTORS (the other difference between the
> > versions is the size computed, but that is hopefully intentional due to
> > 444909385fdaccf961308c4319d7029b82bf8bb1 ).
> >
> > I understand too little to propose a fix or know why the defaults were
> > changed, but this is clearly a regression, and the disk works in the
> > same machine in Windows, and with older Live images.
> >
> > More log output in the Manjaro forum thread, and I have some more log
> > output with printf's sprinkled around if necessary.
> >
> > Happy to help fix this, please have a look :)
> >
> > Thanks,
> >   Stephan
>
> Hello Stephan,
> I have failed to reproduce your issue.

Thanks a lot for trying!

> I would like to know how your array was created: in OS using mdadm or with RST PreOS?

This array was created by the laptop manufacturer.  It an Acer S7 191
which has a peculiar SSD.  It is a dual sided mSATA SSD which has two
independent mSATA SSDs on either side of the PCB, and they are then
joined together to a single block device using RAID-0 IMSM.  There is
something slightly peculiar here.. I got the disk out of a broken S7
and put it into a different one.  Mentioning that in case the BIOS
stores any specific data about the disk and that has changed without
it noticing (but I think that is unlikely).

> Which version of mdadm/RST have you used?

Like I said above, the disk came pre-configured.  I can boot into
Windows alright and can also inspect the disk with the Intel RST
tools, currently at 16.0.2.1086.  On the mdadm side, the disk
assembles with mdadm 4.0 and does not with 4.1; and the commit I
mention above is the one that makes the difference.  Happy to pull out
any RST data, here is what I get from the System Report:

Kit installed: 16.0.2.1086
User interface version: 16.0.2.1086
Language: English (UK)
RAID option ROM version: 11.5.0.1582
Driver version: 16.0.2.1086
ISDI version: 16.0.2.1086

And then details for the disks and arrays.
Array ... Size: 122,114 MB ... Available space: 8MB
Volume ... Size 122,105 MB
Disk ... Size: 60 GB
Disk ... Size: 60 GB

The disk is a LITEONIT CMT-64L3M firmware L2C6

> Your notebook is booting in legacy or UEFI mode?

Booting in EFI mode, via rEFInd.

Thanks,
  Stephan
