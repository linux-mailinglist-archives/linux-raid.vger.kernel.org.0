Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8250B51BA22
	for <lists+linux-raid@lfdr.de>; Thu,  5 May 2022 10:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347299AbiEEIXh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 May 2022 04:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348234AbiEEIWT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 May 2022 04:22:19 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2084A3FC
        for <linux-raid@vger.kernel.org>; Thu,  5 May 2022 01:18:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651738697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqtuPsZiX8Fr8W6OciHlk/3WJYsM4U/NfkYPxDkEEUg=;
        b=CDozTWqudtAgSeM9gmzIWvyMg87q2c3jkr6FaOlovvZeKACZVYkU1fcwEAILHEL7z/jA2X
        5+zZHFJWjKPYR+OooKsp2HpJrTqthZXB995QOQCi9u5Af7jCMzToeFJuiKXry3Zqt6Sdhv
        K3A3Y8hqU4jhI1bmP/wSWoPpKUoXpo0=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     song@kernel.org
Cc:     buczek@molgen.mpg.de, linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: [PATCH 2/2] md: protect md_unregister_thread from reentrancy
Date:   Thu,  5 May 2022 16:16:41 +0800
Message-Id: <20220505081641.21500-3-guoqing.jiang@linux.dev>
In-Reply-To: <20220505081641.21500-1-guoqing.jiang@linux.dev>
References: <20220505081641.21500-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Generally, the md_unregister_thread is called with reconfig_mutex, but
raid_message in dm-raid doesn't hold reconfig_mutex to unregister thread,
so md_unregister_thread can be called simulitaneously from two call sites
in theory.

Then after previous commit which remove the protection of reconfig_mutex
for md_unregister_thread completely, the potential issue could be worse
than before.

Let's take pers_lock at the beginning of function to ensure reentrancy.

Reported-by: Donald Buczek <buczek@molgen.mpg.de>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/md/md.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a70e7f0f9268..c401e063bec8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7962,17 +7962,22 @@ EXPORT_SYMBOL(md_register_thread);
 
 void md_unregister_thread(struct md_thread **threadp)
 {
-	struct md_thread *thread = *threadp;
-	if (!thread)
-		return;
-	pr_debug("interrupting MD-thread pid %d\n", task_pid_nr(thread->tsk));
-	/* Locking ensures that mddev_unlock does not wake_up a
+	struct md_thread *thread;
+
+	/*
+	 * Locking ensures that mddev_unlock does not wake_up a
 	 * non-existent thread
 	 */
 	spin_lock(&pers_lock);
+	thread = *threadp;
+	if (!thread) {
+		spin_unlock(&pers_lock);
+		return;
+	}
 	*threadp = NULL;
 	spin_unlock(&pers_lock);
 
+	pr_debug("interrupting MD-thread pid %d\n", task_pid_nr(thread->tsk));
 	kthread_stop(thread->tsk);
 	kfree(thread);
 }
-- 
2.31.1

