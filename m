Return-Path: <linux-raid+bounces-366-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB382830C97
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jan 2024 19:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17231C21AA9
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jan 2024 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AB22F08;
	Wed, 17 Jan 2024 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDHoOB6Y"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B4222EFF
	for <linux-raid@vger.kernel.org>; Wed, 17 Jan 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515533; cv=none; b=LGOHr2mmRvH62ocaVRduf+BlTgRc/Pm4i1QGLwreJlAVChKWfMpQIwZq7ValsVGyeAHqTsolHy+0+uCY3rijstAFMPTsu5d4kauT1eqszP4uPXqi44VtZtx8jen+MBj330XLL+AOq3T7k+1+wrY+YBocTNGYEHrnL17yz17pPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515533; c=relaxed/simple;
	bh=U/HOsuSALESYByEZMxsqkpAadSe0Ph12ksQGc6g63Dw=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Received:
	 Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type:X-Scanned-By; b=BbQLzic3IrRaRxhQpcSk1uCgghabBJOmrPZZ7VEAbXuX+RWH0W/Q+Mm9IQsfRmi2OUpzmMXr8GvpTD/wqVTmNpQ4m7sFUtG5VMKNue3cZRwldCC69oxB7Ggzq5ayY+GuoQL5rbUfsOID+Nmrzq7x4by2cyDz1il9izlE1nPOpKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDHoOB6Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705515531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nfo38sqj/Duul0x+61EoOlWpjTj/qTa2XQS7wYE8wfg=;
	b=dDHoOB6YfhsNjedjHYYGPplqW4tkQ04jqjeb1x47GEZmLyGaTndmzn8e4lJTl1IL8KZyWj
	HFa14wdJujuSRsU5yLYdDihT3mdgak/Fd+4i9SPmj0xY46iG+QNhHQAsjWKGAf0sLT4lv6
	qcUizFzb4WGGBEziKv1F3qIuKKIBB3g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-JiZ-FnulNk-PA-LnLmzq5A-1; Wed,
 17 Jan 2024 13:18:48 -0500
X-MC-Unique: JiZ-FnulNk-PA-LnLmzq5A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F6313830090;
	Wed, 17 Jan 2024 18:18:47 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 926BF492BE6;
	Wed, 17 Jan 2024 18:18:47 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 8A7DF30C039C; Wed, 17 Jan 2024 18:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 89C883FB50;
	Wed, 17 Jan 2024 19:18:47 +0100 (CET)
Date: Wed, 17 Jan 2024 19:18:47 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>, 
    David Jeffery <djeffery@redhat.com>, Li Nan <linan122@huawei.com>
cc: dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
    Mike Snitzer <msnitzer@redhat.com>, Heinz Mauelshagen <heinzm@redhat.com>, 
    Benjamin Marzinski <bmarzins@redhat.com>
Subject: [PATCH 2/7] md: fix a race condition when stopping the sync thread
In-Reply-To: <e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com>
Message-ID: <8fb335e-6d2c-dbb5-d7-ded8db5145a@redhat.com>
References: <e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Note that md_wakeup_thread_directly is racy - it will do nothing if the
thread is already running or it may cause spurious wake-up if the thread
is blocked in another subsystem.

In order to eliminate the race condition, we will retry
md_wakeup_thread_directly after 0.1 seconds.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# v6.7
Fixes: 130443d60b1b ("md: refactor idle/frozen_sync_thread() to fix deadlock")

---
 drivers/md/md.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/md/md.c
===================================================================
--- linux-2.6.orig/drivers/md/md.c
+++ linux-2.6/drivers/md/md.c
@@ -4889,6 +4889,7 @@ static void stop_sync_thread(struct mdde
 
 	mddev_unlock(mddev);
 
+retry:
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 	/*
 	 * Thread might be blocked waiting for metadata update which will now
@@ -4898,9 +4899,11 @@ static void stop_sync_thread(struct mdde
 	if (work_pending(&mddev->sync_work))
 		flush_work(&mddev->sync_work);
 
-	wait_event(resync_wait,
+	if (!wait_event_timeout(resync_wait,
 		   !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
-		   (check_seq && sync_seq != atomic_read(&mddev->sync_seq)));
+		   (check_seq && sync_seq != atomic_read(&mddev->sync_seq)),
+		   HZ / 10))
+		goto retry;
 
 	if (locked)
 		mddev_lock_nointr(mddev);


