Return-Path: <linux-raid+bounces-24-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 123AE7F6D94
	for <lists+linux-raid@lfdr.de>; Fri, 24 Nov 2023 09:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDADB21249
	for <lists+linux-raid@lfdr.de>; Fri, 24 Nov 2023 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65186B673;
	Fri, 24 Nov 2023 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF64236;
	Fri, 24 Nov 2023 00:00:23 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sc6pm0Jdkz4f3lVd;
	Fri, 24 Nov 2023 16:00:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 59E591A0B58;
	Fri, 24 Nov 2023 16:00:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDX2xERWGBlUnAqBw--.22901S7;
	Fri, 24 Nov 2023 16:00:20 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	yukuai3@huawei.com,
	xni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 3/6] md: remove redundant md_wakeup_thread()
Date: Fri, 24 Nov 2023 15:59:50 +0800
Message-Id: <20231124075953.1932764-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
References: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2xERWGBlUnAqBw--.22901S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW3GrW3KFy7Gw4fAF1fZwb_yoW8try7pa
	y8JF909rWUZa4ayFWDta4DXa45Zw1jqrWqyFW3u3yrJF1ftanxWFyY9F17J3yvya92ya1Y
	qa18GrW7Za4Igw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

In md_set_readonly() and do_md_stop(), md_wakeup_thread() will be called
while 'reconfig_mutex' is held, however, follow up mddev_unlock() will call
md_wakeup_thread() again. Hence remove the redundant md_wakeup_thread().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1d33a39d4f13..b4e21db71454 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6363,7 +6363,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
 	}
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
@@ -6390,7 +6389,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		if (did_freeze) {
 			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			md_wakeup_thread(mddev->thread);
 		}
 		err = -EBUSY;
 		goto out;
@@ -6405,7 +6403,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		set_disk_ro(mddev->gendisk, 1);
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
 		err = 0;
 	}
@@ -6428,7 +6425,6 @@ static int do_md_stop(struct mddev *mddev, int mode,
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
 	}
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
@@ -6453,7 +6449,6 @@ static int do_md_stop(struct mddev *mddev, int mode,
 		if (did_freeze) {
 			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			md_wakeup_thread(mddev->thread);
 		}
 		return -EBUSY;
 	}
-- 
2.39.2


