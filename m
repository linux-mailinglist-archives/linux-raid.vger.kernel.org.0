Return-Path: <linux-raid+bounces-4926-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9408B2AD41
	for <lists+linux-raid@lfdr.de>; Mon, 18 Aug 2025 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492CE6260D3
	for <lists+linux-raid@lfdr.de>; Mon, 18 Aug 2025 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB6325DD1E;
	Mon, 18 Aug 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIGjp06h"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8D2522B1;
	Mon, 18 Aug 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531911; cv=none; b=fH9tWDqqgzwhtslBSx812mUJPNgtUGHaFlsdegz3wyCJwt2dJUBcwfg8SUGasE7TuWMm4oQ3w2vCs69bzWFt+HFDkZuYlQM0KOw0YQ/VBovQcmkS25iL3T4kGULSKdhRZ/dmQRPRt0bWYrK8GB9ZStuTkuzx/JGr/BlOzHX5Dhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531911; c=relaxed/simple;
	bh=6Wryc3PmrtxtoKADR+WUjeXXnn0GQyLwSoyz3sHAopY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9AAeJM4Ofu+vMRy7GsxmesxRSu1cW341tgK/eZzuAVuKia4KWVlVEr/6lRLoseja/0VujJm0CsEgGpuZgHtV2L+xnA18axhfFIF5r6PEvvy3v0UHy6fl1AxXW4J37h3Tyh3Sk+Tyz+FV6PvYkoHs/EoI1AuDkCC47rl2aYnVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIGjp06h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7BAC4CEEB;
	Mon, 18 Aug 2025 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755531911;
	bh=6Wryc3PmrtxtoKADR+WUjeXXnn0GQyLwSoyz3sHAopY=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MIGjp06hrMilOmTtSunNZ+HBbmwqNWva5Wd91dkWBO9bub6jraCJ44p2GiBck+476
	 E834MTE/2M7MCs48gnHaprZe2nXk8jvCt9s9xd3bVu+6jWMakBiiaakg5phmA5aSlw
	 QeqdsbuR2paDNPx478S6UN/7szeit+nFktZhJIhCaAGzwNU0X7ebs4kdm0SkY+4gUV
	 B7asqvInYFFVcwevNAJPZq2LLgf38KR9fL/3wuIB18WqwaFja0Rn4w4p7Sc48BsV1C
	 RysoElzItO5Rfjh9n0KIogqR+C9AbBMZ0DJ+v6sLWoGftSO3qSiOyPN9httvr9MA4u
	 T3vNbP+CtdSGA==
Message-ID: <e8320a2a-06f8-47b9-88ef-6c4764d96714@kernel.org>
Date: Mon, 18 Aug 2025 23:45:10 +0800
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH v2 1/3] md/raid1,raid10: don't broken array on failfast
 metadata write fails
To: Kenta Akagi <k@mgml.me>, Yu Kuai <yukuai1@huaweicloud.com>,
 Song Liu <song@kernel.org>, Mariusz Tkaczyk <mtkaczyk@kernel.org>,
 Guoqing Jiang <jgq516@gmail.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250817172710.4892-1-k@mgml.me>
 <20250817172710.4892-2-k@mgml.me>
 <51efe62a-6190-1fd5-7f7b-b17c3d1af54b@huaweicloud.com>
 <fb752529-6802-4ef9-aeb3-9b04ba86ef5f@huaweicloud.com>
 <0164bc8e-129c-41fa-b236-9efc1b01f7b9@mgml.me>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <0164bc8e-129c-41fa-b236-9efc1b01f7b9@mgml.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/8/18 20:48, Kenta Akagi 写道:
> On 2025/08/18 11:48, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/18 10:05, Yu Kuai 写道:
>>> Hi,
>>>
>>> 在 2025/08/18 1:27, Kenta Akagi 写道:
>>>> A super_write IO failure with MD_FAILFAST must not cause the array
>>>> to fail.
>>>>
>>>> Because a failfast bio may fail even when the rdev is not broken,
>>>> so IO must be retried rather than failing the array when a metadata
>>>> write with MD_FAILFAST fails on the last rdev.
>>> Why just last rdev? If failfast can fail when the rdev is not broken, I
>>> feel we should retry for all the rdev.
> Thank you for reviewing.
>
> The reason this retry applies only to the last rdev is that the purpose
> of failfast is to quickly detach a faulty device and thereby minimize
> mdev IO latency on rdev failure.
> If md retries all rdevs, the Faulty handler will no longer act
> quickly enough, which will always "cause long delays" [1].
> I believe this is not the behavior users want.
>
> [1] https://git.kernel.org/pub/scm/utils/mdadm/mdadm.git/tree/mdadm.8.in?h=main&id=34f21b7acea8afbea9348d0f421beeeedca7a136#n784
>
>> BTW, I couldn't figure out the reason, why failfast is added for the
>> meta write. I do feel just remove this flag for metadata write will fix
>> this problem.
> By issuing metadata writes with failfast in md, it becomes possible to
> detect rdev failures quickly.
> Most applications never issue IO with the REQ_FAILFAST flag set,
> so if md issues its metadata writes without failfast,
> rdev failures would not be detected quickly.
> This would undermine the point of the md's failfast feature.
> And this would also "cause long delays" [1].
> I believe this is also not what users want.

Yes, this make sense. But I was thinking failfast will work on normal IO,
not metadata IO like updating superblock, which doesn't happen quite often
for user. But consider we have this behavior for such a long time, I agree
we'd better not change it.

>> Thanks,
>> Kuai
>>
>>>> A metadata write with MD_FAILFAST is retried after failure as
>>>> follows:
>>>>
>>>> 1. In super_written, MD_SB_NEED_REWRITE is set in sb_flags.
>>>>
>>>> 2. In md_super_wait, which is called by the function that
>>>> executed md_super_write and waits for completion,
>>>> -EAGAIN is returned because MD_SB_NEED_REWRITE is set.
>>>>
>>>> 3. The caller of md_super_wait (such as md_update_sb)
>>>> receives a negative return value and then retries md_super_write.
>>>>
>>>> 4. The md_super_write function, which is called to perform
>>>> the same metadata write, issues a write bio without MD_FAILFAST
>>>> this time.
>>>>
>>>> When a write from super_written without MD_FAILFAST fails,
>>>> the array may broken, and MD_BROKEN should be set.
>>>>
>>>> After commit 9631abdbf406 ("md: Set MD_BROKEN for RAID1 and RAID10"),
>>>> calling md_error on the last rdev in RAID1/10 always sets
>>>> the MD_BROKEN flag on the array.
>>>> As a result, when failfast IO fails on the last rdev, the array
>>>> immediately becomes failed.
>>>>
>>>> This commit prevents MD_BROKEN from being set when a super_write with
>>>> MD_FAILFAST fails on the last rdev, ensuring that the array does
>>>> not become failed due to failfast IO failures.
>>>>
>>>> Failfast IO failures on any rdev except the last one are not retried
>>>> and are marked as Faulty immediately. This minimizes array IO latency
>>>> when an rdev fails.
>>>>
>>>> Fixes: 9631abdbf406 ("md: Set MD_BROKEN for RAID1 and RAID10")
>>>> Signed-off-by: Kenta Akagi <k@mgml.me>
>>>> ---
>>>>    drivers/md/md.c     |  9 ++++++---
>>>>    drivers/md/md.h     |  7 ++++---
>>>>    drivers/md/raid1.c  | 12 ++++++++++--
>>>>    drivers/md/raid10.c | 12 ++++++++++--
>>>>    4 files changed, 30 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>>> index ac85ec73a409..61a8188849a3 100644
>>>> --- a/drivers/md/md.c
>>>> +++ b/drivers/md/md.c
>>>> @@ -999,14 +999,17 @@ static void super_written(struct bio *bio)
>>>>        if (bio->bi_status) {
>>>>            pr_err("md: %s gets error=%d\n", __func__,
>>>>                   blk_status_to_errno(bio->bi_status));
>>>> +        if (bio->bi_opf & MD_FAILFAST)
>>>> +            set_bit(FailfastIOFailure, &rdev->flags);
>>> I think it's better to retry the bio with the flag cleared, then all
>>> underlying procedures can stay the same.
> That might be a better approach. I'll check the call hierarchy and lock dependencies.

You might need to add a new async work to resubmit this bio.

Thanks,
Kuai

> Thanks,
> Akagi
>
>
>>> Thanks,
>>> Kuai
>>>
>>>>            md_error(mddev, rdev);
>>>>            if (!test_bit(Faulty, &rdev->flags)
>>>>                && (bio->bi_opf & MD_FAILFAST)) {
>>>> +            pr_warn("md: %s: Metadata write will be repeated to %pg\n",
>>>> +                mdname(mddev), rdev->bdev);
>>>>                set_bit(MD_SB_NEED_REWRITE, &mddev->sb_flags);
>>>> -            set_bit(LastDev, &rdev->flags);
>>>>            }
>>>>        } else
>>>> -        clear_bit(LastDev, &rdev->flags);
>>>> +        clear_bit(FailfastIOFailure, &rdev->flags);
>>>>        bio_put(bio);
>>>> @@ -1048,7 +1051,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
>>>>        if (test_bit(MD_FAILFAST_SUPPORTED, &mddev->flags) &&
>>>>            test_bit(FailFast, &rdev->flags) &&
>>>> -        !test_bit(LastDev, &rdev->flags))
>>>> +        !test_bit(FailfastIOFailure, &rdev->flags))
>>>>            bio->bi_opf |= MD_FAILFAST;
>>>>        atomic_inc(&mddev->pending_writes);
>>>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>>>> index 51af29a03079..cf989aca72ad 100644
>>>> --- a/drivers/md/md.h
>>>> +++ b/drivers/md/md.h
>>>> @@ -281,9 +281,10 @@ enum flag_bits {
>>>>                     * It is expects that no bad block log
>>>>                     * is present.
>>>>                     */
>>>> -    LastDev,        /* Seems to be the last working dev as
>>>> -                 * it didn't fail, so don't use FailFast
>>>> -                 * any more for metadata
>>>> +    FailfastIOFailure,    /* A device that failled a metadata write
>>>> +                 * with failfast.
>>>> +                 * error_handler must not fail the array
>>>> +                 * if last device has this flag.
>>>>                     */
>>>>        CollisionCheck,        /*
>>>>                     * check if there is collision between raid1
>>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>>> index 408c26398321..fc7195e58f80 100644
>>>> --- a/drivers/md/raid1.c
>>>> +++ b/drivers/md/raid1.c
>>>> @@ -1746,8 +1746,12 @@ static void raid1_status(struct seq_file *seq, struct mddev *mddev)
>>>>     *    - recovery is interrupted.
>>>>     *    - &mddev->degraded is bumped.
>>>>     *
>>>> - * @rdev is marked as &Faulty excluding case when array is failed and
>>>> - * &mddev->fail_last_dev is off.
>>>> + * If @rdev is marked with &FailfastIOFailure, it means that super_write
>>>> + * failed in failfast and will be retried, so the @mddev did not fail.
>>>> + *
>>>> + * @rdev is marked as &Faulty excluding any cases:
>>>> + *    - when @mddev is failed and &mddev->fail_last_dev is off
>>>> + *    - when @rdev is last device and &FailfastIOFailure flag is set
>>>>     */
>>>>    static void raid1_error(struct mddev *mddev, struct md_rdev *rdev)
>>>>    {
>>>> @@ -1758,6 +1762,10 @@ static void raid1_error(struct mddev *mddev, struct md_rdev *rdev)
>>>>        if (test_bit(In_sync, &rdev->flags) &&
>>>>            (conf->raid_disks - mddev->degraded) == 1) {
>>>> +        if (test_bit(FailfastIOFailure, &rdev->flags)) {
>>>> +            spin_unlock_irqrestore(&conf->device_lock, flags);
>>>> +            return;
>>>> +        }
>>>>            set_bit(MD_BROKEN, &mddev->flags);
>>>>            if (!mddev->fail_last_dev) {
>>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>>>> index b60c30bfb6c7..ff105a0dcd05 100644
>>>> --- a/drivers/md/raid10.c
>>>> +++ b/drivers/md/raid10.c
>>>> @@ -1995,8 +1995,12 @@ static int enough(struct r10conf *conf, int ignore)
>>>>     *    - recovery is interrupted.
>>>>     *    - &mddev->degraded is bumped.
>>>>     *
>>>> - * @rdev is marked as &Faulty excluding case when array is failed and
>>>> - * &mddev->fail_last_dev is off.
>>>> + * If @rdev is marked with &FailfastIOFailure, it means that super_write
>>>> + * failed in failfast, so the @mddev did not fail.
>>>> + *
>>>> + * @rdev is marked as &Faulty excluding any cases:
>>>> + *    - when @mddev is failed and &mddev->fail_last_dev is off
>>>> + *    - when @rdev is last device and &FailfastIOFailure flag is set
>>>>     */
>>>>    static void raid10_error(struct mddev *mddev, struct md_rdev *rdev)
>>>>    {
>>>> @@ -2006,6 +2010,10 @@ static void raid10_error(struct mddev *mddev, struct md_rdev *rdev)
>>>>        spin_lock_irqsave(&conf->device_lock, flags);
>>>>        if (test_bit(In_sync, &rdev->flags) && !enough(conf, rdev->raid_disk)) {
>>>> +        if (test_bit(FailfastIOFailure, &rdev->flags)) {
>>>> +            spin_unlock_irqrestore(&conf->device_lock, flags);
>>>> +            return;
>>>> +        }
>>>>            set_bit(MD_BROKEN, &mddev->flags);
>>>>            if (!mddev->fail_last_dev) {
>>>>
>>> .
>>>
>>
>

