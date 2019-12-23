Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFA01293C0
	for <lists+linux-raid@lfdr.de>; Mon, 23 Dec 2019 10:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLWJtP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Dec 2019 04:49:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36301 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfLWJtO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Dec 2019 04:49:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so14785901edp.3
        for <linux-raid@vger.kernel.org>; Mon, 23 Dec 2019 01:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bjRpyldG0wSdBHNZlEMrV3XhFKeY991XOd5mtKsJ5Og=;
        b=Vdptm2uwRHleZdLH9h3ZK6BdCiIhB53IHA2na8ioyTtNuNxWfTHRNLv12h1E1vGdb2
         KAFS9qaudxqG55RfnOPR60gZkpPC9aQTuAi11z0wCpRn22w1fSKli97iAunvUCoYhvvq
         qrDngF1LgesBakKDIxR3o21GydJVMfKlMT+8xQUvvvYeRMJ+pMzK41S+bSi7sIzWBB5w
         E1MXujm+bSdzwmWi5g50b6Uot2Ns9bkyDE3+FP6xuj05RNhL3KVpVjLWLiGXQqEE8YHj
         2OM3zUxd7lTgyiHAoUd61bV5N/xKRzksxgqhm1XY4UyuXjrqA/1yn3El8lJNRcT/0+Bm
         A3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bjRpyldG0wSdBHNZlEMrV3XhFKeY991XOd5mtKsJ5Og=;
        b=kDDUriyoTht2tNiyJZ6BhNABm+wnGoqbG8+C2k+Io/KFJHNIWRtSHPL64UoPXgmF9p
         5CGejomvoC1kNBHalCv4HbRRZ9uY0d0ULVmmc8Ew+PI4oYDD3kTHKuSBD7zKHP6bvd7z
         yo0NWcnEtrxXOCRkXo8VkedKg1Fq/j7yb+Us8yDBRpvT4864Fq9kCIuEQYHsuHXF7Tr7
         LsZWP5RP6CG28B1+CJ+Mj7Uhe7O9t233Iqt9nY+Gzjvkx/aXzNsftkzzTVyXaZeM0al5
         OTyRPUZpxPXvDgS5IWFXa/JuAX+FvQHI27v7+bsHVIOfcZ/U7i+rmWKG0u9R6Khu13Gc
         DeWA==
X-Gm-Message-State: APjAAAVyjb/3spfKsE1DkFaY0D9z6Mj4+EiHnRjD2ncDj2BHyhAiezVu
        cUX311qvEskfqUxG8kTIIaM=
X-Google-Smtp-Source: APXvYqwBu3NS3B6mgC+xD1Oy7Hw7NYprYpoG+TgmaI9ARsJz19/W5QH7pcFVBCR26MltF8hLZ1nBmg==
X-Received: by 2002:a17:907:2071:: with SMTP id qp17mr31488528ejb.176.1577094552798;
        Mon, 23 Dec 2019 01:49:12 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a04e:c36f:204b:a84d])
        by smtp.gmail.com with ESMTPSA id b13sm1059461ejl.5.2019.12.23.01.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:49:12 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 04/10] md: add serialize_policy sysfs node for raid1
Date:   Mon, 23 Dec 2019 10:48:56 +0100
Message-Id: <20191223094902.12704-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

With the new sysfs node, we can use it to control if raid1 array
wants io serialization or not. So mddev_create_serial_pool and
mddev_destroy_serial_pool are called in serialize_policy_store
to enable or disable the serialization.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/md.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index b9b041b7e196..796cf70e1c9f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5304,6 +5304,57 @@ static struct md_sysfs_entry md_fail_last_dev =
 __ATTR(fail_last_dev, S_IRUGO | S_IWUSR, fail_last_dev_show,
        fail_last_dev_store);
 
+static ssize_t serialize_policy_show(struct mddev *mddev, char *page)
+{
+	if (mddev->pers == NULL || (mddev->pers->level != 1))
+		return sprintf(page, "n/a\n");
+	else
+		return sprintf(page, "%d\n", mddev->serialize_policy);
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
+	if (err)
+		return err;
+
+	if (value == mddev->serialize_policy)
+		return len;
+
+	err = mddev_lock(mddev);
+	if (err)
+		return err;
+	if (mddev->pers == NULL || (mddev->pers->level != 1)) {
+		pr_err("md: serialize_policy is only effective for raid1\n");
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	mddev_suspend(mddev);
+	if (value)
+		mddev_create_serial_pool(mddev, NULL, true);
+	else
+		mddev_destroy_serial_pool(mddev, NULL, true);
+	mddev->serialize_policy = value;
+	mddev_resume(mddev);
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
@@ -5321,6 +5372,7 @@ static struct attribute *md_default_attrs[] = {
 	&max_corr_read_errors.attr,
 	&md_consistency_policy.attr,
 	&md_fail_last_dev.attr,
+	&md_serialize_policy.attr,
 	NULL,
 };
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index de04a8d3a67a..f51a3afaee1b 100644
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

