Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CCC1C387C
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 13:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgEDLmz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 07:42:55 -0400
Received: from truschnigg.info ([89.163.150.210]:44982 "EHLO truschnigg.info"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgEDLmz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 4 May 2020 07:42:55 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 May 2020 07:42:54 EDT
Received: from vault.lan (84-112-34-152.cable.dynamic.surfer.at [84.112.34.152])
        by truschnigg.info (Postfix) with ESMTPSA id D0735200EB;
        Mon,  4 May 2020 11:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=truschnigg.info;
        s=mail; t=1588592217;
        bh=bGafGHbvRCXI0I1MH8VBiR/hvPCGApAiGhZjpsDJ1dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtDQKTvsFkVVFqWLyTiM3vUCpkPzb2hnB3PxIk/BTGGX4I76uI2eJV3tmaAN6gIQ6
         4Ur+p38VCbcQ1C7rGb7Ulp65uUyb2Ka3OtZEhuJudTaksXAVMXpiNL2FMJgl9qur7+
         s1MJ+TCh42MFvOtKVKL+9rL0f/5KjqmcEyrof/Zg=
Date:   Mon, 4 May 2020 13:36:53 +0200
From:   Johannes Truschnigg <johannes@truschnigg.info>
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Subject: Re: RAID 1 | Restore based on Image of /dev/sda
Message-ID: <20200504113652.GA22487@vault.lan>
References: <5e29b897-b2df-c6b9-019a-e037101bfeec@peter-speer.de>
 <5EAFF763.2000906@youngman.org.uk>
 <58659d1e-bcce-553c-fe68-52d075422252@peter-speer.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <58659d1e-bcce-553c-fe68-52d075422252@peter-speer.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steffi,

On Mon, May 04, 2020 at 01:26:35PM +0200, Stefanie Leisestreichler wrote:
> [...]
> Thanks, Wol, especially for the hint with the GUIDs, will keep this in mi=
nd.
> If ever using it again - maybe in case of a quick temporary replacement in
> the original computer - I will wipe it with zeros before.
>=20
> The partition layout will be cloned using sfdisk.

When dealing with GPT partitions, you might want to consider using `sgdisk`
instead. It features -G|--randomize-guids and will be able to clone a GPT
table from one drive to another in one go, without you having to iron out
UUID-related problems that "naive" cloning (which I believe `sfdisk` will
perform) will introduce.

Hth!

--=20
with best regards:
- Johannes Truschnigg ( johannes@truschnigg.info )

www:   https://johannes.truschnigg.info/
phone: +43 650 2 133337
xmpp:  johannes@truschnigg.info

Please do not bother me with HTML-email or attachments. Thank you.

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGu9IhkI+7/aKLUWF95W3jMsYfLUFAl6v/lEACgkQ95W3jMsY
fLXefQ//TBRQj61bcfHz4m021Js1fNIWJ6MvTs8BHpejDpIPleU8sXsRP5P3mXA5
q6nx1sfOaxw0Djwaspz8MN7zfEWGVCmC3/BtjOPONUGTw2U2z/l/XgpnYK91KIFg
ZKGHclmPhpVPDVcuylQeZ+/XzlIwseig9mILRMorovAv2rV3mLBzK67Ue+aNKP6/
ZpMCSkVTRE29mS00QTSFs/SU7twcRraXCF3sh1YPEyYzmHESh8gMhRtW9p+r/W12
gWunYa3ko4mSwDj9dehM58873f71xBRi8eaGLEg1DQ02K7aLiZOvhJfOvVdpKW82
Mnu6KWVjVe8GEKg6wx5JpS7Q9TkspZWEZVe1gcr2azHEWYPGVPIgZGcYH+8QkD4X
XOQQTx6MxE+t4jIOiwz/i5aV/8BQtWv523IEIcIkPU8hHkgv2OGv4hWFp2a3Td4N
aJBkUtXzAGSBDFkrvK4qCoTh51RdPK3eiySq99tryEnhbcIwWhB1fYwsTnO9PdxK
GU9qBOKwgmBEoHE/2JcOsnz/0Vx4qF92jYhmw5ooUCjcRUSb1yIFDcdS90Tg0Gkh
hNH5gf0AUGu5cU4UJF9FfolPHAZkSHn+vF8SBLzZlC4ohv11lYlO8IoiHPvmsayx
6oVPeB6LKZlKc5YHmdCdg12RXRgwloBPNO/8CdK8VBhGQIgLdVE=
=MJkY
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
