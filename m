Return-Path: <linux-raid+bounces-1895-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0889062DA
	for <lists+linux-raid@lfdr.de>; Thu, 13 Jun 2024 05:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B142B21CAD
	for <lists+linux-raid@lfdr.de>; Thu, 13 Jun 2024 03:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69087131732;
	Thu, 13 Jun 2024 03:51:00 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD3130ACF
	for <linux-raid@vger.kernel.org>; Thu, 13 Jun 2024 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718250660; cv=none; b=V8jvwO7uVZ1Fe0OdKjbhvP9EIsXc3nm8c6x3AuJ64gc8WG4pRHMujDogSymQpwl7DhM1Tdxe0U4O3GC1wAiLTVx15+Vp60M0xGS9vJO41CHxQ+ujnwx+oDJ/t+iEUiWIZ/vXBFVvc6vvCCqgEMW8krQdxwv0/zlfTvNVVIi9aD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718250660; c=relaxed/simple;
	bh=CX0VQgc6x8qgjOzfr/Xi3oCY3N8hfmNkjJ86guHXysQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mxJwe6zNejsL3qD8xAgLM0ZuUcW69iVF8hlKh9R8m24X4HutoWloCDkkOQCQSSkTE6p6rY/E10UwIFtNsAyNaOTlHpGsYD9YFoccoMXIecJ4JaYYekBSF5qyNRJUZt5oQddabs1kua2WwwD9xqs6HRocAaTrPiciy1hDqgeVEb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W07jg2Jtbz4f3kK1
	for <linux-raid@vger.kernel.org>; Thu, 13 Jun 2024 11:50:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E55421A0C04
	for <linux-raid@vger.kernel.org>; Thu, 13 Jun 2024 11:50:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGcbGpmOqZaPQ--.63800S3;
	Thu, 13 Jun 2024 11:50:53 +0800 (CST)
Subject: Re: [PATCH v2] dm-raid: Fix WARN_ON_ONCE check for sync_thread in
 raid_resume
To: Benjamin Marzinski <bmarzins@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>
Cc: Heinz Mauelshagen <heinzm@redhat.com>, Xiao Ni <xni@redhat.com>,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 Yu Kuai <yukuai1@huaweicloud.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240612181222.877577-1-bmarzins@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b4bae533-d4cb-37ab-b24c-42375c256448@huaweicloud.com>
Date: Thu, 13 Jun 2024 11:50:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240612181222.877577-1-bmarzins@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGcbGpmOqZaPQ--.63800S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1fZF4rXw1DCryUJr1fZwb_yoW8Zw1rp3
	ykGas8Ar4DJr47Z39rJ3WDZa90vanFgrWjkrZxWa4rZ3WrGFsakryFkFyUXFWvkas3Aw1j
	ya13Ja1xuryUKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2024/06/13 2:12, Benjamin Marzinski д��:
> rm-raid devices will occasionally trigger the following warning when
dm-raid

> being resumed after a table load because DM_RECOVERY_RUNNING is set:
> 
> WARNING: CPU: 7 PID: 5660 at drivers/md/dm-raid.c:4105 raid_resume+0xee/0x100 [dm_raid]
> 
> The failing check is:
> WARN_ON_ONCE(test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
> 
> This check is designed to make sure that the sync thread isn't
> registered, but md_check_recovery can set MD_RECOVERY_RUNNING without
> the sync_thread ever getting registered. Instead of checking if
> MD_RECOVERY_RUNNING is set, check if sync_thread is non-NULL.
> 
> Fixes: 16c4770c75b1 ("dm-raid: really frozen sync_thread during suspend")
> Suggested-by: Yu Kuai <yukuai1@huaweicloud.com>
Please use the address yukuai3@huawei.com

> Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
> ---
> Changes in v2:
>   - Move mddev_lock_nointr() earlier to protect dereference and use
>     rcu_dereference_protected() to access sync_thread
> 
>   drivers/md/dm-raid.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index abe88d1e6735..b149ac46a990 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -4101,10 +4101,11 @@ static void raid_resume(struct dm_target *ti)
>   		if (mddev->delta_disks < 0)
>   			rs_set_capacity(rs);
>   
> +		mddev_lock_nointr(mddev);
>   		WARN_ON_ONCE(!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery));
> -		WARN_ON_ONCE(test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
> +		WARN_ON_ONCE(rcu_dereference_protected(mddev->sync_thread,
> +						       lockdep_is_held(&mddev->reconfig_mutex)));
>   		clear_bit(RT_FLAG_RS_FROZEN, &rs->runtime_flags);
> -		mddev_lock_nointr(mddev);

Other than the typo, LGTM

Suggested-and-reviewed-by: Yu Kuai <yukuai3@huawei.com>
>   		mddev->ro = 0;
>   		mddev->in_sync = 0;
>   		md_unfrozen_sync_thread(mddev);
> 


