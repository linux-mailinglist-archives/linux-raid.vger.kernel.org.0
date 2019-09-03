Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE09A5E72
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 02:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfICAS6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 20:18:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:41536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727933AbfICAS5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Sep 2019 20:18:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29BA3AE8D;
        Tue,  3 Sep 2019 00:18:55 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Krzysztof =?utf-8?Q?Jak=C3=B3bczyk?= 
        <krzysiek.jakobczyk@gmail.com>, Phil Turmel <philip@turmel.org>
Date:   Tue, 03 Sep 2019 10:18:47 +1000
Cc:     Neil F Brown <nfbrown@suse.com>, linux-raid@vger.kernel.org,
        Wols Lists <antlists@youngman.org.uk>
Subject: Re: Fwd: mdadm RAID5 to RAID6 migration thrown exceptions, access to data lost
In-Reply-To: <CA+ojRwmnpg6eLbzvXU51sLUmUVUdZnpbF71oafKtvdoApX3e1Q@mail.gmail.com>
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com> <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com> <5D6CF46B.8090905@youngman.org.uk> <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com> <2ce6bd67-d373-e0fc-4dba-c6220aa4d8cb@turmel.org> <CA+ojRwmnpg6eLbzvXU51sLUmUVUdZnpbF71oafKtvdoApX3e1Q@mail.gmail.com>
Message-ID: <87h85udyfs.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02 2019, Krzysztof Jak=C3=B3bczyk wrote:

> Gentlemen,
>
> Just in order for me not to mix anything important I will quickly
> summarize what I'm about to do:
> I will try to release all the files that are being used on the target
> md0, by checking what is still being used with "lsof /data" and then
> will kill the processes that are still trying to use the array.

You won't be able to kill those processes, and there is half a chance
that the "lsof /data" will hang and be unkillable.

> After the files are being unlocked I will perform the outdated host shutd=
own.

I would
   sync &
   wait a little while
   reboot -f -n

A Linux system should always survive "reboot -f -n" with little data
loss, usually none.

> I will boot a thumbstick on that computer with SystemRescueCD and will
> try to assemble the array with the "mdadm --assemble --scan -v --run"
> applying --force if necessary.

=2D-force shouldn't be necessary, so if the first version doesn't work,
check with us first.
>
> Please confirm me if my understanding is correct.

I'd like some more details: particular "mdadm -E" of one or more
component drives.  I'm curious what the data offset is.  As you didn't
need to git a "--backup=3D...." arg to mdadm, I suspect it is reasonably
large, which is good.
Sometimes raid reshape needs an 'mdadm' running to help the kernel, and
if that mdadm gets killed, the reshape will hang.
But with a largeish data-offset, no mdadm helper is needed.

The hang was reported 307 seconds after a "read error corrected"
message. And by that time it had hung for at least 120 seconds - maybe
as much as 240.  So there isn't obviously a strong connection, but maybe
there is a cause/effect there.

Looking at code fixes since 3.16, I can see a couple of live-lock bugs
fixed, but they were fixed well before 2016-12-30, so probably got back
ported to the Debian kernel.

So I cannot easily find an explanation.

I suspect that if you just rebooted, the reshape would restart and
continue happily (unless/until another read error was found).
Rebooting to a rescue CD is likely to be safer.
Likely worst case is that it will hang again, and we'll need to look
more deeply.

In any case, I'd like to see that "mdadm --examine" output.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1tsWcACgkQOeye3VZi
gbnV1g//TqoCwPKr8iwWm/kUQMuJaj6NB25AvNESOwaclMEFDODQlLRSeukU4yHR
QlEVmtHBWiKed0ZZD5k976dLmXsmSmYOsrJQ01R94Yu1v5MJcXDYBe1hXn+tCHqx
9JMn1cOdh4adAsmgVcNtCGwJsfZTKB+dFnx8Sona7ezJ6ewXVwO+B9hDvJz6Ldwa
qTZREEGiL9FPcFOQ/DFhIsBjjZhwYbQidPfq8RHzT1wmVK6Rapc9R5hppwhfhTYP
YU4VZXNr92zTpuKG7Fq4seTvbEuNfwqUkQ/D/2McVXEj8zhiqeIx6JBp46nGFBqm
4AW7VoIW5FjBCFB+cy+w75yf3u53v/5AD1STPf1SqdQ7uJxPKy/UwamDn+dgmG1i
Gl4EwOyyhWJhkQTE8v/zVxykxUkzPMeKq8wDSnrKeWBXCNwmAZg4Spcey4LS++jU
CbhlScowAdMjW2VAfggXqDqGBDMdR7FYhGnJRDnpwO4j5KjfUmpEWpVI1bK+pKew
nVr2UIgJRdaeX2owbF5K6U1CIsuB2wxjmz6QGBJc+CfaP8M8jdqOJTST0s4b7+wM
GnpbqsFFslvh1+kRiKKarCpD/mRqJRR2Ho29T7s1VMeUcZ7Tl3eT7nSstOEqNwu1
W2a6BOWyoBKkkoXrypfJgyaIdqFNMx5jIhaFoIaTf5jxaZYwAFw=
=WvxS
-----END PGP SIGNATURE-----
--=-=-=--
