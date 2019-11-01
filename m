Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC3EC48F
	for <lists+linux-raid@lfdr.de>; Fri,  1 Nov 2019 15:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKAOXM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 1 Nov 2019 10:23:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33240 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfKAOXM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 1 Nov 2019 10:23:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id c4so7702601edl.0
        for <linux-raid@vger.kernel.org>; Fri, 01 Nov 2019 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tREpfeYLO2THIsqAx91gzseKOxGFQjCO8MPJP0rPk+U=;
        b=FXJETWCppdno4+cQKDkpprVmr9nS9iSG2Hgz1NcOTQB0kH5o57vNuZu/104cpjF56F
         csaDV0dtNVkxgVtjYJC5wnW3KbjihR0PRlzkL45y/x6tQYyGxuJcUh++ymBWSxARaF9i
         0pLpug4MuEb/bksVAn3RFjadChGIeCnt5JYx2RRijdYdFpV32xYM1zd2PEgUOzPzmntY
         oeVVlTciHKq+wVSiyNwEB5PvcYpYbtg7325H1RU9aGzgyQ/JHNVo6TeEe8DNg0M7JNem
         K3pG93dcnhpfpJYzKkUKvH6AR9vSvVZgnzwNLF4W9PIv3RH72hWYBIVuUGQnAgIPYQ2o
         cxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tREpfeYLO2THIsqAx91gzseKOxGFQjCO8MPJP0rPk+U=;
        b=o2IfIaES9VAeqz8tqsbZ66B0fuVBfck27hjIH/gOSGZ08nXKuCbpzfJzEGtqSduw6L
         zNxBfAlCqLyY9R2xu25BgiFU28FnWSwIZMJaGfh5OCr48ionss3u7zr4cSQPnfPR4F5W
         8rK3BVNcUAD9aKcn2uYFBP0QvMCvBde8C1ITf0nomiDT20K37f15j5OXdcew3Y3FH9f7
         i9RiCf96WwUc1o98IVQNBb9xFnDjGnAc4GwFpWl75B1h0Xpp4R6AlaBeIFWi73h+fFTX
         U+fh2i2jBzyXOjD7kvmvTBkwRBgcoqOreM161MRMvPO68M5NdDHCqHbWRofj3jVdILY8
         CSlg==
X-Gm-Message-State: APjAAAViMRybBTFNJnjsLejFWHcVykfMJTN1hOxZopHq0DlvtA0+YWJI
        tVeI4OSYfadduy13QetpRrQ=
X-Google-Smtp-Source: APXvYqz+GlZmbyjhXIAJL/l8yWigfgOSWaJhWVghfyI7gnDPQ7HlHM76yORl9mFSdyXy8CO1ptRSfA==
X-Received: by 2002:a17:906:e2c2:: with SMTP id gr2mr9906137ejb.31.1572618190767;
        Fri, 01 Nov 2019 07:23:10 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f5aa:4cb:6cda:7f55])
        by smtp.gmail.com with ESMTPSA id u10sm179093eds.74.2019.11.01.07.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:23:09 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 3/8] md: add serialize_policy sysfs node for raid1
Date:   Fri,  1 Nov 2019 15:22:26 +0100
Message-Id: <20191101142231.23359-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

With the new sysfs node, we can use it to control if raid1 array
wants serialization for write request or not.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/md.h |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 43b7da334e4a..8df94a58512b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -174,6 +174,7 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		memalloc_noio_restore(noio_flag);
 		if (!mddev->serial_info_pool)
 			pr_err("can't alloc memory pool for writemostly\n");
+		mddev->serialize_policy = true;
 		if (!is_suspend)
 			mddev_resume(mddev);
 	}
@@ -216,6 +217,7 @@ static void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			mempool_destroy(mddev->serial_info_pool);
 			mddev->serial_info_pool = NULL;
 		}
+		mddev->serialize_policy = false;
 		mddev_resume(mddev);
 	}
 }
@@ -5261,6 +5263,49 @@ static struct md_sysfs_entry md_fail_last_dev =
 __ATTR(fail_last_dev, S_IRUGO | S_IWUSR, fail_last_dev_show,
        fail_last_dev_store);
 
+static ssize_t serialize_policy_show(struct mddev *mddev, char *page)
+{
+	return sprintf(page, "%d\n", mddev->serialize_policy);
+}
+
+/*
+ * Setting serialize_policy to true to enforce write IO is not reordered
+ * for raid1.
+ */
+static ssize_t
+serialize_policy_store(struct mddev *mddev, const char *buf, size_t len)
+{
+	int err;
+	bool value;
+
+	err = kstrtobool(buf, &value);
+	if (err || value == mddev->serialize_policy)
+		return err ?: -EINVAL;
+
+	err = mddev_lock(mddev);
+	if (err)
+		return err;
+	if (mddev->pers == NULL ||
+	    (strncmp(mddev->pers->name, "raid1", 4) != 0)) {
+		pr_err("md: serialize_policy is only effective for raid1\n");
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	if (value)
+		mddev_create_serial_pool(mddev, NULL, false, true);
+	else
+		mddev_destroy_serial_pool(mddev, NULL, true);
+unlock:
+	mddev_unlock(mddev);
+	return err ?: len;
+}
+
+static struct md_sysfs_entry md_serialize_policy =
+__ATTR(serialize_policy, S_IRUGO | S_IWUSR, serialize_policy_show,
+       serialize_policy_store);
+
+
 static struct attribute *md_default_attrs[] = {
 	&md_level.attr,
 	&md_layout.attr,
@@ -5278,6 +5323,7 @@ static struct attribute *md_default_attrs[] = {
 	&max_corr_read_errors.attr,
 	&md_consistency_policy.attr,
 	&md_fail_last_dev.attr,
+	&md_serialize_policy.attr,
 	NULL,
 };
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 291a59a94528..161772066dab 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -494,6 +494,7 @@ struct mddev {
 
 	bool	has_superblocks:1;
 	bool	fail_last_dev:1;
+	bool	serialize_policy:1;
 };
 
 enum recovery_flags {
-- 
2.17.1

