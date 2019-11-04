Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43589ED805
	for <lists+linux-raid@lfdr.de>; Mon,  4 Nov 2019 04:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfKDDUu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 3 Nov 2019 22:20:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:43296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728643AbfKDDUt (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 3 Nov 2019 22:20:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9904CAE6F;
        Mon,  4 Nov 2019 03:20:47 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     dann frazier <dann.frazier@canonical.com>
Date:   Mon, 04 Nov 2019 14:20:40 +1100
Cc:     Jes Sorensen <jes.sorensen@gmail.com>, linux-raid@vger.kernel.org,
        Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH 1/2] Create: add support for RAID0 layouts.
In-Reply-To: <20191031215644.GB24512@xps13.dannf>
References: <157247951643.8013.12020039865359474811.stgit@noble.brown> <157247976449.8013.11231492614839148435.stgit@noble.brown> <20191031215644.GB24512@xps13.dannf>
Message-ID: <8736f4e393.fsf@notabene.neil.brown.name>
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
>> Since Linux 5.4 a layout is needed for RAID0 arrays with
>> varying device sizes.
>
> Thanks for working on this. It will be key to backport to distros
> along w/ the kernel side.
>
>> This patch makes the layout of an array visible (via --examine)
>> and sets the layout on newly created arrays.
>
> Probably a n00b question - but why is this visible in --examine but not
> --detail? Seems like a feature of the array vs. the members.

I've added the information to --detail.

>> --- a/maps.c
>> +++ b/maps.c
>> @@ -73,6 +73,18 @@ mapping_t r6layout[] =3D {
>>  	{ NULL, UnSet }
>>  };
>>=20=20
>> +/* raid0 layout is only needed because of a bug in 3.13 which changed
>
> s/3.13/3.14/

Fixed.

>
>> + * the effective layout of raid0 arrays with varying device sizes.
>> + */
>> +mapping_t r0layout[] =3D {
>> +	{ "original", RAID0_ORIG_LAYOUT},
>> +	{ "alternate", RAID0_ALT_MULTIZONE_LAYOUT},
>> +	{ "1", 1},
>> +	{ "2", 2},
>
> Nit - why not use the RAID0_ macros here as well, so it is clear which
> that e.g. "1" is an alias for "original"?

If I did that, it wouldn't be obvious from the code that the mapping
was correct.  I've added comments.

>> --- a/mdadm.8.in
>> +++ b/mdadm.8.in
>> @@ -593,6 +593,8 @@ to change the RAID level in some cases.  See LEVEL C=
HANGES below.
>>  This option configures the fine details of data layout for RAID5, RAID6,
>>  and RAID10 arrays, and controls the failure modes for
>
> Should this list now include RAID0?

No, I don't think so.  But the line below should definitely mention
RAID0 - so I've added it there.

>
>>  .IR faulty .
>> +It can also be used for working around a kernel bug, but generaly
>
> s/generaly/generally/

Fixed.

>>  .I 'n'
>> @@ -677,6 +679,32 @@ devices in the array.  It does not need to divide e=
venly into that
>>  number (e.g. it is perfectly legal to have an 'n2' layout for an array
>>  with an odd number of devices).
>>=20=20
>> +A bug in Linux 3.14 means that RAID0 arrays
>
> s/bug in/bug introduced in/
>

Fixed.

>> +An array created for either
>> +.RB ' original '
>> +or
>> +.RB ' alternate '
>> +with not be recognized by an (unpatched) kernel prior to 5.4.  To create
>
> s/with not/will not/
>
> I noticed this in my testing - definitely a nice feature :)

Fixed.

>
>> --- a/super1.c
>> +++ b/super1.c
>> @@ -43,7 +43,7 @@ struct mdp_superblock_1 {
>>=20=20
>>  	__u64	ctime;		/* lo 40 bits are seconds, top 24 are microseconds or 0*/
>>  	__u32	level;		/* -4 (multipath), -1 (linear), 0,1,4,5 */
>> -	__u32	layout;		/* only for raid5 currently */
>> +	__u32	layout;		/* use for raid5, raid6, raid10, and raid0 */
>
> s/use/used/

Fixed.
>
>>  	__u64	size;		/* used size of component devices, in 512byte sectors */
>>=20=20
>>  	__u32	chunksize;	/* in 512byte sectors */
>> @@ -144,6 +144,7 @@ struct misc_dev_info {
>>  #define	MD_FEATURE_JOURNAL		512 /* support write journal */
>>  #define	MD_FEATURE_PPL			1024 /* support PPL */
>>  #define	MD_FEATURE_MUTLIPLE_PPLS	2048 /* support for multiple PPLs */
>> +#define	MD_FEATURE_RAID0_LAYOUT		4096 /* layout is meaninful in RAID0 */
>
> s/meaninful/meaningful/

Fixed.

>
> Those minor fixes aside, the code worked well for me. I was able to
> create a new multi-zone array w/ and w/o an explicit layout, and was
> able to change the layout of an existing array on assemble. I verified
> I could view the layout w/ -E, and that it persisted across reboots.
>
> Tested-by: dann frazier <dann.frazier@canonical.com>

Thanks for your excellent review and testing.  I'll resend shortly.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2/mQgACgkQOeye3VZi
gbl+CA//Qaoz0Ki+SFdOOqo2k6bMI5h7QBW1COjfd5USYh5rPW5zlRQNb0bAKCo0
d7pN53Cwgt0DMlFnonjoP1R2ag5SkvSUH6o2q3aE6tkdpVG81iW8mkLeahFjMLkM
S4FQgeDjqLCN4/jy2I6hrwZjSVyuGH3jpXvt3jUaRNJYaK762Qo72b/Z+zNvbswY
VHLOEThiB7J4Opio1yq6ZhDdz5H98EAkQEeGiUfLsldQhX2G21y4AV2iQYB8laPs
wPsPidx0S9PB5OCB349Qfp98Ex911M3ZbT9H49Fl300V/KRZkP4bZNRD1562fUS+
HNLlb6b42dkP/LjbsK0uAIB9ArCI0YeX0UnarrFErtRhGVGH5qohYPE3/GEglnXZ
Ki/cGcWDzg/NC3Grle/W0gpeFNY+1JIFsskE04tjTkbqjrjHSsnrvJdYGIXXUq+u
sstVAM3k42Z80CAKlXOmo+/nGn0rlmXYXvsNqPzDydSdIADCE4GjsX996LDYbgng
v8QiqQd9NAjClrvXZILttG9dhCE9yQu+EQfO9ZdKJCcXJqxkQrUj+CkCbdOjqISl
5ybeC4CqFSjbuw3vJ3vCthEcxy8reVC0oSgmN2WzctbdtWoFOAy0KLpt6e4ZM0R4
0oGgHd3LLwBoMxfeNYJHxmxhRuaF2RaqUZXXFerq9oBhgfUq04g=
=6Hn0
-----END PGP SIGNATURE-----
--=-=-=--
