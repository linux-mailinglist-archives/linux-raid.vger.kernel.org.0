Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E954CBC73
	for <lists+linux-raid@lfdr.de>; Thu,  3 Mar 2022 12:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiCCLWE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Mar 2022 06:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiCCLWD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 3 Mar 2022 06:22:03 -0500
X-Greylist: delayed 34848 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Mar 2022 03:21:17 PST
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD491768E5
        for <linux-raid@vger.kernel.org>; Thu,  3 Mar 2022 03:21:17 -0800 (PST)
Subject: Re: [PATCH] md: remove most calls to bdevname
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646306475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nagewG6bJXVDUQ/avlmOhsvFUZAZ6rmDXxY1dyGDSfE=;
        b=quZau2UzoMEdCXQII3SJF10h9cyAWg21Y8mncAq82V1N61sua6M3AZ282qXWEQ+pYvVMrH
        GbjyZU0Z3XYikhGASqQA8I115xcjieESh0m5zaqjS1bp20z9V/2nzcZqXezGdbjlG5nJzt
        +loxQwYSGPh1hVdvwvzYW+iBS9T5BG4=
To:     Christoph Hellwig <hch@lst.de>, song@kernel.org
Cc:     linux-raid@vger.kernel.org
References: <20220303110444.320428-1-hch@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <9c966919-e466-f8be-0918-ee24c67472c8@linux.dev>
Date:   Thu, 3 Mar 2022 19:21:11 +0800
MIME-Version: 1.0
In-Reply-To: <20220303110444.320428-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 3/3/22 7:04 PM, Christoph Hellwig wrote:
> Use the %pg format specifier to save on stack consuption and code size.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
