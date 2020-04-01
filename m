Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3093319A50F
	for <lists+linux-raid@lfdr.de>; Wed,  1 Apr 2020 08:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbgDAGEK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Apr 2020 02:04:10 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40188 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731780AbgDAGEJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 1 Apr 2020 02:04:09 -0400
Received: by mail-vs1-f68.google.com with SMTP id w14so5875622vsf.7
        for <linux-raid@vger.kernel.org>; Tue, 31 Mar 2020 23:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iowni-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7ndgFvE9EumYUKhF62tR/xl5OnUQIYXgELaICQDSKs=;
        b=NLn51AeR72RmoJOxL2kJ70uXslF6cNC1S3MXHcwDmXnqfJi6S+uYveN8lz06fEncsj
         uq7FrYV6o/sk2x0JGq7q1F96R0UNE4Ht8WmNGPz4JD5dZkF7x4ZlAYXgEMUNDVSxz1ck
         4L4wA+J2zVT3D0nmKNySMGIy5UpsWylBOshECIpsXhN6PA4D5sSMjtKU0deh5y6CUUXa
         ejn7BkihiKfpVsRLvVXcRqkT1FxpYyJfP0Jjf4p7cE7NxlAd9gZxPK3DWGrnPuyN8Bq6
         b+G6I8QCBG/FOdBt9LftvORKcvUkVoEPcnzWiceLUKj8KOPPFnaMtV/J5jb/1aB7+9WW
         dq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7ndgFvE9EumYUKhF62tR/xl5OnUQIYXgELaICQDSKs=;
        b=FcCV4U5/VCaykcnJLfnR34ZkzGQ4ibovevaF1PpX2IMvHlKB8k/HbpbNVGGhc0Gm5n
         511ClH9uu3OhFMOWfeFrRw5fkmJvONNDva6raxxKYD1JUqfNLuRCELDFi+hVxUk079+G
         SbTvWh3MlPwYXG01SBjXAl6OtcaR6thlwbEFemhsBmcsz0NMP3fVI/FIby3LxkUl79j8
         PcyhEKtxyKwGhaFQhoH86Cz0Zb9cRUgxJhUyRLoULr8pLWvGobW+zzEpdx8tcQOL8Fnc
         DFFc4ahP5EB7HZl6aiy6smrJ9H5fpwYMplJhsUul3046t81GHnzp2pUYZt6HzH9vVfUv
         ssuQ==
X-Gm-Message-State: AGi0PuYa7hZGTObMtUoOI5R9w4fK+TfljcUk7AZmaas5ZNy5fFuH1cT5
        OUDvXpq6kmyCBNII9xMedwNZ7yxUoic8hHS8REDeaw==
X-Google-Smtp-Source: APiQypIVlHCB0+0WzMpCc4v81ufnFoWkL416Ij7pUg+xdlpO+aYjd66Br2R0nEVrCSrktP5SqSRhxEWufBNUn5WqqEE=
X-Received: by 2002:a67:6f84:: with SMTP id k126mr15741534vsc.112.1585721046975;
 Tue, 31 Mar 2020 23:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk> <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org> <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
 <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org> <CAB00BMj5kihqwOY-FOXv-tqG1b2reMnUVkdmB9uyNAeE7ESasw@mail.gmail.com>
 <061b695a-2406-fc00-dd6d-9198b85f3b1b@turmel.org>
In-Reply-To: <061b695a-2406-fc00-dd6d-9198b85f3b1b@turmel.org>
From:   Daniel Jones <dj@iowni.com>
Date:   Wed, 1 Apr 2020 00:03:55 -0600
Message-ID: <CAB00BMi3zhfVGpeE_AyyKiu1=MY2icYgfey0J3GeO8z9ZDAQbg@mail.gmail.com>
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Phil Turmel <philip@turmel.org>
Cc:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks Phil,

I'll read this a couple of times and try some commands (likely on an
overlay) tomorrow.

Regards,
DJ

On Tue, Mar 31, 2020 at 10:45 PM Phil Turmel <philip@turmel.org> wrote:
>
> Hi Daniel,
>
> On 3/31/20 11:39 PM, Daniel Jones wrote:
> > Hello Phil, et al.,
> >
> > Phil, after reading through your email I have some questions.
> >
> >> The array had bad block logging turned on.  We won't re-enable this
> >> mis-feature.  It is default, so you must turn it off in your --create.
> >
> > Am I able to turn off during --create?  The man page for mdadm on my
> > system (mdadm - v4.1 - 2018-10-01) suggests that --update=no-bbl can
> > be used for --assemble and --manage but doesn't list it for --create.
>
> Uhm, self compile and see what you get.  In these situations, relying on
> a potentially buggy system mdadm is not recommended.  But if still not
> available in create, fix it afterwards.  You definitely do not want this.
>
> >> However, the one we know appears to be the typical you'd get from
> >> one reshape after a modern default creation (262144).
> >
> >> You'll have to test four combinations: all at 261124 plus one at a
> >> time at 262144.
> >
> > I'm confused by the offsets. The one remaining superblock I have
> > reports "Data Offset : 261120 sectors".  Your email mentions 261124
> > and 262144. I don't understand how these three values are related?
>
> Yeah, doing math in one's head quickly sometimes yields a fail.  262144
> is 128MB in sectors.  Minus 1024 sectors (your chunk size) yields
> 261120.  /:
>
> > I think it is most likely that my one existing superblock with 261120
> > is one of the original three drives and not the fourth drive that was
> > added later.  (Based on the position in drive bay).
> >
> > So possible offsets (I'm still not clear on this) could be:
> >
> > a) all 261120
>
> Yes.
>
> > b) all 261124
>
> No.
>
> > c) all 262144
>
> No.
>
> > d) three at 261120, one at 262144
>
> Yes.
>
> > e) three at 261120, one at 261124
> > f) three at 261124, one at 261120
> > g) three at 261124, one at 262144
>
> No, no, and no.
>
> > h) three at 262144, one at 261120
>
> Extremely unlikely.  Not in my recommended combinations to check.
>
> > i) three at 262144, one at 261124
>
> No.
>
> > ( this ignores the combinations of not knowing which drive gets the
> > oddball offset )
> > ( this also ignores for now the offsets of 259076 and 260100 mentioned below )
> >
> >> 2) Member order for the other drives.  Three drives taken three at a
> >> time is six combinations.
> >>
> >> 3) Identity of the first drive kicked out. (Or do we know?)  If not
> >> known, there's four more combinations: whether to leave out or one of
> >> three left out.
> >
> > Can I make any tentative conclusions from this information:
> >
> >    Device Role : Active device 1
> >    Array State : .AAA ('A' == active, '.' == missing, 'R' == replacing)
>
> This device will always be listed as the 2nd member in all of your
> --create commands, and always with the offset of 261120 - 2048.
>
> > I know /dev/sde is the device that didn't initially respond to BIOS
> > and suspect it is the "missing" drive from my superblock.
>
> That eliminates the combinations of (3).  Section (2) becomes three
> drives taken two at a time (since you don't know which device role
> /dev/sde had).  But that is still six combinations.
>
> > I know that /dev/sdc is the drive with a working superblock that
> > reports itself as "Active device 1".
>
> Right, as above.
>
> > I don't know how mdadm counts things (starting at 0 or starting at 1,
> > left to right or right to left, including or excluding the missing
> > drive).
>
> Active devices start with zero.
>
> > Would it be reasonable for a first guess that:
> >
> > .AAA = sde sdd sdc sdb  (assuming the order is missing, active 0,
> > active 1, active 2) ?
>
> No.  Order is always active devices 0-3, with one of those replaced (in
> order) with "missing".
>
> > Procedure questions:
> >
> > If I understand all the above, attempted recovery is going to be along
> > the lines of:
> >
> > mdadm --create /dev/md0 --force --assume-clean --readonly
> > --data-offset=261120 --chunk=512K --level=5 --raid-devices=4 missing
> > /dev/sdd /dev/sdc /dev/sdb
> > fsck -n /dev/md0
>
> Yes, but with the order above, and with --data-offset=variable when
> mixing them.
>
> > Subject to:
> > Don't know if --force is desirable in this case?
>
> Not applicable to --create.
>
> > Might need to try different offsets from above.  Don't know how to set
> > offsets if they are different per drive.
>
> man page.
>
> > Should I start with guessing "missing" for 1 or should I start with all 4?
> > Might need to try all device orders.
> >
> >> Start by creating partitions on all devices, preferably at 2048 sectors.
> >> (Should be the default offered.)  Use data offsets 259076 and 260100
> >> instead of 261124 and 262144.
> >
> > If I understand, this is an alternative to recreating the whole-disk
> > mdadm containing one partition. Instead it would involve creating new
> > partition tables on each physical drive, creating one partition per
> > table, writing superblocks to the new /dev/sd[bcde]1 with offsets
> > adjusted by either 2044 or 2048 sectors, and then doing the fsck on
> > the assembled RAID.
>
> Yes, 2048.
>
> > I think the advantage proposed here is that it prevents this
> > "automated superblock overwrite" from happening again if/when I try
> > the motherboard upgrade, but the risk I'm not comfortable with yet is
> > going beyond "do the minimum to get it working again". Although it
> > isn't practical for me to do a dd full backup of these drives, if I
> > can get the array mounted again I can copy off the most important data
> > before doing a grander repartitioning.
>
> It's virtually impossible to correct at any time other than create, so
> do it now.  The "minimum" is a rather brutal situation.  Fix it right.
>
> > Can you advise on any of the above?
> >
> > Thanks,
> > DJ
> >
>
> Phil
