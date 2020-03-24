Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E68219048F
	for <lists+linux-raid@lfdr.de>; Tue, 24 Mar 2020 05:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgCXEpl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 24 Mar 2020 00:45:41 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33452 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgCXEpk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 24 Mar 2020 00:45:40 -0400
Received: by mail-ed1-f43.google.com with SMTP id z65so19286508ede.0
        for <linux-raid@vger.kernel.org>; Mon, 23 Mar 2020 21:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VM7/jaRSpD7I5ztmcaiOp2uqvRKKkT2a+l9zlHHVClc=;
        b=OVD4Kyq5z1GzgsieIlFskrzZBMNn9ZuhLruFFvP+rQPSDeyR4QNMLyq6YaJuQsS9En
         SUUpNtTt6LIACoB2JtEXAlkJqj7k+pEQ7HC3Oq5u9ZD1KsKq1P2k0xCFEmfX0jwJhEGk
         0UKahZijEHPES+r1cjdodyZrP0xutzKLOiYM2h0k8cn4lyiu/D0Mf7qM9CTrcWC/t7P7
         j6M9nUY/2SGZIx75elb0O9LxE0dM6purDRiAS4jzk+i7yKueUc7HvfLav/fsjpeIn4/m
         eiUp3JwYXmDdYWG/T3AWtf6+C32uEIZKs/j4M4xxIbHW/lO8/a/3ai2nXBWTAcVtcnXb
         7Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VM7/jaRSpD7I5ztmcaiOp2uqvRKKkT2a+l9zlHHVClc=;
        b=QQbEyr8YsXQUWfGrOTAd4Wmn7+Dz7/I6t4pgLZzGAe9t7rU2aozD5sJ1Guxm3yoY0R
         EI1Zpx3D2ImFDELLq71uc7pVNmpSHBa8gfzegSkgvBhJMFg+CVJZ+BImS/rgAbeepGn0
         uqfyL8faGB8K4oh3jd6AJd7S07UWHH4gcW2NyDwkA+Bed8Fs3eAP7nFHKF4NVc5F8Gtk
         w3vtFP8PdJBaeBByGMSz3x5u4KkQ/lZ5NmoJBweQ3Ib6JcmPh3V6C79vTwVSyjyeJFcK
         Y5CF8CE2GKKZd+y90qhjElsTrALerQX6DYE4AIwZtBiRm122ofL1jH3wWyZb12EDHpt3
         cBSQ==
X-Gm-Message-State: ANhLgQ1LUNj6QKB6MplKkWGYMJHGD7SgVg/5sEeZlH9JruH1JqXxFF7A
        FFLmFQ0GiPaB1mNPr6llz0IGRZMx+d7P7Mb2pf4iEecF
X-Google-Smtp-Source: ADFU+vuIDMz99z/7KRFO9d4U+OPQnd8LtKE1cMc0NVbHxyhbvgjdW7rOtowqIfLcPvCsGI28/ndgiU5D6rnJmrDEw+c=
X-Received: by 2002:a17:906:95c9:: with SMTP id n9mr17056621ejy.208.1585025138302;
 Mon, 23 Mar 2020 21:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJTWkdvU3of87+-zyUPn7uDBen8ZBswujwMn8wYSiwZb=0V3EQ@mail.gmail.com>
 <CAJTWkdtYbmSapP0cG+nknTQWcn1ut4NaF4v5rEtS0wwvkuMH=A@mail.gmail.com>
 <CAAMCDeeRD51jy8syBoXD_zy2jWFHfG+v0n5AkEHu5-_X0K3+Lg@mail.gmail.com> <CAJTWkdtuOoQOJg44p7u1SMwBJM7yXn-d7+tEKoqkUUDAQDfyzg@mail.gmail.com>
In-Reply-To: <CAJTWkdtuOoQOJg44p7u1SMwBJM7yXn-d7+tEKoqkUUDAQDfyzg@mail.gmail.com>
From:   Patrick Dung <patdung100@gmail.com>
Date:   Tue, 24 Mar 2020 12:45:11 +0800
Message-ID: <CAJTWkduxhetjWT=fYQ46gwoYC2A=xQ4KjD6cxP+K6yUNBK9_EQ@mail.gmail.com>
Subject: Re: Please show descriptive message about degraded raid when booting
To:     Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

By the way, for my original post, it's a virtual machine. I disconnect
one of the members from the raid 1.
I can't simulate hardware failure with VM. So there are no 'SCT Error
Recovery Control/TLER' timeout involved.

Thanks,
Patrick

On Tue, Mar 24, 2020 at 2:33 AM Patrick Dung <patdung100@gmail.com> wrote:
>
> Thanks for reply.
>
> The problem occurs with my physical hardware and in virtual machine
> (can't set TLER).
> The log you see in my original post is captured/simulated from a
> virtual machine.
>
> The system is not 'hung '. If I run rd.debug it would have lots of
> messages scrolling quickly that you can't see clearly.
>
> What I am asking for is a more descriptive message from the MD raid,
> try to display the status like:
> Try to activate md/raid1:md125, currently 1 of of 2 disk online.
> Timeout in X seconds.
> Something like that.
>
> Thanks,
> Patrick
>
> On Tue, Mar 24, 2020 at 2:14 AM Roger Heflin <rogerheflin@gmail.com> wrote:
> >
> > The system had hung.  The disks are failing inside the SCSI subsystem,
> > I don't believe (raid, lvm, multipath) will know anything about what
> > is going on inside the scsi layer.
> >
> > Those default timeouts are usually at least 30 seconds, but in the
> > past the scsi subsystem did some retrying internally.  The timeout
> > needs to be higher than the length of time the disk could take.
> > Non-enterprise, non-raid disks generally have this timeout set 60-120
> > seconds hence MD waiting to see if the failure is a sector read
> > failure (will be a no-response until the disk timeout) or a complete
> > disk failure (no response ever).
> >
> > cat /sys/block/sda/device/timeout shows the timeout.
> >
> > Read about seterc, tler and smartctl for discussions about what is going on.
> >
> > If you can then turn down your disks max timeout with the smartctl
> > commands then the disk will report back a sector failure faster and
> > that is usually what is happening.  If you turn down the disks timeout
> > to a max of say 7 seconds then you can set the scsi layers timeout to
> > say 10 seconds.   Then the only time the scsi timeout matters if if
> > the disk is there but not responding.
> >
> >
> > On Fri, Mar 20, 2020 at 11:50 AM Patrick Dung <patdung100@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > Bump.
> > >
> > > Got a reply from Fedora support but asking me to find upstream.
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1794139
> > >
> > > Thanks,
> > > Patrick
> > >
> > > On Thu, Mar 5, 2020 at 10:57 PM Patrick Dung <patdung100@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > The system have Linux software raid (md) raid 1.
> > > > One of the disk is missing or have problem.
> > > >
> > > > The raid is degraded.
> > > > When the OS boot, it hangs at the message for outputting to kernel at
> > > > about three seconds.
> > > > There is no descriptive message that the RAID is degraded.
> > > > I know the problem because I had wrote zero to one of the disk of the
> > > > raid 1. If I don't know the problem (maybe cable is loose or disk
> > > > failure), it is confusing.
> > > >
> > > > Related log:
> > > >
> > > > [    2.917387] sd 32:0:0:0: [sda] 56623104 512-byte logical blocks:
> > > > (29.0 GB/27.0 GiB)
> > > > [    2.917446] sd 32:0:1:0: [sdb] 56623104 512-byte logical blocks:
> > > > (29.0 GB/27.0 GiB)
> > > > [    2.917499] sd 32:0:0:0: [sda] Write Protect is off
> > > > [    2.917516] sd 32:0:0:0: [sda] Mode Sense: 61 00 00 00
> > > > [    2.917557] sd 32:0:1:0: [sdb] Write Protect is off
> > > > [    2.917575] sd 32:0:1:0: [sdb] Mode Sense: 61 00 00 00
> > > > [    2.917615] sd 32:0:0:0: [sda] Cache data unavailable
> > > > [    2.917636] sd 32:0:0:0: [sda] Assuming drive cache: write through
> > > > [    2.917661] sd 32:0:1:0: [sdb] Cache data unavailable
> > > > [    2.917677] sd 32:0:1:0: [sdb] Assuming drive cache: write through
> > > > [    2.927076] sd 32:0:0:0: [sda] Attached SCSI disk
> > > > [    2.927458]  sdb: sdb1 sdb2 sdb3 sdb4
> > > > [    2.929018] sd 32:0:1:0: [sdb] Attached SCSI disk
> > > > [    3.060855] vmxnet3 0000:0b:00.0 ens192: intr type 3, mode 0, 3
> > > > vectors allocated
> > > > [    3.061826] vmxnet3 0000:0b:00.0 ens192: NIC Link is Up 10000 Mbps
> > > > [  139.411464] md/raid1:md125: active with 1 out of 2 mirrors
> > > > [  139.412176] md125: detected capacity change from 0 to 1073676288
> > > > [  139.433441] md/raid1:md126: active with 1 out of 2 mirrors
> > > > [  139.434182] md126: detected capacity change from 0 to 314507264
> > > > [  139.436894]  md126:
> > > > [  139.455511] md/raid1:md127: active with 1 out of 2 mirrors
> > > > [  139.456739] md127: detected capacity change from 0 to 27582726144
> > > >
> > > > So there are about 130 seconds without any descriptive messages. I
> > > > thought the system had hanged.
> > > >
> > > > Could the kernel display more descriptive messages about the RAID?
> > > >
> > > > If I use rd.debug boot parameters, I know the kernel is still running.
> > > > But it is scrolling very fast without actually knowing what is the the
> > > > problem.
> > > >
> > > > Thanks,
> > > > Patrick
