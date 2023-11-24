Return-Path: <linux-raid+bounces-19-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D97F6D90
	for <lists+linux-raid@lfdr.de>; Fri, 24 Nov 2023 09:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FAF4B21734
	for <lists+linux-raid@lfdr.de>; Fri, 24 Nov 2023 08:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18699461;
	Fri, 24 Nov 2023 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821274483;
	Fri, 24 Nov 2023 00:00:23 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sc6pm6QW1z4f3jZQ;
	Fri, 24 Nov 2023 16:00:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A0C4D1A03D0;
	Fri, 24 Nov 2023 16:00:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDX2xERWGBlUnAqBw--.22901S5;
	Fri, 24 Nov 2023 16:00:19 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	yukuai3@huawei.com,
	xni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 1/6] md: fix missing flush of sync_work
Date: Fri, 24 Nov 2023 15:59:48 +0800
Message-Id: <20231124075953.1932764-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDX2xERWGBlUnAqBw--.22901S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tr18WF13Cr18Cr4kJw13Jwb_yoW8Xry5p3
	ySqa45ArWrAay3t34UGa4qva4rWw10qrZrtrW3u345JF1aqF45G3WY9F1jqFykJF93Zwn8
	ZF48ta9xZ3W0vr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Commit ac619781967b ("md: use separate work_struct for md_start_sync()")
use a new sync_work to replace del_work, however, stop_sync_thread() and
__md_stop_writes() was trying to wait for sync_thread to be done, hence
they should switch to use sync_work as well.

Noted that md_start_sync() from sync_work will grab 'reconfig_mutex',
hence other contex can't held the same lock to flush work, and this will
be fixed in later patches.

Fixes: ac619781967b ("md: use separate work_struct for md_start_sync()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 09686d8db983..1701e2fb219f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4865,7 +4865,7 @@ static void stop_sync_thread(struct mddev *mddev)
 		return;
 	}
 
-	if (work_pending(&mddev->del_work))
+	if (work_pending(&mddev->sync_work))
 		flush_workqueue(md_misc_wq);
 
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
@@ -6273,7 +6273,7 @@ static void md_clean(struct mddev *mddev)
 static void __md_stop_writes(struct mddev *mddev)
 {
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	if (work_pending(&mddev->del_work))
+	if (work_pending(&mddev->sync_work))
 		flush_workqueue(md_misc_wq);
 	if (mddev->sync_thread) {
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-- 
2.39.2


