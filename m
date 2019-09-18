Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFD2B5AB9
	for <lists+linux-raid@lfdr.de>; Wed, 18 Sep 2019 07:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfIRFNF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 18 Sep 2019 01:13:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:42758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbfIRFNF (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 18 Sep 2019 01:13:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8F9FB06B;
        Wed, 18 Sep 2019 05:13:03 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Wed, 18 Sep 2019 15:12:55 +1000
Subject: [PATCH] udev: allow for udev attribute reading bug.
cc:     linux-raid <linux-raid@vger.kernel.org>
Message-ID: <87impq9oh4.fsf@notabene.neil.brown.name>
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


There is a bug in udev (which will hopefully get fixed, but
we should allow for it anways).
When reading a sysfs attribute, it first reads the whole
value of the attribute, then reads again expecting to get
a read of 0 bytes, like you would with an ordinary file.
If the sysfs attribute changed between these two reads, it can
get a mixture of two values.

In particular, if it reads when 'array_state' is changing from
'clear' to 'inactive', it can find the value as "clear\nve".

This causes the test for "|clear|active" to fail, so systemd is allowed
to think that the array is ready - when it isn't.

So change the pattern to allow for this but adding a wildcard at
the end.
Also don't allow for an empty string - reading array_state will
never return an empty string - if it exists at all, it will be
non-empty.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 udev-md-raid-arrays.rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/udev-md-raid-arrays.rules b/udev-md-raid-arrays.rules
index d3916651cf5c..c8fa8e89ef69 100644
=2D-- a/udev-md-raid-arrays.rules
+++ b/udev-md-raid-arrays.rules
@@ -14,7 +14,7 @@ ENV{DEVTYPE}=3D=3D"partition", GOTO=3D"md_ignore_state"
 # never leave state 'inactive'
 ATTR{md/metadata_version}=3D=3D"external:[A-Za-z]*", ATTR{md/array_state}=
=3D=3D"inactive", GOTO=3D"md_ignore_state"
 TEST!=3D"md/array_state", ENV{SYSTEMD_READY}=3D"0", GOTO=3D"md_end"
=2DATTR{md/array_state}=3D=3D"|clear|inactive", ENV{SYSTEMD_READY}=3D"0", G=
OTO=3D"md_end"
+ATTR{md/array_state}=3D=3D"clear*|inactive", ENV{SYSTEMD_READY}=3D"0", GOT=
O=3D"md_end"
 LABEL=3D"md_ignore_state"
=20
 IMPORT{program}=3D"BINDIR/mdadm --detail --no-devices --export $devnode"
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2BvNgACgkQOeye3VZi
gbnRoA/+NIXYCVAnFm6gdaR174G6MFQKDxIUIr525YVZCCDYmYCiYIN1OCarzXfc
/cAyspqxbbQmYiltEVe7iddVr89NKLgZPZ/OrttgvHwaIC64h0uDoq0q5hfg6Rtu
duIAKkl1nFa/RWiyUgcld1Hb+dYCwi8puwef9rpIscBuomhwBtlA+cXJ3m+e2zJz
Pv604D8SpqPIXRGIlQWg4hGGSAr7Zun+lDlDKQ8kEh5VPDVueL4f3Hd6mwqx8Hyj
rCzGQgk45DE25/1ZbCi1ph4nY/UjM0Qta0pjzOLi7Vs1ddCduoGwPZV4nYOOzcTz
6uHWGI9e4eJoODLpwKXZKRbENP5/rcZI8qMxffzE4UM/wGUgRv1iB/94fe6YPiSp
1PpWtSv1vPnosPNpYVMbun4S4UpX2UtA6XKZQYK50UCkyM9oho6UdBl2GjJLCrdJ
d0RhY83S1B6Hx61ihdwIJ9Z5Mx8nUfcZpaSddggr96el2x8sTjhiOga4KfJ1Ugx6
//NBTMcDl1fRGaqDPdUjX3d1mUs4IPozbnHl44ohds8emM+ocGdysZh3GMH7pHvK
BcHsyLUGJm0VAkDypYdU7opXhQvUMaO9Z6DUhc2pvUXTxlTbFsS6SzYec5AYkvUE
8NLH5VvZ6Fua9XocpNGjy/OmOMxJKOqEAWoBM8MaGObYQax4yXY=
=XwvP
-----END PGP SIGNATURE-----
--=-=-=--
