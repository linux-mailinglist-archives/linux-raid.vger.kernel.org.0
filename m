Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE71E6718F0
	for <lists+linux-raid@lfdr.de>; Wed, 18 Jan 2023 11:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjARK11 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 18 Jan 2023 05:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjARK0n (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 18 Jan 2023 05:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E4B66EE8
        for <linux-raid@vger.kernel.org>; Wed, 18 Jan 2023 01:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674034224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZEx3Yhvv9937WjmX53huBMrzAjzyFA6Pcehqt06IDLw=;
        b=fDWJdEvBR8NWOPddg+HfpkVuc2zoTrnOP7A2r1CQITsyILBbpJBZRj7UUmVCBnfkoGQwjr
        TABC5ip4G7z00hSdgs1Me1hpVwFi/S4ab956jGyjXAdRUjQuSCns0+RwXWu4d5vdAw4rNB
        tJxpTcXQ4Cw/CqUrB2Z662q+8URdzcI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-FP3-BEr5PnyoGYNEH390PQ-1; Wed, 18 Jan 2023 04:30:21 -0500
X-MC-Unique: FP3-BEr5PnyoGYNEH390PQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D8543C10694;
        Wed, 18 Jan 2023 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55C042166B29;
        Wed, 18 Jan 2023 09:30:17 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, ming.lei@redhat.com,
        ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH 2/4] Change active_io to percpu
Date:   Wed, 18 Jan 2023 17:30:06 +0800
Message-Id: <20230118093008.67170-3-xni@redhat.com>
In-Reply-To: <20230118093008.67170-1-xni@redhat.com>
References: <20230118093008.67170-1-xni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now the type of active_io is atomic. It's used to count how many ios are
in the submitting process and it's added and decreased very time. But it
only needs to check if it's zero when suspending the raid. So we can
switch atomic to percpu to improve the performance.

After switching to percpu, the raid device is suspended when active_io is
not in percpu mode. mddev->suspended is used to count how many users
are trying to set raid to suspend state.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c | 39 +++++++++++++++++++++++----------------
 drivers/md/md.h |  2 +-
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d3627aad981a..6558ab43f18b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -382,10 +382,7 @@ static DEFINE_SPINLOCK(all_mddevs_lock);
 
 static bool is_md_suspended(struct mddev *mddev)
 {
-	if (mddev->suspended)
-		return true;
-	else
-		return false;
+	return percpu_ref_is_dying(&mddev->active_io);
 }
 /* Rather than calling directly into the personality make_request function,
  * IO requests come here first so that we can check if the device is
@@ -412,7 +409,6 @@ static bool is_suspended(struct mddev *mddev, struct bio *bio)
 void md_handle_request(struct mddev *mddev, struct bio *bio)
 {
 check_suspended:
-	rcu_read_lock();
 	if (is_suspended(mddev, bio)) {
 		DEFINE_WAIT(__wait);
 		/* Bail out if REQ_NOWAIT is set for the bio */
@@ -432,17 +428,15 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
 		}
 		finish_wait(&mddev->sb_wait, &__wait);
 	}
-	atomic_inc(&mddev->active_io);
-	rcu_read_unlock();
+	if (!percpu_ref_tryget_live(&mddev->active_io))
+		goto check_suspended;
 
 	if (!mddev->pers->make_request(mddev, bio)) {
-		atomic_dec(&mddev->active_io);
-		wake_up(&mddev->sb_wait);
+		percpu_ref_put(&mddev->active_io);
 		goto check_suspended;
 	}
 
-	if (atomic_dec_and_test(&mddev->active_io) && is_md_suspended(mddev))
-		wake_up(&mddev->sb_wait);
+	percpu_ref_put(&mddev->active_io);
 }
 EXPORT_SYMBOL(md_handle_request);
 
@@ -488,11 +482,10 @@ void mddev_suspend(struct mddev *mddev)
 	lockdep_assert_held(&mddev->reconfig_mutex);
 	if (mddev->suspended++)
 		return;
-	synchronize_rcu();
 	wake_up(&mddev->sb_wait);
 	set_bit(MD_ALLOW_SB_UPDATE, &mddev->flags);
-	smp_mb__after_atomic();
-	wait_event(mddev->sb_wait, atomic_read(&mddev->active_io) == 0);
+	percpu_ref_kill(&mddev->active_io);
+	wait_event(mddev->sb_wait, percpu_ref_is_zero(&mddev->active_io));
 	mddev->pers->quiesce(mddev, 1);
 	clear_bit_unlock(MD_ALLOW_SB_UPDATE, &mddev->flags);
 	wait_event(mddev->sb_wait, !test_bit(MD_UPDATING_SB, &mddev->flags));
@@ -510,6 +503,7 @@ void mddev_resume(struct mddev *mddev)
 	lockdep_assert_held(&mddev->reconfig_mutex);
 	if (--mddev->suspended)
 		return;
+	percpu_ref_resurrect(&mddev->active_io);
 	wake_up(&mddev->sb_wait);
 	mddev->pers->quiesce(mddev, 0);
 
@@ -688,7 +682,6 @@ void mddev_init(struct mddev *mddev)
 	timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
 	atomic_set(&mddev->active, 1);
 	atomic_set(&mddev->openers, 0);
-	atomic_set(&mddev->active_io, 0);
 	spin_lock_init(&mddev->lock);
 	atomic_set(&mddev->flush_pending, 0);
 	init_waitqueue_head(&mddev->sb_wait);
@@ -5765,6 +5758,11 @@ static void md_safemode_timeout(struct timer_list *t)
 }
 
 static int start_dirty_degraded;
+static void active_io_release(struct percpu_ref *ref)
+{
+	struct mddev *mddev = container_of(ref, struct mddev, active_io);
+	wake_up(&mddev->sb_wait);
+}
 
 int md_run(struct mddev *mddev)
 {
@@ -5845,10 +5843,15 @@ int md_run(struct mddev *mddev)
 		nowait = nowait && bdev_nowait(rdev->bdev);
 	}
 
+	err = percpu_ref_init(&mddev->active_io, active_io_release,
+				PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
+	if (err)
+		return err;
+
 	if (!bioset_initialized(&mddev->bio_set)) {
 		err = bioset_init(&mddev->bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 		if (err)
-			return err;
+			goto exit_active_io;
 	}
 	if (!bioset_initialized(&mddev->sync_set)) {
 		err = bioset_init(&mddev->sync_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
@@ -6036,6 +6039,8 @@ int md_run(struct mddev *mddev)
 	bioset_exit(&mddev->sync_set);
 exit_bio_set:
 	bioset_exit(&mddev->bio_set);
+exit_active_io:
+	percpu_ref_exit(&mddev->active_io);
 	return err;
 }
 EXPORT_SYMBOL_GPL(md_run);
@@ -6260,6 +6265,7 @@ void md_stop(struct mddev *mddev)
 	 */
 	__md_stop_writes(mddev);
 	__md_stop(mddev);
+	percpu_ref_exit(&mddev->active_io);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
 }
@@ -7833,6 +7839,7 @@ static void md_free_disk(struct gendisk *disk)
 	struct mddev *mddev = disk->private_data;
 
 	percpu_ref_exit(&mddev->writes_pending);
+	percpu_ref_exit(&mddev->active_io);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 554a9026669a..6335cb86e52e 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -315,7 +315,7 @@ struct mddev {
 	unsigned long			sb_flags;
 
 	int				suspended;
-	atomic_t			active_io;
+	struct percpu_ref		active_io;
 	int				ro;
 	int				sysfs_active; /* set when sysfs deletes
 						       * are happening, so run/
-- 
2.32.0 (Apple Git-132)

