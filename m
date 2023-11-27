Return-Path: <linux-raid+bounces-66-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ECC7FAD33
	for <lists+linux-raid@lfdr.de>; Mon, 27 Nov 2023 23:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16BF9B211EB
	for <lists+linux-raid@lfdr.de>; Mon, 27 Nov 2023 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E93E487BB;
	Mon, 27 Nov 2023 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSkfdMLQ"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2346543
	for <linux-raid@vger.kernel.org>; Mon, 27 Nov 2023 22:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617FEC433CA;
	Mon, 27 Nov 2023 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701123390;
	bh=GZZZizaQ2JGBGghW8BdCWRMnKc60BblYbZVXriQsgfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DSkfdMLQ8pmpDVfd5IQRuWjLD47xG1hlaqdwCX1t136Gng0x2WShn54MVzcADy4ye
	 DdC8h6Rdgw1PtLZUgrDwGc0hvrVUdhZ2nETg72k5Z58Y8eaGUAnD4z9TeNY7eRu6Im
	 Ia1raqOhsloE/zZ+837ejdU83iSGs5c+uX77UW06H12jt+s4Wap1gDrk5nLlSJ7K2u
	 Qjag8wjGzRYr4KMpQN43Hf8fwL7DItP1VIAwXQF8BSEsqd7j+srS3ce0RqFREoxQ20
	 ashRKjfy0yRBiQf2Rr17DCOqSc2K61X8wIDyM6cdyRW+JQiCgfLMWpsx5MAHUZQr8F
	 zd5sdfNW8RPNw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso6869215e87.1;
        Mon, 27 Nov 2023 14:16:30 -0800 (PST)
X-Gm-Message-State: AOJu0YwmQL8F7iaQ2MiX1l7jmfnSFq1gHyN7DlpWp7HiyjNlYyTH/LVf
	/7td7k7JjOypTbJdZ+8jKRfaFO1GLpKfSLHixlA=
X-Google-Smtp-Source: AGHT+IFfm+9VZJPViMMma0yHMioJXnOhPbRgYu2jVjKJLyBsPv8CY57k8dFJhatnrQzy5PYA1T+wfbYDR9xrM9flXcg=
X-Received: by 2002:a19:7507:0:b0:50a:778b:590 with SMTP id
 y7-20020a197507000000b0050a778b0590mr7617033lfe.68.1701123388506; Mon, 27 Nov
 2023 14:16:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125065419.3518254-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231125065419.3518254-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 27 Nov 2023 14:16:16 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4YsDXdpHMuscQrW4NdXZxhg8-k4J0Xt_47twA8sG_Fmg@mail.gmail.com>
Message-ID: <CAPhsuW4YsDXdpHMuscQrW4NdXZxhg8-k4J0Xt_47twA8sG_Fmg@mail.gmail.com>
Subject: Re: [PATCH -next v2] md: synchronize flush io with array reconfiguration
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: maan@systemlinux.org, neilb@suse.de, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 10:54=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently rcu is used to protect iterating rdev from submit_flushes():
>
> submit_flushes                  remove_and_add_spares
>                                 synchronize_rcu
>                                 pers->hot_remove_disk()
>  rcu_read_lock()
>  rdev_for_each_rcu
>   if (rdev->raid_disk >=3D 0)
>                                 rdev->radi_disk =3D -1;
>    atomic_inc(&rdev->nr_pending)
>    rcu_read_unlock()
>    bi =3D bio_alloc_bioset()
>    bi->bi_end_io =3D md_end_flush
>    bi->private =3D rdev
>    submit_bio
>    // issue io for removed rdev
>
> Fix this problem by grabbing 'acive_io' before iterating rdev, make sure
> that remove_and_add_spares() won't concurrent with submit_flushes().
>
> Fixes: a2826aa92e2e ("md: support barrier requests on all personalities."=
)
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes v2:
>  - Add WARN_ON in case md_flush_request() is not called from
>  md_handle_request() in future.
>
>  drivers/md/md.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 86efc9c2ae56..2ffedc39edd6 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -538,6 +538,9 @@ static void md_end_flush(struct bio *bio)
>         rdev_dec_pending(rdev, mddev);
>
>         if (atomic_dec_and_test(&mddev->flush_pending)) {
> +               /* The pair is percpu_ref_tryget() from md_flush_request(=
) */
> +               percpu_ref_put(&mddev->active_io);
> +
>                 /* The pre-request flush has finished */
>                 queue_work(md_wq, &mddev->flush_work);
>         }
> @@ -557,12 +560,8 @@ static void submit_flushes(struct work_struct *ws)
>         rdev_for_each_rcu(rdev, mddev)
>                 if (rdev->raid_disk >=3D 0 &&
>                     !test_bit(Faulty, &rdev->flags)) {
> -                       /* Take two references, one is dropped
> -                        * when request finishes, one after
> -                        * we reclaim rcu_read_lock
> -                        */
>                         struct bio *bi;
> -                       atomic_inc(&rdev->nr_pending);
> +
>                         atomic_inc(&rdev->nr_pending);
>                         rcu_read_unlock();
>                         bi =3D bio_alloc_bioset(rdev->bdev, 0,
> @@ -573,7 +572,6 @@ static void submit_flushes(struct work_struct *ws)
>                         atomic_inc(&mddev->flush_pending);
>                         submit_bio(bi);
>                         rcu_read_lock();
> -                       rdev_dec_pending(rdev, mddev);
>                 }
>         rcu_read_unlock();
>         if (atomic_dec_and_test(&mddev->flush_pending))
> @@ -626,6 +624,18 @@ bool md_flush_request(struct mddev *mddev, struct bi=
o *bio)
>         /* new request after previous flush is completed */
>         if (ktime_after(req_start, mddev->prev_flush_start)) {
>                 WARN_ON(mddev->flush_bio);
> +               /*
> +                * Grab a reference to make sure mddev_suspend() will wai=
t for
> +                * this flush to be done.
> +                *
> +                * md_flush_reqeust() is called under md_handle_request()=
 and
> +                * 'active_io' is already grabbed, hence percpu_ref_tryge=
t()
> +                * won't fail, percpu_ref_tryget_live() can't be used bec=
ause
> +                * percpu_ref_kill() can be called by mddev_suspend()
> +                * concurrently.
> +                */
> +               if (WARN_ON(percpu_ref_tryget(&mddev->active_io)))

This should be "if (!WARN_ON(..))", right?

Song

> +                       percpu_ref_get(&mddev->active_io);
>                 mddev->flush_bio =3D bio;
>                 bio =3D NULL;
>         }
> --
> 2.39.2
>
>

