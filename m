Return-Path: <linux-raid+bounces-2225-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54393762F
	for <lists+linux-raid@lfdr.de>; Fri, 19 Jul 2024 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2764D1F25A00
	for <lists+linux-raid@lfdr.de>; Fri, 19 Jul 2024 09:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE03824BC;
	Fri, 19 Jul 2024 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0DbFwvZ"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71181AB4
	for <linux-raid@vger.kernel.org>; Fri, 19 Jul 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382784; cv=none; b=ICL8AqK7ZSv7Cm/8RwtW/KH8++z0GjrnAC6aflxuftnBpnEbGQkBiH4JWSEd0DEVC9bXK7bm8YmbIIdq4FFzEKdq9jBpb5R5HWYJNYrDbud0Db0HgpzoiFxlE1yIENRgXr6Vc16cYkcEKElcQqk6c8aLepAG9B6xMbM5H5gcIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382784; c=relaxed/simple;
	bh=bqrwB/sA9RK56qlPkvEtaRYJEnsR7pC1Cij4hys6GPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a99wclrgulkYrsO2jBr1nzJazETsTEloPfx6S1Mtz5I/DEbm2Gfyx72bDYG8JN0VFCr51fNskFI1PgvzgAjJ+QGgasWup+8R3VdOKrLV13ymDYFC054BvRBp/+L8lBi0r4xC+z0o/rQW68jDwuuop5HnKcZzYzsSVL913BGl9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0DbFwvZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721382782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRbnfbyBnYpL5Ar6d25/80oA4sRvUCed9nFsMVGOhPI=;
	b=Z0DbFwvZ07GQRw/7ldf7xunnqU9JGoHlM6MMu+JY7zQY1qLeLRPezauyU9z3cqUU2iPg5x
	Kb19iclALJBxhiNHhJs7KXz7G1Fr0ewATmOCRCpDmQHVvjTL3ZfQCPAs3zuGVxVKaJEifb
	Vxtcie3d7TtS9sAiwZ7eVuUxWv4r3EE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-T08Pxw5nO8GTp4jSafWpOA-1; Fri,
 19 Jul 2024 05:52:58 -0400
X-MC-Unique: T08Pxw5nO8GTp4jSafWpOA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B969C1956088;
	Fri, 19 Jul 2024 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27F8219560B2;
	Fri, 19 Jul 2024 09:52:54 +0000 (UTC)
From: Xiao Ni <xni@redhat.com>
To: mariusz.tkaczyk@linux.intel.com
Cc: ncroxon@redhat.com,
	linux-raid@vger.kernel.org
Subject: [PATCH 09/14] mdadm/mdstat: fix coverity issue CHECKED_RETURN
Date: Fri, 19 Jul 2024 17:52:14 +0800
Message-Id: <20240719095219.9705-10-xni@redhat.com>
In-Reply-To: <20240719095219.9705-1-xni@redhat.com>
References: <20240719095219.9705-1-xni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 mdstat.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mdstat.c b/mdstat.c
index e233f094..930d59ee 100644
--- a/mdstat.c
+++ b/mdstat.c
@@ -146,8 +146,11 @@ struct mdstat_ent *mdstat_read(int hold, int start)
 		f = fopen("/proc/mdstat", "r");
 	if (f == NULL)
 		return NULL;
-	else
-		fcntl(fileno(f), F_SETFD, FD_CLOEXEC);
+
+	if (fcntl(fileno(f), F_SETFD, FD_CLOEXEC) < 0) {
+		fclose(f);
+		return NULL;
+	}
 
 	all = NULL;
 	end = &all;
@@ -281,7 +284,10 @@ struct mdstat_ent *mdstat_read(int hold, int start)
 	}
 	if (hold && mdstat_fd == -1) {
 		mdstat_fd = dup(fileno(f));
-		fcntl(mdstat_fd, F_SETFD, FD_CLOEXEC);
+		if (fcntl(mdstat_fd, F_SETFD, FD_CLOEXEC) < 0) {
+			fclose(f);
+			return NULL;
+		}
 	}
 	fclose(f);
 
-- 
2.41.0


