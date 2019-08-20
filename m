Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5CF952BF
	for <lists+linux-raid@lfdr.de>; Tue, 20 Aug 2019 02:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfHTA0m (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 19 Aug 2019 20:26:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:49184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbfHTA0m (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 19 Aug 2019 20:26:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F2A9ABF4;
        Tue, 20 Aug 2019 00:26:41 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 20 Aug 2019 10:21:09 +1000
Subject: [PATCH 2/2] md: don't report active array_state until after
 revalidate_disk() completes.
Cc:     linux-raid@vger.kernel.org
Message-ID: <156626046966.15343.2000781542596751688.stgit@noble.brown>
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

Until revalidate_disk() has completed, the size of a new md array will
appear to be zero.
So we shouldn't report, through array_state, that the array is active
until that time.
udev rules check array_state to see if the array is ready.  As soon as
it appear to be zero, fsck can be run.  If it find the size to be
zero, it will fail.

So add a new flag to provide an interlock between do_md_run() and
array_state_show().  This flag is set while do_md_run() is active and
it prevents array_state_show() from reporting that the array is
active.

Before do_md_run() is called, ->pers will be NULL so array is
definitely not active.
After do_md_run() is called, revalidate_disk() will have run and the
array will be completely ready.

We also move various sysfs_notify*() calls out of md_run() into
do_md_run() after MD_NOT_READY is cleared.  This ensure the
information is ready before the notification is sent.

Prior to v4.12, array_state_show() was called with the
mddev->reconfig_mutex held, which provided exclusion with do_md_run().

Note that MD_NOT_READY cleared twice.  This is deliberate to cover
both success and error paths with minimal noise.

Fixes: b7b17c9b67e5 ("md: remove mddev_lock() from md_attr_show()")
Cc: stable@vger.kernel.org (v4.12++)
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/md/md.c |   11 +++++++----
 drivers/md/md.h |    3 +++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 624cf1ac43dc..1f70ec595282 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4176,7 +4176,7 @@ array_state_show(struct mddev *mddev, char *page)
 {
 	enum array_state st = inactive;
 
-	if (mddev->pers)
+	if (mddev->pers && !test_bit(MD_NOT_READY, &mddev->flags))
 		switch(mddev->ro) {
 		case 1:
 			st = readonly;
@@ -5744,9 +5744,6 @@ int md_run(struct mddev *mddev)
 		md_update_sb(mddev, 0);
 
 	md_new_event(mddev);
-	sysfs_notify_dirent_safe(mddev->sysfs_state);
-	sysfs_notify_dirent_safe(mddev->sysfs_action);
-	sysfs_notify(&mddev->kobj, NULL, "degraded");
 	return 0;
 
 bitmap_abort:
@@ -5767,6 +5764,7 @@ static int do_md_run(struct mddev *mddev)
 {
 	int err;
 
+	set_bit(MD_NOT_READY, &mddev->flags);
 	err = md_run(mddev);
 	if (err)
 		goto out;
@@ -5787,9 +5785,14 @@ static int do_md_run(struct mddev *mddev)
 
 	set_capacity(mddev->gendisk, mddev->array_sectors);
 	revalidate_disk(mddev->gendisk);
+	clear_bit(MD_NOT_READY, &mddev->flags);
 	mddev->changed = 1;
 	kobject_uevent(&disk_to_dev(mddev->gendisk)->kobj, KOBJ_CHANGE);
+	sysfs_notify_dirent_safe(mddev->sysfs_state);
+	sysfs_notify_dirent_safe(mddev->sysfs_action);
+	sysfs_notify(&mddev->kobj, NULL, "degraded");
 out:
+	clear_bit(MD_NOT_READY, &mddev->flags);
 	return err;
 }
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 10f98200e2f8..08f2aee383e8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -248,6 +248,9 @@ enum mddev_flags {
 	MD_UPDATING_SB,		/* md_check_recovery is updating the metadata
 				 * without explicitly holding reconfig_mutex.
 				 */
+	MD_NOT_READY,		/* do_md_run() is active, so 'array_state'
+				 * must not report that array is ready yet
+				 */
 };
 
 enum mddev_sb_flags {


