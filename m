Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B7620EFF9
	for <lists+linux-raid@lfdr.de>; Tue, 30 Jun 2020 09:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgF3Hzx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jun 2020 03:55:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37646 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730067AbgF3Hzx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Jun 2020 03:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593503751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=GPzKKUu5CFOVI2J1wKRl3Fx7mJY5+q3J3XC/wFlV7+8=;
        b=W5QHJZydkWmp3XOlfJ+b9MMiwr+PJn9tvtRpTK06KFreIGhlpbxK0yVdoe6kj+YH/Fcoqv
        0q1gmYqcewg5zrj49pvOd8nezBZGYsa0eqoMjcHBlM0KIeFbtxUTnXLcadB3/Xm6MLPVUi
        I/TEaEuYpmWTsrF+76PnAvtH1sKnNqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-CJFeQu6rOV6pqP8K-ENKkg-1; Tue, 30 Jun 2020 03:55:44 -0400
X-MC-Unique: CJFeQu6rOV6pqP8K-ENKkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 198AF193F560;
        Tue, 30 Jun 2020 07:55:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42CFF74193;
        Tue, 30 Jun 2020 07:55:41 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org, ncroxon@redhat.com
Subject: [PATCH 1/2] super1.0 calculates max sectors in a wrong way
Date:   Tue, 30 Jun 2020 15:55:36 +0800
Message-Id: <1593503737-5067-2-git-send-email-xni@redhat.com>
In-Reply-To: <1593503737-5067-1-git-send-email-xni@redhat.com>
References: <1593503737-5067-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

One super1.0 raid array wants to grow size, it needs to check the device max usable
size. If the requested size is bigger than max usable size, it will return an error.

Now it uses rdev->sectors for max usable size. If one disk is 500G and the raid device
only uses the 100GB of this disk. rdev->sectors can't tell the real max usable size.
The max usable size should be dev_size-(superblock_size+bitmap_size+badblock_size).

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f53..d2c5984 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2183,10 +2183,30 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 		return 0;
 	} else {
 		/* minor version 0; superblock after data */
-		sector_t sb_start;
-		sb_start = (i_size_read(rdev->bdev->bd_inode) >> 9) - 8*2;
+		sector_t sb_start, bm_space;
+		sector_t dev_size = i_size_read(rdev->bdev->bd_inode) >> 9;
+
+		/* 8K is for superblock */
+		sb_start = dev_size - 8*2;
 		sb_start &= ~(sector_t)(4*2 - 1);
-		max_sectors = rdev->sectors + sb_start - rdev->sb_start;
+
+		/* if the device is bigger than 8Gig, save 64k for bitmap usage,
+		 * if bigger than 200Gig, save 128k
+		 */
+		if (dev_size < 64*2)
+			bm_space = 0;
+		else if (dev_size - 64*2 >= 200*1024*1024*2)
+			bm_space = 128*2;
+		else if (dev_size - 4*2 > 8*1024*1024*2)
+			bm_space = 64*2;
+		else
+			bm_space = 4*2;
+
+		/* Space that can be used to store date needs to decrease superblock
+		 * bitmap space and bad block space(4K)
+		 */
+		max_sectors = sb_start - bm_space - 4*2;
+
 		if (!num_sectors || num_sectors > max_sectors)
 			num_sectors = max_sectors;
 		rdev->sb_start = sb_start;
-- 
2.7.5

