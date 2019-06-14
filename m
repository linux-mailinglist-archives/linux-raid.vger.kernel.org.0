Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0184D46C6D
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 00:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfFNWlS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 18:41:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51752 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbfFNWlR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 Jun 2019 18:41:17 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EMbLmt017808
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=FrzNVlTFdpKeTn10TUbWXzNOEvl12PITjNsmgN3umQg=;
 b=BQxmDyMRYRFLjXLJMyiSJkxJoI2WyQ4ydRBRMBBQloXBgPv3GC+VTnIWOrFhZIunzTIT
 +Ze2JjZrKGle35eXu6Sm0DD1wIW3YczV0PCuyFvEFQIfHcd9RDO7rpKwJ1iVv8U2vGJU
 pilUKaIA7s5xUHOrDbSnGUSxiPZqggPTVxI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t4k3n0950-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 15:41:16 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Jun 2019 15:41:15 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 3533562E307F; Fri, 14 Jun 2019 15:41:14 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 0/8] md: for-5.3 changes
Date:   Fri, 14 Jun 2019 15:41:03 -0700
Message-ID: <20190614224111.3485077-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140178
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jens,

These are md patches for 5.3. Please consider apply them to your
(to be created) for-5.3/block branch.

Thanks,
Song

Guoqing Jiang (1):
  md/raid10: read balance chooses idlest disk for SSD

Gustavo A. R. Silva (1):
  md: raid10: Use struct_size() in kmalloc()

Marcos Paulo de Souza (3):
  drivers: md: Unify common definitions of raid1 and raid10
  md: md.c: Return -ENODEV when mddev is NULL in rdev_attr_show
  md: raid1-10: Unify r{1,10}bio_pool_free

Xiao Ni (1):
  raid5-cache: Need to do start() part job after adding journal device

Yufen Yu (2):
  md: fix spelling typo and add necessary space
  md/raid1: get rid of extra blank line and space

 drivers/md/md.c       | 13 +++----
 drivers/md/raid1-10.c | 30 +++++++++++++++
 drivers/md/raid1.c    | 51 +++++--------------------
 drivers/md/raid10.c   | 86 +++++++++++++++++++------------------------
 drivers/md/raid5.c    | 11 +++++-
 5 files changed, 91 insertions(+), 100 deletions(-)

--
2.17.1
