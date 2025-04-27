Return-Path: <linux-raid+bounces-4056-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E4BA9E104
	for <lists+linux-raid@lfdr.de>; Sun, 27 Apr 2025 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C561A82AD7
	for <lists+linux-raid@lfdr.de>; Sun, 27 Apr 2025 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F3252907;
	Sun, 27 Apr 2025 08:37:17 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE7424EAB2;
	Sun, 27 Apr 2025 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745743037; cv=none; b=YLimWMZELOJVlJFk4toR4qQYwyVEgkhiJU9D3e7nO8IsIOSZklX3lUVxtmd9Prsj5rAGBfCbJSFMTa4/a9sIUJu93N6DK2anFAf6IZCkbGx2yxtDTg3x1xzF7Tl7I8C/sqRnDJ0DL9bbLwLUpblUA7an66DeeSAAKJXt0kM8/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745743037; c=relaxed/simple;
	bh=wO9Y0wqHdeWfdHbfJPLlykXM5N1LOb5pjmWpm6HDKfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MTEZCY/gJdMtMyvlybdLoWFVX4BTzdb9tnY5Elss+mf/Y90XYpwEquH/1ZZnLci9PVZ4wl0XfSmAMMu0riw642GLw3jekJlL86FPTkjiXi7GKo5FDlQivxZspn5/Wuj5LqzuN4fRI/7XiOLBRhpPDGRDubSXa7XIdPOxTwLENnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zlg0v6Slfz4f3jd1;
	Sun, 27 Apr 2025 16:36:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 056D21A018D;
	Sun, 27 Apr 2025 16:37:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDHGsWx7A1oOv4xKg--.7274S10;
	Sun, 27 Apr 2025 16:37:11 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	axboe@kernel.dk,
	xni@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com,
	cl@linux.com,
	nadav.amit@gmail.com,
	ubizjak@gmail.com,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 6/9] md: record dm-raid gendisk in mddev
Date: Sun, 27 Apr 2025 16:29:25 +0800
Message-Id: <20250427082928.131295-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250427082928.131295-1-yukuai1@huaweicloud.com>
References: <20250427082928.131295-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHGsWx7A1oOv4xKg--.7274S10
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8Gw4xtF1kGF4rCr1ftFb_yoW8WF4fpa
	1DC3yrArW5J39Fq3WDJr4DZa45X3WvqryrKFZxCaySvayavF98Ww1kKF42qr4DGrZIgFnx
	ur4jvrZ5Kry0yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Following patch will use gendisk to check if there are normal IO
completed or inflight, to fix a problem in mdraid that foreground IO
can be starved by background sync IO in later patches.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/dm-raid.c | 3 +++
 drivers/md/md.h      | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 6adc55fd90d3..127138c61be5 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -14,6 +14,7 @@
 #include "raid5.h"
 #include "raid10.h"
 #include "md-bitmap.h"
+#include "dm-core.h"
 
 #include <linux/device-mapper.h>
 
@@ -3308,6 +3309,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	/* Disable/enable discard support on raid set. */
 	configure_discard_support(rs);
+	rs->md.dm_gendisk = ti->table->md->disk;
 
 	mddev_unlock(&rs->md);
 	return 0;
@@ -3327,6 +3329,7 @@ static void raid_dtr(struct dm_target *ti)
 
 	mddev_lock_nointr(&rs->md);
 	md_stop(&rs->md);
+	rs->md.dm_gendisk = NULL;
 	mddev_unlock(&rs->md);
 
 	if (work_pending(&rs->md.event_work))
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 1cf00a04bcdd..9d55b4630077 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -404,7 +404,8 @@ struct mddev {
 						       * are happening, so run/
 						       * takeover/stop are not safe
 						       */
-	struct gendisk			*gendisk;
+	struct gendisk			*gendisk;    /* mdraid gendisk */
+	struct gendisk			*dm_gendisk; /* dm-raid gendisk */
 
 	struct kobject			kobj;
 	int				hold_active;
-- 
2.39.2


