Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64528D7B53
	for <lists+linux-raid@lfdr.de>; Tue, 15 Oct 2019 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfJOQYK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Oct 2019 12:24:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfJOQYK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 15 Oct 2019 12:24:10 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9FGKP3W014266
        for <linux-raid@vger.kernel.org>; Tue, 15 Oct 2019 09:24:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=RLfpw0haqd30WLTrs47zkbg6cYLi67mR3c3tWyhRKQA=;
 b=NTG+8jgM3tviGLNIsffKjD6Z1Ds5UDqsiTpkj3jUe2cYi4cL3oot+JqBLKN+A9Dc+9k4
 c5EjATC38tyzevsuc1aOvleDhjhjoGDLy7Luz9AtxRUr5liOMYVy15CMkmWPdLaFskFo
 SPEMjSDTXeSAPt72QFOrf80K0CG3nvJpmcc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vnf1wgxg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Tue, 15 Oct 2019 09:24:09 -0700
Received: from 2401:db00:12:909f:face:0:3:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Oct 2019 09:24:08 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id F299262E1D52; Tue, 15 Oct 2019 09:24:06 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>
CC:     <doktor.yak@gmail.com>, Song Liu <songliubraving@fb.com>,
        NeilBrown <neilb@suse.de>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] md/raid0: fix warning message for parameter default_layout
Date:   Tue, 15 Oct 2019 09:24:03 -0700
Message-ID: <20191015162403.763534-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_06:2019-10-15,2019-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=592 priorityscore=1501 suspectscore=1 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910150142
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The message should match the parameter, i.e. raid0.default_layout.

Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
Cc: NeilBrown <neilb@suse.de>
Reported-by: Ivan Topolsky <doktor.yak@gmail.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/raid0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f61693e59684..1e772287b1c8 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -154,7 +154,7 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
 	} else {
 		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting\n",
 		       mdname(mddev));
-		pr_err("md/raid0: please set raid.default_layout to 1 or 2\n");
+		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
 		err = -ENOTSUPP;
 		goto abort;
 	}
-- 
2.17.1

