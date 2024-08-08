Return-Path: <linux-raid+bounces-2327-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0417194B4AA
	for <lists+linux-raid@lfdr.de>; Thu,  8 Aug 2024 03:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41CB283B5F
	for <lists+linux-raid@lfdr.de>; Thu,  8 Aug 2024 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4FB677;
	Thu,  8 Aug 2024 01:34:07 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0819454
	for <linux-raid@vger.kernel.org>; Thu,  8 Aug 2024 01:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723080847; cv=none; b=dK4745j2xevYOyWCg/2nx3BqORRMdWbHFesxn4QMeHB2gdISUkQUPX3UzAZk3PxQWlaXtWZ+4wxMsTBGGtfymFNaTK0RH95HgR4+AJ5MdK1KTDuXbsEItbk5nEWE67xcBfMh5r4m/icvnaerG27BRQgOaHE433V33rQ1Q4u2Z/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723080847; c=relaxed/simple;
	bh=8K0wx50hu0MJ4CtaACfr7rWtlNboecE+hCBEH2jof3s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dGHsvKfZsTMfI5au6utAQxi/IzwfIMxfuisaPkiCFO6kbzO2baNheigvpkbOfh7H2IbqyHUvIJ/yyxSIIZjxvdkfpSUUWaUKKQC6exEFdn/9sX+gLI75pvOPcmhOIaIIJzlCfBnfx+5inOw7lxnTkqeyxrYnGmkVr59zLtZUdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WfV1q4rhxz4f3jYx
	for <linux-raid@vger.kernel.org>; Thu,  8 Aug 2024 09:33:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B2E7D1A157B
	for <linux-raid@vger.kernel.org>; Thu,  8 Aug 2024 09:34:00 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoSGILRmBYRNBA--.49953S3;
	Thu, 08 Aug 2024 09:33:59 +0800 (CST)
Subject: Re: PROBLEM: repeatable lockup on RAID-6 with LUKS dm-crypt on NVMe
 devices when rsyncing many files
To: John Stoffel <john@stoffel.org>, Christian Theune <ct@flyingcircus.io>
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 dm-devel@lists.linux.dev, "yukuai (C)" <yukuai3@huawei.com>
References: <ADF7D720-5764-4AF3-B68E-1845988737AA@flyingcircus.io>
 <316050c6-fac2-b022-6350-eaedcc7d953a@huaweicloud.com>
 <58450ED6-EBC3-4770-9C5C-01ABB29468D6@flyingcircus.io>
 <EACD5B78-93F6-443C-BB5A-19C9174A1C5C@flyingcircus.io>
 <22C5E55F-9C50-4DB7-B656-08BEC238C8A7@flyingcircus.io>
 <26291.57727.410499.243125@quad.stoffel.home>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dc7324f0-55bc-28a9-742b-2d229719a6c2@huaweicloud.com>
Date: Thu, 8 Aug 2024 09:33:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <26291.57727.410499.243125@quad.stoffel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoSGILRmBYRNBA--.49953S3
X-Coremail-Antispam: 1UD129KBjvAXoWfAw45Gr18WFyDZF1fCry8Xwb_yoW8KFW5Xo
	W3Ww1I9FW8Kr15GF4rCw4UJ3y3Gw4xt3WfAry8Kw4YyF4qkayjqrnrAFyUJa93Xr45JF93
	CF1ag347K3srZwn5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYS7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
	bIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/08/08 5:05, John Stoffel 写道:
>>>>>> "Christian" == Christian Theune <ct@flyingcircus.io> writes:
> 
> 
> 
>> i had some more time at hand and managent to compile 5.15.164. The
>> issue is the same. After around 1h30m of work it hangs.  I’ll try to
>> reproduce this on a newer supported kernel if I can.
> 
> Supported by who?   NixOS?  Why don't you just install linux kernel
> 6.6.x and see of the problem is still there?  5.15.x is ancient and
> un-supported upstream now.

I agree that test on 5.15.x is not necessary for now. Please test on
v6.10 directly and make sure this is not a known problem first. The
hang stack is not really helpful because lots of problems will look like
this. :(

Thanks,
Kuai

> 
> 
> 
>> Kernel:
> 
>> Linux version 5.15.164 (nixbld@localhost) (gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP Sat Jul 27 08:46:18 UTC 2024
> 
>> The config is unchanged except from the deprecated NFSD_V2_ACL and NFSD_V3 options which I had to remove. NFS is not in use on this server, though.
> 
>> Output:
> 
>> [ 4549.838672] INFO: task kworker/u64:7:432 blocked for more than 122 seconds.
>> [ 4549.846507]       Not tainted 5.15.164 #1-NixOS
>> [ 4549.851616] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4549.860421] task:kworker/u64:7   state:D stack:    0 pid:  432 ppid:     2 flags:0x00004000
>> [ 4549.860426] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
>> [ 4549.860435] Call Trace:
>> [ 4549.860437]  <TASK>
>> [ 4549.860440]  __schedule+0x373/0x1580
>> [ 4549.860446]  ? sysvec_call_function_single+0xa/0x90
>> [ 4549.860449]  ? asm_sysvec_call_function_single+0x16/0x20
>> [ 4549.860453]  schedule+0x5b/0xe0
>> [ 4549.860455]  md_bitmap_startwrite+0x177/0x1e0
>> [ 4549.860459]  ? finish_wait+0x90/0x90
>> [ 4549.860465]  add_stripe_bio+0x449/0x770 [raid456]
>> [ 4549.860472]  raid5_make_request+0x1cf/0xbd0 [raid456]
>> [ 4549.860476]  ? kmem_cache_alloc_node_trace+0x341/0x3e0
>> [ 4549.860480]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.860484]  ? linear_map+0x44/0x90 [dm_mod]
>> [ 4549.860490]  ? finish_wait+0x90/0x90
>> [ 4549.860492]  ? __blk_queue_split+0x516/0x580
>> [ 4549.860495]  md_handle_request+0x11f/0x1b0
>> [ 4549.860500]  md_submit_bio+0x6e/0xb0
>> [ 4549.860502]  __submit_bio+0x18c/0x220
>> [ 4549.860505]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.860507]  ? crypt_page_alloc+0x46/0x60 [dm_crypt]
>> [ 4549.860510]  submit_bio_noacct+0xbe/0x2d0
>> [ 4549.860512]  kcryptd_crypt+0x3a8/0x5a0 [dm_crypt]
>> [ 4549.860517]  process_one_work+0x1d3/0x360
>> [ 4549.860521]  worker_thread+0x4d/0x3b0
>> [ 4549.860523]  ? process_one_work+0x360/0x360
>> [ 4549.860525]  kthread+0x115/0x140
>> [ 4549.860528]  ? set_kthread_struct+0x50/0x50
>> [ 4549.860530]  ret_from_fork+0x1f/0x30
>> [ 4549.860535]  </TASK>
>> [ 4549.860536] INFO: task kworker/u64:23:448 blocked for more than 122 seconds.
>> [ 4549.868461]       Not tainted 5.15.164 #1-NixOS
>> [ 4549.873555] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4549.882358] task:kworker/u64:23  state:D stack:    0 pid:  448 ppid:     2 flags:0x00004000
>> [ 4549.882364] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
>> [ 4549.882368] Call Trace:
>> [ 4549.882369]  <TASK>
>> [ 4549.882370]  __schedule+0x373/0x1580
>> [ 4549.882373]  ? sysvec_apic_timer_interrupt+0xa/0x90
>> [ 4549.882375]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>> [ 4549.882379]  schedule+0x5b/0xe0
>> [ 4549.882382]  md_bitmap_startwrite+0x177/0x1e0
>> [ 4549.882384]  ? finish_wait+0x90/0x90
>> [ 4549.882387]  add_stripe_bio+0x449/0x770 [raid456]
>> [ 4549.882393]  raid5_make_request+0x1cf/0xbd0 [raid456]
>> [ 4549.882397]  ? __bio_clone_fast+0xa5/0xe0
>> [ 4549.882401]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.882403]  ? finish_wait+0x90/0x90
>> [ 4549.882406]  md_handle_request+0x11f/0x1b0
>> [ 4549.882410]  ? blk_throtl_charge_bio_split+0x23/0x60
>> [ 4549.882413]  md_submit_bio+0x6e/0xb0
>> [ 4549.882415]  __submit_bio+0x18c/0x220
>> [ 4549.882417]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.882419]  ? crypt_page_alloc+0x46/0x60 [dm_crypt]
>> [ 4549.882421]  submit_bio_noacct+0xbe/0x2d0
>> [ 4549.882424]  kcryptd_crypt+0x3a8/0x5a0 [dm_crypt]
>> [ 4549.882428]  process_one_work+0x1d3/0x360
>> [ 4549.882431]  worker_thread+0x4d/0x3b0
>> [ 4549.882433]  ? process_one_work+0x360/0x360
>> [ 4549.882435]  kthread+0x115/0x140
>> [ 4549.882436]  ? set_kthread_struct+0x50/0x50
>> [ 4549.882438]  ret_from_fork+0x1f/0x30
>> [ 4549.882442]  </TASK>
>> [ 4549.882497] INFO: task .backy-wrapped:2578 blocked for more than 122 seconds.
>> [ 4549.890517]       Not tainted 5.15.164 #1-NixOS
>> [ 4549.895611] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4549.904406] task:.backy-wrapped  state:D stack:    0 pid: 2578 ppid:     1 flags:0x00000002
>> [ 4549.904411] Call Trace:
>> [ 4549.904412]  <TASK>
>> [ 4549.904414]  __schedule+0x373/0x1580
>> [ 4549.904419]  ? xlog_cil_commit+0x556/0x880 [xfs]
>> [ 4549.904465]  ? __xfs_trans_commit+0xac/0x2f0 [xfs]
>> [ 4549.904498]  schedule+0x5b/0xe0
>> [ 4549.904500]  io_schedule+0x42/0x70
>> [ 4549.904503]  wait_on_page_bit_common+0x119/0x380
>> [ 4549.904507]  ? __page_cache_alloc+0x80/0x80
>> [ 4549.904510]  wait_on_page_writeback+0x22/0x70
>> [ 4549.904513]  truncate_inode_pages_range+0x26f/0x6d0
>> [ 4549.904520]  evict+0x15f/0x180
>> [ 4549.904524]  __dentry_kill+0xde/0x170
>> [ 4549.904527]  dput+0x139/0x320
>> [ 4549.904529]  do_renameat2+0x375/0x5f0
>> [ 4549.904536]  __x64_sys_rename+0x3f/0x50
>> [ 4549.904538]  do_syscall_64+0x34/0x80
>> [ 4549.904541]  entry_SYSCALL_64_after_hwframe+0x6c/0xd6
>> [ 4549.904544] RIP: 0033:0x7fbf3e61a75b
>> [ 4549.904545] RSP: 002b:00007ffc61e25988 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
>> [ 4549.904548] RAX: ffffffffffffffda RBX: 00007ffc61e25a20 RCX: 00007fbf3e61a75b
>> [ 4549.904549] RDX: 0000000000000000 RSI: 00007fbf2f7ff150 RDI: 00007fbf2f7fc190
>> [ 4549.904550] RBP: 00007ffc61e259d0 R08: 00000000ffffffff R09: 0000000000000000
>> [ 4549.904551] R10: 00007ffc61e25c00 R11: 0000000000000246 R12: 00000000ffffff9c
>> [ 4549.904552] R13: 00000000ffffff9c R14: 00000000016afab0 R15: 00007fbf30ef0810
>> [ 4549.904555]  </TASK>
>> [ 4549.904556] INFO: task kworker/u64:0:4372 blocked for more than 122 seconds.
>> [ 4549.912477]       Not tainted 5.15.164 #1-NixOS
>> [ 4549.917573] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4549.926373] task:kworker/u64:0   state:D stack:    0 pid: 4372 ppid:     2 flags:0x00004000
>> [ 4549.926376] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
>> [ 4549.926380] Call Trace:
>> [ 4549.926381]  <TASK>
>> [ 4549.926383]  __schedule+0x373/0x1580
>> [ 4549.926386]  ? sysvec_apic_timer_interrupt+0xa/0x90
>> [ 4549.926389]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>> [ 4549.926392]  schedule+0x5b/0xe0
>> [ 4549.926394]  md_bitmap_startwrite+0x177/0x1e0
>> [ 4549.926397]  ? finish_wait+0x90/0x90
>> [ 4549.926401]  add_stripe_bio+0x449/0x770 [raid456]
>> [ 4549.926406]  raid5_make_request+0x1cf/0xbd0 [raid456]
>> [ 4549.926410]  ? __bio_clone_fast+0xa5/0xe0
>> [ 4549.926413]  ? finish_wait+0x90/0x90
>> [ 4549.926415]  ? __blk_queue_split+0x2d0/0x580
>> [ 4549.926418]  md_handle_request+0x11f/0x1b0
>> [ 4549.926422]  md_submit_bio+0x6e/0xb0
>> [ 4549.926424]  __submit_bio+0x18c/0x220
>> [ 4549.926426]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.926428]  ? crypt_page_alloc+0x46/0x60 [dm_crypt]
>> [ 4549.926431]  submit_bio_noacct+0xbe/0x2d0
>> [ 4549.926434]  kcryptd_crypt+0x3a8/0x5a0 [dm_crypt]
>> [ 4549.926437]  process_one_work+0x1d3/0x360
>> [ 4549.926441]  worker_thread+0x4d/0x3b0
>> [ 4549.926442]  ? process_one_work+0x360/0x360
>> [ 4549.926444]  kthread+0x115/0x140
>> [ 4549.926447]  ? set_kthread_struct+0x50/0x50
>> [ 4549.926448]  ret_from_fork+0x1f/0x30
>> [ 4549.926454]  </TASK>
>> [ 4549.926459] INFO: task rsync:4929 blocked for more than 122 seconds.
>> [ 4549.933603]       Not tainted 5.15.164 #1-NixOS
>> [ 4549.938702] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4549.947501] task:rsync           state:D stack:    0 pid: 4929 ppid:  4925 flags:0x00000000
>> [ 4549.947503] Call Trace:
>> [ 4549.947505]  <TASK>
>> [ 4549.947505]  ? usleep_range_state+0x90/0x90
>> [ 4549.947510]  __schedule+0x373/0x1580
>> [ 4549.947513]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.947515]  ? blk_mq_sched_insert_requests+0x97/0xe0
>> [ 4549.947519]  ? usleep_range_state+0x90/0x90
>> [ 4549.947521]  schedule+0x5b/0xe0
>> [ 4549.947523]  schedule_timeout+0xff/0x130
>> [ 4549.947526]  __wait_for_common+0xaf/0x160
>> [ 4549.947530]  xfs_buf_iowait+0x1c/0xa0 [xfs]
>> [ 4549.947573]  __xfs_buf_submit+0x109/0x1b0 [xfs]
>> [ 4549.947604]  xfs_buf_read_map+0x120/0x280 [xfs]
>> [ 4549.947635]  ? xfs_btree_read_buf_block.constprop.0+0xae/0xf0 [xfs]
>> [ 4549.947670]  xfs_trans_read_buf_map+0x156/0x2c0 [xfs]
>> [ 4549.947705]  ? xfs_btree_read_buf_block.constprop.0+0xae/0xf0 [xfs]
>> [ 4549.947735]  xfs_btree_read_buf_block.constprop.0+0xae/0xf0 [xfs]
>> [ 4549.947764]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.947766]  xfs_btree_lookup_get_block+0xa2/0x180 [xfs]
>> [ 4549.947798]  xfs_btree_lookup+0xe9/0x540 [xfs]
>> [ 4549.947830]  xfs_alloc_lookup_eq+0x1d/0x30 [xfs]
>> [ 4549.947863]  xfs_alloc_fixup_trees+0xe7/0x3b0 [xfs]
>> [ 4549.947893]  xfs_alloc_cur_finish+0x2b/0xa0 [xfs]
>> [ 4549.947923]  xfs_alloc_ag_vextent_near.constprop.0+0x3f2/0x4a0 [xfs]
>> [ 4549.947954]  xfs_alloc_ag_vextent+0x13f/0x150 [xfs]
>> [ 4549.947983]  xfs_alloc_vextent+0x327/0x450 [xfs]
>> [ 4549.948013]  xfs_bmap_btalloc+0x44e/0x830 [xfs]
>> [ 4549.948047]  xfs_bmapi_allocate+0xda/0x300 [xfs]
>> [ 4549.948076]  xfs_bmapi_write+0x4ab/0x570 [xfs]
>> [ 4549.948109]  xfs_da_grow_inode_int+0xd8/0x320 [xfs]
>> [ 4549.948141]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.948142]  ? xfs_da_read_buf+0xf7/0x150 [xfs]
>> [ 4549.948171]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.948174]  xfs_dir2_grow_inode+0x68/0x120 [xfs]
>> [ 4549.948204]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.948206]  xfs_dir2_node_addname+0x5ea/0x9e0 [xfs]
>> [ 4549.948241]  xfs_dir_createname+0x1cf/0x1e0 [xfs]
>> [ 4549.948271]  xfs_rename+0x87e/0xcd0 [xfs]
>> [ 4549.948308]  xfs_vn_rename+0xfa/0x170 [xfs]
>> [ 4549.948340]  vfs_rename+0x818/0x10d0
>> [ 4549.948345]  ? lookup_dcache+0x17/0x60
>> [ 4549.948348]  ? do_renameat2+0x57f/0x5f0
>> [ 4549.948350]  do_renameat2+0x57f/0x5f0
>> [ 4549.948355]  __x64_sys_rename+0x3f/0x50
>> [ 4549.948357]  do_syscall_64+0x34/0x80
>> [ 4549.948360]  entry_SYSCALL_64_after_hwframe+0x6c/0xd6
>> [ 4549.948362] RIP: 0033:0x7fcc5520c1d7
>> [ 4549.948364] RSP: 002b:00007ffe3909c748 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
>> [ 4549.948366] RAX: ffffffffffffffda RBX: 00007ffe3909c8f0 RCX: 00007fcc5520c1d7
>> [ 4549.948367] RDX: 0000000000000000 RSI: 00007ffe3909c8f0 RDI: 00007ffe3909e8f0
>> [ 4549.948368] RBP: 00007ffe3909e8f0 R08: 0000000000000000 R09: 00007ffe3909c2f8
>> [ 4549.948369] R10: 00007ffe3909c2f7 R11: 0000000000000246 R12: 0000000000000000
>> [ 4549.948370] R13: 00000000023c9c30 R14: 00000000000081a4 R15: 0000000000000004
>> [ 4549.948373]  </TASK>
>> [ 4549.948374] INFO: task kworker/u64:1:4930 blocked for more than 122 seconds.
>> [ 4549.956299]       Not tainted 5.15.164 #1-NixOS
>> [ 4549.961396] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4549.970198] task:kworker/u64:1   state:D stack:    0 pid: 4930 ppid:     2 flags:0x00004000
>> [ 4549.970202] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
>> [ 4549.970205] Call Trace:
>> [ 4549.970206]  <TASK>
>> [ 4549.970209]  __schedule+0x373/0x1580
>> [ 4549.970211]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.970215]  schedule+0x5b/0xe0
>> [ 4549.970217]  md_bitmap_startwrite+0x177/0x1e0
>> [ 4549.970219]  ? finish_wait+0x90/0x90
>> [ 4549.970223]  add_stripe_bio+0x449/0x770 [raid456]
>> [ 4549.970229]  raid5_make_request+0x1cf/0xbd0 [raid456]
>> [ 4549.970232]  ? kmem_cache_alloc_node_trace+0x341/0x3e0
>> [ 4549.970236]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.970238]  ? linear_map+0x44/0x90 [dm_mod]
>> [ 4549.970244]  ? finish_wait+0x90/0x90
>> [ 4549.970245]  ? __blk_queue_split+0x516/0x580
>> [ 4549.970248]  md_handle_request+0x11f/0x1b0
>> [ 4549.970251]  md_submit_bio+0x6e/0xb0
>> [ 4549.970254]  __submit_bio+0x18c/0x220
>> [ 4549.970256]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.970258]  ? crypt_page_alloc+0x46/0x60 [dm_crypt]
>> [ 4549.970260]  submit_bio_noacct+0xbe/0x2d0
>> [ 4549.970263]  kcryptd_crypt+0x3a8/0x5a0 [dm_crypt]
>> [ 4549.970267]  process_one_work+0x1d3/0x360
>> [ 4549.970270]  worker_thread+0x4d/0x3b0
>> [ 4549.970272]  ? process_one_work+0x360/0x360
>> [ 4549.970274]  kthread+0x115/0x140
>> [ 4549.970276]  ? set_kthread_struct+0x50/0x50
>> [ 4549.970278]  ret_from_fork+0x1f/0x30
>> [ 4549.970282]  </TASK>
>> [ 4549.970284] INFO: task kworker/u64:2:4949 blocked for more than 123 seconds.
>> [ 4549.978205]       Not tainted 5.15.164 #1-NixOS
>> [ 4549.983290] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4549.992088] task:kworker/u64:2   state:D stack:    0 pid: 4949 ppid:     2 flags:0x00004000
>> [ 4549.992093] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
>> [ 4549.992097] Call Trace:
>> [ 4549.992098]  <TASK>
>> [ 4549.992100]  __schedule+0x373/0x1580
>> [ 4549.992103]  ? sysvec_apic_timer_interrupt+0xa/0x90
>> [ 4549.992106]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>> [ 4549.992109]  schedule+0x5b/0xe0
>> [ 4549.992111]  md_bitmap_startwrite+0x177/0x1e0
>> [ 4549.992114]  ? finish_wait+0x90/0x90
>> [ 4549.992117]  add_stripe_bio+0x449/0x770 [raid456]
>> [ 4549.992122]  raid5_make_request+0x1cf/0xbd0 [raid456]
>> [ 4549.992125]  ? kmem_cache_alloc+0x261/0x3b0
>> [ 4549.992129]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.992131]  ? linear_map+0x44/0x90 [dm_mod]
>> [ 4549.992135]  ? finish_wait+0x90/0x90
>> [ 4549.992137]  ? __blk_queue_split+0x516/0x580
>> [ 4549.992139]  md_handle_request+0x11f/0x1b0
>> [ 4549.992142]  md_submit_bio+0x6e/0xb0
>> [ 4549.992144]  __submit_bio+0x18c/0x220
>> [ 4549.992146]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4549.992148]  ? crypt_page_alloc+0x46/0x60 [dm_crypt]
>> [ 4549.992150]  submit_bio_noacct+0xbe/0x2d0
>> [ 4549.992153]  kcryptd_crypt+0x3a8/0x5a0 [dm_crypt]
>> [ 4549.992157]  process_one_work+0x1d3/0x360
>> [ 4549.992160]  worker_thread+0x4d/0x3b0
>> [ 4549.992162]  ? process_one_work+0x360/0x360
>> [ 4549.992163]  kthread+0x115/0x140
>> [ 4549.992166]  ? set_kthread_struct+0x50/0x50
>> [ 4549.992168]  ret_from_fork+0x1f/0x30
>> [ 4549.992172]  </TASK>
>> [ 4549.992174] INFO: task kworker/u64:5:4952 blocked for more than 123 seconds.
>> [ 4550.000095]       Not tainted 5.15.164 #1-NixOS
>> [ 4550.005187] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4550.013985] task:kworker/u64:5   state:D stack:    0 pid: 4952 ppid:     2 flags:0x00004000
>> [ 4550.013988] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
>> [ 4550.013992] Call Trace:
>> [ 4550.013993]  <TASK>
>> [ 4550.013995]  __schedule+0x373/0x1580
>> [ 4550.013997]  ? sysvec_apic_timer_interrupt+0xa/0x90
>> [ 4550.014000]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>> [ 4550.014003]  schedule+0x5b/0xe0
>> [ 4550.014005]  md_bitmap_startwrite+0x177/0x1e0
>> [ 4550.014008]  ? finish_wait+0x90/0x90
>> [ 4550.014010]  add_stripe_bio+0x449/0x770 [raid456]
>> [ 4550.014015]  raid5_make_request+0x1cf/0xbd0 [raid456]
>> [ 4550.014018]  ? __bio_clone_fast+0xa5/0xe0
>> [ 4550.014022]  ? finish_wait+0x90/0x90
>> [ 4550.014024]  ? __blk_queue_split+0x2d0/0x580
>> [ 4550.014027]  md_handle_request+0x11f/0x1b0
>> [ 4550.014030]  md_submit_bio+0x6e/0xb0
>> [ 4550.014032]  __submit_bio+0x18c/0x220
>> [ 4550.014034]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4550.014036]  ? crypt_page_alloc+0x46/0x60 [dm_crypt]
>> [ 4550.014038]  submit_bio_noacct+0xbe/0x2d0
>> [ 4550.014041]  kcryptd_crypt+0x3a8/0x5a0 [dm_crypt]
>> [ 4550.014044]  process_one_work+0x1d3/0x360
>> [ 4550.014047]  worker_thread+0x4d/0x3b0
>> [ 4550.014049]  ? process_one_work+0x360/0x360
>> [ 4550.014050]  kthread+0x115/0x140
>> [ 4550.014052]  ? set_kthread_struct+0x50/0x50
>> [ 4550.014054]  ret_from_fork+0x1f/0x30
>> [ 4550.014058]  </TASK>
>> [ 4550.014059] INFO: task kworker/u64:8:4954 blocked for more than 123 seconds.
>> [ 4550.021982]       Not tainted 5.15.164 #1-NixOS
>> [ 4550.027078] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4550.035881] task:kworker/u64:8   state:D stack:    0 pid: 4954 ppid:     2 flags:0x00004000
>> [ 4550.035884] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
>> [ 4550.035887] Call Trace:
>> [ 4550.035888]  <TASK>
>> [ 4550.035890]  __schedule+0x373/0x1580
>> [ 4550.035893]  ? sysvec_apic_timer_interrupt+0xa/0x90
>> [ 4550.035896]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>> [ 4550.035899]  schedule+0x5b/0xe0
>> [ 4550.035901]  md_bitmap_startwrite+0x177/0x1e0
>> [ 4550.035904]  ? finish_wait+0x90/0x90
>> [ 4550.035907]  add_stripe_bio+0x449/0x770 [raid456]
>> [ 4550.035912]  raid5_make_request+0x1cf/0xbd0 [raid456]
>> [ 4550.035916]  ? __bio_clone_fast+0xa5/0xe0
>> [ 4550.035919]  ? finish_wait+0x90/0x90
>> [ 4550.035921]  ? __blk_queue_split+0x2d0/0x580
>> [ 4550.035924]  md_handle_request+0x11f/0x1b0
>> [ 4550.035927]  md_submit_bio+0x6e/0xb0
>> [ 4550.035929]  __submit_bio+0x18c/0x220
>> [ 4550.035931]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4550.035933]  ? crypt_page_alloc+0x46/0x60 [dm_crypt]
>> [ 4550.035936]  submit_bio_noacct+0xbe/0x2d0
>> [ 4550.035939]  kcryptd_crypt+0x3a8/0x5a0 [dm_crypt]
>> [ 4550.035942]  process_one_work+0x1d3/0x360
>> [ 4550.035946]  worker_thread+0x4d/0x3b0
>> [ 4550.035948]  ? process_one_work+0x360/0x360
>> [ 4550.035949]  kthread+0x115/0x140
>> [ 4550.035951]  ? set_kthread_struct+0x50/0x50
>> [ 4550.035953]  ret_from_fork+0x1f/0x30
>> [ 4550.035957]  </TASK>
>> [ 4550.035958] INFO: task kworker/u64:9:4955 blocked for more than 123 seconds.
>> [ 4550.043881]       Not tainted 5.15.164 #1-NixOS
>> [ 4550.048979] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4550.057786] task:kworker/u64:9   state:D stack:    0 pid: 4955 ppid:     2 flags:0x00004000
>> [ 4550.057790] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
>> [ 4550.057794] Call Trace:
>> [ 4550.057796]  <TASK>
>> [ 4550.057798]  __schedule+0x373/0x1580
>> [ 4550.057801]  ? sysvec_apic_timer_interrupt+0xa/0x90
>> [ 4550.057803]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>> [ 4550.057806]  schedule+0x5b/0xe0
>> [ 4550.057808]  md_bitmap_startwrite+0x177/0x1e0
>> [ 4550.057810]  ? finish_wait+0x90/0x90
>> [ 4550.057813]  add_stripe_bio+0x449/0x770 [raid456]
>> [ 4550.057818]  raid5_make_request+0x1cf/0xbd0 [raid456]
>> [ 4550.057821]  ? __bio_clone_fast+0xa5/0xe0
>> [ 4550.057824]  ? finish_wait+0x90/0x90
>> [ 4550.057826]  ? __blk_queue_split+0x2d0/0x580
>> [ 4550.057828]  md_handle_request+0x11f/0x1b0
>> [ 4550.057831]  md_submit_bio+0x6e/0xb0
>> [ 4550.057834]  __submit_bio+0x18c/0x220
>> [ 4550.057835]  ? srso_alias_return_thunk+0x5/0x7f
>> [ 4550.057837]  ? crypt_page_alloc+0x46/0x60 [dm_crypt]
>> [ 4550.057839]  submit_bio_noacct+0xbe/0x2d0
>> [ 4550.057842]  kcryptd_crypt+0x3a8/0x5a0 [dm_crypt]
>> [ 4550.057846]  process_one_work+0x1d3/0x360
>> [ 4550.057848]  worker_thread+0x4d/0x3b0
>> [ 4550.057850]  ? process_one_work+0x360/0x360
>> [ 4550.057852]  kthread+0x115/0x140
>> [ 4550.057854]  ? set_kthread_struct+0x50/0x50
>> [ 4550.057856]  ret_from_fork+0x1f/0x30
>> [ 4550.057860]  </TASK>
> 
> 
>>> On 7. Aug 2024, at 08:46, Christian Theune <ct@flyingcircus.io> wrote:
>>>
>>> I tried updating to 5.15.164, but have to struggle against our config management as some options have been shifted that I need to filter out: NFSD_V3 and NFSD2_ACL are now fixed and cause config errors if set - I guess that’s a valid thing to happen within an LTS release. I’ll try again on Friday
>>>
>>>> On 7. Aug 2024, at 07:31, Christian Theune <ct@flyingcircus.io> wrote:
>>>>
>>>> Sure,
>>>>
>>>> would you prefer me testing on 5.15.x or something else?
>>>>
>>>>> On 7. Aug 2024, at 04:55, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> 在 2024/08/06 22:10, Christian Theune 写道:
>>>>>> we are seeing an issue that can be triggered with relative ease on a server that has been working fine for a few weeks. The regular workload is a backup utility that copies off data from virtual disk images in 4MiB (compressed) chunks from Ceph onto a local NVME-based RAID-6 array that is encrypted using LUKS.
>>>>>> Today I started a larger rsync job from another server (that has a couple of million files with around 200-300 gib in total) to migrate data and we’ve seen the server suddenly lock up twice. Any IO that interacts with the mountpoint (/srv/backy) will hang indefinitely. A reset is required to get out of this as the machine will hang trying to unmount the affected filesystem. No other messages than the hung tasks are being presented - I have no indicator for hardware faults at the moment.
>>>>>> I’m messaging both dm-devel and linux-raid as I’m suspecting either one or both (or an interaction) might be the cause.
>>>>>> Kernel:
>>>>>> Linux version 5.15.138 (nixbld@localhost) (gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP Wed Nov 8 16:26:52 UTC 2023
>>>>>
>>>>> Since you can trigger this easily, I'll suggest you to try the latest
>>>>> kernel release first.
>>>>>
>>>>> Thanks,
>>>>> Kuai
>>>>>
>>>>>> See the kernel config attached.
>>>>
>>>>
>>>> Liebe Grüße,
>>>> Christian Theune
>>>>
>>>> -- 
>>>> Christian Theune · ct@flyingcircus.io · +49 345 219401 0
>>>> Flying Circus Internet Operations GmbH · https://flyingcircus.io
>>>> Leipziger Str. 70/71 · 06108 Halle (Saale) · Deutschland
>>>> HR Stendal HRB 21169 · Geschäftsführer: Christian Theune, Christian Zagrodnick
>>>>
>>>>
>>>
>>> Liebe Grüße,
>>> Christian Theune
>>>
>>> -- 
>>> Christian Theune · ct@flyingcircus.io · +49 345 219401 0
>>> Flying Circus Internet Operations GmbH · https://flyingcircus.io
>>> Leipziger Str. 70/71 · 06108 Halle (Saale) · Deutschland
>>> HR Stendal HRB 21169 · Geschäftsführer: Christian Theune, Christian Zagrodnick
>>>
> 
>> Liebe Grüße,
>> Christian Theune
> 
>> -- 
>> Christian Theune · ct@flyingcircus.io · +49 345 219401 0
>> Flying Circus Internet Operations GmbH · https://flyingcircus.io
>> Leipziger Str. 70/71 · 06108 Halle (Saale) · Deutschland
>> HR Stendal HRB 21169 · Geschäftsführer: Christian Theune, Christian Zagrodnick
> 
> 
> 
> .
> 


