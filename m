Return-Path: <linux-raid+bounces-3099-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26C9BB47D
	for <lists+linux-raid@lfdr.de>; Mon,  4 Nov 2024 13:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36201F210F8
	for <lists+linux-raid@lfdr.de>; Mon,  4 Nov 2024 12:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA501B3725;
	Mon,  4 Nov 2024 12:18:31 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE515C139
	for <linux-raid@vger.kernel.org>; Mon,  4 Nov 2024 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722711; cv=none; b=hLSifr3t54jrTCthvPrfnh0zPLQhF8FxepE731SIfxj31NZGuL1Dikau7GmldpK1A6BPmYeZutUzuR+waGUuQdpv9Vd8KqIsmBWtvFagVNlKr0Dva5OCKbgQ3nUK2PeJ9iuRerpoaH8DAWWTAVMHBOIhG9R/77j5O5vCjHTnD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722711; c=relaxed/simple;
	bh=id6qYCeFi6fo3j+hV7Hio5GA082ZlVHW1JzVaTCzqhU=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lN6anJjZHBozwd/PwlAw9xa2y7WUMEjJmQ+EINt+LkWbM9bRo5Uw3W7a3r2f1PsqSfT6VAMlt+yGuvYCVk9NTnvb/fcNLL6Z38E3k3BYjhcU64+u+aIjZ3xsTjSWPeDNbMrB22SM3aC6a4fgSzAbJ7KNHRwajq0ERSl+KL6dcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xhr8Y1bxkz4f3jXT
	for <linux-raid@vger.kernel.org>; Mon,  4 Nov 2024 20:18:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 22BF01A0196
	for <linux-raid@vger.kernel.org>; Mon,  4 Nov 2024 20:18:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4eNuyhneaZQAw--.28576S3;
	Mon, 04 Nov 2024 20:18:22 +0800 (CST)
Subject: Re: PROBLEM: repeatable lockup on RAID-6 with LUKS dm-crypt on NVMe
 devices when rsyncing many files
From: Yu Kuai <yukuai1@huaweicloud.com>
To: Christian Theune <ct@flyingcircus.io>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: John Stoffel <john@stoffel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 dm-devel@lists.linux.dev, =?UTF-8?Q?Dragan_Milivojevi=c4=87?=
 <galileo@pkm-inc.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <ADF7D720-5764-4AF3-B68E-1845988737AA@flyingcircus.io>
 <E893A1D9-4042-4515-88AE-C69B078A3E43@flyingcircus.io>
 <A74EC4F5-2FF8-4274-A1EB-28D527F143F1@flyingcircus.io>
 <2d85e9ab-1d0f-70a1-fab2-1e469764ef28@huaweicloud.com>
 <3CF4B28B-52D7-414E-96A1-FDFA5A5EF172@flyingcircus.io>
 <3DB33849-56C5-4C5C-BF56-F54205BEFCF2@flyingcircus.io>
 <1f2c74f4-8ba9-1a9f-0c11-018a25e785e5@huaweicloud.com>
 <22A202B1-A802-406F-8F38-F4F486A92F81@flyingcircus.io>
 <45d44ed5-da7c-6480-9143-f611385b2e92@huaweicloud.com>
 <9C03DED0-3A6A-42F8-B935-6EB500F8BCE2@flyingcircus.io>
 <DD99A1F0-56E7-473D-B917-66885810233E@flyingcircus.io>
 <78517565-B1AB-4441-B4F8-EB380E98EB0F@flyingcircus.io>
 <26403.59789.480428.418012@quad.stoffel.home>
 <5fb0a6f0-066d-c490-3010-8a047aae2c29@huaweicloud.com>
 <F8CEEB15-0E3C-4F67-951D-12E165D6CC05@flyingcircus.io>
 <B6D76C57-B940-4BFD-9C40-D6E463D2A09F@flyingcircus.io>
 <5170f0d2-cb0f-2e0f-eb5e-31aa9d6ff65d@huawei.com>
Message-ID: <2b093abc-cd9a-0b84-bcba-baec689fa153@huaweicloud.com>
Date: Mon, 4 Nov 2024 20:18:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5170f0d2-cb0f-2e0f-eb5e-31aa9d6ff65d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHo4eNuyhneaZQAw--.28576S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW8JF4DXFyxCw43Jw4Utwb_yoWxKr1fpa
	40gFyfGr1DJrWSgr4jg3yj9w4SkFW8ur13WFWkJayDJr4ruw15Kw4Sgw1Yv3WYgrsY9Fy5
	tryqvry7X393CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/11/04 19:40, Yu Kuai 写道:
> Hi,
> 
> 在 2024/11/01 16:33, Christian Theune 写道:
>> I dug out a different one that goes back longer but even that one 
>> seems like something was missing early on when I didn’t have the 
>> serial console attached.
>>
>> I’m wondering whether this indicates an issue during initialization? 
>> I’m going to reboot the machine and make sure i get the early logs 
>> with those numbers.
>>
>> [  405.347345] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(22301786792+8) 4294967259
> 
> For this log, let's assume the firt start is from here.
>> [  432.542465] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(22837701992+8) 4294967260
>> [  432.542469] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(22837701992+8) 4294967261
>> [  434.272964] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(22837701992+8) 4294967262
>> [  434.273175] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(22837701992+8) 4294967263
>> [  434.273189] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(22837701992+8) 4294967264
>> [  434.273285] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(22837701992+8) 4294967265
>> [  434.274063] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(22837701992+8) 4294967264
>> [  434.274066] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(22837701992+8) 4294967263
>> [  434.274070] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(22837701992+8) 4294967262
>> [  434.274073] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(22837701992+8) 4294967261
>> [  434.274078] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(22837701992+8) 4294967260
>> [  434.274083] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(22837701992+8) 4294967259
>> [  434.276609] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(23374951848+8) 4294967260
>> [  434.278939] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(23374951848+8) 4294967261
>> [  464.922354] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(23374951848+8) 4294967260
>> [  464.931833] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(23374951848+8) 4294967259
>> [  466.964557] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(23912715112+8) 4294967260
>> [  466.964616] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(23912715112+8) 4294967261
>> [  474.399930] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(23912715112+8) 4294967262
>> [  474.451451] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(23912715112+8) 4294967263
>> [  489.447079] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(23912715112+8) 4294967262
>> [  489.456574] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(23912715112+8) 4294967261
>> [  489.466069] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(23912715112+8) 4294967260
>> [  489.475565] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(23912715112+8) 4294967259
>> [  491.235517] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(24448073512+8) 4294967260
>> [  491.235602] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(24448073512+8) 4294967261
>> [  498.153108] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(24716445096+8) 4294967262
>> [  498.156307] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(24716445096+8) 4294967263
>> [  530.332619] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(24716445096+8) 4294967262
>> [  530.342110] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(24716445096+8) 4294967261
>> [  530.351595] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(24716445096+8) 4294967260
>> [  530.361082] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(24716445096+8) 4294967259
>> [  535.176774] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(24985208424+8) 4294967260
>> [  549.125326] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(24985208424+8) 4294967259
> 
> Then until now, everything is good, start and end is balanced for this
> stripe head.
>> [  549.635782] __add_stripe_bio: md127: start 
>> ff2721beec8c2fa0(25521770024+8) 4294967261
>> [  590.875593] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(25521770024+8) 4294967260
>> [  590.885081] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(25521770024+8) 4294967259
>> [  596.973863] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(26057037928+8) 4294967263
>> [  596.973866] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(26057037928+8) 4294967262
>> [  596.973869] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(26057037928+8) 4294967261
>> [  596.973871] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(26057037928+8) 4294967260
>> [  596.973881] handle_stripe_clean_event: md127: end 
>> ff2721beec8c2fa0(26057037928+8) 4294967259
> 
> Then, oops, this 'sh' start just once here, and end lots of times. It's
> unlikely that those end are corresponding to the log much earlier, so
> I'm almost convinced that this problem is due to unbalanced start and
> end. And the huge number is due to underflow.
> 
> Let me dig more. :)

I think I found a problem by code review, can you test the following
patch? (Noted this is still from latest mainline).

Thanks,
Kuai

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index dc2ea636d173..04f32173839a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4042,6 +4042,8 @@ static void handle_stripe_clean_event(struct 
r5conf *conf,
                              test_bit(R5_SkipCopy, &dev->flags))) {
                                 /* We can return any write requests */
                                 struct bio *wbi, *wbi2;
+                               bool written = false;
+
                                 pr_debug("Return write for disc %d\n", i);
                                 if (test_and_clear_bit(R5_Discard, 
&dev->flags))
                                         clear_bit(R5_UPTODATE, 
&dev->flags);
@@ -4054,6 +4056,9 @@ static void handle_stripe_clean_event(struct 
r5conf *conf,
                                 dev->page = dev->orig_page;
                                 wbi = dev->written;
                                 dev->written = NULL;
+                               if (wbi)
+                                       written = true;
+
                                 while (wbi && wbi->bi_iter.bi_sector <
                                         dev->sector + 
RAID5_STRIPE_SECTORS(conf)) {
                                         wbi2 = r5_next_bio(conf, wbi, 
dev->sector);
@@ -4061,10 +4066,13 @@ static void handle_stripe_clean_event(struct 
r5conf *conf,
                                         bio_endio(wbi);
                                         wbi = wbi2;
                                 }
- 
conf->mddev->bitmap_ops->endwrite(conf->mddev,
-                                       sh->sector, 
RAID5_STRIPE_SECTORS(conf),
-                                       !test_bit(STRIPE_DEGRADED, 
&sh->state),
-                                       false);
+
+                               if (written)
+ 
conf->mddev->bitmap_ops->endwrite(conf->mddev,
+                                               sh->sector, 
RAID5_STRIPE_SECTORS(conf),
+ 
!test_bit(STRIPE_DEGRADED, &sh->state),
+                                               false);
+
                                 if (head_sh->batch_head) {
                                         sh = 
list_first_entry(&sh->batch_list,
                                                               struct 
stripe_head,

> 
> Thanks,
> Kuai
> 


