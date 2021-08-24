Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A823F5570
	for <lists+linux-raid@lfdr.de>; Tue, 24 Aug 2021 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhHXBSS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Aug 2021 21:18:18 -0400
Received: from out1.migadu.com ([91.121.223.63]:29485 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhHXBSS (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 23 Aug 2021 21:18:18 -0400
X-Greylist: delayed 2048 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Aug 2021 21:18:18 EDT
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629767854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+p/y4+X96U0IPsl0qhnYFKY9iIZpihn52Q9b7rWcaCI=;
        b=KszRba48ZOjNYm7/U/KFc0BQofezUoJfrriiZTL1fec5SWonTOfVRgriUf2+0d5Z/s33SX
        UJgCvoDuRHKhRtOOIuza6Ez1QEfxuZwXlBjkMMHDv515L4x8VkQqM7JBXet0zmcm1wfC9J
        w4UXg2lOhmz0VrsoH34HGHQRZZ6Kimc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     axboe@kernel.dk
Cc:     song@kernel.org, hch@infradead.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] raid1: ensure write behind bio has less than BIO_MAX_VECS sectors
Date:   Tue, 24 Aug 2021 09:16:54 +0800
Message-Id: <20210824011654.3829681-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <jiangguoqing@kylinos.cn>

We can't split write behind bio with more than BIO_MAX_VECS sectors,
otherwise the below call trace was triggered because we could allocate
oversized write behind bio later.

[ 8.097936] bvec_alloc+0x90/0xc0
[ 8.098934] bio_alloc_bioset+0x1b3/0x260
[ 8.099959] raid1_make_request+0x9ce/0xc50 [raid1]
[ 8.100988] ? __bio_clone_fast+0xa8/0xe0
[ 8.102008] md_handle_request+0x158/0x1d0 [md_mod]
[ 8.103050] md_submit_bio+0xcd/0x110 [md_mod]
[ 8.104084] submit_bio_noacct+0x139/0x530
[ 8.105127] submit_bio+0x78/0x1d0
[ 8.106163] ext4_io_submit+0x48/0x60 [ext4]
[ 8.107242] ext4_writepages+0x652/0x1170 [ext4]
[ 8.108300] ? do_writepages+0x41/0x100
[ 8.109338] ? __ext4_mark_inode_dirty+0x240/0x240 [ext4]
[ 8.110406] do_writepages+0x41/0x100
[ 8.111450] __filemap_fdatawrite_range+0xc5/0x100
[ 8.112513] file_write_and_wait_range+0x61/0xb0
[ 8.113564] ext4_sync_file+0x73/0x370 [ext4]
[ 8.114607] __x64_sys_fsync+0x33/0x60
[ 8.115635] do_syscall_64+0x33/0x40
[ 8.116670] entry_SYSCALL_64_after_hwframe+0x44/0xae

Thanks for the comment from Christoph.

[1]. https://bugs.archlinux.org/task/70992

Reported-by: Jens Stutte <jens@chianterastutte.eu>
Tested-by: Jens Stutte <jens@chianterastutte.eu>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
---
V4 change:
1. fix issue reported by lkp.
2. add Reviewed-by tag.

V3 change:
1. add comment before test WriteMostly.
2. reduce line length.

V2 change:
1. add checking for write-behind case and relevant comments from Christoph.

 drivers/md/raid1.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 3c44c4bb40fc..ad51a60f1a93 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1329,6 +1329,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_plug_cb *plug = NULL;
 	int first_clone;
 	int max_sectors;
+	bool write_behind = false;
 
 	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1381,6 +1382,15 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	max_sectors = r1_bio->sectors;
 	for (i = 0;  i < disks; i++) {
 		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
+
+		/*
+		 * The write-behind io is only attempted on drives marked as
+		 * write-mostly, which means we could allocate write behind
+		 * bio later.
+		 */
+		if (rdev && test_bit(WriteMostly, &rdev->flags))
+			write_behind = true;
+
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
 			atomic_inc(&rdev->nr_pending);
 			blocked_rdev = rdev;
@@ -1454,6 +1464,15 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		goto retry_write;
 	}
 
+	/*
+	 * When using a bitmap, we may call alloc_behind_master_bio below.
+	 * alloc_behind_master_bio allocates a copy of the data payload a page
+	 * at a time and thus needs a new bio that can fit the whole payload
+	 * this bio in page sized chunks.
+	 */
+	if (write_behind && bitmap)
+		max_sectors = min_t(int, max_sectors,
+				    BIO_MAX_VECS * PAGE_SECTORS);
 	if (max_sectors < bio_sectors(bio)) {
 		struct bio *split = bio_split(bio, max_sectors,
 					      GFP_NOIO, &conf->bio_split);
-- 
2.25.1

