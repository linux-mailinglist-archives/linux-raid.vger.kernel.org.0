Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34DD3EF806
	for <lists+linux-raid@lfdr.de>; Wed, 18 Aug 2021 04:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhHRCTl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Aug 2021 22:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235026AbhHRCTj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 17 Aug 2021 22:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629253144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=UvTZrEfKvhRt84IX1KuCxKa9m1EnHLjwLbvgXNqwtsU=;
        b=NBMF0priY5wzZtp3uH38t7JD/7rFtjwsDl1+dVy+NgQSFt4Fm3OoEfW/U66uMcSuNw6Ncg
        zNVXXZV4uEWeMbJ+yKe5yo0m3X/o2ycX+7TshWchkuYyCWELNcTN/xZkyb06OqKWcKkEog
        o13yMoJoiuQCpqyEI1uk3e4PWW+f6oY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-hXkswEQiOauvNa0YGjo3bw-1; Tue, 17 Aug 2021 22:19:03 -0400
X-MC-Unique: hXkswEQiOauvNa0YGjo3bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 880E26409B;
        Wed, 18 Aug 2021 02:19:02 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3985D19C87;
        Wed, 18 Aug 2021 02:18:59 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org
Cc:     ncroxon@redhat.com, linux-raid@vger.kernel.org,
        guoqing.jiang@linux.dev
Subject: [PATCH v2 1/1] md/raid10: Remove rcu_dereference when it doesn't need rcu lock to protect
Date:   Wed, 18 Aug 2021 10:18:57 +0800
Message-Id: <1629253137-5571-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

One warning message is triggered like this:
[  695.110751] =============================
[  695.131439] WARNING: suspicious RCU usage
[  695.151389] 4.18.0-319.el8.x86_64+debug #1 Not tainted
[  695.174413] -----------------------------
[  695.192603] drivers/md/raid10.c:1776 suspicious
rcu_dereference_check() usage!
[  695.225107] other info that might help us debug this:
[  695.260940] rcu_scheduler_active = 2, debug_locks = 1
[  695.290157] no locks held by mkfs.xfs/10186.

In the first loop of function raid10_handle_discard. It already
determines which disk need to handle discard request and add the
rdev reference count rdev->nr_pending. So the conf->mirrors will
not change until all bios come back from underlayer disks. It
doesn't need to use rcu_dereference to get rdev.

V2: Fix comment style problem

Fixes: d30588b2731f ('md/raid10: improve raid10 discard request')
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid10.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 16977e8..d5d9233 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1712,6 +1712,11 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	} else
 		r10_bio->master_bio = (struct bio *)first_r10bio;
 
+	/*
+	 * first select target devices under rcu_lock and
+	 * inc refcount on their rdev.  Record them by setting
+	 * bios[x] to bio
+	 */
 	rcu_read_lock();
 	for (disk = 0; disk < geo->raid_disks; disk++) {
 		struct md_rdev *rdev = rcu_dereference(conf->mirrors[disk].rdev);
@@ -1743,9 +1748,6 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	for (disk = 0; disk < geo->raid_disks; disk++) {
 		sector_t dev_start, dev_end;
 		struct bio *mbio, *rbio = NULL;
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[disk].rdev);
-		struct md_rdev *rrdev = rcu_dereference(
-			conf->mirrors[disk].replacement);
 
 		/*
 		 * Now start to calculate the start and end address for each disk.
@@ -1775,9 +1777,12 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 
 		/*
 		 * It only handles discard bio which size is >= stripe size, so
-		 * dev_end > dev_start all the time
+		 * dev_end > dev_start all the time.
+		 * It doesn't need to use rcu lock to get rdev here. We already
+		 * add rdev->nr_pending in the first loop.
 		 */
 		if (r10_bio->devs[disk].bio) {
+			struct md_rdev *rdev = conf->mirrors[disk].rdev;
 			mbio = bio_clone_fast(bio, GFP_NOIO, &mddev->bio_set);
 			mbio->bi_end_io = raid10_end_discard_request;
 			mbio->bi_private = r10_bio;
@@ -1790,6 +1795,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 			bio_endio(mbio);
 		}
 		if (r10_bio->devs[disk].repl_bio) {
+			struct md_rdev *rrdev = conf->mirrors[disk].replacement;
 			rbio = bio_clone_fast(bio, GFP_NOIO, &mddev->bio_set);
 			rbio->bi_end_io = raid10_end_discard_request;
 			rbio->bi_private = r10_bio;
-- 
2.7.5

