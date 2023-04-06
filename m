Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D7B6D962F
	for <lists+linux-raid@lfdr.de>; Thu,  6 Apr 2023 13:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbjDFLql (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Apr 2023 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDFLqP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 Apr 2023 07:46:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C45B770
        for <linux-raid@vger.kernel.org>; Thu,  6 Apr 2023 04:42:18 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Psfg43HsTzrZ6v;
        Thu,  6 Apr 2023 19:39:44 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500002.china.huawei.com
 (7.221.188.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 19:41:00 +0800
From:   Guanqin Miao <miaoguanqin@huawei.com>
To:     <jes@trained-monkey.org>, <mariusz.tkaczyk@linux.intel.com>,
        <pmenzel@molgen.mpg.de>, <linux-raid@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <lixiaokeng@huawei.com>,
        <louhongxiang@huawei.com>
Subject: [PATCH 0/4] Fix memory leak for Manage Assemble Kill mdadm
Date:   Thu, 6 Apr 2023 19:40:07 +0800
Message-ID: <20230406114011.3297545-1-miaoguanqin@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500002.china.huawei.com (7.221.188.171)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When we test mdadm with asan,i we found some memory leaks.
We fix these memory leaks based on code logic.

Guanqin Miao (4):
  Fix memory leak in file Assemble
  Fix memory leak in file Kill
  Fix memory leak in file Manage
  Fix memory leak in file mdadm

 Assemble.c | 15 +++++++++++++--
 Kill.c     |  9 ++++++++-
 Manage.c   | 15 ++++++++++++++-
 mdadm.c    |  4 ++++
 4 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.33.0

