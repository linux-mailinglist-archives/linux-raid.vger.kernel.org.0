Return-Path: <linux-raid+bounces-2460-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9030952C77
	for <lists+linux-raid@lfdr.de>; Thu, 15 Aug 2024 12:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29E4285FE8
	for <lists+linux-raid@lfdr.de>; Thu, 15 Aug 2024 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4B21AC8B8;
	Thu, 15 Aug 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="CCjZOt5N"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22F1AC8B1
	for <linux-raid@vger.kernel.org>; Thu, 15 Aug 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716272; cv=none; b=psR83K4VIWoxRcZpYNzRzDAkBgJxRLo4rB68ZmcAQwFc/HTCKa6QbVE46stgbugdPiormcwghPNteq9CKET+xXHD/pMZM/4plJP5jJqoGOnodLAg13bDGhHUipxTeUZZXltMzOPFsa9JRonuBf+UFsHldzN9Tq+7C+OO9F842qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716272; c=relaxed/simple;
	bh=SmxSNraBrIkoCYkCN/BF6w5+m32rOQ3l4N02lXcNc9I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ATvbyFdgnqT+67GS4d2CIW/x2XTweNplffRrgIZQk5bK/j6zRxOyJhxe/ccAGGuRKx5dQR3mwhoggAOOeg/HYLrOBH6WtnyfalLyvSqxHum+ZeEylYpSVxGz7SqoPnVFyXKe9qxFqcxYZMjtdmDmoZR9b4lnZl7ZeuAar6NuHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=CCjZOt5N; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1723716260;
	bh=SmxSNraBrIkoCYkCN/BF6w5+m32rOQ3l4N02lXcNc9I=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=CCjZOt5NeK/1+009+8Ew8DSAAlcx3KjjAm79757BLSUkL5cJfFCNBw+MZ/Gfs6gX4
	 xiApGHTztY/x+z2aMm2z98MWYdW4XEfrtHtjnhrTl/zvkiWHx4euVYtbisuV68znG5
	 MO7XHCl6fJ3+laP5VnjNLAQqaIr49CLUyhy1wHOs=
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: PROBLEM: repeatable lockup on RAID-6 with LUKS dm-crypt on NVMe
 devices when rsyncing many files
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <CEC90137-09B3-41AA-A115-1C172F9C6C4B@flyingcircus.io>
Date: Thu, 15 Aug 2024 12:03:59 +0200
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 dm-devel@lists.linux.dev,
 "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2F5F9789-1827-4105-934F-516582018540@flyingcircus.io>
References: <ADF7D720-5764-4AF3-B68E-1845988737AA@flyingcircus.io>
 <316050c6-fac2-b022-6350-eaedcc7d953a@huaweicloud.com>
 <58450ED6-EBC3-4770-9C5C-01ABB29468D6@flyingcircus.io>
 <EACD5B78-93F6-443C-BB5A-19C9174A1C5C@flyingcircus.io>
 <22C5E55F-9C50-4DB7-B656-08BEC238C8A7@flyingcircus.io>
 <26291.57727.410499.243125@quad.stoffel.home>
 <2EE0A3CE-CFF2-460C-97CD-262D686BFA8C@flyingcircus.io>
 <1dfc4792-02b2-5b3c-c3d1-bf1b187a182e@huaweicloud.com>
 <4363F3A3-46C2-419E-B43A-4CDA8C293CEB@flyingcircus.io>
 <C832C22B-E720-4457-83C6-CA259AD667B2@flyingcircus.io>
 <e92ccf15-be2a-a1aa-5ea2-a88def82e681@huaweicloud.com>
 <30D680B2-F494-42F5-8498-6ED586E05766@flyingcircus.io>
 <26294.40330.924457.532299@quad.stoffel.home>
 <C9A9855D-B0A2-4B13-947E-01AF5BA6DF04@flyingcircus.io>
 <26298.22106.810744.702395@quad.stoffel.home>
 <EBC67418-E60C-435A-8F63-114C67F07583@flyingcircus.io>
 <CEC90137-09B3-41AA-A115-1C172F9C6C4B@flyingcircus.io>
To: John Stoffel <john@stoffel.org>

Hi,

small insight: even given my dataset that can reliably trigger this =
(after around 1.5 hours of rsyncing) it does not trigger on a specific =
set of files. I=E2=80=99ve deleted the data and started the rsync on a =
fresh directory (not a fresh filesystem, I can=E2=80=99t delete that as =
it carries important data) but it doesn=E2=80=99t always get stuck on =
the same files, even though rsync processes them in a repeatable order.

I=E2=80=99m wondering how to generate more insights from that. Maybe =
keeping a blktrace log might help?=20

It sounds like the specific pattern relies on XFS doing a specific thing =
there =E2=80=A6=20

Wild idea: maybe running the xfstest suite on an in-memory raid 6 setup =
could reproduce this?

I=E2=80=99m guessing that the xfs people do not regularly run their test =
suite on a layered setup like mine with encryption and software raid?
=20
Christian

> On 15. Aug 2024, at 08:19, Christian Theune <ct@flyingcircus.io> =
wrote:
>=20
> Hi,
>=20
>> On 14. Aug 2024, at 10:53, Christian Theune <ct@flyingcircus.io> =
wrote:
>>=20
>> Hi,
>>=20
>>> On 12. Aug 2024, at 20:37, John Stoffel <john@stoffel.org> wrote:
>>>=20
>>> I'd probably just do the RAID6 tests first, get them out of the way. =
=20
>>=20
>> Alright, those are running right now - I=E2=80=99ll let you know what =
happens.
>=20
> I=E2=80=99m not making progress here. I can=E2=80=99t reproduce those =
on in-memory loopback raid 6. However: i can=E2=80=99t fully produce the =
rsync. For me this only triggered after around 1.5hs of progress on the =
NVMe which resulted in the hangup. I can only create around 20 GiB worth =
of raid 6 volume on this machine. I=E2=80=99ve tried running rsync until =
it exhausts the space, deleting the content and running rsync again, but =
I feel like this isn=E2=80=99t suffient to trigger the issue. :(
>=20
> I=E2=80=99m trying to find whether any specific pattern in the files =
around the time it locks up might be relevant here and try to run the =
rsync over that=20
> portion.
>=20
> On the plus side, I have a script now that can create the various =
loopback settings quickly, so I can try out things as needed. Not that =
valuable without a reproducer, yet, though.
>=20
> @Yu: you mentioned that you might be able to provide me a kernel that =
produces more error logging to diagnose this? Any chance we could try =
that route?
>=20
> Christian
>=20
> --=20
> Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
> Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
> Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
> HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian =
Theune, Christian Zagrodnick


Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


