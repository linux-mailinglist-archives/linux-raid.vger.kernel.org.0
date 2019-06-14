Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C3046C72
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 00:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfFNWla (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 18:41:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43432 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbfFNWl3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 Jun 2019 18:41:29 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EMd9Bq005761
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=fXOf6T+dlbuFT5hilrsSc+VUKz3XlrFHHQHF/kiiydQ=;
 b=WkzpGKjhUWCrnevYP8ejnZYtUckPcQQsA/Jt8AGJCt/bRqN+uYmTlxL2+1qQOUKiLjSl
 hdnOrdZSJ1C0SMWIenJbHjlJtQCeLC+AE/NR9IQwI5a82qAdm4sH/EWkK+cllyXwZMze
 p/hVDDe4XIaHQnDW76p1SvwJQITqN7vciO0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t4d24hm3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:28 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Jun 2019 15:41:27 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 95D6762E307F; Fri, 14 Jun 2019 15:41:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kernel-team@fb.com>,
        Yufen Yu <yuyufen@huawei.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 4/8] md: fix spelling typo and add necessary space
Date:   Fri, 14 Jun 2019 15:41:07 -0700
Message-ID: <20190614224111.3485077-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614224111.3485077-1-songliubraving@fb.com>
References: <20190614224111.3485077-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140178
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

This patch fix a spelling typo and add necessary space for code.
In addition, the patch get rid of the unnecessary 'if'.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/md.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 86f4f2b5a724..1f37a1adc926 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5639,8 +5639,7 @@ int md_run(struct mddev *mddev)
 	spin_unlock(&mddev->lock);
 	rdev_for_each(rdev, mddev)
 		if (rdev->raid_disk >= 0)
-			if (sysfs_link_rdev(mddev, rdev))
-				/* failure here is OK */;
+			sysfs_link_rdev(mddev, rdev); /* failure here is OK */
 
 	if (mddev->degraded && !mddev->ro)
 		/* This ensures that recovering status is reported immediately
@@ -8190,8 +8189,7 @@ void md_do_sync(struct md_thread *thread)
 {
 	struct mddev *mddev = thread->mddev;
 	struct mddev *mddev2;
-	unsigned int currspeed = 0,
-		 window;
+	unsigned int currspeed = 0, window;
 	sector_t max_sectors,j, io_sectors, recovery_done;
 	unsigned long mark[SYNC_MARKS];
 	unsigned long update_time;
@@ -8248,7 +8246,7 @@ void md_do_sync(struct md_thread *thread)
 	 * 0 == not engaged in resync at all
 	 * 2 == checking that there is no conflict with another sync
 	 * 1 == like 2, but have yielded to allow conflicting resync to
-	 *		commense
+	 *		commence
 	 * other == active in resync - this many blocks
 	 *
 	 * Before starting a resync we must have set curr_resync to
@@ -8379,7 +8377,7 @@ void md_do_sync(struct md_thread *thread)
 	/*
 	 * Tune reconstruction:
 	 */
-	window = 32*(PAGE_SIZE/512);
+	window = 32 * (PAGE_SIZE / 512);
 	pr_debug("md: using %dk window, over a total of %lluk.\n",
 		 window/2, (unsigned long long)max_sectors/2);
 
@@ -9192,7 +9190,6 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 				 * perform resync with the new activated disk */
 				set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 				md_wakeup_thread(mddev->thread);
-
 			}
 			/* device faulty
 			 * We just want to do the minimum to mark the disk
-- 
2.17.1

