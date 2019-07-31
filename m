Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B91F7B68C
	for <lists+linux-raid@lfdr.de>; Wed, 31 Jul 2019 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGaAK5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jul 2019 20:10:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:37588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfGaAK5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 30 Jul 2019 20:10:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6C75AD88;
        Wed, 31 Jul 2019 00:10:56 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Coly Li <colyli@suse.de>, jes.sorensen@gmail.com,
        linux-raid@vger.kernel.org
Date:   Wed, 31 Jul 2019 10:10:49 +1000
Subject: Re: [PATCH 2/2] udev: add --no-devices option for calling 'mdadm --detail'
In-Reply-To: <20190730164024.97862-2-colyli@suse.de>
References: <20190730164024.97862-1-colyli@suse.de> <20190730164024.97862-2-colyli@suse.de>
Message-ID: <87lfwfkqra.fsf@notabene.neil.brown.name>
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

On Wed, Jul 31 2019, Coly Li wrote:

> When creating symlink of a md raid device, the detailed information of
> component disks are unnecessary for rule udev-md-raid-arrays.rules. For
> md raid devices with huge number of component disks (e.g. 1500 DASD
> disks), the detail information of component devices can be very large
> and exceed udev monitor's on-stack message buffer.
>
> This patch adds '--no-devices' option when calling mdadm by,
> IMPORT{program}=3D"BINDIR/mdadm --detail --no-devices --export $devnode"
>
> Now the detailed output won't include component disks information,
> and the error message "invalid message length" reported by systemd can
> be removed.
>
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Neil Brown <<neilb@suse.com>

Reviewed-by: NeilBrown <neilb@suse.com>

Thanks for these!

NeilBrown


> ---
>  udev-md-raid-arrays.rules | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/udev-md-raid-arrays.rules b/udev-md-raid-arrays.rules
> index 5b99d58..d391665 100644
> --- a/udev-md-raid-arrays.rules
> +++ b/udev-md-raid-arrays.rules
> @@ -17,7 +17,7 @@ TEST!=3D"md/array_state", ENV{SYSTEMD_READY}=3D"0", GOT=
O=3D"md_end"
>  ATTR{md/array_state}=3D=3D"|clear|inactive", ENV{SYSTEMD_READY}=3D"0", G=
OTO=3D"md_end"
>  LABEL=3D"md_ignore_state"
>=20=20
> -IMPORT{program}=3D"BINDIR/mdadm --detail --export $devnode"
> +IMPORT{program}=3D"BINDIR/mdadm --detail --no-devices --export $devnode"
>  ENV{DEVTYPE}=3D=3D"disk", ENV{MD_NAME}=3D=3D"?*", SYMLINK+=3D"disk/by-id=
/md-name-$env{MD_NAME}", OPTIONS+=3D"string_escape=3Dreplace"
>  ENV{DEVTYPE}=3D=3D"disk", ENV{MD_UUID}=3D=3D"?*", SYMLINK+=3D"disk/by-id=
/md-uuid-$env{MD_UUID}"
>  ENV{DEVTYPE}=3D=3D"disk", ENV{MD_DEVNAME}=3D=3D"?*", SYMLINK+=3D"md/$env=
{MD_DEVNAME}"
> --=20
> 2.16.4

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1A3IoACgkQOeye3VZi
gbkwGw/9H48je3H1aPsaRCOkFREmFMIsVOo1ht7spOrqZW2qUmoANckaOvoK8deQ
qA4gd//PnZD74BEONWTx+kTC/3Le2muh/6Po8mHWn653OHeN6d0kVoTX+H6dLi9M
qCoSVVM1xCTrGpPH/FOJ6s6NTMVbWVjOKq8Cd9BzKfUjiiqpbThXLdG06HgTLop5
GJvWGqSPxgBwxRLpJ/m5rKl4guWw3plCxBR2tXdyngbaWivFPF43vwaKfqgTgMdR
xhUFdJmg0yfYM5SbjLFxsn6A1vAtWEX6f0b7Ihj5pIQtHT3MJfuKZJZ6na7YQHg1
kxhe8OsT07VZgX7RmxCImznZ4kV/2Myynb/GKZDCWTFuZEUgOv4pDtKTuWEU5E6P
6tQ8ntg+Ihz2wtE8D834Rn3Si2J0H4sQCzaahcldK7+1F3EMgM/WPgzo7GesPNao
B+Kc0wUKdLYoz9hI4hAlZklYt1qK2Rd7i+vPpKtknXpSXsu4S84TaSeaAoW/TuUl
umVoXmhSS1YejwTiuCrmEDL9h+mz5RaBw0vz2uLt5mxOX31/2ptFjvi7IzbRFf0L
sUZ1HucpcJ7igXbugMjR2jfV5sO3AgvtCDtjEwfuKaxbXpBJW1HcxWwkchQcFE67
IfhbZZXvesFpE3mWdvHLwatctB4h0K0lGgO2YVaFv8W/3U9yhs0=
=LPoh
-----END PGP SIGNATURE-----
--=-=-=--
