Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 703B2A3315
	for <lists+linux-raid@lfdr.de>; Fri, 30 Aug 2019 10:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfH3Inz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 30 Aug 2019 04:43:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728604AbfH3Iny (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 30 Aug 2019 04:43:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC1EEABB2;
        Fri, 30 Aug 2019 08:43:52 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 30 Aug 2019 18:43:46 +1000
Cc:     Neil F Brown <nfbrown@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: WARNING in break_stripe_batch_list with "stripe state: 2001"
In-Reply-To: <a2536d84-68df-3422-b677-66c666ebb35b@cloud.ionos.com>
References: <7401b3e0-fb0c-8ed7-b1cb-28494fbac967@cloud.ionos.com> <e2aad07c-1f67-12c7-ac33-6df9cbdac43c@cloud.ionos.com> <CAPhsuW4gu4BaU=2cTNSGQoLEp4xeixRMgDrqfw0Eoxiu=QfeBw@mail.gmail.com> <a2536d84-68df-3422-b677-66c666ebb35b@cloud.ionos.com>
Message-ID: <874l1zf3gd.fsf@notabene.neil.brown.name>
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

On Tue, Aug 27 2019, Guoqing Jiang wrote:

> Hi Song,
>
> Thanks a lot for your reply.
>
> On 8/26/19 10:07 PM, Song Liu wrote:
>> Hi Guoqing,
>>
>> Sorry for the delay.
>>
>> On Mon, Aug 26, 2019 at 6:46 AM Guoqing Jiang
>> <guoqing.jiang@cloud.ionos.com> wrote:
>> [...]
>>>> Maybe it makes sense to remove the checking of STRIPE_ACTIVE just like
>>>> commit 550da24f8d62f
>>>> ("md/raid5: preserve STRIPE_PREREAD_ACTIVE in break_stripe_batch_list"=
).
>>>>
>>>> @@ -4606,8 +4607,7 @@ static void break_stripe_batch_list(struct
>>>> stripe_head *head_sh,
>>>>
>>>>                  list_del_init(&sh->batch_list);
>>>>
>>>> -               WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
>>>> -                                         (1 << STRIPE_SYNCING) |
>>>> +               WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
>>>>                                            (1 << STRIPE_REPLACED) |
>>>>                                            (1 << STRIPE_DELAYED) |
>>>>                                            (1 << STRIPE_BIT_DELAY) |
>> This part looks good to me.
>>
>>>> @@ -4626,6 +4626,7 @@ static void break_stripe_batch_list(struct
>>>> stripe_head *head_sh,
>>>>
>>>>                  set_mask_bits(&sh->state, ~(STRIPE_EXPAND_SYNC_FLAGS |
>>>>                                              (1 <<
>>>> STRIPE_PREREAD_ACTIVE) |
>>>> +                                           (1 << STRIPE_ACTIVE) |
>>>>                                              (1 << STRIPE_DEGRADED) |
>>>>                                              (1 <<
>>>> STRIPE_ON_UNPLUG_LIST)),
>>>>                                head_sh->state & (1 << STRIPE_INSYNC));
>>>>
>> But I think we should not clear STRIPE_ACTIVE here. It should be
>> cleared at the end of handle_stripe().
>
> Yes, actually "clear_bit_unlock(STRIPE_ACTIVE, &sh->state)" is the last
> line in handle_stripe. So we only need to do one line change like.
>
>
> @@ -4606,8 +4607,7 @@ static void break_stripe_batch_list(struct=20
> stripe_head *head_sh,
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 list_del_init(&sh->batch_list);
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (1 << STRIPE_SYNCING) |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 WARN_ONCE(sh->state & ((1 << STRIPE_SYNCING) |
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (1 << STRIPE_REPLACED) |
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (1 << STRIPE_DELAYED) |
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (1 << STRIPE_BIT_DELAY) |
>
> I will send formal patch if you are fine with above, thanks again.

This is probably OK.

I think that when the 'handle_flags' argument is zero, an error has
occurred and STRIPE_ACTIVE is expected to be set.
When it is non-zero, it shouldn't be set.
I'm not sure it is worth encoding that in the warning, but it probably
is worth making that clear in the commit message.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1o4cIACgkQOeye3VZi
gblUPQ/+IHKcuNLXm4wzSfjGqRpo8THXLy0k2VryUdEEmnj7wJlYl9K5TQvnC0pd
kZGJyy5963fAYnWga7LV5iyLYfHk4wXWEcD2b5BiI8frPIDr1Dcvac8gdHRrcC/7
uK30mB3gvIeLhBEN9xGo3dnxLEwJ42HzPSXM1nb2S/9esjpbb1hQdjczf+oaoqXd
pQvjq8PTTcb4k+xBDeWhPVdq9wNjnnee+BKrMB6uGIDjRdn1/bOFxDRki3+82qAQ
N3+PwOq+3/9OIH0xjpfyrIPTcvMwziBgNvwK2+aQ877q3XHE1WQ4bjt1jYwHPVJP
J6bLymIvX8MYUhlredkPcgYfQNrAOYbMoGwyqEOBXgl7NoaFvfTjPYDmkN6zj6WU
QQZgaxyFqGgWJYxzDWUlarkoL7272rO2jEQnljoTySIPOt5SoDXYvqONdBDUAUQY
34Ded2ayFzNsYVpHF7PcTd52OHdUi5Qh7tnG8ATq1U4bytW/Q0ZPRwT3y6z6A1XR
FpazMv2WiKhx3hJJ9j2jH8kEGOwyqk4snby3QGDDC4veYY1M8EGlt16fbsqwTiAT
XqjE/ZdKgiU+WmZjofHM/JaLulmeao057HATzlPp1Aiy4fZXXQirK/zWKQZORjLa
NdmxGhBcIPKfRMrXuypnadldMG3E4fnvHyROaLm39ZjufTaPJN8=
=s4IR
-----END PGP SIGNATURE-----
--=-=-=--
