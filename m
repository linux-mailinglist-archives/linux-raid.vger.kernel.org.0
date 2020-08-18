Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD98247EEF
	for <lists+linux-raid@lfdr.de>; Tue, 18 Aug 2020 09:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgHRHDV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Aug 2020 03:03:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726583AbgHRHDV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 18 Aug 2020 03:03:21 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I73G6a029730
        for <linux-raid@vger.kernel.org>; Tue, 18 Aug 2020 00:03:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6svwYmWVS6qlnjaQ0Uq/91ijPhvKSVtvlS3GWpi/Kok=;
 b=MUWvJna4TJTRSklOK0gL5m47m/pYu/KjYbj84Wf5FG182DkXGQv1FmfeHSwTsaWKLz9s
 au2hwCzxa7gcLulCaj4gGnCgdyH3A68M1YAeeshekPHOsDW+BFC05SuAGNin6XfmkfIW
 oMQ8LD3X0xze+RWX7NF+BG8gFqvD9SW2Jk4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p7s6cj-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Tue, 18 Aug 2020 00:03:20 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 00:03:04 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 89ACB62E54B8; Tue, 18 Aug 2020 00:02:56 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-bcache@vger.kernel.org>
CC:     <colyli@suse.de>, <axboe@kernel.dk>, <kernel-team@fb.com>,
        <song@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 4/4] bcache: use part_[begin|end]_io_acct instead of disk_[begin|end]_io_acct
Date:   Tue, 18 Aug 2020 00:02:38 -0700
Message-ID: <20200818070238.1323126-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200818070238.1323126-1-songliubraving@fb.com>
References: <20200818070238.1323126-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_04:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=852
 clxscore=1015 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008180049
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This enables proper statistics in /proc/diskstats for bcache partitions.

Cc: Coly Li <colyli@suse.de>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/bcache/request.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 7de82c67597ce..1d946f601f7eb 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -475,6 +475,7 @@ struct search {
 	unsigned int		read_dirty_data:1;
 	unsigned int		cache_missed:1;
=20
+	struct hd_struct	*part;
 	unsigned long		start_time;
=20
 	struct btree_op		op;
@@ -669,7 +670,8 @@ static void bio_complete(struct search *s)
 {
 	if (s->orig_bio) {
 		/* Count on bcache device */
-		disk_end_io_acct(s->d->disk, bio_op(s->orig_bio), s->start_time);
+		part_end_io_acct(s->part, bio_op(s->orig_bio), s->start_time);
+		hd_struct_put(s->part);
=20
 		trace_bcache_request_end(s->d, s->orig_bio);
 		s->orig_bio->bi_status =3D s->iop.status;
@@ -731,7 +733,8 @@ static inline struct search *search_alloc(struct bio =
*bio,
 	s->write		=3D op_is_write(bio_op(bio));
 	s->read_dirty_data	=3D 0;
 	/* Count on the bcache device */
-	s->start_time		=3D disk_start_io_acct(d->disk, bio_sectors(bio), bio_op=
(bio));
+	s->part			=3D disk_map_sector_rcu(d->disk, bio->bi_iter.bi_sector);
+	s->start_time		=3D part_start_io_acct(s->part, bio_sectors(bio), bio_op=
(bio));
 	s->iop.c		=3D d->c;
 	s->iop.bio		=3D NULL;
 	s->iop.inode		=3D d->id;
@@ -1072,6 +1075,7 @@ struct detached_dev_io_private {
 	unsigned long		start_time;
 	bio_end_io_t		*bi_end_io;
 	void			*bi_private;
+	struct hd_struct	*part;
 };
=20
 static void detached_dev_end_io(struct bio *bio)
@@ -1083,7 +1087,8 @@ static void detached_dev_end_io(struct bio *bio)
 	bio->bi_private =3D ddip->bi_private;
=20
 	/* Count on the bcache device */
-	disk_end_io_acct(ddip->d->disk, bio_op(bio), ddip->start_time);
+	part_end_io_acct(ddip->part, bio_op(bio), ddip->start_time);
+	hd_struct_put(ddip->part);
=20
 	if (bio->bi_status) {
 		struct cached_dev *dc =3D container_of(ddip->d,
@@ -1109,7 +1114,8 @@ static void detached_dev_do_request(struct bcache_d=
evice *d, struct bio *bio)
 	ddip =3D kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
 	ddip->d =3D d;
 	/* Count on the bcache device */
-	ddip->start_time =3D disk_start_io_acct(d->disk, bio_sectors(bio), bio_=
op(bio));
+	ddip->part =3D disk_map_sector_rcu(d->disk, bio->bi_iter.bi_sector);
+	ddip->start_time =3D part_start_io_acct(ddip->part, bio_sectors(bio), b=
io_op(bio));
 	ddip->bi_end_io =3D bio->bi_end_io;
 	ddip->bi_private =3D bio->bi_private;
 	bio->bi_end_io =3D detached_dev_end_io;
--=20
2.24.1

