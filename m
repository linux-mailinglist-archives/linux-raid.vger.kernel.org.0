Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4BB258408
	for <lists+linux-raid@lfdr.de>; Tue,  1 Sep 2020 00:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgHaW1k (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 31 Aug 2020 18:27:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27010 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbgHaW1j (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 31 Aug 2020 18:27:39 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07VMN4qr028662
        for <linux-raid@vger.kernel.org>; Mon, 31 Aug 2020 15:27:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6fQHUfYNWpoeGACRSWyXDFz6VwpJvMfrpeVXIWv5oG0=;
 b=omHUtP/q1efZ09lYrxiF2aUFfoO6ca9p1y4GIDJ2dDdV2qxUmiAQHmO+YWjYvWsaZel7
 0RHrtIUvk1IlrlNJyZ++5+gBPfbRL8T/d/Eyu7ZtH+zeEcXHexWIqgVj0GK3jdMoGKwZ
 wvW+HPCL2w4qWcyESDOHIqWK86zdiFzL7TU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3386ukfb55-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Mon, 31 Aug 2020 15:27:39 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 31 Aug 2020 15:27:37 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6046762E51BC; Mon, 31 Aug 2020 15:27:36 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-bcache@vger.kernel.org>
CC:     <colyli@suse.de>, <axboe@kernel.dk>, <kernel-team@fb.com>,
        <song@kernel.org>, <hch@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/3] block: introduce part_[begin|end]_io_acct
Date:   Mon, 31 Aug 2020 15:27:23 -0700
Message-ID: <20200831222725.3860186-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200831222725.3860186-1-songliubraving@fb.com>
References: <20200831222725.3860186-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_10:2020-08-31,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 mlxlogscore=856 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310132
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

These functions can be used to enable iostat for partitions on devices
like md, bcache.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 block/blk-core.c       | 39 +++++++++++++++++++++++++++++++++------
 include/linux/blkdev.h |  5 +++++
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639bd18..abddf8d029b8d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1460,10 +1460,9 @@ void blk_account_io_start(struct request *rq)
 	part_stat_unlock();
 }
=20
-unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sect=
ors,
-		unsigned int op)
+static unsigned long __part_start_io_acct(struct hd_struct *part,
+					  unsigned int sectors, unsigned int op)
 {
-	struct hd_struct *part =3D &disk->part0;
 	const int sgrp =3D op_stat_group(op);
 	unsigned long now =3D READ_ONCE(jiffies);
=20
@@ -1476,12 +1475,26 @@ unsigned long disk_start_io_acct(struct gendisk *=
disk, unsigned int sectors,
=20
 	return now;
 }
+
+unsigned long part_start_io_acct(struct gendisk *disk, struct hd_struct =
**part,
+				 struct bio *bio)
+{
+	*part =3D disk_map_sector_rcu(disk, bio->bi_iter.bi_sector);
+
+	return __part_start_io_acct(*part, bio_sectors(bio), bio_op(bio));
+}
+EXPORT_SYMBOL_GPL(part_start_io_acct);
+
+unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sect=
ors,
+				 unsigned int op)
+{
+	return __part_start_io_acct(&disk->part0, sectors, op);
+}
 EXPORT_SYMBOL(disk_start_io_acct);
=20
-void disk_end_io_acct(struct gendisk *disk, unsigned int op,
-		unsigned long start_time)
+static void __part_end_io_acct(struct hd_struct *part, unsigned int op,
+			       unsigned long start_time)
 {
-	struct hd_struct *part =3D &disk->part0;
 	const int sgrp =3D op_stat_group(op);
 	unsigned long now =3D READ_ONCE(jiffies);
 	unsigned long duration =3D now - start_time;
@@ -1492,6 +1505,20 @@ void disk_end_io_acct(struct gendisk *disk, unsign=
ed int op,
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 }
+
+void part_end_io_acct(struct hd_struct *part, struct bio *bio,
+		      unsigned long start_time)
+{
+	__part_end_io_acct(part, bio_op(bio), start_time);
+	hd_struct_put(part);
+}
+EXPORT_SYMBOL_GPL(part_end_io_acct);
+
+void disk_end_io_acct(struct gendisk *disk, unsigned int op,
+		      unsigned long start_time)
+{
+	__part_end_io_acct(&disk->part0, op, start_time);
+}
 EXPORT_SYMBOL(disk_end_io_acct);
=20
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5636cc17b91..b3f5815a573aa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1930,6 +1930,11 @@ unsigned long disk_start_io_acct(struct gendisk *d=
isk, unsigned int sectors,
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 		unsigned long start_time);
=20
+unsigned long part_start_io_acct(struct gendisk *disk, struct hd_struct =
**part,
+				 struct bio *bio);
+void part_end_io_acct(struct hd_struct *part, struct bio *bio,
+		      unsigned long start_time);
+
 /**
  * bio_start_io_acct - start I/O accounting for bio based drivers
  * @bio:	bio to start account for
--=20
2.24.1

