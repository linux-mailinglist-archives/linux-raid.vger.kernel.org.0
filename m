Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B718A1050A6
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 11:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUKhr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 05:37:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40091 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfKUKho (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 05:37:44 -0500
Received: by mail-ed1-f66.google.com with SMTP id p59so2340482edp.7
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 02:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yYlD41kX5tD8EAaTT3esLkO/n/4PggG3tqAvjPP7PN0=;
        b=jvblJYyLTWTXzrYwH1ZlCkCubVcPMS08OB9m4DkvupPs/PzRWxLBmoKU72lisSSe5p
         LSTYjX3LshFKwOVDr03/c4FUuIoBnAhdPTbJMaYVpNfKxbGPJlxFOUtzLHvrzvxjKBDz
         6nDChW4aCiClOf/IqIG/707Lr02PPK5kdk14jzd5hrYJow8JbwswLoA3kDM/klwpFWYB
         4Bpm9J42WYx6tNd34XPwfFMI4WxxDV0sq6SPRtxHlIQf5/EQn3MtgSAP8EUtCV3+aycd
         2elV6ykLZElwQcfvNTrvljPa+6TeZBRUO7oDvu+jQYoKP/u6yG0P1kIojv4fuOxfhn1V
         acww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yYlD41kX5tD8EAaTT3esLkO/n/4PggG3tqAvjPP7PN0=;
        b=jqkPVklzq+buBp8jXipdCPoY6LqwMg8e/YOzlR78erQj5CYShdNN3rBTJuCUrLvnrG
         d6Z3L6Q5aH7MrqwRGsnJBAPhOe93JP3QfnwERiBUk9AhhEseSic28YaWYgd4ijFe0hSi
         BPDDJlwo3GaxoWxw4uluR8mfggo9sU0QylBaOc2aw19Rs28y0bMn370XsyLeqbfhgVWa
         F/XHnVvhLm+psKfTRhy6zF3HAcUODaNmQEgblIVWJInuVjwUGtQxLIn8z4BRMhLTTfd8
         +7NbDBN8Oxv0ZkFN8WmjeA1nEk/lqiqKeaHw55iF8hnHcf4rn8jm7glSOZCPjzqW+Lfv
         pKDw==
X-Gm-Message-State: APjAAAUqa5RO5j5CmOfjUiAZjdnYtEkY99IUoy3keZqZLTUF8Dwdre4m
        p0UqOMYzkT5Vy/h5Tp9AiYzFOZK7
X-Google-Smtp-Source: APXvYqzqSpv5K4NI6MG8DrR5PhZDfEaejEjZJkUJutU9yMIAOph4IxDRhkDYhCgNDx50U1XjWplRug==
X-Received: by 2002:a17:906:394c:: with SMTP id g12mr12705417eje.233.1574332661065;
        Thu, 21 Nov 2019 02:37:41 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id x29sm87441edi.20.2019.11.21.02.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:37:40 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2 3/9] md: add serialize_policy sysfs node for raid1
Date:   Thu, 21 Nov 2019 11:37:22 +0100
Message-Id: <20191121103728.18919-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
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
index d3619aa39b89..5321e73db90a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5265,6 +5265,57 @@ static struct md_sysfs_entry md_fail_last_dev =
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
+		mddev_create_serial_pool(mddev, NULL, true, true);
+	else
+		mddev_destroy_serial_pool(mddev, NULL, true, true);
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
@@ -5282,6 +5333,7 @@ static struct attribute *md_default_attrs[] = {
 	&max_corr_read_errors.attr,
 	&md_consistency_policy.attr,
 	&md_fail_last_dev.attr,
+	&md_serialize_policy.attr,
 	NULL,
 };
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 3ca0c3ac4640..b2cdc13f0511 100644
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

