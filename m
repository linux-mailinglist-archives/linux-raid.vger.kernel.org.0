Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8954229067
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 08:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgGVGSe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 02:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgGVGSc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Jul 2020 02:18:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6567AC061794
        for <linux-raid@vger.kernel.org>; Tue, 21 Jul 2020 23:18:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so1195682ljj.10
        for <linux-raid@vger.kernel.org>; Tue, 21 Jul 2020 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XqaBe6tOxz6/WE0sIMF3DTrj19IRsfWxni5CCd6yvyI=;
        b=iQCAr5pEakC0gnLBmv0kWPceF2IZexXhlhdCTLf84DZ6ATa4L2sR7n0sUAALzDBY+K
         oMLlKk/2N/SYZoXyaCW3fSNrmjfhxldX8CICmEiJpaqjhkk/7edsb9FyvskdzkIG1L6i
         0d8KFfgdAcr3LOCKgwN5ZEEe8zYc2oAkeRufCyWkCOUW8PJ3krM5gMASixOQ8rehIt3e
         ECG1Z0k4Obg1soQyK+MU63vDmMB0xY54tdzWJctFJurxkpslOJCockYpjSm0jQqhNg9K
         TSOoodXdJA2faxel2VmLv65VeG/lgUjGU9eu0eRHqKrvo5yz2UmZ5awoz4G4R1tWNOwr
         T+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XqaBe6tOxz6/WE0sIMF3DTrj19IRsfWxni5CCd6yvyI=;
        b=NIzv3yjmwCDxgpyxiImUne50Fe/75iLGrQh3r/h+3hRkhYYLz/KiNUG4ZMdrOdsFNS
         OrGCPznJ5GvsSDx5WHhz/APP1ZEpWjZTH3/eVuSQHS0KTntlhobHR+tQQnvPtShjQvE2
         A/Pu2PCcxZntIroaZb3Ph6I54rd68/Nz4WBiVFZQ+aTcx5ZWyla/p9rkesDudKnDbtO0
         rTHEna0zjYlmaxyOHuW6PdH/JsRHkgfIsOC/88clEphpasHOZR8Z/DlTD/pfbhlPdqXM
         bncQFwpLvMpX3fLXFuXoKOPDQWWVoc84PHmnPCJJYDcBKBS3HjQNtMPQTcbK7kOw5PBb
         x/fA==
X-Gm-Message-State: AOAM533OzBoRtmOdqnfLBW1PEBIOy7ndYpMoYtwSM2NU5YsQUCrN+iqe
        eLuqKD76Ziy4Sj1cRilSv9T0VfAEXkEfK0Hapxg=
X-Google-Smtp-Source: ABdhPJzx0P4RXgnMVlqUaRoROjyH6uVr2BUkZbYMfRP/QkLKN1s4S8VFE2edNJsh1I74eDn1PAX0b8q9ZLQcChUGENo=
X-Received: by 2002:a2e:9996:: with SMTP id w22mr15612245lji.446.1595398710905;
 Tue, 21 Jul 2020 23:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <1583259280-124995-1-git-send-email-vmayatskikh@digitalocean.com>
 <1583259280-124995-2-git-send-email-vmayatskikh@digitalocean.com> <D5A36675-8344-4D67-9836-64F9BA78D78E@redhat.com>
In-Reply-To: <D5A36675-8344-4D67-9836-64F9BA78D78E@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 21 Jul 2020 23:18:19 -0700
Message-ID: <CAPhsuW5mSbNNspW2tPy-RZW0MmqZkEfsGzLPh1EvXkzW=eS1vg@mail.gmail.com>
Subject: Re: [PATCH 1/1] md/raid10: avoid deadlock on recovery.
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     Vitaly Mayatskikh <vmayatskikh@digitalocean.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jul 21, 2020 at 7:26 AM Nigel Croxon <ncroxon@redhat.com> wrote:
>
>
> > On Mar 3, 2020, at 1:14 PM, Vitaly Mayatskikh <vmayatskikh@digitalocean=
.com> wrote:
> >
> > When disk failure happens and the array has a spare drive, resync threa=
d
> > kicks in and starts to refill the spare. However it may get blocked by
> > a retry thread that resubmits failed IO to a mirror and itself can get
> > blocked on a barrier raised by the resync thread.
> >
> > Signed-off-by: Vitaly Mayatskikh <vmayatskikh@digitalocean.com>
> > ---
> > drivers/md/raid10.c | 14 +++++++++++---
> > 1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > index ec136e4..f1a8e26 100644
> > --- a/drivers/md/raid10.c
> > +++ b/drivers/md/raid10.c
> > @@ -980,6 +980,7 @@ static void wait_barrier(struct r10conf *conf)
> > {
> >       spin_lock_irq(&conf->resync_lock);
> >       if (conf->barrier) {
> > +             struct bio_list *bio_list =3D current->bio_list;
> >               conf->nr_waiting++;
> >               /* Wait for the barrier to drop.
> >                * However if there are already pending
> > @@ -994,9 +995,16 @@ static void wait_barrier(struct r10conf *conf)
> >               wait_event_lock_irq(conf->wait_barrier,
> >                                   !conf->barrier ||
> >                                   (atomic_read(&conf->nr_pending) &&
> > -                                  current->bio_list &&
> > -                                  (!bio_list_empty(&current->bio_list[=
0]) ||
> > -                                   !bio_list_empty(&current->bio_list[=
1]))),
> > +                                  bio_list &&
> > +                                  (!bio_list_empty(&bio_list[0]) ||
> > +                                   !bio_list_empty(&bio_list[1]))) ||
> > +                                  /* move on if recovery thread is
> > +                                   * blocked by us
> > +                                   */
> > +                                  (conf->mddev->thread->tsk =3D=3D cur=
rent &&
> > +                                   test_bit(MD_RECOVERY_RUNNING,
> > +                                            &conf->mddev->recovery) &&
> > +                                   conf->nr_queued > 0),
> >                                   conf->resync_lock);
> >               conf->nr_waiting--;
> >               if (!conf->nr_waiting)
> > =E2=80=94
> > 1.8.3.1
> >
>
> Song, Have you had a chance to look at this patch?
> We would like to have it pulled in to the kernel.

I am sorry I missed this one. This looks good to me.

Nigel, would you like to add your Reviewed-by, or Acked-by, or Tested-by ta=
g?

Thanks,
Song
