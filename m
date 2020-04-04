Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5035119E7D8
	for <lists+linux-raid@lfdr.de>; Sun,  5 Apr 2020 00:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDDWBG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 4 Apr 2020 18:01:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43030 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDDWBF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 4 Apr 2020 18:01:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id bd14so13942374edb.10
        for <linux-raid@vger.kernel.org>; Sat, 04 Apr 2020 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NhYqtWW68dbY3NeScVdeQXGhl7pkX6GCjnxXTdSfnYY=;
        b=SaoP9cNTeZRe1+niQJva3Zv3Cidm7U2M9dVU4UxsWzYQFWyE4gyFJGQgDIOHu37mEd
         hkFU+0a77VV2kRqXFHuKI51DQuTue8yBhjWzjYxRQeOlxLlCG8kBEcnR4eIN9SgqIZWx
         j7h0/NOR5pH4U5/UcVp6+AQpAFE7UXCkw2rI4ADjW3JpklPiV1qK+kN6lXPz4FNBCmNi
         pZq8bGddyMCug6Bgb9KdE1muo96s3fOjjmPke9lFuRaYfXpB4IMw+hdjqEXVaTS2sEVf
         7ZSp+9p3hHg2ioOtMNqZw/7VQQ87Im4jGCtD18PzAdan6330j+2P1yM6vNA0vW3SqBai
         rWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NhYqtWW68dbY3NeScVdeQXGhl7pkX6GCjnxXTdSfnYY=;
        b=eODDVu/y+zQeIKaxHZMdXY/OJSM9CtAZmD/G+6Qtig8ZaZIF0CS6kpeTZAONtq/2kI
         YZyP2ncTDco0GNF+Hz8WCCA3+Cr60xE2J2KgiPKHvLZFrJhfLQMuK+1S1Xc/edK/PYoN
         2xF+kdssWnBfz9uouZLBP/P7kLHMdmDO4YPkYTUZBMLnjkXIi48RTeboCvtYR4bYKL1H
         TMGiNmcWcm1OU6hrukcntsB1iZgAgtuqRhvT24pxgtPTKjoqGU1PmSYC4nuOyBLZLzer
         rXLLLlOP9vIJ2uocyQXl/El3mdpyfdAOpnNmhYMZ2+Dn1YbIfiqQOTwdPoJIs1bhz55C
         XhJQ==
X-Gm-Message-State: AGi0PuYG/aUdG+gYXk7yTZpcFJbj529fDaZLi16BwzSpNai1e+SZPZu0
        zT2RoufcocJSVBUn6fvwpGPddg==
X-Google-Smtp-Source: APiQypJ1IGdDTL5GasH/tfQxtwGUS/acWw+GM300zM5hd7/v3KeHs5BzyNu1dhE3Dmo85PJvy0hwAQ==
X-Received: by 2002:a05:6402:1b10:: with SMTP id by16mr13827679edb.379.1586037662823;
        Sat, 04 Apr 2020 15:01:02 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:e120:c0df:e1ea:ba3e])
        by smtp.gmail.com with ESMTPSA id oe24sm1718549ejb.47.2020.04.04.15.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 15:01:02 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 1/5] md: add checkings before flush md_misc_wq
Date:   Sat,  4 Apr 2020 23:57:07 +0200
Message-Id: <20200404215711.4272-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
References: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Coly reported possible circular locking dependencyi with LOCKDEP enabled,
quote the below info from the detailed report [1].

[ 1607.673903] Chain exists of:
[ 1607.673903]   kn->count#256 --> (wq_completion)md_misc -->
(work_completion)(&rdev->del_work)
[ 1607.673903]
[ 1607.827946]  Possible unsafe locking scenario:
[ 1607.827946]
[ 1607.898780]        CPU0                    CPU1
[ 1607.952980]        ----                    ----
[ 1608.007173]   lock((work_completion)(&rdev->del_work));
[ 1608.069690]                                lock((wq_completion)md_misc);
[ 1608.149887]                                lock((work_completion)(&rdev->del_work));
[ 1608.242563]   lock(kn->count#256);
[ 1608.283238]
[ 1608.283238]  *** DEADLOCK ***
[ 1608.283238]
[ 1608.354078] 2 locks held by kworker/5:0/843:
[ 1608.405152]  #0: ffff8889eecc9948 ((wq_completion)md_misc){+.+.}, at:
process_one_work+0x42b/0xb30
[ 1608.512399]  #1: ffff888a1d3b7e10
((work_completion)(&rdev->del_work)){+.+.}, at: process_one_work+0x42b/0xb30
[ 1608.632130]

Since works (rdev->del_work and mddev->del_work) are queued in md_misc_wq,
then lockdep_map lock is held if either of them are running, then both of
them try to hold kernfs lock by call kobject_del. Then if new_dev_store
or array_state_store are triggered by write to the related sysfs node, so
the write operation gets kernfs lock, but need the lockdep_map because all
of them would trigger flush_workqueue(md_misc_wq) finally, then the same
lockdep_map lock is needed.

To suppress the lockdep warnning, we should flush the workqueue in case the
related work is pending. And several works are attached to md_misc_wq, so
we need to check which work should be checked:

1. for __md_stop_writes, the purpose of call flush workqueue is ensure sync
thread is started if it was starting, so check mddev->del_work is pending
or not since md_start_sync is attached to mddev->del_work.

2. __md_stop flushes md_misc_wq to ensure event_work is done, check the
event_work is enough. Assume raid_{ctr,dtr} -> md_stop -> __md_stop doesn't
need the kernfs lock.

3. both new_dev_store (holds kernfs lock) and ADD_NEW_DISK ioctl (holds the
bdev->bd_mutex) call flush_workqueue to ensure md_delayed_delete has
completed, this case will be handled in next patch.

4. md_open flushes workqueue to ensure the previous md is disappeared, but
it holds bdev->bd_mutex then try to flush workqueue, so it is better to
check mddev->del_work as well to avoid potential lock issue, this will be
done in another patch.

[1]: https://marc.info/?l=linux-raid&m=158518958031584&w=2

Cc: Coly Li <colyli@suse.de>
Reported-by: Coly Li <colyli@suse.de>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 469f551863be..2c23046fca57 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6146,7 +6146,8 @@ static void md_clean(struct mddev *mddev)
 static void __md_stop_writes(struct mddev *mddev)
 {
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	flush_workqueue(md_misc_wq);
+	if (work_pending(&mddev->del_work))
+		flush_workqueue(md_misc_wq);
 	if (mddev->sync_thread) {
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 		md_reap_sync_thread(mddev);
@@ -6199,7 +6200,8 @@ static void __md_stop(struct mddev *mddev)
 	md_bitmap_destroy(mddev);
 	mddev_detach(mddev);
 	/* Ensure ->event_work is done */
-	flush_workqueue(md_misc_wq);
+	if (mddev->event_work.func)
+		flush_workqueue(md_misc_wq);
 	spin_lock(&mddev->lock);
 	mddev->pers = NULL;
 	spin_unlock(&mddev->lock);
-- 
2.17.1

