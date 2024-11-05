Return-Path: <linux-raid+bounces-3105-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9719BC562
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2024 07:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50D71F252AD
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2024 06:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A758841C69;
	Tue,  5 Nov 2024 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="PyrSzZV0"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD5185B6D
	for <linux-raid@vger.kernel.org>; Tue,  5 Nov 2024 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787825; cv=none; b=NXUuHD4+IVoBxK1M2GXdIS0yCy+nLWTluGaJ7/lmLt1Ayu2qwf2qZKfNMBDv8Wj+YNFGwMsoIUXZ8NRPvCyV7PAbsFaadRwEjsPKZRvTLvC/tj6t8yjHKCoB4JgAgQhZrhBCIyyabiAp+Cs3/hwIbWT5q5DXDDGqeRXXhAdoLR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787825; c=relaxed/simple;
	bh=ALL3RN14eIMv1nL9YU9DMAioQ6DAimQuM62kHw3kUZg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s6L8fJWct0M5VeHUcEH2+CZjjzwIwxI8TvSBRgwjDyARQy17D4Y/njCRnyFYNixqVzF0w8DjIsPZjSLQ3Qgh9KGoW38cqI6e/yLxGxbENgjGQ+0iOqK4HLvgAUJsg3W3L1o0bpVkAsK0z4BRPrWJJVkdvQ6dTJtXLBaDACuyyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=PyrSzZV0; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1730787817;
	bh=xjoglT8hV8khoWBC80ryFGUpCCgrCCSJXcC88mYuxSQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=PyrSzZV0oQI80KbfprV9kldqIGPA+f1MWe9v4ClIAhAYRMJKJdlQinCEZsSJU0otp
	 KLMOw40YrELwxCeUwlsGtykNGlaF4PA8agiIwQqeWmW0jF+h4q2D2KYuxU0Xy1BevV
	 9kKAnHa9NPlzKPXKy9eFEOJuXyOyTGpydK+UZqCc=
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: PROBLEM: repeatable lockup on RAID-6 with LUKS dm-crypt on NVMe
 devices when rsyncing many files
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <753611d4-5c54-ee0d-30ab-9321274fd749@huaweicloud.com>
Date: Tue, 5 Nov 2024 07:23:15 +0100
Cc: John Stoffel <john@stoffel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 dm-devel@lists.linux.dev,
 =?utf-8?Q?Dragan_Milivojevi=C4=87?= <galileo@pkm-inc.com>,
 "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A0AE411-B4B8-424A-B9F6-AF933F6544F9@flyingcircus.io>
References: <ADF7D720-5764-4AF3-B68E-1845988737AA@flyingcircus.io>
 <2d85e9ab-1d0f-70a1-fab2-1e469764ef28@huaweicloud.com>
 <3CF4B28B-52D7-414E-96A1-FDFA5A5EF172@flyingcircus.io>
 <3DB33849-56C5-4C5C-BF56-F54205BEFCF2@flyingcircus.io>
 <1f2c74f4-8ba9-1a9f-0c11-018a25e785e5@huaweicloud.com>
 <22A202B1-A802-406F-8F38-F4F486A92F81@flyingcircus.io>
 <45d44ed5-da7c-6480-9143-f611385b2e92@huaweicloud.com>
 <9C03DED0-3A6A-42F8-B935-6EB500F8BCE2@flyingcircus.io>
 <DD99A1F0-56E7-473D-B917-66885810233E@flyingcircus.io>
 <78517565-B1AB-4441-B4F8-EB380E98EB0F@flyingcircus.io>
 <26403.59789.480428.418012@quad.stoffel.home>
 <5fb0a6f0-066d-c490-3010-8a047aae2c29@huaweicloud.com>
 <F8CEEB15-0E3C-4F67-951D-12E165D6CC05@flyingcircus.io>
 <B6D76C57-B940-4BFD-9C40-D6E463D2A09F@flyingcircus.io>
 <5170f0d2-cb0f-2e0f-eb5e-31aa9d6ff65d@huawei.com>
 <2b093abc-cd9a-0b84-bcba-baec689fa153@huaweicloud.com>
 <63DE1813-C719-49B7-9012-641DB3DECA26@flyingcircus.io>
 <F8A5ABD5-0773-414D-BBBC-538481BCD0F4@flyingcircus.io>
 <753611d4-5c54-ee0d-30ab-9321274fd749@huaweicloud.com>
To: Yu Kuai <yukuai1@huaweicloud.com>

Hi

> On 5. Nov 2024, at 02:20, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>=20
> Thanks for the test, and sorry that I just realized my patch doesn't =
fix
> the problem I noticed. :(
>=20
> Please test again with the following patch on the top. I'm confident
> that this is a real problem at least.
>=20
> Thanks for the testing!
> Kuai
>=20
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 04f32173839a..7ec6a5d2d166 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -4042,7 +4042,7 @@ static void handle_stripe_clean_event(struct =
r5conf *conf,
>                             test_bit(R5_SkipCopy, &dev->flags))) {
>                                /* We can return any write requests */
>                                struct bio *wbi, *wbi2;
> -                               bool written =3D false;
> +                               bool written;
>=20
>                                pr_debug("Return write for disc %d\n", =
i);
>                                if (test_and_clear_bit(R5_Discard, =
&dev->flags))
> @@ -4053,6 +4053,7 @@ static void handle_stripe_clean_event(struct =
r5conf *conf,
>                                do_endio =3D true;
>=20
> returnbi:
> +                               written =3D false;
>                                dev->page =3D dev->orig_page;
>                                wbi =3D dev->written;
>                                dev->written =3D NULL;

Heh - I stared at your first patch earlier and had somewhat of a hunch =
that the looping part would need a reset but I didn=E2=80=99t quite =
trust my intuition as I don=E2=80=99t know the code well enough =E2=80=A6 =
;)

I=E2=80=99m booting with this additional change now and will report back =
again later.

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


