Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD43B577B13
	for <lists+linux-raid@lfdr.de>; Mon, 18 Jul 2022 08:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiGRGef (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 Jul 2022 02:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiGRGed (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 Jul 2022 02:34:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5DD165B0;
        Sun, 17 Jul 2022 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PY4QooK06sCV10t6WAPOaaOFpQ/Z9wrv2mUgV1NKDaY=; b=yA2oZT7uaQQy1/lLrvuv+FB02p
        mmt+SW0IwidrQ349XZ8I08LgvtpXAXmDiln3d2x/ZiZ2ZhH8XJTjWujY35vdBBgKXXk/d/NXd6Imw
        IT+cFZIqDKJkZoakWX40TnlxzGn0K8fATZUkBU+ebO+zonUQluDUP0RdWbQ8ZlMF95rLq0UtDKGAE
        QXouWuukrcL3r7yKbdva9SVnSnkbZiF4JY/1d0JpT1f5HRoBa828kvVppSS+UyG3CmRYELOxWwyTU
        mf+2w8cVwEg+Gfp4G1/y69YmlBpxVPGpUxb0+G5oO5rKCjIG+ccM87oHcKi7rwAtrUkOu6zKleruJ
        sypCA8cA==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDKKs-00BEcz-6H; Mon, 18 Jul 2022 06:34:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 05/10] md: factor out the rdev overlaps check from rdev_size_store
Date:   Mon, 18 Jul 2022 08:34:05 +0200
Message-Id: <20220718063410.338626-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220718063410.338626-1-hch@lst.de>
References: <20220718063410.338626-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This splits the code into nicely readable chunks and also avoids
the refcount inc/dec manipulations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 84 +++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 45 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 96b4e901ff6b5..c8a5f9340060a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3343,14 +3343,33 @@ rdev_size_show(struct md_rdev *rdev, char *page)
 	return sprintf(page, "%llu\n", (unsigned long long)rdev->sectors / 2);
 }
 
-static int overlaps(sector_t s1, sector_t l1, sector_t s2, sector_t l2)
+static int md_rdevs_overlap(struct md_rdev *a, struct md_rdev *b)
 {
 	/* check if two start/length pairs overlap */
-	if (s1+l1 <= s2)
-		return 0;
-	if (s2+l2 <= s1)
-		return 0;
-	return 1;
+	if (a->data_offset + a->sectors <= b->data_offset)
+		return false;
+	if (b->data_offset + b->sectors <= a->data_offset)
+		return false;
+	return true;
+}
+
+static bool md_rdev_overlaps(struct md_rdev *rdev)
+{
+	struct mddev *mddev;
+	struct md_rdev *rdev2;
+
+	spin_lock(&all_mddevs_lock);
+	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
+		rdev_for_each(rdev2, mddev) {
+			if (rdev != rdev2 && rdev->bdev == rdev2->bdev &&
+			    md_rdevs_overlap(rdev, rdev2)) {
+				spin_unlock(&all_mddevs_lock);
+				return true;
+			}
+		}
+	}
+	spin_unlock(&all_mddevs_lock);
+	return false;
 }
 
 static int strict_blocks_to_sectors(const char *buf, sector_t *sectors)
@@ -3402,46 +3421,21 @@ rdev_size_store(struct md_rdev *rdev, const char *buf, size_t len)
 		return -EINVAL; /* component must fit device */
 
 	rdev->sectors = sectors;
-	if (sectors > oldsectors && my_mddev->external) {
-		/* Need to check that all other rdevs with the same
-		 * ->bdev do not overlap.  'rcu' is sufficient to walk
-		 * the rdev lists safely.
-		 * This check does not provide a hard guarantee, it
-		 * just helps avoid dangerous mistakes.
-		 */
-		struct mddev *mddev;
-		int overlap = 0;
-		struct list_head *tmp;
 
-		rcu_read_lock();
-		for_each_mddev(mddev, tmp) {
-			struct md_rdev *rdev2;
-
-			rdev_for_each(rdev2, mddev)
-				if (rdev->bdev == rdev2->bdev &&
-				    rdev != rdev2 &&
-				    overlaps(rdev->data_offset, rdev->sectors,
-					     rdev2->data_offset,
-					     rdev2->sectors)) {
-					overlap = 1;
-					break;
-				}
-			if (overlap) {
-				mddev_put(mddev);
-				break;
-			}
-		}
-		rcu_read_unlock();
-		if (overlap) {
-			/* Someone else could have slipped in a size
-			 * change here, but doing so is just silly.
-			 * We put oldsectors back because we *know* it is
-			 * safe, and trust userspace not to race with
-			 * itself
-			 */
-			rdev->sectors = oldsectors;
-			return -EBUSY;
-		}
+	/*
+	 * Check that all other rdevs with the same bdev do not overlap.  This
+	 * check does not provide a hard guarantee, it just helps avoid
+	 * dangerous mistakes.
+	 */
+	if (sectors > oldsectors && my_mddev->external &&
+	    md_rdev_overlaps(rdev)) {
+		/*
+		 * Someone else could have slipped in a size change here, but
+		 * doing so is just silly.  We put oldsectors back because we
+		 * know it is safe, and trust userspace not to race with itself.
+		 */
+		rdev->sectors = oldsectors;
+		return -EBUSY;
 	}
 	return len;
 }
-- 
2.30.2

