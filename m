Return-Path: <linux-raid+bounces-935-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C71E86A6A3
	for <lists+linux-raid@lfdr.de>; Wed, 28 Feb 2024 03:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F262893A1
	for <lists+linux-raid@lfdr.de>; Wed, 28 Feb 2024 02:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D91CD0F;
	Wed, 28 Feb 2024 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjQo7ZDI"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6718E03
	for <linux-raid@vger.kernel.org>; Wed, 28 Feb 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709087870; cv=none; b=ay4pbbNzavpDMgZ38Hz9HLLkw2JfBAaNMViFWOR4GSrS8YhDcoeRyiozSkBn7yhgiIr6WSjsaJciIO7OX/FTiZuUeZ9IOPOfWUgpFp6JbgorUov7mD99QyYa47Sfj1Sr16C42RvPjkArEZLPuD/0QS6WAZVxwMwdXBAAo5a5OOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709087870; c=relaxed/simple;
	bh=Y1cLeoYbLo94otbAAy3qAetkVXP5bGetC7iLVJlMEDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuG1oIiWhAXIRnJkm4phApX8h8MRd55LoRI/lQYv8PjMRvXaI6mqoCp+hTB8ng2j1ZavoBFEYJBdZiiOpuzVJxFcUpP3ZcFH8DJEEFzuZHRXRJtysodx4Cq3y0ooMnyULzu9Kxd9UI7C6wMmN3eEHe0b5Q4ZAIrLHnKQaoLbuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjQo7ZDI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709087867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvwSQqLsi7hD+vo2V86vEhWSz0zS3Mel/Hkb0f91Fvw=;
	b=WjQo7ZDI+qNQ9dCRfX7nmsp8M8MzDubcBpasP46gvyXzRfx+Ts6fnGoXRBfBNdd47GZybC
	Ar0u7u58ZvVvnS5IHbNvgepE2iSXCGuUaP/pYT/6Eb818vYkK4R1l8XG8axfz9FwkewYfU
	9FfE+HbddFZkrToFUp9VyTZ7Gqtsgmw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ZH29SB_WOwaotaQAYu_Tkw-1; Tue, 27 Feb 2024 21:37:45 -0500
X-MC-Unique: ZH29SB_WOwaotaQAYu_Tkw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-299c12daea5so366094a91.1
        for <linux-raid@vger.kernel.org>; Tue, 27 Feb 2024 18:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709087864; x=1709692664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvwSQqLsi7hD+vo2V86vEhWSz0zS3Mel/Hkb0f91Fvw=;
        b=aJtcvn6i3BzP3WnCfrf05cKhXnT1KvDe9HPMSCGD4sEgpddFc3g6QKGaWQU9ign6tt
         vhg2yfZAJ+92AW0WorxFJiYHetaSvaak19RgkydhHewzcdGY7S+EzNbE6Vb1cNhiIZyG
         2uWbvEtcX4tEr39je1iBYkRwSvoLsRNFHiCrQnzoHkgJlSZynLRv0ym7U+2ddoDKQf9g
         6wSPqEPyK6uB7Yyc+XQY49e7u+VbPwJUYgc+mTfXBtMo9wOVW1lfoUO0KXHk7r2RJ09r
         ifI2H4uZ1wzxmFZJF2sGO9tp23KITT08jirVEcjFvHk4DmaXJRr9Vcw6Y//9ATh2M/No
         a2xA==
X-Forwarded-Encrypted: i=1; AJvYcCUksiFznpB3foVWKt3tUTX4Xsa7vMDUd6HdDx7KpElx++FCWfqnkrrs+Xe0/bOlPbhlgiFnQnio350S7WevQQ3oVMVnt3ZWhjbvnw==
X-Gm-Message-State: AOJu0Yzxus2sgwV5u/fR3dNHVXyhNH1g0fVj68oK7EbRjr/whg2NdeX0
	u5JpxSSJFmmwzvx/7sT9yPI52NCwWAZgPb8Vwx7xav0v3E40FtLJwra1xGMTagPTCGi8jtPIqCT
	f8ey3nMLNrdZuSLBZ6dJKMhIRJZUGVHL6b7G/adDT1y5B2jMUlINLpu0B6UXAIQfyRpapzdfKbS
	dK4hqO4gElvpe8tMEZIvBlAmaWXmGWgj5siA==
X-Received: by 2002:a17:90a:94c7:b0:29a:f6d3:6860 with SMTP id j7-20020a17090a94c700b0029af6d36860mr160988pjw.23.1709087864270;
        Tue, 27 Feb 2024 18:37:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoDUWQuk6MDx5L/6q3APhobRB0qb6V28+9oVurSRwSTPC/9ojJlGD5LszEsSq6wqaeijjQ1a6lPqJsVBih2PU=
X-Received: by 2002:a17:90a:94c7:b0:29a:f6d3:6860 with SMTP id
 j7-20020a17090a94c700b0029af6d36860mr160968pjw.23.1709087863905; Tue, 27 Feb
 2024 18:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227120327.1432511-1-yukuai1@huaweicloud.com> <20240227120327.1432511-11-yukuai1@huaweicloud.com>
In-Reply-To: <20240227120327.1432511-11-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Wed, 28 Feb 2024 10:37:32 +0800
Message-ID: <CALTww2-e2T-_aad2p4vQ5v4XcDZwncUkMenqrkbeYN72+iCt-A@mail.gmail.com>
Subject: Re: [PATCH md-6.9 v2 10/10] md/raid1: factor out helpers to choose
 the best rdev from read_balance()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, shli@fb.com, neilb@suse.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:10=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> The way that best rdev is chosen:
>
> 1) If the read is sequential from one rdev:
>  - if rdev is rotational, use this rdev;
>  - if rdev is non-rotational, use this rdev until total read length
>    exceed disk opt io size;
>
> 2) If the read is not sequential:
>  - if there is idle disk, use it, otherwise:
>  - if the array has non-rotational disk, choose the rdev with minimal
>    inflight IO;
>  - if all the underlaying disks are rotational disk, choose the rdev
>    with closest IO;
>
> There are no functional changes, just to make code cleaner and prepare
> for following refactor.
>
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1.c | 175 +++++++++++++++++++++++++--------------------
>  1 file changed, 98 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index d3e9a0157437..1bdd59d9e6ba 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -730,74 +730,71 @@ static bool should_choose_next(struct r1conf *conf,=
 int disk)
>                mirror->next_seq_sect - opt_iosize >=3D mirror->seq_start;
>  }
>
> -/*
> - * This routine returns the disk from which the requested read should
> - * be done. There is a per-array 'next expected sequential IO' sector
> - * number - if this matches on the next IO then we use the last disk.
> - * There is also a per-disk 'last know head position' sector that is
> - * maintained from IRQ contexts, both the normal and the resync IO
> - * completion handlers update this position correctly. If there is no
> - * perfect sequential match then we pick the disk whose head is closest.
> - *
> - * If there are 2 mirrors in the same 2 devices, performance degrades
> - * because position is mirror, not device based.
> - *
> - * The rdev for the device selected will have nr_pending incremented.
> - */
> -static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *=
max_sectors)
> +static bool rdev_readable(struct md_rdev *rdev, struct r1bio *r1_bio)
>  {
> -       const sector_t this_sector =3D r1_bio->sector;
> -       int sectors;
> -       int best_good_sectors;
> -       int best_disk, best_dist_disk, best_pending_disk, sequential_disk=
;
> -       int disk;
> -       sector_t best_dist;
> -       unsigned int min_pending;
> -       struct md_rdev *rdev;
> +       if (!rdev || test_bit(Faulty, &rdev->flags))
> +               return false;
>
> - retry:
> -       sectors =3D r1_bio->sectors;
> -       best_disk =3D -1;
> -       best_dist_disk =3D -1;
> -       sequential_disk =3D -1;
> -       best_dist =3D MaxSector;
> -       best_pending_disk =3D -1;
> -       min_pending =3D UINT_MAX;
> -       best_good_sectors =3D 0;
> -       clear_bit(R1BIO_FailFast, &r1_bio->state);
> +       /* still in recovery */
> +       if (!test_bit(In_sync, &rdev->flags) &&
> +           rdev->recovery_offset < r1_bio->sector + r1_bio->sectors)
> +               return false;
>
> -       if (raid1_should_read_first(conf->mddev, this_sector, sectors))
> -               return choose_first_rdev(conf, r1_bio, max_sectors);
> +       /* don't read from slow disk unless have to */
> +       if (test_bit(WriteMostly, &rdev->flags))
> +               return false;
> +
> +       /* don't split IO for bad blocks unless have to */
> +       if (rdev_has_badblock(rdev, r1_bio->sector, r1_bio->sectors))
> +               return false;
> +
> +       return true;
> +}
> +
> +struct read_balance_ctl {
> +       sector_t closest_dist;
> +       int closest_dist_disk;
> +       int min_pending;
> +       int min_pending_disk;
> +       int sequential_disk;
> +       int readable_disks;
> +};
> +
> +static int choose_best_rdev(struct r1conf *conf, struct r1bio *r1_bio)
> +{
> +       int disk;
> +       struct read_balance_ctl ctl =3D {
> +               .closest_dist_disk      =3D -1,
> +               .closest_dist           =3D MaxSector,
> +               .min_pending_disk       =3D -1,
> +               .min_pending            =3D UINT_MAX,
> +               .sequential_disk        =3D -1,
> +       };
>
>         for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> +               struct md_rdev *rdev;
>                 sector_t dist;
>                 unsigned int pending;
>
> -               rdev =3D conf->mirrors[disk].rdev;
> -               if (r1_bio->bios[disk] =3D=3D IO_BLOCKED
> -                   || rdev =3D=3D NULL
> -                   || test_bit(Faulty, &rdev->flags))
> -                       continue;
> -               if (!test_bit(In_sync, &rdev->flags) &&
> -                   rdev->recovery_offset < this_sector + sectors)
> -                       continue;
> -               if (test_bit(WriteMostly, &rdev->flags))
> +               if (r1_bio->bios[disk] =3D=3D IO_BLOCKED)
>                         continue;
> -               if (rdev_has_badblock(rdev, this_sector, sectors))
> +
> +               rdev =3D conf->mirrors[disk].rdev;
> +               if (!rdev_readable(rdev, r1_bio))
>                         continue;
>
> -               if (best_disk >=3D 0)
> -                       /* At least two disks to choose from so failfast =
is OK */
> +               /* At least two disks to choose from so failfast is OK */
> +               if (ctl.readable_disks++ =3D=3D 1)
>                         set_bit(R1BIO_FailFast, &r1_bio->state);
>
>                 pending =3D atomic_read(&rdev->nr_pending);
> -               dist =3D abs(this_sector - conf->mirrors[disk].head_posit=
ion);
> +               dist =3D abs(r1_bio->sector - conf->mirrors[disk].head_po=
sition);
> +
>                 /* Don't change to another disk for sequential reads */
>                 if (is_sequential(conf, disk, r1_bio)) {
> -                       if (!should_choose_next(conf, disk)) {
> -                               best_disk =3D disk;
> -                               break;
> -                       }
> +                       if (!should_choose_next(conf, disk))
> +                               return disk;
> +
>                         /*
>                          * Add 'pending' to avoid choosing this disk if
>                          * there is other idle disk.
> @@ -807,17 +804,17 @@ static int read_balance(struct r1conf *conf, struct=
 r1bio *r1_bio, int *max_sect
>                          * If there is no other idle disk, this disk
>                          * will be chosen.
>                          */
> -                       sequential_disk =3D disk;
> +                       ctl.sequential_disk =3D disk;
>                 }
>
> -               if (min_pending > pending) {
> -                       min_pending =3D pending;
> -                       best_pending_disk =3D disk;
> +               if (ctl.min_pending > pending) {
> +                       ctl.min_pending =3D pending;
> +                       ctl.min_pending_disk =3D disk;
>                 }
>
> -               if (dist < best_dist) {
> -                       best_dist =3D dist;
> -                       best_dist_disk =3D disk;
> +               if (ctl.closest_dist > dist) {
> +                       ctl.closest_dist =3D dist;
> +                       ctl.closest_dist_disk =3D disk;
>                 }
>         }
>
> @@ -825,8 +822,8 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>          * sequential IO size exceeds optimal iosize, however, there is n=
o other
>          * idle disk, so choose the sequential disk.
>          */
> -       if (best_disk =3D=3D -1 && min_pending !=3D 0)
> -               best_disk =3D sequential_disk;
> +       if (ctl.sequential_disk !=3D -1 && ctl.min_pending !=3D 0)
> +               return ctl.sequential_disk;
>
>         /*
>          * If all disks are rotational, choose the closest disk. If any d=
isk is
> @@ -834,25 +831,49 @@ static int read_balance(struct r1conf *conf, struct=
 r1bio *r1_bio, int *max_sect
>          * disk is rotational, which might/might not be optimal for raids=
 with
>          * mixed ratation/non-rotational disks depending on workload.
>          */
> -       if (best_disk =3D=3D -1) {
> -               if (READ_ONCE(conf->nonrot_disks) || min_pending =3D=3D 0=
)
> -                       best_disk =3D best_pending_disk;
> -               else
> -                       best_disk =3D best_dist_disk;
> -       }
> +       if (ctl.min_pending_disk !=3D -1 &&
> +           (READ_ONCE(conf->nonrot_disks) || ctl.min_pending =3D=3D 0))
> +               return ctl.min_pending_disk;
> +       else
> +               return ctl.closest_dist_disk;
> +}
>
> -       if (best_disk >=3D 0) {
> -               rdev =3D conf->mirrors[best_disk].rdev;
> -               if (!rdev)
> -                       goto retry;
> +/*
> + * This routine returns the disk from which the requested read should be=
 done.
> + *
> + * 1) If resync is in progress, find the first usable disk and use it ev=
en if it
> + * has some bad blocks.
> + *
> + * 2) Now that there is no resync, loop through all disks and skipping s=
low
> + * disks and disks with bad blocks for now. Only pay attention to key di=
sk
> + * choice.
> + *
> + * 3) If we've made it this far, now look for disks with bad blocks and =
choose
> + * the one with most number of sectors.
> + *
> + * 4) If we are all the way at the end, we have no choice but to use a d=
isk even
> + * if it is write mostly.
> + *
> + * The rdev for the device selected will have nr_pending incremented.
> + */
> +static int read_balance(struct r1conf *conf, struct r1bio *r1_bio,
> +                       int *max_sectors)
> +{
> +       int disk;
>
> -               sectors =3D best_good_sectors;
> -               update_read_sectors(conf, disk, this_sector, sectors);
> -       }
> -       *max_sectors =3D sectors;
> +       clear_bit(R1BIO_FailFast, &r1_bio->state);
> +
> +       if (raid1_should_read_first(conf->mddev, r1_bio->sector,
> +                                   r1_bio->sectors))
> +               return choose_first_rdev(conf, r1_bio, max_sectors);
>
> -       if (best_disk >=3D 0)
> -               return best_disk;
> +       disk =3D choose_best_rdev(conf, r1_bio);
> +       if (disk >=3D 0) {
> +               *max_sectors =3D r1_bio->sectors;
> +               update_read_sectors(conf, disk, r1_bio->sector,
> +                                   r1_bio->sectors);
> +               return disk;
> +       }
>
>         /*
>          * If we are here it means we didn't find a perfectly good disk s=
o
> --
> 2.39.2
>
Hi all
This patch looks good to me. Thanks.
Reviewed-by: Xiao Ni <xni@redhat.com>


