Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4212E197106
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 01:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgC2XIQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 29 Mar 2020 19:08:16 -0400
Received: from reetspetit.info ([212.83.164.73]:52674 "EHLO reetspetit.info"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgC2XIQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 29 Mar 2020 19:08:16 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2020 19:08:15 EDT
Received: (qmail 17294 invoked by uid 453); 29 Mar 2020 23:01:33 -0000
X-Virus-Checked: by ClamAV 0.100.3 on reetspetit.info
X-Virus-Found: No
Authentication-Results: reetspetit.info; auth=pass (plain) smtp.auth=john
Received: from 239.red-80-59-216.staticip.rima-tde.net (HELO home.reetspetit.net) (80.59.216.239)
 by reetspetit.info (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-SHA encrypted); Mon, 30 Mar 2020 01:01:33 +0200
Received: (qmail 9551 invoked by uid 453); 29 Mar 2020 23:01:29 -0000
X-Virus-Checked: by ClamAV 0.100.2 on reetspetit.net
X-Virus-Found: No
Received: from ReetsLaptop.reetspetit.net (HELO ReetsLaptop) (192.168.10.82)
 by reetspetit.net (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Mon, 30 Mar 2020 01:01:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=safeandsoundit.co.uk; h=date:from:cc:subject:message-id:in-reply-to:references:mime-version:content-type; s=default; bh=xbfv0YgIDWxSPbV503Vq9z87QQbd6kMaCopoWzT7nHU=; b=QZRC7JmaoJvHeAQmXbMcdRidzKTzyhOUIMsSUbLC1LqYmEAEGMbjl6HTutqrYIzrRrJvH/jbg4N799rYIIDM4nalb70l6zgQ7xNEstiqNk3bPCrtRHdOLB2nq6Mh022/Q/TD08hbE1nPFsevmyW6MveW+piwlWpFkJ7K1x3rcFVqK3AKWDmSV4MFc3gCDn/9JV8F5DzM+k/+uRPvRoAmu0m6eC4vDndajhPsmNGBkZ5W/QD605zRv02IQNQwQNJz/MauCTMwgxeT3OciRrjgYrMmjqTp+aKTP6/kjGSHuUqxrz/Wc2Z7k61qvGCVRk+SnONTFMCu94dA8hBNxOJluw==
Date:   Mon, 30 Mar 2020 01:01:27 +0200
From:   John Crisp <jcrisp@safeandsoundit.co.uk>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Requesting help repairing a RAID-6 array
Message-ID: <20200330010127.21b9f723@ReetsLaptop>
In-Reply-To: <20200330033539.6171d8a5@natsu>
References: <etPan.5e80defb.10afc736.32ba@crowston.name>
        <fc847f59-b221-c97c-28d6-813f8d79f15f@youngman.org.uk>
        <20200330033539.6171d8a5@natsu>
Organization: SafeAndSound
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/kHY=Fibv/UMxa5qC=cVrVbo"; protocol="application/pgp-signature"
Original-Authentication-Results: reetspetit.net; auth=pass (login) smtp.auth=jcrisp
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--Sig_/kHY=Fibv/UMxa5qC=cVrVbo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Mar 2020 03:35:39 +0500
Roman Mamedov <rm@romanrm.net> wrote:

> Not suitable as a ...drive.
>=20
> That model is literally the only hard drive in the world to get its
> own Wikipedia article[1] for its awful reliability.
>=20
> [1] https://en.wikipedia.org/wiki/ST3000DM001
>=20

Up there with the Deathstar then

https://en.wikipedia.org/wiki/Deskstar

Ahhh the click of doom....

--Sig_/kHY=Fibv/UMxa5qC=cVrVbo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEjK6/QfNffar/UqviTxujxO/QWskFAl6BKMcACgkQTxujxO/Q
WsnhrAf8CvTRXMeBd0CSO2fyjPAEQ/eEekkjaluo0nLoSuFm6xdIofOAx5PvxSZS
vaMK/Pc4KImVPTLzsbuyXC6jyXwLYGZ10vOvujNeXu1eutGnMYBFkek/OinT2USa
I2W4QDrWoDWu4iRHCP1hZSgxZlEoBQq/OMwMtCmfAot3r0heJ6Z55FCV2kmdBaHq
hXUIi71IgHyAK3sr+QAkPp4sMeeK8ne6T4XtZUYvtAEgCoUMURjMzXUlMzxU+FMy
ebkKrYzOH0UKywT7x+eNHfMjH9NbAZDAGRyzGlp84azbKWKSm3xrdQvPEXLX+c/c
mtHlRybAf70lR5gwePkhM6EL4q6Ffw==
=Bk7l
-----END PGP SIGNATURE-----

--Sig_/kHY=Fibv/UMxa5qC=cVrVbo--
