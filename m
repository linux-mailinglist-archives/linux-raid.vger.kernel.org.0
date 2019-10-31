Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF2EA97E
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 04:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfJaDSk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 23:18:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:51828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfJaDSk (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 30 Oct 2019 23:18:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B957DB306;
        Thu, 31 Oct 2019 03:18:37 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Thu, 31 Oct 2019 14:18:30 +1100
Cc:     linux-raid@vger.kernel.org,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Subject: Re: [PATCH mdadm] Makefile: support latest gcc: address-of-packed-member
In-Reply-To: <1f57b1a1-70bd-15a4-4693-1b72aa5546f1@gmail.com>
References: <87k18leqf2.fsf@notabene.neil.brown.name> <1f57b1a1-70bd-15a4-4693-1b72aa5546f1@gmail.com>
Message-ID: <87h83peh6h.fsf@notabene.neil.brown.name>
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

On Wed, Oct 30 2019, Jes Sorensen wrote:

> On 10/30/19 7:58 PM, NeilBrown wrote:
>>=20
>> super-intel often takes the address of a packed member,
>> and seems to work.
>> So suppress this warning.
>> (Earlier gcc ignore the new flag)
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.de>
>
> I am kinda in two minds about this. I started cleaning up some of the=20
> newer gcc stuff a while ago, but then got stuck on super-intel.c
>
> I want the code to build, but I also feel super-intel.c needs cleaning=20
> up and made to use accessor functions or something like that to deal=20
> with these accesses in a better way?
>
> Thoughts?
>
I wonder how much we really need the __attribute((packed)) ...
The structures look well organized and dense to me.
Maybe remove the attribute and add a BUILD_BUG_ON() if the sizeof()
is wrong??

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl26UoYACgkQOeye3VZi
gbletA/+P3seBBAuhyN/wzpSEtW+XHWvYv5MzB/sjYVMbzO9g8/1kgjLg81m4xXH
IEn42N+9xtaobXBnvyGVBPMTF0itKKUhTtifXPZ3Fn1vXuv23/abGN1RN8Kv1Lou
T0ireYkX7usTQtNpN9yitAe03Bwb/kCuMhzzWcQ7KlmO+mPwKM1FtgSGByg1EBXk
n51nXPQHpDRdeUdUAIJYVLnp0Y81itm77M2bjPBeFgIhuKpwIGyzP0bUt7FEMDf2
ZyyppOAbN06mgsvpANh8tqSgOATBDLoz8HYI+1T+iCX+McKreR84Otkl+Bz/Jsee
W/8VAv39BCmqTXSK9CY7dsznonMXKkiRcQooTetiw99U0T2jrZ3ZCbJJNp9wZo0r
Sej6pMZGTm5WSANCMzZ72R3jD/27txYylDLavvfGQMj0rY+KZuLKPKV9edsO6xDA
nZ/xjke0xGIbeQMSkM49HZVliGAGkNZopQV/dSVULxbT7YdhbxFwQ1L3+rC9TcWO
oDl5bQO65rscBkQgVrZuhe/ig75r3KsyBIsLmq2iDDJKuspu+mC5aqB5pFCkfD8V
9TrvW2xYE7IobMPBTvqppioyjuzr87f6uCzR2tZc+3DKMTHKafNMw8EWIz82P7fd
mOskRn1fIDpZ51rJG1eQCv/CroegOimMm/uxOMDp9uP5P76GeQU=
=xWxo
-----END PGP SIGNATURE-----
--=-=-=--
