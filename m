Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0655FAF462
	for <lists+linux-raid@lfdr.de>; Wed, 11 Sep 2019 04:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfIKClT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Sep 2019 22:41:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48890 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbfIKClT (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Sep 2019 22:41:19 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 57C4A7DE1751742BF37E;
        Wed, 11 Sep 2019 10:41:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 10:41:05 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <songliubraving@fb.com>
CC:     <linux-raid@vger.kernel.org>, <yuyufen@huawei.com>
Subject: [PATCH v3 0/2] skip spare disk as freshest disk
Date:   Wed, 11 Sep 2019 11:01:40 +0800
Message-ID: <20190911030142.49105-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,
	For this patchset , we add a new entry .disk_is_spare in super_type
	to check if the disk is in 'spare' state. If a disk is in spare,
	analyze_sbs() should skip the disk to be freshest disk. Otherwise,
	it may cause md run fail. There is a fail example in the second patch.

V3:
 - add a new entry .disk_is_spare in super_type

V2:
 - just fix analyze_sbs() to skip spare disk
 - https://www.spinics.net/lists/raid/msg63196.html

V1:
 - directly modify super_*_load to skip event tests for spare disk
 - https://www.spinics.net/lists/raid/msg63136.html


Yufen Yu (2):
  md: add a new entry .disk_is_spare in super_types
  md: don't let spare disk become the fresh disk in analyze_sbs()

 drivers/md/md.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

-- 
2.17.2

