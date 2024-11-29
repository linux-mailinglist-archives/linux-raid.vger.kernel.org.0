Return-Path: <linux-raid+bounces-3267-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B39D2526
	for <lists+linux-raid@lfdr.de>; Tue, 19 Nov 2024 12:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516581F2182D
	for <lists+linux-raid@lfdr.de>; Tue, 19 Nov 2024 11:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5B1CB9F5;
	Tue, 19 Nov 2024 11:49:17 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1291CACE7;
	Tue, 19 Nov 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016957; cv=none; b=neD76Xtxj1+QiFp27OrRZ6/KcaoT0CFI7ByKn0YY9kQSkfJrSVOy35MNyobL9t8mfR6pxGLu1Sq0IzF0FjoOUfsy6ddhi2eKO3tKfDmhLXJMgN3sB93nf5cTF4MYsK1FK84h/eZ1vPKu5Q9NkbEgUVNzL0+rF70IZt7YgCpZVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016957; c=relaxed/simple;
	bh=jzt29YgPp8kxOmF91HtWePF+gDDTESXZcjT9iL/lpNQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UKa9nh5yl3IfT/4rJFy9bnhdDnEy7ka9pIZvQ05OipLI3zUCtcbpCn54hOgopt2b9QIHIcrA1uRB0eFcDu2O/ehu3WtmGbjulrIXCD0/th3hUKAw7V3ba0DAtWiHRbCQ27RKW7XXdpew8nWMAGGw+YzzViNbf2c1N8UZupkm/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xt2nw1gkHz4f3nKW;
	Tue, 19 Nov 2024 19:48:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 98DC41A0359;
	Tue, 19 Nov 2024 19:49:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgB3U4c1ezxn2nvsCA--.28243S3;
	Tue, 19 Nov 2024 19:49:11 +0800 (CST)
Subject: Re: md-raid 6.11.8 page fault oops
To: Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>
Cc: Genes Lists <lists@sapience.com>, dm-devel@lists.linux.dev,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@leemhuis.info, "yukuai (C)" <yukuai3@huawei.com>
References: <0b579808e848171fc64e04f0629e24735d034d32.camel@sapience.com>
 <CAPhsuW4kNYbcXERCQFqO-r8Q_rCLxrkQPt777cB_8TwyBfy8FA@mail.gmail.com>
 <3441514c-c18e-4711-35be-1e8eda119677@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <76b12bf9-3eff-c9da-2c8b-2cc31fb937a4@huaweicloud.com>
Date: Tue, 19 Nov 2024 19:49:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3441514c-c18e-4711-35be-1e8eda119677@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3U4c1ezxn2nvsCA--.28243S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFW5JF4kZry7AFW8ur1xZrb_yoWrKw45pr
	15JF1vkr4vqryUJrWSqw1jvF1qqr4vyF1UJFn5Krn7JF1qgr1DAr4UGrWjkwnrXr4Uur13
	Aas8X3yfKF4xJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/11/18 18:34, Mikulas Patocka 写道:
> 
> 
> On Fri, 15 Nov 2024, Song Liu wrote:
> 
>> + dm folks
>>
>> It appears the crash happens in dm.c:clone_endio. Commit
>> aaa53168cbcc486ca1927faac00bd99e81d4ff04 made some
>> changes to clone_endio, but I haven't looked into it.
>>
>> Thanks,
>> Song
> 
> Hi
> 
> That commit just adds a test for tio->ti being NULL, so I doubt that it
> caused this error.

The reported address is 0000000000000050, so it's ti is definitely not
NULL, ti->type is just 8 offset. However, target_type->end_io is
exactly 0x50, so the problem is due to ti->type is NULL.

Thanks,
Kuai

> 
> Mikulas
> 
> 
>> On Fri, Nov 15, 2024 at 4:12 AM Genes Lists <lists@sapience.com> wrote:
>>>
>>> md-raid crashed with kernel NULL pointer deref on stable 6.11.8.
>>>
>>> Happened with raid6 while rsync was writing (data was pulled over
>>> network).
>>>
>>> This rsync happens twice every day without a problem. This was the
>>> second run after booting 6.11.8, so will see if/when it happens again -
>>> and if frequent enough to make a bisect possible.
>>>
>>> Nonetheless, reporting now in case it's helpful.
>>>
>>> Full dmesg attached but the interesting part is:
>>>
>>> [33827.216164] BUG: kernel NULL pointer dereference, address:
>>> 0000000000000050
>>> [33827.216183] #PF: supervisor read access in kernel mode
>>> [33827.216193] #PF: error_code(0x0000) - not-present page
>>> [33827.216203] PGD 0 P4D 0
>>> [33827.216211] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>>> [33827.216221] CPU: 4 UID: 0 PID: 793 Comm: md127_raid6 Not tainted
>>> 6.11.8-stable-1 #21 1400000003000000474e5500ae13c727d476f9ab
>>> [33827.216240] Hardware name: To Be Filled By O.E.M. To Be Filled By
>>> O.E.M./Z370 Extreme4, BIOS P4.20 10/31/2019
>>> [33827.216254] RIP: 0010:clone_endio+0x43/0x1f0 [dm_mod]
>>> [33827.216279] Code: 4c 8b 77 e8 65 48 8b 1c 25 28 00 00 00 48 89 5c 24
>>> 08 48 89 fb 88 44 24 07 4d 85 f6 0f 84 11 01 00 00 49 8b 56 08 4c 8b 6b
>>> e0 <48> 8b 6a 50 4d 8b 65 38 3c 05 0f 84 0b 01 00 00 66 90 48 85 ed 74
>>> [33827.216304] RSP: 0018:ffffb9610101bb40 EFLAGS: 00010282
>>> [33827.216315] RAX: 0000000000000000 RBX: ffff9b15b8c5c598 RCX:
>>> 000000000015000c
>>> [33827.216326] RDX: 0000000000000000 RSI: ffffec17e1944200 RDI:
>>> ffff9b15b8c5c598
>>> [33827.216338] RBP: 0000000000000000 R08: ffff9b1825108c00 R09:
>>> 000000000015000c
>>> [33827.216349] R10: 000000000015000c R11: 00000000ffffffff R12:
>>> ffff9b10da026000
>>> [33827.216360] R13: ffff9b15b8c5c520 R14: ffff9b10ca024440 R15:
>>> ffff9b1474cb33c0
>>> [33827.216372] FS:  0000000000000000(0000) GS:ffff9b185ee00000(0000)
>>> knlGS:0000000000000000
>>> [33827.216385] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [33827.216394] CR2: 0000000000000050 CR3: 00000001f4e22005 CR4:
>>> 00000000003706f0
>>> [33827.216406] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>> 0000000000000000
>>> [33827.216417] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>> 0000000000000400
>>> [33827.216429] Call Trace:
>>> [33827.216435]  <TASK>
>>> [33827.216442]  ? __die_body.cold+0x19/0x27
>>> [33827.216453]  ? page_fault_oops+0x15a/0x2d0
>>> [33827.216465]  ? exc_page_fault+0x7e/0x180
>>> [33827.216475]  ? asm_exc_page_fault+0x26/0x30
>>> [33827.216486]  ? clone_endio+0x43/0x1f0 [dm_mod
>>> 1400000003000000474e5500e90ca42f094c5280]
>>> [33827.216510]  clone_endio+0x120/0x1f0 [dm_mod
>>> 1400000003000000474e5500e90ca42f094c5280]
>>> [33827.216533]  md_end_clone_io+0x42/0xa0 [md_mod
>>> 1400000003000000474e55004ac7ec7b1ac1c22c]
>>> [33827.216559]  handle_stripe_clean_event+0x1e6/0x430 [raid456
>>> 1400000003000000474e550080acde909728c7a9]
>>> [33827.216583]  handle_stripe+0x9a3/0x1c00 [raid456
>>> 1400000003000000474e550080acde909728c7a9]
>>> [33827.216606]  handle_active_stripes.isra.0+0x381/0x5b0 [raid456
>>> 1400000003000000474e550080acde909728c7a9]
>>> [33827.216625]  ? psi_task_switch+0xb7/0x200
>>> [33827.216637]  raid5d+0x450/0x670 [raid456
>>> 1400000003000000474e550080acde909728c7a9]
>>> [33827.216655]  ? lock_timer_base+0x76/0xa0
>>> [33827.216666]  md_thread+0xa2/0x190 [md_mod
>>> 1400000003000000474e55004ac7ec7b1ac1c22c]
>>> [33827.216689]  ? __pfx_autoremove_wake_function+0x10/0x10
>>> [33827.216701]  ? __pfx_md_thread+0x10/0x10 [md_mod
>>> 1400000003000000474e55004ac7ec7b1ac1c22c]
>>> [33827.216723]  kthread+0xcf/0x100
>>> [33827.216731]  ? __pfx_kthread+0x10/0x10
>>> [33827.216740]  ret_from_fork+0x31/0x50
>>> [33827.216749]  ? __pfx_kthread+0x10/0x10
>>> [33827.216757]  ret_from_fork_asm+0x1a/0x30
>>> [33827.216769]  </TASK>
>>>
>>> --
>>> Gene
>>>


