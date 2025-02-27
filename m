Return-Path: <linux-raid+bounces-3788-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3FEA4770F
	for <lists+linux-raid@lfdr.de>; Thu, 27 Feb 2025 09:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F359B3B22F9
	for <lists+linux-raid@lfdr.de>; Thu, 27 Feb 2025 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD35222A1EF;
	Thu, 27 Feb 2025 07:59:25 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57307227BA6;
	Thu, 27 Feb 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643165; cv=none; b=HMEh1LYYwQtlaQR1ZbnX6Nc9+/IkJ+e4mHhZl+lnQN+APIvwe3I94kJ6jTdLslyBqclqmwmmbsElhgYPabrEtuYmMS8UY6amRY9TVf2l7p7P2V8NCFqyBO5gFn6wfE2lTGT1iJBgprjhJQjqvicUsJTDZG+5ljiqC/qxNjzo3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643165; c=relaxed/simple;
	bh=7JfyPC4SKfaSXE9X/5i4eNtMjUhnK9ih2VMgcLSAHSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZXof6hsGjtGxApkyqyDMLAg5fKbD0iPM9TfSekSEJ7UefEd+deAvyUxG8PvbnarPpYYHT7AUgDxrwXTcAxzlj3U9Fm5PbxsnxlhR2LRHleHituavrESSxS9Jk694+l+6iG/2ZsPc/a+5S8jo8c7IE5uyATeWkSXny5o/XHAfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z3NyT0p1bz4f3lVb;
	Thu, 27 Feb 2025 15:58:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 65CE11A1C66;
	Thu, 27 Feb 2025 15:59:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl9PG8Bn6c8gFA--.31377S12;
	Thu, 27 Feb 2025 15:59:20 +0800 (CST)
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
Subject: [PATCH V2 08/12] badblocks: fix merge issue when new badblocks align with pre+1
Date: Thu, 27 Feb 2025 15:55:03 +0800
Message-Id: <20250227075507.151331-9-zhengqixing@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHKl9PG8Bn6c8gFA--.31377S12
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr45KrW3Jr4DurWDAr1DKFg_yoW8Xr4kpr
	nxCw1SkryqgF18Za1Uu3WxWrW09a4fGF48Ca9rJr4jkr98A3WIqr1kX3yYqryjqr43Grn0
	q3WY9Fy8Za4kG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

There is a merge issue when adding badblocks as follow:
  echo 0 10 > bad_blocks
  echo 30 10 > bad_blocks
  echo 20 10 > bad_blocks
  cat bad_blocks
  0 10
  20 10    //should be merged with (30 10)
  30 10

In this case, if new badblocks does not intersect with prev, it is added
by insert_at(). If there is an intersection with prev+1, the merge will
be processed in the next re_insert loop.

However, when the end of the new badblocks is exactly equal to the offset
of prev+1, no further re_insert loop occurs, and the two badblocks are not
merge.

Fix it by inc prev, badblocks can be merged during the subsequent code.

Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/badblocks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 57e9edf9b848..92bd43f7fff1 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -892,7 +892,7 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 		len = insert_at(bb, 0, &bad);
 		bb->count++;
 		added++;
-		hint = 0;
+		hint = ++prev;
 		goto update_sectors;
 	}
 
@@ -947,7 +947,7 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 	len = insert_at(bb, prev + 1, &bad);
 	bb->count++;
 	added++;
-	hint = prev + 1;
+	hint = ++prev;
 
 update_sectors:
 	s += len;
-- 
2.39.2


