Return-Path: <linux-raid+bounces-732-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20809859CD6
	for <lists+linux-raid@lfdr.de>; Mon, 19 Feb 2024 08:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458D01C21B0D
	for <lists+linux-raid@lfdr.de>; Mon, 19 Feb 2024 07:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700EF20B22;
	Mon, 19 Feb 2024 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT7NVtHG"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCC208D2
	for <linux-raid@vger.kernel.org>; Mon, 19 Feb 2024 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327648; cv=none; b=ce8HjALpjR9o8MNBGQY/k6RwpU/h7N8NENPuUpOETiQtXf6M0VoXRA3O1pZIh5if0AdO7hloogh4sgVEkq7UCb05PGqYq8O62Ewd71IfZia0TwTrcjjfweshgWU2pNd83ypWUoxAeLd5IOtt/eh9huNYj/Ih1sxvZN733ZMmOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327648; c=relaxed/simple;
	bh=pcdJXDwheFehbxuuoq65tVLxQwvc9vQPW9InBBMs59g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2qKG5s1BZHyaYrwQ7QG9+ZFW7zh+xwT3HUHpSpWXgi5D1H3JM53xy6pFYbqKUQXooqYpSSgDLipH5a7mVqFiI6t6hJEgwEeZu+8KRy4IottsIqfZidattrUB7LvSmXascMjH2SxYPPUygUGRxlUEEutKvRZnLvNp2+RdW/atgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bT7NVtHG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708327644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74CBXR566kPhw7wL0C8NvrxZfbRS6KTgsQ5OejlazBs=;
	b=bT7NVtHGXeQnUGiiekLrEb/zGR1f6nJc3W3AnQ1OYbhTF/49xzp7HQq3Xhz+kTKoCzGwZh
	o3SWfOc01457x3Or64FjfWts3SLmF4Xjms7jiXX85rXnjded1BEugnHkYPEZPJI8dTpP4Q
	C1ZFLJpcrbb8WtjWlsQia9zClr7Uwj0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-MMydf6UJONedwHvxovsZrw-1; Mon, 19 Feb 2024 02:27:22 -0500
X-MC-Unique: MMydf6UJONedwHvxovsZrw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29935a0ecbbso2728218a91.2
        for <linux-raid@vger.kernel.org>; Sun, 18 Feb 2024 23:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708327641; x=1708932441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74CBXR566kPhw7wL0C8NvrxZfbRS6KTgsQ5OejlazBs=;
        b=mstr4YOiKD/SMKs4D1EDeILxw1+4lHUtOYo/Allp4bgRASrdV6gkRIWTurdLzW1NlH
         wb0i8aLOJSsIG8HNrYoAW04oy6u5TRXLCVBf3QHBFIy5dO6Jf+fAPBvT3N7qX5CLKI42
         GvavF/r/IiI83/W823HIBuN/k3hYV43Kem3aUId0vlw6rRBD5nvRXzrizu0vbPLdjKwT
         318xu2RdCg1idJImYuiQAXjXqLNSSfX6M02rhNfeIdxCq+EivH+N29xrkFynN8VZqncg
         YJmnL6y8zonSJpOgClXcdwliDJxxla1vCypHKvEtMMOkJWWYQGxfCRK/46OrxXZBrWzJ
         /lLA==
X-Forwarded-Encrypted: i=1; AJvYcCX0g9OziHmXeUTVyZvl4UXJ9SiP+Z5npbPCstkDbllAffclKpoPYgE2dir/kSbLhYANrKqNNLSTtqGdKA0JzFwzWhhSsYj9ELuWQw==
X-Gm-Message-State: AOJu0Yya74nVq94zxdfEZSM0KE/grVb37IzCi+6Zmhq0sV+9D7t44m6f
	qli3zf0jhH/9ALWhbtjUq5cw8ThnurTNuAN/fJGJMKMOiQneAwEPM8YR9cG5XIlJ1kC8mbiJby4
	P0Th47teLo5K5/XpN3HU84O+4aMBAFhWB4KaYK97Mfw59QxRanDXZ1FBF8Nag+klOeYjs4wjf7K
	bZxzsBEoTnemWvh+GOMmuCiAA55v9y0Kr5dQ==
X-Received: by 2002:a17:90a:b014:b0:299:6e88:7b6a with SMTP id x20-20020a17090ab01400b002996e887b6amr3080468pjq.36.1708327641039;
        Sun, 18 Feb 2024 23:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiSm9rbIwPnYIoYffxiQwVkGHvFDkNB7lRK4S50KJoK/+XfNfNxEf4F0pMqejO3d+DN5B4O+5KIdNB6b63ZhE=
X-Received: by 2002:a17:90a:b014:b0:299:6e88:7b6a with SMTP id
 x20-20020a17090ab01400b002996e887b6amr3080459pjq.36.1708327640736; Sun, 18
 Feb 2024 23:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-10-yukuai1@huaweicloud.com> <CALTww2_ppGe29wMOsLS45kR4YS6TyCTBswmeKyVE+-H6XmoN+g@mail.gmail.com>
 <3c062731-3b74-2b3e-94c8-ffdf940df014@huaweicloud.com>
In-Reply-To: <3c062731-3b74-2b3e-94c8-ffdf940df014@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 19 Feb 2024 15:27:09 +0800
Message-ID: <CALTww29wMJffDUddW526aLbcArqkZVZnrjfuFjOEMUgBMD=AZA@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] dm-raid: really frozen sync_thread during suspend
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, akpm@osdl.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 2:34=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/18 12:53, Xiao Ni =E5=86=99=E9=81=93:
> > Hi Kuai
> >
> > On Thu, Feb 1, 2024 at 5:30=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> 1) The flag MD_RECOVERY_FROZEN doesn't mean that sync thread is frozen=
,
> >>     it only prevent new sync_thread to start, and it can't stop the
> >>     running sync thread;
> >
> > Agree with this
> >
> >> 2) The flag MD_RECOVERY_FROZEN doesn't mean that writes are stopped, u=
se
> >>     it as condition for md_stop_writes() in raid_postsuspend() doesn't
> >>     look correct.
> >
> > I don't agree with it. __md_stop_writes stops sync thread, so it needs
> > to check this flag. And It looks like the name __md_stop_writes is not
> > right. Does it really stop write io? mddev_suspend should be the
> > function that stop write request. From my understanding,
> > raid_postsuspend does two jobs. One is stopping sync thread. Two is
> > suspending array.
>
> MD_RECOVERY_FROZEN is not just used in __md_stop_writes(), so I think
> it's not correct to to check this. For example, if MD_RECOVERY_FROZEN is
> set by raid_message(), then __md_stop_writes() will be skipped.

Hi Kuai

raid_message sets MD_RECOVERY_FROZEN and it stops the sync thread
synchronously. So it doesn't need __md_stop_writes. So from md and
dmraid, it has a rule. If you set MD_RECOVERY_FROZEN, you're in the
process of stopping sync thread.

>
> >
> >> 3) raid_message can set/clear the flag MD_RECOVERY_FROZEN at anytime,
> >>     and if MD_RECOVERY_FROZEN is cleared while the array is suspended,
> >>     new sync_thread can start unexpected.
> >
> > md_action_store doesn't check this either. If the array is suspended
> > and MD_RECOVERY_FROZEN is cleared, before patch01, sync thread can't
> > happen. So it looks like patch01 breaks the logic.
>
> The difference is that md/raid doen't need to frozen sync_thread while
> suspending the array for now. And I don't understand at all why sync
> thread can't happed before patch01.

There is a condition you mentioned above -- the array is suspended.
Before patch01, if one array is suspended, the sync thread can't
happen. Even raid_messages clears MD_RECOVERY_FROZEN, the sync thread
can't start. After resume the array, the sync thread can start again.

Regards
Xiao
>
> Thanks,
> Kuai
>
> >
> > Regards
> > Xiao
> >
> >
> >>
> >> Fix above problems by using the new helper to suspend the array during
> >> suspend, also disallow raid_message() to change sync_thread status
> >> during suspend.
> >>
> >> Note that after commit f52f5c71f3d4 ("md: fix stopping sync thread"), =
the
> >> test shell/lvconvert-raid-reshape.sh start to hang in stop_sync_thread=
(),
> >> and with previous fixes, the test won't hang there anymore, however, t=
he
> >> test will still fail and complain that ext4 is corrupted. And with thi=
s
> >> patch, the test won't hang due to stop_sync_thread() or fail due to ex=
t4
> >> is corrupted anymore. However, there is still a deadlock related to
> >> dm-raid456 that will be fixed in following patches.
> >>
> >> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> >> Closes: https://lore.kernel.org/all/e5e8afe2-e9a8-49a2-5ab0-958d4065c5=
5e@redhat.com/
> >> Fixes: 1af2048a3e87 ("dm raid: fix deadlock caused by premature md_sto=
p_writes()")
> >> Fixes: 9dbd1aa3a81c ("dm raid: add reshaping support to the target")
> >> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/dm-raid.c | 38 +++++++++++++++++++++++++++++---------
> >>   1 file changed, 29 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> >> index eb009d6bb03a..5ce3c6020b1b 100644
> >> --- a/drivers/md/dm-raid.c
> >> +++ b/drivers/md/dm-raid.c
> >> @@ -3240,11 +3240,12 @@ static int raid_ctr(struct dm_target *ti, unsi=
gned int argc, char **argv)
> >>          rs->md.ro =3D 1;
> >>          rs->md.in_sync =3D 1;
> >>
> >> -       /* Keep array frozen until resume. */
> >> -       set_bit(MD_RECOVERY_FROZEN, &rs->md.recovery);
> >> -
> >>          /* Has to be held on running the array */
> >>          mddev_suspend_and_lock_nointr(&rs->md);
> >> +
> >> +       /* Keep array frozen until resume. */
> >> +       md_frozen_sync_thread(&rs->md);
> >> +
> >>          r =3D md_run(&rs->md);
> >>          rs->md.in_sync =3D 0; /* Assume already marked dirty */
> >>          if (r) {
> >> @@ -3722,6 +3723,9 @@ static int raid_message(struct dm_target *ti, un=
signed int argc, char **argv,
> >>          if (!mddev->pers || !mddev->pers->sync_request)
> >>                  return -EINVAL;
> >>
> >> +       if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
> >> +               return -EBUSY;
> >> +
> >>          if (!strcasecmp(argv[0], "frozen"))
> >>                  set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>          else
> >> @@ -3791,15 +3795,31 @@ static void raid_io_hints(struct dm_target *ti=
, struct queue_limits *limits)
> >>          blk_limits_io_opt(limits, chunk_size_bytes * mddev_data_strip=
es(rs));
> >>   }
> >>
> >> +static void raid_presuspend(struct dm_target *ti)
> >> +{
> >> +       struct raid_set *rs =3D ti->private;
> >> +
> >> +       mddev_lock_nointr(&rs->md);
> >> +       md_frozen_sync_thread(&rs->md);
> >> +       mddev_unlock(&rs->md);
> >> +}
> >> +
> >> +static void raid_presuspend_undo(struct dm_target *ti)
> >> +{
> >> +       struct raid_set *rs =3D ti->private;
> >> +
> >> +       mddev_lock_nointr(&rs->md);
> >> +       md_unfrozen_sync_thread(&rs->md);
> >> +       mddev_unlock(&rs->md);
> >> +}
> >> +
> >>   static void raid_postsuspend(struct dm_target *ti)
> >>   {
> >>          struct raid_set *rs =3D ti->private;
> >>
> >>          if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flag=
s)) {
> >>                  /* Writes have to be stopped before suspending to avo=
id deadlocks. */
> >> -               if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
> >> -                       md_stop_writes(&rs->md);
> >> -
> >> +               md_stop_writes(&rs->md);
> >>                  mddev_suspend(&rs->md, false);
> >>          }
> >>   }
> >> @@ -4012,8 +4032,6 @@ static int raid_preresume(struct dm_target *ti)
> >>          }
> >>
> >>          /* Check for any resize/reshape on @rs and adjust/initiate */
> >> -       /* Be prepared for mddev_resume() in raid_resume() */
> >> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>          if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) {
> >>                  set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> >>                  mddev->resync_min =3D mddev->recovery_cp;
> >> @@ -4056,9 +4074,9 @@ static void raid_resume(struct dm_target *ti)
> >>                          rs_set_capacity(rs);
> >>
> >>                  mddev_lock_nointr(mddev);
> >> -               clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>                  mddev->ro =3D 0;
> >>                  mddev->in_sync =3D 0;
> >> +               md_unfrozen_sync_thread(mddev);
> >>                  mddev_unlock_and_resume(mddev);
> >>          }
> >>   }
> >> @@ -4074,6 +4092,8 @@ static struct target_type raid_target =3D {
> >>          .message =3D raid_message,
> >>          .iterate_devices =3D raid_iterate_devices,
> >>          .io_hints =3D raid_io_hints,
> >> +       .presuspend =3D raid_presuspend,
> >> +       .presuspend_undo =3D raid_presuspend_undo,
> >>          .postsuspend =3D raid_postsuspend,
> >>          .preresume =3D raid_preresume,
> >>          .resume =3D raid_resume,
> >> --
> >> 2.39.2
> >>
> >
> > .
> >
>


