Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B403A1C83FF
	for <lists+linux-raid@lfdr.de>; Thu,  7 May 2020 09:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEGH4j (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 May 2020 03:56:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgEGHz5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 7 May 2020 03:55:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5797745993D5BE47473A;
        Thu,  7 May 2020 15:55:53 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 15:55:47 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Alasdair Kergon" <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, dm-devel <dm-devel@redhat.com>,
        Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 03/10] block: add sectors_to_npage()/npage_to_sectors() helpers
Date:   Thu, 7 May 2020 15:50:53 +0800
Message-ID: <20200507075100.1779-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200507075100.1779-1-thunder.leizhen@huawei.com>
References: <20200507075100.1779-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Provide the conversion of "number of sectors"/"sector number" and
"number of pages"/"page number".

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/blkdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 934f31fc15cd..5d8daaffc38b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -910,6 +910,8 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 #define SECTOR_SIZE		(1 << SECTOR_SHIFT)
 #endif
 #define PAGE_SECTORS		(PAGE_SIZE / SECTOR_SIZE)
+#define sectors_to_npage(nr)	((nr) / PAGE_SECTORS)
+#define npage_to_sectors(nr)	((nr) * PAGE_SECTORS)
 
 /*
  * blk_rq_pos()			: the current sector
-- 
2.26.0.106.g9fadedd


