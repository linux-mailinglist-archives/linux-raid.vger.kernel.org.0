Return-Path: <linux-raid+bounces-755-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5D985BFF6
	for <lists+linux-raid@lfdr.de>; Tue, 20 Feb 2024 16:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B88B1F245A4
	for <lists+linux-raid@lfdr.de>; Tue, 20 Feb 2024 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A56762C6;
	Tue, 20 Feb 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkgQPBi+"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDDD762C7
	for <linux-raid@vger.kernel.org>; Tue, 20 Feb 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443083; cv=none; b=iOCeJvZBQsI+qRWc17KlcXH0l854u3Ct5X3kzdpqY/p9hAEP1JqjhU2s+jjyGxP7LvptFrBFgVJklcVXTz8XqMdTlOFZaUtvkLcib9hQJisGmg8NL1BjTWY7dUm61PhTEO6FNVFjJ+YO7OcEnolZVfpiVmduuI04IaqqF1dvimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443083; c=relaxed/simple;
	bh=oSgRYGTEf/dulFhIkSuOVRWdtR0hwQ2/A/X0d3W4ilk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdgj0HO9SfH02Rwgrh+0wfPtDAc58yQ6k4lIRLYBAzNYa8fsub7vbXS0Q5IwiPO6zSP6P2JtZOi/PF+XEaQBQ41Obj5deMGOWPm2D5y24Khiivw80E5NFYcKDS2pgHBivS9MQtcnSbZETFeVVaslyTxST0RXEEPBnzF9Zj8g8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkgQPBi+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708443081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiRXDnsLJGZiZ2myApdsnHktPfLZueKk1fT0FIW8PV0=;
	b=UkgQPBi+neI+xA/5gFy1AwPczQ6IqzM1mSUDVSJwCbPZP0Nb18u4zIfUC+fMwQ9DpT2P6P
	SGbaOGudpOMuMqwYxc3fUWtXH8JVhhg0rDX8rHjw4CD4caoSpdawIckj+vxrN53E9hkpCc
	Sxn985wAaeh33/BXASxIs8swLPf7T1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-pNuu2t83Olqs_QRSf56vZw-1; Tue, 20 Feb 2024 10:31:19 -0500
X-MC-Unique: pNuu2t83Olqs_QRSf56vZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BEFB84F9D1;
	Tue, 20 Feb 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A10CC20229A4;
	Tue, 20 Feb 2024 15:31:14 +0000 (UTC)
From: Xiao Ni <xni@redhat.com>
To: song@kernel.org
Cc: yukuai1@huaweicloud.com,
	bmarzins@redhat.com,
	heinzm@redhat.com,
	snitzer@kernel.org,
	ncroxon@redhat.com,
	neilb@suse.de,
	linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: [PATCH RFC 3/4] md: Missing decrease active_io for flush io
Date: Tue, 20 Feb 2024 23:30:58 +0800
Message-Id: <20240220153059.11233-4-xni@redhat.com>
In-Reply-To: <20240220153059.11233-1-xni@redhat.com>
References: <20240220153059.11233-1-xni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

If all flush bios finish fast, it doesn't decrease active_io. And it will
stuck when stopping array.

This can be reproduced by lvm2 test shell/integrity-caching.sh.
But it can't reproduce 100%.

Fixes: fa2bbff7b0b4 ("md: synchronize flush io with array reconfiguration")
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 77e3af7cf6bb..a41bed286fd2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -579,8 +579,12 @@ static void submit_flushes(struct work_struct *ws)
 			rcu_read_lock();
 		}
 	rcu_read_unlock();
-	if (atomic_dec_and_test(&mddev->flush_pending))
+	if (atomic_dec_and_test(&mddev->flush_pending)) {
+		/* The pair is percpu_ref_get() from md_flush_request() */
+		percpu_ref_put(&mddev->active_io);
+
 		queue_work(md_wq, &mddev->flush_work);
+	}
 }
 
 static void md_submit_flush_data(struct work_struct *ws)
-- 
2.32.0 (Apple Git-132)


