Return-Path: <linux-raid+bounces-788-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7F860968
	for <lists+linux-raid@lfdr.de>; Fri, 23 Feb 2024 04:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109891C2392E
	for <lists+linux-raid@lfdr.de>; Fri, 23 Feb 2024 03:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7125BE7D;
	Fri, 23 Feb 2024 03:32:07 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9039DDA6
	for <linux-raid@vger.kernel.org>; Fri, 23 Feb 2024 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659127; cv=none; b=BibRfPAZlTjHGkz1QEoZs5LorxSvCN2rpbBTmzNBnqOR+mkjcP/oJBYsNn6VvMYHQ6I53TEiou8IVp+kgQpNaDs0qqP9C+IHeZAdbn1lsJJavkwrrSBC/2hXU8BgkUsJu2i6509o1zdzpDqbFSFSvGxHKTXg+d3KA0nIumcswrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659127; c=relaxed/simple;
	bh=8bngH+W00phtjkhDMFDHQoDFzTsw7rnlEbHvv7TU5KU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kNnx+YeJsBgKNalsEBa8/kbdVS4oYYct8yn3a2QzWKHTE0tRlD5Uxv8NmMhiqEx+rtKJejBp34MDp9VGRsi5K1BTKWAYHkOpdQckXncN1Y4ZaaPQZOwnqKQ1hmFUU8rmq2U19OMLUAp3W6R2kAjVSU6yoo+XPfOVgi72WEKurh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgwY963kjz4f3kph
	for <linux-raid@vger.kernel.org>; Fri, 23 Feb 2024 11:31:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 181651A016E
	for <linux-raid@vger.kernel.org>; Fri, 23 Feb 2024 11:32:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBGrEdhl6uV3Ew--.38675S3;
	Fri, 23 Feb 2024 11:31:57 +0800 (CST)
Subject: Re: [PATCH RFC 1/4] dm-raid/md: Clear MD_RECOVERY_WAIT when stopping
 dmraid
To: Xiao Ni <xni@redhat.com>, song@kernel.org
Cc: yukuai1@huaweicloud.com, bmarzins@redhat.com, heinzm@redhat.com,
 snitzer@kernel.org, ncroxon@redhat.com, neilb@suse.de,
 linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240220153059.11233-1-xni@redhat.com>
 <20240220153059.11233-2-xni@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aa0859d5-6e1c-76f0-284d-9d1c21497f28@huaweicloud.com>
Date: Fri, 23 Feb 2024 11:31:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240220153059.11233-2-xni@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBGrEdhl6uV3Ew--.38675S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUAry8Xr4rGr4rXr1DWrg_yoW5urW5pa
	yUXFy5Zr4UArWjvF9rAa1qqa4Fq3WYqFW5Cry3C34rA3Z0k3WfuFWUKFyUXFWDuFyfJF47
	Aan8Ja9xZFZakrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2024/02/20 23:30, Xiao Ni д��:
> MD_RECOVERY_WAIT is used by dmraid to delay reshape process by patch
> commit 644e2537fdc7 ("dm raid: fix stripe adding reshape deadlock").
> Before patch commit f52f5c71f3d4b ("md: fix stopping sync thread")
> dmraid stopped sync thread directy by calling md_reap_sync_thread.
> After this patch dmraid stops sync thread asynchronously as md does.
> This is right. Now the dmraid stop process is like this:
> 
> 1. raid_postsuspend->md_stop_writes->__md_stop_writes->stop_sync_thread.
> stop_sync_thread sets MD_RECOVERY_INTR and wait until MD_RECOVERY_RUNNING
> is cleared
> 2. md_do_sync finds MD_RECOVERY_WAIT is set and return. (This is the
> root cause for this deadlock. We hope md_do_sync can set MD_RECOVERY_DONE)
> 3. md thread calls md_check_recovery (This is the place to reap sync
> thread. Because MD_RECOVERY_DONE is not set. md thread can't reap sync
> thread)
> 4. raid_dtr stops/free struct mddev and release dmraid related resources
> 
> dmraid only sets MD_RECOVERY_WAIT but doesn't clear it. It needs to clear
> this bit when stopping the dmraid before stopping sync thread.
> 
> But the deadlock still can happen sometimes even MD_RECOVERY_WAIT is
> cleared before stopping sync thread. It's the reason stop_sync_thread only
> wakes up task. If the task isn't running, it still needs to wake up sync
> thread too.
> 
> This deadlock can be reproduced 100% by these commands:
> modprobe brd rd_size=34816 rd_nr=5
> while [ 1 ]; do
> vgcreate test_vg /dev/ram*
> lvcreate --type raid5 -L 16M -n test_lv test_vg
> lvconvert -y --stripes 4 /dev/test_vg/test_lv
> vgremove test_vg -ff
> sleep 1
> done
> 
> Fixes: 644e2537fdc7 ("dm raid: fix stripe adding reshape deadlock")
> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
> Signed-off-by: Xiao Ni <xni@redhat.com>

I'm not sure about this change, I think MD_RECOVERY_WAIT is hacky and
really breaks how sync_thread is working, it should just go away soon,
once we make sure sync_thread can't be registered before pers->start()
is done.

Thanks,
Kuai
> ---
>   drivers/md/dm-raid.c | 2 ++
>   drivers/md/md.c      | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index eb009d6bb03a..325767c1140f 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3796,6 +3796,8 @@ static void raid_postsuspend(struct dm_target *ti)
>   	struct raid_set *rs = ti->private;
>   
>   	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
> +		if (test_bit(MD_RECOVERY_WAIT, &rs->md.recovery))
> +			clear_bit(MD_RECOVERY_WAIT, &rs->md.recovery);
>   		/* Writes have to be stopped before suspending to avoid deadlocks. */
>   		if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
>   			md_stop_writes(&rs->md);
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 2266358d8074..54790261254d 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4904,6 +4904,7 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
>   	 * never happen
>   	 */
>   	md_wakeup_thread_directly(mddev->sync_thread);
> +	md_wakeup_thread(mddev->sync_thread);
>   	if (work_pending(&mddev->sync_work))
>   		flush_work(&mddev->sync_work);
>   
> 


