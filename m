Return-Path: <linux-raid+bounces-884-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F4F8685B0
	for <lists+linux-raid@lfdr.de>; Tue, 27 Feb 2024 02:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D550B2116C
	for <lists+linux-raid@lfdr.de>; Tue, 27 Feb 2024 01:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A444C6F;
	Tue, 27 Feb 2024 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODn27Gxs"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5D46BA
	for <linux-raid@vger.kernel.org>; Tue, 27 Feb 2024 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997019; cv=none; b=pR+N7vobqaazUISeJEshXT74YTfBHM8qDNPrgQQliDywwmOQV9Aie4Oi2ZxCYY5Wh3EzNsiPTlDj3Yf57yRDUOYkMB9CLqN5qYvAuRyCK1IWuUnHwhSo/5svOOEqCa6pH1CjoX+AHroIx0pbak84t+OiX30fsGK7Zq3UZ8UzJEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997019; c=relaxed/simple;
	bh=xA6TRf8xFUdVGBiWZV0mZL3GHgEK06cehbHFgElkPJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZRKlIdz+LtDKbE4DPj1QFCErvQV2Aj7c9MomTUMqdzPVJV3asYSmspE694F0O+6DSzSX6Uh9UEQ3reKL9KnvU/Hip4J7+2HmjxaQWM3BkURtw0putlhjX53+sRD5mlItxK4vZ+kms1HQBYmzWILt7jKzef27KyCH9MC4Fzut9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODn27Gxs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708997016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEIn87M+hn2S554hVGnIEt51wunIM1SmI8tOlR3X8NU=;
	b=ODn27Gxs92n37VIR/SIQ5TxBeuouwmMNqn3eCi3ebcIGd6cK3DDyUug+Z8DrlEUVT5/xAm
	cOY065ngncqooSgjeoKpq7Fis7ogz97PeG3649EAGT/BIYFIt2LWNBBLHm3K5YdFTUaqx0
	LaUu2cEstw8Rr1XSwtbXSV8lnkMPP74=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-l1jHSQ4MOCKhJ2OjCurIjg-1; Mon, 26 Feb 2024 20:23:35 -0500
X-MC-Unique: l1jHSQ4MOCKhJ2OjCurIjg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dcaf708cb4so9791815ad.0
        for <linux-raid@vger.kernel.org>; Mon, 26 Feb 2024 17:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708997014; x=1709601814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEIn87M+hn2S554hVGnIEt51wunIM1SmI8tOlR3X8NU=;
        b=XpIe7oyF/s6D0qUPR/TZX6IqX0VCp2GXK1M6/zxIEJsNcmqHAaUBuaD86MsgnYHKd7
         Yp1VFYs9vA4okal4iK9cIPlfYTn+pDNmm/vzLSIsA+IIb1iLsFiY/aJT0NZrMctG1Srz
         cYwWzFXBJrLgcV/pZ9pjI1JdFquyKGmZ5b5qP3ENSKohniRsWPjvr2E3OZItpoimtdsz
         AiWuuIBJpDUTUWlBfIcUL2hkZ0fxSkQrTi1DGKR5+fC08XQlKEOaedwGISScoXbMMGn3
         ql8FfHYRt06JSqFCJ3TsYcfcsBjAJfFrng7h4L/zOz3Zvbe7lCLu63qg5OnaNiAIV8nu
         5uTA==
X-Forwarded-Encrypted: i=1; AJvYcCV1DD9T56NFJp/Iv0m+hZGNbG93MsdXmWYurpvepi/H3ooPeap5t5rqzquUGW1sUGY1gp09cJ2Bf/apS/a+vS7U6HkF9uOQ6UH36g==
X-Gm-Message-State: AOJu0YxGuGgmGQrXlm3pIJABWdBHrDHvevWOIigYOL2d1VSxiCiNglRu
	koUz2x0mTebYoSN+L4791I9bu2sA1Hm+2ZnVkvLa4DTJkZTNVf7prIJr775437nsCA3nJVkR+Xl
	DhUSd8rEBWZ8ooRQm0UKyFZ2uvc/dIn2vv/vgJsjFZlDbQ1jZvi3PvPWVHnyJxGLEOvKLzdct+B
	PbHxX/5WigY3FpVIvlbamMy0ILxVP1OZZQyQ==
X-Received: by 2002:a17:903:32c6:b0:1dc:b3bb:480a with SMTP id i6-20020a17090332c600b001dcb3bb480amr1982768plr.49.1708997014065;
        Mon, 26 Feb 2024 17:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrp3LCl0rRWJjmtM9o8k+hcFDHSYcqPeUM2EFp3Ta84bpAOLpV/2X8Pdy0A/XbEp0OTzf//G1f2Zq8D0NOucM=
X-Received: by 2002:a17:903:32c6:b0:1dc:b3bb:480a with SMTP id
 i6-20020a17090332c600b001dcb3bb480amr1982756plr.49.1708997013734; Mon, 26 Feb
 2024 17:23:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <20240222075806.1816400-7-yukuai1@huaweicloud.com> <CALTww2-ypx2YJOeXTzj7Y0EtXMkfrTOAJzzmDnnUK=1irspWtQ@mail.gmail.com>
 <4f2ae964-5030-907e-bc06-4d9e1fc8f3e8@huaweicloud.com>
In-Reply-To: <4f2ae964-5030-907e-bc06-4d9e1fc8f3e8@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 27 Feb 2024 09:23:22 +0800
Message-ID: <CALTww2_q3XG5HFCYm3Wp7=fjM04cdWZy34R6MsDVLz-82iO88Q@mail.gmail.com>
Subject: Re: [PATCH md-6.9 06/10] md/raid1: factor out read_first_rdev() from read_balance()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:06=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/26 22:16, Xiao Ni =E5=86=99=E9=81=93:
> > On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> read_balance() is hard to understand because there are too many status
> >> and branches, and it's overlong.
> >>
> >> This patch factor out the case to read the first rdev from
> >> read_balance(), there are no functional changes.
> >>
> >> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> >> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/raid1.c | 63 +++++++++++++++++++++++++++++++++-----------=
--
> >>   1 file changed, 46 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >> index 8089c569e84f..08c45ca55a7e 100644
> >> --- a/drivers/md/raid1.c
> >> +++ b/drivers/md/raid1.c
> >> @@ -579,6 +579,47 @@ static sector_t align_to_barrier_unit_end(sector_=
t start_sector,
> >>          return len;
> >>   }
> >>
> >> +static void update_read_sectors(struct r1conf *conf, int disk,
> >> +                               sector_t this_sector, int len)
> >> +{
> >> +       struct raid1_info *info =3D &conf->mirrors[disk];
> >> +
> >> +       atomic_inc(&info->rdev->nr_pending);
> >> +       if (info->next_seq_sect !=3D this_sector)
> >> +               info->seq_start =3D this_sector;
> >> +       info->next_seq_sect =3D this_sector + len;
> >> +}
> >> +
> >> +static int choose_first_rdev(struct r1conf *conf, struct r1bio *r1_bi=
o,
> >> +                            int *max_sectors)
> >> +{
> >> +       sector_t this_sector =3D r1_bio->sector;
> >> +       int len =3D r1_bio->sectors;
> >> +       int disk;
> >> +
> >> +       for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> >> +               struct md_rdev *rdev;
> >> +               int read_len;
> >> +
> >> +               if (r1_bio->bios[disk] =3D=3D IO_BLOCKED)
> >> +                       continue;
> >> +
> >> +               rdev =3D conf->mirrors[disk].rdev;
> >> +               if (!rdev || test_bit(Faulty, &rdev->flags))
> >> +                       continue;
> >> +
> >> +               /* choose the first disk even if it has some bad block=
s. */
> >> +               read_len =3D raid1_check_read_range(rdev, this_sector,=
 &len);
> >> +               if (read_len > 0) {
> >> +                       update_read_sectors(conf, disk, this_sector, r=
ead_len);
> >> +                       *max_sectors =3D read_len;
> >> +                       return disk;
> >> +               }
> >
> > Hi Kuai
> >
> > It needs to update max_sectors even if the bad block starts before
> > this_sector. Because it can't read more than bad_blocks from other
> > member disks. If it reads more data than bad blocks, it will cause
> > data corruption. One rule here is read from the primary disk (the
> > first readable disk) if it has no bad block and read the
> > badblock-data-length data from other disks.
>
> Noted that raid1_check_read_range() will return readable length from
> this rdev, hence if bad block starts before this_sector, 0 is returned,
> and 'len' is updated to the length of badblocks(if not exceed read
> range), and following iteration will find the first disk to read updated
> 'len' data and update max_sectors.

Hi Kuai

The problem is that choose_first_rdev doesn't return 'len' from
max_sectors when bad blocks start before this_sector. In the following
iteration, it can't read more than 'len' from other disks to avoid
data corruption. I haven't read all the patches. To this patch, it
resets best_good_sectors to sectors when it encounters a good member
disk without bad blocks.

Regards
Xiao
>
> Thanks,
> Kuai
>
> >
> > Best Regards
> > Xiao
> >
> >> +       }
> >> +
> >> +       return -1;
> >> +}
> >> +
> >>   /*
> >>    * This routine returns the disk from which the requested read shoul=
d
> >>    * be done. There is a per-array 'next expected sequential IO' secto=
r
> >> @@ -603,7 +644,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>          sector_t best_dist;
> >>          unsigned int min_pending;
> >>          struct md_rdev *rdev;
> >> -       int choose_first;
> >>
> >>    retry:
> >>          sectors =3D r1_bio->sectors;
> >> @@ -613,10 +653,11 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> >>          best_pending_disk =3D -1;
> >>          min_pending =3D UINT_MAX;
> >>          best_good_sectors =3D 0;
> >> -       choose_first =3D raid1_should_read_first(conf->mddev, this_sec=
tor,
> >> -                                              sectors);
> >>          clear_bit(R1BIO_FailFast, &r1_bio->state);
> >>
> >> +       if (raid1_should_read_first(conf->mddev, this_sector, sectors)=
)
> >> +               return choose_first_rdev(conf, r1_bio, max_sectors);
> >> +
> >>          for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> >>                  sector_t dist;
> >>                  sector_t first_bad;
> >> @@ -662,8 +703,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>                                   * bad_sectors from another device..
> >>                                   */
> >>                                  bad_sectors -=3D (this_sector - first=
_bad);
> >> -                               if (choose_first && sectors > bad_sect=
ors)
> >> -                                       sectors =3D bad_sectors;
> >>                                  if (best_good_sectors > sectors)
> >>                                          best_good_sectors =3D sectors=
;
> >>
> >> @@ -673,8 +712,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>                                          best_good_sectors =3D good_se=
ctors;
> >>                                          best_disk =3D disk;
> >>                                  }
> >> -                               if (choose_first)
> >> -                                       break;
> >>                          }
> >>                          continue;
> >>                  } else {
> >> @@ -689,10 +726,6 @@ static int read_balance(struct r1conf *conf, stru=
ct r1bio *r1_bio, int *max_sect
> >>
> >>                  pending =3D atomic_read(&rdev->nr_pending);
> >>                  dist =3D abs(this_sector - conf->mirrors[disk].head_p=
osition);
> >> -               if (choose_first) {
> >> -                       best_disk =3D disk;
> >> -                       break;
> >> -               }
> >>                  /* Don't change to another disk for sequential reads =
*/
> >>                  if (conf->mirrors[disk].next_seq_sect =3D=3D this_sec=
tor
> >>                      || dist =3D=3D 0) {
> >> @@ -760,13 +793,9 @@ static int read_balance(struct r1conf *conf, stru=
ct r1bio *r1_bio, int *max_sect
> >>                  rdev =3D conf->mirrors[best_disk].rdev;
> >>                  if (!rdev)
> >>                          goto retry;
> >> -               atomic_inc(&rdev->nr_pending);
> >> -               sectors =3D best_good_sectors;
> >> -
> >> -               if (conf->mirrors[best_disk].next_seq_sect !=3D this_s=
ector)
> >> -                       conf->mirrors[best_disk].seq_start =3D this_se=
ctor;
> >>
> >> -               conf->mirrors[best_disk].next_seq_sect =3D this_sector=
 + sectors;
> >> +               sectors =3D best_good_sectors;
> >> +               update_read_sectors(conf, disk, this_sector, sectors);
> >>          }
> >>          *max_sectors =3D sectors;
> >>
> >> --
> >> 2.39.2
> >>
> >>
> >
> > .
> >
>


