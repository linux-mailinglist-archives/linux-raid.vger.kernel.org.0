Return-Path: <linux-raid+bounces-3791-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80519A47727
	for <lists+linux-raid@lfdr.de>; Thu, 27 Feb 2025 09:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D001891CE8
	for <lists+linux-raid@lfdr.de>; Thu, 27 Feb 2025 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2B22CBC4;
	Thu, 27 Feb 2025 07:59:28 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF922A4C0;
	Thu, 27 Feb 2025 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643167; cv=none; b=pVcMJAm2o49hx2BFnLzTMf0gNkazUmVvCqtu4VCGxpQAgeXf8BJ2zeljWKFieUWSmIn0Mu7zFX3YXrxOJI9vQgZerRhfNUw1CHS0ifUMd4ffDwAhJTIEzIQn29fvR3LbU63KvUbqNhzbaxQWJO3onaBNw5wmQoKPQpua2I0Dnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643167; c=relaxed/simple;
	bh=P0GtgowFc5ha6VAxQvhxYwHGaBARuTogNinSDNtrmHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faXcQx3B5cdLt5gUAPlk7pFK8jAgyuk2k+LmlZBC6eMuWLPy3uJ2Agc5FwYXjdeEz16np0+dQPx6raw1Y7H3pOStDFP4zvYpcz0LGnz5XxbvauHeUXEq/snhFFz1wSVqGEPhn8CLYZKB9U65lxZuPtvqO5zWHcIe5tdmXJd2rPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z3NyQ5BtZz4f3js6;
	Thu, 27 Feb 2025 15:58:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 936911A06D7;
	Thu, 27 Feb 2025 15:59:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl9PG8Bn6c8gFA--.31377S7;
	Thu, 27 Feb 2025 15:59:16 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: axboe@kernel.dk,
	song@kernel.org,
	yukuai3@huawei.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	dlemoal@kernel.org,
	kch@nvidia.com,
	yanjun.zhu@linux.dev,
	hare@suse.de,
	zhengqixing@huawei.com,
	colyli@kernel.org,
	geliang@kernel.org,
	xni@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH V2 03/12] badblocks: attempt to merge adjacent badblocks during ack_all_badblocks
Date: Thu, 27 Feb 2025 15:54:58 +0800
Message-Id: <20250227075507.151331-4-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250227075507.151331-1-zhengqixing@huaweicloud.com>
References: <20250227075507.151331-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl9PG8Bn6c8gFA--.31377S7
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4fJF1UXF4rGrWDur4rZrb_yoWkXFb_Ja
	s7try8Jr95AF13Cr1Syr1Yqr4FgF4DCr4xKryUAr1fXr17tFZrAa98KrZ8Wrn8GFyUZ3sx
	Ar93Xr43urWI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIF4i
	UUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Li Nan <linan122@huawei.com>

If ack and unack badblocks are adjacent, they will not be merged and will
remain as two separate badblocks. Even after the bad blocks are written
to disk and both become ack, they will still remain as two independent
bad blocks. This is not ideal as it wastes the limited space for
badblocks. Therefore, during ack_all_badblocks(), attempt to merge
badblocks if they are adjacent.

Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Coly Li <colyli@kernel.org>
---
 block/badblocks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/badblocks.c b/block/badblocks.c
index f069c93e986d..ad8652fbe1c8 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1491,6 +1491,11 @@ void ack_all_badblocks(struct badblocks *bb)
 				p[i] = BB_MAKE(start, len, 1);
 			}
 		}
+
+		for (i = 0; i < bb->count ; i++)
+			while (try_adjacent_combine(bb, i))
+				;
+
 		bb->unacked_exist = 0;
 	}
 	write_sequnlock_irq(&bb->lock);
-- 
2.39.2


