Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36AA2429AF
	for <lists+linux-raid@lfdr.de>; Wed, 12 Aug 2020 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHLMs7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Aug 2020 08:48:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727909AbgHLMs6 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 12 Aug 2020 08:48:58 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E5EDD8A23D9871C6F34B;
        Wed, 12 Aug 2020 20:48:53 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 20:48:46 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <neilb@suse.com>,
        <guoqing.jiang@cloud.ionos.com>, <houtao1@huawei.com>,
        <yuyufen@huawei.com>
Subject: [PATCH 00/12] Save memory for stripe_head buffer
Date:   Wed, 12 Aug 2020 08:49:19 -0400
Message-ID: <20200812124931.2584743-1-yuyufen@huawei.com>
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

 In current implementation, grow_buffers() uses alloc_page() to allocate
 the buffers for each stripe_head, i.e. allocate a page for each dev[i]
 in stripe_head.
 
 After setting stripe_size as a configurable value by writing sysfs entry,
 it means that we always allocate 64K buffers, but just use 4K of them when
 stripe_size is 4K in 64KB arm64.
 
 To save memory, we try to let multiple buffers of stripe_head to share only
 one real page when page size is bigger than stripe_size. Detail can be
 seen in patch #10.
 
 This patch set is subsequent optimization for configurable stripe_size,
 which based on the origin patches[1] but reorganized them.

 Patch 1 ~ 2 try to replace current page offset '0' with dev[i].offset.
 Patch 3 ~ 5 let xor compute functions support different page offset for raid5.
 Patch 6 ~ 9 let syndrome and recovery function support different page offset for raid6.
 All of these patch are preparing for shared page. There is no functional change.

 Patch 10 ~ 11 actually implement shared page between multiple devices of
 stripe_head. But they only make sense for PAGE_SIZE != 4096, likely, 64KB arm64
 system. It doesn't make any difference for PAGE_SIZE == 4096 system, likely x86.

 We have run tests of mdadm for raid456 and test raid6test module. 
 Not found obvious errors.

[1] https://www.spinics.net/lists/raid/msg65018.html

Yufen Yu (12):
  md/raid5: add offset array in scribble buffer
  md/raid5: add a new member of offset into r5dev
  md/raid5: make async_copy_data() to support different page offset
  md/raid5: add new xor function to support different page offset
  md/raid5: convert to new xor compution interface
  md/raid6: let syndrome computor support different page offset
  md/raid6: let async recovery function support different page offset
  md/raid6: convert to new syndrome and recovery interface
  raid6test: adaptation with new syndrome function
  md/raid5: let multiple devices of stripe_head share page
  md/raid5: resize stripe_head when reshape array
  md/raid5: reallocate page array after setting new stripe_size

 crypto/async_tx/async_pq.c          |  72 +++++---
 crypto/async_tx/async_raid6_recov.c | 163 ++++++++++++-----
 crypto/async_tx/async_xor.c         | 120 +++++++++++--
 crypto/async_tx/raid6test.c         |  24 ++-
 drivers/md/raid5.c                  | 270 ++++++++++++++++++++++++----
 drivers/md/raid5.h                  |  29 ++-
 include/linux/async_tx.h            |  23 ++-
 7 files changed, 565 insertions(+), 136 deletions(-)

-- 
2.25.4

