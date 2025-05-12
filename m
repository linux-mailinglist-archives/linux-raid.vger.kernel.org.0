Return-Path: <linux-raid+bounces-4197-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BB5AB3980
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 15:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB01179176
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABE2951DD;
	Mon, 12 May 2025 13:41:43 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229EB294A10;
	Mon, 12 May 2025 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747057302; cv=none; b=TOSSYCRyg9AjdzsUIm17s5aRogIfCreBgZ4dTKZ2sBgtLUnsGYPp8VHDOTIPzFzL5lADfh/TGS8m/BHdjPvT8ObxfcG/pkavLMKDKqe5FFzzYY7AaLqv0hsuzjYikoz23W2fquOtC8MvmxE7reCIzZsteI87AsNXcYCt79R4uGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747057302; c=relaxed/simple;
	bh=MRkWQPYb0VD2RHdEFzP8GefKj7cVuZINANlg7F9SD9s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tXj2FiPpbf9ZK9ksVhcjmkoXYtpV5x2JPN4fDK7k0M1Q4Bo8lenwYTj24WBNdHn8wioIdoegld/f+KbbBZdbz/H4peQYj9yii98RDIllQVAgzHWKPRUlAl8nS4fdiTDwP5w1jeTM4o+6PzH1kj80cKOugJEYf7/GzjOPmqJLe74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zx13C586Dz4f3lCf;
	Mon, 12 May 2025 21:41:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF7E01A0359;
	Mon, 12 May 2025 21:41:37 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl+Q+iFo693IMA--.57717S3;
	Mon, 12 May 2025 21:41:37 +0800 (CST)
Subject: Re: [PATCH RFC md-6.16 v3 00/19] md: introduce a new lockless bitmap
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, colyli@kernel.org, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
 <20250512052118.GA1796@lst.de>
 <6aeecf3e-2f24-7d30-8462-c8d30b197740@huaweicloud.com>
 <20250512132750.GD31781@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <934fdd89-3963-98d5-b450-f36024aa47b2@huaweicloud.com>
Date: Mon, 12 May 2025 21:41:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250512132750.GD31781@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl+Q+iFo693IMA--.57717S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GryxAFWrWFWUWr4UXF1rtFb_yoWfWFgEvF
	y3KFyxG39rZw4SvanFgF1DZrZ8Ww17ZFy5A395Gas3Jw4UGa4xGF4vk392qa45tFsakrs8
	ZFWYqry5XwsxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2025/05/12 21:27, Christoph Hellwig д��:
> On Mon, May 12, 2025 at 04:40:02PM +0800, Yu Kuai wrote:
>> I don't have such plan for now, actually I tend to remove bitmap file,
>> once llbitmap is ready with lightweight overhead, I expect perforamce
>> can be better than old bitmap with bitmap file.
>>
>> If there are cases that llbitmap performace is still much worse than
>> none bitmap, and bitmap file can reduce the gap, we'll probable think
>> about bitmap file again.
> 
> I'd really love to see this replace the old code as soon as possible.
> But can we simply drop support for users with the bitmap in a file
> in the file system (no matter how much I dislike that use case..)?
> 

Do you mean drop it now?

AFAIK, bitmap file in a file system is problem the only case for now, I
don't see any users pass in a raw disk in this case, because bitmap file
is at most 128k by default.

Thanks,
Kuai

> .
> 


