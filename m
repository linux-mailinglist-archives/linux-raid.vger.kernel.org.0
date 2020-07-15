Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE10220D22
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgGOMmB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 08:42:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730738AbgGOMmA (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Jul 2020 08:42:00 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B5034F6460BC80921EBC;
        Wed, 15 Jul 2020 20:41:56 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 20:41:49 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v6 03/15] md/raid5: add a member of r5pages for struct stripe_head
Date:   Wed, 15 Jul 2020 08:42:45 -0400
Message-ID: <20200715124257.3175816-4-yuyufen@huawei.com>
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

Since grow_buffers() uses alloc_page() to allocate the buffers for
each stripe_head(), means, it will allocate 64K buffers and just use
4K of them, after setting stripe_size as 4096.

To avoid wasting memory, we try to contain multiple 'page' of sh->dev
into one real page. That means, multiple sh->dev[i].page will point to
the only page with different offset. Example of 64K PAGE_SIZE and
4K stripe_size as following:

                    64K PAGE_SIZE
          +---+---+---+---+------------------------------+
          |   |   |   |   |
          |   |   |   |   |
          +-+-+-+-+-+-+-+-+------------------------------+
            ^   ^   ^   ^
            |   |   |   +----------------------------+
            |   |   |                                |
            |   |   +-------------------+            |
            |   |                       |            |
            |   +----------+            |            |
            |              |            |            |
            +-+            |            |            |
              |            |            |            |
        +-----+-----+------+-----+------+-----+------+------+
sh      | offset(0) | offset(4K) | offset(8K) | offset(12K) |
 +      +-----------+------------+------------+-------------+
 +----> dev[0].page  dev[1].page  dev[2].page  dev[3].page

After trying to share one page, the users of sh->dev[i].page need to
take care:

  1) When issue bio into stripe_head, bi_io_vec.bv_page will point to
     the page directly. So, we should make sure bv_offset to been set
     with correct offset.

  2) When compute xor, the page will be passed to computer function.
     So, we also need to pass offset of that page to computer. Let it
     compute correct location of each sh->dev[i].page.

This patch will add a new member of r5pages into stripe_head to manage
all pages needed by each sh->dev[i]. We also add 'offset' for each r5dev
so that users can get related page offset easily. And add helper function
to get page and it's index in r5pages array by disk index.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/md/raid5.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 5a79a657f162..ff03c0ac2995 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -246,6 +246,14 @@ struct stripe_head {
 		int 		     target, target2;
 		enum sum_check_flags zero_sum_result;
 	} ops;
+
+	/* These pages will be used by bios in dev[i] */
+	struct r5pages {
+		struct page	**page;
+		int	size;	/* page array size */
+		int	stripes_per_page;
+	} pages;
+
 	struct r5dev {
 		/* rreq and rvec are used for the replacement device when
 		 * writing data to both devices.
@@ -253,6 +261,7 @@ struct stripe_head {
 		struct bio	req, rreq;
 		struct bio_vec	vec, rvec;
 		struct page	*page, *orig_page;
+		unsigned int	offset;		/* offset of this page */
 		struct bio	*toread, *read, *towrite, *written;
 		sector_t	sector;			/* sector of this page */
 		unsigned long	flags;
@@ -754,6 +763,35 @@ r5_next_bio(struct r5conf *conf, struct bio *bio, sector_t sector)
 		return NULL;
 }
 
+/*
+ * Return offset of the corresponding page for r5dev.
+ */
+static inline int raid5_get_page_offset(struct stripe_head *sh, int disk_idx)
+{
+	struct r5conf *conf = sh->raid_conf;
+
+	return (disk_idx % sh->pages.stripes_per_page) * conf->stripe_size;
+}
+
+/*
+ * Return corresponding page address for r5dev.
+ */
+static inline struct page *
+raid5_get_dev_page(struct stripe_head *sh, int disk_idx)
+{
+	return sh->pages.page[disk_idx / sh->pages.stripes_per_page];
+}
+
+/*
+ * We want to let multiple buffers to share one real page for
+ * stripe_head when PAGE_SIZE is biggger than stripe_size. If
+ * they are equal, no need to use this strategy.
+ */
+static inline int raid5_stripe_pages_shared(struct r5conf *conf)
+{
+	return conf->stripe_size < PAGE_SIZE;
+}
+
 extern void md_raid5_kick_device(struct r5conf *conf);
 extern int raid5_set_cache_size(struct mddev *mddev, int size);
 extern sector_t raid5_compute_blocknr(struct stripe_head *sh, int i, int previous);
-- 
2.25.4

