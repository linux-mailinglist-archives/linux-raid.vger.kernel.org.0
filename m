Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADB0EA7ED
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 00:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfJ3X7E (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 19:59:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:38144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbfJ3X7E (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 30 Oct 2019 19:59:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A138B307;
        Wed, 30 Oct 2019 23:59:02 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Thu, 31 Oct 2019 10:58:57 +1100
Subject: [PATCH mdadm] Makefile: support latest gcc: address-of-packed-member
cc:     linux-raid@vger.kernel.org
Message-ID: <87k18leqf2.fsf@notabene.neil.brown.name>
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


super-intel often takes the address of a packed member,
and seems to work.
So suppress this warning.
(Earlier gcc ignore the new flag)

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dfe00b0a0be8..0768cc5b566e 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -48,7 +48,7 @@ endif
=20
 CC ?=3D $(CROSS_COMPILE)gcc
 CXFLAGS ?=3D -ggdb
=2DCWFLAGS =3D -Wall -Werror -Wstrict-prototypes -Wextra -Wno-unused-parame=
ter
+CWFLAGS =3D -Wall -Werror -Wstrict-prototypes -Wextra -Wno-unused-paramete=
r -Wno-address-of-packed-member
 ifdef WARN_UNUSED
 CWFLAGS +=3D -Wp,-D_FORTIFY_SOURCE=3D2 -O3
 endif
=2D-=20
2.23.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl26I8EACgkQOeye3VZi
gblkhw//UE8lAhZKD9TXKHg3DSzxoB+M27cn8xGCF3vJtj4/Ti2Y+04ocRAKVn+Z
ziyjZftM3bWrzEE/3hAKSIUany7mCRgTfc2jONMWLgStfMFzw/KZfX9V5I/C/ALd
ycCrbUBooafNgKmLKXzNVLH4n7k2MuM04y6ThnYCn8C/9xyZ7+P18DML3Hx1cEl/
XJwxiJpin17WisVJe0iPuvosqglsN8BZCB2cHYsUlxT+qsxOmSL1xPSNTDxuldjC
YyMPwPgai4wm7geQCAj4SKEkfcs6Us4GlfnR29tvJExb3XWzHuHkKKKH7LRqytTy
Q4KL0T+lLgkcOb7i4XezVw3JNmirMZ0n9qfq3xFYPV4O95nPXmL4OIAVfi+mudkG
9E4pWMdYIL1+1N1eWQjh2QfEXmh18ECvEdDGMaPjKntqXNbPXn6uZKWqNnq66WD0
m1ItEB83w6nllMmTnJFlJo85YI2X1YBN8avNio4Kh+g+zvlMJFkERsv4BXWNuGg4
2rcEZWlxyDv4QCA12mGBU/t/Fn2fOkzBYwzqMGLyPZHhanN0KDeKMTRnRHIYy8st
bxzqNatpmh4v5cxH/A7bQyDWD0PehulaO2T0IwCBnOW0kJR6/RImydbUZJUQkrcV
O8a9Mx2hg4u4A/cQkKHsrmGjNDYvOLG83rfxid6S1HPUrtp32+k=
=bG8e
-----END PGP SIGNATURE-----
--=-=-=--
