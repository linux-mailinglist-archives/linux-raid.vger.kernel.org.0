Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B854183239
	for <lists+linux-raid@lfdr.de>; Tue,  6 Aug 2019 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfHFNGJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 6 Aug 2019 09:06:09 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:35395 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfHFNGJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 6 Aug 2019 09:06:09 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 722BB4404F8;
        Tue,  6 Aug 2019 16:06:05 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Jes Sorensen <jsorensen@fb.com>
Cc:     linux-raid@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] mdadm.h: include sysmacros.h unconditionally
Date:   Tue,  6 Aug 2019 16:05:23 +0300
Message-Id: <6c781ad75d92c6f65832810c44afcba1b2dffc41.1565096723.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

musl libc now also requires sys/sysmacros.h for the major/minor macros.
All supported libc implementations carry sys/sysmacros.h, including
diet-libc, klibc, and uclibc-ng.

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 mdadm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mdadm.h b/mdadm.h
index c36d7fdb10f6..d61a9ca82dc1 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -45,10 +45,8 @@ extern __off64_t lseek64 __P ((int __fd, __off64_t __offset, int __whence));
 #include	<errno.h>
 #include	<string.h>
 #include	<syslog.h>
-#ifdef __GLIBC__
 /* Newer glibc requires sys/sysmacros.h directly for makedev() */
 #include	<sys/sysmacros.h>
-#endif
 #ifdef __dietlibc__
 #include	<strings.h>
 /* dietlibc has deprecated random and srandom!! */
-- 
2.20.1

