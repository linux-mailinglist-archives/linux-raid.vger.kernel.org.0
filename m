Return-Path: <linux-raid+bounces-3452-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F3BA0AF23
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2025 07:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D361656C4
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2025 06:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B09F231A3A;
	Mon, 13 Jan 2025 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhR3GhEP"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CE13D504;
	Mon, 13 Jan 2025 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748809; cv=none; b=U5mVE/lZiz4Iu0XU+eN99RaD9HxVy9nNpf9bSs32zSvGd4Jcww6XcmCEVzwHU+J6KeCnZAmlPeyTRC6Yo1FWbBufbkDLUlOIQqe2KhHulRdNi8YY6qACu1ZQIiZ4PYKKgUMIYxi2YxGegHjg4bWM1COCpSCt6p3WEtQnU62l1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748809; c=relaxed/simple;
	bh=VrfnBLAbJIaR4zhRsyYr0mPJk3ssfnECODENxy1qDxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVP/VjBFnTdDUSwZufygT4OVg5hEYlapNhNo7pQ1W7xKWweiSRpB2Bk2xQMra1V+qliLrKcqWRsv0w2P2762bgkoOnDcPsK4DdOrkM8f86cW6CxIL7XeoBU9vtHYPRLq+57g508oXsYiuqahtznezM2zL9ps0QExXwe06MIhdCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhR3GhEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCA2C4CED6;
	Mon, 13 Jan 2025 06:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736748809;
	bh=VrfnBLAbJIaR4zhRsyYr0mPJk3ssfnECODENxy1qDxQ=;
	h=From:To:Cc:Subject:Date:From;
	b=nhR3GhEPT1mKGXI+pKgl4Kn+xgHuk2nzwhOd7PIQXRq1xYPTMoEAz+qczwMWJAhV3
	 ZRAuVcZKIjVRmjJiHE24xu6PakIhnt5NGEFy69tRkJUYjO4F4GkMgGy5axc2SnU/FC
	 vqtj4q/j4z6jFNnTwrCZuBhcUu40I4/F9bCchRzHhcBAtOCmwR/37vLOb0SoWDGCIW
	 NIfCbAuvdEiWnRB6ndYAYb0L9c3WBFzMrRWkU0bTdXG1w8vdiW23gL1wGmMwU0meuV
	 mga3LpmNw3i2JZMZUcF69RprpGtwr/5lHBb3AlamYzg7UXhUx1B7Jmxwae6Ng6ZUh/
	 /JyFspgDjw35A==
From: Song Liu <song@kernel.org>
To: sfr@canb.auug.org.au,
	axboe@kernel.dk,
	linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	song@kernel.org
Subject: [PATCH] md: Add missing md-linear.c
Date: Sun, 12 Jan 2025 22:13:08 -0800
Message-ID: <20250113061308.101069-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md-linear.c was missed during manual fix-up of a git-am conflict.
Add it back.

Fixes: 7ad00dd67641 ("md: reintroduce md-linear")
Signed-off-by: Song Liu <song@kernel.org>
---
 drivers/md/md-linear.c | 354 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 354 insertions(+)
 create mode 100644 drivers/md/md-linear.c

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
new file mode 100644
index 000000000000..53bc3fda9edb
--- /dev/null
+++ b/drivers/md/md-linear.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * linear.c : Multiple Devices driver for Linux Copyright (C) 1994-96 Marc
+ * ZYNGIER <zyngier@ufr-info-p7.ibp.fr> or <maz@gloups.fdn.fr>
+ */
+
+#include <linux/blkdev.h>
+#include <linux/raid/md_u.h>
+#include <linux/seq_file.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <trace/events/block.h>
+#include "md.h"
+
+struct dev_info {
+	struct md_rdev	*rdev;
+	sector_t	end_sector;
+};
+
+struct linear_conf {
+	struct rcu_head         rcu;
+	sector_t                array_sectors;
+	/* a copy of mddev->raid_disks */
+	int                     raid_disks;
+	struct dev_info         disks[] __counted_by(raid_disks);
+};
+
+/*
+ * find which device holds a particular offset
+ */
+static inline struct dev_info *which_dev(struct mddev *mddev, sector_t sector)
+{
+	int lo, mid, hi;
+	struct linear_conf *conf;
+
+	lo = 0;
+	hi = mddev->raid_disks - 1;
+	conf = mddev->private;
+
+	/*
+	 * Binary Search
+	 */
+
+	while (hi > lo) {
+
+		mid = (hi + lo) / 2;
+		if (sector < conf->disks[mid].end_sector)
+			hi = mid;
+		else
+			lo = mid + 1;
+	}
+
+	return conf->disks + lo;
+}
+
+static sector_t linear_size(struct mddev *mddev, sector_t sectors, int raid_disks)
+{
+	struct linear_conf *conf;
+	sector_t array_sectors;
+
+	conf = mddev->private;
+	WARN_ONCE(sectors || raid_disks,
+		  "%s does not support generic reshape\n", __func__);
+	array_sectors = conf->array_sectors;
+
+	return array_sectors;
+}
+
+static int linear_set_limits(struct mddev *mddev)
+{
+	struct queue_limits lim;
+	int err;
+
+	md_init_stacking_limits(&lim);
+	lim.max_hw_sectors = mddev->chunk_sectors;
+	lim.max_write_zeroes_sectors = mddev->chunk_sectors;
+	lim.io_min = mddev->chunk_sectors << 9;
+	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
+	if (err) {
+		queue_limits_cancel_update(mddev->gendisk->queue);
+		return err;
+	}
+
+	return queue_limits_set(mddev->gendisk->queue, &lim);
+}
+
+static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
+{
+	struct linear_conf *conf;
+	struct md_rdev *rdev;
+	int ret = -EINVAL;
+	int cnt;
+	int i;
+
+	conf = kzalloc(struct_size(conf, disks, raid_disks), GFP_KERNEL);
+	if (!conf)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * conf->raid_disks is copy of mddev->raid_disks. The reason to
+	 * keep a copy of mddev->raid_disks in struct linear_conf is,
+	 * mddev->raid_disks may not be consistent with pointers number of
+	 * conf->disks[] when it is updated in linear_add() and used to
+	 * iterate old conf->disks[] earray in linear_congested().
+	 * Here conf->raid_disks is always consitent with number of
+	 * pointers in conf->disks[] array, and mddev->private is updated
+	 * with rcu_assign_pointer() in linear_addr(), such race can be
+	 * avoided.
+	 */
+	conf->raid_disks = raid_disks;
+
+	cnt = 0;
+	conf->array_sectors = 0;
+
+	rdev_for_each(rdev, mddev) {
+		int j = rdev->raid_disk;
+		struct dev_info *disk = conf->disks + j;
+		sector_t sectors;
+
+		if (j < 0 || j >= raid_disks || disk->rdev) {
+			pr_warn("md/linear:%s: disk numbering problem. Aborting!\n",
+				mdname(mddev));
+			goto out;
+		}
+
+		disk->rdev = rdev;
+		if (mddev->chunk_sectors) {
+			sectors = rdev->sectors;
+			sector_div(sectors, mddev->chunk_sectors);
+			rdev->sectors = sectors * mddev->chunk_sectors;
+		}
+
+		conf->array_sectors += rdev->sectors;
+		cnt++;
+	}
+	if (cnt != raid_disks) {
+		pr_warn("md/linear:%s: not enough drives present. Aborting!\n",
+			mdname(mddev));
+		goto out;
+	}
+
+	/*
+	 * Here we calculate the device offsets.
+	 */
+	conf->disks[0].end_sector = conf->disks[0].rdev->sectors;
+
+	for (i = 1; i < raid_disks; i++)
+		conf->disks[i].end_sector =
+			conf->disks[i-1].end_sector +
+			conf->disks[i].rdev->sectors;
+
+	if (!mddev_is_dm(mddev)) {
+		ret = linear_set_limits(mddev);
+		if (ret)
+			goto out;
+	}
+
+	return conf;
+
+out:
+	kfree(conf);
+	return ERR_PTR(ret);
+}
+
+static int linear_run(struct mddev *mddev)
+{
+	struct linear_conf *conf;
+	int ret;
+
+	if (md_check_no_bitmap(mddev))
+		return -EINVAL;
+
+	conf = linear_conf(mddev, mddev->raid_disks);
+	if (IS_ERR(conf))
+		return PTR_ERR(conf);
+
+	mddev->private = conf;
+	md_set_array_sectors(mddev, linear_size(mddev, 0, 0));
+
+	ret =  md_integrity_register(mddev);
+	if (ret) {
+		kfree(conf);
+		mddev->private = NULL;
+	}
+	return ret;
+}
+
+static int linear_add(struct mddev *mddev, struct md_rdev *rdev)
+{
+	/* Adding a drive to a linear array allows the array to grow.
+	 * It is permitted if the new drive has a matching superblock
+	 * already on it, with raid_disk equal to raid_disks.
+	 * It is achieved by creating a new linear_private_data structure
+	 * and swapping it in in-place of the current one.
+	 * The current one is never freed until the array is stopped.
+	 * This avoids races.
+	 */
+	struct linear_conf *newconf, *oldconf;
+
+	if (rdev->saved_raid_disk != mddev->raid_disks)
+		return -EINVAL;
+
+	rdev->raid_disk = rdev->saved_raid_disk;
+	rdev->saved_raid_disk = -1;
+
+	newconf = linear_conf(mddev, mddev->raid_disks + 1);
+	if (!newconf)
+		return -ENOMEM;
+
+	/* newconf->raid_disks already keeps a copy of * the increased
+	 * value of mddev->raid_disks, WARN_ONCE() is just used to make
+	 * sure of this. It is possible that oldconf is still referenced
+	 * in linear_congested(), therefore kfree_rcu() is used to free
+	 * oldconf until no one uses it anymore.
+	 */
+	oldconf = rcu_dereference_protected(mddev->private,
+			lockdep_is_held(&mddev->reconfig_mutex));
+	mddev->raid_disks++;
+	WARN_ONCE(mddev->raid_disks != newconf->raid_disks,
+		"copied raid_disks doesn't match mddev->raid_disks");
+	rcu_assign_pointer(mddev->private, newconf);
+	md_set_array_sectors(mddev, linear_size(mddev, 0, 0));
+	set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
+	kfree_rcu(oldconf, rcu);
+	return 0;
+}
+
+static void linear_free(struct mddev *mddev, void *priv)
+{
+	struct linear_conf *conf = priv;
+
+	kfree(conf);
+}
+
+static bool linear_make_request(struct mddev *mddev, struct bio *bio)
+{
+	struct dev_info *tmp_dev;
+	sector_t start_sector, end_sector, data_offset;
+	sector_t bio_sector = bio->bi_iter.bi_sector;
+
+	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
+	    && md_flush_request(mddev, bio))
+		return true;
+
+	tmp_dev = which_dev(mddev, bio_sector);
+	start_sector = tmp_dev->end_sector - tmp_dev->rdev->sectors;
+	end_sector = tmp_dev->end_sector;
+	data_offset = tmp_dev->rdev->data_offset;
+
+	if (unlikely(bio_sector >= end_sector ||
+		     bio_sector < start_sector))
+		goto out_of_bounds;
+
+	if (unlikely(is_rdev_broken(tmp_dev->rdev))) {
+		md_error(mddev, tmp_dev->rdev);
+		bio_io_error(bio);
+		return true;
+	}
+
+	if (unlikely(bio_end_sector(bio) > end_sector)) {
+		/* This bio crosses a device boundary, so we have to split it */
+		struct bio *split = bio_split(bio, end_sector - bio_sector,
+					      GFP_NOIO, &mddev->bio_set);
+
+		if (IS_ERR(split)) {
+			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+			bio_endio(bio);
+			return true;
+		}
+
+		bio_chain(split, bio);
+		submit_bio_noacct(bio);
+		bio = split;
+	}
+
+	md_account_bio(mddev, &bio);
+	bio_set_dev(bio, tmp_dev->rdev->bdev);
+	bio->bi_iter.bi_sector = bio->bi_iter.bi_sector -
+		start_sector + data_offset;
+
+	if (unlikely((bio_op(bio) == REQ_OP_DISCARD) &&
+		     !bdev_max_discard_sectors(bio->bi_bdev))) {
+		/* Just ignore it */
+		bio_endio(bio);
+	} else {
+		if (mddev->gendisk)
+			trace_block_bio_remap(bio, disk_devt(mddev->gendisk),
+					      bio_sector);
+		mddev_check_write_zeroes(mddev, bio);
+		submit_bio_noacct(bio);
+	}
+	return true;
+
+out_of_bounds:
+	pr_err("md/linear:%s: make_request: Sector %llu out of bounds on dev %pg: %llu sectors, offset %llu\n",
+	       mdname(mddev),
+	       (unsigned long long)bio->bi_iter.bi_sector,
+	       tmp_dev->rdev->bdev,
+	       (unsigned long long)tmp_dev->rdev->sectors,
+	       (unsigned long long)start_sector);
+	bio_io_error(bio);
+	return true;
+}
+
+static void linear_status(struct seq_file *seq, struct mddev *mddev)
+{
+	seq_printf(seq, " %dk rounding", mddev->chunk_sectors / 2);
+}
+
+static void linear_error(struct mddev *mddev, struct md_rdev *rdev)
+{
+	if (!test_and_set_bit(MD_BROKEN, &mddev->flags)) {
+		char *md_name = mdname(mddev);
+
+		pr_crit("md/linear%s: Disk failure on %pg detected, failing array.\n",
+			md_name, rdev->bdev);
+	}
+}
+
+static void linear_quiesce(struct mddev *mddev, int state)
+{
+}
+
+static struct md_personality linear_personality = {
+	.name		= "linear",
+	.level		= LEVEL_LINEAR,
+	.owner		= THIS_MODULE,
+	.make_request	= linear_make_request,
+	.run		= linear_run,
+	.free		= linear_free,
+	.status		= linear_status,
+	.hot_add_disk	= linear_add,
+	.size		= linear_size,
+	.quiesce	= linear_quiesce,
+	.error_handler	= linear_error,
+};
+
+static int __init linear_init(void)
+{
+	return register_md_personality(&linear_personality);
+}
+
+static void linear_exit(void)
+{
+	unregister_md_personality(&linear_personality);
+}
+
+module_init(linear_init);
+module_exit(linear_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Linear device concatenation personality for MD (deprecated)");
+MODULE_ALIAS("md-personality-1"); /* LINEAR - deprecated*/
+MODULE_ALIAS("md-linear");
+MODULE_ALIAS("md-level--1");
-- 
2.43.5


