Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32003127E7B
	for <lists+linux-raid@lfdr.de>; Fri, 20 Dec 2019 15:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfLTOr2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Dec 2019 09:47:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45673 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfLTOr1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 20 Dec 2019 09:47:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so8442362edw.12
        for <linux-raid@vger.kernel.org>; Fri, 20 Dec 2019 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uDlJNqga0XjKmAuW1F7lRe+hXJz2tKC0m05k+ZkRM6o=;
        b=k07VsjlFKxfz28CKPgKoJRkylVetmw7kCxSaKFMPJiXHpadpr+Vhtf6CopWt585tjY
         4X/cXYqMaRnuDcqEem66AgB1ghiXpiSLEU56T3SDq6gdAexdE1awd+iJBx9ekIFPJH1V
         hx2/HzOSOkkjqkSftdrmctavLtMuKrxvZD2g9N3F3drEazfyMFC1vk1SXz0fFoTFLlJW
         /Fe9WC7i682YJwEfskFIH/DJVAIuvGxMAvV368ML6jVmhkmS0dkxpnGiegN3kwBnickW
         3AfSeiyGC2wJ7AjVNXGE+Jl77FYfvCRjHOzfACQmX0dCzp2F7R607yml4n/AAfR+l4QM
         lrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uDlJNqga0XjKmAuW1F7lRe+hXJz2tKC0m05k+ZkRM6o=;
        b=PIOaTC+XCZsucFNcYGbCt7P4dS9T8XfLD9mW/YRKNZJtEfexvDocQr0SLD6hHyjrpW
         ffd15iRXokork2diQB6dWBKSI33eb9clmDEJauPw4N5Kca+Spu+5inv6oIYMaDPAxEtM
         tbGCGblvDR/2Uq+QfAreNc8JPQoBCLuxCEnDTtvbsv38eOiUtd3v6SmUqmVLSu5QgwHR
         kV+yONAg9lE5jOs5yHkGAHq9+e4d5GemoNffD+GhrxiiKXwvNN7eihwusRZTcLHvoUfw
         2mR+OkCJXDU8VPHFcyKxoXukn+KPm810tAKPZsRjm/CjVNL5uVSOJaicnWo/bh5RCshd
         camA==
X-Gm-Message-State: APjAAAXi2yMhBdQSwZPJqI3d09xDLB4iSwYwlOwt+zykokMj2aKBqzMY
        yA+9Ars07D2qiORdBk6kbyc=
X-Google-Smtp-Source: APXvYqy5h/xHAtzyhtJZuulKaVr1r/wIir0LoHath/o9uJyq1mCQHiry14BFWMMaMj0hYvsqnTE3Ug==
X-Received: by 2002:a17:906:494d:: with SMTP id f13mr16152668ejt.95.1576853245971;
        Fri, 20 Dec 2019 06:47:25 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:ec0a:ec6a:2d1f:6b5b])
        by smtp.gmail.com with ESMTPSA id e1sm979076edn.86.2019.12.20.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 06:47:25 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] raid5: remove worker_cnt_per_group argument from alloc_thread_groups
Date:   Fri, 20 Dec 2019 15:46:29 +0100
Message-Id: <20191220144629.11054-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

We can use "cnt" directly to update conf->worker_cnt_per_group
if alloc_thread_groups returns 0.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/raid5.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 223e97ab27e6..4f7d3e2815d8 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6598,7 +6598,6 @@ raid5_show_group_thread_cnt(struct mddev *mddev, char *page)
 
 static int alloc_thread_groups(struct r5conf *conf, int cnt,
 			       int *group_cnt,
-			       int *worker_cnt_per_group,
 			       struct r5worker_group **worker_groups);
 static ssize_t
 raid5_store_group_thread_cnt(struct mddev *mddev, const char *page, size_t len)
@@ -6607,7 +6606,7 @@ raid5_store_group_thread_cnt(struct mddev *mddev, const char *page, size_t len)
 	unsigned int new;
 	int err;
 	struct r5worker_group *new_groups, *old_groups;
-	int group_cnt, worker_cnt_per_group;
+	int group_cnt;
 
 	if (len >= PAGE_SIZE)
 		return -EINVAL;
@@ -6630,13 +6629,11 @@ raid5_store_group_thread_cnt(struct mddev *mddev, const char *page, size_t len)
 		if (old_groups)
 			flush_workqueue(raid5_wq);
 
-		err = alloc_thread_groups(conf, new,
-					  &group_cnt, &worker_cnt_per_group,
-					  &new_groups);
+		err = alloc_thread_groups(conf, new, &group_cnt, &new_groups);
 		if (!err) {
 			spin_lock_irq(&conf->device_lock);
 			conf->group_cnt = group_cnt;
-			conf->worker_cnt_per_group = worker_cnt_per_group;
+			conf->worker_cnt_per_group = new;
 			conf->worker_groups = new_groups;
 			spin_unlock_irq(&conf->device_lock);
 
@@ -6672,16 +6669,13 @@ static struct attribute_group raid5_attrs_group = {
 	.attrs = raid5_attrs,
 };
 
-static int alloc_thread_groups(struct r5conf *conf, int cnt,
-			       int *group_cnt,
-			       int *worker_cnt_per_group,
+static int alloc_thread_groups(struct r5conf *conf, int cnt, int *group_cnt,
 			       struct r5worker_group **worker_groups)
 {
 	int i, j, k;
 	ssize_t size;
 	struct r5worker *workers;
 
-	*worker_cnt_per_group = cnt;
 	if (cnt == 0) {
 		*group_cnt = 0;
 		*worker_groups = NULL;
@@ -6882,7 +6876,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	struct disk_info *disk;
 	char pers_name[6];
 	int i;
-	int group_cnt, worker_cnt_per_group;
+	int group_cnt;
 	struct r5worker_group *new_group;
 	int ret;
 
@@ -6928,10 +6922,9 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	for (i = 0; i < PENDING_IO_MAX; i++)
 		list_add(&conf->pending_data[i].sibling, &conf->free_list);
 	/* Don't enable multi-threading by default*/
-	if (!alloc_thread_groups(conf, 0, &group_cnt, &worker_cnt_per_group,
-				 &new_group)) {
+	if (!alloc_thread_groups(conf, 0, &group_cnt, &new_group)) {
 		conf->group_cnt = group_cnt;
-		conf->worker_cnt_per_group = worker_cnt_per_group;
+		conf->worker_cnt_per_group = 0;
 		conf->worker_groups = new_group;
 	} else
 		goto abort;
-- 
2.17.1

