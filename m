Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08802303C1
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgG1HSn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 03:18:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45584 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727858AbgG1HSm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 03:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595920721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=jxZwfzJ8KFZMe7ltclCE1D4/LysoHk3nWUZUYRjcbg8=;
        b=SHTut3Sp9xQw9PvGsPe3HxN65BlA7UOEXffFyoQsxCU05cVB2glZBWSPUyjyz6R13uDmFi
        QZvCwzZkLJ2gYw85Z9fgWh1jQ+EYcaLCDQTEOMvuE2pru8j5aIPp+BDiSa2HvxKx6XappQ
        DAyVKz9MgjlMMwz8uLpTZrejPJdua6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-wxB4Kk3vN0Wx0ormvf5Tsg-1; Tue, 28 Jul 2020 03:18:39 -0400
X-MC-Unique: wxB4Kk3vN0Wx0ormvf5Tsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 483FF107ACCA;
        Tue, 28 Jul 2020 07:18:38 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89EB879D1F;
        Tue, 28 Jul 2020 07:18:35 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org, linux-raid@vger.kernel.org
Cc:     colyli@suse.de, ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH V2 2/3] extend r10bio devs to raid disks
Date:   Tue, 28 Jul 2020 15:18:22 +0800
Message-Id: <1595920703-6125-3-git-send-email-xni@redhat.com>
In-Reply-To: <1595920703-6125-1-git-send-email-xni@redhat.com>
References: <1595920703-6125-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now it allocs r10bio->devs[conf->copies]. Discard bio needs to submit
to all member disks and it needs to use r10bio. So extend to
r10bio->devs[geo.raid_disks].

Reviewed-by: Coly Li <colyli@suse.de>
Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid10.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index e45fd56..2a7423e 100644
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
@@ -336,7 +336,7 @@ static int find_bio_disk(struct r10conf *conf, struct r10bio *r10_bio,
 		}
 	}
 
-	BUG_ON(slot == conf->copies);
+	BUG_ON(slot == conf->geo.raid_disks);
 	update_head_pos(slot, r10_bio);
 
 	if (slotp)
@@ -1510,7 +1510,7 @@ static void __make_request(struct mddev *mddev, struct bio *bio, int sectors)
 	r10_bio->mddev = mddev;
 	r10_bio->sector = bio->bi_iter.bi_sector;
 	r10_bio->state = 0;
-	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->copies);
+	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->geo.raid_disks);
 
 	if (bio_data_dir(bio) == READ)
 		raid10_read_request(mddev, bio, r10_bio);
-- 
2.7.5

