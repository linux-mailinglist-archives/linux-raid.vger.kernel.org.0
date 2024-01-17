Return-Path: <linux-raid+bounces-371-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71A830CAA
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jan 2024 19:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF37B23287
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jan 2024 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA2A22F0B;
	Wed, 17 Jan 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPKFXq5f"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070022EE4
	for <linux-raid@vger.kernel.org>; Wed, 17 Jan 2024 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515763; cv=none; b=DLi5ih7h7E5IKMen8MIgeTudBi/AX5tnrFiesJK0ZHz3ftU9UeIYTO+20g90Vx6XzOCFp73ItxUuZC76a+kZNDvVrcEtR5i3XMy9X9c9fLwZoZnc+gtCd1DZ3vB2kUAD/XH3U2IAyXZhes8n/p7xeWyg37HZ9PtLdqaMSpakxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515763; c=relaxed/simple;
	bh=V8R9j4TYEy4pGFHA0w+YlUVkrb0ecevYuEGI9WoaKco=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Received:
	 Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type:X-Scanned-By; b=M2a7rcImGsXzWEznfVEvaPQMWVAC4KVRyDSPeQDgq4W+Amo6kbYUWMQ3hrdYKCvVesM0IYpbgRM2rxzhecas5H+y4luXGTHorvyjvqutMoLB2iCatX5PUvPvDOE6JAavn4s1EQRXxF/xNsHNc85t03RAfWje3jx44D2RU42kI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPKFXq5f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705515761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z09U/kH5aTZB7jjyJSH8zHLRV8pSgNSa2hUWXWZNzSg=;
	b=WPKFXq5fnr89y2q8muWwd7HBgrBPlEy3F6p/qborZz+7ax80FiW7APSoiNwVwHf9r/9owf
	8W+w5Vo4cC1BRQQUcxg5twYnFiuI69x6N6Rb2FK/9tO+B5g40KbCsvVqp2mt9tEhbnhsFC
	4QnT7rvnVIQXATjBHW1vnCm/aH5vuvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-ng3Nu4FMNIS2uCOcjaNjhg-1; Wed, 17 Jan 2024 13:22:36 -0500
X-MC-Unique: ng3Nu4FMNIS2uCOcjaNjhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B94F85A58B;
	Wed, 17 Jan 2024 18:22:36 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 73FB13C27;
	Wed, 17 Jan 2024 18:22:36 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 6B74830C039C; Wed, 17 Jan 2024 18:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 6ABB53FB50;
	Wed, 17 Jan 2024 19:22:36 +0100 (CET)
Date: Wed, 17 Jan 2024 19:22:36 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>, 
    David Jeffery <djeffery@redhat.com>, Li Nan <linan122@huawei.com>
cc: dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
    Mike Snitzer <msnitzer@redhat.com>, Heinz Mauelshagen <heinzm@redhat.com>, 
    Benjamin Marzinski <bmarzins@redhat.com>
Subject: [PATCH 7/7] md: fix a suspicious RCU usage warning
In-Reply-To: <e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com>
Message-ID: <51539879-e1ca-fde3-b8b4-8934ddedcbc@redhat.com>
References: <e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

RCU protection was removed in the commit 2d32777d60de ("raid1: remove rcu
protection to access rdev from conf").

However, the code in fix_read_error does rcu_dereference outside
rcu_read_lock - this triggers the following warning. The warning is
triggered by a LVM2 test shell/integrity-caching.sh.

This commit removes rcu_dereference.

=============================
WARNING: suspicious RCU usage
6.7.0 #2 Not tainted
-----------------------------
drivers/md/raid1.c:2265 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
no locks held by mdX_raid1/1859.

stack backtrace:
CPU: 2 PID: 1859 Comm: mdX_raid1 Not tainted 6.7.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x60/0x70
 lockdep_rcu_suspicious+0x153/0x1b0
 raid1d+0x1732/0x1750 [raid1]
 ? lock_acquire+0x9f/0x270
 ? finish_wait+0x3d/0x80
 ? md_thread+0xf7/0x130 [md_mod]
 ? lock_release+0xaa/0x230
 ? md_register_thread+0xd0/0xd0 [md_mod]
 md_thread+0xa0/0x130 [md_mod]
 ? housekeeping_test_cpu+0x30/0x30
 kthread+0xdc/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x28/0x40
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: ca294b34aaf3 ("md/raid1: support read error check")

---
 drivers/md/raid1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/md/raid1.c
===================================================================
--- linux-2.6.orig/drivers/md/raid1.c
+++ linux-2.6/drivers/md/raid1.c
@@ -2262,7 +2262,7 @@ static void fix_read_error(struct r1conf
 	int sectors = r1_bio->sectors;
 	int read_disk = r1_bio->read_disk;
 	struct mddev *mddev = conf->mddev;
-	struct md_rdev *rdev = rcu_dereference(conf->mirrors[read_disk].rdev);
+	struct md_rdev *rdev = conf->mirrors[read_disk].rdev;
 
 	if (exceed_read_errors(mddev, rdev)) {
 		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;


