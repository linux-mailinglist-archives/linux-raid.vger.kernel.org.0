Return-Path: <linux-raid+bounces-3067-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9DC9B7606
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2024 09:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B88284B44
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2024 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6B514D2BD;
	Thu, 31 Oct 2024 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="gwnvkdru"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3722154426
	for <linux-raid@vger.kernel.org>; Thu, 31 Oct 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361901; cv=none; b=asDewVc/3zNngjs2ggO+sSKU2nwtcPiZA+6A5XC6UYaXG27PgsVHuHuMAHKG2qmV9B51UGyO48PSSCxJOT+wDYWcQfDxtrPDYIPNienhcxBxNfaLyh33hRZYFxtQU5GL1pcgKyko+soRQieRg5blEzaJhrSsS/sasgwmMIa0MDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361901; c=relaxed/simple;
	bh=x/fccpxcSmsYaKuPXEA6Dhc/pFrQlv+UccKT7lkviLg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A2qcjy5NntkpxOZtL4KAjQXV8lGVshw81sVAUZxKXXiZR/GR5V5XBApO0Ht2HiLsvG52U+S8G5sI0MZYGMkiVlbDgdy9553sB4DZfbH8Rq3Z7mtxHHg1munwYJoaufcrl7/RvTahPc088FyJ1bRkAYbHuKVWYY2DcdIz+WWOhb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=gwnvkdru; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1730361890;
	bh=Tt1gdnsW9K9dKQfU26JVuRibG697Gq/i0HGZ+SuWIlo=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=gwnvkdruc4CVHri+l3rAq1vFBH0pDfZ2/W5DTfrGRGOouMX4WseUJ8G14K7UQHgmN
	 7SSTK053rJnaEdDYeFH2nxuI0aJhIg0AFRXcXGYBvgjdjs8M314zGQgDGBPEC5ghRx
	 0aUv6PkQyvfZxS27LbergpXLwt1lVfWQ2qzLRF5Q=
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: PROBLEM: repeatable lockup on RAID-6 with LUKS dm-crypt on NVMe
 devices when rsyncing many files
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <45d44ed5-da7c-6480-9143-f611385b2e92@huaweicloud.com>
Date: Thu, 31 Oct 2024 09:04:27 +0100
Cc: John Stoffel <john@stoffel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 dm-devel@lists.linux.dev,
 =?utf-8?Q?Dragan_Milivojevi=C4=87?= <galileo@pkm-inc.com>,
 "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C03DED0-3A6A-42F8-B935-6EB500F8BCE2@flyingcircus.io>
References: <ADF7D720-5764-4AF3-B68E-1845988737AA@flyingcircus.io>
 <26298.22106.810744.702395@quad.stoffel.home>
 <EBC67418-E60C-435A-8F63-114C67F07583@flyingcircus.io>
 <CEC90137-09B3-41AA-A115-1C172F9C6C4B@flyingcircus.io>
 <2F5F9789-1827-4105-934F-516582018540@flyingcircus.io>
 <adee77ef-f785-acd6-485a-fe2d0a1b9a92@huaweicloud.com>
 <143E09BF-BD10-43EB-B0F1-7421F8200DB1@flyingcircus.io>
 <1bbc86a8-1abf-11a1-e724-b6868a8d9f88@huaweicloud.com>
 <69D8A311-E619-40C2-985A-FB15D0336ADE@flyingcircus.io>
 <CALtW_agiOj2PJ_vsWym0qR8w1Q9iotHKPGuP5RohktkqeXt2mw@mail.gmail.com>
 <E893A1D9-4042-4515-88AE-C69B078A3E43@flyingcircus.io>
 <A74EC4F5-2FF8-4274-A1EB-28D527F143F1@flyingcircus.io>
 <2d85e9ab-1d0f-70a1-fab2-1e469764ef28@huaweicloud.com>
 <3CF4B28B-52D7-414E-96A1-FDFA5A5EF172@flyingcircus.io>
 <3DB33849-56C5-4C5C-BF56-F54205BEFCF2@flyingcircus.io>
 <1f2c74f4-8ba9-1a9f-0c11-018a25e785e5@huaweicloud.com>
 <22A202B1-A802-406F-8F38-F4F486A92F81@flyingcircus.io>
 <45d44ed5-da7c-6480-9143-f611385b2e92@huaweicloud.com>
To: Yu Kuai <yukuai1@huaweicloud.com>

Hi,

> On 31. Oct 2024, at 08:48, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>=20
>> I will try, but I=E2=80=99m not sure. I don=E2=80=99t have a deep =
enough understanding to resolve some of the conflicts. In my previous =
mail I wasn=E2=80=99t sure which change would be the right one:
>> I guess if 6.12 doesn=E2=80=99t have this line at all:
>> -               atomic_set(&sh->count, 1);
>> =E2=80=A6 then setting it to 0 is fine?
>> +               atomic_set(&sh=E2=86=92count, 0);
>=20
> My patch doesn't touch this field at all, why make such change? This =
is
> not OK.

Yeah, patch didn=E2=80=99t think that=E2=80=99s OK either, that=E2=80=99s =
why I came back instead of trying to run that. ;)

Here=E2=80=99s the part of the patch I extracted from the earlier =
emails:

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 58f71c3e1368..b2a75a904209 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2369,6 +2369,7 @@ static struct stripe_head *alloc_stripe(struct =
kmem_cache *sc, gfp_t gfp,
               atomic_set(&sh->count, 1);
               sh->raid_conf =3D conf;
               sh->log_start =3D MaxSector;
+               atomic_set(&sh->bitmap_counts, 0);

=E2=80=A6 aaand I just noticed that patch got confused and tried to =
apply your change 3 lines early, so I ended up with a conflict - =
correctly! :)

>> But again, I have no idea what=E2=80=99s actually going on there =E2=80=
=A6 ;)
>> If you want I can try to wade through and give you a list of =
questions where the patch doesn=E2=80=99t obviously apply and you can =
let me know =E2=80=A6
>=20
> Perhaps can you try v6.12-rc5 directly? If not, I'll give a patch =
based
> on v6.11 later.

So. I=E2=80=99d like to avoid running 6.12rc5 and if it isn=E2=80=99t =
too much trouble I=E2=80=99d appreciate a 6.11 patch, but now that I =
understood what=E2=80=99s wrong I can try to create it myself in the =
next days.

Cheers,
Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


