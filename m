Return-Path: <linux-raid+bounces-1090-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C9386FBD2
	for <lists+linux-raid@lfdr.de>; Mon,  4 Mar 2024 09:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA9E1B2220A
	for <lists+linux-raid@lfdr.de>; Mon,  4 Mar 2024 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F5175BB;
	Mon,  4 Mar 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbpKGmRJ"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0117565
	for <linux-raid@vger.kernel.org>; Mon,  4 Mar 2024 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540894; cv=none; b=cFhoEXU0nRS1At7+7gErdNX7IqLjHoKoZ7zej2rSMIdEaxEKrif2omHJH7cxpD6y89abjwGmroDU97h97v0T/4Htxr7XbErgZymkbgDbNe9HWspe2LH9Wxl9d5z1sswRMiiwu08ia69QUqZlhwkiJtZmRYfa/Cn2/cUTMHeTvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540894; c=relaxed/simple;
	bh=u7PA1inbQXG9P6FLvLTgHGbE5x9WuMpt6Yi47NSpsZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoKEWz1zvMnkm386w76nwUSHj11CW1gIuyM4xWBRGr/+2NeFkd4exoPkfnFDVjrqzCvwOUVVmIFTAc3raPj7wOhCDY1wOUNHf/RibcUHGvSpZbpDuHa7jfLK6er14RSkZluqB7QM4ZZv/nDvu4C09bNmQckXNHnhzKHg3Slnw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbpKGmRJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709540892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XD+3ruqEUG2dUbV3hbDyZxaZ8/xiFwRXERewdKjsKNs=;
	b=JbpKGmRJaYP71+Om1qwre6u8OUDUlny6rL562cEooNCzK30y9tlOcRA66Z1x59/ON0LEdU
	Y36QG3GdDWgL9Phyz4udhPrdnulGUIJU4IRhGI+sxjEkXn0Ra3ecf3w1zGqT4XztCz8fE7
	S0hQ82JeePsVTSbozcCioEmnqi/WD6Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-col8CsohOC6wwZvjNRBw5g-1; Mon, 04 Mar 2024 03:28:09 -0500
X-MC-Unique: col8CsohOC6wwZvjNRBw5g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cfda2f4716so2852517a12.3
        for <linux-raid@vger.kernel.org>; Mon, 04 Mar 2024 00:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540889; x=1710145689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XD+3ruqEUG2dUbV3hbDyZxaZ8/xiFwRXERewdKjsKNs=;
        b=WF3RTth2g4R4libbuVKafYo/v0eBBGOeqknqxtFkUxzi/2kt1UTl4RTJS87ojYctxZ
         /uMAwERaEh1YhxkHwJPS9ax80qHUSzCFB1B/cHnACMWkiQycncfnpeg1//58MMwNbvXa
         7cNTM6eLbY3b9oj4KXHW5pf05W6/PcUxKnxt6ubQpQJlP5n206dm+G8lSDVcmHqwVoOl
         4nmvt76a6YYGRQVLBbTj3YS6H2y772c4cN0ysB9fBlSw8R5tgwx3jiXIRuQ9cQ1WsG0t
         X8n/6gheU5sYSZSkDlEAu2i41QodInpM23hLwRSv0DU9GLcFD/BJ+zjiqDoKrUt18pkY
         Ov9w==
X-Forwarded-Encrypted: i=1; AJvYcCUzUqESHDSZCckyBVPYPBhY3Dcg54wwNHmWZssEUhignSGBd8zGPQuVfS6zGQPHVeuZy58/Tnv5Rnc5ILj6QmDz/7dLYa1xn+nmpw==
X-Gm-Message-State: AOJu0YwnJwGSXPcpGSmH/v8momQCuhM9iqXtW4GuvtVS4bHRNqT1Dg+p
	/8N0X54dCWathTWQ9Vm92YBchqIJK88Xb/ULGsGLzVLQG6qOyI54iNkbt5JndL4XItJYamhymmb
	EG+z0+i5IkiRqfok7QSOQDudYj2MsSqAk6jR84NNF+MJ4XS/afD7eAD9NuJQC4CKaP3SdCfpwYV
	+ZqFyFEKdrKlF4HlMOyxXltiuqmRvjy2+bRw==
X-Received: by 2002:a05:6a20:e616:b0:1a1:4757:927e with SMTP id my22-20020a056a20e61600b001a14757927emr3334942pzb.33.1709540888916;
        Mon, 04 Mar 2024 00:28:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAsbxaG9JxwroOqxa4qnjMmyKIDvQX9MmW5DBEgp2D53RKgUcHFHs8chdn2MoCCL7AFcDGahEh7Xvoq/EnvCU=
X-Received: by 2002:a05:6a20:e616:b0:1a1:4757:927e with SMTP id
 my22-20020a056a20e61600b001a14757927emr3334924pzb.33.1709540888568; Mon, 04
 Mar 2024 00:28:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301095657.662111-1-yukuai1@huaweicloud.com>
 <CALTww2-GV-YBX1ey4juaVHjHz-wNS0xRBqBn=ucDXEb4WNbSOg@mail.gmail.com>
 <0091f7d1-2273-16ff-8285-5fa3f7e2e0f7@huaweicloud.com> <35feaa54-db9e-f0d6-d5a5-a10a45bb90a5@huaweicloud.com>
 <CALTww2-BmudurHbsbbqBMq+KgZs+hokqOJnovS5KDGEidHqZzA@mail.gmail.com>
In-Reply-To: <CALTww2-BmudurHbsbbqBMq+KgZs+hokqOJnovS5KDGEidHqZzA@mail.gmail.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 4 Mar 2024 16:27:57 +0800
Message-ID: <CALTww2_tP9kZEeReystMVLT+UqE7gpHvLO6yrSJ_bjsfTOuaxQ@mail.gmail.com>
Subject: Re: [PATCH -next 0/9] dm-raid, md/raid: fix v6.7 regressions part2
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: zkabelac@redhat.com, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, dm-devel@lists.linux.dev, song@kernel.org, 
	heinzm@redhat.com, neilb@suse.de, jbrassow@redhat.com, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:25=E2=80=AFAM Xiao Ni <xni@redhat.com> wrote:
>
> On Mon, Mar 4, 2024 at 9:24=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
> >
> > Hi,
> >
> > =E5=9C=A8 2024/03/04 9:07, Yu Kuai =E5=86=99=E9=81=93:
> > > Hi,
> > >
> > > =E5=9C=A8 2024/03/03 21:16, Xiao Ni =E5=86=99=E9=81=93:
> > >> Hi all
> > >>
> > >> There is a error report from lvm regression tests. The case is
> > >> lvconvert-raid-reshape-stripes-load-reload.sh. I saw this error when=
 I
> > >> tried to fix dmraid regression problems too. In my patch set,  after
> > >> reverting ad39c08186f8a0f221337985036ba86731d6aafe (md: Don't regist=
er
> > >> sync_thread for reshape directly), this problem doesn't appear.
> > >
>
> Hi Kuai
> > > How often did you see this tes failed? I'm running the tests for over
> > > two days now, for 30+ rounds, and this test never fail in my VM.
>
> I ran 5 times and it failed 2 times just now.
>
> >
> > Take a quick look, there is still a path from raid10 that
> > MD_RECOVERY_FROZEN can be cleared, and in theroy this problem can be
> > triggered. Can you test the following patch on the top of this set?
> > I'll keep running the test myself.
>
> Sure, I'll give the result later.

Hi all

It's not stable to reproduce this. After applying this raid10 patch it
failed once 28 times. Without the raid10 patch, it failed once 30
times, but it failed frequently this morning.

Regards
Xiao
>
> Regards
> Xiao
> >
> > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > index a5f8419e2df1..7ca29469123a 100644
> > --- a/drivers/md/raid10.c
> > +++ b/drivers/md/raid10.c
> > @@ -4575,7 +4575,8 @@ static int raid10_start_reshape(struct mddev *mdd=
ev)
> >          return 0;
> >
> >   abort:
> > -       mddev->recovery =3D 0;
> > +       if (mddev->gendisk)
> > +               mddev->recovery =3D 0;
> >          spin_lock_irq(&conf->device_lock);
> >          conf->geo =3D conf->prev;
> >          mddev->raid_disks =3D conf->geo.raid_disks;
> >
> > Thanks,
> > Kuai
> > >
> > > Thanks,
> > > Kuai
> > >
> > >>
> > >> I put the log in the attachment.
> > >>
> > >> On Fri, Mar 1, 2024 at 6:03=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.=
com> wrote:
> > >>>
> > >>> From: Yu Kuai <yukuai3@huawei.com>
> > >>>
> > >>> link to part1:
> > >>> https://lore.kernel.org/all/CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DU=
q_kSN-Q3G66Q@mail.gmail.com/
> > >>>
> > >>>
> > >>> part1 contains fixes for deadlocks for stopping sync_thread
> > >>>
> > >>> This set contains fixes:
> > >>>   - reshape can start unexpected, cause data corruption, patch 1,5,=
6;
> > >>>   - deadlocks that reshape concurrent with IO, patch 8;
> > >>>   - a lockdep warning, patch 9;
> > >>>
> > >>> I'm runing lvm2 tests with following scripts with a few rounds now,
> > >>>
> > >>> for t in `ls test/shell`; do
> > >>>          if cat test/shell/$t | grep raid &> /dev/null; then
> > >>>                  make check T=3Dshell/$t
> > >>>          fi
> > >>> done
> > >>>
> > >>> There are no deadlock and no fs corrupt now, however, there are sti=
ll
> > >>> four
> > >>> failed tests:
> > >>>
> > >>> ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.s=
h
> > >>> ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
> > >>> ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
> > >>> ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
> > >>>
> > >>> And failed reasons are the same:
> > >>>
> > >>> ## ERROR: The test started dmeventd (147856) unexpectedly
> > >>>
> > >>> I have no clue yet, and it seems other folks doesn't have this issu=
e.
> > >>>
> > >>> Yu Kuai (9):
> > >>>    md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume
> > >>>    md: export helpers to stop sync_thread
> > >>>    md: export helper md_is_rdwr()
> > >>>    md: add a new helper reshape_interrupted()
> > >>>    dm-raid: really frozen sync_thread during suspend
> > >>>    md/dm-raid: don't call md_reap_sync_thread() directly
> > >>>    dm-raid: add a new helper prepare_suspend() in md_personality
> > >>>    dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io
> > >>>      concurrent with reshape
> > >>>    dm-raid: fix lockdep waring in "pers->hot_add_disk"
> > >>>
> > >>>   drivers/md/dm-raid.c | 93 ++++++++++++++++++++++++++++++++++-----=
-----
> > >>>   drivers/md/md.c      | 73 ++++++++++++++++++++++++++--------
> > >>>   drivers/md/md.h      | 38 +++++++++++++++++-
> > >>>   drivers/md/raid5.c   | 32 ++++++++++++++-
> > >>>   4 files changed, 196 insertions(+), 40 deletions(-)
> > >>>
> > >>> --
> > >>> 2.39.2
> > >>>
> > >
> > >
> > > .
> > >
> >


