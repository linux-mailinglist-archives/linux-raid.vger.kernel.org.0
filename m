Return-Path: <linux-raid+bounces-124-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871888069A2
	for <lists+linux-raid@lfdr.de>; Wed,  6 Dec 2023 09:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318721F2156B
	for <lists+linux-raid@lfdr.de>; Wed,  6 Dec 2023 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3619474;
	Wed,  6 Dec 2023 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqx5nB+r"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75295199CB
	for <linux-raid@vger.kernel.org>; Wed,  6 Dec 2023 08:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F00C433CC;
	Wed,  6 Dec 2023 08:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701851424;
	bh=2Ssj5YUmv6lG6OJxBgL50SSR8d7iwn+K/ZH1lXrYlrc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jqx5nB+rhml1pykCKfYXigHkaf1Nx69YuOAsVEBxz/FiBHYcT48elI7UV7fe9IkqR
	 TDBZHyRjo3VFm9IFTAk9fjNLa2cRgBp+Z3CgMEPjQsRdJY2iijfrKYRFrvASQXtxIX
	 36OpHvBymRrwFS7cpCKMw80EN/14XoEgUtj/sQGur4fP2mOPdiG/tqnIJJLOsaGNl7
	 /uZpu8tnod6Cme+p5IrG+MwxlpN4hxnyH5dLCo4KiRP5toxj4sYGyX8gYb8d/VvwA8
	 HjRsRyuk82fJXV7VvqMs6lhKdTnHDEP+dEtOoFi4pDpIqY6keXkuxFX8FN8r3m1NfC
	 QygRug+Zok4zw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c9f84533beso43326811fa.1;
        Wed, 06 Dec 2023 00:30:23 -0800 (PST)
X-Gm-Message-State: AOJu0YxFzyh+HStf3ueZi+IpXuzIM5+ASEl6FLyKsJLT1mkVxwAelG6W
	J6OWErRpG+pFKLdEjavR0aOby6qUyIJTpGmcu6k=
X-Google-Smtp-Source: AGHT+IF1OUe1/TjSE0apOYF5L1Q1hcoDIF0OrfSgzvb4nvicdqGHKa4iFhq04MNIFNKY0rvWn2zy1szgORvQ/lbkhrc=
X-Received: by 2002:a2e:8088:0:b0:2ca:de:e2c5 with SMTP id i8-20020a2e8088000000b002ca00dee2c5mr338458ljg.57.1701851422228;
 Wed, 06 Dec 2023 00:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204031703.3102254-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231204031703.3102254-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Wed, 6 Dec 2023 00:30:10 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4sF=jAyA+Q=2tFBBAApjcW=gWXndDNX6t3nrAfnk_zZA@mail.gmail.com>
Message-ID: <CAPhsuW4sF=jAyA+Q=2tFBBAApjcW=gWXndDNX6t3nrAfnk_zZA@mail.gmail.com>
Subject: Re: [PATCH -next] md: split MD_RECOVERY_NEEDED out of mddev_resume
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	dm-devel@lists.linux.dev, yukuai3@huawei.com, janpieter.sollie@edpnet.be, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 3, 2023 at 7:18=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> New mddev_resume() calls are added to synchroniza IO with array
> reconfiguration, however, this introduce a regression while adding it in
> md_start_sync():
>
> 1) someone set MD_RECOVERY_NEEDED first;
> 2) daemon thread grab reconfig_mutex, then clear MD_RECOVERY_NEEDED and
>    queue a new sync work;
> 3) daemon thread release reconfig_mutex;
> 4) in md_start_sync
>    a) check that there are spares that can be added/removed, then suspend
>       the array;
>    b) remove_and_add_spares may not be called, or called without really
>       add/remove spares;
>    c) resume the array, then set MD_RECOVERY_NEEDED again!
>
> Loop between 2 - 4, then mddev_suspend() will be called quite often, for
> consequence, normal IO will be quite slow.
>
> Fix this problem by spliting MD_RECOVERY_NEEDED out of mddev_resume(), so
> that md_start_sync() won't set such flag and hence the loop will be broke=
n.

I hope we don't leak set_bit MD_RECOVERY_NEEDED to all call
sites of mddev_resume().

How about something like the following instead?

Please also incorporate feedback from Paul in the next version.

Thanks,
Song

diff --git i/drivers/md/md.c w/drivers/md/md.c
index c94373d64f2c..2d53e1b57070 100644
--- i/drivers/md/md.c
+++ w/drivers/md/md.c
@@ -490,7 +490,7 @@ int mddev_suspend(struct mddev *mddev, bool interruptib=
le)
 }
 EXPORT_SYMBOL_GPL(mddev_suspend);

-void mddev_resume(struct mddev *mddev)
+static void __mddev_resume(struct mddev *mddev, bool recovery_needed)
 {
        lockdep_assert_not_held(&mddev->reconfig_mutex);

@@ -507,12 +507,18 @@ void mddev_resume(struct mddev *mddev)
        percpu_ref_resurrect(&mddev->active_io);
        wake_up(&mddev->sb_wait);

-       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+       if (recovery_needed)
+               set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
        md_wakeup_thread(mddev->thread);
        md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshap=
e */

        mutex_unlock(&mddev->suspend_mutex);
 }
+
+void mddev_resume(struct mddev *mddev)
+{
+       __mddev_resume(mddev, true);
+}
 EXPORT_SYMBOL_GPL(mddev_resume);

 /*
@@ -9403,7 +9409,9 @@ static void md_start_sync(struct work_struct *ws)
                goto not_running;
        }

-       suspend ? mddev_unlock_and_resume(mddev) : mddev_unlock(mddev);
+       mddev_unlock(mddev);
+       if (suspend)
+               __mddev_resume(mddev, false);
        md_wakeup_thread(mddev->sync_thread);
        sysfs_notify_dirent_safe(mddev->sysfs_action);
        md_new_event();
@@ -9415,7 +9423,9 @@ static void md_start_sync(struct work_struct *ws)
        clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
        clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
        clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-       suspend ? mddev_unlock_and_resume(mddev) : mddev_unlock(mddev);
+       mddev_unlock(mddev);
+       if (suspend)
+               __mddev_resume(mddev, false);

        wake_up(&resync_wait);
        if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &&

