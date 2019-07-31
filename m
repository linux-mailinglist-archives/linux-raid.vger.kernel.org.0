Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A6A7B72F
	for <lists+linux-raid@lfdr.de>; Wed, 31 Jul 2019 02:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfGaA2v (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jul 2019 20:28:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:41428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfGaA2u (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 30 Jul 2019 20:28:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83660B019;
        Wed, 31 Jul 2019 00:28:49 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Bob Liu <bob.liu@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-raid@vger.kernel.org
Date:   Wed, 31 Jul 2019 10:28:41 +1000
Cc:     jay.vosburgh@canonical.com, songliubraving@fb.com,
        dm-devel@redhat.com, Neil F Brown <nfbrown@suse.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for raid0
In-Reply-To: <d730c417-a328-3df3-1e31-32b6df48b6ad@oracle.com>
References: <20190729203135.12934-1-gpiccoli@canonical.com> <20190729203135.12934-2-gpiccoli@canonical.com> <d730c417-a328-3df3-1e31-32b6df48b6ad@oracle.com>
Message-ID: <87ftmnkpxi.fsf@notabene.neil.brown.name>
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

On Tue, Jul 30 2019, Bob Liu wrote:
>
>
> Curious why only raid0 has this issue?=20

Actually, it isn't only raid0.  'linear' has the same issue.
Probably the fix for raid0 should be applied to linear too.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1A4LoACgkQOeye3VZi
gbn0wRAAuH9h2Qxza5xLzWsV8tlEajzIAXMeAxp4Q+IY9Na0AgXSZPtyyE5lv2TR
wcQhQPFc+rDV+GF2rWoDOkhLKhJENtiTUoGH8ZrhU4C9hW5NRjDx80DruXKwBRll
G5OxcVY9kCDAOPtJnQHw6YjUwvWCiuoYnGqwBqoilnprsH13gPs1YFgaX+wvAj3P
ReAYsTxXQnPOQScQLJQlyis6s+unhCb8++viZmEVSnjK7i+W4i16p2xKyZTWXmXe
FZ+rsOiSll2aaYaBHIGH4oIW7wTNFeOt0z9hJ+Ce0aoQDynccbrNgtoKvkS7NN2O
k8Ci9sGX/GAmUmMD1pZgbJaRaPzMmY61gtVh25hKBMXSe9BTn+B1X9dYm44wQdP0
+hI0lSo4aP0v+aH2KByTg8e2VOOKEgtxJbeqDybgkxjGAiKW8Q82PnCt7jPmAbth
MCFuLsRp/jBClDvvvQUAYTa5rX4rASKzdFs9bQ3O7xG78SUoBBm9qyXu2HjAbYWO
BBXKWLqOXkjol1m5NWJMvY8XIvIhl8SDZNy4kzFdbuSD7eXIWBrp+RXFo7aMdRv9
krY0LAjQKYrzB7TmK7JJmI3rvGnSzBi4pQrJNc6NjOTyaCYF2qg/4LexXa27fNXj
lmWELXJmHvz4WHPJvjhPY5FAO2NjeNNDGpb5AJy4eDhyuF7hfH8=
=ErRK
-----END PGP SIGNATURE-----
--=-=-=--
