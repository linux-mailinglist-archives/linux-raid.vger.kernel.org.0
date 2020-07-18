Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C950D224A3F
	for <lists+linux-raid@lfdr.de>; Sat, 18 Jul 2020 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgGRJ2P (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 18 Jul 2020 05:28:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8321 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgGRJ2P (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 18 Jul 2020 05:28:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 224C2F860C79ACFACD19;
        Sat, 18 Jul 2020 17:28:13 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Jul 2020
 17:28:04 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v7 3/3] md/raid5: support config stripe_size by sysfs entry
Date:   Sat, 18 Jul 2020 05:29:09 -0400
Message-ID: <20200718092909.4020424-4-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200718092909.4020424-1-yuyufen@huawei.com>
References: <20200718092909.4020424-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Adding a new 'stripe_size' sysfs entry to set and show stripe_size.
stripe_size should not be bigger than PAGE_SIZE, and it requires to
be multiple of 4096. We can adjust stripe_size by writing value into
sysfs entry, likely, set stripe_size as 16KB:

          echo 16384 > /sys/block/md1/md/stripe_size

Show current stripe_size value:

          cat /sys/block/md1/md/stripe_size

For PAGE_SIZE is equal to 4096, 'stripe_size' can just be read.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 60cfa397f2d6..40961dd1777b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6503,6 +6503,77 @@ raid5_rmw_level = __ATTR(rmw_level, S_IRUGO | S_IWUSR,
 			 raid5_show_rmw_level,
 			 raid5_store_rmw_level);
 
+static ssize_t
+raid5_show_stripe_size(struct mddev  *mddev, char *page)
+{
+	struct r5conf *conf;
+	int ret = 0;
+
+	spin_lock(&mddev->lock);
+	conf = mddev->private;
+	if (conf)
+		ret = sprintf(page, "%lu\n", RAID5_STRIPE_SIZE(conf));
+	spin_unlock(&mddev->lock);
+	return ret;
+}
+
+#if PAGE_SIZE != DEFAULT_STRIPE_SIZE
+static ssize_t
+raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
+{
+	struct r5conf *conf;
+	unsigned long new;
+	int err;
+
+	if (len >= PAGE_SIZE)
+		return -EINVAL;
+	if (kstrtoul(page, 10, &new))
+		return -EINVAL;
+
+	/*
+	 * The value should not be bigger than PAGE_SIZE. It requires to
+	 * be multiple of DEFAULT_STRIPE_SIZE.
+	 */
+	if (new % DEFAULT_STRIPE_SIZE != 0 || new > PAGE_SIZE || new == 0)
+		return -EINVAL;
+
+	err = mddev_lock(mddev);
+	if (err)
+		return err;
+
+	conf = mddev->private;
+	if (!conf) {
+		err = -ENODEV;
+		goto out_unlock;
+	}
+
+	if (new == conf->stripe_size)
+		goto out_unlock;
+
+	pr_debug("md/raid: change stripe_size from %lu to %lu\n",
+			conf->stripe_size, new);
+
+	mddev_suspend(mddev);
+	conf->stripe_size = new;
+	conf->stripe_shift = ilog2(new) - 9;
+	conf->stripe_sectors = new >> 9;
+	mddev_resume(mddev);
+
+out_unlock:
+	mddev_unlock(mddev);
+	return err ?: len;
+}
+
+static struct md_sysfs_entry
+raid5_stripe_size = __ATTR(stripe_size, 0644,
+			 raid5_show_stripe_size,
+			 raid5_store_stripe_size);
+#else
+static struct md_sysfs_entry
+raid5_stripe_size = __ATTR(stripe_size, 0444,
+			 raid5_show_stripe_size,
+			 NULL);
+#endif
 
 static ssize_t
 raid5_show_preread_threshold(struct mddev *mddev, char *page)
@@ -6691,6 +6762,7 @@ static struct attribute *raid5_attrs[] =  {
 	&raid5_group_thread_cnt.attr,
 	&raid5_skip_copy.attr,
 	&raid5_rmw_level.attr,
+	&raid5_stripe_size.attr,
 	&r5c_journal_mode.attr,
 	&ppl_write_hint.attr,
 	NULL,
-- 
2.25.4

