Return-Path: <linux-raid+bounces-729-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 751DC859C09
	for <lists+linux-raid@lfdr.de>; Mon, 19 Feb 2024 07:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16028B216EE
	for <lists+linux-raid@lfdr.de>; Mon, 19 Feb 2024 06:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D79200AC;
	Mon, 19 Feb 2024 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZ1Joxkw"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A173200B7
	for <linux-raid@vger.kernel.org>; Mon, 19 Feb 2024 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324011; cv=none; b=qedBJ6zfvRR9ELasCSKG4TAgdX7LuRVDw9lk5IF/1Zd3Z9yrvRXtihzHTA7lqMqKAusfwBmEQkblMNBoB7T75jOr6ZZ7UuPaahvHT55DqcRA/atuhv9oOnBnBTNn2+9OLuYOkPaMk+lZ/lsVh3JnShdpzFPEOIETtlgQVBrIB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324011; c=relaxed/simple;
	bh=oSgRYGTEf/dulFhIkSuOVRWdtR0hwQ2/A/X0d3W4ilk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lij6JR36bUglw5QlRfLiiXz7IhLD4ta0kjM5U4N/YatcF/mfrmSarPpWry/NqQvEcpcJysxyUpAGJzJe29d4xTDtTTsc55HbbWc5usYWDHb0juotd4g8IvSm5R16N2dcWt7YLPTQ8Wt7BHnIgCxFHzlO/2VcQoPkKb7qYiJDws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZ1Joxkw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708324008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiRXDnsLJGZiZ2myApdsnHktPfLZueKk1fT0FIW8PV0=;
	b=ZZ1JoxkwDMLFCWqR8bSOB/s/mKVr9ppcDGfty1Bj2ZYrBgxQyyhI8DqVLv9cbYfeazrZuG
	bNZtkqW7nEQ9V0zTQlsyIX7WuUNCqWEJg/tK/85mPU7WuNu9wI3naJuRZrFj147jGG15tE
	g+NB02TehPwj86iXoTwzpd8s2dj9MII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-eNBJgSPyPyKwNWhGaj5YUg-1; Mon, 19 Feb 2024 01:26:44 -0500
X-MC-Unique: eNBJgSPyPyKwNWhGaj5YUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2D5D85A58E;
	Mon, 19 Feb 2024 06:26:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BBEB48B;
	Mon, 19 Feb 2024 06:26:39 +0000 (UTC)
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
Subject: [PATCH RFC 3/3] md: Missing decrease active_io for flush io
Date: Mon, 19 Feb 2024 14:26:21 +0800
Message-Id: <20240219062621.92960-4-xni@redhat.com>
In-Reply-To: <20240219062621.92960-1-xni@redhat.com>
References: <20240219062621.92960-1-xni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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


