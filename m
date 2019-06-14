Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155C646C78
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 00:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFNWlj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 18:41:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51524 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbfFNWlj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 Jun 2019 18:41:39 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EMcw6Q017966
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=s1rgmXGxHb4VK2nZF5EN7gbe6bIgqWlPVdkEhH0NURo=;
 b=QbdrWRZzSiSBhqo+HeBaunuaCJEEO39k12bt8wziKer/8r7GarIt1bB050JtPn9Rvj5F
 yNcoFnLyanY0uDsxNRmLreCXy2eESUt47bBep4fwvO+C5/3sBBgPs4oy62VC7VMAR7Wj
 o/grRE57eQg8Z+T84rzCy+x2kW8uW9iyQdE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t4ds0sfkw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:37 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Jun 2019 15:41:36 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id A1BC562E307F; Fri, 14 Jun 2019 15:41:34 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kernel-team@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 7/8] md: raid1-10: Unify r{1,10}bio_pool_free
Date:   Fri, 14 Jun 2019 15:41:10 -0700
Message-ID: <20190614224111.3485077-8-songliubraving@fb.com>
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
 mlxlogscore=697 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140178
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Avoiding duplicated code, since they just execute a kfree.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/md/raid1-10.c |  5 +++++
 drivers/md/raid1.c    | 13 ++++---------
 drivers/md/raid10.c   | 11 +++--------
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 7d968bf08e54..54db34163968 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -34,6 +34,11 @@ struct resync_pages {
 	struct page	*pages[RESYNC_PAGES];
 };
 
+static void rbio_pool_free(void *rbio, void *data)
+{
+	kfree(rbio);
+}
+
 static inline int resync_alloc_pages(struct resync_pages *rp,
 				     gfp_t gfp_flags)
 {
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 869c32fea1b8..a7860b5f33f2 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -68,11 +68,6 @@ static void * r1bio_pool_alloc(gfp_t gfp_flags, void *data)
 	return kzalloc(size, gfp_flags);
 }
 
-static void r1bio_pool_free(void *r1_bio, void *data)
-{
-	kfree(r1_bio);
-}
-
 #define RESYNC_DEPTH 32
 #define RESYNC_SECTORS (RESYNC_BLOCK_SIZE >> 9)
 #define RESYNC_WINDOW (RESYNC_BLOCK_SIZE * RESYNC_DEPTH)
@@ -148,7 +143,7 @@ static void * r1buf_pool_alloc(gfp_t gfp_flags, void *data)
 	kfree(rps);
 
 out_free_r1bio:
-	r1bio_pool_free(r1_bio, data);
+	rbio_pool_free(r1_bio, data);
 	return NULL;
 }
 
@@ -168,7 +163,7 @@ static void r1buf_pool_free(void *__r1_bio, void *data)
 	/* resync pages array stored in the 1st bio's .bi_private */
 	kfree(rp);
 
-	r1bio_pool_free(r1bio, data);
+	rbio_pool_free(r1bio, data);
 }
 
 static void put_all_bios(struct r1conf *conf, struct r1bio *r1_bio)
@@ -2920,7 +2915,7 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 		goto abort;
 	conf->poolinfo->raid_disks = mddev->raid_disks * 2;
 	err = mempool_init(&conf->r1bio_pool, NR_RAID_BIOS, r1bio_pool_alloc,
-			   r1bio_pool_free, conf->poolinfo);
+			   rbio_pool_free, conf->poolinfo);
 	if (err)
 		goto abort;
 
@@ -3205,7 +3200,7 @@ static int raid1_reshape(struct mddev *mddev)
 	newpoolinfo->raid_disks = raid_disks * 2;
 
 	ret = mempool_init(&newpool, NR_RAID_BIOS, r1bio_pool_alloc,
-			   r1bio_pool_free, newpoolinfo);
+			   rbio_pool_free, newpoolinfo);
 	if (ret) {
 		kfree(newpoolinfo);
 		return ret;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index f35e076ee47d..c9a149b2ec86 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -98,11 +98,6 @@ static void * r10bio_pool_alloc(gfp_t gfp_flags, void *data)
 	return kzalloc(size, gfp_flags);
 }
 
-static void r10bio_pool_free(void *r10_bio, void *data)
-{
-	kfree(r10_bio);
-}
-
 #define RESYNC_SECTORS (RESYNC_BLOCK_SIZE >> 9)
 /* amount of memory to reserve for resync requests */
 #define RESYNC_WINDOW (1024*1024)
@@ -208,7 +203,7 @@ static void * r10buf_pool_alloc(gfp_t gfp_flags, void *data)
 	}
 	kfree(rps);
 out_free_r10bio:
-	r10bio_pool_free(r10_bio, conf);
+	rbio_pool_free(r10_bio, conf);
 	return NULL;
 }
 
@@ -236,7 +231,7 @@ static void r10buf_pool_free(void *__r10_bio, void *data)
 	/* resync pages array stored in the 1st bio's .bi_private */
 	kfree(rp);
 
-	r10bio_pool_free(r10bio, conf);
+	rbio_pool_free(r10bio, conf);
 }
 
 static void put_all_bios(struct r10conf *conf, struct r10bio *r10_bio)
@@ -3651,7 +3646,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	conf->geo = geo;
 	conf->copies = copies;
 	err = mempool_init(&conf->r10bio_pool, NR_RAID_BIOS, r10bio_pool_alloc,
-			   r10bio_pool_free, conf);
+			   rbio_pool_free, conf);
 	if (err)
 		goto out;
 
-- 
2.17.1

