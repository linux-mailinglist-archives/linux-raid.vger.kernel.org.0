Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D65BDA1E
	for <lists+linux-raid@lfdr.de>; Tue, 20 Sep 2022 04:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiITC2w (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 19 Sep 2022 22:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiITC2v (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 19 Sep 2022 22:28:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9E85756E
        for <linux-raid@vger.kernel.org>; Mon, 19 Sep 2022 19:28:50 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWlk30HxXzlW3W;
        Tue, 20 Sep 2022 10:24:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 10:28:48 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <song@kernel.org>, <linux-raid@vger.kernel.org>
CC:     <yebin10@huawei.com>
Subject: [PATCH -next 0/3] do some cleanup for md_ioctl
Date:   Tue, 20 Sep 2022 10:39:35 +0800
Message-ID: <20220920023938.3273598-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Ye Bin (3):
  md: refactor md ioctl cmd check
  md: factor out __md_set_array_info()
  md: introduce md_ro_state to make code easy to understand

 drivers/md/md.c | 249 +++++++++++++++++++++++++-----------------------
 1 file changed, 131 insertions(+), 118 deletions(-)

-- 
2.31.1

