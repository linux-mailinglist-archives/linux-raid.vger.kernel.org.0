Return-Path: <linux-raid+bounces-1023-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E135586D806
	for <lists+linux-raid@lfdr.de>; Fri,  1 Mar 2024 00:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E22845F5
	for <lists+linux-raid@lfdr.de>; Thu, 29 Feb 2024 23:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6313E7CA;
	Thu, 29 Feb 2024 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaR6HQqD"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441813E7C2
	for <linux-raid@vger.kernel.org>; Thu, 29 Feb 2024 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250355; cv=none; b=SG2SaUbRQS0b5BGJg7f4pvnN2OlCBYmmPL/+hDkIdMFkljg9ouOTSoDkeR54dMr8MUZnxeYUiCOGpjNAuUp9tTu7inlVOdDPHG3Mb+iFo0d2c+Lck+1RNsrWOeGkQiC7FT4zd8CEvrekUXTIInzRtKp2q/xeqqjlB7v4wSCbCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250355; c=relaxed/simple;
	bh=p4bWjwkAddqsWnd0sU1h+SjDM2fvQ16755vN2dKqA6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYa4Euf2DLd7vHAi1FIUvidTC3jSxzT/ZFhGVonuONNLN5k6RgCR4FemcFoWyOfE8UJiJoVn6ipYx3PTRCapAYe173mFCzQXvlJl3PiZs3Pga0dK3GJoM4kH3EjN/i6cCZG6Kndj4Lza6mCiMr4rWyiNNCceQXH99XiKqoiDp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaR6HQqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112CBC433F1
	for <linux-raid@vger.kernel.org>; Thu, 29 Feb 2024 23:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709250355;
	bh=p4bWjwkAddqsWnd0sU1h+SjDM2fvQ16755vN2dKqA6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eaR6HQqDZnh5wP6YqWe0wfGXXBn4qD4xTLtsed/plgzmQ+JMzkdpr7EnaBKaBFphQ
	 T0lSd+2eQ5Xz4HYQmz6SibEEj+VXbvX+g3Hu7CSwdXN8L8Nq0xjqT62V5XXoPPP/Hc
	 YFM/xZUyIkHyfi9cQmcUUIm0CoKpbhdSInenE9fkH7n7UX4dE81uGjPvAwXBBM3AVU
	 dC73YURCF1T5g7hqPpWwkLMvmopN5C3UrdHiblYk17CR7QXyDI6hBgeET+S4rVFmFg
	 n35lzIScRacpTQA9/bewKHSlV4cddwJT4f+Pm54dmMKlylpkyBm7o3IpXu3mvJSWGU
	 FqAp77wcdAcFQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512bd533be0so1897089e87.0
        for <linux-raid@vger.kernel.org>; Thu, 29 Feb 2024 15:45:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXexPBZxgRuLUOtiQBj6IxSBCGKZQg/LC5ZUWG4108iqkO3SIjbBqXParVSTm+WQtmSTCLCYHYmFF6E9DcQDIf+HlBiObRYEhXbXw==
X-Gm-Message-State: AOJu0Yw/SP+7Sj6chbECFq+F3R6qMFI1jua89foDyPF95N0a8OdhuhNt
	kmCnPOHVRjVFMkd6EmJCZd/433eLjpQUWzNJDFFNpb4yEcxVHXOK6SEHI5SLqkzyw7rAanC/APo
	hQKyWi0G3JLmkJToMf3eZfoCbuN0=
X-Google-Smtp-Source: AGHT+IG1c1Zkt0vPo7y5BFGb5qVnqCMJ1Ji4GICBaJAoH/3pULO3nnYOlzaiuiyz3bCdHjrNkQurmrnXWE2UE1wSHOA=
X-Received: by 2002:a05:6512:2118:b0:512:b3a3:4adc with SMTP id
 q24-20020a056512211800b00512b3a34adcmr81919lfr.0.1709250353267; Thu, 29 Feb
 2024 15:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229154941.99557-1-xni@redhat.com> <20240229154941.99557-3-xni@redhat.com>
 <CAPhsuW6j5q+kjJ9Xn0dBmb_TVZC+z8FAjExpQHWO1pCAN_fYtQ@mail.gmail.com>
In-Reply-To: <CAPhsuW6j5q+kjJ9Xn0dBmb_TVZC+z8FAjExpQHWO1pCAN_fYtQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 29 Feb 2024 15:45:41 -0800
X-Gmail-Original-Message-ID: <CAPhsuW60wGMLeOAkOqBJTgVU8qEnQCyRB9+c-f42GHe9ynJxpw@mail.gmail.com>
Message-ID: <CAPhsuW60wGMLeOAkOqBJTgVU8qEnQCyRB9+c-f42GHe9ynJxpw@mail.gmail.com>
Subject: Re: [PATCH 2/6] md: Revert "md: Make sure md_do_sync() will set MD_RECOVERY_DONE"
To: Xiao Ni <xni@redhat.com>
Cc: yukuai1@huaweicloud.com, bmarzins@redhat.com, heinzm@redhat.com, 
	snitzer@kernel.org, ncroxon@redhat.com, linux-raid@vger.kernel.org, 
	dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:53=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Feb 29, 2024 at 7:50=E2=80=AFAM Xiao Ni <xni@redhat.com> wrote:
> >
> > This reverts commit 82ec0ae59d02e89164b24c0cc8e4e50de78b5fd6.
> >
> > The root cause is that MD_RECOVERY_WAIT isn't cleared when stopping rai=
d.
> > The following patch 'Clear MD_RECOVERY_WAIT when stopping dmraid' fixes
> > this problem.
> >
> > Signed-off-by: Xiao Ni <xni@redhat.com>
>
> I think we still need 82ec0ae59d02e89164b24c0cc8e4e50de78b5fd6 or some
> variation of it. Otherwise, we may hit the following deadlock. The test v=
m here
> has 2 raid arrays: one raid5 with journal, and a raid1.
>
> I pushed other patches in the set to the md-6.9-for-hch branch for
> further tests.

Actually, it appears md-6.9-for-hch branch still has this problem. Let me t=
est
more..

Song

