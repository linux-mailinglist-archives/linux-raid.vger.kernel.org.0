Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F1088590
	for <lists+linux-raid@lfdr.de>; Sat, 10 Aug 2019 00:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfHIWGH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 9 Aug 2019 18:06:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46079 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfHIWGH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 9 Aug 2019 18:06:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id m97so4891339otm.12
        for <linux-raid@vger.kernel.org>; Fri, 09 Aug 2019 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UpKknYaUdYALIPzUxvl6yGJdZdpvRT5bN4tY1mjTfo=;
        b=mht7ioiq/M09/bcu7F0BemViCfISxPvGSHnGpoBc/kEdyRDaq+3IR7u9IVrID0L+jO
         qGt3ETmLy4Cf2jENJ8Rmui1QHPgd9Op50MfB6O2ZOGpvvS8Pk8EeV5/ZGhzi4qFwdH8r
         mO098ej58KegUi7eNDz3W3UyGLQmbRrIgQjIX9QMWNOn/wW6+KAwH9xiTvnUhbnnBMra
         g6gD0W5znC3otLLh6WoU2yNKnv0Jw0P3BZn7Qn8O6484yEUNSym2SjnTU8w6UjzRAZXp
         VpNtyzvn1A7wwqbRI+tjbCFs6MvfisI4G3xGW0w0Hxg6AX74lIQJ8lgPzQCn7IGOcb46
         XIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UpKknYaUdYALIPzUxvl6yGJdZdpvRT5bN4tY1mjTfo=;
        b=jskbkZiy5M639xuHO/jsf6hstYT+Bm4sIhjOMCaLAp2lCPBvu7TpjbyK2yI0QLGGpZ
         zFEtRQHrCh+kzsWgAW6JIWpJtCbBrOiihUz8pl4hsYqBkr6onkmdtBoOlbzah+8SjZg0
         nGL1FcWtngHQKVJW1+kPGgopXcZAtrxi5syaXT0QtWP17eEYskFuWVqyD8Jxan2KKzb3
         uJOyGd3TSiFSC6IGqZ+pjEa7Q7OQm4WQMa5h7APgfFyN7WCVt0alz0GcSJOHv3R66ria
         IUsnbPX2pzpCWEMTpLjSPknn2CS9yaQA7Yu3pZgTfynt4fd2pbMd5rrAPSW6y5xJQPjo
         rjOw==
X-Gm-Message-State: APjAAAV/9uAUUJgFIk9v2pUhRpX4zuY550XYnXA0u6r+V4VW2NcVyuIT
        +uLYsfzkshQJ69EMRrGsEKU5O2hGQLEZfYjiL8Q=
X-Google-Smtp-Source: APXvYqwhGUGsuy4AoHLX4wAa1vMisE1yNPUuB6rtdaxwefFZDcZ+8+oefsxX5FW3ykFtkUleVebuDzW9W5JEmaNAAVs=
X-Received: by 2002:a05:6830:119:: with SMTP id i25mr20777800otp.288.1565388366349;
 Fri, 09 Aug 2019 15:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <2504385.aUmv4P13uU@d-allen> <55824370.7nbRXrPP5B@linux-spw6>
 <CAJR39ExwJ2TWfU_y4qk_AqrqTaKUkzaTwx9CRCs_bOYgc3Hrzg@mail.gmail.com> <CAJR39EyQKbVPfzAV431w7C2Mo7XzM4iWQ7kF+YpMA69ySicL=w@mail.gmail.com>
In-Reply-To: <CAJR39EyQKbVPfzAV431w7C2Mo7XzM4iWQ7kF+YpMA69ySicL=w@mail.gmail.com>
From:   Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Date:   Fri, 9 Aug 2019 23:05:54 +0100
Message-ID: <CAJR39EyBBOzMikjX6d5k3aVceib0PM_2e_NTp8Z071kgZfuGBA@mail.gmail.com>
Subject: Re: Regression in mdadm breaks assembling of array
To:     Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Cc:     linux-raid@vger.kernel.org, jsorensen@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, 10 Jul 2019 at 22:59, Stephan Diestelhorst
<stephan.diestelhorst@gmail.com> wrote:
> On Mon, 8 Jul 2019 at 13:26, Mariusz Dabrowski
> <mariusz.dabrowski@intel.com> wrote:
> > On Saturday, July 6, 2019 5:13:14 PM CEST Stephan Diestelhorst wrote:
> > > (Off list, please keep me in CC, thx!)
> > > TL;DR:
> > > https://github.com/neilbrown/mdadm/commit611d95290dd41d73bd8f9cc06f7ec293a40
> > > b819e regresses mdadm and does not let me assemble my main drive due to
> > > kernel error
[..]
> > > Full write-up with logs etc here:
> > > https://forum.manjaro.org/t/mdadm-issues-live-cd-works-existing-install-breaks-fakeraid-imsm/93613
[..]
> > Hello Stephan,
> > I have failed to reproduce your issue.
> > I would like to know how your array was created: in OS using mdadm or with RST PreOS?
>
> This array was created by the laptop manufacturer.  It an Acer S7 191
> which has a peculiar SSD.  It is a dual sided mSATA SSD which has two
> independent mSATA SSDs on either side of the PCB, and they are then
> joined together to a single block device using RAID-0 IMSM.  There is
> something slightly peculiar here.. I got the disk out of a broken S7
> and put it into a different one.  Mentioning that in case the BIOS
> stores any specific data about the disk and that has changed without
> it noticing (but I think that is unlikely).
>
> > Which version of mdadm/RST have you used?
>
> Like I said above, the disk came pre-configured.  I can boot into
> Windows alright and can also inspect the disk with the Intel RST
> tools, currently at 16.0.2.1086.  On the mdadm side, the disk
> assembles with mdadm 4.0 and does not with 4.1; and the commit I
> mention above is the one that makes the difference.  Happy to pull out
> any RST data, here is what I get from the System Report:
>
> Kit installed: 16.0.2.1086
> User interface version: 16.0.2.1086
> Language: English (UK)
> RAID option ROM version: 11.5.0.1582
> Driver version: 16.0.2.1086
> ISDI version: 16.0.2.1086
>
> And then details for the disks and arrays.
> Array ... Size: 122,114 MB ... Available space: 8MB
> Volume ... Size 122,105 MB
> Disk ... Size: 60 GB
> Disk ... Size: 60 GB
>
> The disk is a LITEONIT CMT-64L3M firmware L2C6
>
> > Your notebook is booting in legacy or UEFI mode?
>
> Booting in EFI mode, via rEFInd.

Any additional thoughts on this?  I have now downgraded mdadm to
before the commit I mentioned and it assembles flawlessly.

Thanks,
  Stephan
