Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18D2C3C45
	for <lists+linux-raid@lfdr.de>; Wed, 25 Nov 2020 10:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgKYJjA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 25 Nov 2020 04:39:00 -0500
Received: from ns1.ant.gliwice.pl ([195.66.73.63]:40104 "EHLO
        mail.ant.gliwice.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725921AbgKYJi7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 25 Nov 2020 04:38:59 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2020 04:38:58 EST
Received: from matkor-hp.localnet (unknown [91.198.89.112])
        by mail.ant.gliwice.pl (Postfix) with ESMTPSA id 1775CC239;
        Wed, 25 Nov 2020 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ant.gliwice.pl;
        s=default; t=1606296695;
        bh=/VlzlTxXe6SYEhydHUJFKq47ZfNNlI4S2Z5eIfz/6Dk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Rj/Cykb8EjGWVaqeB1Cih9AOlb+uiUIcKXxuY2hEchzvQqJMaSwuKVJtCRQPlkjTf
         nb4y2vYvquObBrOtrQ/Fn6zFQNTCuiXe1KL6MjkYZvDr2ZSMisP4jVj9uehR3LAJJN
         38oBgNvDen+4GS4mRVf2PtVvYO0wNVhMsqmS/3GGFVJF15EWquTNj+F/wShkIfHCcS
         8m0/pCHXaS6LnCuy+m65jv6IgJEM1A2oaMTIX6HI/CI+2Gc1IBY3KvrOhhj1mylXeb
         ZHjFirz2BhiTGeGa9aJ67gUSMTEUGK94E9ZXqBLGrYevN44UV+J9Aema+1DUTeSiya
         8XstyQ3xNSQwg==
From:   Mateusz <mateusz-lists@ant.gliwice.pl>
To:     Linux RAID <linux-raid@vger.kernel.org>,
        Alex <mysqlstudent@gmail.com>
Subject: Re: Considering new SATA PCIe card
Date:   Wed, 25 Nov 2020 10:31:32 +0100
Message-ID: <9796958.nUPlyArG6x@matkor-hp>
In-Reply-To: <CAB1R3sgQm2_-Bhbzned4y056XP5hM9oz1OnTZSfHH9+L5sdpFQ@mail.gmail.com>
References: <CAB1R3sgQm2_-Bhbzned4y056XP5hM9oz1OnTZSfHH9+L5sdpFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On =C5=9Broda, 25 listopada 2020 03:20:20 CET Alex wrote:
> (...) server with 4x4TB 7200 SATA disks in
> RAID5 (...)  motherboard has two
> SATA-6 ports on it and the others are SATA3.
>=20
> Would there really be any benefit to purchasing a new controller such
> as this for it instead of the onboard for the 4x4TB disks?

I doubt it, unless your MB HW/driver is broken, as usual max transfer rate =
of=20
7200 HDD is  around 150MB  and SATA 2.0 ( 3 Gbit/s ) limit is 300MB
Check current HW performance by sth like:
iostat -x 3 -m
and verify if you are close to expected HDD values under real load/test=20
stress.

> I'm also curious if the SATA cables have improved over time, or are
> the same cables I purchased five years ago just as good today?

If controller works in SATA-300 mode on all ports already, you will not get=
=20
any benefit from newer (SATA-600) cables neither.

Regards,

=2D-=20
Mateusz=20
(...) mam brata - powa=C5=BCny, domator, liczykrupa, hipokryta, pobo=C5=BCn=
i=C5=9B,
	kr=C3=B3tko m=C3=B3wi=C4=85c - podpora spo=C5=82ecze=C5=84stwa."
		Nikos Kazantzakis - "Grek Zorba"



