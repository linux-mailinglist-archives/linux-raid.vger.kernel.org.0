Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D64577B1C
	for <lists+linux-raid@lfdr.de>; Mon, 18 Jul 2022 08:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiGRGe4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 Jul 2022 02:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiGRGes (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 Jul 2022 02:34:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F972165BA;
        Sun, 17 Jul 2022 23:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9V0aQoOiMRI4EkpKNbU8q4SwaJx+xMRw4Ry7O21tYGc=; b=H7U/qCa26Vm+TRVvjCm0Rs813B
        XsJuoEn5X0HNXReXZSXyBKl6rpp9fz2ka1SW2AjHePI/xvY4FVAYzGZVkAxO2t4vdi962mPjxpSgS
        a/6ELgWEla1VJyZcbvNw1RCQxgmLBP+AlpgR0yn6DYb926xmrgdjQLqAxhTBU1E/TGWCvS0RrDNqI
        JBu+SLvDmcF3hSiii672ygGyuurFvzWe3mJjXQsyEkhQswsfCRVYNLSb123Jbo1EQZ42PMy+gugy4
        VbYizhr6y3zi4SquaD6j7FO4F0e5iauOmifzKRi995gCuwIdHoMJyqX6z6Ao8o1tsNqIX+PuK0/6Z
        8x13NC6w==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDKL7-00BEia-Ht; Mon, 18 Jul 2022 06:34:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 10/10] md: simplify md_open
Date:   Mon, 18 Jul 2022 08:34:10 +0200
Message-Id: <20220718063410.338626-11-hch@lst.de>
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

Now that devices are on the all_mddevs list until the gendisk is freed,
there can't be any duplicates.  Remove the global list lookup and just
grab a reference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 08cf21ad4c2d7..9b1e61b4bac8b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7785,45 +7785,33 @@ static int md_set_read_only(struct block_device *bdev, bool ro)
 
 static int md_open(struct block_device *bdev, fmode_t mode)
 {
-	/*
-	 * Succeed if we can lock the mddev, which confirms that
-	 * it isn't being stopped right now.
-	 */
-	struct mddev *mddev = mddev_find(bdev->bd_dev);
+	struct mddev *mddev;
 	int err;
 
+	spin_lock(&all_mddevs_lock);
+	mddev = mddev_get(bdev->bd_disk->private_data);
+	spin_unlock(&all_mddevs_lock);
 	if (!mddev)
 		return -ENODEV;
 
-	if (mddev->gendisk != bdev->bd_disk) {
-		/* we are racing with mddev_put which is discarding this
-		 * bd_disk.
-		 */
-		mddev_put(mddev);
-		/* Wait until bdev->bd_disk is definitely gone */
-		if (work_pending(&mddev->del_work))
-			flush_workqueue(md_misc_wq);
-		return -EBUSY;
-	}
-	BUG_ON(mddev != bdev->bd_disk->private_data);
-
-	if ((err = mutex_lock_interruptible(&mddev->open_mutex)))
+	err = mutex_lock_interruptible(&mddev->open_mutex);
+	if (err)
 		goto out;
 
-	if (test_bit(MD_CLOSING, &mddev->flags)) {
-		mutex_unlock(&mddev->open_mutex);
-		err = -ENODEV;
-		goto out;
-	}
+	err = -ENODEV;
+	if (test_bit(MD_CLOSING, &mddev->flags))
+		goto out_unlock;
 
-	err = 0;
 	atomic_inc(&mddev->openers);
 	mutex_unlock(&mddev->open_mutex);
 
 	bdev_check_media_change(bdev);
- out:
-	if (err)
-		mddev_put(mddev);
+	return 0;
+
+out_unlock:
+	mutex_unlock(&mddev->open_mutex);
+out:
+	mddev_put(mddev);
 	return err;
 }
 
-- 
2.30.2

