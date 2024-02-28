Return-Path: <linux-raid+bounces-931-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CF686A615
	for <lists+linux-raid@lfdr.de>; Wed, 28 Feb 2024 02:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0267D1C22992
	for <lists+linux-raid@lfdr.de>; Wed, 28 Feb 2024 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E451CFAB;
	Wed, 28 Feb 2024 01:42:16 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43823C2;
	Wed, 28 Feb 2024 01:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084536; cv=none; b=qLjZ4PLkca+NJmPI2QiAH5ioZUYE5vBzW2XWei6IUffxkHKPQ0WTEhAmwCQva8kX0StyKXjBL3uBUfkVafMohcJIo/9bqlzOFlt6QkrLo1t4LbPUX0ZPcHWBwpfuVylgNT6PzntFsa6Hhtv88F2bIB7Y8OKLp1kLaxwi3hkkyF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084536; c=relaxed/simple;
	bh=ciAs5C8DwsechQSws1hsWH1Ye1v6BBpplzF+SEt7mzc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MynIz8uRMEjeUw7Ohaml8jAZVK5MsCKh8432gPzilmV7W9uIiTMgAcKCknsVWCNZP2bbJsxnMS91VBpgT6z4ZPdCJYtSYJn2V4k52qCRpTPevn524Juoj/i7J8pPCGk3HLWdaHw2FvDBtoCRfXTTK6z5FBjVk6d9zEhc41NcmYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tkxt51lbDz4f3kFH;
	Wed, 28 Feb 2024 09:42:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 767F61A0E61;
	Wed, 28 Feb 2024 09:42:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5vj95lmll7FQ--.36270S3;
	Wed, 28 Feb 2024 09:42:08 +0800 (CST)
Subject: Re: [PATCH 06/16] md/raid1: use the atomic queue limit update APIs
To: Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
 drbd-dev@lists.linbit.com, dm-devel@lists.linux.dev,
 linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240226103004.281412-1-hch@lst.de>
 <20240226103004.281412-7-hch@lst.de>
 <b4828284-87ec-693b-e2c3-84bdafcbda65@huaweicloud.com>
 <20240227152609.GA14782@lst.de>
 <CAPhsuW5xaK=WR1RKGpYkSzHW8TOMbUwY-KeTD=kD3otQFZZV0Q@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <19874170-1c9e-de5c-f197-d3b120a47c6d@huaweicloud.com>
Date: Wed, 28 Feb 2024 09:42:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5xaK=WR1RKGpYkSzHW8TOMbUwY-KeTD=kD3otQFZZV0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5vj95lmll7FQ--.36270S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1DAr1rXry7JFyfWr4fuFg_yoWDKrc_ta
	13ArZ7Kw1kuFWq9F4kKFW3JFZ7KF4DWw4UZa1UWFW3u34fAFn3Xr97Jry3Z3WDKayxK3Z0
	kF1kWa15G340kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/28 5:54, Song Liu 写道:
> On Tue, Feb 27, 2024 at 7:26 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Mon, Feb 26, 2024 at 07:29:08PM +0800, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2024/02/26 18:29, Christoph Hellwig 写道:
>>>> Build the queue limits outside the queue and apply them using
>>>> queue_limits_set.  Also remove the bogus ->gendisk and ->queue NULL
>>>> checks in the are while touching it.
>>>
>>> The checking of mddev->gendisk can't be removed, because this is used to
>>> distinguish dm-raid and md/raid. And the same for following patches.
>>
>> Ah.  Well, we should make that more obvious then.  This is what I
>> currently have:
>>
>> http://git.infradead.org/?p=users/hch/block.git;a=shortlog;h=refs/heads/md-blk-limits
>>
>> particularly:
>>
>> http://git.infradead.org/?p=users/hch/block.git;a=commitdiff;h=24b2fd15f57f06629d2254ebec480e1e28b96636
> 
> Yes! I was thinking about something like mddev_is_dm() to make these
> checks less confusing. Thanks!

Yes, this looks good.

Thanks,
Kuai

> 
> Song
> .
> 


