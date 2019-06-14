Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE246C76
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 00:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFNWlf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 18:41:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726349AbfFNWlf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 Jun 2019 18:41:35 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5EMdcXX018713
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=5pEZktnZ/l+aYv5p3wT4EgNNkHfooDhKeRq34g4FLGY=;
 b=U9Mhj3wKLlT0oI3ImXXfp47bb8bSIE6IgdGvQVB2W0IE3w3+o6D/j0Yrv5uoxC9BMsx2
 9Ayo9gGstjPIYtSS6QzwnSfhMmlyAXnZcgeGi37ELnreDdseiMHfnESb0dl/8a7oehm4
 HDxStm0Br7GIW9K9IT9cV9Mp5giRpyvzz+8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2t3tr9muy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:34 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Jun 2019 15:41:33 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id BB33C62E307F; Fri, 14 Jun 2019 15:41:31 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kernel-team@fb.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 6/8] md: raid10: Use struct_size() in kmalloc()
Date:   Fri, 14 Jun 2019 15:41:09 -0700
Message-ID: <20190614224111.3485077-7-songliubraving@fb.com>
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
 mlxlogscore=707 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140178
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
   int stuff;
   struct boo entry[];
};

instance = kmalloc(size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/raid10.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 1facd0153399..f35e076ee47d 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4755,8 +4755,7 @@ static int handle_reshape_read_error(struct mddev *mddev,
 	int idx = 0;
 	struct page **pages;
 
-	r10b = kmalloc(sizeof(*r10b) +
-	       sizeof(struct r10dev) * conf->copies, GFP_NOIO);
+	r10b = kmalloc(struct_size(r10b, devs, conf->copies), GFP_NOIO);
 	if (!r10b) {
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 		return -ENOMEM;
-- 
2.17.1

