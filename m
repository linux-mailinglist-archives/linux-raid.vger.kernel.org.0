Return-Path: <linux-raid+bounces-378-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F228310E6
	for <lists+linux-raid@lfdr.de>; Thu, 18 Jan 2024 02:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A713A284E4E
	for <lists+linux-raid@lfdr.de>; Thu, 18 Jan 2024 01:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4A6187E;
	Thu, 18 Jan 2024 01:32:30 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216B6184C
	for <linux-raid@vger.kernel.org>; Thu, 18 Jan 2024 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541550; cv=none; b=uc7bJ/0kmPnIhTk/adEmI756VdxTmOBkMwrBo/pCfc9SarqAhu2n+XW3zsxBIZc5MJOvNgbRwfnSHBW0XhlFEFU6SXMcD4th3H41JVlYn4Tnpf1jalZqA6DiQ9/6FG5jx9Hys+7ipmPCghaNCdBQ6KX5ov+5QGml92pyLTx9ewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541550; c=relaxed/simple;
	bh=XoiCJHBOSPiOKatH4br5vOuWzaGeNzp/ZgcQNueh54M=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=SvVZ430KeNYtV6WdQhFrAn+c9P62fKBHyKLNC21SOGAHsRc1TedV3Rp4ywmCTL4uO0Th8cJ0udCLZkyxNmg/TfmxaYRovaGZAz9v0HoF1LttUktZgAQcXWCHQWgXuIre7hpU08DWDF3PrKoMUruCMBPvrdCqOOySWw9frDvn+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFlbp3dsQz4f3k69
	for <linux-raid@vger.kernel.org>; Thu, 18 Jan 2024 09:32:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A93EE1A0172
	for <linux-raid@vger.kernel.org>; Thu, 18 Jan 2024 09:32:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g6nf6hlQy2sBA--.60921S3;
	Thu, 18 Jan 2024 09:32:24 +0800 (CST)
Subject: Re: [PATCH 2/7] md: fix a race condition when stopping the sync
 thread
To: Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 David Jeffery <djeffery@redhat.com>, Li Nan <linan122@huawei.com>
Cc: dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 Mike Snitzer <msnitzer@redhat.com>, Heinz Mauelshagen <heinzm@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com>
 <8fb335e-6d2c-dbb5-d7-ded8db5145a@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dcf29bba-4762-84ad-f60e-3607cf6779f9@huaweicloud.com>
Date: Thu, 18 Jan 2024 09:32:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8fb335e-6d2c-dbb5-d7-ded8db5145a@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g6nf6hlQy2sBA--.60921S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar43Kr1xur1rXry3Gw4kJFb_yoW8Aw1Upa
	ykJryftr4Fyryj9ryDX3WDCFyrZr1UtrW7tryxCw4fZw1jgw45JFyj9Fy5ZFykCF93Ar4U
	XF4rtF45A3WDK3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbPEf5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2024/01/18 2:18, Mikulas Patocka д��:
> Note that md_wakeup_thread_directly is racy - it will do nothing if the
> thread is already running or it may cause spurious wake-up if the thread
> is blocked in another subsystem.

No, as the comment said, md_wakeup_thread_directly() is just to prevent
that md_wakeup_thread() can't wake up md_do_sync() if it's waiting for
metadata update.
> 
> In order to eliminate the race condition, we will retry
> md_wakeup_thread_directly after 0.1 seconds.

And what you changed is not md_wakeup_thread_directly() at all.

Thanks,
Kuai

> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org	# v6.7
> Fixes: 130443d60b1b ("md: refactor idle/frozen_sync_thread() to fix deadlock")
> 
> ---
>   drivers/md/md.c |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/md/md.c
> ===================================================================
> --- linux-2.6.orig/drivers/md/md.c
> +++ linux-2.6/drivers/md/md.c
> @@ -4889,6 +4889,7 @@ static void stop_sync_thread(struct mdde
>   
>   	mddev_unlock(mddev);
>   
> +retry:
>   	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>   	/*
>   	 * Thread might be blocked waiting for metadata update which will now
> @@ -4898,9 +4899,11 @@ static void stop_sync_thread(struct mdde
>   	if (work_pending(&mddev->sync_work))
>   		flush_work(&mddev->sync_work);
>   
> -	wait_event(resync_wait,
> +	if (!wait_event_timeout(resync_wait,
>   		   !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
> -		   (check_seq && sync_seq != atomic_read(&mddev->sync_seq)));
> +		   (check_seq && sync_seq != atomic_read(&mddev->sync_seq)),
> +		   HZ / 10))
> +		goto retry;
>   
>   	if (locked)
>   		mddev_lock_nointr(mddev);
> 
> .
> 


