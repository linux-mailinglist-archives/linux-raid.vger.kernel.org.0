Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5E76074A3
	for <lists+linux-raid@lfdr.de>; Fri, 21 Oct 2022 12:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJUKHh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 21 Oct 2022 06:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJUKHg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 21 Oct 2022 06:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA91254377
        for <linux-raid@vger.kernel.org>; Fri, 21 Oct 2022 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666346853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B8iK4F+gIRD6OyiWnw5QZpyLkuETAwWs/0hjdPLWIcc=;
        b=T1H9PoEwyPiPGTmEQnzMEZ75lci5Wek7rGU1j2jBKcmWHjeViCsICIfq73JbQ2rVc+klE4
        NHOfMqHw6SWmc1WLrR98qfiGEMgWCbaFLVlgadN1oOVzSiLqroHbX8MCfObBQMAStRCaL+
        SLrJwr5QhD6gTwNXgA0WKhcA7RjJBnM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-g9m60NxmM46z0fVzol_Dug-1; Fri, 21 Oct 2022 06:07:32 -0400
X-MC-Unique: g9m60NxmM46z0fVzol_Dug-1
Received: by mail-pf1-f200.google.com with SMTP id y15-20020aa78f2f000000b00562674456afso1184417pfr.9
        for <linux-raid@vger.kernel.org>; Fri, 21 Oct 2022 03:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8iK4F+gIRD6OyiWnw5QZpyLkuETAwWs/0hjdPLWIcc=;
        b=MGLKmwA72mmWj20KZpqYUla2RqqwUCk6NBsQsE+7jWegcKOzIn7BsGAkwAdTI7FYPD
         HnHFLd0KpYleFQgzvA4/EZJJUVNaYpMXaIPhpTrVuTA3+VIXySyz4lsSwSbYr7ODEsVC
         MGXNhi62kyAJNqlEQS9J4Waed7wF6tC+TYkeapEH55L2o20kokMD0sTz1mxnW8wuyOzq
         hzGydxYCow5VcznZs/dQcglh4qjwe4d21iZ3c9yc5Zy9X0l/Fa5+SLfDcKP+dNskwot1
         ISUbv13qXljOfvDN+c0sX8bIK+Wgkt9qhIneuOjp+MnsKQEkV7SVJg0PmOOf7dWfva+x
         zM8w==
X-Gm-Message-State: ACrzQf0FF2KmhSW0TSRTZlyZt6z43DEOSBGZ5+kNOfx03/uzE5Ne2it3
        rUc/FIZGqlg33pFM5XHk8mIg/NepHarurskwXRmyeMyZFLO2UwRYEKpFQz0CbefnVBp5hru7EGF
        VxdqN4niuHiMOiIqElea6Dy5qcjy7Wh/6tcT3FA==
X-Received: by 2002:a17:90b:388c:b0:20a:9c33:dd2b with SMTP id mu12-20020a17090b388c00b0020a9c33dd2bmr55122210pjb.225.1666346851013;
        Fri, 21 Oct 2022 03:07:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4hK0alf7IjlXH6Bnn4FV2fh/8nCvpUPT9CCTgfj2p0vLEVKsbWxIpzsMJsVL7qQLw2RL7bN4rMmRO2eSnkEwM=
X-Received: by 2002:a17:90b:388c:b0:20a:9c33:dd2b with SMTP id
 mu12-20020a17090b388c00b0020a9c33dd2bmr55122175pjb.225.1666346850615; Fri, 21
 Oct 2022 03:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221017021116.39374-1-xni@redhat.com> <CAPhsuW5ptwgE193G44BQF_9DwfewO+de_YYeAQFVpCWfWvL-Xg@mail.gmail.com>
In-Reply-To: <CAPhsuW5ptwgE193G44BQF_9DwfewO+de_YYeAQFVpCWfWvL-Xg@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Fri, 21 Oct 2022 18:07:19 +0800
Message-ID: <CALTww2_bDpuJrBFKos2bFCsk_Z=_=dCe8kKhxNoX-Mhb7i4wLg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add mddev->io_acct_cnt for raid0_quiesce
To:     Song Liu <song@kernel.org>
Cc:     guoqing.jiang@linux.dev, linux-raid@vger.kernel.org,
        ffan@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Oct 21, 2022 at 3:50 AM Song Liu <song@kernel.org> wrote:
>
> On Sun, Oct 16, 2022 at 7:11 PM Xiao Ni <xni@redhat.com> wrote:
> >
> > It has added io_acct_set for raid0/raid5 io accounting and it needs to
> > alloc md_io_acct in the i/o path. They are free when the bios come back
> > from member disks. Now we don't have a method to monitor if those bios
> > are all come back. In the takeover process, it needs to free the raid0
> > memory resource including the memory pool for md_io_acct. But maybe some
> > bios are still not returned. When those bios are returned, it can cause
> > panic bcause of introducing NULL pointer or invalid address.
> >
> > This patch adds io_acct_cnt. So when stopping raid0, it can use this
> > to wait until all bios come back.
> >
> > Reported-by: Fine Fan <ffan@redhat.com>
> > Signed-off-by: Xiao Ni <xni@redhat.com>
>
> I have seen a lot of warnings and errors in dmesg with this patch. For example:
>
> [  402.116463] =============================================================================
> [  402.117176] BUG bio-144 (Tainted: G    B   W         ): Right
> Redzone overwritten
> [  402.117837] -----------------------------------------------------------------------------
> [  402.117837]
> [  402.118713] 0xffff88816f683cd0-0xffff88816f683cd7 @offset=15568.
> First byte 0x0 instead of 0xcc
> [  402.119505] Allocated in mempool_alloc+0x79/0x1a0 age=1038 cpu=19 pid=1130
> [  402.120133]  kmem_cache_alloc+0x2dc/0x3c0
> [  402.120510]  mempool_alloc+0x79/0x1a0
> [  402.120840]  bio_alloc_bioset+0xcb/0x530
> [  402.121205]  bio_alloc_clone+0x20/0x60
> [  402.121560]  md_account_bio+0x41/0x80
> [  402.121890]  raid5_make_request+0x1cf/0x1450
> [  402.122327]  md_handle_request+0x26c/0x3f0
> [  402.122700]  __submit_bio+0x53/0x180
> [  402.123030]  submit_bio_noacct_nocheck+0xe8/0x2b0
> [  402.123453]  __blkdev_direct_IO_async+0x109/0x1d0
> [  402.123897]  generic_file_direct_write+0x9c/0x1e0
> [  402.124332]  __generic_file_write_iter+0x95/0x170
> [  402.124771]  blkdev_write_iter+0xe9/0x180
> [  402.125162]  aio_write+0x11a/0x2e0
> [  402.125503]  io_submit_one+0x627/0xd20
> [  402.125844]  __x64_sys_io_submit+0x88/0x250
> [  402.126223] Slab 0xffffea0005bda000 objects=51 used=51
> fp=0x0000000000000000 flags=0x200000000010200(slab|head|node=0|zone=2)
> [  402.127227] Object 0xffff88816f683c40 @offset=15424 fp=0x0000000000000000
> [  402.127227]
> [  402.127960] Redzone  ffff88816f683c00: cc cc cc cc cc cc cc cc cc
> cc cc cc cc cc cc cc  ................
> [  402.128797] Redzone  ffff88816f683c10: cc cc cc cc cc cc cc cc cc
> cc cc cc cc cc cc cc  ................
> [  402.129665] Redzone  ffff88816f683c20: cc cc cc cc cc cc cc cc cc
> cc cc cc cc cc cc cc  ................
> [  402.130503] Redzone  ffff88816f683c30: cc cc cc cc cc cc cc cc cc
> cc cc cc cc cc cc cc  ................
> [  402.131336] Object   ffff88816f683c40: 80 a3 68 6f 81 88 ff ff af
> 21 00 00 01 00 00 00  ..ho.....!......
> [  402.132166] Object   ffff88816f683c50: 00 00 00 00 00 00 00 00 80
> 23 09 0b 81 88 ff ff  .........#......
> [  402.132996] Object   ffff88816f683c60: 01 88 00 00 02 00 04 40 00
> 5a 5a 5a 00 00 00 00  .......@.ZZZ....
> [  402.133822] Object   ffff88816f683c70: 88 86 1c 00 00 00 00 00 00
> 10 00 00 00 00 00 00  ................
> [  402.134647] Object   ffff88816f683c80: 00 00 00 00 ff ff ff ff e0
> a9 a8 81 ff ff ff ff  ................
> [  402.135501] Object   ffff88816f683c90: 40 3c 68 6f 81 88 ff ff 00
> 00 00 00 00 00 00 00  @<ho............
> [  402.136354] Object   ffff88816f683ca0: 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00  ................
> [  402.137174] Object   ffff88816f683cb0: 00 00 00 00 00 00 00 00 00
> 00 00 00 01 00 00 00  ................
> [  402.138027] Object   ffff88816f683cc0: 00 a4 68 6f 81 88 ff ff 40
> 2f c4 73 81 88 ff ff  ..ho....@/.s....
> [  402.138857] Redzone  ffff88816f683cd0: 00 20 c4 73 81 88 ff ff
>                     . .s....
> [  402.139657] Padding  ffff88816f683d20: 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
> [  402.140510] Padding  ffff88816f683d30: 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
> [  402.141345] CPU: 29 PID: 1092 Comm: md0_raid5 Tainted: G    B   W
>        6.1.0-rc1+ #145
> [  402.142083] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [  402.143127] Call Trace:
> [  402.143365]  <TASK>
> [  402.143563]  dump_stack_lvl+0x45/0x5d
> [  402.143899]  check_bytes_and_report.cold+0x6d/0x85
> [  402.144343]  check_object+0x1fa/0x2d0
> [  402.144675]  free_debug_processing+0x1bc/0x660
> [  402.145091]  ? md_end_io_acct+0x3c/0x80
> [  402.145464]  ? md_end_io_acct+0x3c/0x80
> [  402.145812]  kmem_cache_free+0x55f/0x5b0
> [  402.146164]  md_end_io_acct+0x3c/0x80
> [  402.146498]  handle_stripe+0x11a5/0x1d70
> [  402.146849]  handle_active_stripes.constprop.0+0x487/0x5e0
> [  402.147353]  raid5d+0x40d/0x680
> [  402.147640]  ? lock_acquire+0x1ad/0x310
> [  402.147989]  md_thread+0xc2/0x170
> [  402.148319]  ? prepare_to_wait_exclusive+0xe0/0xe0
> [  402.148749]  ? register_md_personality+0x90/0x90
> [  402.149162]  kthread+0xf2/0x120
> [  402.149455]  ? kthread_complete_and_exit+0x20/0x20
> [  402.149884]  ret_from_fork+0x22/0x30
> [  402.150211]  </TASK>
> [  402.150431] FIX bio-144: Restoring Right Redzone
> 0xffff88816f683cd0-0xffff88816f683cd7=0xcc
> [  402.151196] FIX bio-144: Object at 0xffff88816f683c40 not freed
>
> Please fix them and resend.
>
> Thanks,
> Song

Hi Song

What commands do you run? I've run some tests and didn't see the messages.
By the way, what disks do you use?

Regards
Xiao
>
>
> > ---
> >  drivers/md/md.c    | 13 ++++++++++++-
> >  drivers/md/md.h    | 11 ++++++++---
> >  drivers/md/raid0.c |  6 ++++++
> >  3 files changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 9dc0175280b4..57dc2ddf1e11 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -673,6 +673,7 @@ void mddev_init(struct mddev *mddev)
> >         atomic_set(&mddev->flush_pending, 0);
> >         init_waitqueue_head(&mddev->sb_wait);
> >         init_waitqueue_head(&mddev->recovery_wait);
> > +       init_waitqueue_head(&mddev->wait_io_acct);
> >         mddev->reshape_position = MaxSector;
> >         mddev->reshape_backwards = 0;
> >         mddev->last_sync_action = "none";
> > @@ -8600,15 +8601,18 @@ int acct_bioset_init(struct mddev *mddev)
> >  {
> >         int err = 0;
> >
> > -       if (!bioset_initialized(&mddev->io_acct_set))
> > +       if (!bioset_initialized(&mddev->io_acct_set)) {
> > +               atomic_set(&mddev->io_acct_cnt, 0);
> >                 err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
> >                         offsetof(struct md_io_acct, bio_clone), 0);
> > +       }
> >         return err;
> >  }
> >  EXPORT_SYMBOL_GPL(acct_bioset_init);
> >
> >  void acct_bioset_exit(struct mddev *mddev)
> >  {
> > +       WARN_ON(atomic_read(&mddev->io_acct_cnt) != 0);
> >         bioset_exit(&mddev->io_acct_set);
> >  }
> >  EXPORT_SYMBOL_GPL(acct_bioset_exit);
> > @@ -8617,12 +8621,17 @@ static void md_end_io_acct(struct bio *bio)
> >  {
> >         struct md_io_acct *md_io_acct = bio->bi_private;
> >         struct bio *orig_bio = md_io_acct->orig_bio;
> > +       struct mddev *mddev = md_io_acct->mddev;
> >
> >         orig_bio->bi_status = bio->bi_status;
> >
> >         bio_end_io_acct(orig_bio, md_io_acct->start_time);
> >         bio_put(bio);
> >         bio_endio(orig_bio);
> > +
> > +       if (atomic_dec_and_test(&mddev->io_acct_cnt))
> > +               if (unlikely(test_bit(MD_QUIESCE, &mddev->flags)))
> > +                       wake_up(&mddev->wait_io_acct);
> >  }
> >
> >  /*
> > @@ -8642,6 +8651,8 @@ void md_account_bio(struct mddev *mddev, struct bio **bio)
> >         md_io_acct = container_of(clone, struct md_io_acct, bio_clone);
> >         md_io_acct->orig_bio = *bio;
> >         md_io_acct->start_time = bio_start_io_acct(*bio);
> > +       md_io_acct->mddev = mddev;
> > +       atomic_inc(&mddev->io_acct_cnt);
> >
> >         clone->bi_end_io = md_end_io_acct;
> >         clone->bi_private = md_io_acct;
> > diff --git a/drivers/md/md.h b/drivers/md/md.h
> > index b4e2d8b87b61..061176ff325f 100644
> > --- a/drivers/md/md.h
> > +++ b/drivers/md/md.h
> > @@ -255,6 +255,7 @@ struct md_cluster_info;
> >   *                array is ready yet.
> >   * @MD_BROKEN: This is used to stop writes and mark array as failed.
> >   * @MD_DELETED: This device is being deleted
> > + * @MD_QUIESCE: This device is being quiesced. Now only raid0 use this flag
> >   *
> >   * change UNSUPPORTED_MDDEV_FLAGS for each array type if new flag is added
> >   */
> > @@ -272,6 +273,7 @@ enum mddev_flags {
> >         MD_NOT_READY,
> >         MD_BROKEN,
> >         MD_DELETED,
> > +       MD_QUIESCE,
> >  };
> >
> >  enum mddev_sb_flags {
> > @@ -513,6 +515,8 @@ struct mddev {
> >                                                    * metadata and bitmap writes
> >                                                    */
> >         struct bio_set                  io_acct_set; /* for raid0 and raid5 io accounting */
> > +       atomic_t                        io_acct_cnt;
> > +       wait_queue_head_t               wait_io_acct;
> >
> >         /* Generic flush handling.
> >          * The last to finish preflush schedules a worker to submit
> > @@ -710,9 +714,10 @@ struct md_thread {
> >  };
> >
> >  struct md_io_acct {
> > -       struct bio *orig_bio;
> > -       unsigned long start_time;
> > -       struct bio bio_clone;
> > +       struct bio      *orig_bio;
> > +       unsigned long   start_time;
> > +       struct bio      bio_clone;
> > +       struct mddev    *mddev;
> >  };
> >
> >  #define THREAD_WAKEUP  0
> > diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> > index 857c49399c28..aced0ad8cdab 100644
> > --- a/drivers/md/raid0.c
> > +++ b/drivers/md/raid0.c
> > @@ -754,6 +754,12 @@ static void *raid0_takeover(struct mddev *mddev)
> >
> >  static void raid0_quiesce(struct mddev *mddev, int quiesce)
> >  {
> > +       /* It doesn't use a separate struct to count how many bios are submitted
> > +        * to member disks to avoid memory alloc and performance decrease
> > +        */
> > +       set_bit(MD_QUIESCE, &mddev->flags);
> > +       wait_event(mddev->wait_io_acct, !atomic_read(&mddev->io_acct_cnt));
> > +       clear_bit(MD_QUIESCE, &mddev->flags);
> >  }
> >
> >  static struct md_personality raid0_personality=
> > --
> > 2.32.0 (Apple Git-132)
> >
>

