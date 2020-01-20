Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAA11433EE
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jan 2020 23:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgATWax (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jan 2020 17:30:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41331 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATWax (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 Jan 2020 17:30:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so1073588qtk.8
        for <linux-raid@vger.kernel.org>; Mon, 20 Jan 2020 14:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Vrcg/FOdYbQ2+B6h9Dv+4Ty/iwP+WfFBGEbajMZ9ia4=;
        b=nBoWZRA0rn+7Bar949kfVKukeiQ7Vbfva4rBAMzzojP9q3rS7lYnlNiAragJCV1qTx
         JNvYssGIHibqlDz20znR20+XQCEdsNnnyuaD19XzagM2EqQB+9hNnvqi7qsqY7XVvHbl
         skUeSfRey7Vb1ig1vxBE+b67o0WPWGpgxLQJfY5yl1KpxRxFs2TnKBFvWDumEhOacmy7
         9uBKBxBtvYiZeYM0K8VK7fyQDOi4XiBLmMwPzVCYkUpa8Lm6OgNdgNoY0CHYS+DNOnp5
         6+KsHD7h8+j4IO1tUc6i6VJ3yCa2hlHHaH9qcxGFvvAK6QWYLI0VnAxgRQl95E3hTlHs
         TA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Vrcg/FOdYbQ2+B6h9Dv+4Ty/iwP+WfFBGEbajMZ9ia4=;
        b=e3jmm+51BqrfThoNWGlsLGPvP41gHycvrcJzICGuD5RLikiF1vSlLmVrEPpkrquTpx
         fOimmrB+U9e5el471EYnsDcAFcuA6Wm50gY4U2SYWtdPxjICRDZlMiCFPAhvOBapivM/
         QNuFEwHhfU5/RrGJDvJTWP3wNFbzH54zDGzHyrnVuj+yXt+2FdymxWrMrbPtZaFO8Cv1
         ao3Olq5q8YbmqL0Juy6T++/K6ZaR5eEg3luC4JNSQBav4ZHGBKPSMnhyWBCaA4K82dX+
         Lp5f5UeYea3aHx0gNv+BszQdQiu70DGjRBGBg7IA4htIX1FhQwoRnwvzpXAD6g57LGFT
         j2rw==
X-Gm-Message-State: APjAAAWmQ27W2tnyDFqI6enGV0zCWzE3f1DKWHvxNAZ3NRGY+Bq1D2BT
        iAEhgk4athfewk7AOkR8FhuqCG9eqQzrC+AOzIU=
X-Google-Smtp-Source: APXvYqwKTySS+oeu6MfnneagPeTk8ZC5mntUuPUYEw6kcmt/yFDVkOTvsCy0PyAZO4n3Tam2QKKfOWeE4gmXXa8TdSI=
X-Received: by 2002:ac8:4689:: with SMTP id g9mr1588478qto.121.1579559452300;
 Mon, 20 Jan 2020 14:30:52 -0800 (PST)
MIME-Version: 1.0
References: <CADSg1Jh1i+OPq0_hWOvHxK0xroUbn_w0_ZjxjwcnrbSsBXGY5A@mail.gmail.com>
 <5E25876A.1030004@youngman.org.uk>
In-Reply-To: <5E25876A.1030004@youngman.org.uk>
Reply-To: andrewbass@gmail.com
From:   "Andrey ``Bass'' Shcheglov" <andrewbass@gmail.com>
Date:   Tue, 21 Jan 2020 01:30:41 +0300
Message-ID: <CADSg1Jj3XmD_RmSedn3AT9uCXbHQGa6ATBK1UP33onS8Vi=60g@mail.gmail.com>
Subject: Re: Repairing a RAID1 with non-zero mismatch_cnt
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Many thanks for your response, Wol.

On Mon, 20 Jan 2020 at 13:56, Wols Lists <antlists@youngman.org.uk> wrote:
>
> > The question is: is it possible to assemble an array in a read-only mode,
> > so that the underlying block device is never written to,
> > the metadata in the superblock remains intact and the event count is
> > not incremented?
> >
> > My intention is to avoid the resync when my original /dev/md0 is
> > reassembled from /dev/sda1 and /dev/sdb1.
> >
> Then how (assuming one drive is corrupt) are you going to re-assemble
> the array without forcing a resync on that drive?

Well, of course I will resync eventually, but

1. My original intention was to find the files residing on top of
corrupted blocks and then restore (rewrite) them using the data
recovered from the intact replica.
2. From my experience, an MD array may start re-syncing automatically
at system boot, and this is what I'd rather avoid -- I want to proceed
through all the steps manually, fully understanding what I is being
done.

> >
> > If you have any other recommendations on how to interactively repair
> > the array (I want to be able to peek at the data being synced),
> > I'd appreciate you sharing them.
> >
> My inclination (no warranty included!) would be to shut down the array,
> then assemble it with "/dev/sda1 missing" and --force if necessary. fsck
> that, then rinse and repeat with the second drive.
>
> Assuming neither drive has problems, you should then be able to assemble
> --assume-clean, which will prevent the sync, otherwise you'll have to
> just re-add the duff drive and let it resync.
>
> (In other words, why worry about the resync, because if you find the
> problem then you're going to have to resync to fix it, anyway.)

Thanks, will try that.

Does it make any sense to backup the superblocks of the replicas (e.
g.: using `dd`)?
And if so, then what precautions should be made before restoring the
superblock from a backup?

> Hint - look at dm-integrity. I believe you can put the integrity
> information elsewhere (if you've got a spare bit of disk space) so this
> issue won't arise again. It's new with raid, but apparently works fine
> with raid-1. Don't try it with the higher raids - 5 or 6 - yet.

Thanks, I'll give it a try.

Regards,
Andrey.
