Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAB542398
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jun 2022 08:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiFHBNm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Jun 2022 21:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835810AbiFGX5J (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 Jun 2022 19:57:09 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399BC1D2AD4
        for <linux-raid@vger.kernel.org>; Tue,  7 Jun 2022 16:45:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] md: unlock mddev before reap sync_thread in
 action_store
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654645512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oiTVKG/qVjLFT4tb0cNUBbow5xW1prw8IQOB5dRVTE0=;
        b=Py+mjkFzhNYUc39OveMP0dbVmabt+cpHE6JeVuEKr3OBBOvfX3sjL1t0DDaM2wiApPEOG2
        gbGvbvgkbyXYgFCaDty5FZ1iNTZuVJpCr6ml0U/vNfNba9pybOFSesEcB09DUR1h33pGUW
        jLE7hXHG0tKgu5hF61Pt/MxhsE4Eh4U=
To:     Song Liu <song@kernel.org>
Cc:     Donald Buczek <buczek@molgen.mpg.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20220607020357.14831-1-guoqing.jiang@linux.dev>
 <20220607020357.14831-3-guoqing.jiang@linux.dev>
 <008f7fe2-b2f6-56bd-913d-966fe7386874@linux.dev>
 <CAPhsuW64cv=gvEy-CzBJqWc7PE9m6hEecdD4pm-8LGVEGPxLjw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <955d14d8-3859-f218-ce5b-896bdc202164@linux.dev>
Date:   Wed, 8 Jun 2022 07:45:06 +0800
MIME-Version: 1.0
In-Reply-To: <CAPhsuW64cv=gvEy-CzBJqWc7PE9m6hEecdD4pm-8LGVEGPxLjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 6/8/22 6:59 AM, Song Liu wrote:
> On Tue, Jun 7, 2022 at 2:46 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> Pls hold on, I will verify it with latest kernel.
>>
>> Thanks,
>> Guoqing
>>
>> On 6/7/22 10:03 AM, Guoqing Jiang wrote:
>>> Since the bug which commit 8b48ec23cc51a ("md: don't unregister sync_thread
>>> with reconfig_mutex held") fixed is related with action_store path, other
>>> callers which reap sync_thread didn't need to be changed.
>>>
>>> Let's pull md_unregister_thread from md_reap_sync_thread, then fix previous
>>> bug with belows.
>>>
>>> 1. unlock mddev before md_reap_sync_thread in action_store.
>>> 2. save reshape_position before unlock, then restore it to ensure position
>>>      not changed accidentally by others.
>>>
>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> This version doesn't really work. Maybe we should ship the revert first?

Agree, pls apply the revert first.

Thanks,
Guoqing
