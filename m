Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A833353F345
	for <lists+linux-raid@lfdr.de>; Tue,  7 Jun 2022 03:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiFGBUq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jun 2022 21:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiFGBUp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jun 2022 21:20:45 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2998F8DDEE
        for <linux-raid@vger.kernel.org>; Mon,  6 Jun 2022 18:20:43 -0700 (PDT)
Subject: Re: [PATCH] md: only unlock mddev from action_store
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654564841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PiKmkdcmG9lX0ST/yAFmyucnnDx84SolqJGCIdmVGW0=;
        b=ipzK/2nI9hGI38AWk1xnWBhY1H7qKHWXjLC2ZXDPSORm5arHp4rjnL1cnMJpRFwwiiUTfJ
        3amLLZfvihAcvH0dGBRcuNa4jbI80GQjxtG2NkAsLG06K3ebfKI2cTmWTd8B1YYedtvosQ
        GKj+VqU2kS7wlbgLGhjBYlctpHPTGSY=
To:     Logan Gunthorpe <logang@deltatee.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, buczek@molgen.mpg.de
References: <20220602134509.16662-1-guoqing.jiang@linux.dev>
 <a6a1183b-35ca-b321-cbd5-08e2a9e29ca3@deltatee.com>
 <9b25a8d4-bedf-35bb-6928-3cd49a025460@linux.dev>
 <2e8ae871-8349-2253-fcce-2722b03fe21d@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <050d869e-07a8-18b2-7a77-4a459e93dab3@linux.dev>
Date:   Tue, 7 Jun 2022 09:20:36 +0800
MIME-Version: 1.0
In-Reply-To: <2e8ae871-8349-2253-fcce-2722b03fe21d@deltatee.com>
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



On 6/6/22 11:48 PM, Logan Gunthorpe wrote:
>> After move "md_unregister_thread(&mddev->sync_thread)", then we need to
>> rename md_reap_sync_thread given it doesn't unregister sync_thread, any
>> suggestion about the new name? md_behind_reap_sync_thread?
> I don't like the "behind"... Which would be a name suggesting when the
> function should be called, not what the function does.

Right, naming is hard.

> I'd maybe go with something like md_cleanup_sync_thread()

It is confusing since it doesn't related with sync_thread anymore after 
the pull.
I will keep the name unchanged for now.

Thanks,
Guoqing
