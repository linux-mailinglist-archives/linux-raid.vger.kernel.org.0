Return-Path: <linux-raid+bounces-1050-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC086E434
	for <lists+linux-raid@lfdr.de>; Fri,  1 Mar 2024 16:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB9DB231EC
	for <lists+linux-raid@lfdr.de>; Fri,  1 Mar 2024 15:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9136F07D;
	Fri,  1 Mar 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxxANqKq"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22AB6F076
	for <linux-raid@vger.kernel.org>; Fri,  1 Mar 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306509; cv=none; b=St35PjY9uQnhl5FLA+XDb/1OLO5uSpIE1AR4Jwpppt16z3w6nbVGxkQy+QdyhBi9a5c25xyYZT+n/tKHDFVZeb9g6E6/JLmnK8yI3b9OTnqxjc45IPgn/8vp5VKfR11qBDqI/6wo7p64SaizoeKejYGUyisTDVPSOY9M8KBFjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306509; c=relaxed/simple;
	bh=m+V8CUAm6L5FgD/lMv6u/nUWgVgY7CFIGYZOhIAc10Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrAOQaJslonNgo74FpFPgJiU56z3K1f0FVEv1uondU5oCA+POijgsfxwyNQxfM1N0Oaoz0J126ODRDgGn4CsWkGpGnQs+W+J2Yjw3XXCnKG+nmR64XNRufanXdcuuCrRTBAEk+g/2oiPpQp6g6XCxLA7IQnFH/ZMCc40nm7Z5Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxxANqKq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709306506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcNNQUkDZViYg7vPWVV3aHpQjklVij2EKy0H2bDFA5k=;
	b=QxxANqKqN1TbaZT3QAB2lS3TyWq1VvPlUIxs7tdNb9iULQK9OffY2eesP08fM5xsxsPkYD
	0GHe2piYERYMcetc8qGuTqZiqZSFQ8BQ5ykFoE/cZDoczuQ6yyMyA8rcwy+usxcPNZzsTS
	ghpuGbCxeIxJiY/xPTQxmHGnF0y/FFA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-QRoIEdzzN4OmGDn8T89klQ-1; Fri,
 01 Mar 2024 10:21:42 -0500
X-MC-Unique: QRoIEdzzN4OmGDn8T89klQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D7EB1C05B05;
	Fri,  1 Mar 2024 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C45E21121312;
	Fri,  1 Mar 2024 15:21:38 +0000 (UTC)
From: Xiao Ni <xni@redhat.com>
To: song@kernel.org
Cc: yukuai1@huaweicloud.com,
	bmarzins@redhat.com,
	heinzm@redhat.com,
	snitzer@kernel.org,
	ncroxon@redhat.com,
	linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: [PATCH 2/4] md: Revert "md: Don't ignore suspended array in md_check_recovery()"
Date: Fri,  1 Mar 2024 23:21:26 +0800
Message-Id: <20240301152128.13465-3-xni@redhat.com>
In-Reply-To: <20240301152128.13465-1-xni@redhat.com>
References: <20240301152128.13465-1-xni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This reverts commit 1baae052cccd08daf9a9d64c3f959d8cdb689757.

For dmraid, it doesn't allow any io including sync io when array is
suspended. Although it's a simple change in this patch, it still needs
more work to support it. Now we're trying to fix regression problems.
So let's keep as small changes as we can. We can rethink about this
in future.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index db4743ba7f6c..c4624814d94c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9496,6 +9496,9 @@ static void unregister_sync_thread(struct mddev *mddev)
  */
 void md_check_recovery(struct mddev *mddev)
 {
+	if (READ_ONCE(mddev->suspended))
+		return;
+
 	if (mddev->bitmap)
 		md_bitmap_daemon_work(mddev);
 
-- 
2.32.0 (Apple Git-132)


