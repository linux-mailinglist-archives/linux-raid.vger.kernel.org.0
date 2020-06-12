Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE11F7729
	for <lists+linux-raid@lfdr.de>; Fri, 12 Jun 2020 13:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgFLLPI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 12 Jun 2020 07:15:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbgFLLO6 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 12 Jun 2020 07:14:58 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 264A8481293C501543FE;
        Fri, 12 Jun 2020 19:14:54 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 12 Jun 2020
 19:14:45 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v4 10/15] md/raid5: add offset array in scribble buffer
Date:   Fri, 12 Jun 2020 19:42:15 +0800
Message-ID: <20200612114220.13126-11-yuyufen@huawei.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612114220.13126-1-yuyufen@huawei.com>
References: <20200612114220.13126-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
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
index f8c945645272..053f914424f7 100644
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
@@ -2357,8 +2366,9 @@ static int scribble_alloc(struct raid5_percpu *percpu,
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
2.21.3

