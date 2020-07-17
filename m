Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54FB223153
	for <lists+linux-raid@lfdr.de>; Fri, 17 Jul 2020 04:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGQCxB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 22:53:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57035 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726763AbgGQCxA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jul 2020 22:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594954379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=J97npQr3ocDoJMFk9rVBD7GZJN2AMOCCZDQbaXZG4I4=;
        b=ZtJ81I+cgmeEEfMhVHJIhGCpdf1QC7yie0LJFL+ANe+F2n0FpjbOi9lDupM0vY3Xhq0QDl
        DePF2/5YWSOAM7CPHC9xAZR2Mzq7/1d8EAL6BtmD4MUtIjd12ZUXoErAxIBpECwihGyf/T
        7i76CuVufPexJOwMjKvseg1VccOU8JQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-B93bt4OAO1iAXL27DkOggQ-1; Thu, 16 Jul 2020 22:52:57 -0400
X-MC-Unique: B93bt4OAO1iAXL27DkOggQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B45F78018A1;
        Fri, 17 Jul 2020 02:52:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BB4F75541;
        Fri, 17 Jul 2020 02:52:54 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org, linux-raid@vger.kernel.org
Subject: [PATCH RFC 2/3] extend r10bio devs to raid disks
Date:   Fri, 17 Jul 2020 10:52:47 +0800
Message-Id: <1594954368-5646-3-git-send-email-xni@redhat.com>
In-Reply-To: <1594954368-5646-1-git-send-email-xni@redhat.com>
References: <1594954368-5646-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now it allocs r10bio->devs[conf->copies]. Discard bio needs to submit to all member disks
and it needs to use r10bio. So extend to r10bio->devs[geo.raid_disks].

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

