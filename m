Return-Path: <linux-raid+bounces-1884-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69279058DF
	for <lists+linux-raid@lfdr.de>; Wed, 12 Jun 2024 18:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A781B1C21A61
	for <lists+linux-raid@lfdr.de>; Wed, 12 Jun 2024 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59077181325;
	Wed, 12 Jun 2024 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOnDHDkV"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C3181306;
	Wed, 12 Jun 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210080; cv=none; b=Z1+T4t7N1Dm+MRfbMmRDPknDHz4wPyF9A/CB7QLwb3ygYDMflLygQ1tNH5pmtFH8eJbpvB83cx2p4yPxdQNcd0bK28zSzghwRJZVlu/JYyalolFfKd3ccHnYsTQHseQiINOS8XdJsr4N0+CPrc5E7f6lY5Lc0dp6pghP0Rnwf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210080; c=relaxed/simple;
	bh=F/iQyB6SBb2pGFv8ok+kaiPv97yhfzwveuBMHXXXt28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQQYQhg06XrY2CSP3QnnIaCWV3jq0ykGePT5EQmfeMtuRB9oeiqbC4PUIg1AuVTmN3XJqjf96sGZkN/5icU901WttX343Wg8yp/sp9mEcEgiccISK+kX3eN/YFj5ZEeZF8+/ROAsE9xKmOkVUSenihe20hAs/PhmawWsrEW6DX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOnDHDkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CD4C4AF4D;
	Wed, 12 Jun 2024 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718210079;
	bh=F/iQyB6SBb2pGFv8ok+kaiPv97yhfzwveuBMHXXXt28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UOnDHDkVgdAkELWDJzY3QDQGnT9j1i/Cpd0EcbWBhu2Mao2cduOLF2SBZUsx8GH68
	 QSfPq45Makorq16R1JtF2osfS7fFJB6IiiquKDrcNxxhxGxR038rp7WWkKvPJrsn0F
	 iKBGbC5wxrfqtYovSZ1JB+yhOUptl4Mf1Jwnt+297KlQvNNtXpJ/CRn4eypmcb5HjM
	 Ea4dy1tredWxNrmMOsrPY3rtQDzcZzrFN8tRRIlUevXDK09iQBeJGG5DC8AYTdCHxM
	 POHo8hxPeKkk3lB9/ZqEJEvbc8i7aa2vftvxdo+UdGtlwJBDg7/+vuFuze6jLxd7Ff
	 sGfyUBYNcXMPA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebed33cbaeso26311871fa.1;
        Wed, 12 Jun 2024 09:34:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdmnI2ml1dZ/5NabWLa3nlNJQ8O5OhOrzUFw8dIMk/kAtkfA4tAA+z4Qkk8yAYXLDk3t7uozrDNx1WtCleR+kVXHduIsq0mihh23ohfjAUTxaHXYRa2rUuOhk6UX0c4F1jXHsuHPGxLQ==
X-Gm-Message-State: AOJu0Yw/VaMxjnbQFpBWoHOzJO3GQ2DDGBX5iS7CY/IR21j0ONItQL6J
	qp8l7kr/9ax5u3hS2zpm5BmIga0tuzc+S2YuYTgS9bzTGXthOCr9ao5Q6nZ9J6XRD1iLuUMn4DB
	5DjX7WWr92P6AfuyMljaYEjOi5v8=
X-Google-Smtp-Source: AGHT+IEA+KG+1p25ewpxhsKkVZ6R9CUyIVzpnD0XbAGoF+BMqPkMwxpgLTdrIDkxHWoHd8Z50eIIul5aDP4tlIVAufU=
X-Received: by 2002:a05:651c:19a9:b0:2eb:f2cf:1e49 with SMTP id
 38308e7fff4ca-2ebfc9bbf44mr16842341fa.2.1718210077883; Wed, 12 Jun 2024
 09:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611132251.1967786-1-yukuai1@huaweicloud.com> <12441f87-6e61-4618-a2f5-a2b2b202b26e@molgen.mpg.de>
In-Reply-To: <12441f87-6e61-4618-a2f5-a2b2b202b26e@molgen.mpg.de>
From: Song Liu <song@kernel.org>
Date: Wed, 12 Jun 2024 09:34:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Lz0-WBK=aSoHWpx6iEWfEhkdkJ+s3MmkDcFKA4Bq84w@mail.gmail.com>
Message-ID: <CAPhsuW7Lz0-WBK=aSoHWpx6iEWfEhkdkJ+s3MmkDcFKA4Bq84w@mail.gmail.com>
Subject: Re: [PATCH v2 md-6.11 00/12] md: refacotor and some fixes related to sync_thread
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, xni@redhat.com, mariusz.tkaczyk@linux.intel.com, 
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 7:11=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
[...]
> >    md: use new helers in md_do_sync()
>
> hel*p*ers
>

Fixed this typo and applied to md-6.11. Thanks!

Song

