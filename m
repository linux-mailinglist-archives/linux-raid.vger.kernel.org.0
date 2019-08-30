Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3EA9A324F
	for <lists+linux-raid@lfdr.de>; Fri, 30 Aug 2019 10:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfH3I2m (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 30 Aug 2019 04:28:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:46626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfH3I2m (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 30 Aug 2019 04:28:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4A73AE78;
        Fri, 30 Aug 2019 08:28:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Yufen Yu <yuyufen@huawei.com>, songliubraving@fb.com,
        linux-raid@vger.kernel.org
Date:   Fri, 30 Aug 2019 18:28:34 +1000
Cc:     xni@redhat.com
Subject: Re: [RFC PATCH] md/raid5: set STRIPE_SIZE as a configurable value
In-Reply-To: <20190829081514.29660-1-yuyufen@huawei.com>
References: <20190829081514.29660-1-yuyufen@huawei.com>
Message-ID: <877e6vf45p.fsf@notabene.neil.brown.name>
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

On Thu, Aug 29 2019, Yufen Yu wrote:

> In RAID5, if issued bio has sectors more than STRIPE_SIZE,
> it will be split in unit of STRIPE_SIZE. For bio sectors
> less then STRIPE_SIZE, raid5 issue bio to disk in the size
> of STRIPE_SIZE.
>
> For now, STRIPE_SIZE is equal to the value of PAGE_SIZE.
> That means, RAID5 will issus echo bio to disk at least 64KB
> when use 64KB page size in arm64.
>
> However, filesystem usually issue bio in the unit of 4KB.
> Then, RAID5 will waste resource of disk bandwidth and compute xor.
>
> To avoding the waste, we can add a CONFIG option to set
> the default STRIPE_SIZE as 4096. User can also set the value
> bigger than 4KB for some special requirements, such as we know
> the issued io size is more than 4KB.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  drivers/md/Kconfig | 9 +++++++++
>  drivers/md/raid5.h | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 3834332f4963..4263a655dbbb 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -157,6 +157,15 @@ config MD_RAID456
>=20=20
>  	  If unsure, say Y.
>=20=20
> +config MD_RAID456_STRIPE_SIZE
> +	int "RAID4/RAID5/RAID6 stripe size"
> +	default "4096"
> +	depends on MD_RAID456
> +	help
> +	  The default value is 4096. Only change this if you know
> +	  what you are doing.
> +
> +
>  config MD_MULTIPATH
>  	tristate "Multipath I/O support"
>  	depends on BLK_DEV_MD
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index cf991f13403e..2fcf5853b719 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -473,7 +473,7 @@ struct disk_info {
>   */
>=20=20
>  #define NR_STRIPES		256
> -#define STRIPE_SIZE		PAGE_SIZE
> +#define STRIPE_SIZE		CONFIG_MD_RAID456_STRIPE_SIZE
>  #define STRIPE_SHIFT		(PAGE_SHIFT - 9)
>  #define STRIPE_SECTORS		(STRIPE_SIZE>>9)
>  #define	IO_THRESHOLD		1
> --=20
> 2.17.2

While I agree that this is a problem that should be fixed, I think your
fix is rather simplistic.

grow_buffers() uses alloc_page() allocate the buffers for each
stripe_head()
With this change, it will allocate 64K buffers and use 4K of them.
This is a waste.  Unfortunately fixing it would be a lot more work.
I think that is best way forward though.

Also, I don't think this should be a config option - just make it
always 4096.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1o3jIACgkQOeye3VZi
gbnvyA//drMO15PYGzahRqXo9ZR7ifiqGux/e1nIAlIDkQqnOptvg7l0SdRm2w4H
GZBuYDkE9mqQ2DgP+KyrBHr5NSSLOdRBA4cjA2WhvuaZ4SExgkazBSw11v/w9gt7
FvkCLHPGGOtX2awxVTQeFtLFoH4DqUIaKfLVMtoVbYlMF7ijq8MHEz1mmGiD8KnL
jcJ4aCNwFx2lC70Sc/1Y1pUX9dbaly+O/vxpTdPkbIOcTOoioxukuR4rw96AanpO
HKxQvekYVtkGnyzmrPlA61AOYQNE8huP+RtQwRCiws38X7bgd8VKbEOYgw6u5BsF
IfKanwTsTew9GWXelmAkv9LaDIMU6SavYuoWz3k/Yv6P4WPpfJb+qZSO6qVYETRV
7R+8ikXGttM/MWvMX9IJsx6SR/GeCP7rWr6MvxkEwcqlNppFhsX/10YvJFR7w8Ed
BRQs/uPXYGL8TNteP5XtCA6LJ6cv5TT3IWjl/L6EHrBgKVB/n5bFTvF3QxrK/mda
cHxQ//ACvBDijwbfGj5JFQbSveTMEOIwPPoWKtQmXIwgFmSqFMu/L5DJ3D+DAOdj
bkVC0RHW1tF0IQ1sVktkdVtzKQ34Yp4jXg++RnPbGnvcdCRdjhjJl74bVkPFf9XA
0sEjZHiy3+xbwVipQzn2DK10lZ/5xmCFM6hFq7WwUajb5CSVEfw=
=ZvMC
-----END PGP SIGNATURE-----
--=-=-=--
