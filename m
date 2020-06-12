Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FA81F7723
	for <lists+linux-raid@lfdr.de>; Fri, 12 Jun 2020 13:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgFLLO6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 12 Jun 2020 07:14:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5883 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbgFLLOz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 12 Jun 2020 07:14:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 29EC895B3FAB19D9C108;
        Fri, 12 Jun 2020 19:14:49 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 12 Jun 2020
 19:14:40 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v4 02/15] md/raid5: add sysfs entry to set and show stripe_size
Date:   Fri, 12 Jun 2020 19:42:07 +0800
Message-ID: <20200612114220.13126-3-yuyufen@huawei.com>
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

Here, we don't support setting stripe_size by sysfs.
Following patches will do that.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5c972af66978..9044b78b2f74 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6512,6 +6512,27 @@ raid5_rmw_level = __ATTR(rmw_level, S_IRUGO | S_IWUSR,
 			 raid5_show_rmw_level,
 			 raid5_store_rmw_level);
 
+static ssize_t
+raid5_show_stripe_size(struct mddev  *mddev, char *page)
+{
+	struct r5conf *conf = mddev->private;
+
+	if (conf)
+		return sprintf(page, "%d\n", conf->stripe_size);
+	else
+		return 0;
+}
+
+static ssize_t
+raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
+{
+	return -EINVAL;
+}
+
+static struct md_sysfs_entry
+raid5_stripe_size = __ATTR(stripe_size, 0644,
+			 raid5_show_stripe_size,
+			 raid5_store_stripe_size);
 
 static ssize_t
 raid5_show_preread_threshold(struct mddev *mddev, char *page)
@@ -6700,6 +6721,7 @@ static struct attribute *raid5_attrs[] =  {
 	&raid5_group_thread_cnt.attr,
 	&raid5_skip_copy.attr,
 	&raid5_rmw_level.attr,
+	&raid5_stripe_size.attr,
 	&r5c_journal_mode.attr,
 	&ppl_write_hint.attr,
 	NULL,
-- 
2.21.3

