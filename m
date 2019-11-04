Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE725ED808
	for <lists+linux-raid@lfdr.de>; Mon,  4 Nov 2019 04:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfKDDZm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 3 Nov 2019 22:25:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:44128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728847AbfKDDZm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 3 Nov 2019 22:25:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 174C1B463;
        Mon,  4 Nov 2019 03:25:41 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     dann frazier <dann.frazier@canonical.com>
Date:   Mon, 04 Nov 2019 14:25:35 +1100
Cc:     Jes Sorensen <jes.sorensen@gmail.com>, linux-raid@vger.kernel.org,
        Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH 2/2] Assemble: add support for RAID0 layouts.
In-Reply-To: <20191031220311.GC24512@xps13.dannf>
References: <157247951643.8013.12020039865359474811.stgit@noble.brown> <157247976452.8013.2396485247609220571.stgit@noble.brown> <20191031220311.GC24512@xps13.dannf>
Message-ID: <87zhhccogg.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31 2019, dann frazier wrote:

> On Thu, Oct 31, 2019 at 10:56:04AM +1100, NeilBrown wrote:
>> If you have a RAID0 array with varying sized devices
>> on a kernel before 5.4, you cannot assembling it on
>> 5.4 or later without explicitly setting the layout.
>> This is now possible with
>>   --update=3Dlayout-original (For 3.13 and earlier kernels)
>> or
>>   --update=3Dlayout-alternate (for 3.15 and later kernels)
>
> s/3.15/3.14/
>
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>>  Assemble.c |    8 ++++++++
>>  md.4       |    7 +++++++
>>  mdadm.8.in |   17 +++++++++++++++++
>>  mdadm.c    |    4 ++++
>>  super1.c   |   12 +++++++++++-
>>  5 files changed, 47 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Assemble.c b/Assemble.c
>> index b2e69144f1a2..4066f93e977f 100644
>> --- a/Assemble.c
>> +++ b/Assemble.c
>> @@ -1031,6 +1031,11 @@ static int start_array(int mdfd,
>>  				pr_err("failed to add %s to %s: %s\n",
>>  				       devices[j].devname, mddev,
>>  				       strerror(errno));
>> +				if (errno =3D=3D EINVAL && content->array.level =3D=3D 0 &&
>> +				    content->array.layout !=3D 0) {
>> +					cont_err("Possibly your kernel doesn't support RAID0 layouts.\n");
>
> Why possibly?

Because there might be other circumstances that could result in EINVAL.
I tend to be cautious when determining the cause for a particular
effect.

I've made all the changes you suggested.  Thanks a lot.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2/mi8ACgkQOeye3VZi
gblsLA/6AqxI3y/Y+jMkZxtgvtWDsuPGoKp62FkreaCNSN00gL2lx9ykIKC9rKj7
ReP7ikUf9cE23vCvYATGXFvLwsYrF81THURWW41sKaFNzF6rDmh4Y2xNJ3pRPXmG
n1xsthB7ZAPpUaIVEQxTvR8GIsuKLOJ2HZCdFxA40SE32iMJWBuz/mRwqFHBUxto
ZZlPlD8LRYePj/v66EpCRlsQ0fJaQWm8LDb/ucESlt0ZnuMGryFaEO00TGRDAz1A
fxM3rnj801h4ljs5Xp1DMbP2MUPw/PjzzWPTDnNXwuc3SjY9XY+PVJKaXn2FOojt
oAK35+d7H5WrwYGd4RQw79YyFDybvG+rawygqkGOnFUU8PemsQRg3odXwPBHi3X+
P9RjkTpWv+5iccJVXRGzwtgvdfysxxK2M6lGaLaM4HWTDWcApSgAi1lzQCm9jmQ+
CYTNJqrbqynaOcmCXn0BcNO6XwbqSdDvdK6kwIqEs4qqUo/4W6IKOyiq+MdxF2Xa
3lLHgFEr5Aj2lJ0FsAFGqOcCHLHjuO/5xnpI9r2KgwPB1yBe4horPBVBpmniTOU9
PmdNKNUQfI50ILYb4bP+fs7h6huQM3UjcU+XvQ9y3G8oaD0omY3jAI30DtTM0vI5
VA/5R97G+E5w6pwdp+dmm95zeV7lkVx/OydRarDM8k7KnWOqZxc=
=jElX
-----END PGP SIGNATURE-----
--=-=-=--
