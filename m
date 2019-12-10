Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E194117DD7
	for <lists+linux-raid@lfdr.de>; Tue, 10 Dec 2019 03:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLJCmm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 Dec 2019 21:42:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfLJCmm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 9 Dec 2019 21:42:42 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9F99196027FCB9BA7B8B;
        Tue, 10 Dec 2019 10:42:40 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Dec 2019
 10:42:31 +0800
To:     <linux-raid@vger.kernel.org>, <neilb@suse.de>,
        <songliubraving@fb.com>, <axboe@kernel.dk>, <yuyufen@huawei.com>,
        <houtao1@huawei.com>, <tglx@linutronix.de>,
        <nate.dailey@stratus.com>, <song@kernel.org>,
        "Guoqing Jiang" <guoqing.jiang@cloud.ionos.com>
CC:     Mingfangsen <mingfangsen@huawei.com>, <guiyao@huawei.com>,
        <yanxiaodan@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH V2] md: raid1: check whether rdev is null before reference in
 raid1_sync_request func
Message-ID: <b894dad1-56b9-b87f-c6d5-cbcdea8c1add@huawei.com>
Date:   Tue, 10 Dec 2019 10:42:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

In raid1_sync_request func, rdev should be checked whether it is null
before reference.

--
V1->V2: remove Fixes tag suggested by Guoqing Jiang

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index a409ab6f30bc..0dea35052efe 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2782,7 +2782,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 				write_targets++;
 			}
 		}
-		if (bio->bi_end_io) {
+		if (rdev != NULL && bio->bi_end_io) {
 			atomic_inc(&rdev->nr_pending);
 			bio->bi_iter.bi_sector = sector_nr + rdev->data_offset;
 			bio_set_dev(bio, rdev->bdev);
-- 
2.24.0.windows.2


