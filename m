Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06229127372
	for <lists+linux-raid@lfdr.de>; Fri, 20 Dec 2019 03:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLTCVy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Dec 2019 21:21:54 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:39804 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLTCVx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Dec 2019 21:21:53 -0500
X-QQ-mid: bizesmtp24t1576808496t2bhqham
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 20 Dec 2019 10:21:28 +0800 (CST)
X-QQ-SSF: 00400000002000I0ZH40B00A0000000
X-QQ-FEAT: 3fDsO+rzVm64Cx2A3JWcfzndxjiQqpn66pvtA5WXXr3r1wJb1MkQn2S0KZWjd
        1vT/2Z9qS+c4+5QCSfLZUOtKYr1q479FnWU8L6DAj3TT7hAgYOqilwbOTcAZ4Yt67sPWHG8
        eK/fpr7Qt5vNNJnYRpA7RqAWbaQH1j9ZuygigGVhR76dJFpTnbj3RfSLZrhPx2IXkAncLcU
        6zZWCzWGElsujYlMhzBWC6et8oEJNR0RXImeH+QKt7wrr2VlSSDcJ3DYu2PPhMvxtzgCLLi
        vpbAzLmyZip6dqv4eVg8yJBDzs6Mn9ZJVLxiyQxmS3xjCHr1NLarDDQ5UShZI+TioyU4si7
        wT3kCGpCLs1T45vKy4=
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     liu.song.a23@gmail.com, hpa@zytor.com
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH v4 1/3] raid6/test: fix a compilation error
Date:   Fri, 20 Dec 2019 10:21:26 +0800
Message-Id: <20191220022128.23296-1-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The compilation error is redeclaration showed as following:

        In file included from ../../../include/linux/limits.h:6,
                         from /usr/include/x86_64-linux-gnu/bits/local_lim.h:38,
                         from /usr/include/x86_64-linux-gnu/bits/posix1_lim.h:161,
                         from /usr/include/limits.h:183,
                         from /usr/lib/gcc/x86_64-linux-gnu/8/include-fixed/limits.h:194,
                         from /usr/lib/gcc/x86_64-linux-gnu/8/include-fixed/syslimits.h:7,
                         from /usr/lib/gcc/x86_64-linux-gnu/8/include-fixed/limits.h:34,
                         from ../../../include/linux/raid/pq.h:30,
                         from algos.c:14:
        ../../../include/linux/types.h:114:15: error: conflicting types for ‘int64_t’
         typedef s64   int64_t;
                       ^~~~~~~
        In file included from /usr/include/stdint.h:34,
                         from /usr/lib/gcc/x86_64-linux-gnu/8/include/stdint.h:9,
                         from /usr/include/inttypes.h:27,
                         from ../../../include/linux/raid/pq.h:29,
                         from algos.c:14:
        /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous \
        declaration of ‘int64_t’ was here
         typedef __int64_t int64_t;

Fixes: 54d50897d544 ("linux/kernel.h: split *_MAX and *_MIN macros into <linux/limits.h>")
Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 include/linux/raid/pq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index 0832c9b66852..0b6e7ad9cd2a 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -27,7 +27,6 @@ extern const char raid6_empty_zero_page[PAGE_SIZE];
 
 #include <errno.h>
 #include <inttypes.h>
-#include <limits.h>
 #include <stddef.h>
 #include <sys/mman.h>
 #include <sys/time.h>
-- 
2.20.1



