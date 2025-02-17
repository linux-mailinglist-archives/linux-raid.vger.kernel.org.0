Return-Path: <linux-raid+bounces-3634-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EDEA35524
	for <lists+linux-raid@lfdr.de>; Fri, 14 Feb 2025 04:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D599816A17B
	for <lists+linux-raid@lfdr.de>; Fri, 14 Feb 2025 03:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664A5151984;
	Fri, 14 Feb 2025 03:01:40 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF3126C1E;
	Fri, 14 Feb 2025 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502100; cv=none; b=LIjPupKDWg9PEJ86hM98lLt5ebykHHBiDp0hyUEmwJWnXWMrIBiSkuHDJGoZVvGEaX630mSIC7uFjkq4ayNimEf/JKGrBF26zj85yD7eRu2DqCBhq4X7KmkQuEa7QPX8CRwCYi1uauHR7iB42NUhTdDM+BJj6B5E5me3oJfMeEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502100; c=relaxed/simple;
	bh=15IRzAhxRAQrT8Dl0CxkcNAaO8CmkIYwIa3eHZ10E7w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MPsXf7rQk3aGRUJCDY0R+adIj39C0fhvLRNzn+IaQMw84Xc/lRf2+I5JpOtgXlCYI60QwO7Km2fxUrdFHH3ifHPJpEhKpSxyEaJrOKdeRq6JlRnRVqlx1WiB6d6SZCH4O/YlXVy376LOA/GOAYD+uq1BU2WRPYeTbn+M4Gthbxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YvGz00K9Wz4f3jqr;
	Fri, 14 Feb 2025 11:01:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 292C01A14C4;
	Fri, 14 Feb 2025 11:01:32 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ysQKsq5nzY3yDg--.17850S3;
	Fri, 14 Feb 2025 11:01:31 +0800 (CST)
Subject: Re: [PATCH v3 md-6.15 11/11] md/md-bitmap: introducet
 CONFIG_MD_BITMAP
To: Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com
Cc: linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250123020730.2003602-1-yukuai1@huaweicloud.com>
 <20250123020730.2003602-12-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4e113774-e74f-874f-0e80-256c7bf1b508@huaweicloud.com>
Date: Fri, 14 Feb 2025 11:01:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250123020730.2003602-12-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3ysQKsq5nzY3yDg--.17850S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7tFWkJF4DJr1xGFWruFg_yoW8uw43pF
	4UG34fCrW5XF4jga1UJFWUCFySkwn2grZrArWrGwnakF9rX3sxXa1kWFWjvwn5GrWfJFsx
	Zr4rKr4Duw4DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2025/01/23 10:07, Yu Kuai д��:
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 264756a54f59..9451cc5cc574 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -83,6 +83,9 @@ static const char *action_name[NR_SYNC_ACTIONS] = {
>   static LIST_HEAD(pers_list);
>   static DEFINE_SPINLOCK(pers_lock);
>   
> +static LIST_HEAD(bitmap_list);
> +static DEFINE_SPINLOCK(bitmap_lock);
> +
>   static const struct kobj_type md_ktype;
>   
>   const struct md_cluster_operations *md_cluster_ops;
> @@ -100,7 +103,6 @@ static struct workqueue_struct *md_wq;
>    * workqueue whith reconfig_mutex grabbed.
>    */
>   static struct workqueue_struct *md_misc_wq;
> -struct workqueue_struct *md_bitmap_wq;
>   
>   static int remove_and_add_spares(struct mddev *mddev,
>   				 struct md_rdev *this);
> @@ -650,15 +652,73 @@ static void active_io_release(struct percpu_ref *ref)
>   
>   static void no_op(struct percpu_ref *r) {}
>   
> +void register_md_bitmap(struct bitmap_operations *op)
> +{
> +	pr_info("md: bitmap version %d registered\n", op->version);
> +
> +	spin_lock(&bitmap_lock);
> +	list_add_tail(&op->list, &bitmap_list);
> +	spin_unlock(&bitmap_lock);
> +}
> +
> +void unregister_md_bitmap(struct bitmap_operations *op)
> +{
> +	pr_info("md: bitmap version %d unregistered\n", op->version);
> +
> +	spin_lock(&bitmap_lock);
> +	list_del_init(&op->list);
> +	spin_unlock(&bitmap_lock);
> +}
> +
> +static struct bitmap_operations *find_bitmap(int version)
> +{
> +	struct bitmap_operations *op = NULL;
> +	struct bitmap_operations *tmp;
> +
> +	spin_lock(&bitmap_lock);
> +	list_for_each_entry(tmp, &bitmap_list, list) {
> +		if (tmp->version == version) {
> +			op = tmp;
> +			break;
> +		}
> +	}
> +	spin_unlock(&bitmap_lock);
> +
> +	return op;
> +}

Noted that, we already have pers_lock and pers_list for personalities,
md_cluster_ops and md_cluster_mod for md-cluster. Now, add bitmap_lock
and bitmap_list is a bit ugly.

I decided to refactor this a bit, by adding a new struct
md_submodule_head and unify all sub modules registeration,
unregisteration and lookup. Will send a set soon :)

Thanks,
Kuai


