Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3D46C73
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 00:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfFNWlc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 18:41:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59900 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbfFNWlc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 Jun 2019 18:41:32 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EMclsE031207
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=dE+hUhJBzRBAA2RAE9ldIMDQ9iheP/0WVRTBeDqa85I=;
 b=g/RCZxbqE8potAouR6bd3vXu67uOo/N36/ZnKHzNXnMMcEnPbVfyYNbey3kt6yIAEr9T
 hOXS3P2By3Ni/mriWZSO7nZtabv71l0KYz/KquvEAza2USrW+YskWlJqe7AAunQI9+uT
 H2z65fVNWubF1GNUlvBHx+qQefZbwebJikY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t4dfqsk6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:31 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 14 Jun 2019 15:41:30 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id CD7CD62E307F; Fri, 14 Jun 2019 15:41:28 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kernel-team@fb.com>,
        Yufen Yu <yuyufen@huawei.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 5/8] md/raid1: get rid of extra blank line and space
Date:   Fri, 14 Jun 2019 15:41:08 -0700
Message-ID: <20190614224111.3485077-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614224111.3485077-1-songliubraving@fb.com>
References: <20190614224111.3485077-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=442 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140178
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

This patch get rid of extra blank line and space, and
add necessary space for code.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/raid1.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index e331b433d00c..869c32fea1b8 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1424,7 +1424,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		if (!r1_bio->bios[i])
 			continue;
 
-
 		if (first_clone) {
 			/* do behind I/O ?
 			 * Not if there are too many, or cannot
@@ -1704,9 +1703,8 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		first = last = rdev->saved_raid_disk;
 
 	for (mirror = first; mirror <= last; mirror++) {
-		p = conf->mirrors+mirror;
+		p = conf->mirrors + mirror;
 		if (!p->rdev) {
-
 			if (mddev->gendisk)
 				disk_stack_limits(mddev->gendisk, rdev->bdev,
 						  rdev->data_offset << 9);
@@ -2863,7 +2861,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		if (read_targets == 1)
 			bio->bi_opf &= ~MD_FAILFAST;
 		generic_make_request(bio);
-
 	}
 	return nr_sectors;
 }
@@ -3064,7 +3061,7 @@ static int raid1_run(struct mddev *mddev)
 	}
 
 	mddev->degraded = 0;
-	for (i=0; i < conf->raid_disks; i++)
+	for (i = 0; i < conf->raid_disks; i++)
 		if (conf->mirrors[i].rdev == NULL ||
 		    !test_bit(In_sync, &conf->mirrors[i].rdev->flags) ||
 		    test_bit(Faulty, &conf->mirrors[i].rdev->flags))
@@ -3099,7 +3096,7 @@ static int raid1_run(struct mddev *mddev)
 						  mddev->queue);
 	}
 
-	ret =  md_integrity_register(mddev);
+	ret = md_integrity_register(mddev);
 	if (ret) {
 		md_unregister_thread(&mddev->thread);
 		raid1_free(mddev, conf);
-- 
2.17.1

