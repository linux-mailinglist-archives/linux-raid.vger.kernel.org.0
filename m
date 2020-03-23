Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6613418FCB8
	for <lists+linux-raid@lfdr.de>; Mon, 23 Mar 2020 19:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCWSeI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Mar 2020 14:34:08 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:47082 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCWSeI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Mar 2020 14:34:08 -0400
Received: by mail-ed1-f43.google.com with SMTP id cf14so8260211edb.13
        for <linux-raid@vger.kernel.org>; Mon, 23 Mar 2020 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5OdeVpMEKw2wi/mueLxmFuNvs/+7jPEtl013HfVizY=;
        b=bltZs04/s5Y6anDn3gbdCGdhTK7EiV88s1EOjeg7oV58o7HVc2LIqR3Ddp/ijF+MgA
         m8nM6i9hp7csMA7AU41wEHfzGhZrE1XpUZ1f+IKHxzMInEM/3PZJTLQvBqMWCpq8RGiS
         g7ixOvBABLkAiMeycqrGd5lg+2zfXa6xh8IBTDUnFQTP66NHgXuWfPU40CX0xeUZnvpn
         C356aLoBpGCek93s5V4rOuXmduy4bmAQJNX/+OIZaPdDDuRVWLy5Xw/ASoKOWz93T0KV
         2CaZF+n9R9aVWEGR37DL80i20EoT5bxUp4leYNw7retGhmI9Hh80xA3hJOnpIx+XXk+c
         RDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5OdeVpMEKw2wi/mueLxmFuNvs/+7jPEtl013HfVizY=;
        b=A9XL19EGTrDmokN4AfZkRYhLk7bdag6yEzEy0lfwLksLNgRfaNXh6Mc1gYw7eKDfid
         eCgmYeg1v1qiJECAx091cuzeF8qzw57lmNX+AhSl21Xlleb9UhO1JpWZHMeNRqjQOTVa
         vYhKHoVMEZsFWTUdp8TFSRPRSbw1fyapGdnI1frqYKowawS00CGJpcEWRmFHYF6kUGe/
         HuR//9DIKRhtQyja/i6P4AD96vrqW1tAX0vvtQXEYd9TWeF22I5UdxErsBEAw9iaxCpj
         k6n4/IqPasJ5G2StYEOZT6h1BpFZCqDUsJ7CJ+Jo2ikwDcLNTzsHZC9VIJoh1mkkIVRA
         QMXw==
X-Gm-Message-State: ANhLgQ3raxlZjXBCOnb1rvdhnyXPiu/VOjtSJ0swuS+4rXx+Fkn8hJjS
        JQavFNDDB9HaUYgwiPDjBRg4dPd8K+T3KhnPz1Ph7nNr
X-Google-Smtp-Source: ADFU+vuNlZ8YjugRST1MbRMqOrqikxBymVbZOyikyzGuEmf54f0UFzwugn4rU1bk1V7cX2i8qLwbGpYknI//Ui2QNr0=
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr23237518edu.337.1584988446682;
 Mon, 23 Mar 2020 11:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJTWkdvU3of87+-zyUPn7uDBen8ZBswujwMn8wYSiwZb=0V3EQ@mail.gmail.com>
 <CAJTWkdtYbmSapP0cG+nknTQWcn1ut4NaF4v5rEtS0wwvkuMH=A@mail.gmail.com> <CAAMCDeeRD51jy8syBoXD_zy2jWFHfG+v0n5AkEHu5-_X0K3+Lg@mail.gmail.com>
In-Reply-To: <CAAMCDeeRD51jy8syBoXD_zy2jWFHfG+v0n5AkEHu5-_X0K3+Lg@mail.gmail.com>
From:   Patrick Dung <patdung100@gmail.com>
Date:   Tue, 24 Mar 2020 02:33:40 +0800
Message-ID: <CAJTWkdtuOoQOJg44p7u1SMwBJM7yXn-d7+tEKoqkUUDAQDfyzg@mail.gmail.com>
Subject: Re: Please show descriptive message about degraded raid when booting
To:     Roger Heflin <rogerheflin@gmail.com>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks for reply.

The problem occurs with my physical hardware and in virtual machine
(can't set TLER).
The log you see in my original post is captured/simulated from a
virtual machine.

The system is not 'hung '. If I run rd.debug it would have lots of
messages scrolling quickly that you can't see clearly.

What I am asking for is a more descriptive message from the MD raid,
try to display the status like:
Try to activate md/raid1:md125, currently 1 of of 2 disk online.
Timeout in X seconds.
Something like that.

Thanks,
Patrick

On Tue, Mar 24, 2020 at 2:14 AM Roger Heflin <rogerheflin@gmail.com> wrote:
>
> The system had hung.  The disks are failing inside the SCSI subsystem,
> I don't believe (raid, lvm, multipath) will know anything about what
> is going on inside the scsi layer.
>
> Those default timeouts are usually at least 30 seconds, but in the
> past the scsi subsystem did some retrying internally.  The timeout
> needs to be higher than the length of time the disk could take.
> Non-enterprise, non-raid disks generally have this timeout set 60-120
> seconds hence MD waiting to see if the failure is a sector read
> failure (will be a no-response until the disk timeout) or a complete
> disk failure (no response ever).
>
> cat /sys/block/sda/device/timeout shows the timeout.
>
> Read about seterc, tler and smartctl for discussions about what is going on.
>
> If you can then turn down your disks max timeout with the smartctl
> commands then the disk will report back a sector failure faster and
> that is usually what is happening.  If you turn down the disks timeout
> to a max of say 7 seconds then you can set the scsi layers timeout to
> say 10 seconds.   Then the only time the scsi timeout matters if if
> the disk is there but not responding.
>
>
> On Fri, Mar 20, 2020 at 11:50 AM Patrick Dung <patdung100@gmail.com> wrote:
> >
> > Hello,
> >
> > Bump.
> >
> > Got a reply from Fedora support but asking me to find upstream.
> > https://bugzilla.redhat.com/show_bug.cgi?id=1794139
> >
> > Thanks,
> > Patrick
> >
> > On Thu, Mar 5, 2020 at 10:57 PM Patrick Dung <patdung100@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > The system have Linux software raid (md) raid 1.
> > > One of the disk is missing or have problem.
> > >
> > > The raid is degraded.
> > > When the OS boot, it hangs at the message for outputting to kernel at
> > > about three seconds.
> > > There is no descriptive message that the RAID is degraded.
> > > I know the problem because I had wrote zero to one of the disk of the
> > > raid 1. If I don't know the problem (maybe cable is loose or disk
> > > failure), it is confusing.
> > >
> > > Related log:
> > >
> > > [    2.917387] sd 32:0:0:0: [sda] 56623104 512-byte logical blocks:
> > > (29.0 GB/27.0 GiB)
> > > [    2.917446] sd 32:0:1:0: [sdb] 56623104 512-byte logical blocks:
> > > (29.0 GB/27.0 GiB)
> > > [    2.917499] sd 32:0:0:0: [sda] Write Protect is off
> > > [    2.917516] sd 32:0:0:0: [sda] Mode Sense: 61 00 00 00
> > > [    2.917557] sd 32:0:1:0: [sdb] Write Protect is off
> > > [    2.917575] sd 32:0:1:0: [sdb] Mode Sense: 61 00 00 00
> > > [    2.917615] sd 32:0:0:0: [sda] Cache data unavailable
> > > [    2.917636] sd 32:0:0:0: [sda] Assuming drive cache: write through
> > > [    2.917661] sd 32:0:1:0: [sdb] Cache data unavailable
> > > [    2.917677] sd 32:0:1:0: [sdb] Assuming drive cache: write through
> > > [    2.927076] sd 32:0:0:0: [sda] Attached SCSI disk
> > > [    2.927458]  sdb: sdb1 sdb2 sdb3 sdb4
> > > [    2.929018] sd 32:0:1:0: [sdb] Attached SCSI disk
> > > [    3.060855] vmxnet3 0000:0b:00.0 ens192: intr type 3, mode 0, 3
> > > vectors allocated
> > > [    3.061826] vmxnet3 0000:0b:00.0 ens192: NIC Link is Up 10000 Mbps
> > > [  139.411464] md/raid1:md125: active with 1 out of 2 mirrors
> > > [  139.412176] md125: detected capacity change from 0 to 1073676288
> > > [  139.433441] md/raid1:md126: active with 1 out of 2 mirrors
> > > [  139.434182] md126: detected capacity change from 0 to 314507264
> > > [  139.436894]  md126:
> > > [  139.455511] md/raid1:md127: active with 1 out of 2 mirrors
> > > [  139.456739] md127: detected capacity change from 0 to 27582726144
> > >
> > > So there are about 130 seconds without any descriptive messages. I
> > > thought the system had hanged.
> > >
> > > Could the kernel display more descriptive messages about the RAID?
> > >
> > > If I use rd.debug boot parameters, I know the kernel is still running.
> > > But it is scrolling very fast without actually knowing what is the the
> > > problem.
> > >
> > > Thanks,
> > > Patrick
