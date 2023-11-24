Return-Path: <linux-raid+bounces-25-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232357F6D95
	for <lists+linux-raid@lfdr.de>; Fri, 24 Nov 2023 09:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C367C1F20F1C
	for <lists+linux-raid@lfdr.de>; Fri, 24 Nov 2023 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86049944F;
	Fri, 24 Nov 2023 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810CB423C;
	Fri, 24 Nov 2023 00:00:23 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sc6pp6yxDz4f3mJM;
	Fri, 24 Nov 2023 16:00:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B2C711A0352;
	Fri, 24 Nov 2023 16:00:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDX2xERWGBlUnAqBw--.22901S8;
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
Subject: [PATCH v2 4/6] md: don't leave 'MD_RECOVERY_FROZEN' in error path of md_set_readonly()
Date: Fri, 24 Nov 2023 15:59:51 +0800
Message-Id: <20231124075953.1932764-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDX2xERWGBlUnAqBw--.22901S8
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWfWF17Jry8CF13Xr1kXwb_yoW8Kr4rp3
	yftF98CryUJry3Zr4Dta4DXa45Zw12q3yqyFy3u3s5JF1ftrsxCFyrW34xJrWkKas2v3W5
	Xw48JrW7u342g3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

If md_set_readonly() failed, the array could still be read-write, however
'MD_RECOVERY_FROZEN' could still be set, which leave the array in an
abnormal state that sync or recovery can't continue anymore.
Hence make sure the flag is cleared after md_set_readonly() returns.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index b4e21db71454..5af67748e53e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6360,6 +6360,9 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	int err = 0;
 	int did_freeze = 0;
 
+	if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
+		return -EBUSY;
+
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
@@ -6373,8 +6376,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	 */
 	md_wakeup_thread_directly(mddev->sync_thread);
 
-	if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
-		return -EBUSY;
 	mddev_unlock(mddev);
 	wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
 					  &mddev->recovery));
@@ -6386,27 +6387,29 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
-		if (did_freeze) {
-			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		}
 		err = -EBUSY;
 		goto out;
 	}
+
 	if (mddev->pers) {
 		__md_stop_writes(mddev);
 
-		err  = -ENXIO;
-		if (mddev->ro == MD_RDONLY)
+		if (mddev->ro == MD_RDONLY) {
+			err  = -ENXIO;
 			goto out;
+		}
+
 		mddev->ro = MD_RDONLY;
 		set_disk_ro(mddev->gendisk, 1);
+	}
+
+out:
+	if ((mddev->pers && !err) || did_freeze) {
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
-		err = 0;
 	}
-out:
+
 	mutex_unlock(&mddev->open_mutex);
 	return err;
 }
-- 
2.39.2


