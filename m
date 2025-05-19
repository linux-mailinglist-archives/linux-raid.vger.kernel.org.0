Return-Path: <linux-raid+bounces-4222-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0B7ABBBF9
	for <lists+linux-raid@lfdr.de>; Mon, 19 May 2025 13:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4765D189C01C
	for <lists+linux-raid@lfdr.de>; Mon, 19 May 2025 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D7272E57;
	Mon, 19 May 2025 11:07:44 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2E1F462C
	for <linux-raid@vger.kernel.org>; Mon, 19 May 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652864; cv=none; b=BIGfXoKo58R3fQDojct4k631ThddRJh1ceaUkfyivLI0HlXzPuuZafHCe64IfmooMYwz6kYQq4kawk9t5X5WKAy8j4mBkT3qaRr2DDYgk75x+rYAIabIRE2wqiG9NgSZRwmjDNt50D4FGyczUjrad6BtgCGuGNM940QyOqJxi7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652864; c=relaxed/simple;
	bh=4XqcO7RmN++Pb6VnpN469Bcv4cw/D9ToAHniBreylhc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=snxmJZpwuWsp8doUpLFQJp+CxcBWLiIWaQ13HUVvQQRX6qYavjGUSW1drBGjLwCgFiW4F5YuUwA9zjmezz79bcIxgfU9CrTXoVR94DKQqlrZY/ZLYzPOB7Xea15dyX82rLuq9yK83EDWIflNjvqGUwgfAa2tsL/vHJvHJI3cICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b1FJJ1Ym8z4f3lDK
	for <linux-raid@vger.kernel.org>; Mon, 19 May 2025 19:07:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9FB151A0BA8
	for <linux-raid@vger.kernel.org>; Mon, 19 May 2025 19:07:38 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl_4ECtov619Mw--.35966S3;
	Mon, 19 May 2025 19:07:38 +0800 (CST)
Subject: Re: LVM2 test breakage
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>,
 Mikulas Patocka <mpatocka@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
 dm-devel@lists.linux.dev, "yukuai (C)" <yukuai3@huawei.com>
References: <34fa755d-62c8-4588-8ee1-33cb1249bdf2@redhat.com>
 <98ac5772-9931-17fd-1fc4-18d2c737b079@huaweicloud.com>
 <73ff7f5f-6f09-66d8-9061-7840bc72d0df@huaweicloud.com>
 <0be9be18-9488-1edc-00bb-5a1b0414fd15@redhat.com>
 <81c5847a-cfd8-4f9f-892c-62cca3d17e63@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2ec7a2fd-13bd-08d7-8e8d-71ef83c3aa45@huaweicloud.com>
Date: Mon, 19 May 2025 19:07:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <81c5847a-cfd8-4f9f-892c-62cca3d17e63@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl_4ECtov619Mw--.35966S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw18Jw47Gr18Zw15WFyUWrg_yoW8Cr1fpF
	WrJF4jkwn3GF10k3sIqa15Cw1FqrsrAFZYgFyvgw40krn0k34Svrn8Jr45KFyqgFW8X3yj
	v395try7Z3W5Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/05/19 18:45, Zdenek Kabelac 写道:
> Dne 19. 05. 25 v 12:10 Mikulas Patocka napsal(a):
>> On Mon, 19 May 2025, Yu Kuai wrote:
>>
>>> Hi,
>>>
>>> 在 2025/05/19 9:11, Yu Kuai 写道:
>>>> Hi,
>>>>
>>>> 在 2025/05/17 0:00, Mikulas Patocka 写道:
>>>>> Hi
>>>>>
>>>>> The commit e879a0d9cb086c8e52ce6c04e5bfa63825a6213c breaks the test
>>>>> shell/lvcreate-large-raid.sh in the lvm2 testsuite.
>>>>>
>>>>> The breakage is caused by removing the line "read_bio->bi_opf = op |
>>>>> do_sync;"
>>>>>
>>> Do I need some special setup to run this test? I got following
>>> result in my VM, and I don't understand why it failed.
>>>
>>> Ask Zdenek Kabelac - he is expert in the testsuite.
>>>
>>> Mikulas
> 
> 
> Hi
> 
> 
> Lvm2 test suite is creating 'virtual' disk setup - it usually tries 
> first build something with 'brd' - if this device is 'in-use' it 
> fallback to create some files in LVM_TEST_DIR.
> 
> This dir however must allow creation of device - by default nowdays  
> /dev/shm & /tmp are mounted with  'nodev' mount option.
> 
> So a dir which does allow dev creation must be passed to the test - so 
> either remount dir without 'nodev' or set LVM_TEST_DIR to the filesystem 
> which allows creation of devices.

Yes, I know that, and I set LVM_TEST_DIR to a new mounted nvme, as use
can see in the attached log:

[ 0:02.335] ## DF_H:    /dev/nvme0n1     98G   64K   93G   1% /mnt/test

> 
> In 'lvm2/test'   run  'make help'  to see all possible settings - useful 
> one could be LVM_TEST_AUX_TRACE  to expose shell traces from test 
> internals - helps with debugging...
The log do have shell trace, I think, it stoped here, I just don't know
why :(

[ 0:01.709] ## - /root/lvm2/test/shell/lvcreate-large-raid.sh:31
[ 0:01.710] ## 1 STACKTRACE() called from 
/root/lvm2/test/shell/lvcreate-large-raid.sh:31

Thanks,
Kuai


