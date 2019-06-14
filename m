Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4AB46C6E
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 00:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFNWlU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 18:41:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43406 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfFNWlU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 Jun 2019 18:41:20 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EMd9Bo005761
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=AAwk1JXV8Jt1J+uhsFDDTi0/YVxSTyvydLFVBXkpW/Y=;
 b=fUe6siDQ5ORuVr8YCLg7TH47rJ+TJ0hJNo7viH7e/PPf8A4r6vGkwR4NhDGeHT+f1K8N
 3B1I41ULQ8R+3W6l0wfIpsGRRIWjAMBAblU5IJdeAw5bBldLGYtZbVrvppCr3NSpZnvK
 TwcZ31OkxP3polSIIWvgTLr5y2ydJki4odg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t4d24hm3k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:18 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Jun 2019 15:41:17 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1A9B462E307F; Fri, 14 Jun 2019 15:41:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kernel-team@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 1/8] drivers: md: Unify common definitions of raid1 and raid10
Date:   Fri, 14 Jun 2019 15:41:04 -0700
Message-ID: <20190614224111.3485077-2-songliubraving@fb.com>
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
 mlxlogscore=940 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140178
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

These definitions are being moved to raid1-10.c.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/raid1-10.c | 25 +++++++++++++++++++++++++
 drivers/md/raid1.c    | 29 ++---------------------------
 drivers/md/raid10.c   | 27 +--------------------------
 3 files changed, 28 insertions(+), 53 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 400001b815db..7d968bf08e54 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -3,6 +3,31 @@
 #define RESYNC_BLOCK_SIZE (64*1024)
 #define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
 
+/*
+ * Number of guaranteed raid bios in case of extreme VM load:
+ */
+#define	NR_RAID_BIOS 256
+
+/* when we get a read error on a read-only array, we redirect to another
+ * device without failing the first device, or trying to over-write to
+ * correct the read error.  To keep track of bad blocks on a per-bio
+ * level, we store IO_BLOCKED in the appropriate 'bios' pointer
+ */
+#define IO_BLOCKED ((struct bio *)1)
+/* When we successfully write to a known bad-block, we need to remove the
+ * bad-block marking which must be done from process context.  So we record
+ * the success by setting devs[n].bio to IO_MADE_GOOD
+ */
+#define IO_MADE_GOOD ((struct bio *)2)
+
+#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
+
+/* When there are this many requests queue to be written by
+ * the raid thread, we become 'congested' to provide back-pressure
+ * for writeback.
+ */
+static int max_queued_requests = 1024;
+
 /* for managing resync I/O pages */
 struct resync_pages {
 	void		*raid_bio;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 2aa36e570e04..e331b433d00c 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -42,31 +42,6 @@
 	 (1L << MD_HAS_PPL) |		\
 	 (1L << MD_HAS_MULTIPLE_PPLS))
 
-/*
- * Number of guaranteed r1bios in case of extreme VM load:
- */
-#define	NR_RAID1_BIOS 256
-
-/* when we get a read error on a read-only array, we redirect to another
- * device without failing the first device, or trying to over-write to
- * correct the read error.  To keep track of bad blocks on a per-bio
- * level, we store IO_BLOCKED in the appropriate 'bios' pointer
- */
-#define IO_BLOCKED ((struct bio *)1)
-/* When we successfully write to a known bad-block, we need to remove the
- * bad-block marking which must be done from process context.  So we record
- * the success by setting devs[n].bio to IO_MADE_GOOD
- */
-#define IO_MADE_GOOD ((struct bio *)2)
-
-#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
-
-/* When there are this many requests queue to be written by
- * the raid1 thread, we become 'congested' to provide back-pressure
- * for writeback.
- */
-static int max_queued_requests = 1024;
-
 static void allow_barrier(struct r1conf *conf, sector_t sector_nr);
 static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
 
@@ -2947,7 +2922,7 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 	if (!conf->poolinfo)
 		goto abort;
 	conf->poolinfo->raid_disks = mddev->raid_disks * 2;
-	err = mempool_init(&conf->r1bio_pool, NR_RAID1_BIOS, r1bio_pool_alloc,
+	err = mempool_init(&conf->r1bio_pool, NR_RAID_BIOS, r1bio_pool_alloc,
 			   r1bio_pool_free, conf->poolinfo);
 	if (err)
 		goto abort;
@@ -3232,7 +3207,7 @@ static int raid1_reshape(struct mddev *mddev)
 	newpoolinfo->mddev = mddev;
 	newpoolinfo->raid_disks = raid_disks * 2;
 
-	ret = mempool_init(&newpool, NR_RAID1_BIOS, r1bio_pool_alloc,
+	ret = mempool_init(&newpool, NR_RAID_BIOS, r1bio_pool_alloc,
 			   r1bio_pool_free, newpoolinfo);
 	if (ret) {
 		kfree(newpoolinfo);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index aea11476fee6..1facd0153399 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -64,31 +64,6 @@
  *    [B A] [D C]    [B A] [E C D]
  */
 
-/*
- * Number of guaranteed r10bios in case of extreme VM load:
- */
-#define	NR_RAID10_BIOS 256
-
-/* when we get a read error on a read-only array, we redirect to another
- * device without failing the first device, or trying to over-write to
- * correct the read error.  To keep track of bad blocks on a per-bio
- * level, we store IO_BLOCKED in the appropriate 'bios' pointer
- */
-#define IO_BLOCKED ((struct bio *)1)
-/* When we successfully write to a known bad-block, we need to remove the
- * bad-block marking which must be done from process context.  So we record
- * the success by setting devs[n].bio to IO_MADE_GOOD
- */
-#define IO_MADE_GOOD ((struct bio *)2)
-
-#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
-
-/* When there are this many requests queued to be written by
- * the raid10 thread, we become 'congested' to provide back-pressure
- * for writeback.
- */
-static int max_queued_requests = 1024;
-
 static void allow_barrier(struct r10conf *conf);
 static void lower_barrier(struct r10conf *conf);
 static int _enough(struct r10conf *conf, int previous, int ignore);
@@ -3675,7 +3650,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 
 	conf->geo = geo;
 	conf->copies = copies;
-	err = mempool_init(&conf->r10bio_pool, NR_RAID10_BIOS, r10bio_pool_alloc,
+	err = mempool_init(&conf->r10bio_pool, NR_RAID_BIOS, r10bio_pool_alloc,
 			   r10bio_pool_free, conf);
 	if (err)
 		goto out;
-- 
2.17.1

