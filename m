Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ADC247D84
	for <lists+linux-raid@lfdr.de>; Tue, 18 Aug 2020 06:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgHREaP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Aug 2020 00:30:15 -0400
Received: from smtp.h3c.com ([60.191.123.56]:61813 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgHREaO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 18 Aug 2020 00:30:14 -0400
X-Greylist: delayed 4841 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2020 00:30:11 EDT
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 07I39TEO006132;
        Tue, 18 Aug 2020 11:09:29 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 07I395UC005479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 11:09:05 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Aug 2020 11:09:06 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <inux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] md: only calculate blocksize once and use i_blocksize()
Date:   Tue, 18 Aug 2020 11:02:19 +0800
Message-ID: <20200818030219.40340-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 07I395UC005479
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

We alreday has the interface i_blocksize(), which can be used
to get blocksize, so use it.
Only calculate blocksize once and use it within read_page().

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/md/md-bitmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 95a5f3757..0d5544868 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -357,11 +357,12 @@ static int read_page(struct file *file, unsigned long index,
 	struct inode *inode = file_inode(file);
 	struct buffer_head *bh;
 	sector_t block, blk_cur;
+	unsigned long blocksize = i_blocksize(inode);
 
 	pr_debug("read bitmap file (%dB @ %llu)\n", (int)PAGE_SIZE,
 		 (unsigned long long)index << PAGE_SHIFT);
 
-	bh = alloc_page_buffers(page, 1<<inode->i_blkbits, false);
+	bh = alloc_page_buffers(page, blocksize, false);
 	if (!bh) {
 		ret = -ENOMEM;
 		goto out;
@@ -383,10 +384,10 @@ static int read_page(struct file *file, unsigned long index,
 
 			bh->b_blocknr = block;
 			bh->b_bdev = inode->i_sb->s_bdev;
-			if (count < (1<<inode->i_blkbits))
+			if (count < blocksize)
 				count = 0;
 			else
-				count -= (1<<inode->i_blkbits);
+				count -= blocksize;
 
 			bh->b_end_io = end_bitmap_write;
 			bh->b_private = bitmap;
-- 
2.17.1

