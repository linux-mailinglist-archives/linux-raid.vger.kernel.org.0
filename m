Return-Path: <linux-raid+bounces-1025-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD97186D88F
	for <lists+linux-raid@lfdr.de>; Fri,  1 Mar 2024 02:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711802840CC
	for <lists+linux-raid@lfdr.de>; Fri,  1 Mar 2024 01:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A131E891;
	Fri,  1 Mar 2024 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jlu5aGq0"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C42F36
	for <linux-raid@vger.kernel.org>; Fri,  1 Mar 2024 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255531; cv=none; b=LxkU6YIM/hK/ULi4f0ayAGBQD6C3kwU9934R+WxZiSi4gWunHq/gY0wzaWXVA8LOKfKmW6yNApJ4XLcRLAWfgJ9SClIdZoRtg0TivstzQkURBLaBd1ZzzqsaSZsjiNWDzh03xDMWBQf3Af+bk1WI3F7X06FIQnG3w6Fpxvp50Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255531; c=relaxed/simple;
	bh=kojRRMne3pOGB8u5SHqxmBrFkcsDw/5h221mIjYB9sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBIIJZnXBFrc0gvXpgtNtyXEymQ8QckI1aa3r5P57uqE/CHa5qziEmewH/t6zsTpi+8mk2OwuIsCmIOFRSehpAvScP0meIJIaiOYRlCnQ4iBpTWznL2gSihyxeyU86sz9ILveDFa8g5eKzfX2ggSS0YRE6olqYCEy0G++vknPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jlu5aGq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC486C43390
	for <linux-raid@vger.kernel.org>; Fri,  1 Mar 2024 01:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709255530;
	bh=kojRRMne3pOGB8u5SHqxmBrFkcsDw/5h221mIjYB9sk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jlu5aGq0OaJ3VdDh9USSz8KlXGsI+8KE+rq0MWoxZ2vki5Uopls+RCA1vOJJ6J9ip
	 MqU1rSBYsyOxk3jDlTaRwUpVov7rpkYFOfVI8Oj9vS8YOGI/Jj/WLRbCKtz8WqEZFC
	 Flj6Mc9Dp8H+p6359YVVJmjWN29irvnVnqSGAo1hE6YXTdwdiNtPcb+cnkJpExBKtE
	 xyWQiNTat8QISBlLWZPVM4/pL3p/6qB/0NjvTXgQAMDCeUPrXLpC686T1RU2HXO3mh
	 zuEuwunHp30ki+1q/wekwdzcbRWYSaxc/dY+toAJNIksLt18qB3ZLU6DHurhJiXhVv
	 uroti0y3Chc7g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e4f4e463so1519042e87.1
        for <linux-raid@vger.kernel.org>; Thu, 29 Feb 2024 17:12:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAsh92f6U7mUN3s9pskE5u5PzWtY6l5aJYmnEbx1kL7bnAmzZUrC/UaC6hJYuxTe4YYpu38smsn6jdq1IOrMKT2C0AN84z7wAh+g==
X-Gm-Message-State: AOJu0Yw6lpAphimcLsIw2tEgskqh7BQxocAi43wnlSQ6tJFES0/04y3y
	u/piX99Fz6cfJ1fwwFTrLcW5K6hMjwYCDoc+pGmURpifTGAq1hBbDKE2PWsPMQRirEUYhfwZBnE
	o29jJzJ9xj80nnMK5yUFduuqFmYs=
X-Google-Smtp-Source: AGHT+IFUkGT3mVxqpGqLMFWy0AEwbiE1G4ugtEYhgn4QLRHAFKd4eT4faPuISsFOg9hyN6vZ0OGwTSKbxjuRGdWA1zE=
X-Received: by 2002:ac2:5b85:0:b0:512:fd7b:9bf with SMTP id
 o5-20020ac25b85000000b00512fd7b09bfmr173676lfn.43.1709255528744; Thu, 29 Feb
 2024 17:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229154941.99557-1-xni@redhat.com> <20240229154941.99557-3-xni@redhat.com>
 <CAPhsuW6j5q+kjJ9Xn0dBmb_TVZC+z8FAjExpQHWO1pCAN_fYtQ@mail.gmail.com>
 <CAPhsuW60wGMLeOAkOqBJTgVU8qEnQCyRB9+c-f42GHe9ynJxpw@mail.gmail.com> <CALTww28-+EFDEk6EgGurvD=ET2_MBtebg1fp0pe+YPJ5kOn8Qw@mail.gmail.com>
In-Reply-To: <CALTww28-+EFDEk6EgGurvD=ET2_MBtebg1fp0pe+YPJ5kOn8Qw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 29 Feb 2024 17:11:57 -0800
X-Gmail-Original-Message-ID: <CAPhsuW67vkokFA_DFLS2JZGhTH7J0A75FgvrZLVJN-8a2g6b2g@mail.gmail.com>
Message-ID: <CAPhsuW67vkokFA_DFLS2JZGhTH7J0A75FgvrZLVJN-8a2g6b2g@mail.gmail.com>
Subject: Re: [PATCH 2/6] md: Revert "md: Make sure md_do_sync() will set MD_RECOVERY_DONE"
To: Xiao Ni <xni@redhat.com>
Cc: yukuai1@huaweicloud.com, bmarzins@redhat.com, heinzm@redhat.com, 
	snitzer@kernel.org, ncroxon@redhat.com, linux-raid@vger.kernel.org, 
	dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 4:49=E2=80=AFPM Xiao Ni <xni@redhat.com> wrote:
>
> On Fri, Mar 1, 2024 at 7:46=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Feb 29, 2024 at 2:53=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > On Thu, Feb 29, 2024 at 7:50=E2=80=AFAM Xiao Ni <xni@redhat.com> wrot=
e:
> > > >
> > > > This reverts commit 82ec0ae59d02e89164b24c0cc8e4e50de78b5fd6.
> > > >
> > > > The root cause is that MD_RECOVERY_WAIT isn't cleared when stopping=
 raid.
> > > > The following patch 'Clear MD_RECOVERY_WAIT when stopping dmraid' f=
ixes
> > > > this problem.
> > > >
> > > > Signed-off-by: Xiao Ni <xni@redhat.com>
> > >
> > > I think we still need 82ec0ae59d02e89164b24c0cc8e4e50de78b5fd6 or som=
e
> > > variation of it. Otherwise, we may hit the following deadlock. The te=
st vm here
> > > has 2 raid arrays: one raid5 with journal, and a raid1.
> > >
> > > I pushed other patches in the set to the md-6.9-for-hch branch for
> > > further tests.
> >
> > Actually, it appears md-6.9-for-hch branch still has this problem. Let =
me test
> > more..
> >
> > Song
> >
>
> Hi Song
>
> What are the commands you use for testing? Can you reproduce it with
> the 6.6 kernel?

The VM has these two arrays assembled automatically on boot. I can repro
the issue by simply reboot the VM (which triggers stop array on both). So
the repro is basically rebooting the array in a loop via ssh.

For this branch,

https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=3Dmd-6.9=
-for-hch

which has 5 of the 6 patches in these set, I can reproduce the issue. This =
issue
doesn't happen on commit aee93ec0ec79, which is before this set.

Song

