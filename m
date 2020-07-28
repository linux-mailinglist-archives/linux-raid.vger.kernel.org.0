Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B87230725
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgG1KCM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgG1KCM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 06:02:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C212FC061794
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so20008303eje.7
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w877IAHI25G7BDPRwzhnF/Bru23ieiiSFqwwy4PFlwg=;
        b=TBmOS1UlkOL8RTaARtHi2LLldEQw8PnI8PSSYlboBPA8kYpxjO4IEthgnSmbmUugZ8
         jZ1fm3YtdxY5JJk2U8bsDLGloA9mEHdAEvsUHiCtb3Z0CC9Odih0sMgQxNcRD6CCEwmS
         s/eTFfHNLMRZiL4HdY1pVSCseA9p2RvunEvighVRSFcBS0ACqYP6+h4Rz9xhUxuRwQgP
         viaBDoE+jlASBXU8ix9enC7GDf7ZUR+KhlWinxBxiopMU+iMDcaE/ZcdD+RxykZL9k5Q
         avqv30xMEFzpi2J/oM7s3gsY9i2ja4YmvEA69l66d4hvzhn9V1fA6rfmAYPfmMG7iswN
         We9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w877IAHI25G7BDPRwzhnF/Bru23ieiiSFqwwy4PFlwg=;
        b=jJRnSfS9Xbm8QKe/6f51dl9HWU8pIoA6D6++0vT0LRNJHPEUO7Q9INjkS8AyYZCgqp
         t7iKiUCBjUdIhZim5VcsQHGJ+h4YlmKwcy7zGXwG7j63t5kNC+tmO2wTgaqTEq4FYIun
         YF4Vi3w89o9NmyipP6Anj8GYZoiNwc2EdRakGzFRF01CXhTPKL5a2efSthaxXDmKA5E+
         b/aFnh0LUWNHg1Z1ZwgUKPGfuPCLP1yheyoa1YDWetSe8We8AemlTl5ST/Mn15dnOt0P
         Giixr10jC1YtFno/KO/wn4ck+PkdWzy9FlNXghbzf/FRucsG40r0Mb3+nAXsolQtNnAZ
         WgMg==
X-Gm-Message-State: AOAM5336BhJD5jYqo69FpTy3/Rzv5YdnQkDYeoVGLZHDR+B/Pp0LaTPI
        hAAltY8TI/XOfNnwJmtFETWxUg==
X-Google-Smtp-Source: ABdhPJzgLqFsO5V5CIDs9pj3XqANC8Zbflrmp//a8JaF4E18uKcDb5QiQuaQTftuX6mHUEKpgCwjAA==
X-Received: by 2002:a17:906:a0c8:: with SMTP id bh8mr26105939ejb.190.1595930530467;
        Tue, 28 Jul 2020 03:02:10 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:34cb:1cd0:d3a5:9c35])
        by smtp.gmail.com with ESMTPSA id b24sm9929530edn.33.2020.07.28.03.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:02:09 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org,
        Sebastian Parschauer <s.parschauer@gmx.de>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 1/5] md: register new md sysfs file 'uuid' read-only
Date:   Tue, 28 Jul 2020 12:01:39 +0200
Message-Id: <20200728100143.17813-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
References: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Sebastian Parschauer <s.parschauer@gmx.de>

Report the UUID of the MD array in the following format:
xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

This is useful if you don't want to wait for udev to identify array.
And it is also easy for script to monitor it with the format.

Signed-off-by: Sebastian Parschauer <s.parschauer@gmx.de>
[Guoqing: mention the change in md.rst]
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/admin-guide/md.rst | 4 ++++
 drivers/md/md.c                  | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
index d973d469ffc4..cc8781b96b4d 100644
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -426,6 +426,10 @@ All md devices contain:
      The accepted values when writing to this file are ``ppl`` and ``resync``,
      used to enable and disable PPL.
 
+  uuid
+     This indicates the UUID of the array in the following format:
+     xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
+
 
 As component devices are added to an md array, they appear in the ``md``
 directory as new directories named::
diff --git a/drivers/md/md.c b/drivers/md/md.c
index ea48bc25cce1..0c2a0e65b4f1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4225,6 +4225,14 @@ raid_disks_store(struct mddev *mddev, const char *buf, size_t len)
 static struct md_sysfs_entry md_raid_disks =
 __ATTR(raid_disks, S_IRUGO|S_IWUSR, raid_disks_show, raid_disks_store);
 
+static ssize_t
+uuid_show(struct mddev *mddev, char *page)
+{
+	return sprintf(page, "%pU\n", mddev->uuid);
+}
+static struct md_sysfs_entry md_uuid =
+__ATTR(uuid, S_IRUGO, uuid_show, NULL);
+
 static ssize_t
 chunk_size_show(struct mddev *mddev, char *page)
 {
@@ -5481,6 +5489,7 @@ static struct attribute *md_default_attrs[] = {
 	&md_level.attr,
 	&md_layout.attr,
 	&md_raid_disks.attr,
+	&md_uuid.attr,
 	&md_chunk_size.attr,
 	&md_size.attr,
 	&md_resync_start.attr,
-- 
2.17.1

