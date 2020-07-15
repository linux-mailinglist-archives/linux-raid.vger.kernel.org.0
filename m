Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1852D220D25
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 14:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgGOMmH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 08:42:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731076AbgGOMmD (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Jul 2020 08:42:03 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD119E2A6BEE0E4976EA;
        Wed, 15 Jul 2020 20:42:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 20:41:53 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v6 11/15] md/raid5: support config stripe_size by sysfs entry
Date:   Wed, 15 Jul 2020 08:42:53 -0400
Message-ID: <20200715124257.3175816-12-yuyufen@huawei.com>
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

Adding a new 'stripe_size' sysfs entry to set and show stripe_size.
After that, we can adjust stripe_size by writing value into sysfs
entry, likely, set stripe_size as 16KB:

          echo 16384 > /sys/block/md1/md/stripe_size

Show current stripe_size value:

          cat /sys/block/md1/md/stripe_size

stripe_size should not be bigger than PAGE_SIZE, and it requires to be
multiple of 4096.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 84c35eb225b4..338a0732c202 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6699,6 +6699,99 @@ raid5_rmw_level = __ATTR(rmw_level, S_IRUGO | S_IWUSR,
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
+		ret = sprintf(page, "%lu\n", conf->stripe_size);
+	spin_unlock(&mddev->lock);
+	return ret;
+}
+
+static ssize_t
+raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
+{
+	struct r5conf *conf;
+	unsigned long new;
+	int err;
+	int nr;
+
+	if (len >= PAGE_SIZE)
+		return -EINVAL;
+	if (kstrtoul(page, 10, &new))
+		return -EINVAL;
+	/*
+	 * When PAGE_SZIE is 4096, we don't need to modify stripe_size.
+	 * And the value should not be bigger than PAGE_SIZE.
+	 * It requires to be multiple of 4096.
+	 */
+	if (PAGE_SIZE == 4096 || new % 4096 != 0 ||
+			new > PAGE_SIZE || new == 0)
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
+	if (mddev->sync_thread ||
+	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
+	    mddev->reshape_position != MaxSector ||
+	    mddev->sysfs_active) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+
+	nr = conf->max_nr_stripes;
+
+	/* 1. suspend raid array */
+	mddev_suspend(mddev);
+
+	/* 2. free all old stripe_head */
+	mutex_lock(&conf->cache_size_mutex);
+	shrink_stripes(conf);
+
+	/* 3. set new stripe_size */
+	conf->stripe_size = new;
+	conf->stripe_shift = ilog2(new) - 9;
+	conf->stripe_sectors = new >> 9;
+
+	/* 4. allocate new stripe_head */
+	if (grow_stripes(conf, nr)) {
+		pr_warn("md/raid:%s: couldn't allocate buffers\n",
+				mdname(mddev));
+		err = -ENOMEM;
+	}
+	mutex_unlock(&conf->cache_size_mutex);
+
+	/* 5. resume raid array */
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
 
 static ssize_t
 raid5_show_preread_threshold(struct mddev *mddev, char *page)
@@ -6887,6 +6980,7 @@ static struct attribute *raid5_attrs[] =  {
 	&raid5_group_thread_cnt.attr,
 	&raid5_skip_copy.attr,
 	&raid5_rmw_level.attr,
+	&raid5_stripe_size.attr,
 	&r5c_journal_mode.attr,
 	&ppl_write_hint.attr,
 	NULL,
-- 
2.25.4

