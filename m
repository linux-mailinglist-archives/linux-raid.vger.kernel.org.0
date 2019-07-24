Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61A0B72B27
	for <lists+linux-raid@lfdr.de>; Wed, 24 Jul 2019 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfGXJJu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 24 Jul 2019 05:09:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35318 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfGXJJt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 24 Jul 2019 05:09:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id w20so46425388edd.2
        for <linux-raid@vger.kernel.org>; Wed, 24 Jul 2019 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VGyYommcYUlsWylo8j5ydvMsnHSBeZ3YNr30whtL5g=;
        b=KfcqCVsrEmMdCn3fTMZHQ9U77uzGTCXuDkR58N39zVvDHt4cXqqLis/ufs4q4mTSlj
         2Fi+c/MDVwJPYhv84P2oij0UX3m+BMPxDOmjQQQHltN2ghzmxna06/7pbFBO/lcxhvXV
         MKiLaHNrjzPAJlz3y3cMieH/aVDK6vGVcT0dPX4WfNqBNn0QxBmdODi9RNG3rQEX8AYp
         4010qoKRml8OycCGJjHHoDBIZD/k3jamWSiol9qemBRXqegaKD19xnCfRil6QSS86dMe
         jAoTenfC+EaVNoljKmsRq5miQ+2kwL3QoITrIGSUHkNowmod0wd9IkTuIlEJTvaCuW08
         UQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8VGyYommcYUlsWylo8j5ydvMsnHSBeZ3YNr30whtL5g=;
        b=izssmUijme9qJGzekcHb7BaC8cOEBYNk4uHDeenMoPSsWcDg5tyRoDTH154qgi+wpM
         0bmLHhstKRbNcNYdbYnfKtksIf6P8pPu067+Xy9iH5KgNg/zCD+EeUhnIPdcumR8m8sz
         0WpWNW+ivof0iKnYp/XN+xWrlsubcZwMhsnIBrOfmNPIcO8DBfGYlOuFIQpqmK0BQx9p
         IoKe24aCEZnAbglJca2TQ4iRXsxgvIuhHK12TZ3NxKDQOOlqDtgmd7iWW9ekrZ5vQZsJ
         5gOMgRL/SJqI+M5xQHaoPCzFY46fN96AtMzIhH022FYTgU6OcvwET01Kv0NROxNVFDyR
         TERg==
X-Gm-Message-State: APjAAAXqr0/pradkXFNJU3jh2G4H7FboMRizALBi6DAMChuIUxR2lb2J
        /KGhZU+5xDDnHJgy+rxUFD4=
X-Google-Smtp-Source: APXvYqzI4nP+lc3i1ZL83ExH6IpIr+ijkbXBdumQ99vU9tY+ht0YumD8ye7NY6ngf3pyULKtwINvUA==
X-Received: by 2002:a17:906:f0cd:: with SMTP id dk13mr62087212ejb.84.1563959387398;
        Wed, 24 Jul 2019 02:09:47 -0700 (PDT)
Received: from nb01257.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id nw21sm3927709ejb.15.2019.07.24.02.09.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 02:09:46 -0700 (PDT)
From:   Guoqing Jiang <jgq516@gmail.com>
X-Google-Original-From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        NeilBrown <neilb@suse.de>
Subject: [PATCH 1/3] md: allow last device to be forcibly removed from RAID1/RAID10.
Date:   Wed, 24 Jul 2019 11:09:19 +0200
Message-Id: <20190724090921.13296-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
References: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When the 'last' device in a RAID1 or RAID10 reports an error,
we do not mark it as failed.  This would serve little purpose
as there is no risk of losing data beyond that which is obviously
lost (as there is with RAID5), and there could be other sectors
on the device which are readable, and only readable from this device.
This in general this maximises access to data.

However the current implementation also stops an admin from removing
the last device by direct action.  This is rarely useful, but in many
case is not harmful and can make automation easier by removing special
cases.

Also, if an attempt to write metadata fails the device must be marked
as faulty, else an infinite loop will result, attempting to update
the metadata on all non-faulty devices.

So add 'fail_last_dev' member to 'struct mddev', then we can bypasses
the 'last disk' checks for RAID1 and RAID10, and control the behavior
per array by change sysfs node.

Signed-off-by: NeilBrown <neilb@suse.de>
[add sysfs node for fail_last_dev by Guoqing]
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c     | 29 +++++++++++++++++++++++++++++
 drivers/md/md.h     |  1 +
 drivers/md/raid1.c  |  6 +++---
 drivers/md/raid10.c |  6 +++---
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24638ccedce4..0ced0933d246 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5182,6 +5182,34 @@ static struct md_sysfs_entry md_consistency_policy =
 __ATTR(consistency_policy, S_IRUGO | S_IWUSR, consistency_policy_show,
        consistency_policy_store);
 
+static ssize_t fail_last_dev_show(struct mddev *mddev, char *page)
+{
+	return sprintf(page, "%d\n", mddev->fail_last_dev);
+}
+
+/*
+ * Setting fail_last_dev to true to allow last device to be forcibly removed
+ * from RAID1/RAID10.
+ */
+static ssize_t
+fail_last_dev_store(struct mddev *mddev, const char *buf, size_t len)
+{
+	int ret;
+	bool value;
+
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+
+	if (value != mddev->fail_last_dev)
+		mddev->fail_last_dev = value;
+
+	return len;
+}
+static struct md_sysfs_entry md_fail_last_dev =
+__ATTR(fail_last_dev, S_IRUGO | S_IWUSR, fail_last_dev_show,
+       fail_last_dev_store);
+
 static struct attribute *md_default_attrs[] = {
 	&md_level.attr,
 	&md_layout.attr,
@@ -5198,6 +5226,7 @@ static struct attribute *md_default_attrs[] = {
 	&md_array_size.attr,
 	&max_corr_read_errors.attr,
 	&md_consistency_policy.attr,
+	&md_fail_last_dev.attr,
 	NULL,
 };
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 10f98200e2f8..b742659150a2 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -487,6 +487,7 @@ struct mddev {
 	unsigned int			good_device_nr;	/* good device num within cluster raid */
 
 	bool	has_superblocks:1;
+	bool	fail_last_dev:1;
 };
 
 enum recovery_flags {
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 34e26834ad28..3002fae943f7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1612,12 +1612,12 @@ static void raid1_error(struct mddev *mddev, struct md_rdev *rdev)
 
 	/*
 	 * If it is not operational, then we have already marked it as dead
-	 * else if it is the last working disks, ignore the error, let the
-	 * next level up know.
+	 * else if it is the last working disks with "fail_last_dev == false",
+	 * ignore the error, let the next level up know.
 	 * else mark the drive as failed
 	 */
 	spin_lock_irqsave(&conf->device_lock, flags);
-	if (test_bit(In_sync, &rdev->flags)
+	if (test_bit(In_sync, &rdev->flags) && !mddev->fail_last_dev
 	    && (conf->raid_disks - mddev->degraded) == 1) {
 		/*
 		 * Don't fail the drive, act as though we were just a
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 8a1354a08a1a..95ed41c050e4 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1638,12 +1638,12 @@ static void raid10_error(struct mddev *mddev, struct md_rdev *rdev)
 
 	/*
 	 * If it is not operational, then we have already marked it as dead
-	 * else if it is the last working disks, ignore the error, let the
-	 * next level up know.
+	 * else if it is the last working disks with "fail_last_dev == false",
+	 * ignore the error, let the next level up know.
 	 * else mark the drive as failed
 	 */
 	spin_lock_irqsave(&conf->device_lock, flags);
-	if (test_bit(In_sync, &rdev->flags)
+	if (test_bit(In_sync, &rdev->flags) && !mddev->fail_last_dev
 	    && !enough(conf, rdev->raid_disk)) {
 		/*
 		 * Don't fail the drive, just return an IO error.
-- 
2.17.1

