Return-Path: <linux-raid+bounces-4217-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA1ABB2C7
	for <lists+linux-raid@lfdr.de>; Mon, 19 May 2025 03:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA307A8A77
	for <lists+linux-raid@lfdr.de>; Mon, 19 May 2025 01:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D71918DF8D;
	Mon, 19 May 2025 01:12:15 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AF3AD4B
	for <linux-raid@vger.kernel.org>; Mon, 19 May 2025 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747617134; cv=none; b=iviOrLH0QcwQ++wIAdL99R8QtLTT7o2sAzbgJV2Msh7Sp7eiBDBmb2CgQirV5nsv1IBK0Uh44P1GzgUrrIhENbLLoYk9zYu1KSY9UYQkH620/zMLPKvbpypus36y0ykjaIt8V/q8S1P50eaJVYL/jnLgAYxE5M5GnSToYsJnnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747617134; c=relaxed/simple;
	bh=kQobhRj/AHgQmEaBzba9+ivgn+2GOUh9qmydYNXPg/I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bGsElm/4aTAPYy4+nVDsifj5J3kmgR/7bFOvD/zyqvey82QkD6NpnIIJ7rsACB/VrO/oP4IKdr3WaPV4xdOm1RmXaxYBX3OX+CFc12SZnd/H9YmesjvoiVMXytPatEIcTaGWKi6/lM7YijDUKeP3aTmvTnq8KwCDKrBl4ViUeEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b105Y0F72zKHMSt
	for <linux-raid@vger.kernel.org>; Mon, 19 May 2025 09:12:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9589A1A07BB
	for <linux-raid@vger.kernel.org>; Mon, 19 May 2025 09:11:59 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB32l5dhSpoC9ZTMw--.24507S3;
	Mon, 19 May 2025 09:11:59 +0800 (CST)
Subject: Re: LVM2 test breakage
To: Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>
Cc: zkabelac@redhat.com, linux-raid@vger.kernel.org,
 dm-devel@lists.linux.dev, "yukuai (C)" <yukuai3@huawei.com>
References: <34fa755d-62c8-4588-8ee1-33cb1249bdf2@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <98ac5772-9931-17fd-1fc4-18d2c737b079@huaweicloud.com>
Date: Mon, 19 May 2025 09:11:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <34fa755d-62c8-4588-8ee1-33cb1249bdf2@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32l5dhSpoC9ZTMw--.24507S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4UCF1rCw4ruF45ArW5ZFb_yoWxCFb_GF
	WjyrZ2ga1kGr4xZF1YkF1Y9Fs3Ga1Iv34xJrW0qF12q3savrW5GrWxGr95Zr18Aw18J3W5
	W3yUK348Gry7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2025/05/17 0:00, Mikulas Patocka д��:
> Hi
> 
> The commit e879a0d9cb086c8e52ce6c04e5bfa63825a6213c breaks the test
> shell/lvcreate-large-raid.sh in the lvm2 testsuite.
> 
> The breakage is caused by removing the line "read_bio->bi_opf = op |
> do_sync;"
> 

Sorry that I don't undertand here, before the patch:

op = bio_op(bio);
do_sync = bio->bi_opf & REQ_SYNC;
read_bio->bi_opf = op | do_sync

after the patch:

read_bio = bio_alloc_clone(, bio, ...)
  read_bio->bi_opf = bio->bi_opf

So, after the patch, other than bio_op() and REQ_SYNC, other bio flags
are keeped, I don't see problem for now, I'll run the test later.

Thanks,
Kuai

> Mikulas
> 
> 
> .
> 


