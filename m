Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B082224A41
	for <lists+linux-raid@lfdr.de>; Sat, 18 Jul 2020 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGRJ2R (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 18 Jul 2020 05:28:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgGRJ2R (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 18 Jul 2020 05:28:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 187D9604BD52384BBB81;
        Sat, 18 Jul 2020 17:28:13 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Jul 2020
 17:28:03 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH v7 0/3] md/raid5: set STRIPE_SIZE as a configurable value
Date:   Sat, 18 Jul 2020 05:29:06 -0400
Message-ID: <20200718092909.4020424-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi, all

 For now, STRIPE_SIZE is equal to the value of PAGE_SIZE. That means, RAID5
 will issue each bio to disk at least 64KB when PAGE_SIZE is 64KB in arm64.
 However, filesystem usually issue bio in the unit of 4KB. Then, RAID5 may
 waste resource of disk bandwidth.

 To solve the problem, this patchset try to set stripe_size as a configuare
 value. The default value is 4096. We will add a new sysfs entry and set it
 by writing a new value, likely:

 	echo 16384 > /sys/block/md1/md/stripe_size

 Normally, using default stripe_size can get better performance. So, NeilBrown
 have suggested just to fix the it as 4096. But, out test result shows that
 a big value of stripe_size may have better performance when size of issued
 IOs are mostly bigger than 4096. Thus, in this patchset, we still want to
 set stripe_size as a configurable value.

 This patchset just set STRIPE_SIZE as a configurable value for "PAGE_SIZE != 4096"
 system, likely arm64 with 'PAGE_SIZE=64KB'. It doesn't make any difference for 
 'PAGE_SIZE == 4096' system, likely x86.

 To save memory used by stripe_head, I will send the related optimiation patchset later. 

V7:
 * Just include configurable stripe_size strategy in this patchset.
 * Convert STRIPE_* to RAID_STRIPE_*(conf), without any effect for
   'PAGE_SIZE == 4096' system.
 * Make sysfs entry 'stripe_size' only read for 'PAGE_SIZE == 4096'
 * system.

V6:
 https://www.spinics.net/lists/raid/msg65018.html
 * Convert stripe_size and stripe_sectors from 'unsigned int' to
   'unsigned long' avoiding compiler warning.
 * Add a new member of stripes_per_page into r5conf, avoiding to
   compute each time.
 * Cover mddev->private with mddev_lock(mddev) for raid5_store/show_stripe_size().
 * Get rid of too many WARN_ON() and BUG_ON().
 * Unfold raid5_get_page_index() into raid5_get_dev_page() directly.


Yufen Yu (3):
  md/raid456: convert macro STRIPE_* to RAID5_STRIPE_*
  md/raid5: set default stripe_size as 4096
  md/raid5: support config stripe_size by sysfs entry

 drivers/md/raid5-cache.c |   8 +-
 drivers/md/raid5-ppl.c   |  11 +-
 drivers/md/raid5.c       | 302 ++++++++++++++++++++++++++-------------
 drivers/md/raid5.h       |  53 ++++---
 4 files changed, 246 insertions(+), 128 deletions(-)

-- 
2.25.4

