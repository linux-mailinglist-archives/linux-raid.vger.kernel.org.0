Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E865B1C9FC0
	for <lists+linux-raid@lfdr.de>; Fri,  8 May 2020 02:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgEHAnk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 May 2020 20:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEHAnk (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 7 May 2020 20:43:40 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E8A20663
        for <linux-raid@vger.kernel.org>; Fri,  8 May 2020 00:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588898619;
        bh=KGWsMbIkCVsXqRst/xqS7uhtr68Vh9pzPo5pCHnvfGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AglK3Mp1Iklo2cSSPtANAAWm735XU9WboIN2lNOS5VEMtzB3PklmqdQ2IvdgzfLtO
         AAxkHoa2s95C16pula1Ki5/6u8qerpO3SaDAaJZgVL+5r3V7PUq3ZQNrG+NaMKkFoL
         lyMcgg1/I1QaAyX8sLYiZ5SqRwXtKscs3DHrJ3UE=
Received: by mail-lf1-f54.google.com with SMTP id j14so52224lfg.9
        for <linux-raid@vger.kernel.org>; Thu, 07 May 2020 17:43:39 -0700 (PDT)
X-Gm-Message-State: AOAM530A5l8GF6Hhm8k5hGtLahiVL1zZRQIayJkHAD7yrWBLutU3qdRv
        T7LpyGopYRVHGV0mPQ6SkL9NkmazfcxEQByutXM=
X-Google-Smtp-Source: ABdhPJxkdw19GmfMM+vSwrN2TO/ZS+fc1a6BYKz9/G1+87+It4WbS1vyCSAHUpgyrQDmPgxsIdgestvcGVYlRdiNa9g=
X-Received: by 2002:ac2:4d91:: with SMTP id g17mr99880lfe.162.1588898617305;
 Thu, 07 May 2020 17:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200127152619.GA3596@redhat> <CAPhsuW628WHm_Rifm9uMPeH+mwmeH121p85KbgvLt+SQTngW4A@mail.gmail.com>
 <CA+-xHTGJr5M9Ge1MCPPZWueM56Ap5=qcsG0KkddBMJOCAOWWpw@mail.gmail.com>
 <CAPhsuW7XJzdWxkLDbRG9VS3BJB6qaAoEC_sDOtMRaw1ZvMj1dw@mail.gmail.com> <bcc52c3e-0865-709b-fc4d-7ca59d10bf9d@redhat.com>
In-Reply-To: <bcc52c3e-0865-709b-fc4d-7ca59d10bf9d@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 May 2020 17:43:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5SMkstYK5OKm_C_9xE9o1SBT3AAKX9W4JAZG0pDv7OLQ@mail.gmail.com>
Message-ID: <CAPhsuW5SMkstYK5OKm_C_9xE9o1SBT3AAKX9W4JAZG0pDv7OLQ@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: release pending accounting for an I/O only
 after write-behind is also finished
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     David Jeffery <djeffery@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Apr 23, 2020 at 5:38 AM Nigel Croxon <ncroxon@redhat.com> wrote:
>
>
> On 1/28/20 2:08 PM, Song Liu wrote:
> > On Mon, Jan 27, 2020 at 11:56 AM David Jeffery <djeffery@redhat.com> wrote:
> >> On Mon, Jan 27, 2020 at 12:29 PM Song Liu <song@kernel.org> wrote:
> >>> On Mon, Jan 27, 2020 at 7:26 AM David Jeffery <djeffery@redhat.com> wrote:
> >>>> When using RAID1 and write-behind, md can deadlock when errors occur. With
> >>>> write-behind, r1bio structs can be accounted by raid1 as queued but not
> >>>> counted as pending. The pending count is dropped when the original bio is
> >>>> returned complete but write-behind for the r1bio may still be active.
> >>>>
> >>>> This breaks the accounting used in some conditions to know when the raid1
> >>>> md device has reached an idle state. It can result in calls to
> >>>> freeze_array deadlocking. freeze_array will never complete from a negative
> >>>> "unqueued" value being calculated due to a queued count larger than the
> >>>> pending count.
> >>>>
> >>>> To properly account for write-behind, move the call to allow_barrier from
> >>>> call_bio_endio to raid_end_bio_io. When using write-behind, md can call
> >>>> call_bio_endio before all write-behind I/O is complete. Using
> >>>> raid_end_bio_io for the point to call allow_barrier will release the
> >>>> pending count at a point where all I/O for an r1bio, even write-behind, is
> >>>> done.
> >>>>
> >>>> Signed-off-by: David Jeffery <djeffery@redhat.com>
> >>>> ---
> >>>>
> >>>>   raid1.c |   13 +++++++------
> >>>>   1 file changed, 7 insertions(+), 6 deletions(-)
> >>>>
> >>>>
> >>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >>>> index 201fd8aec59a..0196a9d9f7e9 100644
> >>>> --- a/drivers/md/raid1.c
> >>>> +++ b/drivers/md/raid1.c
> >>>> @@ -279,22 +279,17 @@ static void reschedule_retry(struct r1bio *r1_bio)
> >>>>   static void call_bio_endio(struct r1bio *r1_bio)
> >>>>   {
> >>>>          struct bio *bio = r1_bio->master_bio;
> >>>> -       struct r1conf *conf = r1_bio->mddev->private;
> >>>>
> >>>>          if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
> >>>>                  bio->bi_status = BLK_STS_IOERR;
> >>>>
> >>>>          bio_endio(bio);
> >>>> -       /*
> >>>> -        * Wake up any possible resync thread that waits for the device
> >>>> -        * to go idle.
> >>>> -        */
> >>>> -       allow_barrier(conf, r1_bio->sector);
> >>> raid1_end_write_request() also calls call_bio_endio(). Do we need to fix
> >>> that?
> >> This basically is the problem the patch is fixing.  We don't want
> >> allow_barrier() being called when call_bio_endio() is called directly
> >> from raid1_end_write_request().  Write-behind can still be active here
> >> so it was dropping the pending accounting too early.  We only want it
> >> called when all I/O for the r1bio is complete, which shifting the
> >> allow_barrier() call to raid_end_bio_io() does.
> > Thanks for the explanation. This looks good to me. I will process it
> > after the merge window.
> >
> > I will also re-evaluate whether we need it for stable.
> >
> > Thanks again,
> > Song
> >
> Hello Song,
>
> Did you pull in this patch after the merge window?
>
> I don't see it in your tree.

I am really sorry I missed this one.

Just applied it to md-next.

Thanks,
Song
