Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70E209C72
	for <lists+linux-raid@lfdr.de>; Thu, 25 Jun 2020 12:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403836AbgFYKE3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 25 Jun 2020 06:04:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:37778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403809AbgFYKE3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 25 Jun 2020 06:04:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8ADB0AFD1
        for <linux-raid@vger.kernel.org>; Thu, 25 Jun 2020 10:04:27 +0000 (UTC)
Date:   Thu, 25 Jun 2020 12:04:27 +0200
From:   Ali Abdallah <ali.abdallah@suse.com>
To:     linux-raid@vger.kernel.org
Subject: mdadm calendar specification format error
Message-ID: <20200625100427.rsu56aa4zopqhilb@frix230>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="alvs6pyiehv63xkd"
Content-Disposition: inline
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


--alvs6pyiehv63xkd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Somebody can kindly take care of https://bugzilla.kernel.org/show_bug.cgi?i=
d=3D208283=20

Attached to the bug report, there is a very simple patch to correct the
OnCalendar syntax.

Kind regards

--=20
Ali Abdallah | SUSE Linux L3 Engineer
GPG fingerprint: 51A0 F4A0 C8CF C98F 842E  A9A8 B945 56F8 1C85 D0D5


--alvs6pyiehv63xkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEUaD0oMjPyY+ELqmouUVW+ByF0NUFAl70dqcACgkQuUVW+ByF
0NXY9A//T+UBQ+a7Jg7sgEHkyrSmfVLXkrfn+WxzGG4V6hxDU4PjpeA34CNa0H/J
Zg7fbF5qXYDrshqHtArch8SZq/SrB1WiAuVqQy+6BObXzMBY3FBEkPXG9jEPUoaV
C1I0kD1JZt3vs51NZyuBc2ejxL3/AzRkVt9zAdXT1QeDaGwb7gCRGMNQvyQD4+GJ
D6BxlxX5EPlxd91VRQcKIvizaY2Cuj2kxAlmWGKzFCYprZBfB/Z/WYcw5Vb/ANFj
H/Kg7/eqzW+5WvINCkIfd9BmmIKBo/pyteeIMSTa/VqN+64OnC7CmRVZCm8WnVYL
wHD8UTXcHhib4GMg4a3Y9f+P6cJClhkrayklURMOsFSo2XBpTB1PYx7vgBFOJyFi
zMeJ5hyoUv+H1jDHHxsaZMyGgR6syVArVXhxT0EkUqsu0C1xjhKTnW1RimBCde6t
pybyJD/Kv5hTo3wxem6pYvpMeYjjxSOzz4/B4YB6v7x9V2HS1/RiuLwJY0ObLFzy
wPFFk9h7ApeeNyPM3LhE87wsKquEAPDbtyRKfZgEdpUl5WTl6fKaoz/IfAIDnmWy
r5TFQOkknJrXscIkr09Jf2TTVA+tc9jDUJmAQqNAxLa5JhLdDFX4NJ9MYd9KwYhd
K0BKyloctpztQb0siorZpnAnZlQhi/h9Q3ZuRL0Dd05tt8SGF7I=
=YrL6
-----END PGP SIGNATURE-----

--alvs6pyiehv63xkd--
