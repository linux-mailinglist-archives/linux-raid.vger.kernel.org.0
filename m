Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A47220D24
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 14:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgGOMmE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 08:42:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730738AbgGOMmD (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Jul 2020 08:42:03 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A213FB4AA13B83469E4E;
        Wed, 15 Jul 2020 20:42:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 20:41:52 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v6 09/15] md/raid5: add offset array in scribble buffer
Date:   Wed, 15 Jul 2020 08:42:51 -0400
Message-ID: <20200715124257.3175816-10-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200715124257.3175816-1-yuyufen@huawei.com>
References: <20200715124257.3175816-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When enable shared buffers for stripe_head, it need an offset
array to record page offset to compute xor. To avoid repeatly allocate
an new array each time, we add a memory region into scribble buffer
to record offset.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 2702a1cb2281..b5a00f64db5c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1477,6 +1477,15 @@ static addr_conv_t *to_addr_conv(struct stripe_head *sh,
 	return (void *) (to_addr_page(percpu, i) + sh->disks + 2);
 }
 
+/*
+ * Return a pointer to record offset address.
+ */
+static unsigned int *
+to_addr_offs(struct stripe_head *sh, struct raid5_percpu *percpu)
+{
+	return (unsigned int *) (to_addr_conv(sh, percpu, 0) + sh->disks + 2);
+}
+
 static struct dma_async_tx_descriptor *
 ops_run_compute5(struct stripe_head *sh, struct raid5_percpu *percpu)
 {
@@ -2359,8 +2368,9 @@ static int scribble_alloc(struct raid5_percpu *percpu,
 			  int num, int cnt)
 {
 	size_t obj_size =
-		sizeof(struct page *) * (num+2) +
-		sizeof(addr_conv_t) * (num+2);
+		sizeof(struct page *) * (num + 2) +
+		sizeof(addr_conv_t) * (num + 2) +
+		sizeof(unsigned int) * (num + 2);
 	void *scribble;
 
 	/*
-- 
2.25.4

