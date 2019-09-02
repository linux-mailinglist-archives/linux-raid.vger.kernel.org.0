Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6BAA4FFB
	for <lists+linux-raid@lfdr.de>; Mon,  2 Sep 2019 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfIBHec (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 03:34:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbfIBHec (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Sep 2019 03:34:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F561B633;
        Mon,  2 Sep 2019 07:34:31 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Yufen Yu <yuyufen@huawei.com>, songliubraving@fb.com
Date:   Mon, 02 Sep 2019 17:34:23 +1000
Cc:     linux-raid@vger.kernel.org, yuyufen@huawei.com
Subject: Re: [PATCH] md/raid1: fail run raid1 array when active disk less than one
In-Reply-To: <20190902072436.23225-1-yuyufen@huawei.com>
References: <20190902072436.23225-1-yuyufen@huawei.com>
Message-ID: <87pnkjdudc.fsf@notabene.neil.brown.name>
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

On Mon, Sep 02 2019, Yufen Yu wrote:

> When active disk in raid1 array less than one, we need to return
> fail to run.

Seems reasonable, but how can this happen?
As we never fail the last device in a RAID1, there should always
appear to be one that is working.

Have you had a situation where this in actually needed?

Thanks,
NeilBrown

>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  drivers/md/raid1.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 34e26834ad28..2a554464d6a4 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -3127,6 +3127,13 @@ static int raid1_run(struct mddev *mddev)
>  		    !test_bit(In_sync, &conf->mirrors[i].rdev->flags) ||
>  		    test_bit(Faulty, &conf->mirrors[i].rdev->flags))
>  			mddev->degraded++;
> +	/*
> +	 * RAID1 needs at least one disk in active
> +	 */
> +	if (conf->raid_disks - mddev->degraded < 1) {
> +		ret =3D -EINVAL;
> +		goto abort;
> +	}
>=20=20
>  	if (conf->raid_disks - mddev->degraded =3D=3D 1)
>  		mddev->recovery_cp =3D MaxSector;
> @@ -3160,8 +3167,12 @@ static int raid1_run(struct mddev *mddev)
>  	ret =3D md_integrity_register(mddev);
>  	if (ret) {
>  		md_unregister_thread(&mddev->thread);
> -		raid1_free(mddev, conf);
> +		goto abort;
>  	}
> +	return 0;
> +
> +abort:
> +	raid1_free(mddev, conf);
>  	return ret;
>  }
>=20=20
> --=20
> 2.17.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1sxgAACgkQOeye3VZi
gbl8lQ//RkqU3OnFG4HKvRSc0SXuCrY4qnueVKANF/LL3z5k1LOkdTGgFVB40zgJ
FlNCuE1kpW+/pc7/wS9mplhfxB8tQud5pLOCvpWjYgBisExxY5ADlMUY1EDxil/F
2zOYVMWcbRI1xSkL90XJc0J2qGJkyx0Vnar1wtrLOr2TEcIpA6gkZT7/obLhHHLK
9oQU+M8beIG9EFB2ztKf/Phj+P1lhT7VoTWlY5d5KHBpwTFKTcvyipzSLlgp9DQR
+rsSTidN4Ycms7CEXvBq1D9bxbHtu2MghjvJsNzDziij4h7hOXb0xA1HwXxl7WUk
43UOy0xl4ZGOc6IrDsbuq/Wu3DtHI3Yfi6V/rzYMSJpT/Ds0R6RnOhfiPxIC3dv6
lIDR9BSu/s6KaUDQHMU5wigBqDgCFTEnbJfD63Dq/30aBaIGnr/6D5/m2DtAsev0
3enhSFobdyDUVnKNZus3cKxcDJOZaAtBFDwdbWMnMSGW2jUy4Xd/lLaeZHo2bDaa
f0MaCW/BWUoENzkqvNIWudCem6nWq26QTifvPgk8t5+B0eNWtMhE1vCSMi4cssre
yT1e3pFKGrg3D9ZtQ9W0Bi2jvyTykHXEUYM5eng7cSOJ+Pga7IDw68Q4qsnWUu20
SFMo7x+cCE3bkpRIwQVDg5RjTSw9YlOM5JaTsS0ag3fs3bNc/Ms=
=WIuN
-----END PGP SIGNATURE-----
--=-=-=--
