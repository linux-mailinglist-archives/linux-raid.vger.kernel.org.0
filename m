Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE82314A8EC
	for <lists+linux-raid@lfdr.de>; Mon, 27 Jan 2020 18:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgA0R3Y (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Jan 2020 12:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgA0R3Y (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 Jan 2020 12:29:24 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E370F207FD
        for <linux-raid@vger.kernel.org>; Mon, 27 Jan 2020 17:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580146163;
        bh=li025l6RoCGLmju5RAobe1fe5yBaHeGYZDa/oF6WHAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oLOSRJdB1pprP5+RWn+sb5uwbmzlrtg7p/mTRNbKtqg3AdkPbzaDsiQP+8H6hm1mH
         Bp/iVGPe+TGdvzQ77iia6z70Yjyr8CB8bjq67JVf4xw+K68LEuj9VUfznmnTr0jjf2
         v6KefN8VDopn5m/U8MHgr9Hqx7lUAUbjTpEaIe2M=
Received: by mail-lf1-f51.google.com with SMTP id c23so6807957lfi.7
        for <linux-raid@vger.kernel.org>; Mon, 27 Jan 2020 09:29:22 -0800 (PST)
X-Gm-Message-State: APjAAAWflNicIB9BUZaWMdk20e2mzXP1c+gdSSJjJ+Ip8WSFC+e3MR7Y
        ZEvJ9FAh6ZhwiomAOeY/bQ+0elTqoUtwsWPEWtI=
X-Google-Smtp-Source: APXvYqz70HHvI7u+8msA9CWoqbzc/IbW1yE7QkseSYziy7m/tOjwQ9NpcqrBR7V29iECmlJVVUMixf998dQ+CTIo6lg=
X-Received: by 2002:ac2:5612:: with SMTP id v18mr7966802lfd.172.1580146161020;
 Mon, 27 Jan 2020 09:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20200127152619.GA3596@redhat>
In-Reply-To: <20200127152619.GA3596@redhat>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Jan 2020 09:29:10 -0800
X-Gmail-Original-Message-ID: <CAPhsuW628WHm_Rifm9uMPeH+mwmeH121p85KbgvLt+SQTngW4A@mail.gmail.com>
Message-ID: <CAPhsuW628WHm_Rifm9uMPeH+mwmeH121p85KbgvLt+SQTngW4A@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: release pending accounting for an I/O only
 after write-behind is also finished
To:     David Jeffery <djeffery@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jan 27, 2020 at 7:26 AM David Jeffery <djeffery@redhat.com> wrote:
>
> When using RAID1 and write-behind, md can deadlock when errors occur. With
> write-behind, r1bio structs can be accounted by raid1 as queued but not
> counted as pending. The pending count is dropped when the original bio is
> returned complete but write-behind for the r1bio may still be active.
>
> This breaks the accounting used in some conditions to know when the raid1
> md device has reached an idle state. It can result in calls to
> freeze_array deadlocking. freeze_array will never complete from a negative
> "unqueued" value being calculated due to a queued count larger than the
> pending count.
>
> To properly account for write-behind, move the call to allow_barrier from
> call_bio_endio to raid_end_bio_io. When using write-behind, md can call
> call_bio_endio before all write-behind I/O is complete. Using
> raid_end_bio_io for the point to call allow_barrier will release the
> pending count at a point where all I/O for an r1bio, even write-behind, is
> done.
>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>
>  raid1.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 201fd8aec59a..0196a9d9f7e9 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -279,22 +279,17 @@ static void reschedule_retry(struct r1bio *r1_bio)
>  static void call_bio_endio(struct r1bio *r1_bio)
>  {
>         struct bio *bio = r1_bio->master_bio;
> -       struct r1conf *conf = r1_bio->mddev->private;
>
>         if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
>                 bio->bi_status = BLK_STS_IOERR;
>
>         bio_endio(bio);
> -       /*
> -        * Wake up any possible resync thread that waits for the device
> -        * to go idle.
> -        */
> -       allow_barrier(conf, r1_bio->sector);

raid1_end_write_request() also calls call_bio_endio(). Do we need to fix
that?

Do we need to backport this to stable?

Thanks,
Song

>  }
>
>  static void raid_end_bio_io(struct r1bio *r1_bio)
>  {
>         struct bio *bio = r1_bio->master_bio;
> +       struct r1conf *conf = r1_bio->mddev->private;
>
>         /* if nobody has done the final endio yet, do it now */
>         if (!test_and_set_bit(R1BIO_Returned, &r1_bio->state)) {
> @@ -305,6 +300,12 @@ static void raid_end_bio_io(struct r1bio *r1_bio)
>
>                 call_bio_endio(r1_bio);
>         }
> +       /*
> +        * Wake up any possible resync thread that waits for the device
> +        * to go idle.  All I/Os, even write-behind writes, are done.
> +        */
> +       allow_barrier(conf, r1_bio->sector);
> +
>         free_r1bio(r1_bio);
>  }
>
>
