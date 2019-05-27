Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92FD2ACAB
	for <lists+linux-raid@lfdr.de>; Mon, 27 May 2019 02:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfE0AYq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 May 2019 20:24:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:60180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbfE0AYp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 26 May 2019 20:24:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0369AFE7;
        Mon, 27 May 2019 00:24:43 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Guoqing Jiang <gqjiang@suse.com>, jes.sorensen@gmail.com
Date:   Mon, 27 May 2019 10:24:37 +1000
Cc:     linux-raid@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>
Subject: Re: [RFC PATCH] mdadm/md.4: add the descriptions for bitmap sysfs nodes
In-Reply-To: <20190523083202.12294-1-gqjiang@suse.com>
References: <20190523083202.12294-1-gqjiang@suse.com>
Message-ID: <87a7f8vj5m.fsf@notabene.neil.brown.name>
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

On Thu, May 23 2019, Guoqing Jiang wrote:

> The sysfs nodes under bitmap are not recorded in md.4,
> add them based on md.rst and kernel source code.
>
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
> ---
> Hi,
>
> Please feel free to correct the descriptions since my understanding
> could be wrong.
>
> Thanks,
> Guoqing
>
>  md.4 | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/md.4 b/md.4
> index 3a1d6777e5b7..e81f38e40e77 100644
> --- a/md.4
> +++ b/md.4
> @@ -1101,6 +1101,63 @@ stripe that requires some "prereading".  For fairn=
ess this defaults to
>  maximizes sequential-write throughput at the cost of fairness to threads
>  doing small or random writes.
>=20=20
> +.TP
> +.B md/bitmap/backlog
> +This is only available on RAID1. when write-mostly devices are active,
> +write requests to those devices proceed in the background.

I don't think this is true.  I think the file always exists, even if no
bitmap is configured.
The value stored in the file only has any effect on RAID1 when
write-mostly devices are active.

> +
> +This variable sets a limit on the number of concurrent background writes,
> +the valid values are 0 to 256, 0 means that write-behind is not allowed,
> +while any other number means it can happen. If there are more write requ=
est
                                                                       requ=
ests

> +than the number, new writes will by synchronous.
> +
> +.TP
> +.B md/bitmap/can_clear
> +Write 'true' to 'bitmap/can_clear' will allow bits in the bitmap to be
> +cleared again, write 'false' means bits in the bitmap don't need to be
> +cleared.

This doesn't really explain the purpose of this attribute...

However, looking at the code doesn't make it very clear.

This is for externally managed bitmaps, where the kernel writes the
bitmap itself, but metadata describing the bitmap is managed by mdmon or
similar.
When the array is degraded, bits mustn't be cleared.
When the array becomes optimal again, bit can be cleared, but first the
metadata needs to record the current event count.
So md sets this to 'false' and notifies mdmon, then mdmon updates the
metadata and writes 'true'.

There is no code in mdmon to actually do this, so maybe it doesn't even
work.

> +
> +.TP
> +.B md/bitmap/chunksize
> +The bitmap chunksize can only be changed when no bitmap is active, and
> +the value should be power of 2 and bigger than 512.

  "and at least 512".
=20
> +
> +.TP
> +.B md/bitmap/location
> +This indicates where the write-intent bitmap for the array is stored.
>
It can be "none" or "file" or a signed offset from the array metadata -
measured in sectors.
You cannot set a file by writing here - that can only be done with the
SET_BITMAP_FILE ioctl.

 +
> +Write 'none' to 'bitmap/location' will clear bitmap, and the previous
> +location value must be write to it to restore bitmap.
> +
> +.TP
> +.B md/bitmap/max_backlog_used
> +This keeps track of the maximum number of concurrent write-behind reques=
ts
> +for an md array, writing any value to this file will clear it.
> +
> +.TP
> +.B md/bitmap/metadata
> +This can be either 'internal' or 'external'. 'internal' is set by defaul=
t,
> +which means the metadata for bitmap is stored in the first 256 bytes of
> +the bitmap space. 'external' means that bitmap metadata is managed exter=
nally
> +to the kernel.

I can also be "clustered".

> +
> +.TP
> +.B md/bitmap/space
> +This shows the space (in sectors) which is available at md/bitmap/locati=
on,
> +and allows the kernel to know when it is safe to resize the bitmap to ma=
tch
> +a resized array. It should big enough to contain the total bytes in the =
bitmap.
> +
> +For 1.0 metadata, assume we can use up to the superblock if before, else
> +to 4K beyond superblock. For other metadata versions, assume no change is
> +possible.
> +
> +.TP
> +.B md/bitmap/time_base
> +This shows the time (in seconds) between disk flushes, and is used to lo=
oking
> +for bits in the bitmap to be cleared.
> +
> +The default value is 5 seconds, and it should be an unsigned long value.
> +
>  .SS KERNEL PARAMETERS
>=20=20
>  The md driver recognised several different kernel parameters.
> --=20
> 2.12.3


Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzrLkUACgkQOeye3VZi
gbnt2xAAxFoL3QGd3402ghg6T9IDDUrtD3gUrcHPJaQcvA43k9yeUROqxeMkK4Id
4HoDhRU8If/TbZ8Wu7pDSMKQgmPXHc4G1nR1/enb/tN7DcQw8p4gumZkTOi9bI9r
sjVHreMcp9ZC3p5I8/P8er0EzFbT41LfGjqwiepwGw9WEVj+OGjMdWoffb8UFKzE
unqY3WImiUJ1i8cUbWSFxZkQAn0j9GbbvHNyII+UpOD6p55pE0qOjAIpjUPivg68
lGJ7z3uQ+34PpC49kQbhPj9fUOpaAIarqrpiclB7kagIk0LmxGyJjFsM9N7Wx6St
21LUbckgwWxJS3JgwhIb0+n5rsjWJjdHCoHu1wubNKxocIgoQrtI+JXwDVg0UGNG
XFJWubXsmQ7AjpUvEX+NgFAJoCbiIRdZ1Ts5qHFWhulZjEM7le+AsCr+KMe6/rIA
Zr7kmg8M/Ts99zCNBQPglVVyW5zVpRnFrm8ZinP7Hqp3jkLtJl9wIjC2igcvfxr0
LCAP0V1RoARBylnDGC/+62a8VBFjjSAa0Vi0qB5ceqbME4/Sg57pU90VJ94YxtS3
kg7q7wAi96OCXLRVO0hOvFr0JPuvyPjbYc6hPgxXl4OrDwsQctQ0g7Fm4cJczcE4
OHgnZcyS8y5tdxrTr4FQQfsYVkPhtcrPQxGoExsP9us2AJ78Emo=
=JIpS
-----END PGP SIGNATURE-----
--=-=-=--
