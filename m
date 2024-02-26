Return-Path: <linux-raid+bounces-860-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168AF867176
	for <lists+linux-raid@lfdr.de>; Mon, 26 Feb 2024 11:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18AB289F27
	for <lists+linux-raid@lfdr.de>; Mon, 26 Feb 2024 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710AE58120;
	Mon, 26 Feb 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YtY3XhXv"
X-Original-To: linux-raid@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8857875;
	Mon, 26 Feb 2024 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943456; cv=none; b=Y+S8EV+n6W8YWoGk2JgBqtXIPQGT8BoIpYsGCHLX6FiG4xK768M6xUF0zEQ30Hn08FyrMdqQMTjcGzHwJTj5eIh5pZUAuzV/IYYcIPWjLouYV+icPmptXy2CZhglBJ1zMcOXMHVNkDLN/LmbDXYM7f+h1RrqowiGJGT1/xqioOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943456; c=relaxed/simple;
	bh=pdGx2vwZa8Dr6IFIsSHS+0zp/tQjhJTDUzal3dXFX9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYNhHc5611cyRjm+HQH9D2T8pXcW+985ZLrXRyt5dYNPGoFvUIMqP2pPHig5HdkCxzXUVZuj0VkNdo1hJDFqsAVFDawTnB5H1554H3iPOtKNVB7v5MJXB2oH7aaSaWiNFEuaUpBsWdNzhamgI8/343b1PDUwzEdb1N2UOOJKGrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YtY3XhXv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dO1UJbN98oc0DXmJGPgP9/w6HQlV/cBVJ10XT4uDjII=; b=YtY3XhXvCXLU+Wnt4wgKysGF8m
	/9agg8Gy8eEQkndLE+MAGAu/ruO2rA/7NWhmHFaYHaAJAqu6CIvpUGyYauEDyuGtNNJRxBNG0jql9
	qrfxm5VaIBA8E3kYASWhwDNM9MWBAuuPbOi0/LTeWUAf+3cuhRlWPBudAFvl5lz7T2AuNDkCtZLw3
	uZ65qKiNJQCtzlGyJF06kVT6FrfGeg64lt54uzUDNf5TVbeIMFIrlmpfOWZfnVAvx2KmxI5G66q6O
	XJCuu+cWBHO7ddhjSrg8Wh4tIt0a2BlP+wq3zYkY1hNRliDymGNZkaqpj+MUfBEeq0B2gQM0h64T5
	hWG5w2TA==;
Received: from 213-147-167-65.nat.highway.webapn.at ([213.147.167.65] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYG3-000000004nK-2IZl;
	Mon, 26 Feb 2024 10:30:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 07/16] md/raid10: use the atomic queue limit update APIs
Date: Mon, 26 Feb 2024 11:29:55 +0100
Message-Id: <20240226103004.281412-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226103004.281412-1-hch@lst.de>
References: <20240226103004.281412-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Build the queue limits outside the queue and apply them using
queue_limits_set.  Also remove the bogus ->gendisk and ->queue NULL
checks in the are while touching it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid10.c | 52 +++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7412066ea22c7a..21d0aced9a0725 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2130,11 +2130,9 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 				repl_slot = mirror;
 			continue;
 		}
-
-		if (mddev->gendisk)
-			disk_stack_limits(mddev->gendisk, rdev->bdev,
-					  rdev->data_offset << 9);
-
+		err = mddev_stack_new_rdev(mddev, rdev);
+		if (err)
+			return err;
 		p->head_position = 0;
 		p->recovery_disabled = mddev->recovery_disabled - 1;
 		rdev->raid_disk = mirror;
@@ -2150,10 +2148,9 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		clear_bit(In_sync, &rdev->flags);
 		set_bit(Replacement, &rdev->flags);
 		rdev->raid_disk = repl_slot;
-		err = 0;
-		if (mddev->gendisk)
-			disk_stack_limits(mddev->gendisk, rdev->bdev,
-					  rdev->data_offset << 9);
+		err = mddev_stack_new_rdev(mddev, rdev);
+		if (err)
+			return err;
 		conf->fullsync = 1;
 		WRITE_ONCE(p->replacement, rdev);
 	}
@@ -4002,18 +3999,18 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	return ERR_PTR(err);
 }
 
-static void raid10_set_io_opt(struct r10conf *conf)
+static unsigned int raid10_nr_stripes(struct r10conf *conf)
 {
-	int raid_disks = conf->geo.raid_disks;
+	unsigned int raid_disks = conf->geo.raid_disks;
 
-	if (!(conf->geo.raid_disks % conf->geo.near_copies))
-		raid_disks /= conf->geo.near_copies;
-	blk_queue_io_opt(conf->mddev->queue, (conf->mddev->chunk_sectors << 9) *
-			 raid_disks);
+	if (conf->geo.raid_disks % conf->geo.near_copies)
+		return raid_disks;
+	return raid_disks / conf->geo.near_copies;
 }
 
 static int raid10_run(struct mddev *mddev)
 {
+	struct queue_limits lim;
 	struct r10conf *conf;
 	int i, disk_idx;
 	struct raid10_info *disk;
@@ -4021,6 +4018,7 @@ static int raid10_run(struct mddev *mddev)
 	sector_t size;
 	sector_t min_offset_diff = 0;
 	int first = 1;
+	int ret = -EIO;
 
 	if (mddev->private == NULL) {
 		conf = setup_conf(mddev);
@@ -4047,12 +4045,6 @@ static int raid10_run(struct mddev *mddev)
 		}
 	}
 
-	if (mddev->queue) {
-		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
-		blk_queue_io_min(mddev->queue, mddev->chunk_sectors << 9);
-		raid10_set_io_opt(conf);
-	}
-
 	rdev_for_each(rdev, mddev) {
 		long long diff;
 
@@ -4081,14 +4073,19 @@ static int raid10_run(struct mddev *mddev)
 		if (first || diff < min_offset_diff)
 			min_offset_diff = diff;
 
-		if (mddev->gendisk)
-			disk_stack_limits(mddev->gendisk, rdev->bdev,
-					  rdev->data_offset << 9);
-
 		disk->head_position = 0;
 		first = 0;
 	}
 
+	blk_set_stacking_limits(&lim);
+	lim.max_write_zeroes_sectors = 0;
+	lim.io_min = mddev->chunk_sectors << 9;
+	lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
+	mddev_stack_rdev_limits(mddev, &lim);
+	ret = queue_limits_set(mddev->queue, &lim);
+	if (ret)
+		goto out_free_conf;
+
 	/* need to check that every block has at least one working mirror */
 	if (!enough(conf, -1)) {
 		pr_err("md/raid10:%s: not enough operational mirrors.\n",
@@ -4189,7 +4186,7 @@ static int raid10_run(struct mddev *mddev)
 	raid10_free_conf(conf);
 	mddev->private = NULL;
 out:
-	return -EIO;
+	return ret;
 }
 
 static void raid10_free(struct mddev *mddev, void *priv)
@@ -4966,8 +4963,7 @@ static void end_reshape(struct r10conf *conf)
 	conf->reshape_safe = MaxSector;
 	spin_unlock_irq(&conf->device_lock);
 
-	if (conf->mddev->queue)
-		raid10_set_io_opt(conf);
+	mddev_update_io_opt(conf->mddev, raid10_nr_stripes(conf));
 	conf->fullsync = 0;
 }
 
-- 
2.39.2


