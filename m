Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B5814AABE
	for <lists+linux-raid@lfdr.de>; Mon, 27 Jan 2020 20:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgA0T4H (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Jan 2020 14:56:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55423 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgA0T4G (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 Jan 2020 14:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580154966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OauPd/AjOzTV/MYGhG0/6mggtNc/M8PvdmBRnwbsG4Q=;
        b=KbhX3YoClwWPaVlztsEDwf1BgqmyQQRgDzK7L9N8pjMlIv71hQxKDLq3cB4H3Fpn0DsmtD
        ENKaRqTGjJHunhZJJ2AIUrxbiSybf1NZBEPmvzndEEvR6IhqGlEqjCma1Fg5PYyD3Rblkq
        28enoz0KDw1CAGSn1g2++TzqbygIZ8o=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-Hk2jsgZnN3OGLisSvlS2kQ-1; Mon, 27 Jan 2020 14:56:04 -0500
X-MC-Unique: Hk2jsgZnN3OGLisSvlS2kQ-1
Received: by mail-il1-f199.google.com with SMTP id s9so8512401ilk.0
        for <linux-raid@vger.kernel.org>; Mon, 27 Jan 2020 11:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OauPd/AjOzTV/MYGhG0/6mggtNc/M8PvdmBRnwbsG4Q=;
        b=XUKKXRHbrM/uA7xGvI3kg+iNydpIXc7HdxPDQyhizZl9IlUfSYJDDUBZK5iEK8mDqP
         m03dJq/g/1LjEiK7DChJyx1vwrzeENN+k3saNvHybPVfgOElALmGDmsvM6hZidXrPraX
         bLIWCLfB/uOg8aBveSTanI3zz9AxLbNMX2YZrj57r6kfDBzY0f/RsVbUXgY5c/u8uwhg
         q/d4xxgWqaCjeKNpQCNyTiFIeKpnYRMf25rNBzjV8AeoLVZ/+nQHaOGgRNbrPW+Arv2c
         /lfJhA3ua6ECLAtR1zFP1nvF1CUIBZ+IDI8KYS44ifLhNFnXnLgNvspbp0mzTwHS7Q+2
         KJLw==
X-Gm-Message-State: APjAAAXIXNLyjI2vrs9LliBMkToi/noVOjD38eckNzSv/rb68bkNK17Z
        U5DGNOCbre8f29P11b0pvubv2GlAfD7XPdRCPdzuXKzpG8ZtULpTn7jEt1jMfioQZp1BLiaJRT0
        f3eWQaigLRQ8yPTMFfJGLdBwM14HT9OA0G53E0g==
X-Received: by 2002:a05:6602:235b:: with SMTP id r27mr13826831iot.51.1580154963826;
        Mon, 27 Jan 2020 11:56:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6bwq3I849XJlVOT+9PGjgBJH+rRo/KH+NiyVddPOBhLVpGOCnLqrUkZRBV0hJiii0F8+ojLoWAIrXPxBHC2A=
X-Received: by 2002:a05:6602:235b:: with SMTP id r27mr13826804iot.51.1580154963472;
 Mon, 27 Jan 2020 11:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20200127152619.GA3596@redhat> <CAPhsuW628WHm_Rifm9uMPeH+mwmeH121p85KbgvLt+SQTngW4A@mail.gmail.com>
In-Reply-To: <CAPhsuW628WHm_Rifm9uMPeH+mwmeH121p85KbgvLt+SQTngW4A@mail.gmail.com>
From:   David Jeffery <djeffery@redhat.com>
Date:   Mon, 27 Jan 2020 14:55:52 -0500
Message-ID: <CA+-xHTGJr5M9Ge1MCPPZWueM56Ap5=qcsG0KkddBMJOCAOWWpw@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: release pending accounting for an I/O only
 after write-behind is also finished
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jan 27, 2020 at 12:29 PM Song Liu <song@kernel.org> wrote:
>
> On Mon, Jan 27, 2020 at 7:26 AM David Jeffery <djeffery@redhat.com> wrote:
> >
> > When using RAID1 and write-behind, md can deadlock when errors occur. With
> > write-behind, r1bio structs can be accounted by raid1 as queued but not
> > counted as pending. The pending count is dropped when the original bio is
> > returned complete but write-behind for the r1bio may still be active.
> >
> > This breaks the accounting used in some conditions to know when the raid1
> > md device has reached an idle state. It can result in calls to
> > freeze_array deadlocking. freeze_array will never complete from a negative
> > "unqueued" value being calculated due to a queued count larger than the
> > pending count.
> >
> > To properly account for write-behind, move the call to allow_barrier from
> > call_bio_endio to raid_end_bio_io. When using write-behind, md can call
> > call_bio_endio before all write-behind I/O is complete. Using
> > raid_end_bio_io for the point to call allow_barrier will release the
> > pending count at a point where all I/O for an r1bio, even write-behind, is
> > done.
> >
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > ---
> >
> >  raid1.c |   13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> >
> > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > index 201fd8aec59a..0196a9d9f7e9 100644
> > --- a/drivers/md/raid1.c
> > +++ b/drivers/md/raid1.c
> > @@ -279,22 +279,17 @@ static void reschedule_retry(struct r1bio *r1_bio)
> >  static void call_bio_endio(struct r1bio *r1_bio)
> >  {
> >         struct bio *bio = r1_bio->master_bio;
> > -       struct r1conf *conf = r1_bio->mddev->private;
> >
> >         if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
> >                 bio->bi_status = BLK_STS_IOERR;
> >
> >         bio_endio(bio);
> > -       /*
> > -        * Wake up any possible resync thread that waits for the device
> > -        * to go idle.
> > -        */
> > -       allow_barrier(conf, r1_bio->sector);
>
> raid1_end_write_request() also calls call_bio_endio(). Do we need to fix
> that?

This basically is the problem the patch is fixing.  We don't want
allow_barrier() being called when call_bio_endio() is called directly
from raid1_end_write_request().  Write-behind can still be active here
so it was dropping the pending accounting too early.  We only want it
called when all I/O for the r1bio is complete, which shifting the
allow_barrier() call to raid_end_bio_io() does.

> Do we need to backport this to stable?

Pros:
It's a small patch
Fixes an ugly deadlock which hangs md if it happens.

Cons:
Affects a feature most users don't use
The bug appears to have existed for years with little notice

I consider it rather borderline to being stable-worthy.

> Thanks,
> Song
>

Regards,
David Jeffery

> >  }
> >
> >  static void raid_end_bio_io(struct r1bio *r1_bio)
> >  {
> >         struct bio *bio = r1_bio->master_bio;
> > +       struct r1conf *conf = r1_bio->mddev->private;
> >
> >         /* if nobody has done the final endio yet, do it now */
> >         if (!test_and_set_bit(R1BIO_Returned, &r1_bio->state)) {
> > @@ -305,6 +300,12 @@ static void raid_end_bio_io(struct r1bio *r1_bio)
> >
> >                 call_bio_endio(r1_bio);
> >         }
> > +       /*
> > +        * Wake up any possible resync thread that waits for the device
> > +        * to go idle.  All I/Os, even write-behind writes, are done.
> > +        */
> > +       allow_barrier(conf, r1_bio->sector);
> > +
> >         free_r1bio(r1_bio);
> >  }
> >
> >
>

