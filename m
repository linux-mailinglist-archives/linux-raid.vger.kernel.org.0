Return-Path: <linux-raid+bounces-3786-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4FBA4770E
	for <lists+linux-raid@lfdr.de>; Thu, 27 Feb 2025 09:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CD018900C3
	for <lists+linux-raid@lfdr.de>; Thu, 27 Feb 2025 08:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C998228C99;
	Thu, 27 Feb 2025 07:59:25 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DA226888;
	Thu, 27 Feb 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643164; cv=none; b=lQmrURyCDSBOVLhFWxWQmdPVa5mXJh6JMCtZev83IE9yc2n7XxvX83bxm9J20PPgk3ifTLsKf0NLjAylF7dgW4YIWA29IE6TVNSypivxPi2+Qo6D8QKVQ0Wm4c1S8vGHxsykGmPuGKmgL6w6WxPFHHVAr7jhGExe+qhVz2QWSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643164; c=relaxed/simple;
	bh=Px/mUYvsmiGzmhUc+tXa1Dybn4SpIBzdm7FmG97uj/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j4TpsRYOkGru2gxqvzsyCtPwObwt3S/+NmamxxfJ4Lf5qww/IZIF4AuZ2cZXsyHncoi8DSQ0Tjgt8zCFNRAYM1yybu546OSqpu0MRHAsfgHPG2Ux5VHHyvvUwnubrGF3g3LurR/RZGn9RLLZ3pLJb0K5P2qEyw0aq/YjaHYdz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z3NyT5Vl9z4f3js3;
	Thu, 27 Feb 2025 15:58:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9F4F61A06D7;
	Thu, 27 Feb 2025 15:59:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl9PG8Bn6c8gFA--.31377S11;
	Thu, 27 Feb 2025 15:59:19 +0800 (CST)
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
Subject: [PATCH V2 07/12] badblocks: try can_merge_front before overlap_front
Date: Thu, 27 Feb 2025 15:55:02 +0800
Message-Id: <20250227075507.151331-8-zhengqixing@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHKl9PG8Bn6c8gFA--.31377S11
X-Coremail-Antispam: 1UD129KBjvJXoW7trWxJFWkuFW5Jr1kZF43Wrg_yoW8Cw45pw
	nIvr1akrZ7Kw17ur13u3ZFqr1agFW8GFsrKa17Jw1FkryIvas3KF1Iq3WxK34jqFZIyrn0
	qw15CFy0vFy8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Li Nan <linan122@huawei.com>

Regardless of whether overlap_front() returns true or false,
can_merge_front() will be executed first. Therefore, move
can_merge_front() in front of can_merge_front() to simplify code.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/badblocks.c | 48 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 43430bd3efa7..57e9edf9b848 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -905,39 +905,35 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 		goto update_sectors;
 	}
 
+	if (can_merge_front(bb, prev, &bad)) {
+		len = front_merge(bb, prev, &bad);
+		added++;
+		hint = prev;
+		goto update_sectors;
+	}
+
 	if (overlap_front(bb, prev, &bad)) {
-		if (can_merge_front(bb, prev, &bad)) {
-			len = front_merge(bb, prev, &bad);
-			added++;
-		} else {
-			int extra = 0;
+		int extra = 0;
 
-			if (!can_front_overwrite(bb, prev, &bad, &extra)) {
-				if (extra > 0)
-					goto out;
+		if (!can_front_overwrite(bb, prev, &bad, &extra)) {
+			if (extra > 0)
+				goto out;
 
-				len = min_t(sector_t,
-					    BB_END(p[prev]) - s, sectors);
-				hint = prev;
-				goto update_sectors;
-			}
+			len = min_t(sector_t,
+				    BB_END(p[prev]) - s, sectors);
+			hint = prev;
+			goto update_sectors;
+		}
 
-			len = front_overwrite(bb, prev, &bad, extra);
-			added++;
-			bb->count += extra;
+		len = front_overwrite(bb, prev, &bad, extra);
+		added++;
+		bb->count += extra;
 
-			if (can_combine_front(bb, prev, &bad)) {
-				front_combine(bb, prev);
-				bb->count--;
-			}
+		if (can_combine_front(bb, prev, &bad)) {
+			front_combine(bb, prev);
+			bb->count--;
 		}
-		hint = prev;
-		goto update_sectors;
-	}
 
-	if (can_merge_front(bb, prev, &bad)) {
-		len = front_merge(bb, prev, &bad);
-		added++;
 		hint = prev;
 		goto update_sectors;
 	}
-- 
2.39.2


