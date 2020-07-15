Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BA1221204
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgGOQKu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOQKt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Jul 2020 12:10:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DC9C061755
        for <linux-raid@vger.kernel.org>; Wed, 15 Jul 2020 09:10:49 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t9so1363332lfl.5
        for <linux-raid@vger.kernel.org>; Wed, 15 Jul 2020 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=910h0TUbeWEjKnKzX9Hn28PjWTYV3BNdtYTuGYgWCi4=;
        b=KCoxf+bpY+sPgnPzxiiKxQfO6+ELJmgTNe+H166eQQsHNhxHLfBonc2D0tpbjZUOKo
         64hnNgZ3t8VHRYGDvdo9XmBcIc99ksb8vFnGUKuQUfVk0MwwCEE6770Z13Dmp0TAcwaV
         AdslxYMtxkLCJs1c/iXPmXQk46HE25z9KsZzeIxn/yROfPDv2BbRUIv43A5Sr8J/miW/
         HJO9h1nV5puRWTuFOQuMLUKlu+mzjlAx73RisEBZJGS89BJ5MK0QCwM+9D0rw2EF8nIt
         igaUx41294A8Lf5hRsUNpGVZIIGLRiBUSfdHj1unklRcQc+BjM4yjwsy7bLlskGrEIcN
         O2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=910h0TUbeWEjKnKzX9Hn28PjWTYV3BNdtYTuGYgWCi4=;
        b=Sn50lXv3KDyhjaTa2w1lF5DpZPpYUID6D+C4oj/vDaBRw0ROuagkVaoOx7qpd1Wt5u
         nO2wM3xjA0uLTIC8fa6J3vFqaLHiVzYnlZgeAyRA6qb5QnU5zH/MglOsmjs0riUKsvzA
         BGKz8y7SqpaotiM7C4dCNNPM9EWSvoslkLeRPC+rhiffQnrSGC0njosBSQn6gnHaQ6XE
         V079Z1L0cCHrhsceERLV9wnfPR8703KGddHN62vcUhqnxa2VqQKLTtouGwjeikOqYc59
         3EXI8yRKNbq2ZNwJnGlLPIQScdDPN8SN7JUXGGGi7Cy50IyuVc/CT9MoL9GtKMIBmvvb
         FTvg==
X-Gm-Message-State: AOAM532vt9d7+6+1cJgDAZhy8Y4DDoobsecD3QrbRUSXoBEbtGtPBUc2
        tXLKMSXIyTlVXnd/AuF2IBmpX2+CfjEZY5VhmxQ=
X-Google-Smtp-Source: ABdhPJyZqVoomCpOWNRQ10SirXDzOUMD+n3AyDzJHVgacVY59fFdMgLs2cMVe0XI45rf7gcK5htYDHQAbbwiAQPZUdE=
X-Received: by 2002:a19:8c47:: with SMTP id i7mr5242192lfj.32.1594829447414;
 Wed, 15 Jul 2020 09:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <b551920e-ddad-c627-d75a-e99d32247b6d@gmail.com>
 <0b857b5f-20aa-871d-a22d-43d26ad64764@youngman.org.uk> <CAAMCDec22wshoG8eb9aM4su-EBdJRbh_LyVtaskR9FbYc4f=gw@mail.gmail.com>
 <8373f6a8-f0d9-02de-268d-64bddc4b9aa2@gmail.com>
In-Reply-To: <8373f6a8-f0d9-02de-268d-64bddc4b9aa2@gmail.com>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Wed, 15 Jul 2020 11:10:35 -0500
Message-ID: <CAAMCDecPanRSN70UL7fuMNSdPUwqui8+nDj4Fm=3XohbicBsQA@mail.gmail.com>
Subject: Re: Reshape using drives not partitions, RAID gone after reboot
To:     Adam Barnett <adamtravisbarnett@gmail.com>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

there is a chance that removing the partition tables that should not
be there will just fix it and are what is blocking the devices.

So once you have a copy of the disks, remove the partition table
completely from the 3 and reboot, and it may just start since it will
be able to find the devices.   Or it may now be startable with the
command you attempted to start it with before.

I have had partitioned devices (say /dev/sda1 have a partition table
put on it, and that "block" lvm from looking at /dev/sda1, removing it
and removing the mappings immediately makes the missing pv's show up,
and I am pretty sure mdadm has the same rules.


You must have the exactly right order for assume-clean to work, and
mistake and there will be data issues.

On Tue, Jul 14, 2020 at 9:28 PM Adam Barnett
<adamtravisbarnett@gmail.com> wrote:
>
> Thanks for all the the replies. The drives had single gpt partitions
> that were created before adding the drives to the arrays. So I'll give
> removing the partition tables a try and forcing reassembly.
>
> I also tried stopping the array before forcing reassembly but this issue
> is that the newly added drives appear to have no superblocks, so mdadm
> aborts the assembly.
>
> My current plan is to try to --create --assume-clean the array, but I
> have been reading about using overlay files to preserve the drives. If
> anyone could help me understand exactly how that is done I would be very
> appreciative.
>
> I don't think the list allows links(?) but I'm following the steps on
> the kernel wiki under "Recovering_a_failed_software_RAID" but the bash
> commands are a bit confusing due to the use of the parallel command.
>
> Thanks again all!
>
> -Adam
>
> On 7/14/20 5:27 PM, Roger Heflin wrote:
> > Did you create the partition before you added the disk to mdadm or
> > after?  If after was it a dos or a gpt?  Dos should have only cleared
> > the first 512byte block.  If gpt it will have written to the first
> > block and to at least 1 more location on the disk, possibly causing
> > data loss.
> >
> > If before then you at least need to get rid of the partition table
> > completely.   Having a partition on a device will often cause a number
> > of things to ignore the whole disk.  I have debugged "lost" pv's where
> > the partition effectively "blocked" lvm from even looking at the
> > entire device that the pv was one.
> >
> > If it is a dos partition table then:
> > save a backup of each disk first (always a good idea, you can dd it
> > back if you screwed up so long as you carefully create the backups and
> > name them properly).
> > dd if=/dev/sdx of=/root/sdxbackup.img bs=512 count=1
> > then clear the partition table space, rebooting is probably the
> > easiest way to clear out the mappings, it can be done without
> > rebooting but I have to do it trial and error to figure out the exact
> > order and commands.
> > dd if=/dev/zero of=/dev/sdX bs=512 count=1
> >
> > On Tue, Jul 14, 2020 at 6:11 PM antlists <antlists@youngman.org.uk> wrote:
> >> On 14/07/2020 20:50, Adam Barnett wrote:
> >>> Forcing the assembly does not work:
> >>>
> >>> $ sudo mdadm /dev/md1 --assemble --force /dev/sd[ijmop]1 /dev/sd[kln]
> >>> mdadm: /dev/sdi1 is busy - skipping
> >>> mdadm: /dev/sdj1 is busy - skipping
> >>> mdadm: /dev/sdm1 is busy - skipping
> >>> mdadm: /dev/sdo1 is busy - skipping
> >>> mdadm: /dev/sdp1 is busy - skipping
> >>> mdadm: Cannot assemble mbr metadata on /dev/sdk
> >>> mdadm: /dev/sdk has no superblock - assembly aborted
> >> Did you do an "mdadm --stop /dev/md1" before trying that? That's a
> >> classic error from an array that's previously been partially assembled
> >> and failed ...
> >>
> >> The other thing I'd do is make sure there aren't any other unepected
> >> partially assembled arrays. I doubt it applies here, but I have come
> >> across mirrors that get broken in half and you get two failed arrays
> >> instead of one working one ...
> >>
> >> Cheers,
> >> Wol
