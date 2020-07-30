Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684E1233862
	for <lists+linux-raid@lfdr.de>; Thu, 30 Jul 2020 20:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgG3S3D (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 Jul 2020 14:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgG3S3C (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 30 Jul 2020 14:29:02 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E103C061574
        for <linux-raid@vger.kernel.org>; Thu, 30 Jul 2020 11:29:02 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id z10so2547515ooi.10
        for <linux-raid@vger.kernel.org>; Thu, 30 Jul 2020 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tHIsalCwIdxfnDdJ9GfaQDRkHJMRtmc9W79Y7ldrPhs=;
        b=LYHDbu9noMx8Mzl9EKbYENoesz0zKo7CQJzT8dj9T31Du/pDAA7vouARQLJCPSGiI7
         L2VDK83TXYfUSQyM7Svheba8z8RSSO8pCNXsoaT5po8dAh4b5EITLlYqJtnxg6Y29ryg
         cx4QBE7Phtl8GAIzHvTqMEIkaDEN8FwU7DsB16MlLFrUlzxDuSvE4qJ3ejv8jplVFh1g
         n07YabZqqxtgRSjeP5U1MXW4y9cTDGPZL73opV4Pv/RUjh1I1+Yv9v0bWbXQW8MhsTMv
         mp/wbIXUSr9Ihf8+m8e8ImtwVIH4N26I9eq2a+QH+t6sI0Gj+6T+HNvAEBa1YuvBOLVQ
         hV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHIsalCwIdxfnDdJ9GfaQDRkHJMRtmc9W79Y7ldrPhs=;
        b=Jl5hFGD89AtNgAWUtBXmm6hDDpq2VKcP1WGP6lQpd1Q04fAZuQDlxcnh8DXIVSDhh+
         TqueLSi+IVqX4JiZKWdf8uQnSJB3dkRD2o+JQz+E2Zn9iKkvfGN1zKwbSh5Ef/W4ZmFo
         L9z1r3X78+1maYdgy2bxjLVGwEfA8TCL/tsvcsQSWnNBEE1O9qvVc+UOimhO0piAgx3f
         fokZwC39wXqFWwIZuVnvnAxVEIyjIEnD9LbwsAbR8aPXy1jErTNJYlxHQHwGoW0qRKaH
         EZ9BNqvSaFDci/Mgu8IWJFw8UawIrQ/6lD3X4gvdNts++4r3QhGRvOJB5bP+za3UQP1R
         lleQ==
X-Gm-Message-State: AOAM531wE2UYlY1xq3BUIcI5sqsXfO4EdS3wj1Ob665pHsFc1c3cOxyg
        t/mHTEs4o4dm63NDLLUaMVd9laKzOUmZnBIL5PMDh+8R
X-Google-Smtp-Source: ABdhPJwMgY5KbrmJqQpebz4pMzzQSf36+OO+4JHUUti+qeP7uw5G2if1pyUZL4qgN4Sz49u3aLraOPWeVOcA5b8rZss=
X-Received: by 2002:a4a:9572:: with SMTP id n47mr65981ooi.37.1596133740969;
 Thu, 30 Jul 2020 11:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CBf3QZP4Yss0U=6Aa_5a+3D2Yy-WT545VazHiFWCZsreNOEg@mail.gmail.com>
 <CA+CBf3Q8sKv9k83dp38ekkBY1qgvOe2seQOYvxukg-X4__7JkA@mail.gmail.com>
 <5F180388.6020402@youngman.org.uk> <CA+CBf3T_GtTwLqKrk4UWj_yPPL7vqJQzBD7Z_J34WWSwmudR5g@mail.gmail.com>
 <a5634a2c-d6be-e037-da70-2d828f65873e@youngman.org.uk>
In-Reply-To: <a5634a2c-d6be-e037-da70-2d828f65873e@youngman.org.uk>
From:   Cory Derenburger <cory.derenburger@gmail.com>
Date:   Thu, 30 Jul 2020 11:28:41 -0700
Message-ID: <CA+CBf3SwEntOUTxoYhoxrO97dqnOZ84vu=dmvdQ2EZNP1CgVVg@mail.gmail.com>
Subject: Re: Software RAID6 broke after power outage
To:     antlists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thank you all so much for your guidance and help!  I was able to
reassemble my RAID with the use of a bootable rescue disk.  The --stop
command is what I was missing.

I ended up purchasing a Synology NAS and some Iron Wolf NAS drives to
replace this old file server.  While I could have just replaced the
drives, the file server is quite old and there are other components
that could eventually fail.  The computer was previously a desktop
twice over and is now 15 years old and deserves a retirement.

Thanks again for your help Wol!
Cory

On Wed, Jul 22, 2020 at 12:47 PM antlists <antlists@youngman.org.uk> wrote:
>
> On 22/07/2020 17:29, Cory Derenburger wrote:
> > Thanks Wols,
> >
> > The version on Linux Mint I've been running is quite old.  Once the
> > server was last configured it did not have updates.  It was put on a
> > shelf and (mostly) left alone to serve files reliably for years.
>
> That's good.
> >
> > $ mdadm --version
> > mdadm - v3.2.5 - 18th May 2012
> >
> And that's not so good. If your root is not on the raid and the system
> actually runs, download and run the latest mdadm. That on an old kernel
> shouldn't be a problem. A franken-kernel that's been patched to buggery
> probably is.
>
> > uname -a
> > Linux LIZZY 3.16.0-38-generic #52~14.04.1-Ubuntu SMP Fri May 8
> > 09:43:57 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
> >
> Do you want the good news or the bad news? The good news is we can
> probably recover your data. The bad news is you're probably looking at
> replacing all your drives :-(
>
> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch
>
> A cursory glance says you have several drives that fall foul of this.
> Again, if your system is bootable, you NEED to configure Brad's script
> to run. I'll go into it a bit deeper as I dig through your reply.
> >
> > smartctrl for the drives
> > # smartctl --xall /dev/sdb
> > smartctl 6.2 2013-07-26 r3841 [x86_64-linux-3.16.0-38-generic] (local build)
> > Copyright (C) 2002-13, Bruce Allen, Christian Franke, www.smartmontools.org
> >
> > === START OF INFORMATION SECTION ===
> > Device Model:     Hitachi HUA723020ALA641
> > Serial Number:    YFGK3VXD
> > LU WWN Device Id: 5 000cca 223c7c8d4
> > Firmware Version: MK7OA840
> > User Capacity:    2,000,398,934,016 bytes [2.00 TB]
> > Sector Size:      512 bytes logical/physical
> > Rotation Rate:    7200 rpm
> > Device is:        Not in smartctl database [for details use: -P showall]
> > ATA Version is:   ATA8-ACS T13/1699-D revision 4
> > SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 3.0 Gb/s)
> > Local Time is:    Tue Jul 21 12:43:42 2020 PDT
> > SMART support is: Available - device has SMART capability.
> > SMART support is: Enabled
> > AAM feature is:   Unavailable
> > APM feature is:   Disabled
> > Rd look-ahead is: Enabled
> > Write cache is:   Enabled
> > ATA Security is:  Disabled, NOT FROZEN [SEC1]
> > Wt Cache Reorder: Enabled
> >
> > === START OF READ SMART DATA SECTION ===
> > SMART overall-health self-assessment test result: PASSED
> >
> > General SMART Values:
> > Offline data collection status:  (0x84) Offline data collection activity
> >                                          was suspended by an
> > interrupting command from host.
> >                                          Auto Offline Data Collection: Enabled.
> > Self-test execution status:      (   0) The previous self-test routine completed
> >                                          without error or no self-test has ever
> >                                          been run.
> > Total time to complete Offline
> > data collection:                (20116) seconds.
> > Offline data collection
> > capabilities:                    (0x5b) SMART execute Offline immediate.
> >                                          Auto Offline data collection
> > on/off support.
> >                                          Suspend Offline collection upon new
> >                                          command.
> >                                          Offline surface scan supported.
> >                                          Self-test supported.
> >                                          No Conveyance Self-test supported.
> >                                          Selective Self-test supported.
> > SMART capabilities:            (0x0003) Saves SMART data before entering
> >                                          power-saving mode.
> >                                          Supports SMART auto save timer.
> > Error logging capability:        (0x01) Error logging supported.
> >                                          General Purpose Logging supported.
> > Short self-test routine
> > recommended polling time:        (   1) minutes.
> > Extended self-test routine
> > recommended polling time:        ( 336) minutes.
> > SCT capabilities:              (0x003d) SCT Status supported.
> >                                          SCT Error Recovery Control supported.
> >                                          SCT Feature Control supported.
> >                                          SCT Data Table supported.
>
> GOOD. This drive is suitable for RAID.
> >
> >
> > SCT Error Recovery Control:
> >             Read: Disabled
> >            Write: Disabled
>
> And BAD. Brad's script should switch this on. Check that it does!
> >
>
> >
> > # smartctl --xall /dev/sdc
> > smartctl 6.2 2013-07-26 r3841 [x86_64-linux-3.16.0-38-generic] (local build)
> > Copyright (C) 2002-13, Bruce Allen, Christian Franke, www.smartmontools.org
> >
> > === START OF INFORMATION SECTION ===
> > Model Family:     Western Digital Caviar Green (AF)
>
> I don't think green drives are suitable ... but it is a Caviar, which
> have a good rep ...
>
> > Device Model:     WDC WD20EARS-00MVWB0
> > Serial Number:    WD-WCAZA1597296
> > LU WWN Device Id: 5 0014ee 25a653961
> > Firmware Version: 51.0AB51
> > User Capacity:    2,000,398,934,016 bytes [2.00 TB]
> > Sector Size:      512 bytes logical/physical
> > Device is:        In smartctl database [for details use: -P show]
> > ATA Version is:   ATA8-ACS (minor revision not indicated)
> > SATA Version is:  SATA 2.6, 3.0 Gb/s
> > Local Time is:    Tue Jul 21 12:45:57 2020 PDT
> > SMART support is: Available - device has SMART capability.
> > SMART support is: Enabled
> > AAM feature is:   Disabled
> > APM feature is:   Unavailable
> > Rd look-ahead is: Enabled
> > Write cache is:   Enabled
> > ATA Security is:  Disabled, NOT FROZEN [SEC1]
> > Wt Cache Reorder: Enabled
> >
> > === START OF READ SMART DATA SECTION ===
> > SMART overall-health self-assessment test result: PASSED
> >
> > General SMART Values:
> > Offline data collection status:  (0x82) Offline data collection activity
> >                                          was completed without error.
> >                                          Auto Offline Data Collection: Enabled.
> > Self-test execution status:      (   0) The previous self-test routine completed
> >                                          without error or no self-test has ever
> >                                          been run.
> > Total time to complete Offline
> > data collection:                (38460) seconds.
> > Offline data collection
> > capabilities:                    (0x7b) SMART execute Offline immediate.
> >                                          Auto Offline data collection
> > on/off support.
> >                                          Suspend Offline collection upon new
> >                                          command.
> >                                          Offline surface scan supported.
> >                                          Self-test supported.
> >                                          Conveyance Self-test supported.
> >                                          Selective Self-test supported.
> > SMART capabilities:            (0x0003) Saves SMART data before entering
> >                                          power-saving mode.
> >                                          Supports SMART auto save timer.
> > Error logging capability:        (0x01) Error logging supported.
> >                                          General Purpose Logging supported.
> > Short self-test routine
> > recommended polling time:        (   2) minutes.
> > Extended self-test routine
> > recommended polling time:        ( 371) minutes.
> > Conveyance self-test routine
> > recommended polling time:        (   5) minutes.
> > SCT capabilities:              (0x3035) SCT Status supported.
> >                                          SCT Feature Control supported.
> >                                          SCT Data Table supported.
>
> No mention of Error Recovery ... BAAAADDDDD!!!
> >
> >
> > SCT Error Recovery Control command not supported
>
> BAAAAADDDDDD!!!!
>
> Greens aren't suitable - and this is sdc, the dodgy drive, so I suspect
> using it in a raid array has knackered it.
> >
> > # smartctl --xall /dev/sdd
> > smartctl 6.2 2013-07-26 r3841 [x86_64-linux-3.16.0-38-generic] (local build)
> > Copyright (C) 2002-13, Bruce Allen, Christian Franke, www.smartmontools.org
> >
> > === START OF INFORMATION SECTION ===
> > Device Model:     Hitachi HUA723020ALA641
> > Serial Number:    YFHK9JAA
> > LU WWN Device Id: 5 000cca 223d5f593
> > Firmware Version: MK7OA840
> > User Capacity:    2,000,398,934,016 bytes [2.00 TB]
> > Sector Size:      512 bytes logical/physical
> > Rotation Rate:    7200 rpm
> > Device is:        Not in smartctl database [for details use: -P showall]
> > ATA Version is:   ATA8-ACS T13/1699-D revision 4
> > SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 3.0 Gb/s)
> > Local Time is:    Tue Jul 21 12:47:13 2020 PDT
> > SMART support is: Available - device has SMART capability.
> > SMART support is: Enabled
> > AAM feature is:   Unavailable
> > APM feature is:   Disabled
> > Rd look-ahead is: Enabled
> > Write cache is:   Enabled
> > ATA Security is:  Disabled, NOT FROZEN [SEC1]
> > Wt Cache Reorder: Enabled
> >
> > === START OF READ SMART DATA SECTION ===
> > SMART overall-health self-assessment test result: PASSED
> >
> > General SMART Values:
> > Offline data collection status:  (0x84) Offline data collection activity
> >                                          was suspended by an
> > interrupting command from host.
> >                                          Auto Offline Data Collection: Enabled.
> > Self-test execution status:      (   0) The previous self-test routine completed
> >                                          without error or no self-test has ever
> >                                          been run.
> > Total time to complete Offline
> > data collection:                (19618) seconds.
> > Offline data collection
> > capabilities:                    (0x5b) SMART execute Offline immediate.
> >                                          Auto Offline data collection
> > on/off support.
> >                                          Suspend Offline collection upon new
> >                                          command.
> >                                          Offline surface scan supported.
> >                                          Self-test supported.
> >                                          No Conveyance Self-test supported.
> >                                          Selective Self-test supported.
> > SMART capabilities:            (0x0003) Saves SMART data before entering
> >                                          power-saving mode.
> >                                          Supports SMART auto save timer.
> > Error logging capability:        (0x01) Error logging supported.
> >                                          General Purpose Logging supported.
> > Short self-test routine
> > recommended polling time:        (   1) minutes.
> > Extended self-test routine
> > recommended polling time:        ( 327) minutes.
> > SCT capabilities:              (0x003d) SCT Status supported.
> >                                          SCT Error Recovery Control supported.
>
> Good...
>
> >                                          SCT Feature Control supported.
> >                                          SCT Data Table supported.
> >
> >
> > SCT Error Recovery Control:
> >             Read: Disabled
> >            Write: Disabled
>
> And bad, but at least it's got it ... as above make sure it's enabled.
> >
>
> >
> > # smartctl --xall /dev/sde
> > smartctl 6.2 2013-07-26 r3841 [x86_64-linux-3.16.0-38-generic] (local build)
> > Copyright (C) 2002-13, Bruce Allen, Christian Franke, www.smartmontools.org
> >
> > === START OF INFORMATION SECTION ===
> > Device Model:     Hitachi HUA723020ALA641
>
> Okay, I assume this is the same as the previous drive ...
>
> > Serial Number:    YFG7LWBA
> > LU WWN Device Id: 5 000cca 223c3757b
> > Firmware Version: MK7OA840
> > User Capacity:    2,000,398,934,016 bytes [2.00 TB]
> > Sector Size:      512 bytes logical/physical
> > Rotation Rate:    7200 rpm
> > Device is:        Not in smartctl database [for details use: -P showall]
> > ATA Version is:   ATA8-ACS T13/1699-D revision 4
> > SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 3.0 Gb/s)
> > Local Time is:    Tue Jul 21 12:47:56 2020 PDT
> > SMART support is: Available - device has SMART capability.
> > SMART support is: Enabled
> > AAM feature is:   Unavailable
> > APM feature is:   Disabled
> > Rd look-ahead is: Enabled
> > Write cache is:   Enabled
> > ATA Security is:  Disabled, NOT FROZEN [SEC1]
> > Wt Cache Reorder: Enabled
> >
>
> Okay, we'll assume sdc is dead. The first thing is to try to assemble
> the remaining disks without it. Boot from a rescue disk so you've got
> the latest and greatest available. And don't forget, if you get "device
> busy", you've probably got the remains of a previous assemble messing
> things up, so you need to do a --stop. Just DON'T do a --force, not yet.
>
> Next thing we need is the event count - I think that's mdadm --examine
> over each partition that makes the array.
>
> And make sure you've got a replacement for that Green. You NEED to get
> rid of it.
>
> Let's see how it goes ... if the array assembles fine with the rescue
> disk, just add your new disk and replace sdc, but make sure Brad's
> script has enabled ERC!
>
> Cheers,
> Wol
