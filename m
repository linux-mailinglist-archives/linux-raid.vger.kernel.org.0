Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 306208F87E
	for <lists+linux-raid@lfdr.de>; Fri, 16 Aug 2019 03:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfHPBjm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 15 Aug 2019 21:39:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56624 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfHPBjm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 15 Aug 2019 21:39:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57C5EAD6B;
        Fri, 16 Aug 2019 01:39:39 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Song Liu <liu.song.a23@gmail.com>, Xiao Ni <xni@redhat.com>,
        Neil F Brown <nfbrown@suse.com>
Date:   Fri, 16 Aug 2019 11:39:28 +1000
Cc:     Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] raid5 improve too many read errors msg by adding limits
In-Reply-To: <CAPhsuW5+vk4Ln84JSe-QEt-O2xee9d63B8aGEpxFLVfZWADEfA@mail.gmail.com>
References: <20190812153039.13604-1-ncroxon@redhat.com> <f79ead58-9feb-4b0b-5f29-fd1a4f10342f@redhat.com> <CAPhsuW5+vk4Ln84JSe-QEt-O2xee9d63B8aGEpxFLVfZWADEfA@mail.gmail.com>
Message-ID: <875zmxj3cf.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Aug 15 2019, Song Liu wrote:

> On Mon, Aug 12, 2019 at 4:38 PM Xiao Ni <xni@redhat.com> wrote:
>>
>>
>>
>> On 08/12/2019 11:30 PM, Nigel Croxon wrote:
>> > Often limits can be changed by admin. When discussing such things
>> > it helps if you can provide "self-sustained" facts. Also
>> > sometimes the admin thinks he changed a limit, but it did not
>> > take effect for some reason or he changed the wrong thing.
>> >
>> > Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
>> > ---
>> >   drivers/md/raid5.c | 4 ++--
>> >   1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> > index 522398f61eea..e2b58b58018b 100644
>> > --- a/drivers/md/raid5.c
>> > +++ b/drivers/md/raid5.c
>> > @@ -2566,8 +2566,8 @@ static void raid5_end_read_request(struct bio * bi, int error)
>> >                               bdn);
>> >               } else if (atomic_read(&rdev->read_errors)
>> >                        > conf->max_nr_stripes)
>> > -                     pr_warn("md/raid:%s: Too many read errors, failing device %s.\n",
>> > -                            mdname(conf->mddev), bdn);
>> > +                     pr_warn("md/raid:%s: Too many read errors (%d), failing device %s.\n",
>> > +                            mdname(conf->mddev), conf->max_nr_stripes, bdn);
>> >               else
>> >                       retry = 1;
>> >               if (set_bad && test_bit(In_sync, &rdev->flags)
>>
>> Hi Nigel
>>
>> Is it better to print rdev->read_errors too? So it can know the error
>> numbers and the max nr stripes
>
> I think rdev->read_errors is more useful here.
>
> Hi Neil,
>
> I have a question for this case: this patch changes an existing pr_warn() line,
> which in theory, may break user scripts that grep for this line from dmesg.
> How much do we care about these scripts?

I don't think we need to care about this.  Kernel log message aren't
normally considered part of the ABI.
However in this case, it might actually be more readable to have just
add another line:

  md/raid:md0: 513 read_errors, > 512 stripes
  md/raid:md0: Too many read errors, failing device sda1

??

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1WCVEACgkQOeye3VZi
gbkJVQ/+M1t1txe4mUU9eFz+3mavrEsuilZBmPVXciqAnQFOe940yZIeusES0/NR
2vtZrdb/ql2ZoqRQu7jgXCpHM7Zf1dWGE8PuW4YIo5Tq0PGvAdzcvB3mHu+0gDbt
++5nx7KjIIyPcef3UlmTL3FIhhscmW6kPClmDNWSHwMk+CUOWogCHPgi9FmEbrfM
rsnZ0WN+vqPbSu2hg3f+y3xAtqKCOzbmNID3e7hB8CRptMCihaZBVbApBXADDviK
GDFiHaY8EvMgteaEPzSgclBCsjcS4GOFxhrHTclg93dllqq63/TI6VTEV6vgtQnH
pTYrC/Wk73Y4FT8RQiyLM2Zh9bEVrJGq5fvLWnG+Wfni85wGQz4g2uc6GXKb1ocC
2y8JJAMLv5cz74MSOSXc37fYpOD5y+0t4guoxpaQhMiq63sooNsfR4TOx/D0b1DK
9KUnA/eAaaDf7CsoXW0OM3Ftf8gGSr+wHtwG4b+Ok29Qlf8jVTu1lzVkRPAzLTOF
2WNvrv6aBlpmD4fz8WLcF5JS4DJ4kzCEeA+fzaXSHIb7v3qOOjosA1GP0JWAJMj3
U7FdZ5FHwYBtwRXDAD8r8tNJIG7P6qJtCILQfUGnJX+r1Lc3qTa5geu62F7JQR94
3HVSKIPozJ3frLDC3B3KASkc/6ix5e3f6qtfwvh/S/Rdl0bsZR8=
=LjSV
-----END PGP SIGNATURE-----
--=-=-=--
