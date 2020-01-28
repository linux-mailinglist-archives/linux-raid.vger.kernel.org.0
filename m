Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1ED914C09F
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jan 2020 20:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgA1TIh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jan 2020 14:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgA1TIh (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Jan 2020 14:08:37 -0500
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A86820CC7
        for <linux-raid@vger.kernel.org>; Tue, 28 Jan 2020 19:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580238516;
        bh=jkFTx6B6oy02ecRn0cK1SY6RFYszqK7jZh+SDaYZ2JU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vpPsuibGukQ2L4KSXdJvMO1snuMQH+L2Abu3QbqVpYxjcJVvBMw2p5b3pjtlEOqVx
         +oKGeUWwGn5Nb+p+9UJssZekqzFI1fippBfrxzV0BBlQ9VhWeoID3GQJMk5Qu94R0x
         9WXebQ77B0Kdh6e9EHKWzZ3jMcH5uEbqd7We/puo=
Received: by mail-lf1-f43.google.com with SMTP id l18so9978125lfc.1
        for <linux-raid@vger.kernel.org>; Tue, 28 Jan 2020 11:08:36 -0800 (PST)
X-Gm-Message-State: APjAAAVF01NhjQr/QSBZZQ0VL2YHRGJxzm7dMC00t5YSY7OPPbY9Sy7e
        LNb8c0R5VmOLOlj2Fp/hNCclhBHu2WIN+WVd/no=
X-Google-Smtp-Source: APXvYqxkoFvAvFGG/L0wG2qy2WdDDFPCPe6VZwyi28MdEWm1NEvSLcn1o4q53BKdSIPt7ckm60wUaBt65KLOr+874Do=
X-Received: by 2002:ac2:5612:: with SMTP id v18mr3004998lfd.172.1580238514523;
 Tue, 28 Jan 2020 11:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20200127152619.GA3596@redhat> <CAPhsuW628WHm_Rifm9uMPeH+mwmeH121p85KbgvLt+SQTngW4A@mail.gmail.com>
 <CA+-xHTGJr5M9Ge1MCPPZWueM56Ap5=qcsG0KkddBMJOCAOWWpw@mail.gmail.com>
In-Reply-To: <CA+-xHTGJr5M9Ge1MCPPZWueM56Ap5=qcsG0KkddBMJOCAOWWpw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Jan 2020 11:08:23 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7XJzdWxkLDbRG9VS3BJB6qaAoEC_sDOtMRaw1ZvMj1dw@mail.gmail.com>
Message-ID: <CAPhsuW7XJzdWxkLDbRG9VS3BJB6qaAoEC_sDOtMRaw1ZvMj1dw@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: release pending accounting for an I/O only
 after write-behind is also finished
To:     David Jeffery <djeffery@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jan 27, 2020 at 11:56 AM David Jeffery <djeffery@redhat.com> wrote:
>
> On Mon, Jan 27, 2020 at 12:29 PM Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Jan 27, 2020 at 7:26 AM David Jeffery <djeffery@redhat.com> wrote:
> > >
> > > When using RAID1 and write-behind, md can deadlock when errors occur. With
> > > write-behind, r1bio structs can be accounted by raid1 as queued but not
> > > counted as pending. The pending count is dropped when the original bio is
> > > returned complete but write-behind for the r1bio may still be active.
> > >
> > > This breaks the accounting used in some conditions to know when the raid1
> > > md device has reached an idle state. It can result in calls to
> > > freeze_array deadlocking. freeze_array will never complete from a negative
> > > "unqueued" value being calculated due to a queued count larger than the
> > > pending count.
> > >
> > > To properly account for write-behind, move the call to allow_barrier from
> > > call_bio_endio to raid_end_bio_io. When using write-behind, md can call
> > > call_bio_endio before all write-behind I/O is complete. Using
> > > raid_end_bio_io for the point to call allow_barrier will release the
> > > pending count at a point where all I/O for an r1bio, even write-behind, is
> > > done.
> > >
> > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > ---
> > >
> > >  raid1.c |   13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > >
> > > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > > index 201fd8aec59a..0196a9d9f7e9 100644
> > > --- a/drivers/md/raid1.c
> > > +++ b/drivers/md/raid1.c
> > > @@ -279,22 +279,17 @@ static void reschedule_retry(struct r1bio *r1_bio)
> > >  static void call_bio_endio(struct r1bio *r1_bio)
> > >  {
> > >         struct bio *bio = r1_bio->master_bio;
> > > -       struct r1conf *conf = r1_bio->mddev->private;
> > >
> > >         if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
> > >                 bio->bi_status = BLK_STS_IOERR;
> > >
> > >         bio_endio(bio);
> > > -       /*
> > > -        * Wake up any possible resync thread that waits for the device
> > > -        * to go idle.
> > > -        */
> > > -       allow_barrier(conf, r1_bio->sector);
> >
> > raid1_end_write_request() also calls call_bio_endio(). Do we need to fix
> > that?
>
> This basically is the problem the patch is fixing.  We don't want
> allow_barrier() being called when call_bio_endio() is called directly
> from raid1_end_write_request().  Write-behind can still be active here
> so it was dropping the pending accounting too early.  We only want it
> called when all I/O for the r1bio is complete, which shifting the
> allow_barrier() call to raid_end_bio_io() does.

Thanks for the explanation. This looks good to me. I will process it
after the merge window.

I will also re-evaluate whether we need it for stable.

Thanks again,
Song
