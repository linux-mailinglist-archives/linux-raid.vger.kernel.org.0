Return-Path: <linux-raid+bounces-4013-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC4DA941A6
	for <lists+linux-raid@lfdr.de>; Sat, 19 Apr 2025 07:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F0817DA77
	for <lists+linux-raid@lfdr.de>; Sat, 19 Apr 2025 05:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A281632DF;
	Sat, 19 Apr 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="and5crRP"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-108-mta93.mxroute.com (mail-108-mta93.mxroute.com [136.175.108.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13832C85
	for <linux-raid@vger.kernel.org>; Sat, 19 Apr 2025 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745039335; cv=none; b=P95RG/JEIEatVoUXcyhukz3MrLBNh+AQ7xtuimB0SySqHBDlCvLgfS1kl5vt+R8qCM/1HqhZK7dlIqE8e1mlE3+DWRuhxGSB+f/B99Ee8PagRDOQrteELVv06u+YJ9cCTi24hVRXmzzZreruPTB77bxfslD4X88hIF+1Mvycp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745039335; c=relaxed/simple;
	bh=A3tNZDJcm4cvUZ1O6Z65DWR1sO9mHY36lteyQLaE/lA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n5zNB2rPPeWGgzc0TCaT5GW0V0SDzOwOsSxinOqFHsf0Nbd3D7E65gpY1QyNvM1IldkGpy/FQnLt1k0EEshu7hrdH7QdUrEwQm4Ys6rsJD3A4t1R8jSaOG3ZQxOlmdtq90WJQegQR+5ehKUzmvG0I3jOwoUEWHVy+lfGTZdhtgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=and5crRP; arc=none smtp.client-ip=136.175.108.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta93.mxroute.com (ZoneMTA) with ESMTPSA id 1964c6e573a0008631.013
 for <linux-raid@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 19 Apr 2025 05:03:41 +0000
X-Zone-Loop: 7813861a1a5f226ace26202782a34c73afa7b5fd9472
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=A3tNZDJcm4cvUZ1O6Z65DWR1sO9mHY36lteyQLaE/lA=; b=and5crRPKsy5
	ISMG2TLM1BCRd+KfGFvOKgdQj35qEkMIMLYn8f/7xD82uv4mrbO6wqPNgdBy9amGDHpdhaaHld1mb
	9Q3wAsgvJwhlq7pwBJ8appZxljHWs+ZsfOggU5iPkEoNe3G9JMgMyHYPNB0sGb2FwfFxepQQYQ1js
	zUe+mQsCWkjbdJD509ccLoi7RgwEUCk2JrvBcM+TiA3MQ4E3cxkt2g/cIYczo78o9ncn27ECtiEUp
	17bIs3JLmMf3+HKzDeRkvwIVNSLmBMCPodOaiGZpx+yuEcV7vBfwZ18pwpsH9LERDP2FieJBamo9a
	epx9MnVIPIGc1JXq6UeDQQ==;
From: Su Yue <l@damenly.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk,  xni@redhat.com,  agk@redhat.com,  snitzer@kernel.org,
  mpatocka@redhat.com,  song@kernel.org,  viro@zeniv.linux.org.uk,
  akpm@linux-foundation.org,  nadav.amit@gmail.com,  ubizjak@gmail.com,
  cl@linux.com,  linux-block@vger.kernel.org,
  linux-kernel@vger.kernel.org,  dm-devel@lists.linux.dev,
  linux-raid@vger.kernel.org,  yi.zhang@huawei.com,  yangerkun@huawei.com,
  johnny.chenyi@huawei.com,  "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 4/5] md: fix is_mddev_idle()
In-Reply-To: <e5ec218e-dcab-ff8c-f455-d8fc6943a6e7@huaweicloud.com> (Yu Kuai's
	message of "Sat, 19 Apr 2025 10:00:16 +0800")
References: <20250418010941.667138-1-yukuai1@huaweicloud.com>
	<20250418010941.667138-5-yukuai1@huaweicloud.com>
	<v7r19baz.fsf@damenly.org>
	<e5ec218e-dcab-ff8c-f455-d8fc6943a6e7@huaweicloud.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sat, 19 Apr 2025 13:03:16 +0800
Message-ID: <plh8agkr.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: l@damenly.org

On Sat 19 Apr 2025 at 10:00, Yu Kuai <yukuai1@huaweicloud.com>=20
wrote:

> Hi,
>
> =E5=9C=A8 2025/04/19 9:42, Su Yue =E5=86=99=E9=81=93:
>> On Fri 18 Apr 2025 at 09:09, Yu Kuai <yukuai1@huaweicloud.com>=20
>> wrote:
>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> If sync_speed is above speed_min, then is_mddev_idle() will be=20
>>> called
>>> for each sync IO to check if the array is idle, and inflihgt=20
>>> sync_io
>>> will be limited if the array is not idle.
>>>
>>> However, while mkfs.ext4 for a large raid5 array while=20
>>> recovery is in
>>> progress, it's found that sync_speed is already above=20
>>> speed_min while
>>> lots of stripes are used for sync IO, causing long delay for=20
>>> mkfs.ext4.
>>>
>>> Root cause is the following checking from is_mddev_idle():
>>>
>>> t1: submit sync IO: events1 =3D completed IO - issued sync IO
>>> t2: submit next sync IO: events2=C2=A0 =3D completed IO - issued sync=20
>>> IO
>>> if (events2 - events1 > 64)
>>>
>>> For consequence, the more sync IO issued, the less likely=20
>>> checking will
>>> pass. And when completed normal IO is more than issued sync=20
>>> IO, the
>>> condition will finally pass and is_mddev_idle() will return=20
>>> false,
>>> however, last_events will be updated hence is_mddev_idle() can=20
>>> only
>>> return false once in a while.
>>>
>>> Fix this problem by changing the checking as following:
>>>
>>> 1) mddev doesn't have normal IO completed;
>>> 2) mddev doesn't have normal IO inflight;
>>> 3) if any member disks is partition, and all other partitions=20
>>> doesn't
>>> =C2=A0=C2=A0 have IO completed.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>> =C2=A0drivers/md/md.c | 84=20
>>> =C2=A0+++++++++++++++++++++++++++----------------------
>>> =C2=A0drivers/md/md.h |=C2=A0 3 +-
>>> =C2=A02 files changed, 48 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 52cadfce7e8d..dfd85a5d6112 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -8625,50 +8625,58 @@ void md_cluster_stop(struct mddev=20
>>> *mddev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 put_cluster_ops(mddev);
>>> =C2=A0}
>>>
>>> -static int is_mddev_idle(struct mddev *mddev, int init)
>>> +static bool is_rdev_holder_idle(struct md_rdev *rdev, bool=20
>>> init)
>>> =C2=A0{
>>> +=C2=A0=C2=A0=C2=A0 unsigned long last_events =3D rdev->last_events;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!bdev_is_partition(rdev->bdev))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If rdev is partition, and user doesn't issu=
e IO to the=20
>>> array, the
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * array is still not idle if user issues IO t=
o other=20
>>> partitions.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 rdev->last_events =3D=20
>>> part_stat_read_accum(rdev->bdev->bd_disk->part0,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 sectors) -
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 part_stat_read_accum(rdev->bdev, sectors);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!init && rdev->last_events > last_events)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return true;
>>> +}
>>> +
>>> +/*
>>> + * mddev is idle if following conditions are match since last=20
>>> check:
>>> + * 1) mddev doesn't have normal IO completed;
>>> + * 2) mddev doesn't have inflight normal IO;
>>> + * 3) if any member disk is partition, and other partitions=20
>>> doesn't have IO
>>> + *=C2=A0=C2=A0=C2=A0 completed;
>>> + *
>>> + * Noted this checking rely on IO accounting is enabled.
>>> + */
>>> +static bool is_mddev_idle(struct mddev *mddev, int init)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned long last_events =3D mddev->last_events;
>>> +=C2=A0=C2=A0=C2=A0 struct gendisk *disk;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct md_rdev *rdev;
>>> -=C2=A0=C2=A0=C2=A0 int idle;
>>> -=C2=A0=C2=A0=C2=A0 int curr_events;
>>> +=C2=A0=C2=A0=C2=A0 bool idle =3D true;
>>>
>>> -=C2=A0=C2=A0=C2=A0 idle =3D 1;
>>> -=C2=A0=C2=A0=C2=A0 rcu_read_lock();
>>> -=C2=A0=C2=A0=C2=A0 rdev_for_each_rcu(rdev, mddev) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gendisk *disk =3D rd=
ev->bdev->bd_disk;
>>> +=C2=A0=C2=A0=C2=A0 disk =3D mddev_is_dm(mddev) ? mddev->dm_gendisk :=20
>>> mddev->gendisk;
>>> +=C2=A0=C2=A0=C2=A0 if (!disk)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!init && !blk_queue_io_=
stat(disk->queue))
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
>>> +=C2=A0=C2=A0=C2=A0 mddev->last_events =3D part_stat_read_accum(disk->p=
art0,=20
>>> sectors);
>>> +=C2=A0=C2=A0=C2=A0 if (!init && (mddev->last_events > last_events ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bdev_count_inflight(disk->part0)))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idle =3D false;
>>>
>> Forgot return or goto here?
>
> No, following still need to be executed to init or update
> rdev->last_events.k
>

Okay, I see. is_rdev_holder_idle does the work.

--
Su

> Thanks,
> Kuai
>
>> -- Su
>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 curr_events =3D (int)part_s=
tat_read_accum(disk->part0,=20
>>> sectors) -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&disk->sync_io);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* sync IO will cause sync_=
io to increase before the=20
>>> disk_stats
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as sync_io is count=
ed when a request starts, and
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * disk_stats is count=
ed when it completes.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * So resync activity =
will cause curr_events to be=20
>>> smaller than
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * when there was no s=
uch activity.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * non-sync IO will ca=
use disk_stat to increase=20
>>> without
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * increasing sync_io =
so curr_events will=20
>>> (eventually)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * be larger than it w=
as before.=C2=A0 Once it becomes
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * substantially large=
r, the test below will cause
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the array to appear=
 non-idle, and resync will slow
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * down.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If there is a lot o=
f outstanding resync activity=20
>>> when
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we set last_event t=
o curr_events, then all that=20
>>> activity
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * completing might ca=
use the array to appear=20
>>> non-idle
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and resync will be =
slowed down even though there=20
>>> might
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not have been non-r=
esync activity.=C2=A0 This will only
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * happen once though.=
=C2=A0 'last_events' will soon=20
>>> reflect
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the state where the=
re is little or no outstanding
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * resync requests, an=
d further resync activity will
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * always make curr_ev=
ents less than last_events.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (init || curr_events - r=
dev->last_events > 64) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rde=
v->last_events =3D curr_events;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idl=
e =3D 0;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 rcu_read_lock();
>>> +=C2=A0=C2=A0=C2=A0 rdev_for_each_rcu(rdev, mddev)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_rdev_holder_idle(rd=
ev, init))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idl=
e =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0 return idle;
>>> =C2=A0}
>>>
>>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>>> index b57842188f18..1d51c2405d3d 100644
>>> --- a/drivers/md/md.h
>>> +++ b/drivers/md/md.h
>>> @@ -132,7 +132,7 @@ struct md_rdev {
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 sector_t sectors;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* Device size (in 512bytes=20
>>> sectors) =C2=A0*/
>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct mddev *mddev;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* RAID array if running */
>>> -=C2=A0=C2=A0=C2=A0 int last_events;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* IO event timestamp */
>>> +=C2=A0=C2=A0=C2=A0 unsigned long last_events;=C2=A0=C2=A0=C2=A0 /* IO =
event timestamp */
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If meta_bdev is non-NULL, it means tha=
t a separate=20
>>> device =C2=A0is
>>> @@ -520,6 +520,7 @@ struct mddev {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * adding a spare
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>
>>> +=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_events;=C2=A0=C2=A0=C2=A0 /* IO event=20
>>> timestamp */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 atomic_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 recovery_active; /* blocks scheduled,=20
>>> but =C2=A0not
>>> written */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 wait_queue_head_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 recovery_wait;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 sector_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 recovery_cp;
>> .
>>

