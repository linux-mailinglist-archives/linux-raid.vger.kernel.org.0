Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429C7A5E79
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 02:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfICAWc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 20:22:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:42174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727814AbfICAWc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Sep 2019 20:22:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D679AEBB;
        Tue,  3 Sep 2019 00:22:29 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Yufen Yu <yuyufen@huawei.com>, songliubraving@fb.com
Date:   Tue, 03 Sep 2019 10:22:23 +1000
Cc:     linux-raid@vger.kernel.org
Subject: Re: [PATCH] md/raid1: fail run raid1 array when active disk less than one
In-Reply-To: <9529c6d5-37f3-a7c4-db86-3ebf04a8c893@huawei.com>
References: <20190902072436.23225-1-yuyufen@huawei.com> <87pnkjdudc.fsf@notabene.neil.brown.name> <9529c6d5-37f3-a7c4-db86-3ebf04a8c893@huawei.com>
Message-ID: <87ef0ydy9s.fsf@notabene.neil.brown.name>
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

On Mon, Sep 02 2019, Yufen Yu wrote:

> On 2019/9/2 15:34, NeilBrown wrote:
>> On Mon, Sep 02 2019, Yufen Yu wrote:
>>
>>> When active disk in raid1 array less than one, we need to return
>>> fail to run.
>> Seems reasonable, but how can this happen?
>> As we never fail the last device in a RAID1, there should always
>> appear to be one that is working.
>>
>> Have you had a situation where this in actually needed?
>
> There is a situation we found in follow patch.
> https://marc.info/?l=3Dlinux-raid&m=3D156740736305042&w=3D2

Ahhh - thanks.   Multiple cascading failures there, but is certainly
could happen.
As I said, I think the patch make sense.  IT might be a good idea to add
the reproduced from the linked email to the patch description.
You can also add
  Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


>
> Though we can fix that situation, I am not sure whether other situation
> can also cause the active disk less than one.
>
> Thanks
> Yufen
>
>>
>> Thanks,
>> NeilBrown
>>
>>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>>> ---
>>>   drivers/md/raid1.c | 13 ++++++++++++-
>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>> index 34e26834ad28..2a554464d6a4 100644
>>> --- a/drivers/md/raid1.c
>>> +++ b/drivers/md/raid1.c
>>> @@ -3127,6 +3127,13 @@ static int raid1_run(struct mddev *mddev)
>>>   		    !test_bit(In_sync, &conf->mirrors[i].rdev->flags) ||
>>>   		    test_bit(Faulty, &conf->mirrors[i].rdev->flags))
>>>   			mddev->degraded++;
>>> +	/*
>>> +	 * RAID1 needs at least one disk in active
>>> +	 */
>>> +	if (conf->raid_disks - mddev->degraded < 1) {
>>> +		ret =3D -EINVAL;
>>> +		goto abort;
>>> +	}
>>>=20=20=20
>>>   	if (conf->raid_disks - mddev->degraded =3D=3D 1)
>>>   		mddev->recovery_cp =3D MaxSector;
>>> @@ -3160,8 +3167,12 @@ static int raid1_run(struct mddev *mddev)
>>>   	ret =3D md_integrity_register(mddev);
>>>   	if (ret) {
>>>   		md_unregister_thread(&mddev->thread);
>>> -		raid1_free(mddev, conf);
>>> +		goto abort;
>>>   	}
>>> +	return 0;
>>> +
>>> +abort:
>>> +	raid1_free(mddev, conf);
>>>   	return ret;
>>>   }
>>>=20=20=20
>>> --=20
>>> 2.17.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1tsj8ACgkQOeye3VZi
gblSJRAAoaHZUQY4y13UXZNbuA0XzySC9eTTdV2uptwN2Fi1ElH2NeptEDx+1hMB
1henjP3lXK38R54xSL7RBYSDfgAMUVXulxKby9kvglp6lJrvIl9KtY52jT/L8Isy
f6H3wukxu2V9etNfQ9GvabPAIVVGoUSZK/IEVOG37ICW3RS3Tt2PsRxI80W4BE3I
81+mNKFrJvkwsNrzDtLGVfmlW54EZ/77g1GdOv2dopwonFGUnLWoUndUA3kF+RV5
ykqdPAJ3En4rwDvRAKa3GBPR2rgNifatnguzB0CZJEEn0q6zSuehTIoxyFhqrQa8
8qDUzgyH7ZQ0npg/quM4wSDLtbTpFpoV9luSyEr1aKFtZmoYjvElPNxJDwix2sTu
7oa7hB5H5DiqcvLNCFKh0zYNPG1x7AGx/SNfGLEc39r/X/XfA2gDiVT2WwfnJ58x
xgmXgXiq0euOpm8yJhwdLIto0GwpovWPg1FgFYUWpeOG7800qqi6wodJT4wGmxzX
oE8cZkFcEpwJspHpbjFtUbiURrepxqaDfKD8O2BOSTsKfRPX4ER+byKPrNPYAzR/
TtE8GNSeYhU3DycCaaupPTKpiFErgZctV6ZtH1XGMNehQXHlFs84Tm998of+VH7+
sp9SAtyO+uONOO/anOYAVPKcC8VHG2oTqcMwMtXXwSdcyD6Fo1E=
=5cB0
-----END PGP SIGNATURE-----
--=-=-=--
