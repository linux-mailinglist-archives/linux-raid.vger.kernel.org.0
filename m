Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F21E1F10EF
	for <lists+linux-raid@lfdr.de>; Mon,  8 Jun 2020 02:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgFHA72 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 7 Jun 2020 20:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbgFHA6k (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 7 Jun 2020 20:58:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E260C08C5C3;
        Sun,  7 Jun 2020 17:58:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1ji67W-0000w0-Gy; Mon, 08 Jun 2020 02:58:34 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH v2 13/18] raid5: Use sequence counter with associated spinlock
Date:   Mon,  8 Jun 2020 02:57:24 +0200
Message-Id: <20200608005729.1874024-14-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608005729.1874024-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200608005729.1874024-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 drivers/md/raid5.c | 2 +-
 drivers/md/raid5.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ba00e9877f02..69f31c675b58 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6929,7 +6929,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	} else
 		goto abort;
 	spin_lock_init(&conf->device_lock);
-	seqcount_init(&conf->gen_lock);
+	seqcount_spinlock_init(&conf->gen_lock, &conf->device_lock);
 	mutex_init(&conf->cache_size_mutex);
 	init_waitqueue_head(&conf->wait_for_quiescent);
 	init_waitqueue_head(&conf->wait_for_stripe);
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index f90e0704bed9..a2c9e9e9f5ac 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -589,7 +589,7 @@ struct r5conf {
 	int			prev_chunk_sectors;
 	int			prev_algo;
 	short			generation; /* increments with every reshape */
-	seqcount_t		gen_lock;	/* lock against generation changes */
+	seqcount_spinlock_t	gen_lock;	/* lock against generation changes */
 	unsigned long		reshape_checkpoint; /* Time we last updated
 						     * metadata */
 	long long		min_offset_diff; /* minimum difference between
-- 
2.20.1

