Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2B62254EE
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 02:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGTARZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Jul 2020 20:17:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgGTARZ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 19 Jul 2020 20:17:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8BEA5ADBD;
        Mon, 20 Jul 2020 00:17:29 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Zhao Heming <heming.zhao@suse.com>, linux-raid@vger.kernel.org
Date:   Mon, 20 Jul 2020 10:17:18 +1000
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com,
        jes@trained-monkey.org
Subject: Re: [PATCH] mdadm/Detail: show correct state for cluster-md array
In-Reply-To: <1595009398-5069-1-git-send-email-heming.zhao@suse.com>
References: <1595009398-5069-1-git-send-email-heming.zhao@suse.com>
Message-ID: <87blkbvy41.fsf@notabene.neil.brown.name>
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

On Sat, Jul 18 2020, Zhao Heming wrote:

> After kernel md module commit 480523feae581, in md-cluster env,
> mddev->in_sync always zero, it will make array.state never set
> up MD_SB_CLEAN. it causes "mdadm -D /dev/mdX" show state 'active'
> all the time.
>
> bitmap.c: add a new API IsBitmapDirty() to support inquiry bitmap
> dirty or clean.
>
> Signed-off-by: Zhao Heming <heming.zhao@suse.com>
> ---
>  Detail.c | 21 ++++++++++++++++++++-
>  bitmap.c | 27 +++++++++++++++++++++++++++
>  mdadm.h  |  1 +
>  3 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/Detail.c b/Detail.c
> index 24eeba0..fd580a3 100644
> --- a/Detail.c
> +++ b/Detail.c
> @@ -495,8 +495,27 @@ int Detail(char *dev, struct context *c)
>  							  sra->array_state);
>  				else
>  					arrayst =3D "clean";
> -			} else
> +			} else {
>  				arrayst =3D "active";
> +				if (array.state & (1<<MD_SB_CLUSTERED)) {
> +					int dirty =3D 0;
> +					for (d =3D 0; d < max_disks * 2; d++) {
> +						char *dv;
> +						mdu_disk_info_t disk =3D disks[d];
> +
> +						if (d >=3D array.raid_disks * 2 &&
> +								disk.major =3D=3D 0 && disk.minor =3D=3D 0)
> +							continue;
> +						if ((d & 1) && disk.major =3D=3D 0 && disk.minor =3D=3D 0)
> +							continue;
> +						dv =3D map_dev_preferred(disk.major, disk.minor, 0, c->prefer);
> +						if (dv !=3D NULL)
> +							if ((dirty =3D IsBitmapDirty(dv))) break;

You don't need to read the bitmap from every device - they should all be
the same.  Just reading one is sufficient.

However ....


> +					}
> +					if (dirty =3D=3D 0)
> +						arrayst =3D "clean";
> +				}
> +			}
>=20=20
>  			printf("             State : %s%s%s%s%s%s%s \n",
>  			       arrayst, st,
> diff --git a/bitmap.c b/bitmap.c
> index e38cb96..90ad932 100644
> --- a/bitmap.c
> +++ b/bitmap.c
> @@ -368,6 +368,33 @@ free_info:
>  	return rv;
>  }
>=20=20
> +int IsBitmapDirty(char *filename)
> +{
> +	/*
> +	 * Read the bitmap file
> +	 * return: 1(dirty), 0 (clean), -1(error)
> +	 */
> +
> +	struct supertype *st =3D NULL;
> +	bitmap_info_t *info;
> +	int fd =3D -1, rv =3D -1;
> +
> +	fd =3D bitmap_file_open(filename, &st, 0);
> +	if (fd < 0)
> +		return rv;
> +
> +	info =3D bitmap_fd_read(fd, 0);

This only examines the first bitmap.  For a cluster-array there is a
separate bitmap for each node in the cluster.
See the
		for (i =3D 0; i < (int)sb->nodes; i++) {
loop in ExamineBitmap().  You need to check for active bits in every
bitmap on the selected device.

NeilBrown


> +	if (!info) {
> +		goto out;
> +	}
> +	rv =3D info->dirty_bits ? 1 : 0;
> +	free(info);
> +out:
> +	close(fd);
> +	free(st);
> +	return rv;
> +}
> +
>  int CreateBitmap(char *filename, int force, char uuid[16],
>  		 unsigned long chunksize, unsigned long daemon_sleep,
>  		 unsigned long write_behind,
> diff --git a/mdadm.h b/mdadm.h
> index 399478b..ba8ba91 100644
> --- a/mdadm.h
> +++ b/mdadm.h
> @@ -1447,6 +1447,7 @@ extern int CreateBitmap(char *filename, int force, =
char uuid[16],
>  			unsigned long long array_size,
>  			int major);
>  extern int ExamineBitmap(char *filename, int brief, struct supertype *st=
);
> +extern int IsBitmapDirty(char *filename);
>  extern int Write_rules(char *rule_name);
>  extern int bitmap_update_uuid(int fd, int *uuid, int swap);
>=20=20
> --=20
> 2.25.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl8U4o4ACgkQOeye3VZi
gbmshA/8DOwj/Mf3+BgxV12K2yetVXOOIhsw08tJpL8fQFcpdLkqZTUfgC5HXNNW
wCl1b+Cg5+Tk8cHVg6ks0muU31ZQXv12Lt7VDAdpriirLHOjNoCxSYjzJWjm1axB
zicVlBNNb1xD2PiOenmeNZUK6sqen6U1cQcwkADXN5Oqh6ixSpT1cUXTco8jjtAa
dwhKixJJwQVfE4e5MPhq0P38fY8l5gvacOykCEAi3tcfwJMPMP5jYQvGcwAJ/N5g
FLdzWMr068X0AKNbIwQfpf2BGfXvzaZCTWn7Okm2ky2WbaUXp+4SYByy6ibqoT4B
Z5KWL2nAPa5dGHMLUZCayJ+GeR8ryenvs28koQz9AqyVazV2M/Jqp1Ej8sRYU7tR
aEJoOXzS+rscot4Knkcc/U9U/OYV5x95r+n//ZVO7kk5ukbGPWN7zjxXCNJn8vd+
d2r5VACicTf6b8vHjh6KrqJQO2QoHGwloM0TsHGT2Q9Pv5h2OlN5DqKgZ3w80Z6e
sWnmMX9prklw5YYmdHL6xUl9+OQtY1i9f3U4tp/LnMeTGh0+/6xPNmpcp2OzDWGD
aAxTUH2W4SktsXCzVYwIXPx7PRSntwxVUmEzq1MHrzrjgfmGILL3V/2lBPmzV05P
d0AKqHxlmIkklacDF7ROUyYAu51CBP7BqFpGOWKuADJtvV0LthY=
=+0qb
-----END PGP SIGNATURE-----
--=-=-=--
