Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229CB184E6
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2019 07:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfEIFkm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 May 2019 01:40:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:47654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfEIFkm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 May 2019 01:40:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 008F0ABD4;
        Thu,  9 May 2019 05:40:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Date:   Thu, 09 May 2019 15:40:35 +1000
Subject: Re: Spare pool documentation
In-Reply-To: <1059881755.12544793.1557239163561.JavaMail.zimbra@karlsbakk.net>
References: <1059881755.12544793.1557239163561.JavaMail.zimbra@karlsbakk.net>
Message-ID: <87ef58yylo.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, May 07 2019, Roy Sigurd Karlsbakk wrote:

> Hi
>
> I came across the phenomonen of 'spare pools', merely mentioned in the manual pages I've found, but just, so I did some testing in my raidtest vm to see if I could make it work. It seems fine by me, but so far I don't have more than one raidset (plus the small one for the root). Are there any official documentation on this except for the few lines in the manual pages?
>
> I wrote about my tests here: https://wiki.malinux.no/index.php/Roy's_notes#Spare_pools

Thank you for sharing your notes.
There is also
   https://raid.wiki.kernel.org/index.php/Tweaking,_tuning_and_troubleshooting#Sharing_spare_disks_between_different_arrays

It is always possible to improve the documentation.  If you have
specific suggestions of change to make to specific documents, please
share them.  Maybe even send a patch.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzTvVMACgkQOeye3VZi
gblM7w//fmG2VgB+z0QkyZYnubeJ6NKr9NGVLITmYx4mVA1hSX+16+H5IREvyOBp
flkcb+dtf4BqkAdaeQkTV2I6e0RuQmnSUIL7WXyKXQbesgL1J1BNTSU4FQFw/qxS
7eFbob0PJx2aitGWLPBv6rVdk1O8ycPJrvB9HpvezzGdCCcxEnbVJqM0MBB4tEOW
/yLJ+iTbfqA7ijXHLgk8nDQxcoYpfmiJ0A5wOI51dTji4ZFMoLyLkOfp2KdP2w9T
1iKbPQXHjfBgVnGZR2BNs70TznBlyePBLShUerVLgPtpJQpKHa8mB8ENEGo89ibQ
bV+Dlcd9iYaI5RQEcU04JSyilSvAKN7B3qU8xq1o5SZOeqWKkLuywYrulxOvqZ4E
H7h5Map+k+vGk8hBdtsw3g86L+4RJeFVmxcEybuzCEEacN5thpO+sTtpXhT5mxrh
js7Gu+8xdNuw9iyJSapOj1e7NaIwzZnRZW9RkNvOC1Q2pCnzKcu5OvwHJOFKVasZ
VeIOXVXouKd6Pd5OXxtFYhDmePxhGNeewltYzsaiFV7JGZb3NMkBQchHsl6W6wjN
8bvh8s0HFUtrKyz8hq5A8GjiMNX8Nid4odtD/3oPQKqMMW1azQO89wz9OFE8xstT
n+SwLSCisGPg01BS2HqAvlKR9SC9WhRByCgazh0micWDbTTIZ+0=
=5Z9Z
-----END PGP SIGNATURE-----
--=-=-=--
