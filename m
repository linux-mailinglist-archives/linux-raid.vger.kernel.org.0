Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF455952BE
	for <lists+linux-raid@lfdr.de>; Tue, 20 Aug 2019 02:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfHTA0g (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 19 Aug 2019 20:26:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:49172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbfHTA0g (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 19 Aug 2019 20:26:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88CB2ABF4;
        Tue, 20 Aug 2019 00:26:35 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 20 Aug 2019 10:21:09 +1000
Subject: [PATCH 1/2] md: only call set_in_sync() when it is expected to
 succeed.
Cc:     linux-raid@vger.kernel.org, Jack Wang <jinpu.wang@cloud.ionos.com>
Message-ID: <156626046961.15343.7213118215003724843.stgit@noble.brown>
In-Reply-To: <156626036792.15343.14564114570071245486.stgit@noble.brown>
References: <156626036792.15343.14564114570071245486.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Since commit 4ad23a976413 ("MD: use per-cpu counter for
writes_pending"), set_in_sync() is substantially more expensive: it
can wait for a full RCU grace period which can be 10s of milliseconds.

So we should only call it when the cost is justified.

md_check_recovery() currently calls set_in_sync() every time it finds
anything to do (on non-external active arrays).  For an array
performing resync or recovery, this will be quite often.
Each call will introduce a delay to the md thread, which can noticeable
affect IO submission latency.

In md_check_recovery() we only need to call set_in_sync() if
'safemode' was non-zero at entry, meaning that there has been not
recent IO.  So we save this "safemode was nonzero" state, and only
call set_in_sync() if it was non-zero.

This measurably reduces mean and maximum IO submission latency during
resync/recovery.

Reported-and-tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Fixes: 4ad23a976413 ("MD: use per-cpu counter for writes_pending")
Cc: stable@vger.kernel.org (v4.12+)
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/md/md.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24638ccedce4..624cf1ac43dc 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8900,6 +8900,7 @@ void md_check_recovery(struct mddev *mddev)
 
 	if (mddev_trylock(mddev)) {
 		int spares = 0;
+		bool try_set_sync = mddev->safemode != 0;
 
 		if (!mddev->external && mddev->safemode == 1)
 			mddev->safemode = 0;
@@ -8945,7 +8946,7 @@ void md_check_recovery(struct mddev *mddev)
 			}
 		}
 
-		if (!mddev->external && !mddev->in_sync) {
+		if (try_set_sync && !mddev->external && !mddev->in_sync) {
 			spin_lock(&mddev->lock);
 			set_in_sync(mddev);
 			spin_unlock(&mddev->lock);


