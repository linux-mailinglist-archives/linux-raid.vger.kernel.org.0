Return-Path: <linux-raid+bounces-137-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B695F808935
	for <lists+linux-raid@lfdr.de>; Thu,  7 Dec 2023 14:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08731C20B14
	for <lists+linux-raid@lfdr.de>; Thu,  7 Dec 2023 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1E40BE7;
	Thu,  7 Dec 2023 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOFJzf2s"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5AAAA;
	Thu,  7 Dec 2023 05:31:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d076ebf79cso6555495ad.1;
        Thu, 07 Dec 2023 05:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701955865; x=1702560665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aev9J6mN2EY8+FG61FYKOaENAqi2oXGAi8qvYOhlJAU=;
        b=WOFJzf2sA6h8R8SmeyQsBb8IE6guq+SAXKFGSE65oC4qLjegu8+CRBADT8SCdx0i6j
         4fiVf/VgzG8YNa4GZwi1RM0CID562+CDUeBrI6wAkXXWOMungbLLJea6ScgM9h407g0U
         SspvkCji/S6NWyfagW7xI3sP2llxeEjOlJW7x0xPNJrO6qQ07XfthF+n/fVJUM5BD2sk
         8A1NWDO5uH6w6SDJR9CGhsOw3VgIAAVH8SobR+1OYXccZEUhS+6C3PrEGLcZ2PK+qqdG
         lW/6NT3O45fJJTp3hDzdmU5TzxVqKwJ2eRHuvz6vNk52+gzNkvxW7ofUkahbGvK+Vf/R
         BY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955865; x=1702560665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aev9J6mN2EY8+FG61FYKOaENAqi2oXGAi8qvYOhlJAU=;
        b=qflZ6A7WR4NLv9sCebLG64e13fz/y/mfr6uuQvMbHnQZLcPZ6Ek5K7FK+n7iflePmy
         iOC8f374ETh+z/y4or/tUtLEmFZtzg+BAP5W275zsFnmjCkdarp2uzk/Qv7QSCF9jP1P
         wTlOeEkmRML9u9ShJ2nlVZADFCelmKkgl+sei0dtcojoZ0jeLjZggoto2ISFwdWnR7N9
         1wAEhoLdC2zachviZ4+5vFuwP8/tO/ufZ5BxH/RGe13P4qFH7O6Hia2rgrslplWDlaKb
         Ra8cgpebl6IbOaGssbRzB/tCejx9bUCP6z8ZBT+ie7qTCWfgCeM6+71KwEl88JRVv8Jl
         IRVw==
X-Gm-Message-State: AOJu0Yxt/y8X63cLQ0beCypQCa6GXJYyXiz9or8ct9wviph0E0nLpoXt
	jolenuoVgGjRiOGlBD14ptE=
X-Google-Smtp-Source: AGHT+IEwD/bOrKkf+MTY2Jfymyu7xY1uDt3c1uWVfPutZE2vbgmS7Lw9dpGDotzR6/1+XHwx0ZZpDw==
X-Received: by 2002:a17:902:9a42:b0:1d0:d196:2658 with SMTP id x2-20020a1709029a4200b001d0d1962658mr1790745plv.19.1701955865287;
        Thu, 07 Dec 2023 05:31:05 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id hi16-20020a17090b30d000b00286bd821426sm1345976pjb.26.2023.12.07.05.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:31:04 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 2653E119A3A33; Thu,  7 Dec 2023 20:30:58 +0700 (WIB)
Date: Thu, 7 Dec 2023 20:30:58 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Genes Lists <lists@sapience.com>, snitzer@kernel.org, song@kernel.org,
	yukuai3@huawei.com, axboe@kernel.dk, mpatocka@redhat.com,
	heinzm@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux RAID <linux-raid@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>
Cc: Bhanu Victor DiCara <00bvd0+linux@gmail.com>, Xiao Ni <xni@redhat.com>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: md raid6 oops in 6.6.4 stable
Message-ID: <ZXHJEkwIJ5zKTMjV@archie.me>
References: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhpqYfwBnN+2BHNb"
Content-Disposition: inline
In-Reply-To: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>


--jhpqYfwBnN+2BHNb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 08:10:04AM -0500, Genes Lists wrote:
> I have not had chance to git bisect this but since it happened in stable I
> thought it was important to share sooner than later.
>=20
> One possibly relevant commit between 6.6.3 and 6.6.4 could be:
>=20
>   commit 2c975b0b8b11f1ffb1ed538609e2c89d8abf800e
>   Author: Song Liu <song@kernel.org>
>   Date:   Fri Nov 17 15:56:30 2023 -0800
>=20
>     md: fix bi_status reporting in md_end_clone_io
>=20
> log attached shows page_fault_oops.
> Machine was up for 3 days before crash happened.
>=20

Can you confirm that culprit by bisection?

--=20
An old man doll... just what I always wanted! - Clara

--jhpqYfwBnN+2BHNb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXHJDwAKCRD2uYlJVVFO
o2gqAP0RyiWVKDs1YHLmQEmMkdQ/Vg+D+akWMv/vR0dA4KyRhwEAlUX/G5NLLPjg
iAaaSETn92ArdnUKGhw2wCNijuF20Q8=
=utvD
-----END PGP SIGNATURE-----

--jhpqYfwBnN+2BHNb--

