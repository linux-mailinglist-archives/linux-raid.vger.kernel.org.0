Return-Path: <linux-raid+bounces-2244-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789C6938B04
	for <lists+linux-raid@lfdr.de>; Mon, 22 Jul 2024 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA19B1C21242
	for <lists+linux-raid@lfdr.de>; Mon, 22 Jul 2024 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB01E161328;
	Mon, 22 Jul 2024 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqhGA8MK"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108E4204F
	for <linux-raid@vger.kernel.org>; Mon, 22 Jul 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636295; cv=none; b=md1oQ0uXLDiP0F0zVay+T0mZPXHavKonnWaAFicgpgmoIxO6Kqu4k9mkBajuioBN1HzRnMifQw8b4QXxY1mbQ2k3zlDiXtsqfJ3H53rOzqJLDilZpUnVmuw2nZS5W1Ova6SP+YrRlpRbQqCRMrzcyRZRncOQBym5RrOOK9BYCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636295; c=relaxed/simple;
	bh=nyQb8sSls3t9h1bjfoCHwqKY+xs2YTimd4XfC+3a4zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cv4XRUnhWB/ActV20BA9/13bh0DvW3FRz4hKayzsBingwT6KdD0/DFSH1dEv6geuo0BLb1Wzf06dAHx8XETuEAoOrkPwo9xJNTa5QFwPROREt7wg6Y/78ONsN5eIEHJ4LFCfnbKnEXNHVszstjqI5aTV8Q+pFfhHvvoL5xwwKsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqhGA8MK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721636292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ2i4vtQrConEVfiH/q51wUDvEeO64dNaRgUf3S1ldA=;
	b=XqhGA8MK4ZXhIHLJdLQEPvP7i0G7MKt9JC5u10vHPdHrf5d1nB0Zelp1LbN82Hr9lvDf5U
	Cgt8TjOcbuYQJR+2wAk23gLAiVkuecOqGao2W5O9xhskMBvj6F0p0PqGZRGm5jhMP1CZi+
	pqBqLOzoLpc263y0gBA1uPRyE2djNoM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-HD5rotsdNSC0D_MlAbQkvg-1; Mon,
 22 Jul 2024 04:18:05 -0400
X-MC-Unique: HD5rotsdNSC0D_MlAbQkvg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8AA21955D42;
	Mon, 22 Jul 2024 08:18:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 311461955D45;
	Mon, 22 Jul 2024 08:18:01 +0000 (UTC)
From: Xiao Ni <xni@redhat.com>
To: mariusz.tkaczyk@linux.intel.com
Cc: ncroxon@redhat.com,
	linux-raid@vger.kernel.org
Subject: [PATCH 06/14] mdadm/mdmon: fix coverity issue RESOURCE_LEAK
Date: Mon, 22 Jul 2024 16:17:28 +0800
Message-Id: <20240722081736.20439-7-xni@redhat.com>
In-Reply-To: <20240722081736.20439-1-xni@redhat.com>
References: <20240722081736.20439-1-xni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Fix resource leak problem in mdmon.c

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 mdmon.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mdmon.c b/mdmon.c
index b6fe302e..a498c9bd 100644
--- a/mdmon.c
+++ b/mdmon.c
@@ -455,22 +455,25 @@ static int mdmon(char *devnm, int must_fork, int takeover)
 	if (must_fork) {
 		if (pipe(pfd) != 0) {
 			pr_err("failed to create pipe\n");
+			close_fd(&mdfd);
 			return 1;
 		}
 		switch(fork()) {
 		case -1:
 			pr_err("failed to fork: %s\n", strerror(errno));
+			close_fd(&mdfd);
 			return 1;
 		case 0: /* child */
-			close(pfd[0]);
+			close_fd(&pfd[0]);
 			break;
 		default: /* parent */
-			close(pfd[1]);
+			close_fd(&pfd[1]);
 			if (read(pfd[0], &status, sizeof(status)) != sizeof(status)) {
 				wait(&status);
 				status = WEXITSTATUS(status);
 			}
-			close(pfd[0]);
+			close_fd(&pfd[0]);
+			close_fd(&mdfd);
 			return status;
 		}
 	} else
-- 
2.41.0


