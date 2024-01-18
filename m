Return-Path: <linux-raid+bounces-384-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C30831136
	for <lists+linux-raid@lfdr.de>; Thu, 18 Jan 2024 03:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034FD1F220F1
	for <lists+linux-raid@lfdr.de>; Thu, 18 Jan 2024 02:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A432211C;
	Thu, 18 Jan 2024 02:04:08 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5920F2
	for <linux-raid@vger.kernel.org>; Thu, 18 Jan 2024 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543447; cv=none; b=C4qhM6/JPSIqhj5JI3M953ecy3R93KtcnGKypwVNvMeYwyuaW0v4OJLDLTZskGMqcajWaWbWX+wfm68hU8pYuOA18WJPmzfBGJ9I0kIIE5uQTef4ShORD6yPelGljriZksnk9qkEFBYkEpcSx1wf/C5ZZY5ey0FLZ4ur1UYa7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543447; c=relaxed/simple;
	bh=5F6HIsjedr0HZn/DS1rVNOHdbnQcau5vNyZZxuVk6ao=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=hr6p4JQ7uWEGB0J5AWDDgv4XHHTeLYC1IaCbdlnQ5CXyJZGU3NpqZa16uHQR4RbMXS/5xVmcAbvruq7LjA8dhgrqWCV7eJOFZvDUfIPVPPfmT6O5md3POD4ovzYxgnX8SUtpjxpR9qWA/d8nDuKJ7W0qJ+uwptcvUV9xz9s60iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFmJC0bp2z4f3lg5
	for <linux-raid@vger.kernel.org>; Thu, 18 Jan 2024 10:03:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 36E1F1A0172
	for <linux-raid@vger.kernel.org>; Thu, 18 Jan 2024 10:04:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ4Ph6hlxn2uBA--.43049S3;
	Thu, 18 Jan 2024 10:04:01 +0800 (CST)
Subject: Re: [PATCH 0/7] MD fixes for the LVM2 testsuite
To: Song Liu <song@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
Cc: David Jeffery <djeffery@redhat.com>, Li Nan <linan122@huawei.com>,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 Mike Snitzer <msnitzer@redhat.com>, Heinz Mauelshagen <heinzm@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com>
 <CAPhsuW40f2SQqzcRkCxu-9=or=3HNiDBHirHO4F=BjAn_ufZgg@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7088e329-b857-7654-294c-3f43930f8f10@huaweicloud.com>
Date: Thu, 18 Jan 2024 10:03:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW40f2SQqzcRkCxu-9=or=3HNiDBHirHO4F=BjAn_ufZgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ4Ph6hlxn2uBA--.43049S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW8uFyDur4kXw17uryxuFg_yoWkZFbE9F
	yqvr97GwsrAw4UXan0qw42qr47KFZrZryDWrWUtrn8Ga43XFWDJrZrGrZ3ZrZxGa98KF9I
	gFZ7ArW8Awn8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UGYL9UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/18 3:27, Song Liu 写道:
> Hi Mikulas,
> 
> On Wed, Jan 17, 2024 at 10:17 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>>
>> Hi
>>
>> Here I'm sending MD patches that fix the LVM2 testsuite for the kernels
>> 6.7 and 6.8. The testsuite was broken in the 6.6 -> 6.7 window, there are
>> multiple tests that deadlock.
>>
>> I fixed some of the bugs. And I reverted some patches that claim to be
>> fixing bugs but they break the testsuite.
>>
>> I'd like to ask you - please, next time when you are going to commit
>> something into the MD subsystem, download the LVM2 package from
>> git://sourceware.org/git/lvm2.git and run the testsuite ("./configure &&
>> make && make check") to make sure that your bugfix doesn't introduce
>> another bug. You can run a specific test with the "T" parameter - for
>> example "make check T=shell/integrity-caching.sh"
> 
> Thanks for the report and fixes!
> 
> We will look into the fixes and process them ASAP.
> 
> We will also add the lvm2 testsuite to the test framework.

Yes, we absolutely must make sure that dm-raid is not broken...

I'll try to run lvm2 testsuite and figure out the root cause.

Thanks,
Kuai

> 
> Song
> .
> 


