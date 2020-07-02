Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA488211BFC
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 08:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgGBGao (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 02:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbgGBGao (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 02:30:44 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6203C20874
        for <linux-raid@vger.kernel.org>; Thu,  2 Jul 2020 06:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593671443;
        bh=1RehCHNrb59Lz18C2/pL8xMfuWQ4i8Irciv+r3b/ZRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qwK0A+SJ2PGzjN16NOpspV+mtBJQ5R12mpO/5IhaxBwAIqJo8YVeO920bUy0tuiwn
         WNMr8eALN2B1Du2NpEg+B/DiW9iYmcI31Ll99r9LCi9Mu+udXEywmPxKgIywyZsnZr
         nfAlDbpB+UoRglVlZRBHCAggDJOlHNzQkr2qZPbU=
Received: by mail-lj1-f176.google.com with SMTP id n23so30330224ljh.7
        for <linux-raid@vger.kernel.org>; Wed, 01 Jul 2020 23:30:43 -0700 (PDT)
X-Gm-Message-State: AOAM531ZJXoVMZD/IGwIXxNXD/BOJzCjDzy2Qbz+41Y56TZYJIwO8EJ4
        J95vX0GEmDcTWPXv1v51mMM04syv6qLhYXUdquo=
X-Google-Smtp-Source: ABdhPJwQ2hAkuxA5CLIaxOvcMRCdKkJFsqHG/BkHETCNt7hn+Z/DIyNqH5IHzSU/dleWLHfdHXFOYx4ZLI8P6XPTn1Y=
X-Received: by 2002:a2e:88c6:: with SMTP id a6mr11285377ljk.27.1593671441760;
 Wed, 01 Jul 2020 23:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200601161256.27718-1-artur.paszkiewicz@intel.com> <d09aefa9-00ed-ef94-f5c4-50be91828170@cloud.ionos.com>
In-Reply-To: <d09aefa9-00ed-ef94-f5c4-50be91828170@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 1 Jul 2020 23:30:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Q5TuOVepEJ8u3R6f8e34K24Bct1tLF_Cz=TstsY3JHg@mail.gmail.com>
Message-ID: <CAPhsuW6Q5TuOVepEJ8u3R6f8e34K24Bct1tLF_Cz=TstsY3JHg@mail.gmail.com>
Subject: Re: [PATCH] md: improve io stats accounting
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jun 8, 2020 at 7:37 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> On 6/1/20 6:12 PM, Artur Paszkiewicz wrote:
> > Use generic io accounting functions to manage io stats. There was an
> > attempt to do this earlier in commit 18c0b223cf990172 ("md: use generic
> > io stats accounting functions to simplify io stat accounting"), but it
> > did not include a call to generic_end_io_acct() and caused issues with
> > tracking in-flight IOs, so it was later removed in commit
> > 74672d069b298b03 ("md: fix md io stats accounting broken").
> >
> > This patch attempts to fix this by using both generic_start_io_acct()
> > and generic_end_io_acct(). To make it possible, in md_make_request() a
> > bio is cloned with additional data - struct md_io, which includes the io
> > start_time. A new bioset is introduced for this purpose. We call
> > generic_start_io_acct() and pass the clone instead of the original to
> > md_handle_request(). When it completes, we call generic_end_io_acct()
> > and complete the original bio.
> >
> > This adds correct statistics about in-flight IOs and IO processing time,
> > interpreted e.g. in iostat as await, svctm, aqu-sz and %util.
> >
> > It also fixes a situation where too many IOs where reported if a bio was
> > re-submitted to the mddev, because io accounting is now performed only
> > on newly arriving bios.
> >
> > Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> > ---
> >   drivers/md/md.c | 65 +++++++++++++++++++++++++++++++++++++++----------
> >   drivers/md/md.h |  1 +
> >   2 files changed, 53 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index f567f536b529..5a9f167ef5b9 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -463,12 +463,32 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
> >   }
> >   EXPORT_SYMBOL(md_handle_request);
> >
> > +struct md_io {
> > +     struct mddev *mddev;
> > +     struct bio *orig_bio;
> > +     unsigned long start_time;
> > +     struct bio orig_bio_clone;
> > +};
> > +
> > +static void md_end_request(struct bio *bio)
> > +{
> > +     struct md_io *md_io = bio->bi_private;
> > +     struct mddev *mddev = md_io->mddev;
> > +     struct bio *orig_bio = md_io->orig_bio;
> > +
> > +     orig_bio->bi_status = bio->bi_status;
> > +
> > +     generic_end_io_acct(mddev->queue, bio_op(orig_bio),
> > +                         &mddev->gendisk->part0, md_io->start_time);
>
> [...]
>
> > +             generic_start_io_acct(mddev->queue, bio_op(bio),
> > +                                   bio_sectors(bio), &mddev->gendisk->part0);
> > +     }
> > +
>
> Now, you need to switch to call bio_{start,end}_io_acct instead of
> generic_{start,end}_io_acct after the changes from Christoph.

Thanks Guoqing!

Hi Artur,

Please rebase your change on top of md-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=md-next

Also, please check the .patch file with scripts/checkpatch.pl.

Thanks,
Song
