Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771BB53F763
	for <lists+linux-raid@lfdr.de>; Tue,  7 Jun 2022 09:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiFGHjJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Jun 2022 03:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiFGHjH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 Jun 2022 03:39:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344BE9983B
        for <linux-raid@vger.kernel.org>; Tue,  7 Jun 2022 00:39:05 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LHMdg5fXtzjb8n;
        Tue,  7 Jun 2022 15:37:43 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 15:39:02 +0800
Received: from [10.174.177.211] (10.174.177.211) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 15:39:02 +0800
Message-ID: <21027a7d-faa5-9903-8e67-b8b8470a1e72@huawei.com>
Date:   Tue, 7 Jun 2022 15:39:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 0/5] mdadm: fix memory leak and double free
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     <linfeilong@huawei.com>, <lixiaokeng@huawei.com>,
        <jes@trained-monkey.org>, <linux-raid@vger.kernel.org>
References: <00992179-9572-ceb4-eb49-492c42e67695@huawei.com>
 <047a161f-ad48-a60f-ae2e-af19234df4e0@molgen.mpg.de>
From:   Wu Guanghao <wuguanghao3@huawei.com>
In-Reply-To: <047a161f-ad48-a60f-ae2e-af19234df4e0@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.211]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



在 2022/5/31 14:57, Paul Menzel 写道:
> Dear Wu,
> 
> 
> Thank you for the patches.
> 
> Am 31.05.22 um 08:48 schrieb Wu Guanghao:
>> Through tool scanning and code review, we found several memory leaks and double free
>>
>> Wu Guanghao (5):
>>    parse_layout_faulty: fix memleak
>>    Detail: fix memleak
>>    load_imsm_mpb: fix double free
>>    find_disk_attached_hba: fix memleak
>>    get_vd_num_of_subarray: fix memleak
>>
>>   Detail.c      | 1 +
>>   super-ddf.c   | 9 +++++++--
>>   super-intel.c | 6 ++++--
>>   util.c        | 1 +
>>   4 files changed, 13 insertions(+), 4 deletions(-)
> 
> If an issues was found by a tool, could you please add a Reported-by tag to the corresponding commit message?
> 
> Another small nit, could you please add a dot/period at the end of sentences in the commit messages?
> 
Sure, I will add in patch V2.

> Kind regards,
> 
> Paul
> .
