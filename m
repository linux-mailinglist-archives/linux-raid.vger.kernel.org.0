Return-Path: <linux-raid+bounces-4779-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8632B17B0E
	for <lists+linux-raid@lfdr.de>; Fri,  1 Aug 2025 04:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C27F3AF577
	for <lists+linux-raid@lfdr.de>; Fri,  1 Aug 2025 02:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01D376;
	Fri,  1 Aug 2025 02:00:49 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B09224D6;
	Fri,  1 Aug 2025 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754013649; cv=none; b=lfL63NMX/MVdH8hh7lU8K48DZ3lLDCXZDPhby9WEQFxwY/AgpCublkQnBmojxbUEQsrsin3rV5Uv7lJ7yBm96XjXrLYp1VqQKJ+MWScL2iW6+PvFl8WDmi9pC/DG1ySl0DuzqydL20C0bDG4X6Lh3647hQNtDsltWeYyjfjKiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754013649; c=relaxed/simple;
	bh=uUgBHxk1XWPT9uqTiGzegsSuOWtCEXVRytWcBEnLKxo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DxEfhcPfZe05uOpAbroz7kgogpFqNkMZWsmlfXOTrCj6FdAQgCHPU8xUJg/Rgma5HO1+3Jvxdsi55aXrExgSsDInj2gl9KhQO98A+cfXBdXjERDhwcarKf1HnIcUMQWZYg/CqZUjodlEdtEVSTUuDcwlfOBy+iveAtuKROFgr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4btTgd1j1MzYQvgt;
	Fri,  1 Aug 2025 10:00:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DFFB71A10E9;
	Fri,  1 Aug 2025 10:00:43 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgC3MxTJH4xo6bCnCA--.58432S3;
	Fri, 01 Aug 2025 10:00:43 +0800 (CST)
Subject: Re: [PATCH v4 11/11] md/md-llbitmap: introduce new lockless bitmap
To: Yu Kuai <yukuai@kernel.org>, corbet@lwn.net, agk@redhat.co,
 snitzer@kernel.org, mpatocka@redhat.com, hch@lst.de, song@kernel.org,
 hare@suse.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yangerkun@huawei.com,
 yi.zhang@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250721171557.34587-1-yukuai@kernel.org>
 <20250721171557.34587-12-yukuai@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f282237e-be12-b178-0e25-3a73bd20d77c@huaweicloud.com>
Date: Fri, 1 Aug 2025 10:00:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250721171557.34587-12-yukuai@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3MxTJH4xo6bCnCA--.58432S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF43uw4UGF1UGFWrurW3KFg_yoW5Zw47pF
	WIvF9xKayfJr1rXw17Xrn5ZFZ5XrWkKwsIqFn7A345WrnF9rnIkrWrGFWUJw4rZwn8JFs5
	ta15Krs8KF1DuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUFku4UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2025/07/22 1:15, Yu Kuai д��:
> +static int llbitmap_read_sb(struct llbitmap *llbitmap)
> +{
> +	struct mddev *mddev = llbitmap->mddev;
> +	unsigned long daemon_sleep;
> +	unsigned long chunksize;
> +	unsigned long events;
> +	struct page *sb_page;
> +	bitmap_super_t *sb;
> +	int ret = -EINVAL;
> +
> +	if (!mddev->bitmap_info.offset) {
> +		pr_err("md/llbitmap: %s: no super block found", mdname(mddev));
> +		return -EINVAL;
> +	}
> +
> +	sb_page = llbitmap_read_page(llbitmap, 0);
> +	if (IS_ERR(sb_page)) {
> +		pr_err("md/llbitmap: %s: read super block failed",
> +		       mdname(mddev));

There should return -EIO directly here.
> +		ret = -EIO;
> +		goto out;

And the out tag can be removed.

Thanks,
Kuai

> +	}
> +
> +	sb = kmap_local_page(sb_page);
> +	if (sb->magic != cpu_to_le32(BITMAP_MAGIC)) {
> +		pr_err("md/llbitmap: %s: invalid super block magic number",
> +		       mdname(mddev));
> +		goto out_put_page;
> +	}
> +
> +	if (sb->version != cpu_to_le32(BITMAP_MAJOR_LOCKLESS)) {
> +		pr_err("md/llbitmap: %s: invalid super block version",
> +		       mdname(mddev));
> +		goto out_put_page;
> +	}
> +
> +	if (memcmp(sb->uuid, mddev->uuid, 16)) {
> +		pr_err("md/llbitmap: %s: bitmap superblock UUID mismatch\n",
> +		       mdname(mddev));
> +		goto out_put_page;
> +	}
> +
> +	if (mddev->bitmap_info.space == 0) {
> +		int room = le32_to_cpu(sb->sectors_reserved);
> +
> +		if (room)
> +			mddev->bitmap_info.space = room;
> +		else
> +			mddev->bitmap_info.space = mddev->bitmap_info.default_space;
> +	}
> +	llbitmap->flags = le32_to_cpu(sb->state);
> +	if (test_and_clear_bit(BITMAP_FIRST_USE, &llbitmap->flags)) {
> +		ret = llbitmap_init(llbitmap);
> +		goto out_put_page;
> +	}
> +
> +	chunksize = le32_to_cpu(sb->chunksize);
> +	if (!is_power_of_2(chunksize)) {
> +		pr_err("md/llbitmap: %s: chunksize not a power of 2",
> +		       mdname(mddev));
> +		goto out_put_page;
> +	}
> +
> +	if (chunksize < DIV_ROUND_UP(mddev->resync_max_sectors,
> +				     mddev->bitmap_info.space << SECTOR_SHIFT)) {
> +		pr_err("md/llbitmap: %s: chunksize too small %lu < %llu / %lu",
> +		       mdname(mddev), chunksize, mddev->resync_max_sectors,
> +		       mddev->bitmap_info.space);
> +		goto out_put_page;
> +	}
> +
> +	daemon_sleep = le32_to_cpu(sb->daemon_sleep);
> +	if (daemon_sleep < 1 || daemon_sleep > MAX_SCHEDULE_TIMEOUT / HZ) {
> +		pr_err("md/llbitmap: %s: daemon sleep %lu period out of range",
> +		       mdname(mddev), daemon_sleep);
> +		goto out_put_page;
> +	}
> +
> +	events = le64_to_cpu(sb->events);
> +	if (events < mddev->events) {
> +		pr_warn("md/llbitmap :%s: bitmap file is out of date (%lu < %llu) -- forcing full recovery",
> +			mdname(mddev), events, mddev->events);
> +		set_bit(BITMAP_STALE, &llbitmap->flags);
> +	}
> +
> +	sb->sync_size = cpu_to_le64(mddev->resync_max_sectors);
> +	mddev->bitmap_info.chunksize = chunksize;
> +	mddev->bitmap_info.daemon_sleep = daemon_sleep;
> +
> +	llbitmap->barrier_idle = DEFAULT_BARRIER_IDLE;
> +	llbitmap->chunksize = chunksize;
> +	llbitmap->chunks = DIV_ROUND_UP(mddev->resync_max_sectors, chunksize);
> +	llbitmap->chunkshift = ffz(~chunksize);
> +	ret = llbitmap_cache_pages(llbitmap);
> +
> +out_put_page:
> +	__free_page(sb_page);
> +out:
> +	kunmap_local(sb);
> +	return ret;
> +}


