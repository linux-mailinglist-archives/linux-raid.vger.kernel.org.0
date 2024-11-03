Return-Path: <linux-raid+bounces-3091-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899169BA678
	for <lists+linux-raid@lfdr.de>; Sun,  3 Nov 2024 16:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FEB6B2123B
	for <lists+linux-raid@lfdr.de>; Sun,  3 Nov 2024 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43761183CBE;
	Sun,  3 Nov 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="CYO3SNmJ"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC75171A7
	for <linux-raid@vger.kernel.org>; Sun,  3 Nov 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730649309; cv=none; b=TAuj4hV+oAz2ljTtt94pJ6wgvO2eVlgQTG9raTXgWfrX/rSAYr3zcQxtXUy7e+1OlGXK0PxIe8LaMJ8tyqNLGB85xcz9AGtTjtn9AgPku/onwbifH+xhILQnPbmeFk8ZKNWPNripv7Iyj/vuowuU09vV2bf6HQ9FvHECn3zEzwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730649309; c=relaxed/simple;
	bh=QobNRYHNiPSReFp6feXtTc+KJOmHaTnNTaWvbqc0NSo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eiownP9o6KJVKB7CDFHIjoufUX1K9J6QjJcs3ZpeJxagZp1laQ+kYLi6Mjf8cTBkpzIr3VjRZZ7kLYz9qXD5e7YTacV4eC8Mi707NA3Uf9XoMZBsYGoqqDeVugFRCAfuzmXIG24LnG8xW8VhpVxS1wwAfzJJz1bZ9oM7g3UbMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=CYO3SNmJ; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1730649285;
	bh=H14id28IuZznnAdSKOck4E5JLbGhH2JrFW2ykoH10wQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=CYO3SNmJZvrJvKE85cEbg80DgFhyAEfbhQ0O5HVtszWks48gH3DXSVYggmQjsUiAE
	 uN/DrSKWB8Kyn567arZXv5SBKMspPSH8Ot0KcplHMaEa1TTcvePkEYqiQ/D5bj0tay
	 jsn+ZVCtY4z6EtjVnx3WBAKgqAd+A9Wh32kpQsqs=
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: PROBLEM: repeatable lockup on RAID-6 with LUKS dm-crypt on NVMe
 devices when rsyncing many files
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <B6D76C57-B940-4BFD-9C40-D6E463D2A09F@flyingcircus.io>
Date: Sun, 3 Nov 2024 16:54:21 +0100
Cc: John Stoffel <john@stoffel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 dm-devel@lists.linux.dev,
 =?utf-8?Q?Dragan_Milivojevi=C4=87?= <galileo@pkm-inc.com>,
 "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <87E347A1-059E-4F0B-865D-6862EEBE0C64@flyingcircus.io>
References: <ADF7D720-5764-4AF3-B68E-1845988737AA@flyingcircus.io>
 <143E09BF-BD10-43EB-B0F1-7421F8200DB1@flyingcircus.io>
 <1bbc86a8-1abf-11a1-e724-b6868a8d9f88@huaweicloud.com>
 <69D8A311-E619-40C2-985A-FB15D0336ADE@flyingcircus.io>
 <CALtW_agiOj2PJ_vsWym0qR8w1Q9iotHKPGuP5RohktkqeXt2mw@mail.gmail.com>
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
To: Yu Kuai <yukuai1@huaweicloud.com>

Hi,

running without the debug patch again on 6.11.5 I=E2=80=99m still able =
to reproduce with bitmap enabled. I=E2=80=99ve gathered the full list of =
all stuck tasks.

Just as a reminder on the setup, the layering here is:

nvme drives =E2=86=92 mdraid =E2=86=92 lvm =E2=86=92 dmcrypt =E2=86=92 =
xfs=20

Any ideas how to get better debugging output for you different than the =
printk strategy as that seems to cause the (likely) race condition not =
to trigger =E2=80=A6 ?

Christian

The first message came in around:

[91177.798820] INFO: task kworker/u129:22:381874 blocked for more than =
122 seconds.
[91177.807148]       Not tainted 6.11.5 #1-NixOS
[91177.812050] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
[91177.820854] task:kworker/u129:22 state:D stack:0     pid:381874 =
tgid:381874 ppid:2      flags:0x00004000
[91177.820861] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[91177.820871] Call Trace:
[91177.820872]  <TASK>
[91177.820877]  __schedule+0x425/0x1460
[91177.820886]  schedule+0x27/0xf0
[91177.820889]  md_bitmap_startwrite+0x14f/0x1c0
[91177.820895]  ? __pfx_autoremove_wake_function+0x10/0x10
[91177.820901]  __add_stripe_bio+0x1f4/0x240 [raid456]
[91177.820908]  raid5_make_request+0x364/0x1290 [raid456]
[91177.820915]  ? srso_alias_return_thunk+0x5/0xfbef5
[91177.820918]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[91177.820923]  ? __pfx_woken_wake_function+0x10/0x10
[91177.820926]  ? bio_split_rw+0x141/0x2a0
[91177.820931]  md_handle_request+0x153/0x270
[91177.820935]  ? srso_alias_return_thunk+0x5/0xfbef5
[91177.820938]  __submit_bio+0x190/0x240
[91177.820942]  submit_bio_noacct_nocheck+0x19a/0x3c0
[91177.820945]  ? srso_alias_return_thunk+0x5/0xfbef5
[91177.820947]  ? submit_bio_noacct+0x47/0x5b0
[91177.820950]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[91177.820954]  process_one_work+0x18f/0x3b0
[91177.820959]  worker_thread+0x21f/0x330
[91177.820962]  ? __pfx_worker_thread+0x10/0x10
[91177.820964]  kthread+0xcd/0x100
[91177.820967]  ? __pfx_kthread+0x10/0x10
[91177.820970]  ret_from_fork+0x31/0x50
[91177.820974]  ? __pfx_kthread+0x10/0x10
[91177.820977]  ret_from_fork_asm+0x1a/0x30
[91177.820982]  </TASK>

And I received the current blocked state of all stuck processes just =
now:

[168277.817543] sysrq: Show Blocked State
[168277.822017] task:xfsaild/dm-4    state:D stack:0     pid:2118  =
tgid:2118  ppid:2      flags:0x00004000
[168277.822022] Call Trace:
[168277.822024]  <TASK>
[168277.822030]  __schedule+0x425/0x1460
[168277.822038]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.822044]  schedule+0x27/0xf0
[168277.822046]  schedule_timeout+0x9e/0x170
[168277.822050]  ? __pfx_process_timeout+0x10/0x10
[168277.822057]  xfsaild+0xc0/0xa40 [xfs]
[168277.822158]  ? __pfx_xfsaild+0x10/0x10 [xfs]
[168277.822230]  ? __pfx_xfsaild+0x10/0x10 [xfs]
[168277.822299]  kthread+0xcd/0x100
[168277.822304]  ? __pfx_kthread+0x10/0x10
[168277.822307]  ret_from_fork+0x31/0x50
[168277.822311]  ? __pfx_kthread+0x10/0x10
[168277.822314]  ret_from_fork_asm+0x1a/0x30
[168277.822320]  </TASK>
[168277.822362] task:kworker/u129:22 state:D stack:0     pid:381874 =
tgid:381874 ppid:2      flags:0x00004000
[168277.822366] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.822373] Call Trace:
[168277.822374]  <TASK>
[168277.822376]  __schedule+0x425/0x1460
[168277.822382]  schedule+0x27/0xf0
[168277.822385]  md_bitmap_startwrite+0x14f/0x1c0
[168277.822389]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.822394]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.822402]  raid5_make_request+0x364/0x1290 [raid456]
[168277.822409]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.822410]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.822415]  ? __pfx_woken_wake_function+0x10/0x10
[168277.822418]  ? bio_split_rw+0x141/0x2a0
[168277.822423]  md_handle_request+0x153/0x270
[168277.822428]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.822430]  __submit_bio+0x190/0x240
[168277.822435]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.822438]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.822439]  ? submit_bio_noacct+0x47/0x5b0
[168277.822443]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.822446]  process_one_work+0x18f/0x3b0
[168277.822451]  worker_thread+0x21f/0x330
[168277.822453]  ? __pfx_worker_thread+0x10/0x10
[168277.822455]  kthread+0xcd/0x100
[168277.822458]  ? __pfx_kthread+0x10/0x10
[168277.822460]  ret_from_fork+0x31/0x50
[168277.822463]  ? __pfx_kthread+0x10/0x10
[168277.822465]  ret_from_fork_asm+0x1a/0x30
[168277.822469]  </TASK>
[168277.822471] task:kworker/u129:13 state:D stack:0     pid:389003 =
tgid:389003 ppid:2      flags:0x00004000
[168277.822475] Workqueue: writeback wb_workfn (flush-253:4)
[168277.822479] Call Trace:
[168277.822480]  <TASK>
[168277.822482]  __schedule+0x425/0x1460
[168277.822485]  ? xfs_trans_add_item+0x37/0xb0 [xfs]
[168277.822566]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.822570]  schedule+0x27/0xf0
[168277.822573]  schedule_timeout+0x15d/0x170
[168277.822576]  __down_common+0x119/0x220
[168277.822579]  ? xfs_buf_lock+0x31/0xe0 [xfs]
[168277.822675]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.822678]  down+0x47/0x60
[168277.822680]  xfs_buf_lock+0x31/0xe0 [xfs]
[168277.822752]  xfs_buf_find_lock+0x55/0x100 [xfs]
[168277.822822]  xfs_buf_get_map+0x1ea/0xa80 [xfs]
[168277.822891]  ? down+0x1e/0x60
[168277.822895]  xfs_buf_read_map+0x62/0x2a0 [xfs]
[168277.822967]  ? xfs_btree_read_buf_block+0xa7/0x120 [xfs]
[168277.823058]  xfs_trans_read_buf_map+0x12e/0x310 [xfs]
[168277.823145]  ? xfs_btree_read_buf_block+0xa7/0x120 [xfs]
[168277.823226]  xfs_btree_read_buf_block+0xa7/0x120 [xfs]
[168277.823297]  xfs_btree_lookup_get_block+0xa6/0x1f0 [xfs]
[168277.823368]  xfs_btree_lookup+0xea/0x500 [xfs]
[168277.823438]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.823442]  xfs_alloc_ag_vextent_locality+0xcc/0x450 [xfs]
[168277.823525]  xfs_alloc_ag_vextent_near+0x2cb/0x540 [xfs]
[168277.823598]  xfs_alloc_vextent_iterate_ags.constprop.0+0xc8/0x200 =
[xfs]
[168277.823672]  ? xfs_buf_item_format+0x1b8/0x450 [xfs]
[168277.823760]  xfs_alloc_vextent_start_ag+0xc0/0x190 [xfs]
[168277.823834]  xfs_bmap_btalloc+0x4dd/0x640 [xfs]
[168277.823915]  xfs_bmapi_allocate+0xac/0x2c0 [xfs]
[168277.823985]  xfs_bmapi_convert_one_delalloc+0x1f6/0x430 [xfs]
[168277.824059]  xfs_bmapi_convert_delalloc+0x43/0x60 [xfs]
[168277.824128]  xfs_map_blocks+0x257/0x420 [xfs]
[168277.824219]  iomap_writepages+0x271/0x9b0
[168277.824225]  xfs_vm_writepages+0x67/0x90 [xfs]
[168277.824298]  do_writepages+0x76/0x260
[168277.824304]  __writeback_single_inode+0x3d/0x350
[168277.824308]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824309]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824312]  writeback_sb_inodes+0x21c/0x4e0
[168277.824323]  __writeback_inodes_wb+0x4c/0xf0
[168277.824324]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824327]  wb_writeback+0x193/0x310
[168277.824330]  wb_workfn+0x357/0x450
[168277.824335]  process_one_work+0x18f/0x3b0
[168277.824338]  worker_thread+0x21f/0x330
[168277.824340]  ? __pfx_worker_thread+0x10/0x10
[168277.824342]  kthread+0xcd/0x100
[168277.824345]  ? __pfx_kthread+0x10/0x10
[168277.824347]  ret_from_fork+0x31/0x50
[168277.824350]  ? __pfx_kthread+0x10/0x10
[168277.824352]  ret_from_fork_asm+0x1a/0x30
[168277.824357]  </TASK>
[168277.824359] task:kworker/u129:8  state:D stack:0     pid:401440 =
tgid:401440 ppid:2      flags:0x00004000
[168277.824363] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.824366] Call Trace:
[168277.824367]  <TASK>
[168277.824369]  __schedule+0x425/0x1460
[168277.824375]  schedule+0x27/0xf0
[168277.824377]  md_bitmap_startwrite+0x14f/0x1c0
[168277.824380]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.824383]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.824390]  raid5_make_request+0x364/0x1290 [raid456]
[168277.824396]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824398]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.824401]  ? __pfx_woken_wake_function+0x10/0x10
[168277.824403]  ? bio_split_rw+0x141/0x2a0
[168277.824408]  md_handle_request+0x153/0x270
[168277.824411]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824413]  __submit_bio+0x190/0x240
[168277.824417]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.824420]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824422]  ? submit_bio_noacct+0x47/0x5b0
[168277.824425]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.824429]  process_one_work+0x18f/0x3b0
[168277.824432]  worker_thread+0x21f/0x330
[168277.824434]  ? __pfx_worker_thread+0x10/0x10
[168277.824436]  kthread+0xcd/0x100
[168277.824438]  ? __pfx_kthread+0x10/0x10
[168277.824441]  ret_from_fork+0x31/0x50
[168277.824443]  ? __pfx_kthread+0x10/0x10
[168277.824446]  ret_from_fork_asm+0x1a/0x30
[168277.824450]  </TASK>
[168277.824451] task:kworker/u129:15 state:D stack:0     pid:401443 =
tgid:401443 ppid:2      flags:0x00004000
[168277.824454] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.824457] Call Trace:
[168277.824458]  <TASK>
[168277.824460]  __schedule+0x425/0x1460
[168277.824462]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824465]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824467]  ? raid5_bio_lowest_chunk_sector+0x65/0xe0 [raid456]
[168277.824473]  schedule+0x27/0xf0
[168277.824476]  md_bitmap_startwrite+0x14f/0x1c0
[168277.824478]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.824481]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.824486]  raid5_make_request+0x364/0x1290 [raid456]
[168277.824492]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824494]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.824497]  ? __pfx_woken_wake_function+0x10/0x10
[168277.824499]  ? bio_split_rw+0x141/0x2a0
[168277.824504]  md_handle_request+0x153/0x270
[168277.824506]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824509]  __submit_bio+0x190/0x240
[168277.824513]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.824516]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824517]  ? submit_bio_noacct+0x47/0x5b0
[168277.824521]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.824524]  process_one_work+0x18f/0x3b0
[168277.824526]  worker_thread+0x21f/0x330
[168277.824529]  ? __pfx_worker_thread+0x10/0x10
[168277.824531]  kthread+0xcd/0x100
[168277.824533]  ? __pfx_kthread+0x10/0x10
[168277.824536]  ret_from_fork+0x31/0x50
[168277.824538]  ? __pfx_kthread+0x10/0x10
[168277.824540]  ret_from_fork_asm+0x1a/0x30
[168277.824544]  </TASK>
[168277.824546] task:kworker/u129:19 state:D stack:0     pid:401446 =
tgid:401446 ppid:2      flags:0x00004000
[168277.824549] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.824552] Call Trace:
[168277.824553]  <TASK>
[168277.824555]  __schedule+0x425/0x1460
[168277.824560]  schedule+0x27/0xf0
[168277.824562]  md_bitmap_startwrite+0x14f/0x1c0
[168277.824565]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.824568]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.824573]  raid5_make_request+0x364/0x1290 [raid456]
[168277.824579]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824581]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.824583]  ? __pfx_woken_wake_function+0x10/0x10
[168277.824586]  ? bio_split_rw+0x141/0x2a0
[168277.824590]  md_handle_request+0x153/0x270
[168277.824593]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824595]  __submit_bio+0x190/0x240
[168277.824599]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.824602]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824604]  ? submit_bio_noacct+0x47/0x5b0
[168277.824607]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.824610]  process_one_work+0x18f/0x3b0
[168277.824617]  worker_thread+0x21f/0x330
[168277.824620]  ? __pfx_worker_thread+0x10/0x10
[168277.824622]  kthread+0xcd/0x100
[168277.824625]  ? __pfx_kthread+0x10/0x10
[168277.824628]  ret_from_fork+0x31/0x50
[168277.824630]  ? __pfx_kthread+0x10/0x10
[168277.824632]  ret_from_fork_asm+0x1a/0x30
[168277.824636]  </TASK>
[168277.824638] task:kworker/u129:27 state:D stack:0     pid:401450 =
tgid:401450 ppid:2      flags:0x00004000
[168277.824641] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.824644] Call Trace:
[168277.824645]  <TASK>
[168277.824646]  __schedule+0x425/0x1460
[168277.824652]  schedule+0x27/0xf0
[168277.824655]  md_bitmap_startwrite+0x14f/0x1c0
[168277.824657]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.824660]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.824666]  raid5_make_request+0x364/0x1290 [raid456]
[168277.824672]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824673]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.824677]  ? __pfx_woken_wake_function+0x10/0x10
[168277.824679]  ? bio_split_rw+0x141/0x2a0
[168277.824684]  md_handle_request+0x153/0x270
[168277.824686]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824689]  __submit_bio+0x190/0x240
[168277.824693]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.824696]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824698]  ? submit_bio_noacct+0x47/0x5b0
[168277.824701]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.824704]  process_one_work+0x18f/0x3b0
[168277.824708]  worker_thread+0x21f/0x330
[168277.824710]  ? __pfx_worker_thread+0x10/0x10
[168277.824712]  kthread+0xcd/0x100
[168277.824714]  ? __pfx_kthread+0x10/0x10
[168277.824717]  ret_from_fork+0x31/0x50
[168277.824719]  ? __pfx_kthread+0x10/0x10
[168277.824722]  ret_from_fork_asm+0x1a/0x30
[168277.824726]  </TASK>
[168277.824727] task:kworker/u129:28 state:D stack:0     pid:401451 =
tgid:401451 ppid:2      flags:0x00004000
[168277.824731] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.824733] Call Trace:
[168277.824735]  <TASK>
[168277.824736]  __schedule+0x425/0x1460
[168277.824742]  schedule+0x27/0xf0
[168277.824745]  md_bitmap_startwrite+0x14f/0x1c0
[168277.824747]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.824750]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.824755]  raid5_make_request+0x364/0x1290 [raid456]
[168277.824762]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824763]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.824766]  ? __pfx_woken_wake_function+0x10/0x10
[168277.824768]  ? bio_split_rw+0x141/0x2a0
[168277.824774]  md_handle_request+0x153/0x270
[168277.824776]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824779]  __submit_bio+0x190/0x240
[168277.824783]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.824786]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824788]  ? submit_bio_noacct+0x47/0x5b0
[168277.824791]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.824794]  process_one_work+0x18f/0x3b0
[168277.824797]  worker_thread+0x21f/0x330
[168277.824800]  ? __pfx_worker_thread+0x10/0x10
[168277.824802]  kthread+0xcd/0x100
[168277.824804]  ? __pfx_kthread+0x10/0x10
[168277.824807]  ret_from_fork+0x31/0x50
[168277.824809]  ? __pfx_kthread+0x10/0x10
[168277.824811]  ret_from_fork_asm+0x1a/0x30
[168277.824815]  </TASK>
[168277.824819] task:kworker/u129:4  state:D stack:0     pid:424186 =
tgid:424186 ppid:2      flags:0x00004000
[168277.824822] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.824824] Call Trace:
[168277.824826]  <TASK>
[168277.824827]  __schedule+0x425/0x1460
[168277.824833]  schedule+0x27/0xf0
[168277.824836]  md_bitmap_startwrite+0x14f/0x1c0
[168277.824838]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.824841]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.824847]  raid5_make_request+0x364/0x1290 [raid456]
[168277.824853]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824854]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.824857]  ? __pfx_woken_wake_function+0x10/0x10
[168277.824859]  ? bio_split_rw+0x141/0x2a0
[168277.824864]  md_handle_request+0x153/0x270
[168277.824867]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824869]  __submit_bio+0x190/0x240
[168277.824873]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.824877]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.824878]  ? submit_bio_noacct+0x47/0x5b0
[168277.824882]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.824885]  process_one_work+0x18f/0x3b0
[168277.824887]  worker_thread+0x21f/0x330
[168277.824890]  ? __pfx_worker_thread+0x10/0x10
[168277.824892]  kthread+0xcd/0x100
[168277.824895]  ? __pfx_kthread+0x10/0x10
[168277.824897]  ret_from_fork+0x31/0x50
[168277.824899]  ? __pfx_kthread+0x10/0x10
[168277.824902]  ret_from_fork_asm+0x1a/0x30
[168277.824907]  </TASK>
[168277.824908] task:kworker/u129:16 state:D stack:0     pid:424195 =
tgid:424195 ppid:2      flags:0x00004000
[168277.824911] Workqueue: xfs-cil/dm-4 xlog_cil_push_work [xfs]
[168277.825002] Call Trace:
[168277.825003]  <TASK>
[168277.825005]  __schedule+0x425/0x1460
[168277.825008]  ? __blk_flush_plug+0xf5/0x150
[168277.825013]  schedule+0x27/0xf0
[168277.825016]  xlog_state_get_iclog_space+0x102/0x2b0 [xfs]
[168277.825090]  ? __pfx_default_wake_function+0x10/0x10
[168277.825094]  xlog_write_get_more_iclog_space+0xd0/0x100 [xfs]
[168277.825165]  xlog_write+0x310/0x470 [xfs]
[168277.825237]  xlog_cil_push_work+0x6a5/0x880 [xfs]
[168277.825311]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825314]  process_one_work+0x18f/0x3b0
[168277.825317]  worker_thread+0x21f/0x330
[168277.825319]  ? __pfx_worker_thread+0x10/0x10
[168277.825321]  kthread+0xcd/0x100
[168277.825324]  ? __pfx_kthread+0x10/0x10
[168277.825326]  ret_from_fork+0x31/0x50
[168277.825329]  ? __pfx_kthread+0x10/0x10
[168277.825331]  ret_from_fork_asm+0x1a/0x30
[168277.825336]  </TASK>
[168277.825337] task:kworker/u129:29 state:D stack:0     pid:424199 =
tgid:424199 ppid:2      flags:0x00004000
[168277.825340] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.825343] Call Trace:
[168277.825344]  <TASK>
[168277.825346]  __schedule+0x425/0x1460
[168277.825352]  schedule+0x27/0xf0
[168277.825355]  md_bitmap_startwrite+0x14f/0x1c0
[168277.825357]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.825361]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.825367]  raid5_make_request+0x364/0x1290 [raid456]
[168277.825373]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825375]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.825378]  ? __pfx_woken_wake_function+0x10/0x10
[168277.825380]  ? bio_split_rw+0x141/0x2a0
[168277.825385]  md_handle_request+0x153/0x270
[168277.825389]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825391]  __submit_bio+0x190/0x240
[168277.825395]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.825398]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825400]  ? submit_bio_noacct+0x47/0x5b0
[168277.825403]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.825406]  process_one_work+0x18f/0x3b0
[168277.825409]  worker_thread+0x21f/0x330
[168277.825411]  ? __pfx_worker_thread+0x10/0x10
[168277.825413]  kthread+0xcd/0x100
[168277.825416]  ? __pfx_kthread+0x10/0x10
[168277.825419]  ret_from_fork+0x31/0x50
[168277.825421]  ? __pfx_kthread+0x10/0x10
[168277.825423]  ret_from_fork_asm+0x1a/0x30
[168277.825428]  </TASK>
[168277.825429] task:kworker/u129:0  state:D stack:0     pid:425890 =
tgid:425890 ppid:2      flags:0x00004000
[168277.825432] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.825435] Call Trace:
[168277.825436]  <TASK>
[168277.825438]  __schedule+0x425/0x1460
[168277.825440]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825445]  schedule+0x27/0xf0
[168277.825448]  md_bitmap_startwrite+0x14f/0x1c0
[168277.825450]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.825453]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.825459]  raid5_make_request+0x364/0x1290 [raid456]
[168277.825464]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825466]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.825469]  ? __pfx_woken_wake_function+0x10/0x10
[168277.825472]  ? bio_split_rw+0x141/0x2a0
[168277.825476]  md_handle_request+0x153/0x270
[168277.825479]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825481]  __submit_bio+0x190/0x240
[168277.825486]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.825489]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825490]  ? submit_bio_noacct+0x47/0x5b0
[168277.825494]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.825497]  process_one_work+0x18f/0x3b0
[168277.825500]  worker_thread+0x21f/0x330
[168277.825502]  ? __pfx_worker_thread+0x10/0x10
[168277.825504]  kthread+0xcd/0x100
[168277.825506]  ? __pfx_kthread+0x10/0x10
[168277.825509]  ret_from_fork+0x31/0x50
[168277.825512]  ? __pfx_kthread+0x10/0x10
[168277.825514]  ret_from_fork_asm+0x1a/0x30
[168277.825518]  </TASK>
[168277.825520] task:kworker/u129:1  state:D stack:0     pid:425891 =
tgid:425891 ppid:2      flags:0x00004000
[168277.825523] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.825526] Call Trace:
[168277.825527]  <TASK>
[168277.825528]  __schedule+0x425/0x1460
[168277.825531]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825536]  schedule+0x27/0xf0
[168277.825538]  md_bitmap_startwrite+0x14f/0x1c0
[168277.825541]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.825544]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.825549]  raid5_make_request+0x364/0x1290 [raid456]
[168277.825555]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825557]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.825560]  ? __pfx_woken_wake_function+0x10/0x10
[168277.825563]  ? bio_split_rw+0x141/0x2a0
[168277.825568]  md_handle_request+0x153/0x270
[168277.825570]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825573]  __submit_bio+0x190/0x240
[168277.825577]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.825580]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825582]  ? submit_bio_noacct+0x47/0x5b0
[168277.825585]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.825588]  process_one_work+0x18f/0x3b0
[168277.825591]  worker_thread+0x21f/0x330
[168277.825593]  ? __pfx_worker_thread+0x10/0x10
[168277.825595]  kthread+0xcd/0x100
[168277.825598]  ? __pfx_kthread+0x10/0x10
[168277.825600]  ret_from_fork+0x31/0x50
[168277.825603]  ? __pfx_kthread+0x10/0x10
[168277.825605]  ret_from_fork_asm+0x1a/0x30
[168277.825610]  </TASK>
[168277.825611] task:kworker/u129:2  state:D stack:0     pid:425892 =
tgid:425892 ppid:2      flags:0x00004000
[168277.825618] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.825621] Call Trace:
[168277.825622]  <TASK>
[168277.825623]  __schedule+0x425/0x1460
[168277.825629]  schedule+0x27/0xf0
[168277.825632]  md_bitmap_startwrite+0x14f/0x1c0
[168277.825634]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.825637]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.825643]  raid5_make_request+0x364/0x1290 [raid456]
[168277.825649]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825650]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.825653]  ? __pfx_woken_wake_function+0x10/0x10
[168277.825656]  ? bio_split_rw+0x141/0x2a0
[168277.825661]  md_handle_request+0x153/0x270
[168277.825664]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825666]  __submit_bio+0x190/0x240
[168277.825670]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.825673]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825675]  ? submit_bio_noacct+0x47/0x5b0
[168277.825678]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.825681]  process_one_work+0x18f/0x3b0
[168277.825684]  worker_thread+0x21f/0x330
[168277.825687]  ? __pfx_worker_thread+0x10/0x10
[168277.825689]  kthread+0xcd/0x100
[168277.825691]  ? __pfx_kthread+0x10/0x10
[168277.825694]  ret_from_fork+0x31/0x50
[168277.825696]  ? __pfx_kthread+0x10/0x10
[168277.825698]  ret_from_fork_asm+0x1a/0x30
[168277.825703]  </TASK>
[168277.825704] task:kworker/u129:3  state:D stack:0     pid:425893 =
tgid:425893 ppid:2      flags:0x00004000
[168277.825707] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.825710] Call Trace:
[168277.825711]  <TASK>
[168277.825713]  __schedule+0x425/0x1460
[168277.825715]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825720]  schedule+0x27/0xf0
[168277.825722]  md_bitmap_startwrite+0x14f/0x1c0
[168277.825725]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.825728]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.825733]  raid5_make_request+0x364/0x1290 [raid456]
[168277.825739]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825741]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.825744]  ? __pfx_woken_wake_function+0x10/0x10
[168277.825746]  ? bio_split_rw+0x141/0x2a0
[168277.825751]  md_handle_request+0x153/0x270
[168277.825754]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825756]  __submit_bio+0x190/0x240
[168277.825760]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.825763]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825765]  ? submit_bio_noacct+0x47/0x5b0
[168277.825768]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.825771]  process_one_work+0x18f/0x3b0
[168277.825774]  worker_thread+0x21f/0x330
[168277.825776]  ? __pfx_worker_thread+0x10/0x10
[168277.825779]  kthread+0xcd/0x100
[168277.825781]  ? __pfx_kthread+0x10/0x10
[168277.825784]  ret_from_fork+0x31/0x50
[168277.825786]  ? __pfx_kthread+0x10/0x10
[168277.825788]  ret_from_fork_asm+0x1a/0x30
[168277.825792]  </TASK>
[168277.825794] task:kworker/u129:5  state:D stack:0     pid:425894 =
tgid:425894 ppid:2      flags:0x00004000
[168277.825797] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.825799] Call Trace:
[168277.825800]  <TASK>
[168277.825802]  __schedule+0x425/0x1460
[168277.825805]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825809]  schedule+0x27/0xf0
[168277.825812]  md_bitmap_startwrite+0x14f/0x1c0
[168277.825814]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.825817]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.825823]  raid5_make_request+0x364/0x1290 [raid456]
[168277.825829]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825830]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.825833]  ? __pfx_woken_wake_function+0x10/0x10
[168277.825836]  ? bio_split_rw+0x141/0x2a0
[168277.825840]  md_handle_request+0x153/0x270
[168277.825843]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825846]  __submit_bio+0x190/0x240
[168277.825850]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.825853]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825855]  ? submit_bio_noacct+0x47/0x5b0
[168277.825858]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.825861]  process_one_work+0x18f/0x3b0
[168277.825864]  worker_thread+0x21f/0x330
[168277.825866]  ? __pfx_worker_thread+0x10/0x10
[168277.825868]  kthread+0xcd/0x100
[168277.825871]  ? __pfx_kthread+0x10/0x10
[168277.825873]  ret_from_fork+0x31/0x50
[168277.825876]  ? __pfx_kthread+0x10/0x10
[168277.825878]  ret_from_fork_asm+0x1a/0x30
[168277.825882]  </TASK>
[168277.825884] task:kworker/u129:6  state:D stack:0     pid:425895 =
tgid:425895 ppid:2      flags:0x00004000
[168277.825886] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.825889] Call Trace:
[168277.825890]  <TASK>
[168277.825892]  __schedule+0x425/0x1460
[168277.825897]  schedule+0x27/0xf0
[168277.825900]  md_bitmap_startwrite+0x14f/0x1c0
[168277.825903]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.825905]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.825911]  raid5_make_request+0x364/0x1290 [raid456]
[168277.825917]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825919]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.825922]  ? __pfx_woken_wake_function+0x10/0x10
[168277.825924]  ? bio_split_rw+0x141/0x2a0
[168277.825929]  md_handle_request+0x153/0x270
[168277.825932]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825935]  __submit_bio+0x190/0x240
[168277.825939]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.825942]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.825944]  ? submit_bio_noacct+0x47/0x5b0
[168277.825947]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.825950]  process_one_work+0x18f/0x3b0
[168277.825953]  worker_thread+0x21f/0x330
[168277.825956]  ? __pfx_worker_thread+0x10/0x10
[168277.825958]  kthread+0xcd/0x100
[168277.825960]  ? __pfx_kthread+0x10/0x10
[168277.825962]  ret_from_fork+0x31/0x50
[168277.825965]  ? __pfx_kthread+0x10/0x10
[168277.825968]  ret_from_fork_asm+0x1a/0x30
[168277.825972]  </TASK>
[168277.825973] task:kworker/u129:7  state:D stack:0     pid:425896 =
tgid:425896 ppid:2      flags:0x00004000
[168277.825976] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.825979] Call Trace:
[168277.825980]  <TASK>
[168277.825982]  __schedule+0x425/0x1460
[168277.825987]  schedule+0x27/0xf0
[168277.825990]  md_bitmap_startwrite+0x14f/0x1c0
[168277.825992]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.825995]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826001]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826007]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826009]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826011]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826014]  ? bio_split_rw+0x141/0x2a0
[168277.826018]  md_handle_request+0x153/0x270
[168277.826021]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826024]  __submit_bio+0x190/0x240
[168277.826028]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826031]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826032]  ? submit_bio_noacct+0x47/0x5b0
[168277.826036]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826039]  process_one_work+0x18f/0x3b0
[168277.826042]  worker_thread+0x21f/0x330
[168277.826044]  ? __pfx_worker_thread+0x10/0x10
[168277.826046]  kthread+0xcd/0x100
[168277.826049]  ? __pfx_kthread+0x10/0x10
[168277.826051]  ret_from_fork+0x31/0x50
[168277.826054]  ? __pfx_kthread+0x10/0x10
[168277.826056]  ret_from_fork_asm+0x1a/0x30
[168277.826060]  </TASK>
[168277.826062] task:kworker/u129:9  state:D stack:0     pid:425897 =
tgid:425897 ppid:2      flags:0x00004000
[168277.826065] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826067] Call Trace:
[168277.826068]  <TASK>
[168277.826070]  __schedule+0x425/0x1460
[168277.826076]  schedule+0x27/0xf0
[168277.826078]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826081]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826084]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826090]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826096]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826098]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826100]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826103]  ? bio_split_rw+0x141/0x2a0
[168277.826107]  md_handle_request+0x153/0x270
[168277.826110]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826113]  __submit_bio+0x190/0x240
[168277.826117]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826120]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826122]  ? submit_bio_noacct+0x47/0x5b0
[168277.826125]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826128]  process_one_work+0x18f/0x3b0
[168277.826131]  worker_thread+0x21f/0x330
[168277.826133]  ? __pfx_worker_thread+0x10/0x10
[168277.826136]  kthread+0xcd/0x100
[168277.826138]  ? __pfx_kthread+0x10/0x10
[168277.826140]  ret_from_fork+0x31/0x50
[168277.826143]  ? __pfx_kthread+0x10/0x10
[168277.826145]  ret_from_fork_asm+0x1a/0x30
[168277.826150]  </TASK>
[168277.826151] task:kworker/u129:10 state:D stack:0     pid:425898 =
tgid:425898 ppid:2      flags:0x00004000
[168277.826154] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826156] Call Trace:
[168277.826157]  <TASK>
[168277.826159]  __schedule+0x425/0x1460
[168277.826165]  schedule+0x27/0xf0
[168277.826167]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826170]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826172]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826178]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826184]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826186]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826189]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826191]  ? bio_split_rw+0x141/0x2a0
[168277.826196]  md_handle_request+0x153/0x270
[168277.826199]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826201]  __submit_bio+0x190/0x240
[168277.826205]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826208]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826210]  ? submit_bio_noacct+0x47/0x5b0
[168277.826214]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826217]  process_one_work+0x18f/0x3b0
[168277.826219]  worker_thread+0x21f/0x330
[168277.826222]  ? __pfx_worker_thread+0x10/0x10
[168277.826224]  kthread+0xcd/0x100
[168277.826227]  ? __pfx_kthread+0x10/0x10
[168277.826229]  ret_from_fork+0x31/0x50
[168277.826231]  ? __pfx_kthread+0x10/0x10
[168277.826234]  ret_from_fork_asm+0x1a/0x30
[168277.826238]  </TASK>
[168277.826240] task:kworker/u129:11 state:D stack:0     pid:425899 =
tgid:425899 ppid:2      flags:0x00004000
[168277.826242] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826245] Call Trace:
[168277.826246]  <TASK>
[168277.826248]  __schedule+0x425/0x1460
[168277.826250]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826255]  schedule+0x27/0xf0
[168277.826257]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826260]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826263]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826269]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826274]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826277]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826279]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826282]  ? bio_split_rw+0x141/0x2a0
[168277.826286]  md_handle_request+0x153/0x270
[168277.826289]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826292]  __submit_bio+0x190/0x240
[168277.826296]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826298]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826301]  ? submit_bio_noacct+0x47/0x5b0
[168277.826304]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826307]  process_one_work+0x18f/0x3b0
[168277.826309]  worker_thread+0x21f/0x330
[168277.826312]  ? __pfx_worker_thread+0x10/0x10
[168277.826314]  kthread+0xcd/0x100
[168277.826316]  ? __pfx_kthread+0x10/0x10
[168277.826319]  ret_from_fork+0x31/0x50
[168277.826321]  ? __pfx_kthread+0x10/0x10
[168277.826324]  ret_from_fork_asm+0x1a/0x30
[168277.826328]  </TASK>
[168277.826330] task:kworker/u129:12 state:D stack:0     pid:425900 =
tgid:425900 ppid:2      flags:0x00004000
[168277.826332] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826335] Call Trace:
[168277.826336]  <TASK>
[168277.826337]  __schedule+0x425/0x1460
[168277.826343]  schedule+0x27/0xf0
[168277.826346]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826349]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826351]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826357]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826363]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826365]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826367]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826370]  ? bio_split_rw+0x141/0x2a0
[168277.826375]  md_handle_request+0x153/0x270
[168277.826377]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826380]  __submit_bio+0x190/0x240
[168277.826384]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826387]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826389]  ? submit_bio_noacct+0x47/0x5b0
[168277.826392]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826395]  process_one_work+0x18f/0x3b0
[168277.826398]  worker_thread+0x21f/0x330
[168277.826400]  ? __pfx_worker_thread+0x10/0x10
[168277.826402]  kthread+0xcd/0x100
[168277.826405]  ? __pfx_kthread+0x10/0x10
[168277.826408]  ret_from_fork+0x31/0x50
[168277.826410]  ? __pfx_kthread+0x10/0x10
[168277.826412]  ret_from_fork_asm+0x1a/0x30
[168277.826417]  </TASK>
[168277.826418] task:kworker/u129:14 state:D stack:0     pid:425901 =
tgid:425901 ppid:2      flags:0x00004000
[168277.826421] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826424] Call Trace:
[168277.826425]  <TASK>
[168277.826426]  __schedule+0x425/0x1460
[168277.826432]  schedule+0x27/0xf0
[168277.826435]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826438]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826441]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826447]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826453]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826455]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826458]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826460]  ? bio_split_rw+0x141/0x2a0
[168277.826465]  md_handle_request+0x153/0x270
[168277.826468]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826471]  __submit_bio+0x190/0x240
[168277.826475]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826478]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826480]  ? submit_bio_noacct+0x47/0x5b0
[168277.826483]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826486]  process_one_work+0x18f/0x3b0
[168277.826489]  worker_thread+0x21f/0x330
[168277.826491]  ? __pfx_worker_thread+0x10/0x10
[168277.826493]  ? __pfx_worker_thread+0x10/0x10
[168277.826495]  kthread+0xcd/0x100
[168277.826498]  ? __pfx_kthread+0x10/0x10
[168277.826501]  ret_from_fork+0x31/0x50
[168277.826503]  ? __pfx_kthread+0x10/0x10
[168277.826505]  ret_from_fork_asm+0x1a/0x30
[168277.826509]  </TASK>
[168277.826511] task:kworker/u129:18 state:D stack:0     pid:425924 =
tgid:425924 ppid:2      flags:0x00004000
[168277.826514] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826516] Call Trace:
[168277.826517]  <TASK>
[168277.826519]  __schedule+0x425/0x1460
[168277.826524]  schedule+0x27/0xf0
[168277.826527]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826530]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826533]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826538]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826544]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826546]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826549]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826551]  ? bio_split_rw+0x141/0x2a0
[168277.826556]  md_handle_request+0x153/0x270
[168277.826559]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826561]  __submit_bio+0x190/0x240
[168277.826565]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826569]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826570]  ? submit_bio_noacct+0x47/0x5b0
[168277.826573]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826577]  process_one_work+0x18f/0x3b0
[168277.826580]  worker_thread+0x21f/0x330
[168277.826582]  ? __pfx_worker_thread+0x10/0x10
[168277.826584]  kthread+0xcd/0x100
[168277.826586]  ? __pfx_kthread+0x10/0x10
[168277.826589]  ret_from_fork+0x31/0x50
[168277.826591]  ? __pfx_kthread+0x10/0x10
[168277.826594]  ret_from_fork_asm+0x1a/0x30
[168277.826598]  </TASK>
[168277.826600] task:kworker/u129:20 state:D stack:0     pid:425925 =
tgid:425925 ppid:2      flags:0x00004000
[168277.826602] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826605] Call Trace:
[168277.826606]  <TASK>
[168277.826608]  __schedule+0x425/0x1460
[168277.826617]  schedule+0x27/0xf0
[168277.826619]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826622]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826625]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826631]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826637]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826639]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826642]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826644]  ? bio_split_rw+0x141/0x2a0
[168277.826649]  md_handle_request+0x153/0x270
[168277.826652]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826655]  __submit_bio+0x190/0x240
[168277.826659]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826662]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826663]  ? submit_bio_noacct+0x47/0x5b0
[168277.826667]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826670]  process_one_work+0x18f/0x3b0
[168277.826673]  worker_thread+0x21f/0x330
[168277.826675]  ? __pfx_worker_thread+0x10/0x10
[168277.826677]  kthread+0xcd/0x100
[168277.826679]  ? __pfx_kthread+0x10/0x10
[168277.826682]  ret_from_fork+0x31/0x50
[168277.826684]  ? __pfx_kthread+0x10/0x10
[168277.826687]  ret_from_fork_asm+0x1a/0x30
[168277.826691]  </TASK>
[168277.826693] task:kworker/u129:21 state:D stack:0     pid:425926 =
tgid:425926 ppid:2      flags:0x00004000
[168277.826696] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826699] Call Trace:
[168277.826700]  <TASK>
[168277.826701]  __schedule+0x425/0x1460
[168277.826707]  schedule+0x27/0xf0
[168277.826710]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826712]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826715]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826720]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826727]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826728]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826731]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826734]  ? bio_split_rw+0x141/0x2a0
[168277.826738]  md_handle_request+0x153/0x270
[168277.826741]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826743]  __submit_bio+0x190/0x240
[168277.826748]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826751]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826753]  ? submit_bio_noacct+0x47/0x5b0
[168277.826756]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826759]  process_one_work+0x18f/0x3b0
[168277.826762]  worker_thread+0x21f/0x330
[168277.826764]  ? __pfx_worker_thread+0x10/0x10
[168277.826766]  kthread+0xcd/0x100
[168277.826768]  ? __pfx_kthread+0x10/0x10
[168277.826771]  ret_from_fork+0x31/0x50
[168277.826774]  ? __pfx_kthread+0x10/0x10
[168277.826776]  ret_from_fork_asm+0x1a/0x30
[168277.826780]  </TASK>
[168277.826782] task:kworker/u129:23 state:D stack:0     pid:425927 =
tgid:425927 ppid:2      flags:0x00004000
[168277.826784] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826787] Call Trace:
[168277.826788]  <TASK>
[168277.826790]  __schedule+0x425/0x1460
[168277.826795]  schedule+0x27/0xf0
[168277.826798]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826800]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826803]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826809]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826815]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826817]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826819]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826822]  ? bio_split_rw+0x141/0x2a0
[168277.826827]  md_handle_request+0x153/0x270
[168277.826830]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826832]  __submit_bio+0x190/0x240
[168277.826837]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826840]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826841]  ? submit_bio_noacct+0x47/0x5b0
[168277.826844]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826848]  process_one_work+0x18f/0x3b0
[168277.826851]  worker_thread+0x21f/0x330
[168277.826853]  ? __pfx_worker_thread+0x10/0x10
[168277.826855]  kthread+0xcd/0x100
[168277.826857]  ? __pfx_kthread+0x10/0x10
[168277.826860]  ret_from_fork+0x31/0x50
[168277.826862]  ? __pfx_kthread+0x10/0x10
[168277.826865]  ret_from_fork_asm+0x1a/0x30
[168277.826869]  </TASK>
[168277.826871] task:kworker/u129:25 state:D stack:0     pid:425929 =
tgid:425929 ppid:2      flags:0x00004000
[168277.826874] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826877] Call Trace:
[168277.826878]  <TASK>
[168277.826880]  __schedule+0x425/0x1460
[168277.826885]  schedule+0x27/0xf0
[168277.826887]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826890]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826893]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826898]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826904]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826906]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826909]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826911]  ? bio_split_rw+0x141/0x2a0
[168277.826916]  md_handle_request+0x153/0x270
[168277.826919]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826921]  __submit_bio+0x190/0x240
[168277.826925]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.826928]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826930]  ? submit_bio_noacct+0x47/0x5b0
[168277.826933]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.826936]  process_one_work+0x18f/0x3b0
[168277.826939]  worker_thread+0x21f/0x330
[168277.826942]  ? __pfx_worker_thread+0x10/0x10
[168277.826944]  kthread+0xcd/0x100
[168277.826946]  ? __pfx_kthread+0x10/0x10
[168277.826948]  ret_from_fork+0x31/0x50
[168277.826951]  ? __pfx_kthread+0x10/0x10
[168277.826954]  ret_from_fork_asm+0x1a/0x30
[168277.826958]  </TASK>
[168277.826959] task:kworker/u129:26 state:D stack:0     pid:425930 =
tgid:425930 ppid:2      flags:0x00004000
[168277.826962] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.826965] Call Trace:
[168277.826966]  <TASK>
[168277.826967]  __schedule+0x425/0x1460
[168277.826973]  schedule+0x27/0xf0
[168277.826975]  md_bitmap_startwrite+0x14f/0x1c0
[168277.826978]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.826981]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.826986]  raid5_make_request+0x364/0x1290 [raid456]
[168277.826992]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.826994]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.826997]  ? __pfx_woken_wake_function+0x10/0x10
[168277.826999]  ? bio_split_rw+0x141/0x2a0
[168277.827004]  md_handle_request+0x153/0x270
[168277.827007]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827010]  __submit_bio+0x190/0x240
[168277.827014]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.827016]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827018]  ? submit_bio_noacct+0x47/0x5b0
[168277.827021]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.827025]  process_one_work+0x18f/0x3b0
[168277.827028]  worker_thread+0x21f/0x330
[168277.827030]  ? __pfx_worker_thread+0x10/0x10
[168277.827032]  kthread+0xcd/0x100
[168277.827034]  ? __pfx_kthread+0x10/0x10
[168277.827037]  ret_from_fork+0x31/0x50
[168277.827039]  ? __pfx_kthread+0x10/0x10
[168277.827042]  ret_from_fork_asm+0x1a/0x30
[168277.827046]  </TASK>
[168277.827047] task:kworker/u129:30 state:D stack:0     pid:425931 =
tgid:425931 ppid:2      flags:0x00004000
[168277.827050] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.827053] Call Trace:
[168277.827054]  <TASK>
[168277.827055]  __schedule+0x425/0x1460
[168277.827061]  schedule+0x27/0xf0
[168277.827064]  md_bitmap_startwrite+0x14f/0x1c0
[168277.827066]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.827069]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.827075]  raid5_make_request+0x364/0x1290 [raid456]
[168277.827081]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827083]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.827086]  ? __pfx_woken_wake_function+0x10/0x10
[168277.827088]  ? bio_split_rw+0x141/0x2a0
[168277.827093]  md_handle_request+0x153/0x270
[168277.827096]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827098]  __submit_bio+0x190/0x240
[168277.827102]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.827105]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827108]  ? submit_bio_noacct+0x47/0x5b0
[168277.827111]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.827114]  process_one_work+0x18f/0x3b0
[168277.827117]  worker_thread+0x21f/0x330
[168277.827119]  ? __pfx_worker_thread+0x10/0x10
[168277.827121]  kthread+0xcd/0x100
[168277.827124]  ? __pfx_kthread+0x10/0x10
[168277.827126]  ret_from_fork+0x31/0x50
[168277.827128]  ? __pfx_kthread+0x10/0x10
[168277.827131]  ret_from_fork_asm+0x1a/0x30
[168277.827136]  </TASK>
[168277.827137] task:kworker/u129:31 state:D stack:0     pid:425932 =
tgid:425932 ppid:2      flags:0x00004000
[168277.827139] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.827142] Call Trace:
[168277.827143]  <TASK>
[168277.827145]  __schedule+0x425/0x1460
[168277.827151]  schedule+0x27/0xf0
[168277.827153]  md_bitmap_startwrite+0x14f/0x1c0
[168277.827156]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.827159]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.827165]  raid5_make_request+0x364/0x1290 [raid456]
[168277.827171]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827173]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.827175]  ? __pfx_woken_wake_function+0x10/0x10
[168277.827178]  ? bio_split_rw+0x141/0x2a0
[168277.827182]  md_handle_request+0x153/0x270
[168277.827185]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827188]  __submit_bio+0x190/0x240
[168277.827192]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.827195]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827197]  ? submit_bio_noacct+0x47/0x5b0
[168277.827200]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.827203]  process_one_work+0x18f/0x3b0
[168277.827206]  worker_thread+0x21f/0x330
[168277.827209]  ? __pfx_worker_thread+0x10/0x10
[168277.827210]  kthread+0xcd/0x100
[168277.827213]  ? __pfx_kthread+0x10/0x10
[168277.827215]  ret_from_fork+0x31/0x50
[168277.827218]  ? __pfx_kthread+0x10/0x10
[168277.827220]  ret_from_fork_asm+0x1a/0x30
[168277.827225]  </TASK>
[168277.827226] task:kworker/u129:32 state:D stack:0     pid:425933 =
tgid:425933 ppid:2      flags:0x00004000
[168277.827228] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.827231] Call Trace:
[168277.827232]  <TASK>
[168277.827234]  __schedule+0x425/0x1460
[168277.827240]  schedule+0x27/0xf0
[168277.827242]  md_bitmap_startwrite+0x14f/0x1c0
[168277.827245]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.827247]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.827254]  raid5_make_request+0x364/0x1290 [raid456]
[168277.827259]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827261]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.827264]  ? __pfx_woken_wake_function+0x10/0x10
[168277.827267]  ? bio_split_rw+0x141/0x2a0
[168277.827271]  md_handle_request+0x153/0x270
[168277.827274]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827277]  __submit_bio+0x190/0x240
[168277.827281]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.827284]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827285]  ? submit_bio_noacct+0x47/0x5b0
[168277.827289]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.827292]  process_one_work+0x18f/0x3b0
[168277.827295]  worker_thread+0x21f/0x330
[168277.827297]  ? __pfx_worker_thread+0x10/0x10
[168277.827299]  kthread+0xcd/0x100
[168277.827302]  ? __pfx_kthread+0x10/0x10
[168277.827304]  ret_from_fork+0x31/0x50
[168277.827306]  ? __pfx_kthread+0x10/0x10
[168277.827309]  ret_from_fork_asm+0x1a/0x30
[168277.827313]  </TASK>
[168277.827315] task:kworker/u129:33 state:D stack:0     pid:427404 =
tgid:427404 ppid:2      flags:0x00004000
[168277.827318] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.827320] Call Trace:
[168277.827322]  <TASK>
[168277.827324]  __schedule+0x425/0x1460
[168277.827329]  schedule+0x27/0xf0
[168277.827332]  md_bitmap_startwrite+0x14f/0x1c0
[168277.827334]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.827337]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.827343]  raid5_make_request+0x364/0x1290 [raid456]
[168277.827349]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827351]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.827353]  ? __pfx_woken_wake_function+0x10/0x10
[168277.827356]  ? bio_split_rw+0x141/0x2a0
[168277.827361]  md_handle_request+0x153/0x270
[168277.827364]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827366]  __submit_bio+0x190/0x240
[168277.827370]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.827373]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827374]  ? submit_bio_noacct+0x47/0x5b0
[168277.827377]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.827381]  process_one_work+0x18f/0x3b0
[168277.827383]  worker_thread+0x21f/0x330
[168277.827385]  ? __pfx_worker_thread+0x10/0x10
[168277.827388]  ? __pfx_worker_thread+0x10/0x10
[168277.827390]  kthread+0xcd/0x100
[168277.827392]  ? __pfx_kthread+0x10/0x10
[168277.827394]  ret_from_fork+0x31/0x50
[168277.827397]  ? __pfx_kthread+0x10/0x10
[168277.827399]  ret_from_fork_asm+0x1a/0x30
[168277.827404]  </TASK>
[168277.827407] task:rsync           state:D stack:0     pid:428253 =
tgid:428253 ppid:428251 flags:0x00004000
[168277.827409] Call Trace:
[168277.827410]  <TASK>
[168277.827412]  __schedule+0x425/0x1460
[168277.827415]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827419]  schedule+0x27/0xf0
[168277.827422]  schedule_timeout+0x9e/0x170
[168277.827424]  ? __pfx_process_timeout+0x10/0x10
[168277.827427]  io_schedule_timeout+0x51/0x70
[168277.827431]  balance_dirty_pages+0x3e7/0x9f0
[168277.827439]  balance_dirty_pages_ratelimited_flags+0x2a9/0x390
[168277.827442]  iomap_file_buffered_write+0x163/0x440
[168277.827450]  xfs_file_buffered_write+0x87/0x2a0 [xfs]
[168277.827537]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827540]  vfs_write+0x291/0x460
[168277.827546]  ksys_write+0x6f/0xf0
[168277.827549]  do_syscall_64+0xb7/0x200
[168277.827554]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[168277.827558] RIP: 0033:0x7f7b9e92c133
[168277.827560] RSP: 002b:00007fff07ae39f8 EFLAGS: 00000246 ORIG_RAX: =
0000000000000001
[168277.827562] RAX: ffffffffffffffda RBX: 00000000369cf5c0 RCX: =
00007f7b9e92c133
[168277.827564] RDX: 0000000000040000 RSI: 00000000369cf5c0 RDI: =
0000000000000003
[168277.827565] RBP: 0000000000000003 R08: 0000000000020000 R09: =
000000003698f5b0
[168277.827567] R10: 00007f7b9ed1b180 R11: 0000000000000246 R12: =
0000000000040000
[168277.827568] R13: 0000000000020000 R14: 0000000000020000 R15: =
0000000000000000
[168277.827572]  </TASK>
[168277.827573] task:kworker/u129:34 state:D stack:0     pid:428278 =
tgid:428278 ppid:2      flags:0x00004000
[168277.827576] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.827579] Call Trace:
[168277.827580]  <TASK>
[168277.827582]  __schedule+0x425/0x1460
[168277.827586]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827588]  ? raid5_bio_lowest_chunk_sector+0x65/0xe0 [raid456]
[168277.827594]  schedule+0x27/0xf0
[168277.827597]  md_bitmap_startwrite+0x14f/0x1c0
[168277.827600]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.827603]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.827609]  raid5_make_request+0x364/0x1290 [raid456]
[168277.827619]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827621]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.827623]  ? __pfx_woken_wake_function+0x10/0x10
[168277.827626]  ? bio_split_rw+0x141/0x2a0
[168277.827631]  md_handle_request+0x153/0x270
[168277.827634]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827636]  __submit_bio+0x190/0x240
[168277.827640]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.827644]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827646]  ? submit_bio_noacct+0x47/0x5b0
[168277.827649]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.827652]  process_one_work+0x18f/0x3b0
[168277.827656]  worker_thread+0x21f/0x330
[168277.827658]  ? __pfx_worker_thread+0x10/0x10
[168277.827660]  ? __pfx_worker_thread+0x10/0x10
[168277.827662]  kthread+0xcd/0x100
[168277.827664]  ? __pfx_kthread+0x10/0x10
[168277.827667]  ret_from_fork+0x31/0x50
[168277.827670]  ? __pfx_kthread+0x10/0x10
[168277.827672]  ret_from_fork_asm+0x1a/0x30
[168277.827678]  </TASK>
[168277.827679] task:kworker/u129:35 state:D stack:0     pid:428482 =
tgid:428482 ppid:2      flags:0x00004000
[168277.827682] Workqueue: kcryptd-253:4-1 kcryptd_crypt [dm_crypt]
[168277.827685] Call Trace:
[168277.827686]  <TASK>
[168277.827687]  __schedule+0x425/0x1460
[168277.827693]  schedule+0x27/0xf0
[168277.827696]  md_bitmap_startwrite+0x14f/0x1c0
[168277.827698]  ? __pfx_autoremove_wake_function+0x10/0x10
[168277.827701]  __add_stripe_bio+0x1f4/0x240 [raid456]
[168277.827707]  raid5_make_request+0x364/0x1290 [raid456]
[168277.827713]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827715]  ? submit_bio_noacct_nocheck+0x276/0x3c0
[168277.827718]  ? __pfx_woken_wake_function+0x10/0x10
[168277.827720]  ? bio_split_rw+0x141/0x2a0
[168277.827725]  md_handle_request+0x153/0x270
[168277.827728]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827731]  __submit_bio+0x190/0x240
[168277.827735]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.827738]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827740]  ? submit_bio_noacct+0x47/0x5b0
[168277.827743]  kcryptd_crypt_write_convert+0x118/0x1e0 [dm_crypt]
[168277.827747]  process_one_work+0x18f/0x3b0
[168277.827750]  worker_thread+0x21f/0x330
[168277.827751]  ? __pfx_worker_thread+0x10/0x10
[168277.827753]  ? __pfx_worker_thread+0x10/0x10
[168277.827755]  kthread+0xcd/0x100
[168277.827758]  ? __pfx_kthread+0x10/0x10
[168277.827760]  ret_from_fork+0x31/0x50
[168277.827762]  ? __pfx_kthread+0x10/0x10
[168277.827765]  ret_from_fork_asm+0x1a/0x30
[168277.827769]  </TASK>
[168277.827771] task:kworker/17:3    state:D stack:0     pid:438399 =
tgid:438399 ppid:2      flags:0x00004000
[168277.827774] Workqueue: xfs-sync/dm-4 xfs_log_worker [xfs]
[168277.827854] Call Trace:
[168277.827855]  <TASK>
[168277.827857]  __schedule+0x425/0x1460
[168277.827861]  ? ttwu_do_activate+0x64/0x210
[168277.827863]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827867]  schedule+0x27/0xf0
[168277.827870]  schedule_timeout+0x15d/0x170
[168277.827873]  __wait_for_common+0x90/0x1c0
[168277.827876]  ? __pfx_schedule_timeout+0x10/0x10
[168277.827880]  __flush_workqueue+0x158/0x440
[168277.827882]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.827886]  xlog_cil_push_now.isra.0+0x5e/0xa0 [xfs]
[168277.827958]  xlog_cil_force_seq+0x69/0x240 [xfs]
[168277.828029]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.828031]  ? __schedule+0x42d/0x1460
[168277.828034]  xfs_log_force+0x7a/0x230 [xfs]
[168277.828105]  xfs_log_worker+0x3d/0xc0 [xfs]
[168277.828175]  process_one_work+0x18f/0x3b0
[168277.828178]  worker_thread+0x21f/0x330
[168277.828179]  ? __pfx_worker_thread+0x10/0x10
[168277.828182]  ? __pfx_worker_thread+0x10/0x10
[168277.828184]  kthread+0xcd/0x100
[168277.828186]  ? __pfx_kthread+0x10/0x10
[168277.828189]  ret_from_fork+0x31/0x50
[168277.828191]  ? __pfx_kthread+0x10/0x10
[168277.828193]  ret_from_fork_asm+0x1a/0x30
[168277.828198]  </TASK>
[168277.828218] task:kworker/u130:3  state:D stack:0     pid:781590 =
tgid:781590 ppid:2      flags:0x00004000
[168277.828221] Workqueue: writeback wb_workfn (flush-253:1)
[168277.828224] Call Trace:
[168277.828225]  <TASK>
[168277.828226]  ? __pfx_wbt_inflight_cb+0x10/0x10
[168277.828231]  __schedule+0x425/0x1460
[168277.828236]  ? __pfx_wbt_cleanup_cb+0x10/0x10
[168277.828238]  ? __pfx_wbt_inflight_cb+0x10/0x10
[168277.828240]  schedule+0x27/0xf0
[168277.828243]  io_schedule+0x46/0x70
[168277.828246]  rq_qos_wait+0xbe/0x130
[168277.828249]  ? __pfx_rq_qos_wake_function+0x10/0x10
[168277.828252]  ? __pfx_wbt_inflight_cb+0x10/0x10
[168277.828255]  wbt_wait+0xae/0x130
[168277.828259]  __rq_qos_throttle+0x24/0x40
[168277.828261]  blk_mq_submit_bio+0x1d2/0x780
[168277.828267]  __submit_bio+0x6c/0x240
[168277.828271]  submit_bio_noacct_nocheck+0x19a/0x3c0
[168277.828274]  ? submit_bio_noacct+0x47/0x5b0
[168277.828277]  iomap_submit_ioend+0x40/0x80
[168277.828280]  iomap_writepages+0x4be/0x9b0
[168277.828284]  xfs_vm_writepages+0x67/0x90 [xfs]
[168277.828370]  do_writepages+0x76/0x260
[168277.828373]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.828375]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.828376]  ? sched_clock_cpu+0xf/0x190
[168277.828379]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.828382]  ? psi_group_change+0x138/0x350
[168277.828385]  __writeback_single_inode+0x3d/0x350
[168277.828388]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.828389]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.828392]  writeback_sb_inodes+0x21c/0x4e0
[168277.828395]  ? select_task_rq_fair+0x1d4/0x1d30
[168277.828405]  __writeback_inodes_wb+0x4c/0xf0
[168277.828407]  ? srso_alias_return_thunk+0x5/0xfbef5
[168277.828410]  wb_writeback+0x193/0x310
[168277.828414]  wb_workfn+0x2b1/0x450
[168277.828418]  process_one_work+0x18f/0x3b0
[168277.828421]  worker_thread+0x21f/0x330
[168277.828423]  ? __pfx_worker_thread+0x10/0x10
[168277.828425]  kthread+0xcd/0x100
[168277.828428]  ? __pfx_kthread+0x10/0x10
[168277.828430]  ret_from_fork+0x31/0x50
[168277.828433]  ? __pfx_kthread+0x10/0x10
[168277.828436]  ret_from_fork_asm+0x1a/0x30
[168277.828440]  </TASK>



> On 1. Nov 2024, at 09:33, Christian Theune <ct@flyingcircus.io> wrote:
>=20
> A thought about the high numbers: they look like relatively regular =
=E2=80=9Cmany bits on=E2=80=9D patterns:
>=20
>>>> bin(4294967264)
> =E2=80=980b11111111111111111111111111100000'
>=20
> I think I enabled the bitmap online so MAYBE it circumvents =
initialisation of some memory instead of when this gets up during a =
regular boot. I=E2=80=99m not seeing those numbers anymore after booting =
cleanly.
>=20
> I=E2=80=99m letting things run for a few hours again, but I=E2=80=99m =
still concerned that the printk overhead doesn=E2=80=99t allow the =
system to actually trigger the issue again.
>=20
> If I=E2=80=99m not getting things stuck again, then I=E2=80=99ll =
double check to ensure that my reproduce is still valid on 6.11.5 =
without the debugging patch.
>=20
> Christian
>=20
>> On 1. Nov 2024, at 08:56, Christian Theune <ct@flyingcircus.io> =
wrote:
>>=20
>> Hi,
>>=20
>> ok, so the journal didn=E2=80=99t have that because it was way too =
much. Looks like I actually need to stick with the serial console =
logging after all.
>>=20
>> I dug out a different one that goes back longer but even that one =
seems like something was missing early on when I didn=E2=80=99t have the =
serial console attached.
>>=20
>> I=E2=80=99m wondering whether this indicates an issue during =
initialization? I=E2=80=99m going to reboot the machine and make sure i =
get the early logs with those numbers.
>>=20
>> [  405.347345] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(22301786792+8) 4294967259
>> [  432.542465] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(22837701992+8) 4294967260
>> [  432.542469] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(22837701992+8) 4294967261
>> [  434.272964] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(22837701992+8) 4294967262
>> [  434.273175] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(22837701992+8) 4294967263
>> [  434.273189] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(22837701992+8) 4294967264
>> [  434.273285] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(22837701992+8) 4294967265
>> [  434.274063] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(22837701992+8) 4294967264
>> [  434.274066] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(22837701992+8) 4294967263
>> [  434.274070] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(22837701992+8) 4294967262
>> [  434.274073] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(22837701992+8) 4294967261
>> [  434.274078] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(22837701992+8) 4294967260
>> [  434.274083] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(22837701992+8) 4294967259
>> [  434.276609] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(23374951848+8) 4294967260
>> [  434.278939] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(23374951848+8) 4294967261
>> [  464.922354] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(23374951848+8) 4294967260
>> [  464.931833] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(23374951848+8) 4294967259
>> [  466.964557] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(23912715112+8) 4294967260
>> [  466.964616] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(23912715112+8) 4294967261
>> [  474.399930] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(23912715112+8) 4294967262
>> [  474.451451] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(23912715112+8) 4294967263
>> [  489.447079] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(23912715112+8) 4294967262
>> [  489.456574] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(23912715112+8) 4294967261
>> [  489.466069] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(23912715112+8) 4294967260
>> [  489.475565] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(23912715112+8) 4294967259
>> [  491.235517] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(24448073512+8) 4294967260
>> [  491.235602] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(24448073512+8) 4294967261
>> [  498.153108] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(24716445096+8) 4294967262
>> [  498.156307] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(24716445096+8) 4294967263
>> [  530.332619] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(24716445096+8) 4294967262
>> [  530.342110] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(24716445096+8) 4294967261
>> [  530.351595] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(24716445096+8) 4294967260
>> [  530.361082] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(24716445096+8) 4294967259
>> [  535.176774] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(24985208424+8) 4294967260
>> [  549.125326] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(24985208424+8) 4294967259
>> [  549.635782] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(25521770024+8) 4294967261
>> [  590.875593] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(25521770024+8) 4294967260
>> [  590.885081] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(25521770024+8) 4294967259
>> [  596.973863] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26057037928+8) 4294967263
>> [  596.973866] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26057037928+8) 4294967262
>> [  596.973869] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26057037928+8) 4294967261
>> [  596.973871] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26057037928+8) 4294967260
>> [  596.973881] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26057037928+8) 4294967259
>> [  596.974557] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26325099752+8) 4294967260
>> [  637.646142] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26325099752+8) 4294967259
>> [  641.292887] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032741096+8) 4294967260
>> [  654.931195] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032741096+8) 4294967259
>> [  654.933295] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592771048+8) 4294967260
>> [  654.933570] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592771048+8) 4294967261
>> [  654.935967] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592771048+8) 4294967262
>> [  654.937411] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592771048+8) 4294967263
>> [  683.008873] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592771048+8) 4294967264
>> [  685.689494] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592771048+8) 4294967263
>> [  685.689496] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592771048+8) 4294967262
>> [  685.689498] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592771048+8) 4294967261
>> [  685.689499] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592771048+8) 4294967260
>> [  685.689501] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592771048+8) 4294967259
>> [  685.690260] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592774184+8) 4294967260
>> [  685.692999] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592774184+8) 4294967261
>> [  685.693119] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592774184+8) 4294967262
>> [  685.693124] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592774184+8) 4294967263
>> [  685.693427] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592774184+8) 4294967264
>> [  685.693428] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592774184+8) 4294967265
>> [  685.693517] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592774184+8) 4294967266
>> [  685.693528] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592774184+8) 4294967267
>> [  713.684556] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592774184+8) 4294967266
>> [  713.694044] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592774184+8) 4294967265
>> [  713.703539] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592774184+8) 4294967264
>> [  713.713026] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592774184+8) 4294967263
>> [  713.722512] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592774184+8) 4294967262
>> [  713.731996] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592774184+8) 4294967261
>> [  713.741480] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592774184+8) 4294967260
>> [  713.750962] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592774184+8) 4294967259
>> [  715.765954] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592775464+8) 4294967260
>> [  715.766034] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592775464+8) 4294967261
>> [  715.766278] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592775464+8) 4294967262
>> [  715.766305] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592775464+8) 4294967263
>> [  715.766468] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592775464+8) 4294967264
>> [  716.077253] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592775464+8) 4294967265
>> [  731.258391] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592780072+8) 4294967260
>> [  731.258401] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592780072+8) 4294967261
>> [  731.258584] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592780072+8) 4294967262
>> [  731.258711] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592780072+8) 4294967263
>> [  731.260991] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592780072+8) 4294967264
>> [  731.261318] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592780072+8) 4294967265
>> [  731.261513] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592780072+8) 4294967266
>> [  758.285428] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592780072+8) 4294967265
>> [  758.294912] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592780072+8) 4294967264
>> [  758.304396] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592780072+8) 4294967263
>> [  758.313881] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592780072+8) 4294967262
>> [  758.323377] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592780072+8) 4294967261
>> [  758.332875] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592780072+8) 4294967260
>> [  758.342365] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592780072+8) 4294967259
>> [  758.922198] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592780072+8) 4294967260
>> [  780.668347] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592780072+8) 4294967259
>> [  780.957247] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592782888+8) 4294967260
>> [  780.957393] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592782888+8) 4294967261
>> [  780.957440] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592782888+8) 4294967262
>> [  780.957616] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592782888+8) 4294967263
>> [  780.957675] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592782888+8) 4294967264
>> [  780.957754] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592782888+8) 4294967265
>> [  790.623177] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26592782888+8) 4294967266
>> [  828.374094] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592782888+8) 4294967265
>> [  828.383581] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592782888+8) 4294967264
>> [  828.393067] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592782888+8) 4294967263
>> [  828.402553] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592782888+8) 4294967262
>> [  828.412040] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592782888+8) 4294967261
>> [  828.421525] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592782888+8) 4294967260
>> [  828.431012] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26592782888+8) 4294967259
>> [  830.477927] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(13690207080+8) 4294967260
>> [  851.040449] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(13690207080+8) 4294967259
>> [  851.762678] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861766952+8) 4294967260
>> [  851.762837] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861766952+8) 4294967261
>> [  851.762948] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861766952+8) 4294967262
>> [  851.763032] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861766952+8) 4294967263
>> [  851.763068] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861766952+8) 4294967264
>> [  851.763112] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861766952+8) 4294967265
>> [  851.763202] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861766952+8) 4294967266
>> [  851.766405] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861766952+8) 4294967267
>> [  851.768763] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861766952+8) 4294967266
>> [  851.768766] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861766952+8) 4294967265
>> [  851.768768] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861766952+8) 4294967264
>> [  851.768770] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861766952+8) 4294967263
>> [  851.768773] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861766952+8) 4294967262
>> [  851.768775] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861766952+8) 4294967261
>> [  851.768778] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861766952+8) 4294967260
>> [  851.768780] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861766952+8) 4294967259
>> [  851.769437] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768360+8) 4294967261
>> [  851.769437] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768360+8) 4294967260
>> [  880.058982] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768360+8) 4294967262
>> [  880.059032] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768360+8) 4294967263
>> [  880.059090] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768360+8) 4294967264
>> [  880.059140] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768360+8) 4294967265
>> [  880.059317] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768360+8) 4294967266
>> [  891.735497] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861768360+8) 4294967265
>> [  891.744974] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861768360+8) 4294967264
>> [  891.754455] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861768360+8) 4294967263
>> [  891.763939] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861768360+8) 4294967262
>> [  891.773422] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861768360+8) 4294967261
>> [  891.782975] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861768360+8) 4294967260
>> [  891.792469] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861768360+8) 4294967259
>> [  897.108788] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768872+8) 4294967260
>> [  897.108789] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768872+8) 4294967261
>> [  897.108813] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768872+8) 4294967262
>> [  897.108823] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768872+8) 4294967263
>> [  903.693112] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768872+8) 4294967264
>> [  904.663454] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861768872+8) 4294967265
>> [  906.906830] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861770984+8) 4294967260
>> [  906.908087] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861770984+8) 4294967261
>> [  906.908508] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861770984+8) 4294967262
>> [  906.910088] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861770984+8) 4294967263
>> [  906.912093] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861770984+8) 4294967264
>> [  906.912840] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861770984+8) 4294967265
>> [  906.914294] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861770984+8) 4294967266
>> [  906.914323] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861770984+8) 4294967267
>> [  906.914806] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861770984+8) 4294967266
>> [  906.914808] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861770984+8) 4294967265
>> [  906.914809] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861770984+8) 4294967264
>> [  906.914810] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861770984+8) 4294967263
>> [  906.914811] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861770984+8) 4294967262
>> [  906.914813] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861770984+8) 4294967261
>> [  906.914815] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861770984+8) 4294967260
>> [  906.914817] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861770984+8) 4294967259
>> [  934.849642] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861773736+8) 4294967261
>> [  934.854037] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861773736+8) 4294967260
>> [  934.854040] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861773736+8) 4294967259
>> [  934.855808] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861776680+8) 4294967260
>> [  934.855945] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861776680+8) 4294967261
>> [  963.315203] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861776680+8) 4294967262
>> [  963.315320] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861776680+8) 4294967263
>> [  963.315327] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861776680+8) 4294967264
>> [  963.315499] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861776680+8) 4294967265
>> [  982.866693] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861776680+8) 4294967264
>> [  982.876178] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861776680+8) 4294967263
>> [  982.885665] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861776680+8) 4294967262
>> [  982.895158] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861776680+8) 4294967261
>> [  982.904644] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861776680+8) 4294967260
>> [  982.914129] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861776680+8) 4294967259
>> [  990.121616] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861777832+8) 4294967260
>> [  990.121662] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861777832+8) 4294967261
>> [  990.121768] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861777832+8) 4294967262
>> [  990.121828] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861777832+8) 4294967263
>> [  990.121843] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861777832+8) 4294967264
>> [ 1013.206756] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861777832+8) 4294967263
>> [ 1013.206757] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861777832+8) 4294967262
>> [ 1013.206758] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861777832+8) 4294967261
>> [ 1013.206759] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861777832+8) 4294967260
>> [ 1013.224363] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861777832+8) 4294967259
>> [ 1032.134913] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861781032+8) 4294967260
>> [ 1032.134928] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861781032+8) 4294967261
>> [ 1032.135028] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861781032+8) 4294967262
>> [ 1032.135078] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861781032+8) 4294967263
>> [ 1041.027196] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861781032+8) 4294967264
>> [ 1041.027321] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861781032+8) 4294967265
>> [ 1041.027485] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861781032+8) 4294967266
>> [ 1057.623365] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861781032+8) 4294967267
>> [ 1076.893035] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861781032+8) 4294967266
>> [ 1076.902520] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861781032+8) 4294967265
>> [ 1076.912004] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861781032+8) 4294967264
>> [ 1076.921490] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861781032+8) 4294967263
>> [ 1076.930986] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861781032+8) 4294967262
>> [ 1076.940475] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861781032+8) 4294967261
>> [ 1076.949962] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861781032+8) 4294967260
>> [ 1076.959446] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861781032+8) 4294967259
>> [ 1077.721459] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861784872+8) 4294967260
>> [ 1077.721615] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861784872+8) 4294967261
>> [ 1077.721706] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861784872+8) 4294967262
>> [ 1077.721739] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861784872+8) 4294967263
>> [ 1077.721765] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861784872+8) 4294967264
>> [ 1110.833257] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861784872+8) 4294967263
>> [ 1110.842743] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861784872+8) 4294967262
>> [ 1110.852225] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861784872+8) 4294967261
>> [ 1110.861709] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861784872+8) 4294967260
>> [ 1110.871194] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861784872+8) 4294967259
>> [ 1112.052569] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861786920+8) 4294967260
>> [ 1112.052666] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861786920+8) 4294967261
>> [ 1112.052695] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861786920+8) 4294967262
>> [ 1112.052727] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861786920+8) 4294967263
>> [ 1112.052778] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861786920+8) 4294967264
>> [ 1112.053637] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861786920+8) 4294967265
>> [ 1112.053649] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861786920+8) 4294967266
>> [ 1173.829738] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861789672+8) 4294967265
>> [ 1173.839223] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861789672+8) 4294967264
>> [ 1173.848709] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861789672+8) 4294967263
>> [ 1173.858195] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861789672+8) 4294967262
>> [ 1173.867683] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861789672+8) 4294967261
>> [ 1173.877167] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861789672+8) 4294967260
>> [ 1173.886654] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861789672+8) 4294967259
>> [ 1176.428651] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861792872+8) 4294967260
>> [ 1176.428940] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861792872+8) 4294967263
>> [ 1176.428942] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861792872+8) 4294967264
>> [ 1176.428939] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861792872+8) 4294967262
>> [ 1176.428903] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861792872+8) 4294967261
>> [ 1176.429040] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861792872+8) 4294967265
>> [ 1191.700497] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861797928+8) 4294967265
>> [ 1191.704134] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861797928+8) 4294967266
>> [ 1191.704199] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861797928+8) 4294967267
>> [ 1191.705804] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861797928+8) 4294967266
>> [ 1191.705808] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861797928+8) 4294967265
>> [ 1191.705809] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861797928+8) 4294967264
>> [ 1191.705812] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861797928+8) 4294967263
>> [ 1191.705815] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861797928+8) 4294967262
>> [ 1191.705817] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861797928+8) 4294967261
>> [ 1191.705819] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861797928+8) 4294967260
>> [ 1191.705821] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861797928+8) 4294967259
>> [ 1191.810863] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861792488+8) 4294967260
>> [ 1244.235788] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27917293544+8) 4294967260
>> [ 1309.535319] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861804392+8) 4294967264
>> [ 1309.544810] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861804392+8) 4294967263
>> [ 1309.554303] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861804392+8) 4294967262
>> [ 1309.563787] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861804392+8) 4294967261
>> [ 1309.573272] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861804392+8) 4294967260
>> [ 1309.582759] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861804392+8) 4294967259
>> [ 1314.950362] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861809064+8) 4294967262
>> [ 1314.950455] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861809064+8) 4294967263
>> [ 1314.950457] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861809064+8) 4294967264
>> [ 1314.950470] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861809064+8) 4294967265
>> [ 1345.736319] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861809064+8) 4294967264
>> [ 1345.745804] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861809064+8) 4294967263
>> [ 1345.755290] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861809064+8) 4294967262
>> [ 1345.764773] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861809064+8) 4294967261
>> [ 1345.774264] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861809064+8) 4294967260
>> [ 1345.783759] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861809064+8) 4294967259
>> [ 1346.823135] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28462541160+8) 4294967259
>> [ 1346.824776] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861814312+8) 4294967260
>> [ 1346.824799] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861814312+8) 4294967261
>> [ 1346.824806] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861814312+8) 4294967262
>> [ 1346.824922] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861814312+8) 4294967263
>> [ 1346.825566] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861814312+8) 4294967264
>> [ 1373.560546] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861814568+8) 4294967260
>> [ 1431.650090] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861814568+8) 4294967259
>> [ 1468.944088] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861821608+8) 4294967265
>> [ 1468.953581] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861821608+8) 4294967264
>> [ 1468.963067] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861821608+8) 4294967263
>> [ 1468.972552] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861821608+8) 4294967262
>> [ 1468.982036] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861821608+8) 4294967261
>> [ 1468.991524] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861821608+8) 4294967260
>> [ 1469.001009] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861821608+8) 4294967259
>> [ 1474.904585] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861825384+8) 4294967261
>> [ 1474.904585] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861825384+8) 4294967260
>> [ 1474.904634] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861825384+8) 4294967262
>> [ 1474.904752] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861825384+8) 4294967263
>> [ 1474.904798] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861825384+8) 4294967264
>> [ 1474.904805] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861825384+8) 4294967265
>> [ 1477.837716] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861825384+8) 4294967266
>> [ 1479.836591] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861828456+8) 4294967260
>> [ 1479.858896] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861828456+8) 4294967261
>> [ 1479.859238] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861828456+8) 4294967262
>> [ 1479.859525] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861828456+8) 4294967263
>> [ 1479.859669] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861828456+8) 4294967264
>> [ 1479.859897] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861828456+8) 4294967265
>> [ 1479.860071] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861828456+8) 4294967266
>> [ 1507.386887] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861828456+8) 4294967265
>> [ 1507.396375] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861828456+8) 4294967264
>> [ 1507.405858] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861828456+8) 4294967263
>> [ 1507.415343] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861828456+8) 4294967262
>> [ 1507.424831] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861828456+8) 4294967261
>> [ 1507.434322] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861828456+8) 4294967260
>> [ 1507.443826] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861828456+8) 4294967259
>> [ 1569.056325] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861834088+8) 4294967264
>> [ 1569.065837] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861834088+8) 4294967263
>> [ 1569.075325] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861834088+8) 4294967262
>> [ 1569.084816] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861834088+8) 4294967261
>> [ 1569.094308] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861834088+8) 4294967260
>> [ 1569.103801] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861834088+8) 4294967259
>> [ 1571.985752] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861838056+8) 4294967260
>> [ 1571.985858] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861838056+8) 4294967261
>> [ 1571.985888] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861838056+8) 4294967263
>> [ 1571.985864] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861838056+8) 4294967262
>> [ 1571.985962] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861838056+8) 4294967264
>> [ 1571.986450] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861838056+8) 4294967265
>> [ 1582.882338] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861838056+8) 4294967264
>> [ 1582.882340] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861838056+8) 4294967263
>> [ 1582.882342] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861838056+8) 4294967262
>> [ 1582.882344] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861838056+8) 4294967261
>> [ 1582.882345] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861838056+8) 4294967260
>> [ 1582.882346] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861838056+8) 4294967259
>> [ 1582.884560] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861843304+8) 4294967260
>> [ 1582.884860] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861843304+8) 4294967261
>> [ 1582.884880] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861843304+8) 4294967262
>> [ 1582.885034] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861843304+8) 4294967263
>> [ 1582.885126] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861843304+8) 4294967264
>> [ 1582.885164] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861843304+8) 4294967265
>> [ 1675.519030] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861843304+8) 4294967264
>> [ 1675.528518] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861843304+8) 4294967263
>> [ 1675.538016] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861843304+8) 4294967262
>> [ 1675.547513] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861843304+8) 4294967261
>> [ 1675.556999] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861843304+8) 4294967260
>> [ 1675.566485] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861843304+8) 4294967259
>> [ 1682.250399] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861848168+8) 4294967260
>> [ 1682.250639] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861848168+8) 4294967261
>> [ 1682.250690] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861848168+8) 4294967262
>> [ 1682.250718] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861848168+8) 4294967263
>> [ 1682.250974] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861848168+8) 4294967264
>> [ 1682.251078] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861848168+8) 4294967265
>> [ 1682.251306] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861848168+8) 4294967266
>> [ 1704.298207] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861848168+8) 4294967265
>> [ 1704.298211] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861848168+8) 4294967264
>> [ 1704.298214] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861848168+8) 4294967263
>> [ 1704.298216] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861848168+8) 4294967262
>> [ 1704.298218] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861848168+8) 4294967261
>> [ 1704.298220] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861848168+8) 4294967260
>> [ 1704.298222] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861848168+8) 4294967259
>> [ 1704.299566] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861852968+8) 4294967260
>> [ 1704.299718] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861852968+8) 4294967261
>> [ 1704.299758] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861852968+8) 4294967262
>> [ 1704.299834] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861852968+8) 4294967263
>> [ 1704.299888] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861852968+8) 4294967264
>> [ 1704.304001] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861852968+8) 4294967265
>> [ 1704.304132] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861852968+8) 4294967266
>> [ 1772.283712] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861854696+8) 4294967264
>> [ 1772.293200] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861854696+8) 4294967263
>> [ 1772.302685] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861854696+8) 4294967262
>> [ 1772.312169] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861854696+8) 4294967261
>> [ 1772.321652] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861854696+8) 4294967260
>> [ 1772.331135] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861854696+8) 4294967259
>> [ 1776.549687] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861858856+8) 4294967260
>> [ 1776.549697] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861858856+8) 4294967261
>> [ 1776.549898] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861858856+8) 4294967263
>> [ 1776.549945] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861858856+8) 4294967264
>> [ 1776.549962] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861858856+8) 4294967265
>> [ 1776.549828] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861858856+8) 4294967262
>> [ 1776.550033] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861858856+8) 4294967266
>> [ 1776.550080] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861858856+8) 4294967267
>> [ 1781.961535] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861858856+8) 4294967266
>> [ 1782.080461] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861858856+8) 4294967265
>> [ 1782.199404] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861858856+8) 4294967264
>> [ 1782.318346] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861858856+8) 4294967263
>> [ 1782.438150] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861858856+8) 4294967262
>> [ 1782.557963] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861858856+8) 4294967261
>> [ 1782.677762] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861858856+8) 4294967260
>> [ 1782.797570] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861858856+8) 4294967259
>> [ 1786.992892] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861859880+8) 4294967261
>> [ 1786.992878] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861859880+8) 4294967260
>> [ 1786.993259] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861859880+8) 4294967262
>> [ 1786.993401] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861859880+8) 4294967263
>> [ 1786.993449] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861859880+8) 4294967264
>> [ 1795.858021] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861859880+8) 4294967266
>> [ 1795.858009] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861859880+8) 4294967265
>> [ 1795.858180] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861859880+8) 4294967267
>> [ 1805.164880] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861859880+8) 4294967266
>> [ 1805.174370] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861859880+8) 4294967265
>> [ 1805.183853] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861859880+8) 4294967264
>> [ 1805.193339] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861859880+8) 4294967263
>> [ 1805.202828] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861859880+8) 4294967262
>> [ 1805.212314] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861859880+8) 4294967261
>> [ 1805.221800] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861859880+8) 4294967260
>> [ 1805.231291] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861859880+8) 4294967259
>> [ 1807.730968] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861861672+8) 4294967261
>> [ 1807.730937] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861861672+8) 4294967260
>> [ 1807.731203] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861861672+8) 4294967262
>> [ 1807.731267] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861861672+8) 4294967263
>> [ 1807.731406] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861861672+8) 4294967264
>> [ 1807.731542] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861861672+8) 4294967265
>> [ 1807.731764] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861861672+8) 4294967266
>> [ 1893.800189] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861869864+8) 4294967263
>> [ 1893.809691] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861869864+8) 4294967262
>> [ 1893.819186] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861869864+8) 4294967261
>> [ 1893.828675] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861869864+8) 4294967260
>> [ 1893.838165] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861869864+8) 4294967259
>> [ 1897.304170] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861873064+8) 4294967260
>> [ 1897.304333] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861873064+8) 4294967261
>> [ 1897.304579] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861873064+8) 4294967262
>> [ 1897.304721] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861873064+8) 4294967263
>> [ 1897.304812] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861873064+8) 4294967264
>> [ 1897.304978] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861873064+8) 4294967265
>> [ 1910.883901] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861873064+8) 4294967259
>> [ 1910.888991] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861876200+8) 4294967262
>> [ 1910.888995] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861876200+8) 4294967264
>> [ 1910.888988] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861876200+8) 4294967261
>> [ 1910.888993] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861876200+8) 4294967263
>> [ 1910.888986] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861876200+8) 4294967260
>> [ 1990.952649] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861876200+8) 4294967264
>> [ 1990.952651] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861876200+8) 4294967263
>> [ 1990.952653] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861876200+8) 4294967262
>> [ 1990.952655] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861876200+8) 4294967261
>> [ 1990.952657] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861876200+8) 4294967260
>> [ 1990.952659] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861876200+8) 4294967259
>> [ 1990.957010] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861883368+8) 4294967260
>> [ 1990.957011] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861883368+8) 4294967261
>> [ 1990.957016] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861883368+8) 4294967262
>> [ 1990.957020] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26861883368+8) 4294967263
>> [ 2021.437780] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861883368+8) 4294967262
>> [ 2021.437782] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861883368+8) 4294967261
>> [ 2021.437783] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861883368+8) 4294967260
>> [ 2021.437785] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26861883368+8) 4294967259
>> [ 2021.442407] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130481192+8) 4294967260
>> [ 2021.443820] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130481192+8) 4294967261
>> [ 2045.539668] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130481192+8) 4294967262
>> [ 2045.540142] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130481192+8) 4294967263
>> [ 2045.540232] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130481192+8) 4294967264
>> [ 2045.540262] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130481192+8) 4294967265
>> [ 2050.125201] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130481192+8) 4294967266
>> [ 2057.875279] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130481192+8) 4294967265
>> [ 2057.884767] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130481192+8) 4294967264
>> [ 2057.894262] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130481192+8) 4294967263
>> [ 2057.903753] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130481192+8) 4294967262
>> [ 2057.913237] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130481192+8) 4294967261
>> [ 2057.922722] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130481192+8) 4294967260
>> [ 2057.932205] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130481192+8) 4294967259
>> [ 2059.233074] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130482408+8) 4294967260
>> [ 2059.233116] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130482408+8) 4294967261
>> [ 2059.233120] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130482408+8) 4294967262
>> [ 2059.233171] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130482408+8) 4294967263
>> [ 2059.233632] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130482408+8) 4294967264
>> [ 2059.233684] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130482408+8) 4294967265
>> [ 2059.235328] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130482408+8) 4294967266
>> [ 2059.235336] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130482408+8) 4294967267
>> [ 2059.238433] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130482408+8) 4294967266
>> [ 2059.238435] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130482408+8) 4294967265
>> [ 2059.238436] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130482408+8) 4294967264
>> [ 2059.238437] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130482408+8) 4294967263
>> [ 2059.238439] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130482408+8) 4294967262
>> [ 2059.238440] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130482408+8) 4294967261
>> [ 2059.238441] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130482408+8) 4294967260
>> [ 2059.238443] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130482408+8) 4294967259
>> [ 2090.648331] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130483880+8) 4294967260
>> [ 2090.648399] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130483880+8) 4294967261
>> [ 2090.648402] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130483880+8) 4294967262
>> [ 2090.648414] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130483880+8) 4294967263
>> [ 2090.648428] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130483880+8) 4294967264
>> [ 2090.648540] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130483880+8) 4294967265
>> [ 2090.651017] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130483880+8) 4294967266
>> [ 2090.700177] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130483880+8) 4294967267
>> [ 2118.173167] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130483880+8) 4294967266
>> [ 2118.182657] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130483880+8) 4294967265
>> [ 2118.192147] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130483880+8) 4294967264
>> [ 2118.201638] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130483880+8) 4294967263
>> [ 2118.211138] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130483880+8) 4294967262
>> [ 2118.220626] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130483880+8) 4294967261
>> [ 2118.230111] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130483880+8) 4294967260
>> [ 2118.239602] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130483880+8) 4294967259
>> [ 2119.232574] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130486888+8) 4294967260
>> [ 2119.232574] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130486888+8) 4294967261
>> [ 2119.232691] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130486888+8) 4294967262
>> [ 2119.232707] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130486888+8) 4294967263
>> [ 2119.232880] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130486888+8) 4294967264
>> [ 2119.232926] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130486888+8) 4294967265
>> [ 2119.232990] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130486888+8) 4294967266
>> [ 2119.233054] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130486888+8) 4294967267
>> [ 2146.417917] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130486888+8) 4294967266
>> [ 2151.981747] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130486888+8) 4294967265
>> [ 2152.121412] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130486888+8) 4294967264
>> [ 2152.261047] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130486888+8) 4294967263
>> [ 2152.400699] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130486888+8) 4294967262
>> [ 2152.540356] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130486888+8) 4294967261
>> [ 2152.680005] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130486888+8) 4294967260
>> [ 2152.819653] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130486888+8) 4294967259
>> [ 2157.037069] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130488808+8) 4294967260
>> [ 2157.037363] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130488808+8) 4294967261
>> [ 2157.037405] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130488808+8) 4294967262
>> [ 2157.037421] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130488808+8) 4294967263
>> [ 2157.037446] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130488808+8) 4294967264
>> [ 2214.237201] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130488808+8) 4294967263
>> [ 2214.246685] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130488808+8) 4294967262
>> [ 2214.256174] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130488808+8) 4294967261
>> [ 2214.265665] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130488808+8) 4294967260
>> [ 2214.275152] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130488808+8) 4294967259
>> [ 2220.022835] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130492776+8) 4294967260
>> [ 2220.022859] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130492776+8) 4294967261
>> [ 2220.022876] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130492776+8) 4294967262
>> [ 2220.022912] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130492776+8) 4294967263
>> [ 2220.023258] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130492776+8) 4294967265
>> [ 2220.023161] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130492776+8) 4294967264
>> [ 2243.495792] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130495656+8) 4294967264
>> [ 2272.045830] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130499624+8) 4294967265
>> [ 2272.045833] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130499624+8) 4294967264
>> [ 2272.045835] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130499624+8) 4294967263
>> [ 2272.045837] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130499624+8) 4294967262
>> [ 2272.045838] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130499624+8) 4294967261
>> [ 2272.045840] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130499624+8) 4294967260
>> [ 2272.045841] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130499624+8) 4294967259
>> [ 2302.557785] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130503336+8) 4294967266
>> [ 2302.557787] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130503336+8) 4294967265
>> [ 2302.557789] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130503336+8) 4294967264
>> [ 2302.557791] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130503336+8) 4294967263
>> [ 2302.557793] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130503336+8) 4294967262
>> [ 2302.557796] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130503336+8) 4294967261
>> [ 2302.557797] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130503336+8) 4294967260
>> [ 2302.557799] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130503336+8) 4294967259
>> [ 2302.561904] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130505320+8) 4294967260
>> [ 2302.561926] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130505320+8) 4294967261
>> [ 2302.561957] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130505320+8) 4294967263
>> [ 2302.561933] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130505320+8) 4294967262
>> [ 2302.562006] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130505320+8) 4294967264
>> [ 2302.562203] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130505320+8) 4294967265
>> [ 2302.562232] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130505320+8) 4294967266
>> [ 2302.562597] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130505320+8) 4294967267
>> [ 2329.647721] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130505320+8) 4294967266
>> [ 2329.738196] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130505320+8) 4294967265
>> [ 2329.828677] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130505320+8) 4294967264
>> [ 2329.919153] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130505320+8) 4294967263
>> [ 2330.009644] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130505320+8) 4294967262
>> [ 2330.100125] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130505320+8) 4294967261
>> [ 2330.190603] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130505320+8) 4294967260
>> [ 2330.281085] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130505320+8) 4294967259
>> [ 2332.172188] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130506664+8) 4294967265
>> [ 2332.172198] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130506664+8) 4294967264
>> [ 2332.172233] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130506664+8) 4294967263
>> [ 2332.172242] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130506664+8) 4294967262
>> [ 2332.172255] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130506664+8) 4294967261
>> [ 2332.172264] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130506664+8) 4294967260
>> [ 2332.172278] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130506664+8) 4294967259
>> [ 2332.178323] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130508328+8) 4294967262
>> [ 2332.178317] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130508328+8) 4294967261
>> [ 2332.178310] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130508328+8) 4294967260
>> [ 2332.178326] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130508328+8) 4294967263
>> [ 2332.178394] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130508328+8) 4294967264
>> [ 2332.178580] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130508328+8) 4294967265
>> [ 2332.178600] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130508328+8) 4294967266
>> [ 2332.178697] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130508328+8) 4294967267
>> [ 2358.527771] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130508328+8) 4294967266
>> [ 2358.657096] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130508328+8) 4294967265
>> [ 2358.786383] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130508328+8) 4294967264
>> [ 2358.915693] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130508328+8) 4294967263
>> [ 2359.044994] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130508328+8) 4294967262
>> [ 2359.174296] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130508328+8) 4294967261
>> [ 2359.303592] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130508328+8) 4294967260
>> [ 2359.432875] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130508328+8) 4294967259
>> [ 2367.401519] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27111972904+8) 4294967260
>> [ 2367.410065] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27111972904+8) 4294967259
>> [ 2399.790368] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130512104+8) 4294967260
>> [ 2403.855440] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130512104+8) 4294967261
>> [ 2403.855574] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130512104+8) 4294967262
>> [ 2403.855636] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130512104+8) 4294967263
>> [ 2403.855687] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130512104+8) 4294967264
>> [ 2478.513548] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130512104+8) 4294967263
>> [ 2478.523034] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130512104+8) 4294967262
>> [ 2478.532518] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130512104+8) 4294967261
>> [ 2478.542003] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130512104+8) 4294967260
>> [ 2478.551487] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130512104+8) 4294967259
>> [ 2483.294420] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130518312+8) 4294967264
>> [ 2483.294422] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130518312+8) 4294967263
>> [ 2483.294423] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130518312+8) 4294967262
>> [ 2483.294425] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130518312+8) 4294967261
>> [ 2483.294426] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130518312+8) 4294967260
>> [ 2483.294428] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130518312+8) 4294967259
>> [ 2515.139576] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130521064+8) 4294967260
>> [ 2515.139576] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130521064+8) 4294967261
>> [ 2515.139584] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130521064+8) 4294967262
>> [ 2515.139592] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130521064+8) 4294967264
>> [ 2515.139587] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130521064+8) 4294967263
>> [ 2515.139593] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130521064+8) 4294967265
>> [ 2515.139795] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130521064+8) 4294967266
>> [ 2556.408113] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130524584+8) 4294967264
>> [ 2556.417600] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130524584+8) 4294967263
>> [ 2556.427088] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130524584+8) 4294967262
>> [ 2556.436578] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130524584+8) 4294967261
>> [ 2556.446066] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130524584+8) 4294967260
>> [ 2556.455551] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130524584+8) 4294967259
>> [ 2559.815547] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130528296+8) 4294967260
>> [ 2559.815563] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130528296+8) 4294967261
>> [ 2559.815793] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130528296+8) 4294967262
>> [ 2559.815874] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130528296+8) 4294967263
>> [ 2559.816031] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130528296+8) 4294967264
>> [ 2568.256111] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130528296+8) 4294967265
>> [ 2568.256157] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130528296+8) 4294967266
>> [ 2619.422458] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130530472+8) 4294967265
>> [ 2619.431942] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130530472+8) 4294967264
>> [ 2619.441449] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130530472+8) 4294967263
>> [ 2619.450948] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130530472+8) 4294967262
>> [ 2619.460435] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130530472+8) 4294967261
>> [ 2619.469921] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130530472+8) 4294967260
>> [ 2619.479412] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130530472+8) 4294967259
>> [ 2633.472211] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130534440+8) 4294967261
>> [ 2633.472205] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130534440+8) 4294967260
>> [ 2633.472305] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130534440+8) 4294967262
>> [ 2633.472427] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130534440+8) 4294967264
>> [ 2633.472417] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130534440+8) 4294967263
>> [ 2633.472587] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130534440+8) 4294967265
>> [ 2633.539700] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130534440+8) 4294967266
>> [ 2661.223491] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130534440+8) 4294967265
>> [ 2661.223493] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130534440+8) 4294967264
>> [ 2661.223494] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130534440+8) 4294967263
>> [ 2661.223496] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130534440+8) 4294967262
>> [ 2661.223497] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130534440+8) 4294967261
>> [ 2661.223498] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130534440+8) 4294967260
>> [ 2661.223500] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130534440+8) 4294967259
>> [ 2661.228040] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(539699176+8) 4294967260
>> [ 2706.576782] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(539699176+8) 4294967259
>> [ 2709.937157] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130541416+8) 4294967260
>> [ 2709.937171] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130541416+8) 4294967261
>> [ 2709.937316] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130541416+8) 4294967262
>> [ 2709.937650] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130541416+8) 4294967263
>> [ 2709.937717] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130541416+8) 4294967264
>> [ 2709.937724] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130541416+8) 4294967265
>> [ 2709.937725] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130541416+8) 4294967266
>> [ 2709.937737] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130541416+8) 4294967267
>> [ 2721.462599] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130541416+8) 4294967266
>> [ 2721.610877] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130541416+8) 4294967265
>> [ 2721.759136] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130541416+8) 4294967264
>> [ 2721.907488] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130541416+8) 4294967263
>> [ 2722.055771] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130541416+8) 4294967262
>> [ 2722.204050] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130541416+8) 4294967261
>> [ 2722.352331] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130541416+8) 4294967260
>> [ 2722.500592] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130541416+8) 4294967259
>> [ 2724.772625] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130543016+8) 4294967260
>> [ 2724.772751] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130543016+8) 4294967261
>> [ 2724.772938] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130543016+8) 4294967262
>> [ 2724.772988] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130543016+8) 4294967263
>> [ 2724.773119] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130543016+8) 4294967264
>> [ 2754.673788] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130543016+8) 4294967263
>> [ 2754.673790] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130543016+8) 4294967262
>> [ 2754.673791] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130543016+8) 4294967261
>> [ 2754.673794] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130543016+8) 4294967260
>> [ 2754.673795] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130543016+8) 4294967259
>> [ 2785.394053] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130547432+8) 4294967261
>> [ 2785.394056] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130547432+8) 4294967263
>> [ 2785.394059] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130547432+8) 4294967265
>> [ 2785.394054] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130547432+8) 4294967262
>> [ 2785.394058] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130547432+8) 4294967264
>> [ 2785.394050] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130547432+8) 4294967260
>> [ 2785.463401] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130547432+8) 4294967266
>> [ 2785.472247] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130547432+8) 4294967267
>> [ 2787.076731] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130547432+8) 4294967266
>> [ 2787.076732] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130547432+8) 4294967265
>> [ 2787.076734] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130547432+8) 4294967264
>> [ 2787.076735] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130547432+8) 4294967263
>> [ 2787.076736] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130547432+8) 4294967262
>> [ 2787.076738] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130547432+8) 4294967261
>> [ 2787.076739] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130547432+8) 4294967260
>> [ 2787.076740] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130547432+8) 4294967259
>> [ 2808.905214] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130550312+8) 4294967265
>> [ 2808.905333] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130550312+8) 4294967266
>> [ 2808.905388] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130550312+8) 4294967267
>> [ 2808.906939] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130550312+8) 4294967266
>> [ 2808.906941] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130550312+8) 4294967265
>> [ 2808.906943] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130550312+8) 4294967264
>> [ 2808.906944] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130550312+8) 4294967263
>> [ 2808.906946] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130550312+8) 4294967262
>> [ 2808.906947] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130550312+8) 4294967261
>> [ 2808.906950] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130550312+8) 4294967260
>> [ 2808.906952] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130550312+8) 4294967259
>> [ 2836.311276] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130552808+8) 4294967260
>> [ 2854.798417] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130552808+8) 4294967259
>> [ 2856.543067] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130552808+8) 4294967264
>> [ 2856.543070] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130552808+8) 4294967263
>> [ 2856.543073] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130552808+8) 4294967262
>> [ 2856.543075] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130552808+8) 4294967261
>> [ 2856.543077] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130552808+8) 4294967260
>> [ 2856.543079] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130552808+8) 4294967259
>> [ 2856.546312] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130558568+8) 4294967260
>> [ 2856.546314] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130558568+8) 4294967261
>> [ 2856.546421] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130558568+8) 4294967262
>> [ 2856.546509] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130558568+8) 4294967263
>> [ 2856.546926] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130558568+8) 4294967264
>> [ 2886.489550] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130558568+8) 4294967265
>> [ 2886.489595] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130558568+8) 4294967266
>> [ 2886.489713] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130558568+8) 4294967267
>> [ 2897.617989] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130558568+8) 4294967266
>> [ 2897.627477] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130558568+8) 4294967265
>> [ 2897.636962] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130558568+8) 4294967264
>> [ 2897.646444] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130558568+8) 4294967263
>> [ 2897.655920] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130558568+8) 4294967262
>> [ 2897.665409] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130558568+8) 4294967261
>> [ 2897.674910] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130558568+8) 4294967260
>> [ 2897.684404] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130558568+8) 4294967259
>> [ 2899.844282] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130560872+8) 4294967266
>> [ 2899.844316] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130560872+8) 4294967265
>> [ 2899.844354] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130560872+8) 4294967264
>> [ 2899.844382] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130560872+8) 4294967263
>> [ 2899.844423] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130560872+8) 4294967262
>> [ 2899.844462] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130560872+8) 4294967261
>> [ 2899.844516] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130560872+8) 4294967260
>> [ 2899.844570] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130560872+8) 4294967259
>> [ 2899.845690] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130563048+8) 4294967260
>> [ 2899.845966] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130563048+8) 4294967261
>> [ 2899.846019] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130563048+8) 4294967262
>> [ 2899.846062] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130563048+8) 4294967263
>> [ 2899.846186] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130563048+8) 4294967264
>> [ 2899.846207] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130563048+8) 4294967265
>> [ 2899.846260] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130563048+8) 4294967266
>> [ 2952.891498] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130563048+8) 4294967265
>> [ 2952.900984] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130563048+8) 4294967264
>> [ 2952.910478] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130563048+8) 4294967263
>> [ 2952.919966] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130563048+8) 4294967262
>> [ 2952.929461] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130563048+8) 4294967261
>> [ 2952.938950] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130563048+8) 4294967260
>> [ 2952.948431] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130563048+8) 4294967259
>> [ 2955.316494] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130566632+8) 4294967260
>> [ 2955.316704] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130566632+8) 4294967261
>> [ 2955.316809] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130566632+8) 4294967262
>> [ 2955.316988] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130566632+8) 4294967263
>> [ 2955.317105] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130566632+8) 4294967264
>> [ 2987.714377] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130566632+8) 4294967263
>> [ 2987.714379] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130566632+8) 4294967262
>> [ 2987.714381] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130566632+8) 4294967261
>> [ 2987.714383] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130566632+8) 4294967260
>> [ 2987.714385] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130566632+8) 4294967259
>> [ 2987.719137] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(1092459240+8) 4294967260
>> [ 3047.110275] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130574440+8) 4294967264
>> [ 3047.110276] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130574440+8) 4294967263
>> [ 3047.110277] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130574440+8) 4294967262
>> [ 3047.110278] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130574440+8) 4294967261
>> [ 3047.110279] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130574440+8) 4294967260
>> [ 3047.110281] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130574440+8) 4294967259
>> [ 3047.112501] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130577896+8) 4294967260
>> [ 3047.112711] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130577896+8) 4294967261
>> [ 3047.112750] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130577896+8) 4294967262
>> [ 3070.186991] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130577896+8) 4294967263
>> [ 3070.187120] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130577896+8) 4294967264
>> [ 3110.127145] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130577896+8) 4294967263
>> [ 3110.136633] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130577896+8) 4294967262
>> [ 3110.146121] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130577896+8) 4294967261
>> [ 3110.155611] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130577896+8) 4294967260
>> [ 3110.165103] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130577896+8) 4294967259
>> [ 3113.362512] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130581928+8) 4294967260
>> [ 3113.362527] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130581928+8) 4294967261
>> [ 3113.362737] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130581928+8) 4294967262
>> [ 3113.362788] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130581928+8) 4294967264
>> [ 3113.362772] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130581928+8) 4294967263
>> [ 3113.363524] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130581928+8) 4294967265
>> [ 3181.040787] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130581928+8) 4294967264
>> [ 3181.050278] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130581928+8) 4294967263
>> [ 3181.059767] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130581928+8) 4294967262
>> [ 3181.069267] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130581928+8) 4294967261
>> [ 3181.078760] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130581928+8) 4294967260
>> [ 3181.088248] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130581928+8) 4294967259
>> [ 3190.006331] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130586472+8) 4294967260
>> [ 3190.006353] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130586472+8) 4294967261
>> [ 3190.006523] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130586472+8) 4294967262
>> [ 3190.006526] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130586472+8) 4294967263
>> [ 3190.006576] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130586472+8) 4294967264
>> [ 3190.006604] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130586472+8) 4294967265
>> [ 3190.006676] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130586472+8) 4294967266
>> [ 3222.489157] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130590248+8) 4294967259
>> [ 3222.494665] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130593576+8) 4294967260
>> [ 3222.494810] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130593576+8) 4294967261
>> [ 3222.495400] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130593576+8) 4294967262
>> [ 3222.495460] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130593576+8) 4294967263
>> [ 3222.496203] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130593576+8) 4294967264
>> [ 3222.496266] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130593576+8) 4294967265
>> [ 3249.542100] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130593576+8) 4294967264
>> [ 3249.542102] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130593576+8) 4294967263
>> [ 3249.542103] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130593576+8) 4294967262
>> [ 3249.542105] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130593576+8) 4294967261
>> [ 3249.542107] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130593576+8) 4294967260
>> [ 3249.542109] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130593576+8) 4294967259
>> [ 3249.547575] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130590440+8) 4294967260
>> [ 3298.070385] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130603176+8) 4294967260
>> [ 3298.070466] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130603176+8) 4294967261
>> [ 3298.070767] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130603176+8) 4294967262
>> [ 3298.070824] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130603176+8) 4294967263
>> [ 3298.070896] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130603176+8) 4294967264
>> [ 3351.191989] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130603176+8) 4294967263
>> [ 3351.201478] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130603176+8) 4294967262
>> [ 3351.210961] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130603176+8) 4294967261
>> [ 3351.220447] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130603176+8) 4294967260
>> [ 3351.229931] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130603176+8) 4294967259
>> [ 3354.186090] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130606312+8) 4294967260
>> [ 3354.186174] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130606312+8) 4294967261
>> [ 3354.186453] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130606312+8) 4294967262
>> [ 3354.186600] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130606312+8) 4294967263
>> [ 3354.186610] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130606312+8) 4294967264
>> [ 3354.186666] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130606312+8) 4294967265
>> [ 3354.186682] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27130606312+8) 4294967266
>> [ 3395.962921] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130606312+8) 4294967265
>> [ 3395.972408] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130606312+8) 4294967264
>> [ 3395.981893] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130606312+8) 4294967263
>> [ 3395.991379] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130606312+8) 4294967262
>> [ 3396.000863] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130606312+8) 4294967261
>> [ 3396.010344] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130606312+8) 4294967260
>> [ 3396.019828] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27130606312+8) 4294967259
>> [ 3397.783940] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399959720+8) 4294967260
>> [ 3397.783984] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399959720+8) 4294967261
>> [ 3397.784015] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399959720+8) 4294967262
>> [ 3397.784039] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399959720+8) 4294967263
>> [ 3397.784102] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399959720+8) 4294967264
>> [ 3397.784112] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399959720+8) 4294967265
>> [ 3397.784206] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399959720+8) 4294967266
>> [ 3397.784239] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399959720+8) 4294967267
>> [ 3407.297456] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399959720+8) 4294967266
>> [ 3407.515478] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399959720+8) 4294967265
>> [ 3407.733622] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399959720+8) 4294967264
>> [ 3407.952516] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399959720+8) 4294967263
>> [ 3408.171430] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399959720+8) 4294967262
>> [ 3408.390355] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399959720+8) 4294967261
>> [ 3408.609270] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399959720+8) 4294967260
>> [ 3408.828226] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399959720+8) 4294967259
>> [ 3410.118755] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399965352+8) 4294967260
>> [ 3410.118912] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399965352+8) 4294967261
>> [ 3410.119044] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399965352+8) 4294967262
>> [ 3410.119183] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399965352+8) 4294967263
>> [ 3410.119190] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399965352+8) 4294967264
>> [ 3410.119398] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399965352+8) 4294967265
>> [ 3474.070919] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399965352+8) 4294967264
>> [ 3474.080400] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399965352+8) 4294967263
>> [ 3474.089879] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399965352+8) 4294967262
>> [ 3474.099370] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399965352+8) 4294967261
>> [ 3474.108856] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399965352+8) 4294967260
>> [ 3474.118342] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399965352+8) 4294967259
>> [ 3477.161290] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399969512+8) 4294967261
>> [ 3477.161249] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399969512+8) 4294967260
>> [ 3477.161478] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399969512+8) 4294967262
>> [ 3477.161505] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399969512+8) 4294967263
>> [ 3487.704510] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399969512+8) 4294967264
>> [ 3487.704567] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399969512+8) 4294967265
>> [ 3510.992084] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399969512+8) 4294967264
>> [ 3510.992086] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399969512+8) 4294967263
>> [ 3510.992088] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399969512+8) 4294967262
>> [ 3510.992089] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399969512+8) 4294967261
>> [ 3510.992090] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399969512+8) 4294967260
>> [ 3510.992091] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399969512+8) 4294967259
>> [ 3510.992993] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399973352+8) 4294967260
>> [ 3510.993007] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399973352+8) 4294967261
>> [ 3550.083557] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399973352+8) 4294967260
>> [ 3550.083561] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399973352+8) 4294967259
>> [ 3555.089305] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399973352+8) 4294967260
>> [ 3555.089386] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399973352+8) 4294967261
>> [ 3555.089618] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399973352+8) 4294967262
>> [ 3555.089635] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399973352+8) 4294967263
>> [ 3555.089655] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399973352+8) 4294967264
>> [ 3572.781054] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399973352+8) 4294967263
>> [ 3572.790547] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399973352+8) 4294967262
>> [ 3572.800034] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399973352+8) 4294967261
>> [ 3572.809523] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399973352+8) 4294967260
>> [ 3572.819005] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399973352+8) 4294967259
>> [ 3589.172647] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399976104+8) 4294967266
>> [ 3589.172750] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399976104+8) 4294967265
>> [ 3589.172860] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399976104+8) 4294967264
>> [ 3589.172991] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399976104+8) 4294967263
>> [ 3589.173151] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399976104+8) 4294967262
>> [ 3589.173314] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399976104+8) 4294967261
>> [ 3589.173391] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399976104+8) 4294967260
>> [ 3589.173461] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399976104+8) 4294967259
>> [ 3589.175972] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032743848+8) 4294967260
>> [ 3621.769395] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032743848+8) 4294967259
>> [ 3623.304014] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399975272+8) 4294967260
>> [ 3686.974958] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399986216+8) 4294967267
>> [ 3722.135513] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399986216+8) 4294967266
>> [ 3722.144998] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399986216+8) 4294967265
>> [ 3722.154484] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399986216+8) 4294967264
>> [ 3722.163972] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399986216+8) 4294967263
>> [ 3722.173455] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399986216+8) 4294967262
>> [ 3722.182939] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399986216+8) 4294967261
>> [ 3722.192426] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399986216+8) 4294967260
>> [ 3722.201912] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399986216+8) 4294967259
>> [ 3729.633922] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399989800+8) 4294967260
>> [ 3729.634199] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399989800+8) 4294967261
>> [ 3729.634228] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399989800+8) 4294967262
>> [ 3729.634351] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399989800+8) 4294967263
>> [ 3729.634466] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399989800+8) 4294967264
>> [ 3737.013926] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399989800+8) 4294967265
>> [ 3737.016635] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399989800+8) 4294967266
>> [ 3761.542817] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399989800+8) 4294967265
>> [ 3761.542819] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399989800+8) 4294967264
>> [ 3761.542820] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399989800+8) 4294967263
>> [ 3761.542822] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399989800+8) 4294967262
>> [ 3761.542824] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399989800+8) 4294967261
>> [ 3761.542826] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399989800+8) 4294967260
>> [ 3761.542827] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399989800+8) 4294967259
>> [ 3761.545145] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(4298178536+8) 4294967260
>> [ 3781.220916] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(4298178536+8) 4294967259
>> [ 3816.363850] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399990824+8) 4294967261
>> [ 3816.363852] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399990824+8) 4294967260
>> [ 3816.363853] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27399990824+8) 4294967259
>> [ 3816.366775] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399995816+8) 4294967260
>> [ 3816.367295] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399995816+8) 4294967261
>> [ 3816.367301] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399995816+8) 4294967262
>> [ 3816.367544] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399995816+8) 4294967263
>> [ 3816.367693] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399995816+8) 4294967264
>> [ 3816.368092] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399995816+8) 4294967265
>> [ 3843.302810] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27399995816+8) 4294967266
>> [ 3869.720089] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400001256+8) 4294967261
>> [ 3869.720097] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400001256+8) 4294967262
>> [ 3869.720194] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400001256+8) 4294967263
>> [ 3869.720213] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400001256+8) 4294967264
>> [ 3869.725214] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400001256+8) 4294967265
>> [ 3911.191478] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400001256+8) 4294967264
>> [ 3911.200970] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400001256+8) 4294967263
>> [ 3911.210456] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400001256+8) 4294967262
>> [ 3911.219942] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400001256+8) 4294967261
>> [ 3911.229426] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400001256+8) 4294967260
>> [ 3911.238911] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400001256+8) 4294967259
>> [ 3914.293028] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400004328+8) 4294967264
>> [ 3914.293031] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400004328+8) 4294967263
>> [ 3914.293033] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400004328+8) 4294967262
>> [ 3914.293035] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400004328+8) 4294967261
>> [ 3914.293038] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400004328+8) 4294967260
>> [ 3914.293040] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400004328+8) 4294967259
>> [ 3914.295622] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400007592+8) 4294967261
>> [ 3914.295641] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400007592+8) 4294967262
>> [ 3914.295643] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400007592+8) 4294967263
>> [ 3914.295621] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400007592+8) 4294967260
>> [ 3914.295871] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400007592+8) 4294967264
>> [ 3999.621383] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400007592+8) 4294967263
>> [ 3999.630885] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400007592+8) 4294967262
>> [ 3999.640370] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400007592+8) 4294967261
>> [ 3999.649865] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400007592+8) 4294967260
>> [ 3999.659351] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400007592+8) 4294967259
>> [ 4004.391868] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400016232+8) 4294967260
>> [ 4004.391913] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400016232+8) 4294967261
>> [ 4004.392117] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400016232+8) 4294967262
>> [ 4004.392564] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400016232+8) 4294967263
>> [ 4004.392579] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400016232+8) 4294967264
>> [ 4004.392650] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400016232+8) 4294967265
>> [ 4004.392858] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400016232+8) 4294967266
>> [ 4074.054694] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400016232+8) 4294967265
>> [ 4074.064183] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400016232+8) 4294967264
>> [ 4074.073668] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400016232+8) 4294967263
>> [ 4074.083155] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400016232+8) 4294967262
>> [ 4074.092647] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400016232+8) 4294967261
>> [ 4074.102149] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400016232+8) 4294967260
>> [ 4074.111642] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400016232+8) 4294967259
>> [ 4114.890444] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400020712+8) 4294967265
>> [ 4114.890445] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400020712+8) 4294967264
>> [ 4114.890446] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400020712+8) 4294967263
>> [ 4114.890447] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400020712+8) 4294967262
>> [ 4114.890448] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400020712+8) 4294967261
>> [ 4114.890449] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400020712+8) 4294967260
>> [ 4114.890450] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400020712+8) 4294967259
>> [ 4114.894014] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032743784+8) 4294967260
>> [ 4137.422104] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400026664+8) 4294967260
>> [ 4137.422134] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400026664+8) 4294967261
>> [ 4137.422222] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400026664+8) 4294967262
>> [ 4137.422380] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400026664+8) 4294967263
>> [ 4137.422447] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400026664+8) 4294967264
>> [ 4137.422527] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400026664+8) 4294967265
>> [ 4137.422809] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400026664+8) 4294967266
>> [ 4195.441417] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400026664+8) 4294967265
>> [ 4195.450902] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400026664+8) 4294967264
>> [ 4195.460386] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400026664+8) 4294967263
>> [ 4195.469873] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400026664+8) 4294967262
>> [ 4195.479360] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400026664+8) 4294967261
>> [ 4195.488848] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400026664+8) 4294967260
>> [ 4195.498336] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400026664+8) 4294967259
>> [ 4205.104432] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(6458132264+8) 4294967260
>> [ 4270.444837] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(6458132264+8) 4294967259
>> [ 4282.274860] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400036904+8) 4294967265
>> [ 4282.274879] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400036904+8) 4294967264
>> [ 4282.274897] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400036904+8) 4294967263
>> [ 4282.274916] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400036904+8) 4294967262
>> [ 4282.274936] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400036904+8) 4294967261
>> [ 4282.274955] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400036904+8) 4294967260
>> [ 4282.274975] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400036904+8) 4294967259
>> [ 4282.276460] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400039464+8) 4294967260
>> [ 4282.276797] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400039464+8) 4294967261
>> [ 4282.276964] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400039464+8) 4294967262
>> [ 4282.277061] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400039464+8) 4294967263
>> [ 4282.277143] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400039464+8) 4294967264
>> [ 4282.277191] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400039464+8) 4294967266
>> [ 4282.277191] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400039464+8) 4294967265
>> [ 4282.277271] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400039464+8) 4294967267
>> [ 4282.321155] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400039464+8) 4294967266
>> [ 4282.387435] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400039464+8) 4294967265
>> [ 4282.448733] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400039464+8) 4294967264
>> [ 4282.448742] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400039464+8) 4294967263
>> [ 4282.448751] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400039464+8) 4294967262
>> [ 4282.448759] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400039464+8) 4294967261
>> [ 4282.448767] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400039464+8) 4294967260
>> [ 4282.448775] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400039464+8) 4294967259
>> [ 4315.061841] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400040168+8) 4294967260
>> [ 4315.061855] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400040168+8) 4294967262
>> [ 4315.061844] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400040168+8) 4294967261
>> [ 4315.061924] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400040168+8) 4294967263
>> [ 4315.061976] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400040168+8) 4294967264
>> [ 4315.063503] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400040168+8) 4294967265
>> [ 4382.511212] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400040168+8) 4294967264
>> [ 4382.520702] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400040168+8) 4294967263
>> [ 4382.530180] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400040168+8) 4294967262
>> [ 4382.539665] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400040168+8) 4294967261
>> [ 4382.549163] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400040168+8) 4294967260
>> [ 4382.558657] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400040168+8) 4294967259
>> [ 4387.176732] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400046440+8) 4294967260
>> [ 4387.176821] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400046440+8) 4294967261
>> [ 4387.176898] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400046440+8) 4294967262
>> [ 4387.177030] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400046440+8) 4294967263
>> [ 4387.177229] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400046440+8) 4294967264
>> [ 4387.177270] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400046440+8) 4294967265
>> [ 4457.957710] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400046440+8) 4294967264
>> [ 4457.957715] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400046440+8) 4294967263
>> [ 4457.957719] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400046440+8) 4294967262
>> [ 4457.957723] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400046440+8) 4294967261
>> [ 4457.957727] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400046440+8) 4294967260
>> [ 4457.957731] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400046440+8) 4294967259
>> [ 4457.961270] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400051432+8) 4294967260
>> [ 4457.961406] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400051432+8) 4294967261
>> [ 4457.961619] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400051432+8) 4294967262
>> [ 4457.961651] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400051432+8) 4294967264
>> [ 4457.961806] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400051432+8) 4294967265
>> [ 4457.961645] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400051432+8) 4294967263
>> [ 4485.589613] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400051432+8) 4294967264
>> [ 4485.589615] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400051432+8) 4294967263
>> [ 4485.589616] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400051432+8) 4294967262
>> [ 4485.589617] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400051432+8) 4294967261
>> [ 4485.589618] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400051432+8) 4294967260
>> [ 4485.589619] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400051432+8) 4294967259
>> [ 4485.593052] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400056936+8) 4294967260
>> [ 4485.593052] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400056936+8) 4294967261
>> [ 4485.593288] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400056936+8) 4294967262
>> [ 4485.593416] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400056936+8) 4294967263
>> [ 4485.593532] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400056936+8) 4294967264
>> [ 4485.593652] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400056936+8) 4294967265
>> [ 4485.593678] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400056936+8) 4294967266
>> [ 4485.850480] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400056936+8) 4294967267
>> [ 4515.537222] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400056936+8) 4294967266
>> [ 4515.537223] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400056936+8) 4294967265
>> [ 4515.537224] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400056936+8) 4294967264
>> [ 4515.537226] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400056936+8) 4294967263
>> [ 4515.537227] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400056936+8) 4294967262
>> [ 4515.537228] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400056936+8) 4294967261
>> [ 4515.537229] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400056936+8) 4294967260
>> [ 4515.537231] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400056936+8) 4294967259
>> [ 4515.539155] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400058088+8) 4294967260
>> [ 4515.539253] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400058088+8) 4294967261
>> [ 4515.539324] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400058088+8) 4294967262
>> [ 4515.539513] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400058088+8) 4294967263
>> [ 4515.539522] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400058088+8) 4294967264
>> [ 4543.939187] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400058088+8) 4294967265
>> [ 4567.298898] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400058088+8) 4294967264
>> [ 4567.308382] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400058088+8) 4294967263
>> [ 4567.317870] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400058088+8) 4294967262
>> [ 4567.327355] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400058088+8) 4294967261
>> [ 4567.336851] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400058088+8) 4294967260
>> [ 4567.346342] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400058088+8) 4294967259
>> [ 4574.769978] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400062760+8) 4294967260
>> [ 4574.770644] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400062760+8) 4294967261
>> [ 4574.770713] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400062760+8) 4294967262
>> [ 4585.659234] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400062760+8) 4294967263
>> [ 4585.659638] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400062760+8) 4294967264
>> [ 4585.659851] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400062760+8) 4294967265
>> [ 4628.062519] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400062760+8) 4294967264
>> [ 4628.062521] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400062760+8) 4294967263
>> [ 4628.062522] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400062760+8) 4294967262
>> [ 4628.062524] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400062760+8) 4294967261
>> [ 4628.062525] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400062760+8) 4294967260
>> [ 4628.062526] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400062760+8) 4294967259
>> [ 4628.067547] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400067240+8) 4294967260
>> [ 4628.067553] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400067240+8) 4294967262
>> [ 4628.067549] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400067240+8) 4294967261
>> [ 4628.067556] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400067240+8) 4294967263
>> [ 4628.067558] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400067240+8) 4294967264
>> [ 4628.067643] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400067240+8) 4294967265
>> [ 4628.067650] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400067240+8) 4294967266
>> [ 4655.735972] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400069224+8) 4294967266
>> [ 4655.738016] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400069224+8) 4294967267
>> [ 4655.740269] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400069224+8) 4294967266
>> [ 4655.740270] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400069224+8) 4294967265
>> [ 4655.740271] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400069224+8) 4294967264
>> [ 4655.740273] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400069224+8) 4294967263
>> [ 4655.740274] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400069224+8) 4294967262
>> [ 4655.740275] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400069224+8) 4294967261
>> [ 4655.740277] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400069224+8) 4294967260
>> [ 4655.740278] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400069224+8) 4294967259
>> [ 4655.744826] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400071144+8) 4294967260
>> [ 4655.745042] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400071144+8) 4294967261
>> [ 4655.745074] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400071144+8) 4294967262
>> [ 4655.745162] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400071144+8) 4294967263
>> [ 4684.693786] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400071144+8) 4294967264
>> [ 4707.657198] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400071144+8) 4294967263
>> [ 4707.666685] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400071144+8) 4294967262
>> [ 4707.676172] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400071144+8) 4294967261
>> [ 4707.685664] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400071144+8) 4294967260
>> [ 4707.695155] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400071144+8) 4294967259
>> [ 4714.104353] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400074856+8) 4294967260
>> [ 4714.104370] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400074856+8) 4294967261
>> [ 4714.104532] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400074856+8) 4294967262
>> [ 4714.104556] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400074856+8) 4294967263
>> [ 4714.104738] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400074856+8) 4294967264
>> [ 4714.104749] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400074856+8) 4294967265
>> [ 4714.104870] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400074856+8) 4294967266
>> [ 4767.415146] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400074856+8) 4294967265
>> [ 4767.424642] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400074856+8) 4294967264
>> [ 4767.434126] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400074856+8) 4294967263
>> [ 4767.443610] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400074856+8) 4294967262
>> [ 4767.453092] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400074856+8) 4294967261
>> [ 4767.462576] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400074856+8) 4294967260
>> [ 4767.472063] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400074856+8) 4294967259
>> [ 4772.506161] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400078056+8) 4294967260
>> [ 4772.506215] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400078056+8) 4294967261
>> [ 4772.506341] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400078056+8) 4294967262
>> [ 4772.506665] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400078056+8) 4294967263
>> [ 4772.506877] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400078056+8) 4294967264
>> [ 4772.507010] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400078056+8) 4294967265
>> [ 4788.406891] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400078056+8) 4294967266
>> [ 4841.522571] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400085928+8) 4294967260
>> [ 4841.523093] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27400085928+8) 4294967261
>> [ 4907.596094] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400085928+8) 4294967260
>> [ 4907.596096] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27400085928+8) 4294967259
>> [ 4907.596899] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27651747176+8) 4294967260
>> [ 4973.644083] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27651747176+8) 4294967259
>> [ 4983.401423] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667021416+8) 4294967260
>> [ 4983.401434] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667021416+8) 4294967261
>> [ 4983.401439] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667021416+8) 4294967262
>> [ 4983.412449] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667021416+8) 4294967261
>> [ 4983.412450] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667021416+8) 4294967260
>> [ 4983.412452] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667021416+8) 4294967259
>> [ 5009.844830] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667021416+8) 4294967263
>> [ 5009.844831] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667021416+8) 4294967262
>> [ 5009.844832] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667021416+8) 4294967261
>> [ 5009.844834] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667021416+8) 4294967260
>> [ 5009.844835] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667021416+8) 4294967259
>> [ 5036.841498] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667025832+8) 4294967260
>> [ 5036.841516] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667025832+8) 4294967261
>> [ 5036.841589] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667025832+8) 4294967262
>> [ 5036.841711] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667025832+8) 4294967263
>> [ 5036.841866] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667025832+8) 4294967264
>> [ 5036.842021] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667025832+8) 4294967265
>> [ 5065.748527] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667025832+8) 4294967264
>> [ 5065.758011] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667025832+8) 4294967263
>> [ 5065.767510] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667025832+8) 4294967262
>> [ 5065.776985] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667025832+8) 4294967261
>> [ 5065.786473] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667025832+8) 4294967260
>> [ 5065.795964] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667025832+8) 4294967259
>> [ 5069.198341] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667029032+8) 4294967260
>> [ 5069.198447] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667029032+8) 4294967261
>> [ 5069.198475] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667029032+8) 4294967262
>> [ 5069.198565] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667029032+8) 4294967263
>> [ 5069.198600] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667029032+8) 4294967264
>> [ 5069.198657] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667029032+8) 4294967265
>> [ 5069.198719] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667029032+8) 4294967266
>> [ 5069.198749] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667029032+8) 4294967267
>> [ 5158.739304] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667030504+8) 4294967265
>> [ 5158.748804] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667030504+8) 4294967264
>> [ 5158.758295] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667030504+8) 4294967263
>> [ 5158.767784] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667030504+8) 4294967262
>> [ 5158.777267] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667030504+8) 4294967261
>> [ 5158.786749] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667030504+8) 4294967260
>> [ 5158.796231] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667030504+8) 4294967259
>> [ 5174.398776] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667037928+8) 4294967260
>> [ 5174.398877] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667037928+8) 4294967261
>> [ 5174.398898] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667037928+8) 4294967262
>> [ 5174.398990] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667037928+8) 4294967263
>> [ 5174.399068] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667037928+8) 4294967264
>> [ 5174.399165] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667037928+8) 4294967265
>> [ 5215.123596] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667037928+8) 4294967264
>> [ 5215.133088] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667037928+8) 4294967263
>> [ 5215.142587] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667037928+8) 4294967262
>> [ 5215.152066] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667037928+8) 4294967261
>> [ 5215.161549] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667037928+8) 4294967260
>> [ 5215.171035] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667037928+8) 4294967259
>> [ 5223.954743] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667042408+8) 4294967260
>> [ 5223.954779] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667042408+8) 4294967261
>> [ 5223.954951] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667042408+8) 4294967262
>> [ 5223.955007] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667042408+8) 4294967263
>> [ 5223.955223] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667042408+8) 4294967264
>> [ 5223.955228] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667042408+8) 4294967265
>> [ 5223.955230] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667042408+8) 4294967266
>> [ 5223.955472] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667042408+8) 4294967267
>> [ 5259.738014] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667042408+8) 4294967266
>> [ 5260.031050] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667042408+8) 4294967265
>> [ 5260.324115] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667042408+8) 4294967264
>> [ 5260.617186] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667042408+8) 4294967263
>> [ 5260.910270] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667042408+8) 4294967262
>> [ 5261.203354] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667042408+8) 4294967261
>> [ 5261.496406] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667042408+8) 4294967260
>> [ 5261.789480] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667042408+8) 4294967259
>> [ 5265.172862] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667045608+8) 4294967260
>> [ 5265.173244] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667045608+8) 4294967261
>> [ 5265.173322] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667045608+8) 4294967262
>> [ 5265.173763] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667045608+8) 4294967263
>> [ 5265.173927] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667045608+8) 4294967265
>> [ 5265.173927] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667045608+8) 4294967264
>> [ 5265.173928] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667045608+8) 4294967266
>> [ 5265.173973] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667045608+8) 4294967267
>> [ 5294.960280] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667045608+8) 4294967266
>> [ 5295.249813] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667045608+8) 4294967265
>> [ 5295.539340] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667045608+8) 4294967264
>> [ 5295.829752] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667045608+8) 4294967263
>> [ 5296.120184] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667045608+8) 4294967262
>> [ 5296.410623] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667045608+8) 4294967261
>> [ 5296.701004] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667045608+8) 4294967260
>> [ 5296.991418] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667045608+8) 4294967259
>> [ 5298.908411] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667048360+8) 4294967260
>> [ 5298.908458] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667048360+8) 4294967261
>> [ 5298.908544] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667048360+8) 4294967262
>> [ 5298.908650] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667048360+8) 4294967263
>> [ 5298.908710] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667048360+8) 4294967264
>> [ 5298.909051] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667048360+8) 4294967265
>> [ 5413.856013] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667058856+8) 4294967266
>> [ 5446.671677] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667058856+8) 4294967265
>> [ 5446.671679] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667058856+8) 4294967264
>> [ 5446.671680] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667058856+8) 4294967263
>> [ 5446.671681] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667058856+8) 4294967262
>> [ 5446.671682] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667058856+8) 4294967261
>> [ 5446.671683] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667058856+8) 4294967260
>> [ 5446.671684] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667058856+8) 4294967259
>> [ 5479.015532] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667064808+8) 4294967260
>> [ 5479.015632] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667064808+8) 4294967261
>> [ 5479.015683] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667064808+8) 4294967262
>> [ 5479.015735] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667064808+8) 4294967263
>> [ 5492.731793] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667064808+8) 4294967264
>> [ 5492.731911] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667064808+8) 4294967265
>> [ 5506.007986] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667064808+8) 4294967264
>> [ 5506.007988] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667064808+8) 4294967263
>> [ 5506.007991] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667064808+8) 4294967262
>> [ 5506.007994] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667064808+8) 4294967261
>> [ 5506.007997] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667064808+8) 4294967260
>> [ 5506.008000] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667064808+8) 4294967259
>> [ 5506.011738] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667070888+8) 4294967260
>> [ 5506.011854] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667070888+8) 4294967261
>> [ 5506.011861] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667070888+8) 4294967262
>> [ 5506.012133] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667070888+8) 4294967263
>> [ 5506.012143] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667070888+8) 4294967264
>> [ 5555.890832] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667070888+8) 4294967263
>> [ 5555.900322] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667070888+8) 4294967262
>> [ 5555.909852] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667070888+8) 4294967261
>> [ 5555.919336] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667070888+8) 4294967260
>> [ 5555.928823] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667070888+8) 4294967259
>> [ 5574.002280] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667074728+8) 4294967260
>> [ 5574.002313] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667074728+8) 4294967261
>> [ 5574.002403] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667074728+8) 4294967262
>> [ 5574.002468] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667074728+8) 4294967263
>> [ 5574.002561] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667074728+8) 4294967264
>> [ 5574.002645] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667074728+8) 4294967265
>> [ 5606.796975] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667074728+8) 4294967264
>> [ 5606.796977] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667074728+8) 4294967263
>> [ 5606.796978] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667074728+8) 4294967262
>> [ 5606.796979] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667074728+8) 4294967261
>> [ 5606.796981] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667074728+8) 4294967260
>> [ 5606.796982] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667074728+8) 4294967259
>> [ 5606.798208] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667079720+8) 4294967260
>> [ 5606.798527] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667079720+8) 4294967261
>> [ 5606.798585] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667079720+8) 4294967262
>> [ 5606.798607] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667079720+8) 4294967263
>> [ 5606.803857] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667079720+8) 4294967264
>> [ 5606.804282] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667079720+8) 4294967265
>> [ 5639.962722] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667079720+8) 4294967266
>> [ 5652.645345] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667079720+8) 4294967265
>> [ 5652.654833] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667079720+8) 4294967264
>> [ 5652.664323] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667079720+8) 4294967263
>> [ 5652.673815] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667079720+8) 4294967262
>> [ 5652.683294] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667079720+8) 4294967261
>> [ 5652.692781] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667079720+8) 4294967260
>> [ 5654.603101] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667079720+8) 4294967259
>> [ 5654.613230] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667080872+8) 4294967260
>> [ 5654.613572] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667080872+8) 4294967261
>> [ 5654.613687] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667080872+8) 4294967262
>> [ 5654.613814] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667080872+8) 4294967263
>> [ 5654.614055] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667080872+8) 4294967264
>> [ 5683.045381] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667080872+8) 4294967263
>> [ 5683.045383] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667080872+8) 4294967262
>> [ 5683.045385] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667080872+8) 4294967261
>> [ 5683.045387] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667080872+8) 4294967260
>> [ 5683.045388] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667080872+8) 4294967259
>> [ 5683.048586] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667086696+8) 4294967260
>> [ 5683.048965] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667086696+8) 4294967261
>> [ 5683.049073] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667086696+8) 4294967262
>> [ 5683.049140] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667086696+8) 4294967263
>> [ 5683.049162] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667086696+8) 4294967264
>> [ 5683.049196] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667086696+8) 4294967265
>> [ 5683.049256] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667086696+8) 4294967266
>> [ 5683.474474] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667086696+8) 4294967267
>> [ 5723.855633] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667086696+8) 4294967266
>> [ 5724.027114] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667086696+8) 4294967265
>> [ 5724.198621] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667086696+8) 4294967264
>> [ 5724.370117] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667086696+8) 4294967263
>> [ 5724.541614] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667086696+8) 4294967262
>> [ 5724.713065] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667086696+8) 4294967261
>> [ 5724.884518] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667086696+8) 4294967260
>> [ 5725.055989] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667086696+8) 4294967259
>> [ 5730.407790] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667087784+8) 4294967260
>> [ 5730.407821] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667087784+8) 4294967261
>> [ 5730.407937] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667087784+8) 4294967263
>> [ 5730.407896] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667087784+8) 4294967262
>> [ 5730.408159] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667087784+8) 4294967265
>> [ 5730.408143] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667087784+8) 4294967264
>> [ 5730.408353] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667087784+8) 4294967266
>> [ 5758.122868] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667094824+8) 4294967260
>> [ 5758.123578] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667094824+8) 4294967261
>> [ 5758.123627] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667094824+8) 4294967262
>> [ 5758.130240] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667094824+8) 4294967263
>> [ 5758.130420] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667094824+8) 4294967264
>> [ 5758.130534] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667094824+8) 4294967265
>> [ 5846.663594] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667098600+8) 4294967264
>> [ 5846.673081] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667098600+8) 4294967263
>> [ 5846.682568] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667098600+8) 4294967262
>> [ 5846.692061] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667098600+8) 4294967261
>> [ 5846.701549] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667098600+8) 4294967260
>> [ 5846.711038] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667098600+8) 4294967259
>> [ 5911.098887] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667106344+8) 4294967265
>> [ 5911.108378] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667106344+8) 4294967264
>> [ 5911.117873] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667106344+8) 4294967263
>> [ 5911.127372] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667106344+8) 4294967262
>> [ 5911.136857] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667106344+8) 4294967261
>> [ 5911.146341] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667106344+8) 4294967260
>> [ 5911.155824] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667106344+8) 4294967259
>> [ 5928.422955] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667111592+8) 4294967260
>> [ 5928.422960] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667111592+8) 4294967261
>> [ 5928.422966] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667111592+8) 4294967262
>> [ 5928.422974] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667111592+8) 4294967264
>> [ 5928.422972] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27667111592+8) 4294967263
>> [ 6014.681387] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667117352+8) 4294967265
>> [ 6014.690871] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667117352+8) 4294967264
>> [ 6014.700360] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667117352+8) 4294967263
>> [ 6014.709859] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667117352+8) 4294967262
>> [ 6014.719355] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667117352+8) 4294967261
>> [ 6014.728844] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667117352+8) 4294967260
>> [ 6014.738332] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667117352+8) 4294967259
>> [ 6056.379708] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667123432+8) 4294967265
>> [ 6056.389200] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667123432+8) 4294967264
>> [ 6056.398687] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667123432+8) 4294967263
>> [ 6056.408178] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667123432+8) 4294967262
>> [ 6056.417667] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667123432+8) 4294967261
>> [ 6056.427155] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667123432+8) 4294967260
>> [ 6056.436640] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27667123432+8) 4294967259
>> [ 6063.789506] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935493416+8) 4294967260
>> [ 6063.789738] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935493416+8) 4294967261
>> [ 6063.789989] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935493416+8) 4294967262
>> [ 6063.790034] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935493416+8) 4294967263
>> [ 6063.790190] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935493416+8) 4294967264
>> [ 6063.790287] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935493416+8) 4294967265
>> [ 6078.230963] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935493416+8) 4294967266
>> [ 6105.353125] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935493416+8) 4294967265
>> [ 6105.362612] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935493416+8) 4294967264
>> [ 6105.372093] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935493416+8) 4294967263
>> [ 6105.381577] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935493416+8) 4294967262
>> [ 6105.391064] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935493416+8) 4294967261
>> [ 6105.400555] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935493416+8) 4294967260
>> [ 6105.410041] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935493416+8) 4294967259
>> [ 6128.587354] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27920223080+8) 4294967260
>> [ 6201.907683] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27920223080+8) 4294967259
>> [ 6210.113728] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032744680+8) 4294967259
>> [ 6283.753223] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935506280+8) 4294967264
>> [ 6283.762710] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935506280+8) 4294967263
>> [ 6283.772194] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935506280+8) 4294967262
>> [ 6283.781677] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935506280+8) 4294967261
>> [ 6283.791163] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935506280+8) 4294967260
>> [ 6283.800647] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935506280+8) 4294967259
>> [ 6294.185205] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935512488+8) 4294967260
>> [ 6294.185349] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935512488+8) 4294967261
>> [ 6354.564956] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935517864+8) 4294967266
>> [ 6354.565008] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935517864+8) 4294967265
>> [ 6354.565050] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935517864+8) 4294967264
>> [ 6354.565103] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935517864+8) 4294967263
>> [ 6354.565143] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935517864+8) 4294967262
>> [ 6354.565198] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935517864+8) 4294967261
>> [ 6354.565250] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935517864+8) 4294967260
>> [ 6354.565295] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935517864+8) 4294967259
>> [ 6354.571582] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935519464+8) 4294967260
>> [ 6354.571613] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935519464+8) 4294967261
>> [ 6354.571614] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935519464+8) 4294967262
>> [ 6354.572095] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935519464+8) 4294967263
>> [ 6381.572101] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935519464+8) 4294967264
>> [ 6381.572150] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935519464+8) 4294967265
>> [ 6381.572462] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935519464+8) 4294967266
>> [ 6417.668789] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935519464+8) 4294967265
>> [ 6417.678285] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935519464+8) 4294967264
>> [ 6417.687773] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935519464+8) 4294967263
>> [ 6417.697266] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935519464+8) 4294967262
>> [ 6417.706822] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935519464+8) 4294967261
>> [ 6417.716318] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935519464+8) 4294967260
>> [ 6417.725807] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935519464+8) 4294967259
>> [ 6442.242691] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935524328+8) 4294967260
>> [ 6442.242776] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935524328+8) 4294967261
>> [ 6442.242901] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935524328+8) 4294967262
>> [ 6442.242998] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935524328+8) 4294967263
>> [ 6442.243060] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935524328+8) 4294967264
>> [ 6442.243109] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935524328+8) 4294967265
>> [ 6487.368252] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935524328+8) 4294967264
>> [ 6487.368256] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935524328+8) 4294967263
>> [ 6487.384984] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935524328+8) 4294967262
>> [ 6487.401709] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935524328+8) 4294967261
>> [ 6487.418441] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935524328+8) 4294967260
>> [ 6487.418447] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935524328+8) 4294967259
>> [ 6512.350543] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935529384+8) 4294967260
>> [ 6512.351290] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935529384+8) 4294967261
>> [ 6512.351395] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935529384+8) 4294967262
>> [ 6512.351419] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935529384+8) 4294967263
>> [ 6512.351565] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935529384+8) 4294967264
>> [ 6512.351578] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935529384+8) 4294967265
>> [ 6512.351611] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935529384+8) 4294967266
>> [ 6558.339111] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935529384+8) 4294967265
>> [ 6558.339113] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935529384+8) 4294967264
>> [ 6558.339115] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935529384+8) 4294967263
>> [ 6558.339118] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935529384+8) 4294967262
>> [ 6558.339120] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935529384+8) 4294967261
>> [ 6558.339122] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935529384+8) 4294967260
>> [ 6558.339123] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935529384+8) 4294967259
>> [ 6604.012612] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935535336+8) 4294967265
>> [ 6604.012615] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935535336+8) 4294967264
>> [ 6604.012617] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935535336+8) 4294967263
>> [ 6604.012619] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935535336+8) 4294967262
>> [ 6604.012622] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935535336+8) 4294967261
>> [ 6604.012624] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935535336+8) 4294967260
>> [ 6604.012626] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935535336+8) 4294967259
>> [ 6636.116612] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935541672+8) 4294967260
>> [ 6636.117018] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935541672+8) 4294967261
>> [ 6636.117064] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935541672+8) 4294967262
>> [ 6636.117191] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935541672+8) 4294967263
>> [ 6636.117217] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935541672+8) 4294967265
>> [ 6636.117204] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935541672+8) 4294967264
>> [ 6636.117365] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935541672+8) 4294967266
>> [ 6697.656762] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935541672+8) 4294967265
>> [ 6697.666250] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935541672+8) 4294967264
>> [ 6697.675731] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935541672+8) 4294967263
>> [ 6697.685213] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935541672+8) 4294967262
>> [ 6697.694703] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935541672+8) 4294967261
>> [ 6697.704188] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935541672+8) 4294967260
>> [ 6697.713685] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935541672+8) 4294967259
>> [ 6699.748818] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935546472+8) 4294967260
>> [ 6699.749045] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935546472+8) 4294967261
>> [ 6699.749350] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935546472+8) 4294967262
>> [ 6699.749488] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935546472+8) 4294967264
>> [ 6699.749487] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935546472+8) 4294967263
>> [ 6699.749673] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935546472+8) 4294967265
>> [ 6700.169570] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935546472+8) 4294967266
>> [ 6714.982644] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935551336+8) 4294967264
>> [ 6714.982749] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935551336+8) 4294967265
>> [ 6752.225916] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935551336+8) 4294967264
>> [ 6752.235410] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935551336+8) 4294967263
>> [ 6752.244901] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935551336+8) 4294967262
>> [ 6752.254387] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935551336+8) 4294967261
>> [ 6752.263875] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935551336+8) 4294967260
>> [ 6752.273361] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935551336+8) 4294967259
>> [ 6763.509990] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935556136+8) 4294967260
>> [ 6763.510135] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935556136+8) 4294967261
>> [ 6763.510150] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935556136+8) 4294967262
>> [ 6763.510183] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935556136+8) 4294967263
>> [ 6763.510242] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935556136+8) 4294967264
>> [ 6763.510270] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935556136+8) 4294967265
>> [ 6763.512906] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935556136+8) 4294967266
>> [ 6823.022727] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935556136+8) 4294967265
>> [ 6823.022730] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935556136+8) 4294967264
>> [ 6823.022731] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935556136+8) 4294967263
>> [ 6823.022734] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935556136+8) 4294967262
>> [ 6823.022735] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935556136+8) 4294967261
>> [ 6823.022736] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935556136+8) 4294967260
>> [ 6823.022738] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935556136+8) 4294967259
>> [ 6823.024701] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935561512+8) 4294967260
>> [ 6823.024824] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935561512+8) 4294967261
>> [ 6823.025069] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935561512+8) 4294967263
>> [ 6823.024976] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935561512+8) 4294967262
>> [ 6823.025323] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935561512+8) 4294967264
>> [ 6823.025427] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935561512+8) 4294967265
>> [ 6929.234367] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935561512+8) 4294967264
>> [ 6929.243863] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935561512+8) 4294967263
>> [ 6929.253358] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935561512+8) 4294967262
>> [ 6929.262845] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935561512+8) 4294967261
>> [ 6929.272333] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935561512+8) 4294967260
>> [ 6929.281822] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935561512+8) 4294967259
>> [ 6930.403685] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935567784+8) 4294967260
>> [ 6930.403904] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935567784+8) 4294967261
>> [ 6930.404088] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935567784+8) 4294967262
>> [ 6930.404223] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935567784+8) 4294967263
>> [ 6930.404286] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935567784+8) 4294967264
>> [ 6930.404292] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935567784+8) 4294967265
>> [ 6994.814514] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935567784+8) 4294967264
>> [ 6994.824001] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935567784+8) 4294967263
>> [ 6994.833494] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935567784+8) 4294967262
>> [ 6994.842983] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935567784+8) 4294967261
>> [ 6994.852473] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935567784+8) 4294967260
>> [ 6994.861960] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935567784+8) 4294967259
>> [ 6997.854357] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935572712+8) 4294967265
>> [ 7031.426286] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935572712+8) 4294967264
>> [ 7031.435774] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935572712+8) 4294967263
>> [ 7031.452511] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935572712+8) 4294967262
>> [ 7031.468341] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935572712+8) 4294967261
>> [ 7031.484182] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935572712+8) 4294967260
>> [ 7039.434351] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935572712+8) 4294967259
>> [ 7045.236931] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935578664+8) 4294967260
>> [ 7045.237482] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935578664+8) 4294967261
>> [ 7045.237696] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935578664+8) 4294967262
>> [ 7045.237743] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935578664+8) 4294967263
>> [ 7056.937353] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935578664+8) 4294967264
>> [ 7056.937578] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935578664+8) 4294967265
>> [ 7056.940551] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935578664+8) 4294967264
>> [ 7056.940553] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935578664+8) 4294967263
>> [ 7056.940554] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935578664+8) 4294967262
>> [ 7056.940555] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935578664+8) 4294967261
>> [ 7056.940556] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935578664+8) 4294967260
>> [ 7056.940557] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935578664+8) 4294967259
>> [ 7083.864814] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935579560+8) 4294967260
>> [ 7083.865053] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935579560+8) 4294967262
>> [ 7083.865036] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935579560+8) 4294967261
>> [ 7083.865102] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935579560+8) 4294967263
>> [ 7083.865159] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935579560+8) 4294967264
>> [ 7083.964009] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935579560+8) 4294967265
>> [ 7095.497485] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935579560+8) 4294967266
>> [ 7155.158072] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935579560+8) 4294967265
>> [ 7155.158073] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935579560+8) 4294967264
>> [ 7155.158074] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935579560+8) 4294967263
>> [ 7155.158076] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935579560+8) 4294967262
>> [ 7155.158077] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935579560+8) 4294967261
>> [ 7155.158078] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935579560+8) 4294967260
>> [ 7155.158079] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935579560+8) 4294967259
>> [ 7155.165525] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935586856+8) 4294967260
>> [ 7180.285881] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935586856+8) 4294967261
>> [ 7183.167275] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935586856+8) 4294967262
>> [ 7183.414146] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935586856+8) 4294967263
>> [ 7224.653276] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935586856+8) 4294967265
>> [ 7224.662765] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935586856+8) 4294967264
>> [ 7224.672249] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935586856+8) 4294967263
>> [ 7224.681736] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935586856+8) 4294967262
>> [ 7224.691228] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935586856+8) 4294967261
>> [ 7224.700720] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935586856+8) 4294967260
>> [ 7224.710207] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935586856+8) 4294967259
>> [ 7229.399854] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935593320+8) 4294967260
>> [ 7229.399922] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935593320+8) 4294967261
>> [ 7229.400041] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935593320+8) 4294967262
>> [ 7229.400099] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935593320+8) 4294967263
>> [ 7229.400157] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935593320+8) 4294967264
>> [ 7229.400221] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935593320+8) 4294967265
>> [ 7288.006416] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935599144+8) 4294967260
>> [ 7288.006417] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935599144+8) 4294967261
>> [ 7288.006420] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935599144+8) 4294967262
>> [ 7288.006422] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935599144+8) 4294967263
>> [ 7288.006605] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935599144+8) 4294967264
>> [ 7288.006752] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935599144+8) 4294967265
>> [ 7288.006975] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935599144+8) 4294967266
>> [ 7353.182856] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935607144+8) 4294967261
>> [ 7353.182854] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935607144+8) 4294967260
>> [ 7353.182949] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935607144+8) 4294967262
>> [ 7353.183001] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935607144+8) 4294967263
>> [ 7353.183401] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935607144+8) 4294967264
>> [ 7353.183737] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935607144+8) 4294967266
>> [ 7353.183726] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935607144+8) 4294967265
>> [ 7353.184047] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(27935607144+8) 4294967267
>> [ 7443.628841] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935609128+8) 4294967264
>> [ 7443.638347] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935609128+8) 4294967263
>> [ 7443.647826] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935609128+8) 4294967262
>> [ 7443.657311] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935609128+8) 4294967261
>> [ 7443.666797] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935609128+8) 4294967260
>> [ 7443.676282] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935609128+8) 4294967259
>> [ 7501.172830] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935614952+8) 4294967263
>> [ 7501.182322] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935614952+8) 4294967262
>> [ 7501.191809] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935614952+8) 4294967261
>> [ 7501.201294] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935614952+8) 4294967260
>> [ 7501.210778] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(27935614952+8) 4294967259
>> [ 7508.208830] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204178984+8) 4294967260
>> [ 7508.209597] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204178984+8) 4294967261
>> [ 7508.209670] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204178984+8) 4294967262
>> [ 7522.177756] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204178984+8) 4294967263
>> [ 7522.177879] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204178984+8) 4294967264
>> [ 7522.177881] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204178984+8) 4294967265
>> [ 7550.776037] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204178984+8) 4294967264
>> [ 7550.785525] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204178984+8) 4294967263
>> [ 7550.795016] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204178984+8) 4294967262
>> [ 7550.804501] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204178984+8) 4294967261
>> [ 7550.813985] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204178984+8) 4294967260
>> [ 7550.823470] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204178984+8) 4294967259
>> [ 7556.140566] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204189096+8) 4294967260
>> [ 7556.140598] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204189096+8) 4294967261
>> [ 7556.140739] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204189096+8) 4294967262
>> [ 7556.140798] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204189096+8) 4294967263
>> [ 7556.140931] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204189096+8) 4294967264
>> [ 7556.141063] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204189096+8) 4294967265
>> [ 7556.141111] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204189096+8) 4294967266
>> [ 7556.141212] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204189096+8) 4294967267
>> [ 7589.706135] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204189096+8) 4294967266
>> [ 7589.991286] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204189096+8) 4294967265
>> [ 7590.277340] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204189096+8) 4294967264
>> [ 7590.563347] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204189096+8) 4294967263
>> [ 7590.849389] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204189096+8) 4294967262
>> [ 7591.135445] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204189096+8) 4294967261
>> [ 7591.421473] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204189096+8) 4294967260
>> [ 7591.707517] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204189096+8) 4294967259
>> [ 7606.172838] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204191720+8) 4294967260
>> [ 7703.615017] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204191720+8) 4294967263
>> [ 7703.624510] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204191720+8) 4294967262
>> [ 7703.634001] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204191720+8) 4294967261
>> [ 7703.643491] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204191720+8) 4294967260
>> [ 7703.652977] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204191720+8) 4294967259
>> [ 7708.933190] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204199848+8) 4294967260
>> [ 7708.933333] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204199848+8) 4294967261
>> [ 7708.933473] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204199848+8) 4294967262
>> [ 7708.933618] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204199848+8) 4294967263
>> [ 7708.933620] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204199848+8) 4294967264
>> [ 7708.933657] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204199848+8) 4294967265
>> [ 7708.933663] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204199848+8) 4294967266
>> [ 7758.303406] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204199848+8) 4294967265
>> [ 7758.303407] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204199848+8) 4294967264
>> [ 7758.303408] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204199848+8) 4294967263
>> [ 7758.303410] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204199848+8) 4294967262
>> [ 7758.303411] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204199848+8) 4294967261
>> [ 7758.303412] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204199848+8) 4294967260
>> [ 7758.303413] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204199848+8) 4294967259
>> [ 7778.439143] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204205672+8) 4294967260
>> [ 7778.439197] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204205672+8) 4294967261
>> [ 7778.439279] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204205672+8) 4294967262
>> [ 7778.439376] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204205672+8) 4294967263
>> [ 7778.439409] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204205672+8) 4294967264
>> [ 7778.439494] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204205672+8) 4294967265
>> [ 7858.899558] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204205672+8) 4294967264
>> [ 7858.899559] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204205672+8) 4294967263
>> [ 7858.899561] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204205672+8) 4294967262
>> [ 7858.899562] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204205672+8) 4294967261
>> [ 7858.899563] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204205672+8) 4294967260
>> [ 7858.899564] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204205672+8) 4294967259
>> [ 7890.583124] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204213800+8) 4294967260
>> [ 7890.583147] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204213800+8) 4294967261
>> [ 7890.583594] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204213800+8) 4294967262
>> [ 7890.583650] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204213800+8) 4294967263
>> [ 7890.584141] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204213800+8) 4294967264
>> [ 7890.584215] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204213800+8) 4294967265
>> [ 7890.584351] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204213800+8) 4294967266
>> [ 7952.730165] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204213800+8) 4294967265
>> [ 7952.739650] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204213800+8) 4294967264
>> [ 7952.749137] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204213800+8) 4294967263
>> [ 7952.758627] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204213800+8) 4294967262
>> [ 7952.768110] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204213800+8) 4294967261
>> [ 7952.777595] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204213800+8) 4294967260
>> [ 7952.787077] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204213800+8) 4294967259
>> [ 7966.676635] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204218216+8) 4294967260
>> [ 7966.676647] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204218216+8) 4294967261
>> [ 7966.676670] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204218216+8) 4294967263
>> [ 7966.676658] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204218216+8) 4294967262
>> [ 7966.676686] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204218216+8) 4294967264
>> [ 7966.677634] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204218216+8) 4294967265
>> [ 7966.708979] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204218216+8) 4294967266
>> [ 8032.243861] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204218216+8) 4294967265
>> [ 8032.253352] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204218216+8) 4294967264
>> [ 8032.262845] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204218216+8) 4294967263
>> [ 8032.272336] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204218216+8) 4294967262
>> [ 8032.281826] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204218216+8) 4294967261
>> [ 8032.291317] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204218216+8) 4294967260
>> [ 8032.300800] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204218216+8) 4294967259
>> [ 8043.901514] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204224168+8) 4294967260
>> [ 8043.901516] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204224168+8) 4294967261
>> [ 8043.901563] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204224168+8) 4294967262
>> [ 8043.901612] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204224168+8) 4294967264
>> [ 8043.901609] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204224168+8) 4294967263
>> [ 8043.907672] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204224168+8) 4294967265
>> [ 8146.468217] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204224168+8) 4294967264
>> [ 8146.477717] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204224168+8) 4294967263
>> [ 8146.487204] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204224168+8) 4294967262
>> [ 8146.496692] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204224168+8) 4294967261
>> [ 8146.506180] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204224168+8) 4294967260
>> [ 8146.515671] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204224168+8) 4294967259
>> [ 8151.492003] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204232232+8) 4294967260
>> [ 8151.492121] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204232232+8) 4294967261
>> [ 8151.492457] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204232232+8) 4294967262
>> [ 8151.492601] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204232232+8) 4294967264
>> [ 8151.492590] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204232232+8) 4294967263
>> [ 8151.492750] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204232232+8) 4294967265
>> [ 8164.821795] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204232232+8) 4294967266
>> [ 8200.519377] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204238120+8) 4294967260
>> [ 8200.519505] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204238120+8) 4294967261
>> [ 8200.519782] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204238120+8) 4294967262
>> [ 8200.519805] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204238120+8) 4294967263
>> [ 8200.520020] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204238120+8) 4294967264
>> [ 8200.520247] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204238120+8) 4294967265
>> [ 8200.520434] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204238120+8) 4294967266
>> [ 8200.520558] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204238120+8) 4294967267
>> [ 8231.475052] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204238120+8) 4294967266
>> [ 8231.637009] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204238120+8) 4294967265
>> [ 8231.799001] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204238120+8) 4294967264
>> [ 8231.960972] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204238120+8) 4294967263
>> [ 8232.122948] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204238120+8) 4294967262
>> [ 8232.284905] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204238120+8) 4294967261
>> [ 8232.446896] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204238120+8) 4294967260
>> [ 8232.608893] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204238120+8) 4294967259
>> [ 8251.913368] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204240808+8) 4294967260
>> [ 8251.913382] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204240808+8) 4294967263
>> [ 8251.913377] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204240808+8) 4294967261
>> [ 8251.913388] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204240808+8) 4294967265
>> [ 8251.913387] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204240808+8) 4294967264
>> [ 8251.913379] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204240808+8) 4294967262
>> [ 8302.630262] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204247848+8) 4294967261
>> [ 8302.630318] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204247848+8) 4294967263
>> [ 8302.630275] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204247848+8) 4294967262
>> [ 8302.630250] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204247848+8) 4294967260
>> [ 8302.630745] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204247848+8) 4294967264
>> [ 8377.488095] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204247848+8) 4294967263
>> [ 8377.497581] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204247848+8) 4294967262
>> [ 8377.507068] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204247848+8) 4294967261
>> [ 8377.516554] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204247848+8) 4294967260
>> [ 8377.526049] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204247848+8) 4294967259
>> [ 8382.868830] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204252072+8) 4294967260
>> [ 8382.868911] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204252072+8) 4294967261
>> [ 8382.869109] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204252072+8) 4294967262
>> [ 8382.869323] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204252072+8) 4294967263
>> [ 8382.983582] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204252072+8) 4294967264
>> [ 8407.895450] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204252072+8) 4294967263
>> [ 8407.895452] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204252072+8) 4294967262
>> [ 8407.895455] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204252072+8) 4294967261
>> [ 8407.895457] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204252072+8) 4294967260
>> [ 8407.895459] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204252072+8) 4294967259
>> [ 8454.553018] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204257768+8) 4294967264
>> [ 8454.570223] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204257768+8) 4294967263
>> [ 8454.587423] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204257768+8) 4294967262
>> [ 8454.587426] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204257768+8) 4294967261
>> [ 8454.604638] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204257768+8) 4294967260
>> [ 8454.621845] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204257768+8) 4294967259
>> [ 8498.349228] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204263784+8) 4294967261
>> [ 8498.349235] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204263784+8) 4294967262
>> [ 8498.349217] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204263784+8) 4294967260
>> [ 8498.349235] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204263784+8) 4294967263
>> [ 8498.349317] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204263784+8) 4294967264
>> [ 8498.349366] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204263784+8) 4294967265
>> [ 8517.904808] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204263784+8) 4294967266
>> [ 8551.340824] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204263784+8) 4294967265
>> [ 8551.350319] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204263784+8) 4294967264
>> [ 8551.359809] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204263784+8) 4294967263
>> [ 8551.369300] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204263784+8) 4294967262
>> [ 8551.378788] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204263784+8) 4294967261
>> [ 8551.388272] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204263784+8) 4294967260
>> [ 8551.397756] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204263784+8) 4294967259
>> [ 8599.114364] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204268840+8) 4294967265
>> [ 8599.114366] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204268840+8) 4294967264
>> [ 8599.114367] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204268840+8) 4294967263
>> [ 8599.114368] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204268840+8) 4294967262
>> [ 8599.114370] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204268840+8) 4294967261
>> [ 8599.114371] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204268840+8) 4294967260
>> [ 8599.114372] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204268840+8) 4294967259
>> [ 8599.117759] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204274216+8) 4294967260
>> [ 8623.906310] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204274216+8) 4294967261
>> [ 8623.909333] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204274216+8) 4294967260
>> [ 8623.909335] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204274216+8) 4294967259
>> [ 8623.909624] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204274216+8) 4294967260
>> [ 8623.910846] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204274216+8) 4294967261
>> [ 8623.913364] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204274216+8) 4294967262
>> [ 8625.066563] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204274216+8) 4294967263
>> [ 8651.338552] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204280104+8) 4294967267
>> [ 8693.930170] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204280104+8) 4294967266
>> [ 8693.939647] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204280104+8) 4294967265
>> [ 8693.949139] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204280104+8) 4294967264
>> [ 8693.958637] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204280104+8) 4294967263
>> [ 8693.968135] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204280104+8) 4294967262
>> [ 8693.977622] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204280104+8) 4294967261
>> [ 8693.987106] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204280104+8) 4294967260
>> [ 8693.996589] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204280104+8) 4294967259
>> [ 8703.470915] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204283624+8) 4294967260
>> [ 8703.470931] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204283624+8) 4294967261
>> [ 8703.470985] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204283624+8) 4294967264
>> [ 8703.470977] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204283624+8) 4294967263
>> [ 8703.470957] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204283624+8) 4294967262
>> [ 8703.471000] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204283624+8) 4294967265
>> [ 8703.471037] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204283624+8) 4294967266
>> [ 8771.557361] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204283624+8) 4294967265
>> [ 8771.566858] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204283624+8) 4294967264
>> [ 8771.576344] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204283624+8) 4294967263
>> [ 8771.585830] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204283624+8) 4294967262
>> [ 8771.595316] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204283624+8) 4294967261
>> [ 8771.604797] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204283624+8) 4294967260
>> [ 8771.614273] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28204283624+8) 4294967259
>> [ 8772.929338] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204289768+8) 4294967260
>> [ 8772.929454] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204289768+8) 4294967261
>> [ 8772.929545] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204289768+8) 4294967262
>> [ 8772.929764] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204289768+8) 4294967263
>> [ 8772.929816] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204289768+8) 4294967264
>> [ 8772.929850] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204289768+8) 4294967265
>> [ 8847.837534] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204297128+8) 4294967263
>> [ 8847.837548] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204297128+8) 4294967264
>> [ 8847.843801] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28204297128+8) 4294967265
>> [ 8945.958057] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472893352+8) 4294967260
>> [ 8945.958072] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472893352+8) 4294967261
>> [ 8945.958101] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472893352+8) 4294967262
>> [ 8945.958105] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472893352+8) 4294967263
>> [ 8945.958112] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472893352+8) 4294967264
>> [ 8945.958137] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472893352+8) 4294967265
>> [ 8991.941073] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472893352+8) 4294967264
>> [ 8991.941075] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472893352+8) 4294967263
>> [ 8991.941076] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472893352+8) 4294967262
>> [ 8991.941077] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472893352+8) 4294967261
>> [ 8991.941078] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472893352+8) 4294967260
>> [ 8991.941080] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472893352+8) 4294967259
>> [ 9036.005328] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472899304+8) 4294967260
>> [ 9036.005409] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472899304+8) 4294967261
>> [ 9036.006275] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472899304+8) 4294967262
>> [ 9036.006348] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472899304+8) 4294967263
>> [ 9036.006436] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472899304+8) 4294967264
>> [ 9036.006517] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472899304+8) 4294967265
>> [ 9089.090686] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472899304+8) 4294967264
>> [ 9089.100181] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472899304+8) 4294967263
>> [ 9089.109670] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472899304+8) 4294967262
>> [ 9089.119157] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472899304+8) 4294967261
>> [ 9089.128642] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472899304+8) 4294967260
>> [ 9089.138130] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472899304+8) 4294967259
>> [ 9120.298531] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472904744+8) 4294967266
>> [ 9120.298540] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472904744+8) 4294967265
>> [ 9120.298547] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472904744+8) 4294967264
>> [ 9120.298555] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472904744+8) 4294967263
>> [ 9120.298568] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472904744+8) 4294967262
>> [ 9120.298581] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472904744+8) 4294967261
>> [ 9120.298599] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472904744+8) 4294967260
>> [ 9120.298613] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472904744+8) 4294967259
>> [ 9120.440293] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472909032+8) 4294967260
>> [ 9120.440348] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472909032+8) 4294967261
>> [ 9120.440387] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472909032+8) 4294967262
>> [ 9120.440528] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472909032+8) 4294967263
>> [ 9120.440553] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472909032+8) 4294967264
>> [ 9120.440625] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472909032+8) 4294967265
>> [ 9157.076832] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472909032+8) 4294967266
>> [ 9204.360610] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472909032+8) 4294967265
>> [ 9204.370096] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472909032+8) 4294967264
>> [ 9204.379585] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472909032+8) 4294967263
>> [ 9204.389070] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472909032+8) 4294967262
>> [ 9204.398557] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472909032+8) 4294967261
>> [ 9204.408047] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472909032+8) 4294967260
>> [ 9204.417534] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472909032+8) 4294967259
>> [ 9235.036854] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472915624+8) 4294967260
>> [ 9235.036941] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472915624+8) 4294967261
>> [ 9235.036985] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472915624+8) 4294967262
>> [ 9235.037076] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472915624+8) 4294967263
>> [ 9235.037103] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472915624+8) 4294967264
>> [ 9235.037202] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472915624+8) 4294967265
>> [ 9326.601083] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472925480+8) 4294967260
>> [ 9326.601219] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472925480+8) 4294967261
>> [ 9326.601490] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472925480+8) 4294967262
>> [ 9326.601519] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472925480+8) 4294967263
>> [ 9326.601556] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472925480+8) 4294967264
>> [ 9326.601644] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472925480+8) 4294967265
>> [ 9326.601736] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472925480+8) 4294967266
>> [ 9326.607310] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472925480+8) 4294967267
>> [ 9358.046046] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472925480+8) 4294967266
>> [ 9358.055533] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472925480+8) 4294967265
>> [ 9358.065019] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472925480+8) 4294967264
>> [ 9358.074517] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472925480+8) 4294967263
>> [ 9358.084002] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472925480+8) 4294967262
>> [ 9358.093495] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472925480+8) 4294967261
>> [ 9358.102997] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472925480+8) 4294967260
>> [ 9358.112485] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472925480+8) 4294967259
>> [ 9361.800927] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472927848+8) 4294967260
>> [ 9361.801104] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472927848+8) 4294967261
>> [ 9361.801282] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472927848+8) 4294967262
>> [ 9361.801484] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472927848+8) 4294967263
>> [ 9361.801527] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472927848+8) 4294967264
>> [ 9361.801620] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472927848+8) 4294967265
>> [ 9361.801653] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472927848+8) 4294967266
>> [ 9430.438322] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472927848+8) 4294967265
>> [ 9430.447809] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472927848+8) 4294967264
>> [ 9430.457294] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472927848+8) 4294967263
>> [ 9430.466782] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472927848+8) 4294967262
>> [ 9430.476277] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472927848+8) 4294967261
>> [ 9430.485766] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472927848+8) 4294967260
>> [ 9430.495250] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472927848+8) 4294967259
>> [ 9444.781947] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472932456+8) 4294967260
>> [ 9444.781963] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472932456+8) 4294967261
>> [ 9444.782418] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472932456+8) 4294967262
>> [ 9444.782605] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472932456+8) 4294967263
>> [ 9444.782662] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472932456+8) 4294967264
>> [ 9444.782718] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472932456+8) 4294967265
>> [ 9444.782857] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472932456+8) 4294967266
>> [ 9444.782963] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472932456+8) 4294967267
>> [ 9460.949714] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472932456+8) 4294967266
>> [ 9461.002252] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472932456+8) 4294967265
>> [ 9461.054806] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472932456+8) 4294967264
>> [ 9461.107370] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472932456+8) 4294967263
>> [ 9461.159913] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472932456+8) 4294967262
>> [ 9461.212473] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472932456+8) 4294967261
>> [ 9461.265014] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472932456+8) 4294967260
>> [ 9461.317558] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472932456+8) 4294967259
>> [ 9472.880989] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472934568+8) 4294967260
>> [ 9472.881022] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472934568+8) 4294967262
>> [ 9472.881013] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472934568+8) 4294967261
>> [ 9472.881466] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472934568+8) 4294967263
>> [ 9472.881585] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472934568+8) 4294967264
>> [ 9472.881617] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472934568+8) 4294967265
>> [ 9472.881636] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472934568+8) 4294967266
>> [ 9473.230016] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472934568+8) 4294967267
>> [ 9484.525992] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472934568+8) 4294967266
>> [ 9484.607866] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472934568+8) 4294967265
>> [ 9484.690643] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472934568+8) 4294967264
>> [ 9484.773393] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472934568+8) 4294967263
>> [ 9484.856144] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472934568+8) 4294967262
>> [ 9484.938897] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472934568+8) 4294967261
>> [ 9485.021665] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472934568+8) 4294967260
>> [ 9485.104419] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472934568+8) 4294967259
>> [ 9565.878800] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472938920+8) 4294967265
>> [ 9565.888283] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472938920+8) 4294967264
>> [ 9565.897767] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472938920+8) 4294967263
>> [ 9565.907250] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472938920+8) 4294967262
>> [ 9565.916734] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472938920+8) 4294967261
>> [ 9565.926219] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472938920+8) 4294967260
>> [ 9565.935703] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472938920+8) 4294967259
>> [ 9569.109038] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032745832+8) 4294967260
>> [ 9613.943060] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032745832+8) 4294967259
>> [ 9625.083909] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472948456+8) 4294967264
>> [ 9625.083911] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472948456+8) 4294967263
>> [ 9625.083913] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472948456+8) 4294967262
>> [ 9625.083914] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472948456+8) 4294967261
>> [ 9625.083916] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472948456+8) 4294967260
>> [ 9625.083917] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472948456+8) 4294967259
>> [ 9686.963155] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(8599505896+8) 4294967259
>> [ 9706.444605] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472960104+8) 4294967260
>> [ 9706.444608] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472960104+8) 4294967261
>> [ 9706.444612] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472960104+8) 4294967262
>> [ 9706.444615] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472960104+8) 4294967263
>> [ 9706.444671] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472960104+8) 4294967264
>> [ 9706.462013] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472960104+8) 4294967265
>> [ 9709.460551] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472960104+8) 4294967266
>> [ 9713.748452] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472964136+8) 4294967266
>> [ 9713.748682] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472964136+8) 4294967267
>> [ 9713.753732] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472964136+8) 4294967266
>> [ 9713.753735] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472964136+8) 4294967265
>> [ 9713.753736] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472964136+8) 4294967264
>> [ 9713.753737] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472964136+8) 4294967263
>> [ 9713.753739] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472964136+8) 4294967262
>> [ 9713.753740] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472964136+8) 4294967261
>> [ 9713.753741] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472964136+8) 4294967260
>> [ 9713.753743] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472964136+8) 4294967259
>> [ 9742.956450] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472967144+8) 4294967260
>> [ 9742.956502] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472967144+8) 4294967261
>> [ 9742.956503] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472967144+8) 4294967262
>> [ 9742.956551] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472967144+8) 4294967263
>> [ 9743.152042] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472967144+8) 4294967264
>> [ 9756.828598] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472967144+8) 4294967265
>> [ 9811.500567] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472967144+8) 4294967264
>> [ 9811.510052] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472967144+8) 4294967263
>> [ 9811.519534] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472967144+8) 4294967262
>> [ 9811.529017] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472967144+8) 4294967261
>> [ 9811.538503] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472967144+8) 4294967260
>> [ 9811.547984] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472967144+8) 4294967259
>> [ 9816.207521] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472971752+8) 4294967266
>> [ 9816.207576] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472971752+8) 4294967265
>> [ 9816.207628] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472971752+8) 4294967264
>> [ 9816.207682] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472971752+8) 4294967263
>> [ 9816.207747] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472971752+8) 4294967262
>> [ 9816.207801] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472971752+8) 4294967261
>> [ 9816.207859] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472971752+8) 4294967260
>> [ 9816.207914] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472971752+8) 4294967259
>> [ 9816.211655] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472975272+8) 4294967260
>> [ 9816.211658] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472975272+8) 4294967261
>> [ 9816.211787] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472975272+8) 4294967262
>> [ 9816.211882] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472975272+8) 4294967263
>> [ 9816.211901] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472975272+8) 4294967264
>> [ 9816.211947] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472975272+8) 4294967265
>> [ 9919.228920] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472975272+8) 4294967264
>> [ 9919.238395] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472975272+8) 4294967263
>> [ 9919.247877] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472975272+8) 4294967262
>> [ 9919.257360] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472975272+8) 4294967261
>> [ 9919.266845] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472975272+8) 4294967260
>> [ 9919.276332] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472975272+8) 4294967259
>> [ 9921.581043] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472984680+8) 4294967261
>> [ 9921.580965] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472984680+8) 4294967260
>> [ 9921.581099] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472984680+8) 4294967262
>> [ 9921.581185] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472984680+8) 4294967263
>> [ 9921.581304] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472984680+8) 4294967264
>> [ 9921.581341] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472984680+8) 4294967265
>> [ 9921.581364] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472984680+8) 4294967266
>> [ 9921.581365] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472984680+8) 4294967267
>> [ 9921.583872] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472984680+8) 4294967266
>> [ 9921.583882] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472984680+8) 4294967265
>> [ 9921.583897] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472984680+8) 4294967264
>> [ 9921.583913] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472984680+8) 4294967263
>> [ 9921.583929] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472984680+8) 4294967262
>> [ 9921.583945] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472984680+8) 4294967261
>> [ 9921.583960] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472984680+8) 4294967260
>> [ 9921.583977] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472984680+8) 4294967259
>> [ 9951.448268] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28457314088+8) 4294967260
>> [ 9986.682431] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472994664+8) 4294967262
>> [ 9986.682540] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472994664+8) 4294967263
>> [ 9986.682661] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472994664+8) 4294967264
>> [ 9986.687019] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28472994664+8) 4294967265
>> [10026.057977] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472994664+8) 4294967264
>> [10026.057980] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472994664+8) 4294967263
>> [10026.057982] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472994664+8) 4294967262
>> [10026.057984] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472994664+8) 4294967261
>> [10026.057986] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472994664+8) 4294967260
>> [10026.057987] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28472994664+8) 4294967259
>> [10026.060967] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473000424+8) 4294967260
>> [10026.061269] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473000424+8) 4294967261
>> [10026.061642] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473000424+8) 4294967262
>> [10026.061728] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473000424+8) 4294967264
>> [10026.061715] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473000424+8) 4294967263
>> [10026.061745] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473000424+8) 4294967265
>> [10026.061790] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473000424+8) 4294967266
>> [10026.061809] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473000424+8) 4294967267
>> [10055.918459] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473000424+8) 4294967266
>> [10056.153717] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473000424+8) 4294967265
>> [10056.388985] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473000424+8) 4294967264
>> [10056.624244] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473000424+8) 4294967263
>> [10056.859507] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473000424+8) 4294967262
>> [10057.094768] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473000424+8) 4294967261
>> [10057.330043] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473000424+8) 4294967260
>> [10057.565339] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473000424+8) 4294967259
>> [10060.361434] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473001448+8) 4294967260
>> [10060.361487] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473001448+8) 4294967261
>> [10060.361634] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473001448+8) 4294967262
>> [10060.361709] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473001448+8) 4294967263
>> [10060.361710] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473001448+8) 4294967264
>> [10060.361710] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473001448+8) 4294967265
>> [10060.361723] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473001448+8) 4294967266
>> [10108.302805] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473001448+8) 4294967265
>> [10108.302808] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473001448+8) 4294967264
>> [10108.302810] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473001448+8) 4294967263
>> [10108.302812] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473001448+8) 4294967262
>> [10108.302814] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473001448+8) 4294967261
>> [10108.302816] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473001448+8) 4294967260
>> [10108.302818] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473001448+8) 4294967259
>> [10108.307331] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473008296+8) 4294967260
>> [10108.307515] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473008296+8) 4294967261
>> [10108.307665] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473008296+8) 4294967263
>> [10108.307647] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473008296+8) 4294967262
>> [10108.308273] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473008296+8) 4294967264
>> [10108.308454] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473008296+8) 4294967266
>> [10108.308426] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473008296+8) 4294967265
>> [10108.308720] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473008296+8) 4294967267
>> [10138.300402] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473008296+8) 4294967266
>> [10138.516650] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473008296+8) 4294967265
>> [10138.732928] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473008296+8) 4294967264
>> [10138.949166] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473008296+8) 4294967263
>> [10139.165431] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473008296+8) 4294967262
>> [10139.381678] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473008296+8) 4294967261
>> [10139.597964] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473008296+8) 4294967260
>> [10139.814237] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473008296+8) 4294967259
>> [10144.088915] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032746728+8) 4294967260
>> [10188.320954] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032746728+8) 4294967259
>> [10196.658979] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473013608+8) 4294967260
>> [10196.659207] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473013608+8) 4294967261
>> [10196.659343] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473013608+8) 4294967262
>> [10196.659430] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473013608+8) 4294967263
>> [10196.659439] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473013608+8) 4294967264
>> [10196.660163] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473013608+8) 4294967265
>> [10196.660183] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473013608+8) 4294967266
>> [10279.470741] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473013608+8) 4294967265
>> [10279.480231] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473013608+8) 4294967264
>> [10279.489723] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473013608+8) 4294967263
>> [10279.499214] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473013608+8) 4294967262
>> [10279.508709] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473013608+8) 4294967261
>> [10279.518206] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473013608+8) 4294967260
>> [10279.527693] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28473013608+8) 4294967259
>> [10286.896922] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032746984+8) 4294967260
>> [10304.464308] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032746984+8) 4294967259
>> [10305.667186] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473022056+8) 4294967260
>> [10305.667269] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473022056+8) 4294967261
>> [10305.667270] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473022056+8) 4294967262
>> [10305.667429] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473022056+8) 4294967263
>> [10305.667512] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473022056+8) 4294967264
>> [10305.667590] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473022056+8) 4294967265
>> [10305.667639] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28473022056+8) 4294967266
>> [10334.751820] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28457314152+8) 4294967260
>> [10415.904902] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28457314152+8) 4294967259
>> [10415.960311] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28457314152+8) 4294967260
>> [10423.280595] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28457314152+8) 4294967259
>> [10439.777461] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741281576+8) 4294967263
>> [10439.777592] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741281576+8) 4294967264
>> [10439.777647] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741281576+8) 4294967265
>> [10439.777786] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741281576+8) 4294967266
>> [10497.698903] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741281576+8) 4294967265
>> [10497.698905] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741281576+8) 4294967264
>> [10497.698907] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741281576+8) 4294967263
>> [10497.698908] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741281576+8) 4294967262
>> [10497.698910] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741281576+8) 4294967261
>> [10497.698911] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741281576+8) 4294967260
>> [10497.698912] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741281576+8) 4294967259
>> [10497.701113] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741287848+8) 4294967260
>> [10497.701118] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741287848+8) 4294967261
>> [10497.701183] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741287848+8) 4294967262
>> [10497.701490] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741287848+8) 4294967263
>> [10497.701908] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741287848+8) 4294967264
>> [10497.702132] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741287848+8) 4294967265
>> [10593.723273] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741293480+8) 4294967264
>> [10593.723280] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741293480+8) 4294967265
>> [10593.723381] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741293480+8) 4294967266
>> [10681.179411] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741293480+8) 4294967265
>> [10681.188893] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741293480+8) 4294967264
>> [10681.198368] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741293480+8) 4294967263
>> [10681.207851] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741293480+8) 4294967262
>> [10681.217350] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741293480+8) 4294967261
>> [10681.226842] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741293480+8) 4294967260
>> [10681.236340] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741293480+8) 4294967259
>> [10689.151359] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741301800+8) 4294967260
>> [10689.151633] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741301800+8) 4294967261
>> [10689.151649] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741301800+8) 4294967262
>> [10689.151700] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741301800+8) 4294967263
>> [10689.151823] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741301800+8) 4294967264
>> [10689.152267] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741301800+8) 4294967265
>> [10689.152370] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741301800+8) 4294967266
>> [10765.465443] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741309544+8) 4294967260
>> [10765.465539] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741309544+8) 4294967261
>> [10765.465942] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741309544+8) 4294967262
>> [10765.466073] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741309544+8) 4294967263
>> [10765.471339] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741309544+8) 4294967264
>> [10765.471352] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741309544+8) 4294967265
>> [10765.471615] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741309544+8) 4294967266
>> [10810.806942] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741309544+8) 4294967265
>> [10810.816430] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741309544+8) 4294967264
>> [10810.825920] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741309544+8) 4294967263
>> [10810.835410] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741309544+8) 4294967262
>> [10810.844892] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741309544+8) 4294967261
>> [10810.854379] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741309544+8) 4294967260
>> [10810.863866] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741309544+8) 4294967259
>> [10829.079850] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741313832+8) 4294967260
>> [10849.794350] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741313832+8) 4294967259
>> [10918.134642] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741313832+8) 4294967264
>> [10918.144122] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741313832+8) 4294967263
>> [10918.153605] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741313832+8) 4294967262
>> [10918.163087] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741313832+8) 4294967261
>> [10918.172569] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741313832+8) 4294967260
>> [10918.182053] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741313832+8) 4294967259
>> [10925.672507] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741320744+8) 4294967260
>> [10925.672673] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741320744+8) 4294967262
>> [10925.672533] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741320744+8) 4294967261
>> [10925.672788] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741320744+8) 4294967263
>> [10925.672958] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741320744+8) 4294967264
>> [10925.672978] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741320744+8) 4294967265
>> [10925.673524] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741320744+8) 4294967266
>> [10925.673721] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741320744+8) 4294967267
>> [10938.064956] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741320744+8) 4294967266
>> [10938.263167] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741320744+8) 4294967265
>> [10938.461362] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741320744+8) 4294967264
>> [10938.659537] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741320744+8) 4294967263
>> [10938.857718] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741320744+8) 4294967262
>> [10939.055907] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741320744+8) 4294967261
>> [10939.254110] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741320744+8) 4294967260
>> [10939.452289] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741320744+8) 4294967259
>> [10942.625740] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741322600+8) 4294967260
>> [10942.625791] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741322600+8) 4294967262
>> [10942.625850] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741322600+8) 4294967264
>> [10942.625849] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741322600+8) 4294967263
>> [10942.625789] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741322600+8) 4294967261
>> [10942.626403] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741322600+8) 4294967265
>> [11020.726643] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741322600+8) 4294967264
>> [11020.726645] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741322600+8) 4294967263
>> [11020.726646] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741322600+8) 4294967262
>> [11020.726648] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741322600+8) 4294967261
>> [11020.726649] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741322600+8) 4294967260
>> [11020.726651] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741322600+8) 4294967259
>> [11045.762697] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741328104+8) 4294967262
>> [11045.763802] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741328104+8) 4294967263
>> [11045.763966] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741328104+8) 4294967264
>> [11045.764660] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741328104+8) 4294967265
>> [11072.427987] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741342760+8) 4294967266
>> [11072.429693] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741342760+8) 4294967265
>> [11072.429971] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741342760+8) 4294967264
>> [11072.430020] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741342760+8) 4294967263
>> [11072.430076] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741342760+8) 4294967262
>> [11072.430127] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741342760+8) 4294967261
>> [11072.430180] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741342760+8) 4294967260
>> [11072.430234] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741342760+8) 4294967259
>> [11103.176662] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741345192+8) 4294967260
>> [11103.176760] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741345192+8) 4294967261
>> [11103.176914] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741345192+8) 4294967262
>> [11103.176947] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741345192+8) 4294967263
>> [11103.177351] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741345192+8) 4294967264
>> [11103.243210] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741345192+8) 4294967265
>> [11197.368568] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741345192+8) 4294967264
>> [11197.378067] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741345192+8) 4294967263
>> [11197.387571] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741345192+8) 4294967262
>> [11197.397061] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741345192+8) 4294967261
>> [11197.406551] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741345192+8) 4294967260
>> [11197.416027] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741345192+8) 4294967259
>> [11213.302960] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741352808+8) 4294967260
>> [11214.005987] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741352808+8) 4294967265
>> [11214.005989] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741352808+8) 4294967264
>> [11214.005990] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741352808+8) 4294967263
>> [11214.005991] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741352808+8) 4294967262
>> [11214.005992] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741352808+8) 4294967261
>> [11214.005994] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741352808+8) 4294967260
>> [11214.005995] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741352808+8) 4294967259
>> [11251.017225] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741359720+8) 4294967260
>> [11251.017225] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741359720+8) 4294967261
>> [11251.017233] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741359720+8) 4294967263
>> [11251.017238] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741359720+8) 4294967266
>> [11251.017236] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741359720+8) 4294967265
>> [11251.017234] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741359720+8) 4294967264
>> [11251.017231] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741359720+8) 4294967262
>> [11269.980634] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741359720+8) 4294967267
>> [11289.588526] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741359720+8) 4294967266
>> [11289.598008] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741359720+8) 4294967265
>> [11289.607492] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741359720+8) 4294967264
>> [11289.616977] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741359720+8) 4294967263
>> [11289.626462] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741359720+8) 4294967262
>> [11289.635951] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741359720+8) 4294967261
>> [11289.645439] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741359720+8) 4294967260
>> [11289.654929] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741359720+8) 4294967259
>> [11289.955406] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741364520+8) 4294967260
>> [11289.955748] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741364520+8) 4294967261
>> [11289.955828] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741364520+8) 4294967262
>> [11289.956014] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741364520+8) 4294967263
>> [11310.687017] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741364520+8) 4294967264
>> [11344.753308] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741371944+8) 4294967266
>> [11344.753344] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741371944+8) 4294967265
>> [11344.753381] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741371944+8) 4294967264
>> [11344.753417] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741371944+8) 4294967263
>> [11344.753453] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741371944+8) 4294967262
>> [11344.753488] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741371944+8) 4294967261
>> [11344.753524] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741371944+8) 4294967260
>> [11344.753559] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741371944+8) 4294967259
>> [11372.057310] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741374568+8) 4294967260
>> [11372.057453] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741374568+8) 4294967261
>> [11372.058126] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741374568+8) 4294967262
>> [11372.058225] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741374568+8) 4294967263
>> [11372.058236] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741374568+8) 4294967264
>> [11372.058445] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741374568+8) 4294967265
>> [11477.692568] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741374568+8) 4294967264
>> [11477.702057] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741374568+8) 4294967263
>> [11477.711549] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741374568+8) 4294967262
>> [11477.721041] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741374568+8) 4294967261
>> [11477.730527] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741374568+8) 4294967260
>> [11477.740015] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741374568+8) 4294967259
>> [11484.738964] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28725142504+8) 4294967260
>> [11516.590602] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28725142504+8) 4294967259
>> [11541.514580] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741387368+8) 4294967260
>> [11541.514657] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741387368+8) 4294967261
>> [11541.514736] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741387368+8) 4294967262
>> [11541.514795] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741387368+8) 4294967263
>> [11541.514937] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741387368+8) 4294967264
>> [11541.514959] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741387368+8) 4294967265
>> [11541.515020] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741387368+8) 4294967266
>> [11541.515178] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741387368+8) 4294967267
>> [11589.245255] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741387368+8) 4294967266
>> [11589.530527] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741387368+8) 4294967265
>> [11589.815730] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741387368+8) 4294967264
>> [11590.100882] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741387368+8) 4294967263
>> [11590.386071] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741387368+8) 4294967262
>> [11590.671228] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741387368+8) 4294967261
>> [11590.956368] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741387368+8) 4294967260
>> [11591.241504] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741387368+8) 4294967259
>> [11665.205805] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741392232+8) 4294967264
>> [11665.215300] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741392232+8) 4294967263
>> [11665.224797] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741392232+8) 4294967262
>> [11665.234283] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741392232+8) 4294967261
>> [11665.243770] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741392232+8) 4294967260
>> [11665.253265] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741392232+8) 4294967259
>> [11676.491376] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741400360+8) 4294967260
>> [11676.491588] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741400360+8) 4294967261
>> [11676.491637] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741400360+8) 4294967262
>> [11676.491798] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741400360+8) 4294967263
>> [11676.492010] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741400360+8) 4294967264
>> [11785.703215] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741406824+8) 4294967260
>> [11787.558791] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741406824+8) 4294967261
>> [11787.558892] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741406824+8) 4294967262
>> [11791.614199] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741406824+8) 4294967263
>> [11793.388452] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741406824+8) 4294967264
>> [11795.421600] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741406824+8) 4294967265
>> [11795.422104] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741406824+8) 4294967266
>> [11795.424300] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28741406824+8) 4294967267
>> [11795.426502] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741406824+8) 4294967266
>> [11795.426503] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741406824+8) 4294967265
>> [11795.426504] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741406824+8) 4294967264
>> [11795.426505] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741406824+8) 4294967263
>> [11795.426506] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741406824+8) 4294967262
>> [11795.426507] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741406824+8) 4294967261
>> [11795.426509] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741406824+8) 4294967260
>> [11795.426510] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28741406824+8) 4294967259
>> [11871.476819] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009321576+8) 4294967260
>> [11871.486321] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009321576+8) 4294967259
>> [11919.615037] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009330472+8) 4294967260
>> [11919.615114] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009330472+8) 4294967261
>> [11919.615374] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009330472+8) 4294967262
>> [11919.615395] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009330472+8) 4294967263
>> [11919.615491] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009330472+8) 4294967264
>> [11928.774840] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009330472+8) 4294967267
>> [12000.001506] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009336936+8) 4294967264
>> [12000.001507] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009336936+8) 4294967263
>> [12000.001509] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009336936+8) 4294967262
>> [12000.001510] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009336936+8) 4294967261
>> [12000.001512] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009336936+8) 4294967260
>> [12000.001514] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009336936+8) 4294967259
>> [12033.086368] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009343400+8) 4294967260
>> [12033.086440] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009343400+8) 4294967261
>> [12033.086702] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009343400+8) 4294967262
>> [12033.086790] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009343400+8) 4294967263
>> [12033.087023] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009343400+8) 4294967264
>> [12071.801701] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009349352+8) 4294967262
>> [12071.801733] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009349352+8) 4294967264
>> [12071.801727] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009349352+8) 4294967263
>> [12071.801859] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009349352+8) 4294967265
>> [12071.801934] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009349352+8) 4294967266
>> [12147.838099] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009349352+8) 4294967265
>> [12147.838104] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009349352+8) 4294967264
>> [12147.838108] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009349352+8) 4294967263
>> [12147.838113] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009349352+8) 4294967262
>> [12147.838117] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009349352+8) 4294967261
>> [12147.838122] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009349352+8) 4294967260
>> [12147.838131] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009349352+8) 4294967259
>> [12161.825218] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009356712+8) 4294967260
>> [12171.278213] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009356712+8) 4294967261
>> [12171.278308] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009356712+8) 4294967262
>> [12171.278349] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009356712+8) 4294967263
>> [12171.278418] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009356712+8) 4294967264
>> [12171.278481] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009356712+8) 4294967265
>> [12225.694791] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009356712+8) 4294967264
>> [12225.704279] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009356712+8) 4294967263
>> [12225.713774] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009356712+8) 4294967262
>> [12225.723264] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009356712+8) 4294967261
>> [12225.732759] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009356712+8) 4294967260
>> [12225.742248] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009356712+8) 4294967259
>> [12241.217982] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009362344+8) 4294967260
>> [12241.218022] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009362344+8) 4294967261
>> [12241.218156] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009362344+8) 4294967262
>> [12241.218291] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009362344+8) 4294967263
>> [12241.218712] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009362344+8) 4294967264
>> [12241.225590] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009362344+8) 4294967265
>> [12324.241931] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009362344+8) 4294967264
>> [12324.251421] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009362344+8) 4294967263
>> [12324.260905] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009362344+8) 4294967262
>> [12324.270390] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009362344+8) 4294967261
>> [12324.279874] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009362344+8) 4294967260
>> [12324.289362] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009362344+8) 4294967259
>> [12330.627283] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009368808+8) 4294967261
>> [12330.627282] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009368808+8) 4294967260
>> [12330.627356] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009368808+8) 4294967262
>> [12330.627452] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009368808+8) 4294967263
>> [12330.627459] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009368808+8) 4294967264
>> [12330.627476] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009368808+8) 4294967265
>> [12360.643250] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009368808+8) 4294967265
>> [12360.643251] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009368808+8) 4294967264
>> [12360.643253] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009368808+8) 4294967263
>> [12360.643254] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009368808+8) 4294967262
>> [12360.643256] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009368808+8) 4294967261
>> [12360.643257] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009368808+8) 4294967260
>> [12360.643258] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009368808+8) 4294967259
>> [12412.055085] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009379560+8) 4294967262
>> [12412.055185] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009379560+8) 4294967263
>> [12412.055346] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009379560+8) 4294967264
>> [12412.055358] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009379560+8) 4294967265
>> [12502.916463] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009379560+8) 4294967264
>> [12502.925955] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009379560+8) 4294967263
>> [12502.935437] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009379560+8) 4294967262
>> [12502.944921] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009379560+8) 4294967261
>> [12502.954403] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009379560+8) 4294967260
>> [12502.963891] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009379560+8) 4294967259
>> [12508.172163] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28994103208+8) 4294967260
>> [12569.394168] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(28994103208+8) 4294967259
>> [12669.806358] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009393000+8) 4294967264
>> [12669.815852] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009393000+8) 4294967263
>> [12669.825349] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009393000+8) 4294967262
>> [12669.834848] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009393000+8) 4294967261
>> [12669.844337] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009393000+8) 4294967260
>> [12669.853824] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009393000+8) 4294967259
>> [12681.132403] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009401128+8) 4294967260
>> [12681.132623] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009401128+8) 4294967261
>> [12681.132903] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009401128+8) 4294967262
>> [12681.133118] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009401128+8) 4294967263
>> [12681.133360] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009401128+8) 4294967264
>> [12681.133472] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009401128+8) 4294967265
>> [12681.133687] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009401128+8) 4294967266
>> [12756.131024] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009401128+8) 4294967265
>> [12756.140520] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009401128+8) 4294967264
>> [12756.150010] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009401128+8) 4294967263
>> [12756.159496] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009401128+8) 4294967262
>> [12756.168984] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009401128+8) 4294967261
>> [12756.178470] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009401128+8) 4294967260
>> [12756.187958] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009401128+8) 4294967259
>> [12761.752380] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009406632+8) 4294967260
>> [12761.752555] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009406632+8) 4294967261
>> [12761.752566] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009406632+8) 4294967262
>> [12761.752717] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009406632+8) 4294967263
>> [12761.752864] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009406632+8) 4294967264
>> [12761.753575] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009406632+8) 4294967265
>> [12841.108192] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009406632+8) 4294967264
>> [12841.117686] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009406632+8) 4294967263
>> [12841.127177] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009406632+8) 4294967262
>> [12841.136667] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009406632+8) 4294967261
>> [12841.146150] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009406632+8) 4294967260
>> [12841.155642] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009406632+8) 4294967259
>> [12854.788520] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009414440+8) 4294967262
>> [12854.789006] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009414440+8) 4294967263
>> [12854.790480] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009414440+8) 4294967264
>> [12854.792345] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009414440+8) 4294967265
>> [12854.792371] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009414440+8) 4294967266
>> [12854.792648] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009414440+8) 4294967267
>> [12854.796137] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009414440+8) 4294967266
>> [12854.796140] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009414440+8) 4294967265
>> [12854.796143] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009414440+8) 4294967264
>> [12854.796145] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009414440+8) 4294967263
>> [12854.796147] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009414440+8) 4294967262
>> [12854.796149] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009414440+8) 4294967261
>> [12854.796151] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009414440+8) 4294967260
>> [12854.796152] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009414440+8) 4294967259
>> [12979.496382] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009416680+8) 4294967265
>> [12979.505867] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009416680+8) 4294967264
>> [12979.515357] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009416680+8) 4294967263
>> [12979.524845] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009416680+8) 4294967262
>> [12979.534338] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009416680+8) 4294967261
>> [12979.543825] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009416680+8) 4294967260
>> [12979.553315] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009416680+8) 4294967259
>> [12987.839356] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032747304+8) 4294967260
>> [13019.716541] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032747304+8) 4294967259
>> [13023.790667] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(8053065000+8) 4294967260
>> [13166.159630] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(8053065000+8) 4294967259
>> [13172.153701] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009436840+8) 4294967260
>> [13172.153856] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009436840+8) 4294967261
>> [13172.154183] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009436840+8) 4294967262
>> [13172.154307] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009436840+8) 4294967263
>> [13172.154320] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009436840+8) 4294967264
>> [13172.154325] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009436840+8) 4294967265
>> [13172.154327] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009436840+8) 4294967266
>> [13172.154540] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009436840+8) 4294967267
>> [13184.154929] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009436840+8) 4294967266
>> [13184.395309] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009436840+8) 4294967265
>> [13184.635656] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009436840+8) 4294967264
>> [13184.876002] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009436840+8) 4294967263
>> [13185.116361] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009436840+8) 4294967262
>> [13185.356722] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009436840+8) 4294967261
>> [13185.597099] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009436840+8) 4294967260
>> [13185.837445] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009436840+8) 4294967259
>> [13200.462739] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009439016+8) 4294967260
>> [13200.463373] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009439016+8) 4294967261
>> [13200.463433] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009439016+8) 4294967262
>> [13200.463686] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009439016+8) 4294967263
>> [13200.463718] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009439016+8) 4294967264
>> [13200.463750] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009439016+8) 4294967265
>> [13200.463801] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009439016+8) 4294967266
>> [13200.463824] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29009439016+8) 4294967267
>> [13218.832166] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009439016+8) 4294967266
>> [13218.964853] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009439016+8) 4294967265
>> [13219.097514] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009439016+8) 4294967264
>> [13219.230197] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009439016+8) 4294967263
>> [13219.362875] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009439016+8) 4294967262
>> [13219.495536] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009439016+8) 4294967261
>> [13219.628221] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009439016+8) 4294967260
>> [13219.760852] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009439016+8) 4294967259
>> [13284.342646] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009440424+8) 4294967264
>> [13284.352133] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009440424+8) 4294967263
>> [13284.361618] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009440424+8) 4294967262
>> [13284.371115] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009440424+8) 4294967261
>> [13284.380606] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009440424+8) 4294967260
>> [13284.390092] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29009440424+8) 4294967259
>> [13290.205839] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29312350184+8) 4294967260
>> [13328.994695] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29312350184+8) 4294967259
>> [13358.709396] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324623208+8) 4294967261
>> [13358.709379] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324623208+8) 4294967260
>> [13358.709414] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324623208+8) 4294967262
>> [13358.709435] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324623208+8) 4294967263
>> [13358.709475] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324623208+8) 4294967264
>> [13362.737444] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324623208+8) 4294967265
>> [13362.737666] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324623208+8) 4294967266
>> [13386.563843] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324629288+8) 4294967260
>> [13386.563968] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324629288+8) 4294967261
>> [13386.564092] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324629288+8) 4294967262
>> [13386.564227] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324629288+8) 4294967263
>> [13386.564297] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324629288+8) 4294967264
>> [13386.564364] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324629288+8) 4294967265
>> [13386.564532] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324629288+8) 4294967266
>> [13425.701678] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324629288+8) 4294967265
>> [13425.701680] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324629288+8) 4294967264
>> [13425.701681] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324629288+8) 4294967263
>> [13425.701682] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324629288+8) 4294967262
>> [13425.701684] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324629288+8) 4294967261
>> [13425.701686] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324629288+8) 4294967260
>> [13425.701688] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324629288+8) 4294967259
>> [13491.009481] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545812584+8) 4294967264
>> [13491.018974] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545812584+8) 4294967263
>> [13491.028463] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545812584+8) 4294967262
>> [13491.037945] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545812584+8) 4294967261
>> [13491.047430] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545812584+8) 4294967260
>> [13491.056918] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545812584+8) 4294967259
>> [13493.360976] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545815400+8) 4294967260
>> [13493.361476] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545815400+8) 4294967261
>> [13493.361592] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545815400+8) 4294967262
>> [13493.366880] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545815400+8) 4294967263
>> [13493.367183] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545815400+8) 4294967264
>> [13493.367399] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545815400+8) 4294967265
>> [13493.367635] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545815400+8) 4294967266
>> [13493.367706] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545815400+8) 4294967267
>> [13524.736988] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545815400+8) 4294967266
>> [13524.746476] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545815400+8) 4294967265
>> [13524.755962] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545815400+8) 4294967264
>> [13524.765450] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545815400+8) 4294967263
>> [13524.774943] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545815400+8) 4294967262
>> [13524.784436] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545815400+8) 4294967261
>> [13524.793931] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545815400+8) 4294967260
>> [13524.803422] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545815400+8) 4294967259
>> [13529.444566] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545816296+8) 4294967260
>> [13529.444628] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545816296+8) 4294967261
>> [13529.445249] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545816296+8) 4294967262
>> [13529.445330] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545816296+8) 4294967264
>> [13529.445307] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545816296+8) 4294967263
>> [13529.445578] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545816296+8) 4294967265
>> [13529.445594] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545816296+8) 4294967266
>> [13568.836756] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545816296+8) 4294967265
>> [13568.836757] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545816296+8) 4294967264
>> [13568.836759] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545816296+8) 4294967263
>> [13568.836766] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545816296+8) 4294967262
>> [13568.836768] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545816296+8) 4294967261
>> [13568.836769] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545816296+8) 4294967260
>> [13568.836770] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545816296+8) 4294967259
>> [13595.486041] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545821480+8) 4294967260
>> [13595.486114] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545821480+8) 4294967261
>> [13595.486450] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545821480+8) 4294967262
>> [13595.486544] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545821480+8) 4294967263
>> [13595.486756] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545821480+8) 4294967264
>> [13595.486807] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545821480+8) 4294967265
>> [13595.487127] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545821480+8) 4294967266
>> [13684.444417] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545821480+8) 4294967265
>> [13684.453904] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545821480+8) 4294967264
>> [13684.463391] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545821480+8) 4294967263
>> [13684.472878] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545821480+8) 4294967262
>> [13684.482361] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545821480+8) 4294967261
>> [13684.491850] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545821480+8) 4294967260
>> [13684.501340] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545821480+8) 4294967259
>> [13686.643818] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324647016+8) 4294967260
>> [13686.643853] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324647016+8) 4294967261
>> [13686.643948] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324647016+8) 4294967262
>> [13686.643993] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324647016+8) 4294967263
>> [13686.644144] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324647016+8) 4294967264
>> [13686.644406] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324647016+8) 4294967265
>> [13686.644525] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324647016+8) 4294967266
>> [13734.793297] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324647016+8) 4294967265
>> [13734.809137] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324647016+8) 4294967264
>> [13744.445102] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324647016+8) 4294967263
>> [13744.454593] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324647016+8) 4294967262
>> [13744.464083] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324647016+8) 4294967261
>> [13744.473560] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324647016+8) 4294967260
>> [13744.483051] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324647016+8) 4294967259
>> [13820.332081] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324654440+8) 4294967264
>> [13820.341572] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324654440+8) 4294967263
>> [13820.351058] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324654440+8) 4294967262
>> [13820.360550] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324654440+8) 4294967261
>> [13820.370039] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324654440+8) 4294967260
>> [13820.379525] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324654440+8) 4294967259
>> [13828.887574] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324662056+8) 4294967260
>> [13828.888698] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324662056+8) 4294967261
>> [13828.888811] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324662056+8) 4294967262
>> [13828.888838] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324662056+8) 4294967263
>> [13828.888877] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324662056+8) 4294967264
>> [13828.889012] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324662056+8) 4294967265
>> [13828.889087] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324662056+8) 4294967266
>> [13939.263249] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324662056+8) 4294967265
>> [13939.272744] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324662056+8) 4294967264
>> [13939.282233] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324662056+8) 4294967263
>> [13939.291721] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324662056+8) 4294967262
>> [13939.301203] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324662056+8) 4294967261
>> [13939.310687] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324662056+8) 4294967260
>> [13939.320173] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324662056+8) 4294967259
>> [13949.622362] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032748904+8) 4294967260
>> [13975.927477] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324672360+8) 4294967267
>> [13975.932834] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324672360+8) 4294967266
>> [13975.932837] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324672360+8) 4294967265
>> [13975.932840] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324672360+8) 4294967264
>> [13975.932843] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324672360+8) 4294967263
>> [13975.932845] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324672360+8) 4294967262
>> [13975.932848] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324672360+8) 4294967261
>> [13975.932851] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324672360+8) 4294967260
>> [13975.932853] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324672360+8) 4294967259
>> [14002.581980] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324674920+8) 4294967260
>> [14002.582096] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324674920+8) 4294967261
>> [14002.582385] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324674920+8) 4294967262
>> [14002.582558] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324674920+8) 4294967263
>> [14002.582619] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324674920+8) 4294967264
>> [14002.582667] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324674920+8) 4294967265
>> [14119.130023] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324674920+8) 4294967264
>> [14119.139513] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324674920+8) 4294967263
>> [14119.148996] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324674920+8) 4294967262
>> [14119.158486] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324674920+8) 4294967261
>> [14119.167972] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324674920+8) 4294967260
>> [14119.177456] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324674920+8) 4294967259
>> [14124.072930] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324682216+8) 4294967260
>> [14124.073027] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324682216+8) 4294967262
>> [14124.073025] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324682216+8) 4294967261
>> [14124.073126] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324682216+8) 4294967263
>> [14124.073129] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324682216+8) 4294967264
>> [14124.073379] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324682216+8) 4294967265
>> [14210.467642] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324682216+8) 4294967264
>> [14210.467644] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324682216+8) 4294967263
>> [14210.467645] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324682216+8) 4294967262
>> [14210.467647] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324682216+8) 4294967261
>> [14210.467650] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324682216+8) 4294967260
>> [14210.467652] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324682216+8) 4294967259
>> [14239.699953] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29312349928+8) 4294967260
>> [14343.004904] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29312349928+8) 4294967259
>> [14351.607882] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324697960+8) 4294967260
>> [14351.607891] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324697960+8) 4294967262
>> [14351.607979] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324697960+8) 4294967263
>> [14351.607884] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324697960+8) 4294967261
>> [14351.608559] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324697960+8) 4294967264
>> [14351.608811] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324697960+8) 4294967265
>> [14351.691948] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324697960+8) 4294967266
>> [14460.596492] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324697960+8) 4294967265
>> [14460.596493] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324697960+8) 4294967264
>> [14460.596494] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324697960+8) 4294967263
>> [14460.596495] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324697960+8) 4294967262
>> [14460.596496] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324697960+8) 4294967261
>> [14460.596497] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324697960+8) 4294967260
>> [14460.596499] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324697960+8) 4294967259
>> [14460.598694] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324706536+8) 4294967260
>> [14460.598948] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324706536+8) 4294967261
>> [14460.599105] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324706536+8) 4294967262
>> [14460.599222] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324706536+8) 4294967263
>> [14460.599261] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324706536+8) 4294967264
>> [14460.599376] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324706536+8) 4294967265
>> [14541.632593] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324706536+8) 4294967264
>> [14541.642093] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324706536+8) 4294967263
>> [14541.651581] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324706536+8) 4294967262
>> [14541.661069] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324706536+8) 4294967261
>> [14541.670554] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324706536+8) 4294967260
>> [14541.680042] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324706536+8) 4294967259
>> [14547.546543] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324713128+8) 4294967260
>> [14547.546543] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324713128+8) 4294967261
>> [14547.547058] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324713128+8) 4294967262
>> [14547.547167] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324713128+8) 4294967263
>> [14547.547468] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324713128+8) 4294967264
>> [14547.547552] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324713128+8) 4294967265
>> [14547.547661] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324713128+8) 4294967266
>> [14547.547697] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324713128+8) 4294967267
>> [14575.315268] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324713128+8) 4294967266
>> [14575.596007] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324713128+8) 4294967265
>> [14575.876716] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324713128+8) 4294967264
>> [14576.157450] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324713128+8) 4294967263
>> [14576.438196] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324713128+8) 4294967262
>> [14576.718943] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324713128+8) 4294967261
>> [14576.999682] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324713128+8) 4294967260
>> [14577.280400] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324713128+8) 4294967259
>> [14582.737304] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032749480+8) 4294967260
>> [14636.539506] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032749480+8) 4294967259
>> [14638.880107] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032749864+8) 4294967260
>> [14657.493830] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032749864+8) 4294967259
>> [14675.212921] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324721960+8) 4294967260
>> [14675.213033] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324721960+8) 4294967261
>> [14675.213091] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324721960+8) 4294967262
>> [14675.213105] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324721960+8) 4294967263
>> [14675.213429] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324721960+8) 4294967264
>> [14675.213477] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324721960+8) 4294967265
>> [14675.213877] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29324721960+8) 4294967266
>> [14737.052888] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324721960+8) 4294967265
>> [14737.062372] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324721960+8) 4294967264
>> [14737.071858] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324721960+8) 4294967263
>> [14737.081341] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324721960+8) 4294967262
>> [14737.090827] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324721960+8) 4294967261
>> [14737.100311] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324721960+8) 4294967260
>> [14737.109810] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29324721960+8) 4294967259
>> [14743.382147] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545824552+8) 4294967260
>> [14743.382495] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545824552+8) 4294967261
>> [14743.382520] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545824552+8) 4294967262
>> [14743.382595] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545824552+8) 4294967263
>> [14743.382607] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545824552+8) 4294967264
>> [14743.382646] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545824552+8) 4294967265
>> [14743.382683] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545824552+8) 4294967266
>> [14836.115483] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545824552+8) 4294967265
>> [14836.124971] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545824552+8) 4294967264
>> [14836.134457] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545824552+8) 4294967263
>> [14836.143943] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545824552+8) 4294967262
>> [14836.153427] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545824552+8) 4294967261
>> [14836.162908] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545824552+8) 4294967260
>> [14836.172392] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545824552+8) 4294967259
>> [14867.977410] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545830952+8) 4294967265
>> [14867.977411] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545830952+8) 4294967264
>> [14867.977413] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545830952+8) 4294967263
>> [14867.977414] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545830952+8) 4294967262
>> [14867.977416] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545830952+8) 4294967261
>> [14867.977418] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545830952+8) 4294967260
>> [14867.977419] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545830952+8) 4294967259
>> [14867.982046] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545836776+8) 4294967260
>> [14867.982289] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545836776+8) 4294967261
>> [14867.982319] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545836776+8) 4294967262
>> [14867.982377] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545836776+8) 4294967263
>> [14867.982398] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545836776+8) 4294967264
>> [14867.982409] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545836776+8) 4294967265
>> [14906.532978] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545845096+8) 4294967264
>> [14906.532983] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545845096+8) 4294967263
>> [14906.532987] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545845096+8) 4294967262
>> [14906.532991] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545845096+8) 4294967261
>> [14906.532995] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545845096+8) 4294967260
>> [14906.533001] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545845096+8) 4294967259
>> [14906.537331] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545849064+8) 4294967260
>> [14906.537374] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545849064+8) 4294967261
>> [14906.537389] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545849064+8) 4294967262
>> [14906.537397] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545849064+8) 4294967263
>> [14906.537413] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545849064+8) 4294967264
>> [14906.537417] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545849064+8) 4294967265
>> [14906.538256] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545849064+8) 4294967266
>> [15000.553174] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545849064+8) 4294967265
>> [15000.562663] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545849064+8) 4294967264
>> [15000.572145] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545849064+8) 4294967263
>> [15000.581619] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545849064+8) 4294967262
>> [15000.591109] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545849064+8) 4294967261
>> [15000.600591] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545849064+8) 4294967260
>> [15000.610079] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545849064+8) 4294967259
>> [15038.840534] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545864360+8) 4294967265
>> [15038.840569] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545864360+8) 4294967266
>> [15038.918437] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545864360+8) 4294967267
>> [15072.110477] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545864360+8) 4294967266
>> [15072.119963] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545864360+8) 4294967265
>> [15072.129445] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545864360+8) 4294967264
>> [15072.138931] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545864360+8) 4294967263
>> [15072.148422] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545864360+8) 4294967262
>> [15072.157919] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545864360+8) 4294967261
>> [15072.167410] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545864360+8) 4294967260
>> [15072.176895] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545864360+8) 4294967259
>> [15094.337077] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545868328+8) 4294967260
>> [15094.337106] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545868328+8) 4294967262
>> [15094.337126] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545868328+8) 4294967264
>> [15094.337145] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545868328+8) 4294967265
>> [15094.337125] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545868328+8) 4294967263
>> [15094.337095] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545868328+8) 4294967261
>> [15094.337202] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545868328+8) 4294967266
>> [15094.337864] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545868328+8) 4294967267
>> [15109.185642] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545868328+8) 4294967266
>> [15109.231325] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545868328+8) 4294967265
>> [15109.276996] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545868328+8) 4294967264
>> [15109.322684] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545868328+8) 4294967263
>> [15109.368357] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545868328+8) 4294967262
>> [15109.414059] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545868328+8) 4294967261
>> [15109.459734] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545868328+8) 4294967260
>> [15109.505426] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545868328+8) 4294967259
>> [15109.940853] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545870888+8) 4294967266
>> [15109.940854] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545870888+8) 4294967265
>> [15109.940856] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545870888+8) 4294967264
>> [15109.940857] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545870888+8) 4294967263
>> [15109.940858] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545870888+8) 4294967262
>> [15109.940860] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545870888+8) 4294967261
>> [15109.940862] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545870888+8) 4294967260
>> [15109.940863] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545870888+8) 4294967259
>> [15109.943869] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032750824+8) 4294967260
>> [15109.946364] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032750824+8) 4294967259
>> [15143.938195] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545873384+8) 4294967260
>> [15143.938199] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545873384+8) 4294967261
>> [15143.938502] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545873384+8) 4294967262
>> [15143.938860] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545873384+8) 4294967263
>> [15143.939079] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545873384+8) 4294967265
>> [15143.939055] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545873384+8) 4294967264
>> [15194.321503] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545873384+8) 4294967264
>> [15194.330986] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545873384+8) 4294967263
>> [15194.340472] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545873384+8) 4294967262
>> [15194.349954] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545873384+8) 4294967261
>> [15194.359431] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545873384+8) 4294967260
>> [15194.368920] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545873384+8) 4294967259
>> [15202.981864] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545880552+8) 4294967260
>> [15202.982006] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545880552+8) 4294967262
>> [15202.982049] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545880552+8) 4294967263
>> [15202.981938] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545880552+8) 4294967261
>> [15202.982750] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545880552+8) 4294967264
>> [15284.694932] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545880552+8) 4294967263
>> [15284.704421] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545880552+8) 4294967262
>> [15284.713913] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545880552+8) 4294967261
>> [15284.723400] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545880552+8) 4294967260
>> [15284.732888] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545880552+8) 4294967259
>> [15293.005593] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29531458344+8) 4294967264
>> [15293.005596] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29531458344+8) 4294967263
>> [15293.005597] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29531458344+8) 4294967262
>> [15293.005599] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29531458344+8) 4294967261
>> [15293.005602] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29531458344+8) 4294967260
>> [15293.005603] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29531458344+8) 4294967259
>> [15293.008211] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032751272+8) 4294967260
>> [15293.009308] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032751272+8) 4294967259
>> [15361.123918] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545683432+8) 4294967265
>> [15361.133405] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545683432+8) 4294967264
>> [15361.142894] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545683432+8) 4294967263
>> [15361.152384] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545683432+8) 4294967262
>> [15361.161896] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545683432+8) 4294967261
>> [15361.171380] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545683432+8) 4294967260
>> [15361.180864] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545683432+8) 4294967259
>> [15364.021538] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545884008+8) 4294967260
>> [15364.021666] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545884008+8) 4294967261
>> [15364.022045] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545884008+8) 4294967262
>> [15364.022114] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545884008+8) 4294967264
>> [15364.022092] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545884008+8) 4294967263
>> [15364.022137] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545884008+8) 4294967265
>> [15364.022367] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545884008+8) 4294967266
>> [15364.022522] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545884008+8) 4294967267
>> [15374.355722] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545884008+8) 4294967266
>> [15374.554797] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545884008+8) 4294967265
>> [15374.753840] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545884008+8) 4294967264
>> [15374.952890] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545884008+8) 4294967263
>> [15375.151938] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545884008+8) 4294967262
>> [15375.351041] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545884008+8) 4294967261
>> [15375.550089] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545884008+8) 4294967260
>> [15375.749178] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545884008+8) 4294967259
>> [15475.090773] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545887592+8) 4294967263
>> [15475.090778] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545887592+8) 4294967262
>> [15475.090782] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545887592+8) 4294967261
>> [15475.090790] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545887592+8) 4294967260
>> [15475.090795] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545887592+8) 4294967259
>> [15512.462087] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29530332008+8) 4294967260
>> [15605.182723] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29530332008+8) 4294967259
>> [15610.777819] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545906216+8) 4294967260
>> [15610.778112] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545906216+8) 4294967261
>> [15610.778158] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545906216+8) 4294967262
>> [15610.778540] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545906216+8) 4294967263
>> [15610.778741] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545906216+8) 4294967264
>> [15610.778768] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545906216+8) 4294967265
>> [15610.779126] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545906216+8) 4294967266
>> [15610.779136] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545906216+8) 4294967267
>> [15625.092720] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545906216+8) 4294967266
>> [15625.291753] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545906216+8) 4294967265
>> [15625.490794] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545906216+8) 4294967264
>> [15625.689869] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545906216+8) 4294967263
>> [15625.888922] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545906216+8) 4294967262
>> [15626.087961] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545906216+8) 4294967261
>> [15626.287002] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545906216+8) 4294967260
>> [15626.486060] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545906216+8) 4294967259
>> [15631.421893] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545907560+8) 4294967260
>> [15631.422458] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545907560+8) 4294967261
>> [15631.422563] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545907560+8) 4294967262
>> [15631.422804] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545907560+8) 4294967263
>> [15631.422822] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545907560+8) 4294967264
>> [15631.422885] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545907560+8) 4294967265
>> [15649.575279] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545907560+8) 4294967266
>> [15684.592107] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545907560+8) 4294967265
>> [15684.601597] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545907560+8) 4294967264
>> [15684.611088] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545907560+8) 4294967263
>> [15684.620575] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545907560+8) 4294967262
>> [15684.630060] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545907560+8) 4294967261
>> [15684.639545] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545907560+8) 4294967260
>> [15684.649027] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545907560+8) 4294967259
>> [15690.850975] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545911720+8) 4294967260
>> [15690.851550] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545911720+8) 4294967261
>> [15690.851939] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545911720+8) 4294967262
>> [15690.852053] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545911720+8) 4294967263
>> [15690.852178] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545911720+8) 4294967264
>> [15690.852281] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545911720+8) 4294967265
>> [15690.852313] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545911720+8) 4294967266
>> [15735.620596] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545921320+8) 4294967260
>> [15735.620646] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545921320+8) 4294967261
>> [15735.620685] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545921320+8) 4294967263
>> [15735.620686] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545921320+8) 4294967264
>> [15735.620652] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545921320+8) 4294967262
>> [15735.621500] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545921320+8) 4294967265
>> [15816.149770] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545921320+8) 4294967264
>> [15816.149772] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545921320+8) 4294967263
>> [15816.149774] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545921320+8) 4294967262
>> [15816.149776] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545921320+8) 4294967261
>> [15816.149778] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545921320+8) 4294967260
>> [15816.149780] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29545921320+8) 4294967259
>> [15844.779214] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545928872+8) 4294967260
>> [15844.779218] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29545928872+8) 4294967261
>> [15934.023215] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816766056+8) 4294967265
>> [15934.032699] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816766056+8) 4294967264
>> [15934.042184] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816766056+8) 4294967263
>> [15934.051668] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816766056+8) 4294967262
>> [15934.061153] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816766056+8) 4294967261
>> [15934.070639] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816766056+8) 4294967260
>> [15934.080128] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816766056+8) 4294967259
>> [15935.505198] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816773224+8) 4294967260
>> [15935.505344] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816773224+8) 4294967261
>> [15935.505684] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816773224+8) 4294967262
>> [15951.816975] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816773224+8) 4294967263
>> [15951.817541] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816773224+8) 4294967264
>> [15951.817733] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816773224+8) 4294967265
>> [16048.370516] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816773224+8) 4294967264
>> [16048.370517] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816773224+8) 4294967263
>> [16048.370518] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816773224+8) 4294967262
>> [16048.370520] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816773224+8) 4294967261
>> [16048.370521] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816773224+8) 4294967260
>> [16048.370522] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816773224+8) 4294967259
>> [16048.372719] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816781032+8) 4294967260
>> [16048.373083] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816781032+8) 4294967261
>> [16048.373765] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816781032+8) 4294967262
>> [16048.373913] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816781032+8) 4294967263
>> [16048.373913] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816781032+8) 4294967264
>> [16048.373936] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816781032+8) 4294967265
>> [16048.373938] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816781032+8) 4294967266
>> [16048.373966] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816781032+8) 4294967267
>> [16099.152109] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816781032+8) 4294967266
>> [16099.438210] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816781032+8) 4294967265
>> [16099.724249] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816781032+8) 4294967264
>> [16100.011268] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816781032+8) 4294967263
>> [16100.298239] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816781032+8) 4294967262
>> [16100.585188] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816781032+8) 4294967261
>> [16100.872155] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816781032+8) 4294967260
>> [16101.159163] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816781032+8) 4294967259
>> [16105.965912] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816783592+8) 4294967260
>> [16105.966207] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816783592+8) 4294967261
>> [16105.966279] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816783592+8) 4294967262
>> [16105.966399] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816783592+8) 4294967263
>> [16105.966643] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816783592+8) 4294967264
>> [16105.966725] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816783592+8) 4294967265
>> [16163.037754] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816815272+8) 4294967260
>> [16163.037836] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816815272+8) 4294967261
>> [16163.037883] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816815272+8) 4294967262
>> [16163.038018] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816815272+8) 4294967263
>> [16163.038537] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816815272+8) 4294967264
>> [16163.039472] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816815272+8) 4294967265
>> [16163.263169] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816815272+8) 4294967266
>> [16264.133495] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816815272+8) 4294967265
>> [16264.142981] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816815272+8) 4294967264
>> [16264.152464] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816815272+8) 4294967263
>> [16264.161951] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816815272+8) 4294967262
>> [16264.171441] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816815272+8) 4294967261
>> [16264.180935] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816815272+8) 4294967260
>> [16264.190424] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816815272+8) 4294967259
>> [16266.992432] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816820136+8) 4294967260
>> [16266.992711] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816820136+8) 4294967261
>> [16266.993213] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816820136+8) 4294967262
>> [16266.993398] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816820136+8) 4294967263
>> [16266.993458] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816820136+8) 4294967264
>> [16290.695547] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816820136+8) 4294967265
>> [16290.695556] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816820136+8) 4294967266
>> [16379.808266] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816820136+8) 4294967265
>> [16379.817751] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816820136+8) 4294967264
>> [16379.827236] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816820136+8) 4294967263
>> [16379.836720] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816820136+8) 4294967262
>> [16379.846205] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816820136+8) 4294967261
>> [16379.855697] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816820136+8) 4294967260
>> [16379.865187] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816820136+8) 4294967259
>> [16387.725516] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816798760+8) 4294967260
>> [16387.725798] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816798760+8) 4294967261
>> [16387.725917] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816798760+8) 4294967262
>> [16387.726352] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816798760+8) 4294967263
>> [16387.726414] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816798760+8) 4294967264
>> [16387.726707] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816798760+8) 4294967265
>> [16408.022981] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816798760+8) 4294967266
>> [16505.753964] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816798760+8) 4294967265
>> [16505.763456] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816798760+8) 4294967264
>> [16505.772952] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816798760+8) 4294967263
>> [16505.782444] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816798760+8) 4294967262
>> [16505.791921] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816798760+8) 4294967261
>> [16505.801405] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816798760+8) 4294967260
>> [16505.810889] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816798760+8) 4294967259
>> [16515.475620] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816802408+8) 4294967261
>> [16515.475613] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816802408+8) 4294967260
>> [16515.475711] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816802408+8) 4294967262
>> [16515.475844] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816802408+8) 4294967263
>> [16515.475958] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816802408+8) 4294967264
>> [16515.476377] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816802408+8) 4294967265
>> [16515.476744] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816802408+8) 4294967266
>> [16534.160611] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816802408+8) 4294967267
>> [16554.448056] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816802408+8) 4294967266
>> [16554.457546] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816802408+8) 4294967265
>> [16554.467022] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816802408+8) 4294967264
>> [16554.476504] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816802408+8) 4294967263
>> [16554.485979] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816802408+8) 4294967262
>> [16554.495463] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816802408+8) 4294967261
>> [16554.504953] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816802408+8) 4294967260
>> [16554.514442] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816802408+8) 4294967259
>> [16555.835592] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816805160+8) 4294967260
>> [16555.835847] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816805160+8) 4294967261
>> [16555.836140] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816805160+8) 4294967262
>> [16555.836279] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816805160+8) 4294967263
>> [16576.074289] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816805160+8) 4294967264
>> [16576.074652] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816805160+8) 4294967265
>> [16576.075049] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816805160+8) 4294967266
>> [16702.114836] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816805160+8) 4294967265
>> [16702.124323] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816805160+8) 4294967264
>> [16702.133808] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816805160+8) 4294967263
>> [16702.143300] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816805160+8) 4294967262
>> [16702.152799] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816805160+8) 4294967261
>> [16702.162289] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816805160+8) 4294967260
>> [16702.171773] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816805160+8) 4294967259
>> [16710.388044] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816808616+8) 4294967260
>> [16710.388157] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816808616+8) 4294967261
>> [16710.388256] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816808616+8) 4294967262
>> [16710.388347] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816808616+8) 4294967264
>> [16710.388390] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816808616+8) 4294967265
>> [16710.388410] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816808616+8) 4294967266
>> [16710.388285] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816808616+8) 4294967263
>> [16710.389466] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816808616+8) 4294967267
>> [16726.681690] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816808616+8) 4294967266
>> [16732.076989] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816808616+8) 4294967265
>> [16732.227720] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816808616+8) 4294967264
>> [16732.378463] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816808616+8) 4294967263
>> [16732.529207] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816808616+8) 4294967262
>> [16732.679930] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816808616+8) 4294967261
>> [16732.830681] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816808616+8) 4294967260
>> [16732.981424] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816808616+8) 4294967259
>> [16739.691982] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816835496+8) 4294967261
>> [16739.691980] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816835496+8) 4294967260
>> [16739.692049] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816835496+8) 4294967262
>> [16739.692753] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816835496+8) 4294967263
>> [16739.693143] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816835496+8) 4294967264
>> [16739.693286] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816835496+8) 4294967265
>> [16739.693391] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816835496+8) 4294967266
>> [16796.194339] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816839720+8) 4294967260
>> [16796.194398] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816839720+8) 4294967261
>> [16796.194422] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816839720+8) 4294967262
>> [16796.194483] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816839720+8) 4294967263
>> [16796.194946] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816839720+8) 4294967264
>> [16796.195038] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816839720+8) 4294967265
>> [16796.195499] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816839720+8) 4294967266
>> [16870.648462] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032753896+8) 4294967260
>> [16898.893981] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032753896+8) 4294967259
>> [16967.311945] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816848744+8) 4294967265
>> [16967.321437] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816848744+8) 4294967264
>> [16967.330924] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816848744+8) 4294967263
>> [16967.340412] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816848744+8) 4294967262
>> [16967.349896] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816848744+8) 4294967261
>> [16967.359379] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816848744+8) 4294967260
>> [16967.368867] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816848744+8) 4294967259
>> [16976.071394] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816856744+8) 4294967260
>> [16976.071413] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816856744+8) 4294967261
>> [16976.071469] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816856744+8) 4294967262
>> [16976.071568] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816856744+8) 4294967263
>> [16976.071677] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816856744+8) 4294967264
>> [16976.071732] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816856744+8) 4294967266
>> [16976.071700] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816856744+8) 4294967265
>> [16976.072068] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816856744+8) 4294967267
>> [16990.311360] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816856744+8) 4294967266
>> [16990.481108] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816856744+8) 4294967265
>> [16990.650832] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816856744+8) 4294967264
>> [16990.820572] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816856744+8) 4294967263
>> [16990.990305] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816856744+8) 4294967262
>> [16991.160043] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816856744+8) 4294967261
>> [16991.329786] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816856744+8) 4294967260
>> [16991.499551] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816856744+8) 4294967259
>> [16996.987839] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032754024+8) 4294967260
>> [17047.151615] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032754024+8) 4294967259
>> [17115.879905] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816864616+8) 4294967264
>> [17115.889391] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816864616+8) 4294967263
>> [17115.898868] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816864616+8) 4294967262
>> [17115.908352] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816864616+8) 4294967261
>> [17115.917837] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816864616+8) 4294967260
>> [17115.927320] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816864616+8) 4294967259
>> [17116.400129] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816873704+8) 4294967260
>> [17116.400218] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816873704+8) 4294967261
>> [17116.400665] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816873704+8) 4294967262
>> [17116.400972] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816873704+8) 4294967263
>> [17116.401012] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816873704+8) 4294967264
>> [17116.401073] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816873704+8) 4294967265
>> [17116.401094] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29816873704+8) 4294967266
>> [17173.631876] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816873704+8) 4294967265
>> [17173.631877] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816873704+8) 4294967264
>> [17173.631878] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816873704+8) 4294967263
>> [17173.631880] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816873704+8) 4294967262
>> [17173.631881] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816873704+8) 4294967261
>> [17173.631883] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816873704+8) 4294967260
>> [17173.631885] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(29816873704+8) 4294967259
>> [17201.424309] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032753960+8) 4294967260
>> [17209.574673] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032753960+8) 4294967259
>> [17212.610080] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3568296+8) 4294967260
>> [17212.610550] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3568296+8) 4294967261
>> [17226.574613] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3568296+8) 4294967262
>> [17226.574818] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3568296+8) 4294967263
>> [17226.575156] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3568296+8) 4294967264
>> [17226.575266] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3568296+8) 4294967265
>> [17226.575729] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3568296+8) 4294967266
>> [17296.342998] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3568296+8) 4294967265
>> [17296.352083] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3568296+8) 4294967264
>> [17296.361178] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3568296+8) 4294967263
>> [17296.370271] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3568296+8) 4294967262
>> [17296.379366] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3568296+8) 4294967261
>> [17296.388464] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3568296+8) 4294967260
>> [17296.397557] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3568296+8) 4294967259
>> [17297.711781] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3559976+8) 4294967260
>> [17297.712071] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3559976+8) 4294967261
>> [17311.049521] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3559976+8) 4294967262
>> [17311.049595] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(3559976+8) 4294967263
>> [17391.178025] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3559976+8) 4294967262
>> [17391.187127] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3559976+8) 4294967261
>> [17391.196230] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3559976+8) 4294967260
>> [17391.205325] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(3559976+8) 4294967259
>> [17397.357339] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(77864+8) 4294967260
>> [17397.358064] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(77864+8) 4294967261
>> [17397.358191] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(77864+8) 4294967262
>> [17406.112100] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(77864+8) 4294967263
>> [17460.063716] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(77864+8) 4294967262
>> [17460.072623] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(77864+8) 4294967261
>> [17460.081520] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(77864+8) 4294967260
>> [17460.090422] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(77864+8) 4294967259
>> [17464.959257] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(75624+8) 4294967260
>> [17482.594510] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(75624+8) 4294967259
>> [17508.091641] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(69480+8) 4294967261
>> [17508.091640] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(69480+8) 4294967260
>> [17508.091647] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(69480+8) 4294967262
>> [17532.456256] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(68008+8) 4294967260
>> [17532.456294] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(68008+8) 4294967261
>> [17532.456309] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(68008+8) 4294967262
>> [17572.776358] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(68008+8) 4294967261
>> [17572.785257] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(68008+8) 4294967260
>> [17572.794163] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(68008+8) 4294967259
>> [17594.427109] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(12348140520+8) 4294967259
>> [17631.571482] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(59688+8) 4294967262
>> [17633.896087] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(59688+8) 4294967261
>> [17633.904990] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(59688+8) 4294967260
>> [17633.913889] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(59688+8) 4294967259
>> [17640.670153] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(42344+8) 4294967262
>> [17661.740739] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(48232+8) 4294967264
>> [17661.740869] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(48232+8) 4294967265
>> [17691.866848] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(48232+8) 4294967264
>> [17691.866850] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(48232+8) 4294967263
>> [17691.866851] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(48232+8) 4294967262
>> [17691.866853] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(48232+8) 4294967261
>> [17691.866854] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(48232+8) 4294967260
>> [17691.866855] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(48232+8) 4294967259
>> [17711.055783] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(50024+8) 4294967260
>> [17711.055850] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(50024+8) 4294967262
>> [17711.055807] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(50024+8) 4294967261
>> [17753.659012] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(50024+8) 4294967261
>> [17753.667920] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(50024+8) 4294967260
>> [17753.676822] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(50024+8) 4294967259
>> [17756.839874] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032754472+8) 4294967260
>> [17761.904589] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032754472+8) 4294967259
>> [17764.608952] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(39848+8) 4294967260
>> [17764.609156] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(39848+8) 4294967262
>> [17764.609117] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(39848+8) 4294967261
>> [17764.609992] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(39848+8) 4294967263
>> [17785.372101] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(39848+8) 4294967264
>> [17785.480370] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(39848+8) 4294967265
>> [17831.956995] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(39848+8) 4294967264
>> [17831.965897] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(39848+8) 4294967263
>> [17831.974795] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(39848+8) 4294967262
>> [17831.983692] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(39848+8) 4294967261
>> [17831.992592] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(39848+8) 4294967260
>> [17832.001495] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(39848+8) 4294967259
>> [17834.344591] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032755304+8) 4294967260
>> [17843.122828] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(15032755304+8) 4294967259
>> [17845.582553] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(49576+8) 4294967260
>> [17845.582666] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(49576+8) 4294967261
>> [17845.583154] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(49576+8) 4294967262
>> [17845.583190] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(49576+8) 4294967264
>> [17845.583179] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(49576+8) 4294967263
>> [17895.265867] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(49576+8) 4294967263
>> [17895.274772] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(49576+8) 4294967262
>> [17895.283673] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(49576+8) 4294967261
>> [17895.292578] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(49576+8) 4294967260
>> [17895.301470] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(49576+8) 4294967259
>> [17898.047030] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(32744+8) 4294967260
>> [17898.048282] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(32744+8) 4294967261
>> [17898.049252] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(32744+8) 4294967260
>> [17898.049253] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(32744+8) 4294967259
>> [17910.857571] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26536+8) 4294967260
>> [17910.857605] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(26536+8) 4294967261
>> [17940.805214] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26536+8) 4294967260
>> [17940.805216] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26536+8) 4294967259
>> [17953.692889] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21992+8) 4294967261
>> [17953.692929] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21992+8) 4294967262
>> [17953.693143] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21992+8) 4294967261
>> [17953.694264] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21992+8) 4294967262
>> [18003.530258] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21992+8) 4294967261
>> [18003.539162] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21992+8) 4294967260
>> [18003.548066] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21992+8) 4294967259
>> [18009.481434] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(26216+8) 4294967259
>> [18009.492293] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(25704+8) 4294967260
>> [18048.069279] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(25704+8) 4294967259
>> [18048.552558] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(14056+8) 4294967260
>> [18048.552796] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(14056+8) 4294967261
>> [18048.552825] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(14056+8) 4294967262
>> [18048.554933] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(14056+8) 4294967263
>> [18081.808216] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(14056+8) 4294967262
>> [18081.808217] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(14056+8) 4294967261
>> [18081.808219] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(14056+8) 4294967260
>> [18081.808220] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(14056+8) 4294967259
>> [18081.819956] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(19816+8) 4294967260
>> [18081.820706] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(19816+8) 4294967261
>> [18110.361331] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(19816+8) 4294967260
>> [18110.361332] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(19816+8) 4294967259
>> [18160.565496] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(10792+8) 4294967263
>> [18169.306917] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(10792+8) 4294967260
>> [18169.306918] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(10792+8) 4294967259
>> [18169.318095] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(20764456+8) 4294967260
>> [18169.319212] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(20764456+8) 4294967261
>> [18169.394456] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(20764456+8) 4294967262
>> [18211.597621] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(61800+8) 4294967259
>> [18261.334926] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(8296+8) 4294967260
>> [18261.335380] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(8296+8) 4294967261
>> [18297.192489] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(25501361192+8) 4294967259
>> [18332.815982] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21156200+8) 4294967262
>> [18332.816950] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21156200+8) 4294967263
>> [18332.819467] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21156200+8) 4294967264
>> [18332.819799] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21156200+8) 4294967265
>> [18332.820819] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21156200+8) 4294967266
>> [18363.308810] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21156200+8) 4294967265
>> [18363.308813] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21156200+8) 4294967264
>> [18363.308816] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21156200+8) 4294967263
>> [18363.308819] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21156200+8) 4294967262
>> [18363.308822] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21156200+8) 4294967261
>> [18363.308825] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21156200+8) 4294967260
>> [18363.308828] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(21156200+8) 4294967259
>> [18412.849619] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21171752+8) 4294967262
>> [18412.850582] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21171752+8) 4294967263
>> [18412.850911] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21171752+8) 4294967264
>> [18412.851264] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(21171752+8) 4294967265
>> [18443.565725] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(28454161000+8) 4294967260
>> [18473.028395] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331145896+8) 4294967260
>> [18473.029608] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331145896+8) 4294967261
>> [18502.557646] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331145896+8) 4294967262
>> [18502.557723] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331145896+8) 4294967263
>> [18502.558152] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331145896+8) 4294967264
>> [18502.558930] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331145896+8) 4294967265
>> [18502.559041] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331145896+8) 4294967266
>> [18502.563022] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331145896+8) 4294967265
>> [18502.563024] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331145896+8) 4294967264
>> [18502.563025] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331145896+8) 4294967263
>> [18502.563026] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331145896+8) 4294967262
>> [18502.563027] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331145896+8) 4294967261
>> [18502.563029] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331145896+8) 4294967260
>> [18502.563030] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331145896+8) 4294967259
>> [18560.133303] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331007720+8) 4294967259
>> [18589.564077] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331158184+8) 4294967260
>> [18589.564089] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331158184+8) 4294967261
>> [18589.564670] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331158184+8) 4294967262
>> [18589.565137] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331158184+8) 4294967263
>> [18589.565700] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331158184+8) 4294967264
>> [18589.566003] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331158184+8) 4294967265
>> [18638.817896] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331165224+8) 4294967260
>> [18639.851587] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(4563405800+8) 4294967260
>> [18721.230354] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(6174129128+8) 4294967260
>> [18753.264400] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(6174129128+8) 4294967259
>> [18814.918267] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(15032755240+8) 4294967260
>> [18817.035728] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331192424+8) 4294967267
>> [18817.037803] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331192424+8) 4294967266
>> [18817.037809] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331192424+8) 4294967265
>> [18817.037812] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331192424+8) 4294967264
>> [18817.037815] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331192424+8) 4294967263
>> [18817.037818] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331192424+8) 4294967262
>> [18817.037822] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331192424+8) 4294967261
>> [18817.037825] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331192424+8) 4294967260
>> [18817.037827] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331192424+8) 4294967259
>> [18847.022837] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(8589935656+8) 4294967260
>> [18931.949431] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(29530321832+8) 4294967260
>> [19054.852844] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331221672+8) 4294967265
>> [19054.852846] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331221672+8) 4294967264
>> [19054.852847] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331221672+8) 4294967263
>> [19054.852849] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331221672+8) 4294967262
>> [19054.852850] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331221672+8) 4294967261
>> [19054.852852] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331221672+8) 4294967260
>> [19054.852853] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331221672+8) 4294967259
>> [19104.480492] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331234728+8) 4294967264
>> [19104.480523] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331234728+8) 4294967265
>> [19162.254665] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331242344+8) 4294967263
>> [19162.254666] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331242344+8) 4294967262
>> [19162.254668] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331242344+8) 4294967261
>> [19162.254669] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331242344+8) 4294967260
>> [19162.254671] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331242344+8) 4294967259
>> [19194.644616] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331249768+8) 4294967260
>> [19194.644618] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331249768+8) 4294967259
>> [19225.730035] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331254184+8) 4294967260
>> [19225.730135] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331254184+8) 4294967261
>> [19225.730341] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331254184+8) 4294967262
>> [19225.733024] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331254184+8) 4294967263
>> [19225.733509] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331254184+8) 4294967264
>> [19225.799551] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331254184+8) 4294967265
>> [19250.693927] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331254184+8) 4294967266
>> [19251.803761] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331259048+8) 4294967260
>> [19251.805818] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331259048+8) 4294967261
>> [19251.807214] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331259048+8) 4294967262
>> [19251.807230] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331259048+8) 4294967263
>> [19251.807441] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331259048+8) 4294967264
>> [19251.807684] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(331259048+8) 4294967265
>> [19284.419215] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331259048+8) 4294967265
>> [19284.419218] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331259048+8) 4294967264
>> [19284.419221] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331259048+8) 4294967263
>> [19284.419222] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331259048+8) 4294967262
>> [19284.419225] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331259048+8) 4294967261
>> [19284.419228] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331259048+8) 4294967260
>> [19284.419230] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(331259048+8) 4294967259
>> [19324.123801] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(540515944+8) 4294967260
>> [19324.124880] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(540515944+8) 4294967261
>> [19389.626363] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(540515944+8) 4294967264
>> [19389.626366] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(540515944+8) 4294967263
>> [19389.626370] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(540515944+8) 4294967262
>> [19389.626373] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(540515944+8) 4294967261
>> [19389.626376] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(540515944+8) 4294967260
>> [19389.626379] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(540515944+8) 4294967259
>> [19411.000068] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(537018984+8) 4294967264
>> [19411.000070] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(537018984+8) 4294967263
>> [19411.000071] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(537018984+8) 4294967262
>> [19411.000073] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(537018984+8) 4294967261
>> [19411.000075] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(537018984+8) 4294967260
>> [19411.000076] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(537018984+8) 4294967259
>> [19442.885291] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536946088+8) 4294967260
>> [19442.885494] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536946088+8) 4294967261
>> [19442.885496] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536946088+8) 4294967262
>> [19442.885575] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536946088+8) 4294967263
>> [19500.040964] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536935976+8) 4294967260
>> [19503.516938] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536935976+8) 4294967263
>> [19503.516939] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536935976+8) 4294967262
>> [19503.516941] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536935976+8) 4294967261
>> [19503.516942] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536935976+8) 4294967260
>> [19503.516944] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536935976+8) 4294967259
>> [19531.506729] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536929960+8) 4294967261
>> [19531.507247] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536929960+8) 4294967262
>> [19531.510481] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536929960+8) 4294967263
>> [19559.370264] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536929960+8) 4294967262
>> [19559.370268] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536929960+8) 4294967261
>> [19559.370272] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536929960+8) 4294967260
>> [19559.370275] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536929960+8) 4294967259
>> [19590.464792] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(7788215976+8) 4294967260
>> [19620.633883] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(7788215976+8) 4294967259
>> [19650.250748] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536913192+8) 4294967260
>> [19680.643891] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(20135746152+8) 4294967260
>> [19708.804030] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(20135746152+8) 4294967259
>> [19737.574540] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536913640+8) 4294967260
>> [19737.574543] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536913640+8) 4294967259
>> [19765.378569] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536900904+8) 4294967261
>> [19794.831033] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536910312+8) 4294967260
>> [19821.381894] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536910312+8) 4294967259
>> [19821.429688] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536898024+8) 4294967264
>> [19856.960152] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536883944+8) 4294967260
>> [19856.964598] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536883944+8) 4294967261
>> [19856.967055] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536883944+8) 4294967262
>> [19879.048926] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536883944+8) 4294967263
>> [19879.048937] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536883944+8) 4294967264
>> [19887.395626] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536883944+8) 4294967263
>> [19887.395631] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536883944+8) 4294967262
>> [19887.395634] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536883944+8) 4294967261
>> [19887.395637] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536883944+8) 4294967260
>> [19887.395639] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536883944+8) 4294967259
>> [19887.406610] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536878120+8) 4294967260
>> [19916.087911] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536878120+8) 4294967261
>> [19918.951492] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536876264+8) 4294967260
>> [19947.259645] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(536876264+8) 4294967261
>> [19983.717648] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536876264+8) 4294967260
>> [19983.717650] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(536876264+8) 4294967259
>> [19983.723154] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555348520+8) 4294967260
>> [19983.723284] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555348520+8) 4294967261
>> [19983.723330] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555348520+8) 4294967262
>> [19983.723447] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555348520+8) 4294967263
>> [20015.225720] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555348520+8) 4294967264
>> [20015.225737] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555348520+8) 4294967265
>> [20015.233248] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555348520+8) 4294967264
>> [20015.233249] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555348520+8) 4294967263
>> [20015.233250] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555348520+8) 4294967262
>> [20015.233251] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555348520+8) 4294967261
>> [20015.233252] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555348520+8) 4294967260
>> [20015.233253] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555348520+8) 4294967259
>> [20039.634420] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555348520+8) 4294967260
>> [20059.881519] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555355880+8) 4294967263
>> [20059.881521] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555355880+8) 4294967262
>> [20059.881522] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555355880+8) 4294967261
>> [20059.881523] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555355880+8) 4294967260
>> [20059.881524] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555355880+8) 4294967259
>> [20091.703960] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555360360+8) 4294967260
>> [20091.704062] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555360360+8) 4294967261
>> [20091.704130] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555360360+8) 4294967262
>> [20091.704371] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555360360+8) 4294967263
>> [20091.704597] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555360360+8) 4294967264
>> [20091.705014] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555360360+8) 4294967265
>> [20091.705043] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555360360+8) 4294967266
>> [20091.705080] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555360360+8) 4294967267
>> [20107.172534] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555360360+8) 4294967266
>> [20107.416045] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555360360+8) 4294967265
>> [20107.659569] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555360360+8) 4294967264
>> [20107.903083] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555360360+8) 4294967263
>> [20108.146684] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555360360+8) 4294967262
>> [20108.390242] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555360360+8) 4294967261
>> [20108.633740] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555360360+8) 4294967260
>> [20108.877229] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555360360+8) 4294967259
>> [20125.925086] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555361448+8) 4294967260
>> [20125.925103] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555361448+8) 4294967261
>> [20128.394916] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555361448+8) 4294967262
>> [20128.583655] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555361448+8) 4294967263
>> [20132.751983] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555361448+8) 4294967264
>> [20138.332744] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555365992+8) 4294967260
>> [20138.333973] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555365992+8) 4294967261
>> [20138.334178] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555365992+8) 4294967262
>> [20138.335009] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555365992+8) 4294967263
>> [20138.335115] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555365992+8) 4294967264
>> [20138.335265] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555365992+8) 4294967265
>> [20138.338858] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555365992+8) 4294967264
>> [20138.338860] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555365992+8) 4294967263
>> [20138.338862] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555365992+8) 4294967262
>> [20138.338864] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555365992+8) 4294967261
>> [20138.338866] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555365992+8) 4294967260
>> [20138.338868] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555365992+8) 4294967259
>> [20166.832981] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555368936+8) 4294967260
>> [20166.833229] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555368936+8) 4294967261
>> [20166.834027] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555368936+8) 4294967262
>> [20196.134888] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555368936+8) 4294967263
>> [20199.500306] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555373992+8) 4294967263
>> [20199.500310] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555373992+8) 4294967262
>> [20199.500313] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555373992+8) 4294967261
>> [20199.500317] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555373992+8) 4294967260
>> [20199.500321] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555373992+8) 4294967259
>> [20199.942600] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555373992+8) 4294967260
>> [20199.944367] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555373992+8) 4294967259
>> [20245.088563] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555378728+8) 4294967260
>> [20245.088642] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555378728+8) 4294967261
>> [20245.088687] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555378728+8) 4294967262
>> [20245.088777] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555378728+8) 4294967263
>> [20245.091384] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555378728+8) 4294967264
>> [20245.091670] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555378728+8) 4294967265
>> [20245.091900] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555378728+8) 4294967266
>> [20245.092055] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(555378728+8) 4294967267
>> [20271.055283] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555378728+8) 4294967266
>> [20271.064573] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555378728+8) 4294967265
>> [20271.073864] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555378728+8) 4294967264
>> [20271.083165] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555378728+8) 4294967263
>> [20275.933633] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555378728+8) 4294967262
>> [20275.942927] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555378728+8) 4294967261
>> [20275.952228] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555378728+8) 4294967260
>> [20275.961535] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(555378728+8) 4294967259
>> [20280.815537] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805450536+8) 4294967260
>> [20280.816905] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805450536+8) 4294967261
>> [20442.104270] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805450536+8) 4294967260
>> [20443.448533] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805450536+8) 4294967259
>> [20445.747762] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805355304+8) 4294967260
>> [20445.747900] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805355304+8) 4294967261
>> [20445.747918] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805355304+8) 4294967262
>> [20445.748615] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805355304+8) 4294967263
>> [20494.667635] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805355304+8) 4294967264
>> [20494.667769] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805355304+8) 4294967265
>> [20524.978466] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805355304+8) 4294967264
>> [20524.987753] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805355304+8) 4294967263
>> [20524.997049] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805355304+8) 4294967262
>> [20525.006349] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805355304+8) 4294967261
>> [20533.505202] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805355304+8) 4294967260
>> [20533.514488] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805355304+8) 4294967259
>> [20535.464796] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805352616+8) 4294967260
>> [20535.465312] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805352616+8) 4294967261
>> [20547.361843] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805352616+8) 4294967262
>> [20547.362543] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805352616+8) 4294967263
>> [20547.362994] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805352616+8) 4294967264
>> [20565.098049] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805352616+8) 4294967263
>> [20565.098051] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805352616+8) 4294967262
>> [20565.098052] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805352616+8) 4294967261
>> [20565.098054] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805352616+8) 4294967260
>> [20565.098055] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805352616+8) 4294967259
>> [20565.099574] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805346088+8) 4294967260
>> [20565.099733] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805346088+8) 4294967261
>> [20565.099960] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805346088+8) 4294967262
>> [20609.002609] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805346088+8) 4294967261
>> [20609.011900] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805346088+8) 4294967260
>> [20609.021187] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805346088+8) 4294967259
>> [20612.483895] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805346088+8) 4294967260
>> [20612.484023] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805346088+8) 4294967261
>> [20612.484674] __add_stripe_bio: md127: start =
ff2721beec8c2fa0(805346088+8) 4294967262
>> [20641.495298] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805346088+8) 4294967261
>> [20641.504590] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805346088+8) 4294967260
>> [20641.513885] handle_stripe_clean_event: md127: end =
ff2721beec8c2fa0(805346088+8) 4294967259
>>=20
>> Liebe Gr=C3=BC=C3=9Fe,
>> Christian Theune
>>=20
>> --=20
>> Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
>> Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
>> Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
>> HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian =
Theune, Christian Zagrodnick
>>=20
>=20
> Liebe Gr=C3=BC=C3=9Fe,
> Christian Theune
>=20
> --=20
> Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
> Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
> Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
> HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian =
Theune, Christian Zagrodnick
>=20

Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


