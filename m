Return-Path: <linux-raid+bounces-4051-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780FBA9E0F1
	for <lists+linux-raid@lfdr.de>; Sun, 27 Apr 2025 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F220917D7E7
	for <lists+linux-raid@lfdr.de>; Sun, 27 Apr 2025 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F145D24E4AF;
	Sun, 27 Apr 2025 08:37:14 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ABF24729E;
	Sun, 27 Apr 2025 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745743034; cv=none; b=YuUmuMVQj8u70H3LV5zmAqS3eZrLeWR1s+X1KJSByuhQIE+3BqC7XnEvY/YD4td4MxxMmO50Po9osb072Q362/FzIekSHpXqtklUdP4L1I56C4RKU55e+CUvXJPUm9kDCCxK6thE0ezvsj/SQi99mjtBh5jbA4avLuWDvwv5PeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745743034; c=relaxed/simple;
	bh=I3IP+6pZGUdxD1vyt2vEOwUCd6PtNM/JC/1BzMwekBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omssgG+FHgDT70Qwedl00pAqRIKx5egF6LAF2l8PtD1i5YjhG8LMjP83AGWtAhzQSgX8XaNKTuXJbnURYGg2v4vnX77Dhj+awf+g9Ht8kE01GI2WtOL0lSFecrRJdbEWP1dMjFCFNrExjrp2WmbNy2BMaZ0HKATcQPLCSNwXjHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4Zlg1L2pxMzYQv4h;
	Sun, 27 Apr 2025 16:37:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D8D151A018D;
	Sun, 27 Apr 2025 16:37:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDHGsWx7A1oOv4xKg--.7274S7;
	Sun, 27 Apr 2025 16:37:09 +0800 (CST)
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
Subject: [PATCH v2 3/9] block: WARN if bdev inflight counter is negative
Date: Sun, 27 Apr 2025 16:29:22 +0800
Message-Id: <20250427082928.131295-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDHGsWx7A1oOv4xKg--.7274S7
X-Coremail-Antispam: 1UD129KBjvdXoWrtF18GF1xZFy8uryxur4kJFb_yoW3KFc_Gr
	n2g34DZw13GFZxArn0vF4YvrWv9w18JFZ3JFy2qF9xur4UXasagw1vyws8JFZ8Xa90gFyS
	kF9rZFy0yr13tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pRl_MsUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Which means there is a BUG for related bio-based disk driver, or blk-mq
for rq-based disk, it's better not to hide the BUG.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index f671d9ee00c4..d158c25237b6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -136,9 +136,9 @@ static void part_in_flight_rw(struct block_device *part,
 		inflight[0] += part_stat_local_read_cpu(part, in_flight[0], cpu);
 		inflight[1] += part_stat_local_read_cpu(part, in_flight[1], cpu);
 	}
-	if ((int)inflight[0] < 0)
+	if (WARN_ON_ONCE((int)inflight[0] < 0))
 		inflight[0] = 0;
-	if ((int)inflight[1] < 0)
+	if (WARN_ON_ONCE((int)inflight[1] < 0))
 		inflight[1] = 0;
 }
 
-- 
2.39.2


