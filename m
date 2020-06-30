Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E420F1B1
	for <lists+linux-raid@lfdr.de>; Tue, 30 Jun 2020 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbgF3Jdr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jun 2020 05:33:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731023AbgF3Jdq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Jun 2020 05:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593509625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TeH/KjE2ras8/uNUZA9hpX013b+O2klms48sWmTt9uM=;
        b=bOvDlTnUr107LCnv1APtfQDpyvQmjCb+qJehAOB1RKQWw1opGrw61/2ogyk3zBCRzx57Un
        GUoKRsOSnTmI8mME1X2jQUoKcvWkipdI72rdyJh0o+RU0r6ffSHN5+ORWbaHUe4wR7p0Im
        LKfSKgghrCsdu0RHk/yDCqQEuQuUUy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-suHKUVjONb-uWBK6fSI0yw-1; Tue, 30 Jun 2020 05:33:41 -0400
X-MC-Unique: suHKUVjONb-uWBK6fSI0yw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D177018FF66E;
        Tue, 30 Jun 2020 09:33:40 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0021C19932;
        Tue, 30 Jun 2020 09:33:38 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, ncroxon@redhat.com
Subject: [PATCH 1/1] super1 block data_size should be member disk size
Date:   Tue, 30 Jun 2020 17:33:37 +0800
Message-Id: <1593509617-6305-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all

It's the patch I want to fix this problem. But I'm not sure I'm right or not. So this
is just for review. If it's right, I'll send the patch formally.

Test:
mdadm -CR /dev/md0 -l1 -n2 /dev/loop0 /dev/loop1 --size=1G (loop0 and loop1 are 8GB)
Result:
rdev->sectors(kernel space) will be 8GB, it's wrong. It should be 1GB-superblock-bitmap-badblock.

During creating super1.0/1.2 raid device, kernel space calls super_1_load, it sets rdev->sectors
with sb->data_size. If the raid device is created with specifying --size, it doesn't use total
space of disk. But rdev->sectors is still set with the total space of disk(decreasing superblock/bitmap/badblock)

So sb->data_size shoule be the raid member size rather than the total disk size.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 super1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/super1.c b/super1.c
index e0d80be..d5d022b 100644
--- a/super1.c
+++ b/super1.c
@@ -2029,7 +2029,7 @@ static int write_init_super1(struct supertype *st)
 			sb->super_offset = __cpu_to_le64(sb_offset);
 			if (sb_offset < array_size + bm_space)
 				bm_space = sb_offset - array_size;
-			sb->data_size = __cpu_to_le64(sb_offset - bm_space);
+			sb->data_size = __cpu_to_le64(array_size);
 			if (bm_space >= 8) {
 				sb->bblog_size = __cpu_to_le16(8);
 				sb->bblog_offset = __cpu_to_le32((unsigned)-8);
@@ -2043,7 +2043,7 @@ static int write_init_super1(struct supertype *st)
 				data_offset = sb_offset + 16;
 
 			sb->data_offset = __cpu_to_le64(data_offset);
-			sb->data_size = __cpu_to_le64(dsize - data_offset);
+			sb->data_size = __cpu_to_le64(array_size);
 			if (data_offset >= sb_offset+bm_offset+bm_space+8) {
 				sb->bblog_size = __cpu_to_le16(8);
 				sb->bblog_offset = __cpu_to_le32(bm_offset +
-- 
2.7.5

