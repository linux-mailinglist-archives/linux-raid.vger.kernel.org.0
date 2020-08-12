Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8072429B4
	for <lists+linux-raid@lfdr.de>; Wed, 12 Aug 2020 14:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHLMtE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Aug 2020 08:49:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727909AbgHLMtC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 12 Aug 2020 08:49:02 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 09FD7EE431A9BC9693F8;
        Wed, 12 Aug 2020 20:48:59 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 20:48:51 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH 12/12] md/raid5: reallocate page array after setting new stripe_size
Date:   Wed, 12 Aug 2020 08:49:31 -0400
Message-ID: <20200812124931.2584743-13-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200812124931.2584743-1-yuyufen@huawei.com>
References: <20200812124931.2584743-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When try to resize stripe_size, we also need to free old
shared page array and allocate new.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 265d1c22309b..7770b2e1248b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6680,6 +6680,7 @@ raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
 	struct r5conf *conf;
 	unsigned long new;
 	int err;
+	int size;
 
 	if (len >= PAGE_SIZE)
 		return -EINVAL;
@@ -6709,10 +6710,29 @@ raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
 	pr_debug("md/raid: change stripe_size from %lu to %lu\n",
 			conf->stripe_size, new);
 
+	if (mddev->sync_thread ||
+		test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
+		mddev->reshape_position != MaxSector ||
+		mddev->sysfs_active) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+
 	mddev_suspend(mddev);
+	mutex_lock(&conf->cache_size_mutex);
+	size = conf->max_nr_stripes;
+
+	shrink_stripes(conf);
+
 	conf->stripe_size = new;
 	conf->stripe_shift = ilog2(new) - 9;
 	conf->stripe_sectors = new >> 9;
+	if (grow_stripes(conf, size)) {
+		pr_warn("md/raid:%s: couldn't allocate buffers\n",
+				mdname(mddev));
+		err = -ENOMEM;
+	}
+	mutex_unlock(&conf->cache_size_mutex);
 	mddev_resume(mddev);
 
 out_unlock:
-- 
2.25.4

