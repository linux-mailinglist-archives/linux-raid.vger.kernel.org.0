Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D7F6E2E0
	for <lists+linux-raid@lfdr.de>; Fri, 19 Jul 2019 10:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGSItY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Jul 2019 04:49:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfGSItY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 19 Jul 2019 04:49:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 365CD30C62A0;
        Fri, 19 Jul 2019 08:49:24 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C95B19D7E;
        Fri, 19 Jul 2019 08:49:18 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     artur.paszkiewicz@intel.com, jes.sorensen@gmail.com,
        ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH 1/1] bad block is after superblock and bitmap
Date:   Fri, 19 Jul 2019 16:49:16 +0800
Message-Id: <1563526156-17802-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 19 Jul 2019 08:49:24 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now it calculate bad block offset by bm_offset + bm_space. It should add sb_offset.

Fixes: 1b7eb672(super1: fix setting bad block log offset in write_init_super1())
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 super1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/super1.c b/super1.c
index b85dc20..682655a 100644
--- a/super1.c
+++ b/super1.c
@@ -2012,7 +2012,7 @@ static int write_init_super1(struct supertype *st)
 			sb->data_size = __cpu_to_le64(dsize - data_offset);
 			if (data_offset >= sb_offset+bm_offset+bm_space+8) {
 				sb->bblog_size = __cpu_to_le16(8);
-				sb->bblog_offset = __cpu_to_le32(bm_offset +
+				sb->bblog_offset = __cpu_to_le32(sb_offset + bm_offset +
 								 bm_space);
 			} else if (data_offset >= sb_offset + 16) {
 				sb->bblog_size = __cpu_to_le16(8);
-- 
2.7.5

