Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408783EFDDA
	for <lists+linux-raid@lfdr.de>; Wed, 18 Aug 2021 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbhHRHj1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 18 Aug 2021 03:39:27 -0400
Received: from out0.migadu.com ([94.23.1.103]:59355 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238718AbhHRHjO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 18 Aug 2021 03:39:14 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629272317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hP9HW//B3NoX9LwkEHKK/gCPkZG5tN3oUHI8WD99sBQ=;
        b=m7pL9uRMb0zz5TvuiVQHjPX6RmPmZjUNzr8ZYd/uROuymj5cfHgXzKrhFrzbOovbNIYd9e
        UP3+N7ztESb+0fHHMOepX0XS0MsZ098oQxDZZfq3AQOljeLcEmaLq8deRL+Lt/9SLh3dyf
        VmRsEWkPr2WVohhU/eZ00npYGAtQdc0=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [PATCH V2] raid1: ensure write behind bio has less than BIO_MAX_VECS sectors
Date:   Wed, 18 Aug 2021 15:37:38 +0800
Message-Id: <20210818073738.1271033-1-guoqing.jiang@linux.dev>
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

Cc: Song Liu <song@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Reported-by: Jens Stutte <jens@chianterastutte.eu>
Tested-by: Jens Stutte <jens@chianterastutte.eu>
Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
---
Hi Jens,

Could you consider apply this to block tree? Since it depends
on commit 018eca456c4b4dca56aaf1ec27f309c74d0fe246 in block
tree for-next branch, otherwise lkp would complain about compile
issue again.

Thanks,
Guoqing

V2 change:
1. add checking for write-behind case and relevant comments from Christoph.

 drivers/md/raid1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 3c44c4bb40fc..e8c8e6bb0439 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1329,6 +1329,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_plug_cb *plug = NULL;
 	int first_clone;
 	int max_sectors;
+	bool write_behind = false;
 
 	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1381,6 +1382,10 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	max_sectors = r1_bio->sectors;
 	for (i = 0;  i < disks; i++) {
 		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
+
+		if (test_bit(WriteMostly, &mirror->rdev->flags))
+			write_behind = true;
+
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
 			atomic_inc(&rdev->nr_pending);
 			blocked_rdev = rdev;
@@ -1454,6 +1459,14 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		goto retry_write;
 	}
 
+	/*
+	 * When using a bitmap, we may call alloc_behind_master_bio below.
+	 * alloc_behind_master_bio allocates a copy of the data payload a page
+	 * at a time and thus needs a new bio that can fit the whole payload
+	 * this bio in page sized chunks.
+	 */
+	if (write_behind && bitmap)
+		max_sectors = min_t(int, max_sectors, BIO_MAX_VECS * PAGE_SECTORS);
 	if (max_sectors < bio_sectors(bio)) {
 		struct bio *split = bio_split(bio, max_sectors,
 					      GFP_NOIO, &conf->bio_split);
-- 
2.25.1

