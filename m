Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B704114D06C
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jan 2020 19:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgA2SYr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 Jan 2020 13:24:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:45752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgA2SYr (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 29 Jan 2020 13:24:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F52DAECB;
        Wed, 29 Jan 2020 18:24:45 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] md: optimize barrier usage for Rmw atomic bitops
Date:   Wed, 29 Jan 2020 10:14:37 -0800
Message-Id: <20200129181437.25155-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

For both set and clear_bit, we can avoid the unnecessary barrier
on non LL/SC architectures, such as x86. Instead, use the
smp_mb__{before,after}_atomic() calls.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/md/md.c     | 2 +-
 drivers/md/raid10.c | 7 ++++---
 drivers/md/raid5.c  | 9 +++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4824d50526fa..4ed2eb6933f7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2561,7 +2561,7 @@ static bool set_in_sync(struct mddev *mddev)
 			 * Ensure ->in_sync is visible before we clear
 			 * ->sync_checkers.
 			 */
-			smp_mb();
+			smp_mb__before_atomic();
 			set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
 			sysfs_notify_dirent_safe(mddev->sysfs_state);
 		}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index ec136e44aef7..1993a1958c75 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1865,9 +1865,10 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 		/* We must have just cleared 'rdev' */
 		p->rdev = p->replacement;
 		clear_bit(Replacement, &p->replacement->flags);
-		smp_mb(); /* Make sure other CPUs may see both as identical
-			   * but will never see neither -- if they are careful.
-			   */
+		/* Make sure other CPUs may see both as identical
+		 * but will never see neither -- if they are careful.
+		 */
+		smp_mb__after_atomic();
 		p->replacement = NULL;
 	}
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ba00e9877f02..3ad6209287cf 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -364,7 +364,7 @@ static int release_stripe_list(struct r5conf *conf,
 		int hash;
 
 		/* sh could be readded after STRIPE_ON_RELEASE_LIST is cleard */
-		smp_mb();
+		smp_mb__before_atomic();
 		clear_bit(STRIPE_ON_RELEASE_LIST, &sh->state);
 		/*
 		 * Don't worry the bit is set here, because if the bit is set
@@ -7654,9 +7654,10 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 		/* We must have just cleared 'rdev' */
 		p->rdev = p->replacement;
 		clear_bit(Replacement, &p->replacement->flags);
-		smp_mb(); /* Make sure other CPUs may see both as identical
-			   * but will never see neither - if they are careful
-			   */
+		/* Make sure other CPUs may see both as identical
+		 * but will never see neither - if they are careful
+		 */
+		smp_mb__after_atomic();
 		p->replacement = NULL;
 
 		if (!err)
-- 
2.16.4

