Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F586573576
	for <lists+linux-raid@lfdr.de>; Wed, 13 Jul 2022 13:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiGMLbu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 Jul 2022 07:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiGMLbr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 13 Jul 2022 07:31:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE96102901;
        Wed, 13 Jul 2022 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bngMjYE6V+XiRTbGrn4zsxCyBaGkCajcx67H9eDcFnw=; b=1hfedvL2eoJfFmn1dj1bBqDpZW
        AzAmvNhGfu3gMtkEEaCltlIo8wPNI+AfPI1ZUaHlw/eiVx9HB9lPGCOAmgxX4w0M9yi4gIOOyvwhr
        l1Oya/Ql3xGTWF2KG7/48ZjsrMVXBI9fkNpisjfLJ2z47uSZfY/PjJe05LYOFIQESBe6bXgBW8Xyf
        8p/fUwKps0l5Lg9MIpid0zwY35QStZOGu1z73FoNp9NpqybmigjsuaMLaIBryLNLCCe20+fPTRkBB
        kloPCwBpV6wG4Eceg8WFkhr8HTSZjsuCJGOAHE8PvZBMPNvPifITIXx4Vp3Fn6qzCAGGBTRfLb4nk
        4PycjnrQ==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBaaj-003A6Q-OO; Wed, 13 Jul 2022 11:31:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 6/9] md: stop using for_each_mddev in md_notify_reboot
Date:   Wed, 13 Jul 2022 13:31:22 +0200
Message-Id: <20220713113125.2232975-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713113125.2232975-1-hch@lst.de>
References: <20220713113125.2232975-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Just do a simple list_for_each_entry_safe on all_mddevs, and only grab a
reference when we drop the lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a2c2e45cb4c18..d3e587271ef3f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9588,11 +9588,13 @@ EXPORT_SYMBOL_GPL(rdev_clear_badblocks);
 static int md_notify_reboot(struct notifier_block *this,
 			    unsigned long code, void *x)
 {
-	struct list_head *tmp;
-	struct mddev *mddev;
+	struct mddev *mddev, *n;
 	int need_delay = 0;
 
-	for_each_mddev(mddev, tmp) {
+	spin_lock(&all_mddevs_lock);
+	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
+		mddev_get(mddev);
+		spin_unlock(&all_mddevs_lock);
 		if (mddev_trylock(mddev)) {
 			if (mddev->pers)
 				__md_stop_writes(mddev);
@@ -9601,7 +9603,11 @@ static int md_notify_reboot(struct notifier_block *this,
 			mddev_unlock(mddev);
 		}
 		need_delay = 1;
+		mddev_put(mddev);
+		spin_lock(&all_mddevs_lock);
 	}
+	spin_unlock(&all_mddevs_lock);
+
 	/*
 	 * certain more exotic SCSI devices are known to be
 	 * volatile wrt too early system reboots. While the
-- 
2.30.2

