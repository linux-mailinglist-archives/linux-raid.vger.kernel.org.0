Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0A55C780
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jun 2022 14:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiF0N4P (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Jun 2022 09:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiF0N4N (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 27 Jun 2022 09:56:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95842B1E5
        for <linux-raid@vger.kernel.org>; Mon, 27 Jun 2022 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656338171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ef5bxLSjOkhKAwh638F1gN0SMXoDq1o5NkFfN4YL/Cs=;
        b=GDJrKYsajltPU9P9hY9zs9gzPFCfBQSrli5MVvirCYOiXG0yl3aUhJUvMCx5fACh4Rv9qp
        YZ10rjpvzTAsWgmHX9NWCeXh0XOq+UUxezYovqWUULQlcaM+/S9RSa1C+1GSpe/ut7z31J
        NUOn9xakVgQJQ/dR5lY6U2R2sPm/at8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-0tp6m-VpOXyCGolU6HCljg-1; Mon, 27 Jun 2022 09:56:00 -0400
X-MC-Unique: 0tp6m-VpOXyCGolU6HCljg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D64A185A7A4;
        Mon, 27 Jun 2022 13:56:00 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 651F0492CA3;
        Mon, 27 Jun 2022 13:56:00 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 25RDu0Av016820;
        Mon, 27 Jun 2022 09:56:00 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 25RDu06O016816;
        Mon, 27 Jun 2022 09:56:00 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 27 Jun 2022 09:56:00 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Heinz Mauelshagen <heinzm@redhat.com>
cc:     Mike Snitzer <msnitzer@redhat.com>, Song Liu <song@kernel.org>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Marian Csontos <mcsontos@redhat.com>,
        Ming Lei <minlei@redhat.com>, dm-devel@redhat.com,
        linux-raid <linux-raid@vger.kernel.org>
Subject: [PATCH v2] dm-raid: fix out of memory accesses in dm-raid
In-Reply-To: <CAM23VxqOH9SeZFvfbFD2zUF_WFDUVY1Xh0ngp_1E+7n=7+7TUQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2206270954570.16147@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2206270858520.13562@file01.intranet.prod.int.rdu2.redhat.com> <CAM23VxqOH9SeZFvfbFD2zUF_WFDUVY1Xh0ngp_1E+7n=7+7TUQ@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

dm-raid allocates the array of devices with rs->raid_disks entries and
then accesses it in a loop for rs->md.raid_disks. During reshaping,
rs->md.raid_disks may be greater than rs->raid_disks, so it accesses
entries beyond the end of the array.

We fix this bug by limiting the iteration to rs->raid_disks.

The bug is triggered when running lvm test shell/lvconvert-raid.sh and the
kernel is compiled with kasan.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/md/dm-raid.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/md/dm-raid.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-raid.c	2022-06-27 15:44:12.000000000 +0200
+++ linux-2.6/drivers/md/dm-raid.c	2022-06-27 15:44:12.000000000 +0200
@@ -1004,7 +1004,7 @@ static int validate_raid_redundancy(stru
 	unsigned int rebuilds_per_group = 0, copies;
 	unsigned int group_size, last_group_start;
 
-	for (i = 0; i < rs->md.raid_disks; i++)
+	for (i = 0; i < rs->raid_disks; i++)
 		if (!test_bit(In_sync, &rs->dev[i].rdev.flags) ||
 		    !rs->dev[i].rdev.sb_page)
 			rebuild_cnt++;
@@ -1047,7 +1047,7 @@ static int validate_raid_redundancy(stru
 		 *	    C	 D    D	   E	E
 		 */
 		if (__is_raid10_near(rs->md.new_layout)) {
-			for (i = 0; i < rs->md.raid_disks; i++) {
+			for (i = 0; i < rs->raid_disks; i++) {
 				if (!(i % copies))
 					rebuilds_per_group = 0;
 				if ((!rs->dev[i].rdev.sb_page ||
@@ -1073,7 +1073,7 @@ static int validate_raid_redundancy(stru
 		group_size = (rs->md.raid_disks / copies);
 		last_group_start = (rs->md.raid_disks / group_size) - 1;
 		last_group_start *= group_size;
-		for (i = 0; i < rs->md.raid_disks; i++) {
+		for (i = 0; i < rs->raid_disks; i++) {
 			if (!(i % copies) && !(i > last_group_start))
 				rebuilds_per_group = 0;
 			if ((!rs->dev[i].rdev.sb_page ||
@@ -1588,7 +1588,7 @@ static sector_t __rdev_sectors(struct ra
 {
 	int i;
 
-	for (i = 0; i < rs->md.raid_disks; i++) {
+	for (i = 0; i < rs->raid_disks; i++) {
 		struct md_rdev *rdev = &rs->dev[i].rdev;
 
 		if (!test_bit(Journal, &rdev->flags) &&
@@ -3766,7 +3766,7 @@ static int raid_iterate_devices(struct d
 	unsigned int i;
 	int r = 0;
 
-	for (i = 0; !r && i < rs->md.raid_disks; i++)
+	for (i = 0; !r && i < rs->raid_disks; i++)
 		if (rs->dev[i].data_dev)
 			r = fn(ti,
 				 rs->dev[i].data_dev,
@@ -3817,7 +3817,7 @@ static void attempt_restore_of_faulty_de
 
 	memset(cleared_failed_devices, 0, sizeof(cleared_failed_devices));
 
-	for (i = 0; i < mddev->raid_disks; i++) {
+	for (i = 0; i < rs->raid_disks; i++) {
 		r = &rs->dev[i].rdev;
 		/* HM FIXME: enhance journal device recovery processing */
 		if (test_bit(Journal, &r->flags))

