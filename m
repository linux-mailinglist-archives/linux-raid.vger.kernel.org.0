Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDC830DBA9
	for <lists+linux-raid@lfdr.de>; Wed,  3 Feb 2021 14:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhBCNrV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 3 Feb 2021 08:47:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232353AbhBCNrQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 3 Feb 2021 08:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612359949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ZMQikjLk9eFY7bt3SQeKTK8nWHqnlSURlfANQbf/AP0=;
        b=Nrs4ShfNNBiYMW3CB9746I4mFg0uzLoJnlHtXX3MoI+LMQaUkoaJu0JjYE8UckDDpk83HN
        88WHXc04dZCUqfg2TirxvmFoRWN0YKfLpqwcXJvVdd82IoGq0uahwro1BiK8kafaPiG13Q
        qBdRTvKI5TMZcOMw9U966q4fvCVzDZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-musKnC2aPOq_5WeiaS2Ylg-1; Wed, 03 Feb 2021 08:45:47 -0500
X-MC-Unique: musKnC2aPOq_5WeiaS2Ylg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D55F19611A0;
        Wed,  3 Feb 2021 13:45:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44FBA3828;
        Wed,  3 Feb 2021 13:45:42 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org, matthew.ruffell@canonical.com,
        colyli@suse.de, guoqing.jiang@cloud.ionos.com, ncroxon@redhat.com
Subject: [PATCH 2/5] md/raid10: extend r10bio devs to raid disks
Date:   Wed,  3 Feb 2021 21:45:28 +0800
Message-Id: <1612359931-24209-3-git-send-email-xni@redhat.com>
In-Reply-To: <1612359931-24209-1-git-send-email-xni@redhat.com>
References: <1612359931-24209-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now it allocs r10bio->devs[conf->copies]. Discard bio needs to submit
to all member disks and it needs to use r10bio. So extend to
r10bio->devs[geo.raid_disks].

Reviewed-by: Coly Li <colyli@suse.de>
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid10.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index be8f14a..891b249 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -91,7 +91,7 @@ static inline struct r10bio *get_resync_r10bio(struct bio *bio)
 static void * r10bio_pool_alloc(gfp_t gfp_flags, void *data)
 {
 	struct r10conf *conf = data;
-	int size = offsetof(struct r10bio, devs[conf->copies]);
+	int size = offsetof(struct r10bio, devs[conf->geo.raid_disks]);
 
 	/* allocate a r10bio with room for raid_disks entries in the
 	 * bios array */
@@ -238,7 +238,7 @@ static void put_all_bios(struct r10conf *conf, struct r10bio *r10_bio)
 {
 	int i;
 
-	for (i = 0; i < conf->copies; i++) {
+	for (i = 0; i < conf->geo.raid_disks; i++) {
 		struct bio **bio = & r10_bio->devs[i].bio;
 		if (!BIO_SPECIAL(*bio))
 			bio_put(*bio);
@@ -327,7 +327,7 @@ static int find_bio_disk(struct r10conf *conf, struct r10bio *r10_bio,
 	int slot;
 	int repl = 0;
 
-	for (slot = 0; slot < conf->copies; slot++) {
+	for (slot = 0; slot < conf->geo.raid_disks; slot++) {
 		if (r10_bio->devs[slot].bio == bio)
 			break;
 		if (r10_bio->devs[slot].repl_bio == bio) {
@@ -336,7 +336,6 @@ static int find_bio_disk(struct r10conf *conf, struct r10bio *r10_bio,
 		}
 	}
 
-	BUG_ON(slot == conf->copies);
 	update_head_pos(slot, r10_bio);
 
 	if (slotp)
@@ -1492,7 +1491,7 @@ static void __make_request(struct mddev *mddev, struct bio *bio, int sectors)
 	r10_bio->sector = bio->bi_iter.bi_sector;
 	r10_bio->state = 0;
 	r10_bio->read_slot = -1;
-	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->copies);
+	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->geo.raid_disks);
 
 	if (bio_data_dir(bio) == READ)
 		raid10_read_request(mddev, bio, r10_bio);
-- 
2.7.5

