Return-Path: <linux-raid+bounces-4144-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91A1AB2CD0
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 03:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017CE3B77CC
	for <lists+linux-raid@lfdr.de>; Mon, 12 May 2025 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC6E1E5716;
	Mon, 12 May 2025 01:28:10 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573A1E2602;
	Mon, 12 May 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013290; cv=none; b=ZESAB3ACJB9l2CLhosjTDOLIReVvDifvjqix8FAKdnIEiE56YY/AtT5wrWTWYOBy8OdjCNVnRcx7lyL0+xtXA/BG4MiDq19TgC0c3euiPBUpCtp3X3kTE1nhVmUwbj2aRPagOXD6FWkmPtTL/72nXoB1kZPX6QvbBJbtauNHBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013290; c=relaxed/simple;
	bh=ZLnxyOFDhn3NNnhysj3ERHI4Uo95sKDUQ514ww9Ohd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mbaqteoIaZbchSMUKus/0rwLVA1qPU0CAUPafLPJk3PRZSLEm46Aaw8NEU2OayIzAgZMafHKxUSz7zMX2IxuyVHfxXZ/q+inXjh1Gi3jVL958A+FPdxwqrBjQuqx+lUQ7FhTVhW/qGi5X48D0XVB3qE2YQ3p8b0Af37E0s1otBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zwhmq1Dpyz4f3jXl;
	Mon, 12 May 2025 09:27:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D22431A0FD4;
	Mon, 12 May 2025 09:28:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2CdTiFoNFCWMA--.55093S7;
	Mon, 12 May 2025 09:28:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	xni@redhat.com,
	colyli@kernel.org,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com
Cc: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC md-6.16 v3 03/19] md/md-bitmap: remove parameter slot from bitmap_create()
Date: Mon, 12 May 2025 09:19:11 +0800
Message-Id: <20250512011927.2809400-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
References: <20250512011927.2809400-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2CdTiFoNFCWMA--.55093S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyrWFW8XF47KFW7XrW3GFg_yoW5XF48p3
	97tas3GrW3JrWaqw4UXFyv9a45Xwn2grZrtryxC34rWF1DZrnxCF4FgF1jywn8Ka4rAFs8
	Xw15Gw18GF1Igr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

All callers pass in '-1' for 'slot', hence it can be removed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 6 +++---
 drivers/md/md-bitmap.h | 2 +-
 drivers/md/md.c        | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 56a1430a398e..4c5067783b7a 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2183,9 +2183,9 @@ static struct bitmap *__bitmap_create(struct mddev *mddev, int slot)
 	return ERR_PTR(err);
 }
 
-static int bitmap_create(struct mddev *mddev, int slot)
+static int bitmap_create(struct mddev *mddev)
 {
-	struct bitmap *bitmap = __bitmap_create(mddev, slot);
+	struct bitmap *bitmap = __bitmap_create(mddev, -1);
 
 	if (IS_ERR(bitmap))
 		return PTR_ERR(bitmap);
@@ -2647,7 +2647,7 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 			}
 
 			mddev->bitmap_info.offset = offset;
-			rv = bitmap_create(mddev, -1);
+			rv = bitmap_create(mddev);
 			if (rv)
 				goto out;
 
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index c3fc051c88e9..41d09c6d0c14 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -74,7 +74,7 @@ struct bitmap_operations {
 	struct md_submodule_head head;
 
 	bool (*enabled)(void *data);
-	int (*create)(struct mddev *mddev, int slot);
+	int (*create)(struct mddev *mddev);
 	int (*resize)(struct mddev *mddev, sector_t blocks, int chunksize);
 
 	int (*load)(struct mddev *mddev);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index c72c13ed4253..dc2b2b274677 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6255,7 +6255,7 @@ int md_run(struct mddev *mddev)
 	}
 	if (err == 0 && pers->sync_request && md_bitmap_registered(mddev) &&
 	    (mddev->bitmap_info.file || mddev->bitmap_info.offset)) {
-		err = mddev->bitmap_ops->create(mddev, -1);
+		err = mddev->bitmap_ops->create(mddev);
 		if (err)
 			pr_warn("%s: failed to create bitmap (%d)\n",
 				mdname(mddev), err);
@@ -7324,7 +7324,7 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
 	err = 0;
 	if (mddev->pers) {
 		if (fd >= 0) {
-			err = mddev->bitmap_ops->create(mddev, -1);
+			err = mddev->bitmap_ops->create(mddev);
 			if (!err)
 				err = mddev->bitmap_ops->load(mddev);
 
@@ -7648,7 +7648,7 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 				mddev->bitmap_info.default_offset;
 			mddev->bitmap_info.space =
 				mddev->bitmap_info.default_space;
-			rv = mddev->bitmap_ops->create(mddev, -1);
+			rv = mddev->bitmap_ops->create(mddev);
 			if (!rv)
 				rv = mddev->bitmap_ops->load(mddev);
 
-- 
2.39.2


