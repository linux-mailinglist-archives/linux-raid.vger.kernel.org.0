Return-Path: <linux-raid+bounces-5290-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76594B52A3F
	for <lists+linux-raid@lfdr.de>; Thu, 11 Sep 2025 09:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269DA7B7E4D
	for <lists+linux-raid@lfdr.de>; Thu, 11 Sep 2025 07:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7242F2773FA;
	Thu, 11 Sep 2025 07:41:20 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721C27703D;
	Thu, 11 Sep 2025 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576480; cv=none; b=M70eJBGiz9MubSpKTHuQHuU1IM9KK8al0sZLUb23UVX+DCWuzaBy7N+WdUUCeQwJ8tzoZH6j1fzhvmziI41LsZMI3G2H7wUXa0WZhBTiy3RSG479doNOIYkFgEM5hX36j9dyS8SMIAnPLZnxhIzUUArSrFH4tuYouRo0XfstsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576480; c=relaxed/simple;
	bh=GFT3xJ+Fkz80bqhMX6JXYUEgjypR4BJKo9su5SlKML8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDPy77/ye+6ORnTPSNrO33fIEb+wsJMNXKdbycvT6p9KaFuwkM61NMoXEEgI+TFw/EMFljCCkWJaQI8uLtgdxrrX/8Ee99SxgH2V8gjPa66PUDs6piyLF8ijscw+kwSrfxmvHZ9k7cxLMmmio+1aTPkhPSiRR6sUZSWjpIAbU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cMqHZ2j4yzKHLsr;
	Thu, 11 Sep 2025 15:41:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A35131A10CC;
	Thu, 11 Sep 2025 15:41:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncY0XfcJorYmACA--.14632S5;
	Thu, 11 Sep 2025 15:41:14 +0800 (CST)
From: linan666@huaweicloud.com
To: corbet@lwn.net,
	song@kernel.org,
	yukuai3@huawei.com,
	linan122@huawei.com,
	xni@redhat.com,
	hare@suse.de
Cc: martin.petersen@oracle.com,
	bvanassche@acm.org,
	filipe.c.maia@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linan666@huaweicloud.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com
Subject: [PATCH v4 1/2] md: prevent adding disks with larger logical_block_size to active arrays
Date: Thu, 11 Sep 2025 15:31:43 +0800
Message-Id: <20250911073144.42160-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250911073144.42160-1-linan666@huaweicloud.com>
References: <20250911073144.42160-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY0XfcJorYmACA--.14632S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr15Zr17CFy3Wr1UZrWDurg_yoW8JFWrpa
	97Xa4Yk348JF1akay7J3WrAFy5uws7KrZ7Kry2k3yvqFZxJr17KF43CFZ8Xr1rta93AF4a
	qw4UKw4kua48tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU16wuUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

When adding a disk to a md array, avoid updating the array's
logical_block_size to match the new disk. This prevents accidental
partition table loss that renders the array unusable.

The later patch will introduce a way to configure the array's
logical_block_size.

The issue was introduced before Linux 2.6.12-rc2.

Fixes: d2e45eace8 ("[PATCH] Fix raid "bio too big" failures")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/md/md.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a77c59527d4c..40f56183c744 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6064,6 +6064,13 @@ int mddev_stack_new_rdev(struct mddev *mddev, struct md_rdev *rdev)
 	if (mddev_is_dm(mddev))
 		return 0;
 
+	if (queue_logical_block_size(rdev->bdev->bd_disk->queue) >
+	    queue_logical_block_size(mddev->gendisk->queue)) {
+		pr_err("%s: incompatible logical_block_size, can not add\n",
+		       mdname(mddev));
+		return -EINVAL;
+	}
+
 	lim = queue_limits_start_update(mddev->gendisk->queue);
 	queue_limits_stack_bdev(&lim, rdev->bdev, rdev->data_offset,
 				mddev->gendisk->disk_name);
-- 
2.39.2


