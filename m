Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D51C7095FE
	for <lists+linux-raid@lfdr.de>; Fri, 19 May 2023 13:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjESLNr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 May 2023 07:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjESLNr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 19 May 2023 07:13:47 -0400
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 May 2023 04:13:45 PDT
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F87F1
        for <linux-raid@vger.kernel.org>; Fri, 19 May 2023 04:13:45 -0700 (PDT)
Message-ID: <5e8a5f4f-e71c-97a4-6ace-974753a1a528@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684494352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+f7q/+iPZrZx2NdGrm8LfceCd8cPvq8pKk+gPXnu86I=;
        b=wI1UWO9HY2djqaPvMvHuDdBCij+lS3XSpIled16qwu9240aoDzen8dn+RinWrVUT47f8NK
        O/VhnReI586owQNuJ9H8/qkTBljdgkr8QYuRFGT+J8HReiAfK0l5T9wqUannsiUoWq35Ap
        2uTsK6VA64qBYsaTdHEldrwMqxlh5Lg=
Date:   Fri, 19 May 2023 19:05:46 +0800
MIME-Version: 1.0
Subject: Re: [song-md:module_alloc_test 5/6]
 arch/powerpc/kernel/module.c:108:8: error: unused variable 'ptr'
To:     kernel test robot <lkp@intel.com>, Song Liu <song@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-raid@vger.kernel.org
References: <202305191808.4xsaLKSZ-lkp@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <202305191808.4xsaLKSZ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 5/19/23 18:41, kernel test robot wrote:
> Hi Song,
>
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git module_alloc_test

Could you only post test results for md-next/md-fixes branches to raid 
list? Since this is
obvious irrelevant to the list.

Thanks,
Guoqing
