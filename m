Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56321B9453
	for <lists+linux-raid@lfdr.de>; Sun, 26 Apr 2020 23:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDZVu1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 Apr 2020 17:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgDZVtv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 26 Apr 2020 17:49:51 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD5C09B050
        for <linux-raid@vger.kernel.org>; Sun, 26 Apr 2020 14:49:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr25so12456021ejb.10
        for <linux-raid@vger.kernel.org>; Sun, 26 Apr 2020 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xmVUgxR4RkezqKBk0fRvQI3+2wLIZJ7zmozB8jZORxA=;
        b=anDlxyzgROe5uD6yg0m6HW1PUaakY+m40DdicyefRKrxKyIZGl7Jshydu0kr872GNe
         /i1TnxhxjuU4rEjAMUbx5fJcYlcKgxKzuqUD+owhUZp+tcz3maXUuHBrPRqL0OXgEYiA
         rIXAfi/rtOagy1a/o50Q8fxmx5BCVVp14DmJnHr1V/GvvL/Mt4U/q7kkZ84Hj10Gjp0I
         AH1/kGG3wyMyq/jqu2dcKBG+6IuCF7Pryi+cFSw9tB1Y17Xmow8XJOpxh4SVnuFsLG+f
         8IWT9gV2fdMe8Wtto7bNKvaO/MquUmrwJ9LKrx6EnNMzwlKpIsCxNWRPFgv1F9T8FjGe
         rBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xmVUgxR4RkezqKBk0fRvQI3+2wLIZJ7zmozB8jZORxA=;
        b=e7tG6U+R0TZyWpJ6v3GR3C5B1dVY58eLuRa3YjPkG00nA1L8pAsh9UJfyv9kj6/lSp
         ezVO3OUQVsE008UtI2nbzv7UsTzW2X8SQg0UhjZA7jPEkXR2OuZzS0xKeTK7w7QzPO0i
         U4DhbIxHTpn44y4v1kHHxPiDCv4wt06XWUFrhRSiNFC54l+NLjR8iugyuJTAm9xXoMdQ
         +3vNLrGNjoGLFaH+0xLtpOlZ5lFkgmuDh4f4oB2j5cOovTEnr5qNg6OP+jS4kAKSe9gF
         GssJhT1qoZl/qbxnr4yO8ZYFQDeMhmxrKByUZXfGQdvmIF6FeXu8dCFKzJ+rApBxTl6/
         BNCw==
X-Gm-Message-State: AGi0PuaM56EbRsNWBCtQEcjnZc/SRinhdjaP7p8VjnAaE2g93mFVXwqS
        uvsDWvJto230UMppnx/LUfiXvQ==
X-Google-Smtp-Source: APiQypIJg5ZBPDjk8zuYwSPioxFnrrJmJZ6e8E9h5lzaJIzlYqV42JDaS97GOWPsGEzoA3fm2GMRlQ==
X-Received: by 2002:a17:906:1490:: with SMTP id x16mr15873490ejc.323.1587937788622;
        Sun, 26 Apr 2020 14:49:48 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:47 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [RFC PATCH 2/9] md: remove __clear_page_buffers and use set/clear_fs_page_private
Date:   Sun, 26 Apr 2020 23:49:18 +0200
Message-Id: <20200426214925.10970-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

After introduce set/clear_fs_page_private in pagemap.h, we can remove
the duplicat code and call the new functions.

Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md-bitmap.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b952bd45bd6a..b935473c82b7 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -324,14 +324,6 @@ static void end_bitmap_write(struct buffer_head *bh, int uptodate)
 		wake_up(&bitmap->write_wait);
 }
 
-/* copied from buffer.c */
-static void
-__clear_page_buffers(struct page *page)
-{
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
-}
 static void free_buffers(struct page *page)
 {
 	struct buffer_head *bh;
@@ -345,7 +337,7 @@ static void free_buffers(struct page *page)
 		free_buffer_head(bh);
 		bh = next;
 	}
-	__clear_page_buffers(page);
+	clear_fs_page_private(page);
 	put_page(page);
 }
 
@@ -374,7 +366,7 @@ static int read_page(struct file *file, unsigned long index,
 		ret = -ENOMEM;
 		goto out;
 	}
-	attach_page_buffers(page, bh);
+	set_fs_page_private(page, bh);
 	blk_cur = index << (PAGE_SHIFT - inode->i_blkbits);
 	while (bh) {
 		block = blk_cur;
-- 
2.17.1

