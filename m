Return-Path: <linux-raid+bounces-375-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D1A831070
	for <lists+linux-raid@lfdr.de>; Thu, 18 Jan 2024 01:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C109284E19
	for <lists+linux-raid@lfdr.de>; Thu, 18 Jan 2024 00:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE239E;
	Thu, 18 Jan 2024 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqKwc09g"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E715375
	for <linux-raid@vger.kernel.org>; Thu, 18 Jan 2024 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537166; cv=none; b=FKQrN4ZIUv1oXVf0dlCSA4FhdkXHnfLO5A362gZ6TSBqhyUFWF+99BvDy2oamF5HWBRote4wrDp7Pp0mlEADbVXeZCYXHCQ/cecIMOQeYDZzyl/Hg2knaMPvSQWBotJ306BmyzrBHlH/yO9j9dCf8IkBw4H8dJLK7Lr0kOxeTzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537166; c=relaxed/simple;
	bh=aJVJHY3NRnsPPDENMxonxmkWGceA7EJMSjcQ91JsQrk=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=eZtaOjBykleRRDxA3alQCN28KvrHSHgxAKqA0uuahL0eE7LA2Wp4ZvQs4XewKr+oQui1eLdZmsLYPyI7/X4idfxSGldoXwh0i5KNdgoxmRBT2cDzYiwJLG2J+yQXl1mCojRkMPscizAg62FgJDBeKA/qkAcJ1kyJt5DjcwPLnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqKwc09g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE46DC43394
	for <linux-raid@vger.kernel.org>; Thu, 18 Jan 2024 00:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705537165;
	bh=aJVJHY3NRnsPPDENMxonxmkWGceA7EJMSjcQ91JsQrk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pqKwc09gEZYS8iBcS5Mr8Cnzlz8UUEcTOQ/EC5+Bplw22lQatRi2gOUP6BASDs/Ve
	 0K5w6g/Ht37RJsqOdv/yv1ikk7mnXMiqDqy6UwdyrinaIEXQNaefUunXAgBZSgXc1+
	 4U4lMbULPkBw22VgkO76KSl2Ed+u4/faXmiE1Cnkeen/jSXUuY7SBAmwNh2JwIzeoi
	 ISLxBobJ+eRPMax4tDaLW372RTU1CQeE6u3OHYRXsphYqgZhI6WXe31SbLinQeX5Fa
	 GFxa5kySa90PXsv6OqPTv+nmnPgSPggdrtDtiNyFGSWpklrORs875PTIsOJF+ldvy9
	 U4Yd7HjOXWdag==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso14599669e87.2
        for <linux-raid@vger.kernel.org>; Wed, 17 Jan 2024 16:19:25 -0800 (PST)
X-Gm-Message-State: AOJu0YyJCk3PTM3ALebqNjavc/HfvUAH55BzwQldsS1DcjYlKP958vRA
	le/39Cfsgh7fLN76dfNdO5+qY1tKry+4LOMkoKBtLsc4ZRa+iJX/h9MglqJPVTMk39tioHbQRw8
	KXuK9RoYtJYLvyQK/MS5Wsu+vAmY=
X-Google-Smtp-Source: AGHT+IFE8zKt28H+maScGStQJ27xIRlnBq8ORNmVpdL3fYcb3DoqXrBkLzUDI/fPlbYaZCDNH/Kek17SlPkeWK7suG8=
X-Received: by 2002:a05:6512:3c2:b0:50e:b3bb:12aa with SMTP id
 w2-20020a05651203c200b0050eb3bb12aamr8556lfp.59.1705537163946; Wed, 17 Jan
 2024 16:19:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com> <9801e40-8ac7-e225-6a71-309dcf9dc9aa@redhat.com>
In-Reply-To: <9801e40-8ac7-e225-6a71-309dcf9dc9aa@redhat.com>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Jan 2024 16:19:12 -0800
X-Gmail-Original-Message-ID: <CAPhsuW483DSEvgoT0c-Mo1gdpVKRRLkTxu+kuxYG6k-zew+FFA@mail.gmail.com>
Message-ID: <CAPhsuW483DSEvgoT0c-Mo1gdpVKRRLkTxu+kuxYG6k-zew+FFA@mail.gmail.com>
Subject: Re: [PATCH 3/7] md: test for MD_RECOVERY_DONE in stop_sync_thread
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>, David Jeffery <djeffery@redhat.com>, 
	Li Nan <linan122@huawei.com>, dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	Mike Snitzer <msnitzer@redhat.com>, Heinz Mauelshagen <heinzm@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:19=E2=80=AFAM Mikulas Patocka <mpatocka@redhat.c=
om> wrote:
>
> stop_sync_thread sets MD_RECOVERY_INTR and then waits for
> MD_RECOVERY_RUNNING to be cleared. However, md_do_sync will not clear
> MD_RECOVERY_RUNNING when exiting, it will set MD_RECOVERY_DONE instead.
>
> So, we must wait for MD_RECOVERY_DONE to be set as well.
>
> This patch fixes a deadlock in the LVM2 test shell/integrity-caching.sh.

I am not able to reproduce the issue on 6.7 kernel with
shell/integrity-caching.sh.
I got:

VERBOSE=3D0 ./lib/runner \
        --testdir . --outdir results \
        --flavours ndev-vanilla --only shell/integrity-caching.sh --skip @
running 1 tests
###       passed: [ndev-vanilla] shell/integrity-caching.sh  4:24.225

### 1 tests: 1 passed, 0 skipped, 0 timed out, 0 warned, 0 failed   in  4:2=
4.453
make[1]: Leaving directory '/root/lvm2/test'

Do you see the issue every time with shell/integrity-caching.sh?

Thanks,
Song

>
> sysrq: Show Blocked State
> task:lvm             state:D stack:0     pid:11422  tgid:11422 ppid:1374 =
  flags:0x00004002
> Call Trace:
>  <TASK>
>  __schedule+0x228/0x570
>  schedule+0x29/0xa0
>  schedule_timeout+0x6a/0xd0
>  ? timer_shutdown_sync+0x10/0x10
>  stop_sync_thread+0x141/0x180 [md_mod]
>  ? housekeeping_test_cpu+0x30/0x30
>  __md_stop_writes+0x10/0xd0 [md_mod]
>  md_stop+0x9/0x20 [md_mod]
>  raid_dtr+0x1e/0x60 [dm_raid]
>  dm_table_destroy+0x53/0x110 [dm_mod]
>  __dm_destroy+0x10b/0x1e0 [dm_mod]
>  ? table_clear+0xa0/0xa0 [dm_mod]
>  dev_remove+0xd4/0x110 [dm_mod]
>  ctl_ioctl+0x2e1/0x570 [dm_mod]
>  dm_ctl_ioctl+0x5/0x10 [dm_mod]
>  __x64_sys_ioctl+0x85/0xa0
>  do_syscall_64+0x5d/0x1a0
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org      # v6.7
> Fixes: 130443d60b1b ("md: refactor idle/frozen_sync_thread() to fix deadl=
ock")
>
> ---
>  drivers/md/md.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Index: linux-2.6/drivers/md/md.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/md/md.c
> +++ linux-2.6/drivers/md/md.c
> @@ -4881,7 +4881,8 @@ static void stop_sync_thread(struct mdde
>         if (check_seq)
>                 sync_seq =3D atomic_read(&mddev->sync_seq);
>
> -       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> +       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
> +           test_bit(MD_RECOVERY_DONE, &mddev->recovery)) {
>                 if (!locked)
>                         mddev_unlock(mddev);
>                 return;
> @@ -4901,6 +4902,7 @@ retry:
>
>         if (!wait_event_timeout(resync_wait,
>                    !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
> +                  test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
>                    (check_seq && sync_seq !=3D atomic_read(&mddev->sync_s=
eq)),
>                    HZ / 10))
>                 goto retry;
>

