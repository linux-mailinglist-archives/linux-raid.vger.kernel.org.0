Return-Path: <linux-raid+bounces-930-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE6B86A612
	for <lists+linux-raid@lfdr.de>; Wed, 28 Feb 2024 02:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF9E28B02B
	for <lists+linux-raid@lfdr.de>; Wed, 28 Feb 2024 01:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829D1CD24;
	Wed, 28 Feb 2024 01:38:25 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAA014F6C;
	Wed, 28 Feb 2024 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084305; cv=none; b=N8OvZBKTZJVhE+OYveXXwnnJ2A+oFIWCO1mbvK1QtF8wVlhA9Kz/e6mBpqNuQTqzq+u21PoGKNtpniTLz8VZ/EwI4IyqcSxsRvLPz8S0eiRkzN+6tYiXAXki4Au8t8hlVT+FNWalL+JqQgAAAUtK2iP5mfKXbIg9eNPjj0PosAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084305; c=relaxed/simple;
	bh=XBPk9Qj2LrjEaxZJYC7mfL8VZlgkPfh1DzOeRlZHWG0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Vk3NuimeK860vQ3OvbPJnoIr2tFfgb10rZaBVDY4RY8xXs0Oi/+VeFUlpS0X+RFJk1iNo213lUNMhWB8z/tb5Fb2aHOY4zNSOrg+GqgrPp8qqA2PrNpbbZzK+UuuQcLmMgg6yqqDP0TYo0Tvo1mEQRGopaf2nVWLSRyFPl3AOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tkxnh6nTvz4f3kK0;
	Wed, 28 Feb 2024 09:38:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4C3751A0232;
	Wed, 28 Feb 2024 09:38:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxCLjt5lOxd7FQ--.32591S3;
	Wed, 28 Feb 2024 09:38:20 +0800 (CST)
Subject: Re: [PATCH 04/16] md: add queue limit helpers
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
 drbd-dev@lists.linbit.com, dm-devel@lists.linux.dev,
 linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240226103004.281412-1-hch@lst.de>
 <20240226103004.281412-5-hch@lst.de>
 <6eb1741e-f336-bfb1-6549-21374ee667fc@huaweicloud.com>
 <20240227143618.GA13570@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e97d9a41-3e9e-0673-cbdd-466cb52d9f3f@huaweicloud.com>
Date: Wed, 28 Feb 2024 09:38:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240227143618.GA13570@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxCLjt5lOxd7FQ--.32591S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW8JFW3Jw17CF17Cr45Jrb_yoWxZFc_Wa
	98u39Fywn7ZFWvvrZrtFnxZFZ2kF18XF97XayfXF40g34UXF18GF4kAry8A3ZxGa17Cr1a
	gF9Yq34xtrZFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2024/02/27 22:36, Christoph Hellwig д��:
> On Mon, Feb 26, 2024 at 07:38:17PM +0800, Yu Kuai wrote:
>> Any reason to use blk_mq_freeze/unfreeze_queue ? I don't think this is
>> meaningful for raid, this only wait for IO submission, not IO done.
>>
>> raid should already handle concurrent IO with reshape, so I think this
>> can just be removed.
> 
> We can't just change limits under the driver if I/Os are being sumitted.
> That is one of the points of the whole queue limits exercises.
> 

Agree with this, it's just these apis can't gurantee this in raid, there
could still be IO inflight, perhaps you can use:

mddev_suspend(mddev)
...
mddev_resume(mddev)

Thanks,
Kuai

> .
> 


