Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA5220109
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 01:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGNX1w (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jul 2020 19:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGNX1w (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jul 2020 19:27:52 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE561C061755
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 16:27:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x9so489168ljc.5
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYBI4dm7Kp2+xeC9dWugzzFTj5Ea+ga0vMr4wGA0e9s=;
        b=NfXMmSPs7077AxS+PkqidHKhw9bjBn1eln1WzdovaU+5/aVwzUdJTje292hlCsF3tm
         IZgvmrikkgLgbBZoQnPh47ogBOFYFdTMDgM4pfTdgJu9h+tfSkun+HUvHNB1ANHmbBqo
         nuUJisHyV0cxStyDPxl4i29fHyDj78u2pxZtEUDpZ7mj/EjHt2QOqWY+ki5SInRDtsuO
         PmyZT1WygrmeyWTBPcoXQDjGd+HFR2MsPyjiYT4EQg07ouzcI7ehvLCXQtawU0WH3+nI
         L9NBSFfpFdTUDNTJ83lHIsMw9IvxtIldyOoNEuRA9uOE5khJzuRE3EEi5d1bUlQR+BYx
         eWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYBI4dm7Kp2+xeC9dWugzzFTj5Ea+ga0vMr4wGA0e9s=;
        b=AV0IH8Mm5PJKRXrezxJAhTp/tIsN5PD5ywuY0B4CsAXAjG6yPYA7pijG+0SjT9zJwS
         u+cUtaw55d8AFEXTVj3x2ul437nco1OrdXjWkXiUNGGeKlb3PypOemeyF200jY2R66od
         AR2yqJGhe5FP88OJNfX4RcSNHk0fLkMbCQzKBl37KAJf5nmbwHkdIYHi5lK5dDb2y78a
         t7DQUezDhTU7D5I7f3KrjHKPs43s19p4ksO7kSVyF7HEXzOZLACPmO2FsEeFPgbnHURP
         1YTjVrjxw0OY+8XKHslAXm0tqyp3TL0WJdbCU2EiSpfHcYBffHb4m2S4pKfYyiRfZtFQ
         wvcw==
X-Gm-Message-State: AOAM533Fohkm9gJT0cM2V3ZGhx2MUx1XBtVsnmBLL1lkYoxcq7HyJHMX
        3tO8m4VlDooFSqzE7h95jOvzrgk3Kz++TIlHXaz5qw==
X-Google-Smtp-Source: ABdhPJyF4Pm9sxEZg22VAgwAyqqIGSJr8U2PCo8Di5bw6W53j/5s88g/evmiLxx2XJ+AtwnuniDsjFMmKHc0feilaEg=
X-Received: by 2002:a2e:8890:: with SMTP id k16mr3152110lji.113.1594769270362;
 Tue, 14 Jul 2020 16:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <b551920e-ddad-c627-d75a-e99d32247b6d@gmail.com> <0b857b5f-20aa-871d-a22d-43d26ad64764@youngman.org.uk>
In-Reply-To: <0b857b5f-20aa-871d-a22d-43d26ad64764@youngman.org.uk>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Tue, 14 Jul 2020 18:27:39 -0500
Message-ID: <CAAMCDec22wshoG8eb9aM4su-EBdJRbh_LyVtaskR9FbYc4f=gw@mail.gmail.com>
Subject: Re: Reshape using drives not partitions, RAID gone after reboot
To:     antlists <antlists@youngman.org.uk>
Cc:     Adam Barnett <adamtravisbarnett@gmail.com>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Did you create the partition before you added the disk to mdadm or
after?  If after was it a dos or a gpt?  Dos should have only cleared
the first 512byte block.  If gpt it will have written to the first
block and to at least 1 more location on the disk, possibly causing
data loss.

If before then you at least need to get rid of the partition table
completely.   Having a partition on a device will often cause a number
of things to ignore the whole disk.  I have debugged "lost" pv's where
the partition effectively "blocked" lvm from even looking at the
entire device that the pv was one.

If it is a dos partition table then:
save a backup of each disk first (always a good idea, you can dd it
back if you screwed up so long as you carefully create the backups and
name them properly).
dd if=/dev/sdx of=/root/sdxbackup.img bs=512 count=1
then clear the partition table space, rebooting is probably the
easiest way to clear out the mappings, it can be done without
rebooting but I have to do it trial and error to figure out the exact
order and commands.
dd if=/dev/zero of=/dev/sdX bs=512 count=1

On Tue, Jul 14, 2020 at 6:11 PM antlists <antlists@youngman.org.uk> wrote:
>
> On 14/07/2020 20:50, Adam Barnett wrote:
> > Forcing the assembly does not work:
> >
> > $ sudo mdadm /dev/md1 --assemble --force /dev/sd[ijmop]1 /dev/sd[kln]
> > mdadm: /dev/sdi1 is busy - skipping
> > mdadm: /dev/sdj1 is busy - skipping
> > mdadm: /dev/sdm1 is busy - skipping
> > mdadm: /dev/sdo1 is busy - skipping
> > mdadm: /dev/sdp1 is busy - skipping
> > mdadm: Cannot assemble mbr metadata on /dev/sdk
> > mdadm: /dev/sdk has no superblock - assembly aborted
>
> Did you do an "mdadm --stop /dev/md1" before trying that? That's a
> classic error from an array that's previously been partially assembled
> and failed ...
>
> The other thing I'd do is make sure there aren't any other unepected
> partially assembled arrays. I doubt it applies here, but I have come
> across mirrors that get broken in half and you get two failed arrays
> instead of one working one ...
>
> Cheers,
> Wol
