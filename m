Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346762490CD
	for <lists+linux-raid@lfdr.de>; Wed, 19 Aug 2020 00:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgHRW1S (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Aug 2020 18:27:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60498 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbgHRW1Q (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 18 Aug 2020 18:27:16 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07IMDV0v030272
        for <linux-raid@vger.kernel.org>; Tue, 18 Aug 2020 15:27:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=mDwExpppelWwEhObLUpHdWuu5whhjC8BnC8yJ4+f9go=;
 b=jegP3tYd3vGf0Z1oCN62w6/2gRHKMdql0B3WuUnUM+cJNUmHow/KF6gSvdDe/0M9jBtD
 H3phxyWzgPm3ZFx/zFyxhcXyVWgXiAT2xY+DTGL0inrxXFeDFK3WMDHzkT75yO0q36TQ
 /MFgQgrkeY9ViuIluBSB9+JMVu0YZv/WWb8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304kpncrb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Tue, 18 Aug 2020 15:27:14 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 15:27:01 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id CE4BE62E4B8C; Tue, 18 Aug 2020 15:26:57 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-bcache@vger.kernel.org>
CC:     <colyli@suse.de>, <axboe@kernel.dk>, <kernel-team@fb.com>,
        <song@kernel.org>, <hch@infradead.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 0/3] block: improve iostat for md/bcache partitions
Date:   Tue, 18 Aug 2020 15:26:42 -0700
Message-ID: <20200818222645.952219-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_16:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=543
 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180160
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Currently, devices like md, bcache uses disk_[start|end]_io_acct to repor=
t
iostat. These functions couldn't get proper iostat for partitions on thes=
e
devices.

This set resolves this issue by introducing part_[begin|end]_io_acct, and
using them in md and bcache code.

Changes v1 =3D> v2:
1. Refactor the code, as suggested by Christoph.
2. Include Coly's Reviewed-by tag.

Song Liu (3):
  block: introduce part_[begin|end]_io_acct
  md: use part_[begin|end]_io_acct instead of disk_[begin|end]_io_acct
  bcache: use part_[begin|end]_io_acct instead of
    disk_[begin|end]_io_acct

 block/blk-core.c            | 39 +++++++++++++++++++++++++++++++------
 drivers/md/bcache/request.c | 10 ++++++----
 drivers/md/md.c             |  8 ++++----
 include/linux/blkdev.h      |  5 +++++
 4 files changed, 48 insertions(+), 14 deletions(-)

--
2.24.1
