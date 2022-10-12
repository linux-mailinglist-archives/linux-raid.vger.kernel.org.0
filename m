Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D05FC413
	for <lists+linux-raid@lfdr.de>; Wed, 12 Oct 2022 12:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJLK7B (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Oct 2022 06:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLK7A (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 12 Oct 2022 06:59:00 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A84B6007
        for <linux-raid@vger.kernel.org>; Wed, 12 Oct 2022 03:58:59 -0700 (PDT)
Subject: Re: Memory leak when raid10 takeover raid0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665572337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwN6ckNoy8yHrzUuqImL71Xuja/zCoMe+2N49p8onH0=;
        b=R5U57RANVIQo0AcvHVVO10vKL8+CBso6pn6ycGwzHCyVqDQ+Dkpl08s8nuqHqtB1+21A5o
        KUf3nMxbj5SWgTkYvN25uCBxGWppncNfEP+JRJ5tKvk0JVt6CPDLBgW0gXc900Rre99vIk
        Kl0dBwp595glNSIQ4LWFAcXzt8yp60I=
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, Song Liu <song@kernel.org>
References: <CALTww2-EAeM6aKeZbZ2udTwS5RFwNWfF9uag=npewB9j0H51Hw@mail.gmail.com>
 <35f4a626-7f83-56c5-4cad-73ede197ccbf@linux.dev>
 <CALTww2_jaUVEk-zeobWSn9+yDYfkESKEX6hAKZ+-O+dMzQS+Hg@mail.gmail.com>
 <861e6a43-40f6-a214-a72b-f641f9b6bc29@linux.dev>
 <CALTww2_FHYi7nsox4P4Mw+wFwUjZ8KPuuPCWXpwwB-e2XrRK+A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <c103f890-f1a5-9b3a-0d3a-ff56a38b3595@linux.dev>
Date:   Wed, 12 Oct 2022 18:58:57 +0800
MIME-Version: 1.0
In-Reply-To: <CALTww2_FHYi7nsox4P4Mw+wFwUjZ8KPuuPCWXpwwB-e2XrRK+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 10/11/22 11:49 PM, Xiao Ni wrote:
>> I finally reproduced it with 6.0 kernel, and It is a NULL dereference.
> That's cool. Could you share the steps?

Do the two things simultaneously.

1. write to raid0
2. echo raid10 > /sys/block/md/mdx/level

Thanks,
Guoqing
