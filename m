Return-Path: <linux-raid+bounces-3699-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE58CA3E41E
	for <lists+linux-raid@lfdr.de>; Thu, 20 Feb 2025 19:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8C23B618D
	for <lists+linux-raid@lfdr.de>; Thu, 20 Feb 2025 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1124BD0C;
	Thu, 20 Feb 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="mmVao0ba"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D8F24BCF5;
	Thu, 20 Feb 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076932; cv=none; b=tZtddSJeLu2u0sswXIVI7ML6004+kxJZJMVtWlrAAcx8DOjk3nU0d8OA07esz4Y1oAR/Rf/CUCw4yex+uC9q82gnafS+7WmMokfwtiNQUAkNOIvXLbGxsriIofYeSEsM1i7RUwEumSnHbmbPKHmkyY/9wXysOGuMeoo0OG7Z7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076932; c=relaxed/simple;
	bh=wtnnZPkOf7BrsKB8Z/mdzevF6TxC5hF2ePYSpdm6h0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4js7nZo5PoWJ5eGxFdQB5m6dhiTU9QGUC3Mf0/FgVBwsl8zhNZu+ZWWp1t6ir4sjGY7eNs9+L+KuoDRUDcNysnUmUe80+AA6S1QNHBP2a1upGx6huuGxeel/zIvrU6SQ0GMD4nl87kIe0SCsWDwFhOjkTld7ICTbHViowyHIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=mmVao0ba; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id AAB4A2003EF;
	Thu, 20 Feb 2025 19:41:50 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=mmVao0ba;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uLVen2E3RvhESJ8F8MBdYo2bGGGeVIqkqKDEqDdgtGQ=; b=mmVao0baO+xoUcVvp5rDnrVvkF
	dQwWxlr39sUrAt4F7QoJNAku6XY+MjjSGy45QStx1pNW+VkBR54NCpA+pauZ9aWqKFHWZaMURyYnd
	XMgCaluaqWdCvVpF+lFbo0aj8ID7T1BKCgZwk5Hkuhl7yGrT/LThiZsV6TbJ0PV1jD3E=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tlBUb-000f4t-2f;
	Thu, 20 Feb 2025 19:41:49 +0100
Date: Thu, 20 Feb 2025 19:41:49 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, yukuai3@huawei.com, hare@suse.de, axboe@kernel.dk,
	logang@deltatee.com, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, hch@lst.de, guillaume@morinfr.org
Subject: Re: [PATCH v3] md: fix mddev uaf while iterating all_mddevs list
Message-ID: <Z7d3bY2EoScBIk4k@bender.morinfr.org>
References: <20250220124348.845222-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220124348.845222-1-yukuai1@huaweicloud.com>

On 20 Feb 20:43, Yu Kuai wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
> 
> While iterating all_mddevs list from md_notify_reboot() and md_exit(),
> list_for_each_entry_safe is used, and this can race with deletint the
> next mddev, causing UAF:
> 
> t1:
> spin_lock
> //list_for_each_entry_safe(mddev, n, ...)
>  mddev_get(mddev1)
>  // assume mddev2 is the next entry
>  spin_unlock
>             t2:
>             //remove mddev2
>             ...
>             mddev_free
>             spin_lock
>             list_del
>             spin_unlock
>             kfree(mddev2)
>  mddev_put(mddev1)
>  spin_lock
>  //continue dereference mddev2->all_mddevs
> 
> The old helper for_each_mddev() actually grab the reference of mddev2
> while holding the lock, to prevent from being freed. This problem can be
> fixed the same way, however, the code will be complex.
> 
> Hence switch to use list_for_each_entry, in this case mddev_put() can free
> the mddev1 and it's not safe as well. Refer to md_seq_show(), also factor
> out a helper mddev_put_locked() to fix this problem.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: f26514342255 ("md: stop using for_each_mddev in md_notify_reboot")
> Fixes: 16648bac862f ("md: stop using for_each_mddev in md_exit")
> Reported-by: Guillaume Morin <guillaume@morinfr.org>
> Closes: https://lore.kernel.org/all/Z7Y0SURoA8xwg7vn@bender.morinfr.org/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 827646b3eb59..f501bc5f68f1 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -629,6 +629,12 @@ static void __mddev_put(struct mddev *mddev)
>  	queue_work(md_misc_wq, &mddev->del_work);
>  }
>  
> +static void mddev_put_locked(struct mddev *mddev)
> +{
> +	if (atomic_dec_and_test(&mddev->active))
> +		__mddev_put(mddev);
> +}
> +
>  void mddev_put(struct mddev *mddev)
>  {
>  	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
> @@ -8461,9 +8467,7 @@ static int md_seq_show(struct seq_file *seq, void *v)
>  	if (mddev == list_last_entry(&all_mddevs, struct mddev, all_mddevs))
>  		status_unused(seq);
>  
> -	if (atomic_dec_and_test(&mddev->active))
> -		__mddev_put(mddev);
> -
> +	mddev_put_locked(mddev);
>  	return 0;
>  }
>  
> @@ -9895,11 +9899,11 @@ EXPORT_SYMBOL_GPL(rdev_clear_badblocks);
>  static int md_notify_reboot(struct notifier_block *this,
>  			    unsigned long code, void *x)
>  {
> -	struct mddev *mddev, *n;
> +	struct mddev *mddev;
>  	int need_delay = 0;
>  
>  	spin_lock(&all_mddevs_lock);
> -	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
> +	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
>  		if (!mddev_get(mddev))
>  			continue;
>  		spin_unlock(&all_mddevs_lock);
> @@ -9911,8 +9915,8 @@ static int md_notify_reboot(struct notifier_block *this,
>  			mddev_unlock(mddev);
>  		}
>  		need_delay = 1;
> -		mddev_put(mddev);
>  		spin_lock(&all_mddevs_lock);
> +		mddev_put_locked(mddev);
>  	}
>  	spin_unlock(&all_mddevs_lock);
>  
> @@ -10245,7 +10249,7 @@ void md_autostart_arrays(int part)
>  
>  static __exit void md_exit(void)
>  {
> -	struct mddev *mddev, *n;
> +	struct mddev *mddev;
>  	int delay = 1;
>  
>  	unregister_blkdev(MD_MAJOR,"md");
> @@ -10266,7 +10270,7 @@ static __exit void md_exit(void)
>  	remove_proc_entry("mdstat", NULL);
>  
>  	spin_lock(&all_mddevs_lock);
> -	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
> +	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
>  		if (!mddev_get(mddev))
>  			continue;
>  		spin_unlock(&all_mddevs_lock);
> @@ -10278,8 +10282,8 @@ static __exit void md_exit(void)
>  		 * the mddev for destruction by a workqueue, and the
>  		 * destroy_workqueue() below will wait for that to complete.
>  		 */
> -		mddev_put(mddev);
>  		spin_lock(&all_mddevs_lock);
> +		mddev_put_locked(mddev);
>  	}
>  	spin_unlock(&all_mddevs_lock);
>  
> -- 
> 2.39.2
> 

I confirm that this patch fixes our reproducer for the GPF

Thanks

Tested-by: Guillaume Morin <guillaume@morinfr.org>

-- 
Guillaume Morin <guillaume@morinfr.org>

