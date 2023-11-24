Return-Path: <linux-raid+bounces-28-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96947F6E20
	for <lists+linux-raid@lfdr.de>; Fri, 24 Nov 2023 09:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88453B20BD9
	for <lists+linux-raid@lfdr.de>; Fri, 24 Nov 2023 08:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B91BA38;
	Fri, 24 Nov 2023 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILLHeucV"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F429455
	for <linux-raid@vger.kernel.org>; Fri, 24 Nov 2023 08:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A85C433CC;
	Fri, 24 Nov 2023 08:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700814514;
	bh=Its1lpTyj1208LNth+AHWxjgVlyQ75sfrft50TxFD3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ILLHeucVr6o0qcrdNygWSeykFp05IPb5EC7rR8z6HxMuebx1KtpynDvrnjwAymbND
	 dQG4drK9xbGUFYQ0dwPnoZc5Fkh07xzL5jKwRcwbiAhVHwmt/6aU+zsQqYIPbM65EI
	 sq/OqQ+qcMm4iDYPmVisnzsBb/uWVyWoqLsZR8mxTOEUmYCouvc8cBHRAQiCg18MZN
	 sEC/PndFUVcy/nPxJmDzBtRIlbNLD/Dr7NLbsh+eClu1FJpkGoKCD7godYhI2B4oCs
	 WARAWaw/s6XWjoRjoZpeuqguaZz4s3Zrro2a4iJMti4LYhWQa3dhoVRWORkrCMKMZk
	 kHBr9g0PPg3Tw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5079f6efd64so2145297e87.2;
        Fri, 24 Nov 2023 00:28:34 -0800 (PST)
X-Gm-Message-State: AOJu0Yxlk7gfv/DeRISn0jIxs2Ymo04YLSZaPgeCm2RzVPMNvc+SWZxt
	C65Qlqo220Bo+sk1+GXoN4N9JJtEFJ1ccyjZAlU=
X-Google-Smtp-Source: AGHT+IHCtxfxRzJ3enha/RrAeqc2zXjTIGE1U25U5czi3FboYKTVtpEDQw80BRycSUEmtKHIKR78hOcyae46EAicnOI=
X-Received: by 2002:ac2:5ecd:0:b0:50a:aae6:3bd8 with SMTP id
 d13-20020ac25ecd000000b0050aaae63bd8mr1126203lfq.69.1700814512559; Fri, 24
 Nov 2023 00:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231021102059.3198284-1-yukuai1@huaweicloud.com> <20231021102059.3198284-3-yukuai1@huaweicloud.com>
In-Reply-To: <20231021102059.3198284-3-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Nov 2023 00:28:20 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6kZ4voZQPsYQK4O9=5LtFvB8UY_oSWXkOTnek=aJPidw@mail.gmail.com>
Message-ID: <CAPhsuW6kZ4voZQPsYQK4O9=5LtFvB8UY_oSWXkOTnek=aJPidw@mail.gmail.com>
Subject: Re: [PATCH -next v2 2/6] md: remove flag RemoveSynchronized
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 7:25=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> rcu is not used correctly here, because synchronize_rcu() is called
> before replacing old value, for example:
>
> remove_and_add_spares   // other path
>  synchronize_rcu
>  // called before replacing old value
>  set_bit(RemoveSynchronized)
>                         rcu_read_lock()
>                         rdev =3D conf->mirros[].rdev
>  pers->hot_remove_disk
>   conf->mirros[].rdev =3D NULL;
>   if (!test_bit(RemoveSynchronized))
>    synchronize_rcu
>    /*
>     * won't be called, and won't wait
>     * for concurrent readers to be done.
>     */
>                         // access rdev after remove_and_add_spares()
>                         rcu_read_unlock()
>
> Fortunately, there is a separate rcu protection to prevent such rdev
> to be freed:
>
> md_kick_rdev_from_array         //other path
>                                 rcu_read_lock()
>                                 rdev =3D conf->mirros[].rdev
> list_del_rcu(&rdev->same_set)
>
>                                 rcu_read_unlock()
>                                 /*
>                                  * rdev can be removed from conf, but
>                                  * rdev won't be freed.
>                                  */
> synchronize_rcu()
> free rdev
>
> Hence remove this useless flag and prepare to remove rcu protection to
> access rdev from 'conf'.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

RemoveSynchronized is not removed from md.h.


> ---
>  drivers/md/md-multipath.c |  9 ---------
>  drivers/md/md.c           | 37 ++++++-------------------------------
>  drivers/md/raid1.c        |  9 ---------
>  drivers/md/raid10.c       |  9 ---------
>  drivers/md/raid5.c        |  9 ---------
>  5 files changed, 6 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
> index d22276870283..aa77133f3188 100644
> --- a/drivers/md/md-multipath.c
> +++ b/drivers/md/md-multipath.c
> @@ -258,15 +258,6 @@ static int multipath_remove_disk(struct mddev *mddev=
, struct md_rdev *rdev)
>                         goto abort;
>                 }
>                 p->rdev =3D NULL;
> -               if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> -                       synchronize_rcu();
> -                       if (atomic_read(&rdev->nr_pending)) {
> -                               /* lost the race, try later */
> -                               err =3D -EBUSY;
> -                               p->rdev =3D rdev;
> -                               goto abort;
> -                       }
> -               }
>                 err =3D md_integrity_register(mddev);
>         }
>  abort:
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 09686d8db983..68f3bb6e89cb 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9250,44 +9250,19 @@ static int remove_and_add_spares(struct mddev *md=
dev,
>         struct md_rdev *rdev;
>         int spares =3D 0;
>         int removed =3D 0;
> -       bool remove_some =3D false;
>
>         if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>                 /* Mustn't remove devices when resync thread is running *=
/
>                 return 0;
>
>         rdev_for_each(rdev, mddev) {
> -               if ((this =3D=3D NULL || rdev =3D=3D this) &&
> -                   rdev->raid_disk >=3D 0 &&
> -                   !test_bit(Blocked, &rdev->flags) &&
> -                   test_bit(Faulty, &rdev->flags) &&
> -                   atomic_read(&rdev->nr_pending)=3D=3D0) {
> -                       /* Faulty non-Blocked devices with nr_pending =3D=
=3D 0
> -                        * never get nr_pending incremented,
> -                        * never get Faulty cleared, and never get Blocke=
d set.
> -                        * So we can synchronize_rcu now rather than once=
 per device
> -                        */
> -                       remove_some =3D true;
> -                       set_bit(RemoveSynchronized, &rdev->flags);
> -               }
> -       }
> -
> -       if (remove_some)
> -               synchronize_rcu();
> -       rdev_for_each(rdev, mddev) {
> -               if ((this =3D=3D NULL || rdev =3D=3D this) &&
> -                   (test_bit(RemoveSynchronized, &rdev->flags) ||
> -                    rdev_removeable(rdev))) {
> -                       if (mddev->pers->hot_remove_disk(
> -                                   mddev, rdev) =3D=3D 0) {
> -                               sysfs_unlink_rdev(mddev, rdev);
> -                               rdev->saved_raid_disk =3D rdev->raid_disk=
;
> -                               rdev->raid_disk =3D -1;
> -                               removed++;
> -                       }
> +               if ((this =3D=3D NULL || rdev =3D=3D this) && rdev_remove=
able(rdev) &&
> +                   !mddev->pers->hot_remove_disk(mddev, rdev)) {
> +                       sysfs_unlink_rdev(mddev, rdev);
> +                       rdev->saved_raid_disk =3D rdev->raid_disk;
> +                       rdev->raid_disk =3D -1;
> +                       removed++;
>                 }
> -               if (remove_some && test_bit(RemoveSynchronized, &rdev->fl=
ags))
> -                       clear_bit(RemoveSynchronized, &rdev->flags);
>         }
>
>         if (removed && mddev->kobj.sd)
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index c13088eae401..4348d670439d 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1836,15 +1836,6 @@ static int raid1_remove_disk(struct mddev *mddev, =
struct md_rdev *rdev)
>                         goto abort;
>                 }
>                 p->rdev =3D NULL;
> -               if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> -                       synchronize_rcu();
> -                       if (atomic_read(&rdev->nr_pending)) {
> -                               /* lost the race, try later */
> -                               err =3D -EBUSY;
> -                               p->rdev =3D rdev;
> -                               goto abort;
> -                       }
> -               }
>                 if (conf->mirrors[conf->raid_disks + number].rdev) {
>                         /* We just removed a device that is being replace=
d.
>                          * Move down the replacement.  We drain all IO be=
fore
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4b5f34f320c8..33ab00323cae 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2219,15 +2219,6 @@ static int raid10_remove_disk(struct mddev *mddev,=
 struct md_rdev *rdev)
>                 goto abort;
>         }
>         *rdevp =3D NULL;
> -       if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> -               synchronize_rcu();
> -               if (atomic_read(&rdev->nr_pending)) {
> -                       /* lost the race, try later */
> -                       err =3D -EBUSY;
> -                       *rdevp =3D rdev;
> -                       goto abort;
> -               }
> -       }
>         if (p->replacement) {
>                 /* We must have just cleared 'rdev' */
>                 p->rdev =3D p->replacement;
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 27a4dce51c92..a80be51b4825 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -8202,15 +8202,6 @@ static int raid5_remove_disk(struct mddev *mddev, =
struct md_rdev *rdev)
>                 goto abort;
>         }
>         *rdevp =3D NULL;
> -       if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> -               lockdep_assert_held(&mddev->reconfig_mutex);
> -               synchronize_rcu();
> -               if (atomic_read(&rdev->nr_pending)) {
> -                       /* lost the race, try later */
> -                       err =3D -EBUSY;
> -                       rcu_assign_pointer(*rdevp, rdev);
> -               }
> -       }
>         if (!err) {
>                 err =3D log_modify(conf, rdev, false);
>                 if (err)
> --
> 2.39.2
>

