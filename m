Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6C6837F
	for <lists+linux-raid@lfdr.de>; Mon, 15 Jul 2019 08:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfGOGTb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 15 Jul 2019 02:19:31 -0400
Received: from mail5.windriver.com ([192.103.53.11]:52212 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfGOGTb (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 15 Jul 2019 02:19:31 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x6F6Itm6002412
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-raid@vger.kernel.org>; Sun, 14 Jul 2019 23:19:20 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Sun, 14 Jul 2019 23:18:59 -0700
From:   <mingli.yu@windriver.com>
To:     <linux-raid@vger.kernel.org>
Subject: [PATCH] Revert "tests: wait for complete rebuild in integrity checks"
Date:   Mon, 15 Jul 2019 14:18:58 +0800
Message-ID: <1563171538-127463-1-git-send-email-mingli.yu@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Mingli Yu <Mingli.Yu@windriver.com>

This reverts commit e2a8e9dcf67a28bc722fa5ab2c49b0bc452d4d74
as the logic "check state 'U*'" will make the test enters
infinite loop especially in qemu env, so revert it to
use the previous logic "check wait" which also used
commonly by other tests such as tests/02r5grow, tests/07revert-grow
and etc.
---
 tests/01r5integ    | 2 +-
 tests/01raid6integ | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/01r5integ b/tests/01r5integ
index 48676a2..ffb30ce 100644
--- a/tests/01r5integ
+++ b/tests/01r5integ
@@ -27,7 +27,7 @@ do
      exit 1
     fi
     mdadm $md0 -a $i
-    while ! (check state 'U*'); do check wait; sleep 0.2; done
+   check wait
   done
   mdadm -S $md0
 done
diff --git a/tests/01raid6integ b/tests/01raid6integ
index 12f4d81..c6fcdae 100644
--- a/tests/01raid6integ
+++ b/tests/01raid6integ
@@ -47,10 +47,10 @@ do
          exit 1
        fi
        mdadm $md0 -a $first
-       while ! (check state 'U*_U*'); do check wait; sleep 0.2; done
+       check wait
     done
     mdadm $md0 -a $second
-    while ! (check state 'U*'); do check wait; sleep 0.2; done
+    check wait
     totest="$totest $second"
   done
   mdadm -S $md0
-- 
2.7.4

