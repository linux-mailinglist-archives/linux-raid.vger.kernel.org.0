Return-Path: <linux-raid+bounces-3147-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F49C06DA
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2024 14:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C9D284BD6
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2024 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B220FA9B;
	Thu,  7 Nov 2024 13:02:17 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959620EA33
	for <linux-raid@vger.kernel.org>; Thu,  7 Nov 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984537; cv=none; b=sm7dvjOxMLUFE+gZFbgQYMzdIQ7WD6QnnNy5nJlMiy2VWzZJ6jITHITBgs1GPsPfS5c97hKR7l/O18UG8GDA5Zfizxa/O2kOU5irn2rjlv7ut8PIvbCItr8tZB9VXt455UYV3+dUONeYf96/YdFmU80Tu29LS4bE8bmL9NKMCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984537; c=relaxed/simple;
	bh=z369lES9dlJGVMxroWXe6Rl2IoMK5Pj1bkY4Fv0u6KY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EAe5RSfAEU4N/uCJLMYPf09zXVNCSf0Uq8ZCCOqZTamBLbe7ViXfOadDCuTmc5S/fDOATaKM9RZ/ba8GlbL4C/15uU0/oy7XImTFyd+xI0xZ5nY9utAR5dCS+r6wPjPZflRYi96kKiBRb+KKvdKOyqa2n2VYfqRZeQYnqqvrCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xkhzp6WkVz4f3m7p
	for <linux-raid@vger.kernel.org>; Thu,  7 Nov 2024 21:01:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D02481A018C
	for <linux-raid@vger.kernel.org>; Thu,  7 Nov 2024 21:02:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4dRuixnj+RyBA--.6466S5;
	Thu, 07 Nov 2024 21:02:11 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mariusz.tkaczyk@linux.intel.com,
	linux-raid@vger.kernel.org
Cc: yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH V2 1/3] tests/05r1-re-add-nosuper: remove bitmap file test
Date: Thu,  7 Nov 2024 20:58:37 +0800
Message-Id: <20241107125839.310633-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241107125839.310633-1-yukuai1@huaweicloud.com>
References: <20241107125839.310633-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4dRuixnj+RyBA--.6466S5
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyDCw18KF18AF4rZFyxXwb_yoW3JFb_CF
	1fWrWxW3yxu3Z2qr18Ca1UZw4vqw43CF1FvFy5XF1fGF1UXrn3Kas7Cryaqry3urZrCFya
	vrWUXFW3CF18CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
	4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07UAEfrUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Prepare to remove bitmap file support.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/05r1-re-add-nosuper | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/05r1-re-add-nosuper b/tests/05r1-re-add-nosuper
index 7d41fd7b..a3fa9503 100644
--- a/tests/05r1-re-add-nosuper
+++ b/tests/05r1-re-add-nosuper
@@ -1,12 +1,9 @@
-
 #
 # create a raid1, remove a drive, and readd it.
 # resync should be instant.
 # Then do some IO first.  Resync should still be very fast
 #
-bmf=$targetdir/bitmap2
-rm -f $bmf
-yes | mdadm -B $md0 -l1 -n2 -b$bmf -d1 $dev1 $dev2
+mdadm -B $md0 -l1 -n2 -d1 $dev1 $dev2
 check resync
 check wait
 testdev $md0 1 $size 1
-- 
2.39.2


