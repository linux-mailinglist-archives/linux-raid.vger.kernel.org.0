Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEB4B376A
	for <lists+linux-raid@lfdr.de>; Mon, 16 Sep 2019 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfIPJpu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Sep 2019 05:45:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfIPJpu (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 16 Sep 2019 05:45:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34658C004E8D;
        Mon, 16 Sep 2019 09:45:50 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8F835D6A3;
        Mon, 16 Sep 2019 09:45:46 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     djeffery@redhat.com, ncroxon@redhat.com, heinzm@redhat.com,
        neilb@suse.de, songliubraving@fb.com
Subject: [PATCH 1/1] Call md_handle_request directly in md_flush_request
Date:   Mon, 16 Sep 2019 17:45:45 +0800
Message-Id: <1568627145-14210-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 16 Sep 2019 09:45:50 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

pers->make_request can fail sometimes. It can't handle the bio again
if pers->make_request fails. The bio can never return to upper layer
again. It should use md_handle_request to do this job.

Fixes: 2bc13b8 (md: batch flush requests.)
Suggested-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index daa885e..8ed19b4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -570,7 +570,7 @@ void md_flush_request(struct mddev *mddev, struct bio *bio)
 			bio_endio(bio);
 		else {
 			bio->bi_opf &= ~REQ_PREFLUSH;
-			mddev->pers->make_request(mddev, bio);
+			md_handle_request(mddev, bio);
 		}
 	}
 }
-- 
2.7.5

