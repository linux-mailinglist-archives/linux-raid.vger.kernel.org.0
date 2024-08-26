Return-Path: <linux-raid+bounces-2573-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7A695EACE
	for <lists+linux-raid@lfdr.de>; Mon, 26 Aug 2024 09:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF55528250F
	for <lists+linux-raid@lfdr.de>; Mon, 26 Aug 2024 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E8313BAE4;
	Mon, 26 Aug 2024 07:49:55 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCA12E1EE;
	Mon, 26 Aug 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658594; cv=none; b=LSB8jQzm2SpA156BE5suaidJeBJ7H7npVuGxYpbNrnFbWiT5Cm/sxoYB+LgNfWyGtZ2Ka/Lg57S32EmMeO1Z3LtA5XO4s8+ePmhdJ4d+AkwKG01WXXASpl6BepcGKLJ3FK6BtCkbQVzp7PXl7vnyBbC1JZI3MFxcBZuM+b2cIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658594; c=relaxed/simple;
	bh=AlnCRfuMKu6QMNGIldmtj055RY4KSn6MUQwndsDBMOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faw5VOe1TNWD+X7bPzkz9KRP3KBpH3GVwak5uLdj0L6iLyVPpXR6laFXinOftwplcCE1C3SfxxKkAz/BJDeJMT8fauLZBPfz7xqcJLuMcGBDV4PebGxiOz+ckmJYVBoYS0+HfNXFwOmDkMqA+M+gfvRDIV0LW5TFRqKsYNWRvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WsjW76ZwMz4f3jk3;
	Mon, 26 Aug 2024 15:49:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C3CAE1A174B;
	Mon, 26 Aug 2024 15:49:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4WaM8xmWWIECw--.13849S7;
	Mon, 26 Aug 2024 15:49:49 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mariusz.tkaczyk@linux.intel.com,
	xni@redhat.com,
	song@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.12 v2 03/42] md: use new helper md_bitmap_get_stats() in update_array_info()
Date: Mon, 26 Aug 2024 15:44:13 +0800
Message-Id: <20240826074452.1490072-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826074452.1490072-1-yukuai1@huaweicloud.com>
References: <20240826074452.1490072-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4WaM8xmWWIECw--.13849S7
X-Coremail-Antispam: 1UD129KBjvdXoWruFWUuF4xKryfKw47Cry7GFg_yoWDJFcEgF
	4vk348GrW5GryrtFnxZw4avryYyayDW3WkXF47K34xAF1UJa4fGrs5uwn8tr1xXFW7Ar9I
	yryUJw4Svrn5AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb68FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43Mx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, avoid dereferencing bitmap directly to
prepare inventing a new bitmap.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index b52d0cc773ae..92e7f05e6bc1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7577,15 +7577,17 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 			if (rv)
 				md_bitmap_destroy(mddev);
 		} else {
-			/* remove the bitmap */
-			if (!mddev->bitmap) {
-				rv = -ENOENT;
+			struct md_bitmap_stats stats;
+
+			rv = md_bitmap_get_stats(mddev->bitmap, &stats);
+			if (rv)
 				goto err;
-			}
-			if (mddev->bitmap->storage.file) {
+
+			if (stats.file) {
 				rv = -EINVAL;
 				goto err;
 			}
+
 			if (mddev->bitmap_info.nodes) {
 				/* hold PW on all the bitmap lock */
 				if (md_cluster_ops->lock_all_bitmaps(mddev) <= 0) {
-- 
2.39.2


