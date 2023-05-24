Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED7B70F00B
	for <lists+linux-raid@lfdr.de>; Wed, 24 May 2023 09:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjEXH6w (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 24 May 2023 03:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjEXH6w (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 24 May 2023 03:58:52 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD7093
        for <linux-raid@vger.kernel.org>; Wed, 24 May 2023 00:58:50 -0700 (PDT)
Received: from [192.168.0.185] (unknown [95.90.238.68])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 68C8361EA1BFF;
        Wed, 24 May 2023 09:56:32 +0200 (CEST)
Message-ID: <b2cd227c-cca0-12a8-5716-79e7b690a591@molgen.mpg.de>
Date:   Wed, 24 May 2023 09:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH tests 0/5] tests: add some regression tests
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     yukuai3@huawei.com, yangerkun@huawei.com,
        linux-raid@vger.kernel.org, mariusz.tkaczyk@linux.intel.com,
        jes@trained-monkey.org, logang@deltatee.com, song@kernel.org
References: <20230523133900.3149123-1-yukuai1@huaweicloud.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230523133900.3149123-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Yu,


Thank you so very much for adding tests. For those unfamiliar with the 
test framework, could you add one line how to run the newly added tests?


Kind regards,

Paul


PS: Your participation in and contributions to the Linux kernel are very 
much appreciated. Great work, and good to have you.
