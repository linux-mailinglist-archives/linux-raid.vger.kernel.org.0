Return-Path: <linux-raid+bounces-2650-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9288961BEB
	for <lists+linux-raid@lfdr.de>; Wed, 28 Aug 2024 04:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218021C2336F
	for <lists+linux-raid@lfdr.de>; Wed, 28 Aug 2024 02:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9924779F;
	Wed, 28 Aug 2024 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dhu0lHvP"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4C199B9
	for <linux-raid@vger.kernel.org>; Wed, 28 Aug 2024 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811156; cv=none; b=CwvFSZ+DmF7tYilYiW6+MtkEocq1lfl1zbFdZcsKMsF2TZ8d6cu5EeBbO4oiqGgOIZJmmKr+90QkQhNunVkCS04inYIhBUid6iVY7r4OU+Nbm38f5Udf+f6a5W6ZaTS53uyA249LuXBY3nX+dpYsszgmicK5gdAnBhpZjqnP1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811156; c=relaxed/simple;
	bh=UVVjq7cWmRg0LfpYkoOu27ebo4uiZcLN/QzfrcMuRXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CRhHKIxNjnsHGMLb8YJ7kVpsZBioIMJxAp0zNmN7ZZAbaCqBMxFPvGEcIFygwAgK5TsbEfebzdsphXCC2KlOJtCGAk/w/iTuSAcR+7v6BLIU5+cc0ZSH5UcU6EjQ13JujI0k1cQHWywG/Mfkf4elxKirDVc6+9VQaLqNH7+5TZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dhu0lHvP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724811153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4eoPsAnFhicrDpf9RMhK41us47wLQZPSb94/GVUNvqk=;
	b=Dhu0lHvPTQLJb1Yf/sRQXE6xqubgWPI9Owh8SLzVOzVCOhaCdYMOyCGEHou2bM1VZayoGZ
	e/ZVxDMN7dPXbTnIFwf80yhzqSwbJzeT4R2wLqd4EqWVU+2r1ZnX3PRuwX4h+ZMYS4u0bp
	sk6uPj8TxLHHh7DlUhQz3QdPbCfKNu4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-p5q0Tg8qO-KOt5FOLjhlHQ-1; Tue,
 27 Aug 2024 22:12:32 -0400
X-MC-Unique: p5q0Tg8qO-KOt5FOLjhlHQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 666BA1955BE7;
	Wed, 28 Aug 2024 02:12:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C01E03001FF9;
	Wed, 28 Aug 2024 02:12:25 +0000 (UTC)
From: Xiao Ni <xni@redhat.com>
To: mariusz.tkaczyk@linux.intel.com
Cc: ncroxon@redhat.com,
	linux-raid@vger.kernel.org
Subject: [PATCH 04/10] mdadm/Grow: sleep a while after removing disk in impose_level
Date: Wed, 28 Aug 2024 10:11:44 +0800
Message-Id: <20240828021150.63240-5-xni@redhat.com>
In-Reply-To: <20240828021150.63240-1-xni@redhat.com>
References: <20240828021150.63240-1-xni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

It needs to remove disks when reshaping from raid456 to raid0. In
kernel space it sets MD_RECOVERY_RUNNING. And it will fail to change
level. So wait sometime to let md thread to clear this flag.

This is found by test case 05r6tor0.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 Grow.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Grow.c b/Grow.c
index 2a7587315817..aaf349e9722f 100644
--- a/Grow.c
+++ b/Grow.c
@@ -3028,6 +3028,12 @@ static int impose_level(int fd, int level, char *devname, int verbose)
 			      makedev(disk.major, disk.minor));
 			hot_remove_disk(fd, makedev(disk.major, disk.minor), 1);
 		}
+		/*
+		 * hot_remove_disk lets kernel set MD_RECOVERY_RUNNING
+		 * and it can't set level. It needs to wait sometime
+		 * to let md thread to clear the flag.
+		 */
+		sleep_for(5, 0, true);
 	}
 	c = map_num(pers, level);
 	if (c) {
-- 
2.32.0 (Apple Git-132)


