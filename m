Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07531B2666
	for <lists+linux-raid@lfdr.de>; Tue, 21 Apr 2020 14:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgDUMlC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Apr 2020 08:41:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728898AbgDUMk7 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Apr 2020 08:40:59 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 722DF16203BF9C64D2A1;
        Tue, 21 Apr 2020 20:40:51 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 20:40:45 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <colyli@suse.de>,
        <xni@redhat.com>, <houtao1@huawei.com>, <yuyufen@huawei.com>
Subject: [PATCH RFC v2 7/8] md/raid5: add offset array in scribble buffer
Date:   Tue, 21 Apr 2020 20:39:51 +0800
Message-ID: <20200421123952.49025-8-yuyufen@huawei.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421123952.49025-1-yuyufen@huawei.com>
References: <20200421123952.49025-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When enable compresssion buffers for stripe_head, it need an offset
array to record page offset to compute xor. To avoid repeatly allocate
an new array each time, we add a memory region into scribble buffer
to record offset.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 52efacd486ab..801491748043 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1467,6 +1467,15 @@ static addr_conv_t *to_addr_conv(struct stripe_head *sh,
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
@@ -2315,8 +2324,9 @@ static int scribble_alloc(struct raid5_percpu *percpu,
 			  int num, int cnt, gfp_t flags)
 {
 	size_t obj_size =
-		sizeof(struct page *) * (num+2) +
-		sizeof(addr_conv_t) * (num+2);
+		sizeof(struct page *) * (num + 2) +
+		sizeof(addr_conv_t) * (num + 2) +
+		sizeof(unsigned int) * (num + 2);
 	void *scribble;
 
 	scribble = kvmalloc_array(cnt, obj_size, flags);
-- 
2.21.1

