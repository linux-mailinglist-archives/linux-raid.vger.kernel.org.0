Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E48251F723
	for <lists+linux-raid@lfdr.de>; Mon,  9 May 2022 10:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiEIIsW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 May 2022 04:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiEIIRw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 May 2022 04:17:52 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCDB1ECBBA
        for <linux-raid@vger.kernel.org>; Mon,  9 May 2022 01:13:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652083948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9hOjassq7OOXCcKqwYjVbAZqUNw9d2C2n877F+FkvKg=;
        b=ZAT/iedQBmQhXE84Lgqu2UHdei1bii9Nvt0jBcbA9Fy5DGRTo6Mn1Vq5L5ZP0JpNH0bOBo
        oAxUnMz52t4H9sQJ+dg66kT7vn+expc1RdtSJ++DJoL9rh8sAq+uT2RuZs8dlhvSASKb5J
        6vSeVgzKflZQlRZQ8TsqPfLcimM2rLg=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH 2/2] md: protect md_unregister_thread from reentrancy
To:     Song Liu <song@kernel.org>
Cc:     Donald Buczek <buczek@molgen.mpg.de>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20220505081641.21500-1-guoqing.jiang@linux.dev>
 <20220505081641.21500-3-guoqing.jiang@linux.dev>
 <CAPhsuW4EhdQ6-t8hOyznn0XF2REWLXBCLKh1ru9NZHz9xF5raQ@mail.gmail.com>
Message-ID: <2ed65394-1bda-4076-dc43-ad4c9332ff13@linux.dev>
Date:   Mon, 9 May 2022 16:12:23 +0800
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4EhdQ6-t8hOyznn0XF2REWLXBCLKh1ru9NZHz9xF5raQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 5/9/22 2:39 PM, Song Liu wrote:
> On Thu, May 5, 2022 at 1:18 AM Guoqing Jiang<guoqing.jiang@linux.dev>  wrote:
>> From: Guoqing Jiang<guoqing.jiang@cloud.ionos.com>
>>
>> Generally, the md_unregister_thread is called with reconfig_mutex, but
>> raid_message in dm-raid doesn't hold reconfig_mutex to unregister thread,
>> so md_unregister_thread can be called simulitaneously from two call sites
>> in theory.
> Can we add lock/unlock into raid_message? Are there some constraints here?

Honestly, I don't know about dm-raid well, and there was no reply from 
dm people
as you might know, so I prefer leave it as it is.

Thanks,
Guoqing
