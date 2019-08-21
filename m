Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824AF98377
	for <lists+linux-raid@lfdr.de>; Wed, 21 Aug 2019 20:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfHUSpd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Aug 2019 14:45:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727237AbfHUSpc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 21 Aug 2019 14:45:32 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x7LIY49U005297
        for <linux-raid@vger.kernel.org>; Wed, 21 Aug 2019 11:45:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=JA+ifyo7RfG/cO/IPNeiai+xkp8MvWeBO6//0L2ELG8=;
 b=rUoyLygeuquyOqgecflnWT7qICq7NwbCsh6Pdikjb06gYB9tdoUvEH5a9t78D+kMrONq
 6ODrQpT5sH0NTkq0bhmKnjKrnJHlUbKnGATLkCHVF0N0PvvtfZZDijQNO6YaSEiLN9ms
 kKyXcNpNJcTLvSb5ecVmOfUqK+bs3YoYMjA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2uh7xrh450-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Wed, 21 Aug 2019 11:45:31 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Aug 2019 11:45:30 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DC05762E1CA7; Wed, 21 Aug 2019 11:45:29 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, NeilBrown <neilb@suse.com>,
        Jens Axboe <axboe@kernel.dk>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] md: update MAINTAINERS info
Date:   Wed, 21 Aug 2019 11:45:25 -0700
Message-ID: <20190821184525.1459041-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=780 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210182
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I haven't been reviewing patches for md in the past few months. So I
guess I should just be the maintainer.

Cc: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2c343ee3b2c..8038278eb00e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14872,9 +14872,9 @@ F:	include/linux/arm_sdei.h
 F:	include/uapi/linux/arm_sdei.h
 
 SOFTWARE RAID (Multiple Disks) SUPPORT
-M:	Shaohua Li <shli@kernel.org>
+M:	Song Liu <song@kernel.org>
 L:	linux-raid@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shli/md.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git
 S:	Supported
 F:	drivers/md/Makefile
 F:	drivers/md/Kconfig
-- 
2.17.1

