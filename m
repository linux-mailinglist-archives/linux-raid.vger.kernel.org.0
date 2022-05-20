Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272D352F3C5
	for <lists+linux-raid@lfdr.de>; Fri, 20 May 2022 21:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345830AbiETT3n (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 May 2022 15:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347802AbiETT3n (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 20 May 2022 15:29:43 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2D9195BE2
        for <linux-raid@vger.kernel.org>; Fri, 20 May 2022 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
        MIME-Version:Date:Message-ID:cc:content-disposition;
        bh=39UEJD6aSL9Yob2972qu3vDAJPW05F9BZs1wUTeDZD8=; b=il9MjwYGvzZNJn/rDGhNZGkFbf
        9pwZ05r/x0B35hcnwYuO4yQmM8jLtXca0axu976vtAuwTk2DWfjBW3qJDsW7nAwqR2EdejdT6q36L
        ggHrynSwMjWYK1/cwDH8LoB5p4FAYcey6f7dV1B0oHHbHWS2EDlcVjxp31ufVEAgxpQZCW8NlQm2F
        CLciymnoAnzgSHgVzrsX1GiU21vfvxEdkOQnEdpbGV2Fgok5UZuhJQne3fGOQcoc5ZigqNib7NPhv
        bNx4ClalwYQHqFJ7z7N2Dvm/O7JdJfTMC9RStbqCilGMYxOI6ftR38sdcFQE+kdYtLTVqjn1ijHuy
        EqTjFGpw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ns8Je-003GKP-QH; Fri, 20 May 2022 13:29:39 -0600
Message-ID: <22bc60e6-97e4-e798-a28f-6d6305f87557@deltatee.com>
Date:   Fri, 20 May 2022 13:29:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-CA
To:     himanshu.madhani@oracle.com, linux-raid@vger.kernel.org
References: <20220510170920.18730-1-himanshu.madhani@oracle.com>
 <20220510170920.18730-7-himanshu.madhani@oracle.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220510170920.18730-7-himanshu.madhani@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: himanshu.madhani@oracle.com, linux-raid@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v3 6/7] tests: fix $dir path
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org




On 2022-05-10 11:09, himanshu.madhani@oracle.com wrote:
> From: Sudhakar Panneerselvam <sudhakar.panneerselvam@oracle.com>
> 
> Some of the test cases use $dir to refer to the location of mdadm and
> other test binaries. But $dir was never initialized anywhere in the test
> sequence.

I noticed this too in a couple tests, but IMO I'd rather see the
variable removed instead of blindly fixed without specifying the effects
on the tests that use it.

For example, I've noticed that 07testreshape5 uses it, but once fixed,
the test still fails.

A bunch of 10ddf tests have it but those lines are commented out.

A bunch of 19*repair tests use it but they don't seem to fail for me
before the fix so there is likely some other brokenness involved.

Logan
