Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBA758E71A
	for <lists+linux-raid@lfdr.de>; Wed, 10 Aug 2022 08:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiHJGFX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 10 Aug 2022 02:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiHJGFF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 10 Aug 2022 02:05:05 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28DA61D42
        for <linux-raid@vger.kernel.org>; Tue,  9 Aug 2022 23:05:02 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aec83.dynamic.kabel-deutschland.de [95.90.236.131])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B2AAB61EA192C;
        Wed, 10 Aug 2022 08:04:59 +0200 (CEST)
Message-ID: <82583f41-31a2-0aa5-76e6-530218e3f593@molgen.mpg.de>
Date:   Wed, 10 Aug 2022 08:04:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH] md/raid10: Fix a recently introduced sparse warning
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        Rong A Chen <rong.a.chen@intel.com>,
        Jens Axboe <axboe@kernel.dk>, kernel test robot <lkp@intel.com>
References: <20220809181358.3111654-1-bvanassche@acm.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220809181358.3111654-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Bart,


Thank you for the patch. I’d prefer the commit message summary to be 
specific about the change, as there are several sparse warnings. Maybe:

> Update r10_sync_page_io() to take req_op over int

Otherwise, this looks good to me.


Kind regards,

Paul
