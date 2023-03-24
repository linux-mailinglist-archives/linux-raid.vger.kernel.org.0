Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB06C7EFA
	for <lists+linux-raid@lfdr.de>; Fri, 24 Mar 2023 14:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCXNk5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 Mar 2023 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjCXNk4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 Mar 2023 09:40:56 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F54722C9B
        for <linux-raid@vger.kernel.org>; Fri, 24 Mar 2023 06:40:49 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 59BF861CC40F9;
        Fri, 24 Mar 2023 14:40:46 +0100 (CET)
Message-ID: <9c3ac4a9-5deb-3a90-3aea-2f571f284568@molgen.mpg.de>
Date:   Fri, 24 Mar 2023 14:40:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Fix null pointer for incremental in mdadm
To:     miaoguanqin@huawei.com
Cc:     jes@trained-monkey.org, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linfeilong@huawei.com,
        lixiaokeng@huawei.com, louhongxiang@huawei.com
References: <20230323013723.3242033-1-miaoguanqin@huawei.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230323013723.3242033-1-miaoguanqin@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Miao,


Am 23.03.23 um 02:37 schrieb miaoguanqin:

[…]

> Signed-off-by: miaoguanqin <miaoguanqin@huawei.com>
> Signed-off-by: lixiaokeng <lixiaokeng@huawei.com>

Thank you for your patches. It’d be great if you used the full names 
(also in your From: field) instead of usernames. For example, Li Xiao Keng.

     git config --global user.name "…"
     git commit --amend --author="… <miaoguanqin@huawei.com>"


Kind regards,

Paul
