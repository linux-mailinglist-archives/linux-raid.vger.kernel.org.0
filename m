Return-Path: <linux-raid+bounces-721-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B76B8595BA
	for <lists+linux-raid@lfdr.de>; Sun, 18 Feb 2024 09:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95761F22586
	for <lists+linux-raid@lfdr.de>; Sun, 18 Feb 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8F310A0D;
	Sun, 18 Feb 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+Y1PE2U"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244C149E15
	for <linux-raid@vger.kernel.org>; Sun, 18 Feb 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708245704; cv=none; b=hg5QWzCNvrzrAkUkRlXe57wehAwzafE9wEF/nYMfiz/4xfuN+1k3r+2bNI6ReoikP9Vssf7K4oOZedsW6mA4P6h20vpkLDIUPJ0di38UsvEXESGeu6niPQfUBwzZdhfiNtmhcGwrL/d7gA732DkDz4ueUu51pgCcRXs/o46s7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708245704; c=relaxed/simple;
	bh=xa3ziE6Qutr5+xa7JQlO2n8jIX7lnDu1Ca6EXaSl4ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtWI0oib8PP3yVRRZKWWOOfPF8nhm4Ughf7/Ia0BOdViLTLPfjRpiVc/5Btx1xhcI22OM0Q0Iku8Cxmn9xeyunPBKVSXHF/mZ7bh+CnUOP2iOAm9bOhyjcwLeB1RKRt3icg6m7jPPjm6eoUnJfaSOxi6mrOqG3/ezTQZF0S1+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+Y1PE2U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708245701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggfbkSa8PyXJ242DaT2ZTSwKqBqe1KUKN815Ichjbxg=;
	b=S+Y1PE2UCCZ9vS2Upe2TFFq585wqO6AP17l22IOhSeKqEsKw051Bk95AD1UP0PdIxGzJmR
	zx4kBEWXqHrgh4fMFY/4K0e2ymC7j/LNFBxzZaR9dEGqqZQfMvD4eus9US7WoeSGNtPHLg
	g1FfvA7LZbz9egG9M6pkRNkA3YQFrck=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-S1YrGCp8M8W2_RRElg_uVw-1; Sun, 18 Feb 2024 03:41:39 -0500
X-MC-Unique: S1YrGCp8M8W2_RRElg_uVw-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5995ab41225so4571251eaf.3
        for <linux-raid@vger.kernel.org>; Sun, 18 Feb 2024 00:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708245699; x=1708850499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggfbkSa8PyXJ242DaT2ZTSwKqBqe1KUKN815Ichjbxg=;
        b=Xa/lVxckp3wO8WCBUHzcV+/eU4KYOmj81T+D1z+esas2QO0MlA+gaoRStT7OM1BBkK
         HoP9KK+CCBaor4Rl2o+5fxlRd7C73B+r8FOBP5e6jMBhgF425BN0hbYX/YAElLb15hPo
         PBKT/aPz/6aV/xeKwFJbxhaEJE4ERRf31mFRZdM1IgBbRsXXESvsGDaq5i6s/ctwiaMo
         Sv6O14d89M7esSMQetLywqzObhHvLv2qaLX0QRJdzj+XpJx/wx0EcSZQqQHOrQC5iM/a
         FbfsO2ktFx9tyu45lNNw7IJWVTcFIOZlzqC+Lf1qV1ItHnzHMy36mwFf8YoFftA88tia
         0kVw==
X-Forwarded-Encrypted: i=1; AJvYcCUSjD3r8ExQTH4qpO1NU5MWVgjvyA0lPhF3FMimoYa2CU2VqiELvC4EP/GbQwKKUpyb0uWLd3oFbcsl9J2HnntZOUMYl3shZWAOVg==
X-Gm-Message-State: AOJu0YySfLpmaKwVb4/6ojz3U94kN8CpzQ5biLEEuWJPJmwp9xbLe2wr
	v8A725ur3ESgSgwClmzv8HQKRm2vz5AlO4lF+aDL55PydskbHNukNw4zVPqYNBZ6c9Ad0QrdeTV
	m6AwxCHvC+jwirzjQnLL+05e75tsaa6RxObjvLIY/oe+j1evXkPkYemCR4HNhvvlMkdQcMIo1C5
	3CW/ws5K1N1g/+g4hQOgK7HG4Hdo0ygh61kA==
X-Received: by 2002:a05:6358:758d:b0:176:4600:1d65 with SMTP id x13-20020a056358758d00b0017646001d65mr10987192rwf.2.1708245698886;
        Sun, 18 Feb 2024 00:41:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEitTYhrOMLgjuMz5Sh70o042K1q1dQUDwA1ZGgBMgydBB1ccvzkwYereW0X4JuExpECSPzO9CYfrofZYWI+yc=
X-Received: by 2002:a05:6358:758d:b0:176:4600:1d65 with SMTP id
 x13-20020a056358758d00b0017646001d65mr10987186rwf.2.1708245698558; Sun, 18
 Feb 2024 00:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-4-yukuai1@huaweicloud.com> <CALTww283nysUDy=jmW4w45GbS6O2nS0XLYX=KEiO2BUp5+cLaA@mail.gmail.com>
 <15f0f260-3a2f-6d9b-e60e-c534a9a4d7d0@huaweicloud.com>
In-Reply-To: <15f0f260-3a2f-6d9b-e60e-c534a9a4d7d0@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Sun, 18 Feb 2024 16:41:27 +0800
Message-ID: <CALTww2-jfLXfOSHfBTUk9iMUZfHprmQ56bp2XFPbQaj401nSKg@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] md: make sure md_do_sync() will set MD_RECOVERY_DONE
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, akpm@osdl.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 2:51=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/18 13:56, Xiao Ni =E5=86=99=E9=81=93:
> > On Thu, Feb 1, 2024 at 5:30=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> stop_sync_thread() will interrupt md_do_sync(), and md_do_sync() must
> >> set MD_RECOVERY_DONE, so that follow up md_check_recovery() will
> >> unregister sync_thread, clear MD_RECOVERY_RUNNING and wake up
> >> stop_sync_thread().
> >>
> >> If MD_RECOVERY_WAIT is set or the array is read-only, md_do_sync() wil=
l
> >> return without setting MD_RECOVERY_DONE, and after commit f52f5c71f3d4
> >> ("md: fix stopping sync thread"), dm-raid switch from
> >> md_reap_sync_thread() to stop_sync_thread() to unregister sync_thread
> >> from md_stop() and md_stop_writes(), causing the test
> >> shell/lvconvert-raid-reshape.sh hang.
> >>
> >> We shouldn't switch back to md_reap_sync_thread() because it's
> >> problematic in the first place. Fix the problem by making sure
> >> md_do_sync() will set MD_RECOVERY_DONE.
> >>
> >> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> >> Closes: https://lore.kernel.org/all/ece2b06f-d647-6613-a534-ff4c9bec11=
42@redhat.com/
> >> Fixes: d5d885fd514f ("md: introduce new personality funciton start()")
> >> Fixes: 5fd6c1dce06e ("[PATCH] md: allow checkpoint of recovery with ve=
rsion-1 superblock")
> >> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/md.c | 12 ++++++++----
> >>   1 file changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index 6906d023f1d6..c65dfd156090 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -8788,12 +8788,16 @@ void md_do_sync(struct md_thread *thread)
> >>          int ret;
> >>
> >>          /* just incase thread restarts... */
> >> -       if (test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
> >> -           test_bit(MD_RECOVERY_WAIT, &mddev->recovery))
> >> +       if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
> >>                  return;
> >> -       if (!md_is_rdwr(mddev)) {/* never try to sync a read-only arra=
y */
> >> +
> >> +       if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
> >> +               goto skip;
> >> +
> >> +       if (test_bit(MD_RECOVERY_WAIT, &mddev->recovery) ||
> >> +           !md_is_rdwr(mddev)) {/* never try to sync a read-only arra=
y */
> >>                  set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> >> -               return;
> >> +               goto skip;
> >>          }
> >
> > Hi all
> >
> > I have a question here. The codes above means if MD_RECOVERY_WAIT is
> > set, it sets MD_RECOVERY_INTR. If so, the sync thread can't happen.
> > But from the codes in md_start function:
> >
> >                  set_bit(MD_RECOVERY_WAIT, &mddev->recovery);
> >                  md_wakeup_thread(mddev->thread);
> >                  ret =3D mddev->pers->start(mddev);
> >                  clear_bit(MD_RECOVERY_WAIT, &mddev->recovery);
> >                  md_wakeup_thread(mddev->sync_thread);
> >
> > MD_RECOVERY_WAIT means "it'll run sync thread later not interrupt it".
> > I guess this patch can introduce a new bug for raid5 journal?
>
> I'm not sure what kind of problem you're talking about. After patch 4,
> md_start_sync() should be the only place to register sync_thread, hence
> md_start() should not see registered sync_thread. Perhaps
> MD_RECOVERY_WAIT and md_wakeup_thread(mddev->sync_thread) can be removed
> after patch 4?

Hi Kuai

Before this patch, the process is:
1. set MD_RECOVERY_WAIT
2. start sync thread, sync thread can't run until MD_RECOVERY_WAIT is clear=
ed
3. do something
4. clear MD_RECOVERY_WAIT
5. sync thread (md_do_sync) can run

After this patch, step2 returns directly because MD_RECOVERY_INTR is
set. By this patch, MD_RECOVERY_WAIT has the same meaning as
MD_RECOVERY_INTR.  So this patch breaks one logic.

MD_RECOVERY_WAIT is introduced by patch
d5d885fd514fcebc9da5503c88aa0112df7514ef (md: introduce new
personality funciton start()). Then dm raid uses it to delay sync
thread too.

Back to the deadlock which this patch tries to fix.
The original report is reshape is stuck and can be reproduced easily
by these commands:
modprobe brd rd_size=3D34816 rd_nr=3D5
vgcreate test_vg /dev/ram*
lvcreate --type raid5 -L 16M -n test_lv test_vg
lvconvert -y --stripes 4 /dev/test_vg/test_lv
vgremove test_vg -ff

The root cause is that dm raid stopped the sync thread directly
before. It works even MD_RECOVERY_WAIT is set. Now we stop sync thread
asynchronously. Because MD_RECOVERY_WAIT is set, when stopping dm
raid, it can't set MD_RECOVERY_DONE in md_do_sync. It's the reason
it's stuck at stop_sync_thread. So to fix this deadlock, dm raid
should clear MD_RECOVERY_WAIT before stopping the sync thread.

dm raid stop process:
1. dm_table_postsuspend_targets -> raid_postsuspend -> md_stop_writes.
2. dm_table_destroy -> raid_dtr

So we need to clear MD_RECOVERY_WAIT before calling md_stop_writes.

>
> >
> > And to resolve this deadlock, we can use this patch:
> >
> > --- a/drivers/md/dm-raid.c
> > +++ b/drivers/md/dm-raid.c
> > @@ -3796,8 +3796,10 @@ static void raid_postsuspend(struct dm_target *t=
i)
> >          struct raid_set *rs =3D ti->private;
> >
> >          if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags=
)) {
> > +               if (test_bit(MD_RECOVERY_WAIT, &rs->md.recovery))
> > +                       clear_bit(MD_RECOVERY_WAIT, &rs->md.recovery);
>
> You must make sure md_do_sync() is called after this if sync_thread is
> already registered, and I don't understand yet how this is guranteed. :(

md_stop_writes -> __md_stop_writes -> stop_sync_thread guarantee this.

Best Regards
Xiao
>
> Thanks,
> Kuai
>
> >
> > Regards
> > Xiao
> >>
> >>          if (mddev_is_clustered(mddev)) {
> >> --
> >> 2.39.2
> >>
> >
> > .
> >
>


