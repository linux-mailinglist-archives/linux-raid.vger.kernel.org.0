Return-Path: <linux-raid+bounces-329-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0782C446
	for <lists+linux-raid@lfdr.de>; Fri, 12 Jan 2024 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93856B212B7
	for <lists+linux-raid@lfdr.de>; Fri, 12 Jan 2024 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFAF1B5B3;
	Fri, 12 Jan 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRVpXWqf"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAAF1B5A9;
	Fri, 12 Jan 2024 17:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFB1C433F1;
	Fri, 12 Jan 2024 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079297;
	bh=sE1TCe80xpKNIxZm8GXM9fLcVkdAEX6Fc2Z2vgDhElE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fRVpXWqf2aJoqxFaPcC1R/GyqHT2YPwwGsRWgDYpzhmMgdGZFpjWwbLFWPOax0zm/
	 VSJoaHnAemwwPl1vsNnoTON0lJfGtVHQ0UK+YpnR4qBAwS7OXZdp2nIssn4qlN8BH4
	 QiypiMwBewbX5T+eHf09P3XzL7Fb+rcLUOXV1c7FC9eZU0i05tNe8Fe1F9zVhYwOBu
	 KtBjyXP2C1AMrvKkwJUCoZmTzRAhfefsAQIhYcqRWK/JBk7JMcBAEYMZl7nYmAVuxg
	 t3yuDgB7Kp+LHqBmH/wFPMzGeIXa28npbPi52xs6/WQpTmd8/JH6xPQRI7UscTkFNf
	 iw8gIfpvYEUiA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd7e429429so35774721fa.1;
        Fri, 12 Jan 2024 09:08:17 -0800 (PST)
X-Gm-Message-State: AOJu0YzAZLTUoELgRxHU3+d3D2VP1pWsp1YntgxYHairS//G87qsraFx
	GPOLhaOnCFrZrlnEnfmIbH4u3C6EyG24+nAfhCs=
X-Google-Smtp-Source: AGHT+IHyAqay9dvgUNhPdxBClQnLJFRhZs6TShMRqnoDzO/tn6LzEQj4Bd27DfAjV2Uk0jCL5TT4pF5PbmXdq+XuE5w=
X-Received: by 2002:a05:6512:74:b0:50e:69df:b067 with SMTP id
 i20-20020a056512007400b0050e69dfb067mr767864lfo.11.1705079295776; Fri, 12 Jan
 2024 09:08:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214222107.2016042-1-song@kernel.org> <20231214222107.2016042-2-song@kernel.org>
 <CAMuHMdUtzhwHLa_DTtH00YsZ6t_CefZjZj6oS_mpckHDNXpYWw@mail.gmail.com>
In-Reply-To: <CAMuHMdUtzhwHLa_DTtH00YsZ6t_CefZjZj6oS_mpckHDNXpYWw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 12 Jan 2024 09:08:04 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6KVN1c=dB1RXVQjygBevVcb_1qQJoLz3zA-qTVVmbCAw@mail.gmail.com>
Message-ID: <CAPhsuW6KVN1c=dB1RXVQjygBevVcb_1qQJoLz3zA-qTVVmbCAw@mail.gmail.com>
Subject: Re: [PATCH 1/3] md: Remove deprecated CONFIG_MD_LINEAR
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Neil Brown <neilb@suse.de>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Mateusz Grzonka <mateusz.grzonka@intel.com>, Jes Sorensen <jes@trained-monkey.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Fri, Jan 12, 2024 at 1:28=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
[...]
>
> > --- a/drivers/md/Kconfig
> > +++ b/drivers/md/Kconfig
> > @@ -61,19 +61,6 @@ config MD_BITMAP_FILE
> >           various kernel APIs and can only work with files on a file sy=
stem not
> >           actually sitting on the MD device.
> >
> > -config MD_LINEAR
> > -       tristate "Linear (append) mode (deprecated)"
> > -       depends on BLK_DEV_MD
> > -       help
> > -         If you say Y here, then your multiple devices driver will be =
able to
> > -         use the so-called linear mode, i.e. it will combine the hard =
disk
> > -         partitions by simply appending one to the other.
> > -
> > -         To compile this as a module, choose M here: the module
> > -         will be called linear.
> > -
> > -         If unsure, say Y.
> > -
>
> Is this what you need to recover data from disks salvaged from a
> commercial NAS configured in JBOD mode?
> If yes, and there is no better way to do that, you probably do not
> want to drop this support.  Actual NAS systems running Linux might
> use this as well.

Thanks for the heads-up. I honestly don't know about this use case.
Where can I find/get more information about it?

Thanks,
Song

