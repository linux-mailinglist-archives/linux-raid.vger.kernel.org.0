Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D24646C71
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 00:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfFNWl0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 18:41:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39054 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbfFNWl0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 Jun 2019 18:41:26 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EMeJGi022069
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=bEweOnQSDMke6LqmS9D6feAAfrM7Q2fflzDOn8WRI7c=;
 b=PLReu5E0PliXJrIx8O7+N8h/C7JyIEfVIaTVDi92rbL848P0hbfaGgjBpPUYoPhhFRB4
 V6BVwiuPo0jrQUbVGf5b2Z7zvMesVb9mDFv7JL+4vey3mqiNQUloHAHBLXjPN18B8NNt
 MLhsNqkzXX2jgddiITXVq7O62JWvWL46W8k= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t4axmj62a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:25 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 14 Jun 2019 15:41:23 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 4BDF262E307F; Fri, 14 Jun 2019 15:41:22 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kernel-team@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 3/8] md: md.c: Return -ENODEV when mddev is NULL in rdev_attr_show
Date:   Fri, 14 Jun 2019 15:41:06 -0700
Message-ID: <20190614224111.3485077-4-songliubraving@fb.com>
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
 mlxlogscore=882 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140178
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Commit c42d3240990814eec1e4b2b93fa0487fc4873aed
("md: return -ENODEV if rdev has no mddev assigned") changed
rdev_attr_store to return -ENODEV when rdev->mddev is NULL, now do the
same to rdev_attr_show.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 04f4f131f9d6..86f4f2b5a724 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3356,7 +3356,7 @@ rdev_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	if (!entry->show)
 		return -EIO;
 	if (!rdev->mddev)
-		return -EBUSY;
+		return -ENODEV;
 	return entry->show(rdev, page);
 }
 
-- 
2.17.1

