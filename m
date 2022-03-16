Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBDF4DAF5A
	for <lists+linux-raid@lfdr.de>; Wed, 16 Mar 2022 13:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355528AbiCPMK4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Mar 2022 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348240AbiCPMKz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 16 Mar 2022 08:10:55 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A556E53B52
        for <linux-raid@vger.kernel.org>; Wed, 16 Mar 2022 05:09:40 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5aef39.dynamic.kabel-deutschland.de [95.90.239.57])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7D5AC61EA192E;
        Wed, 16 Mar 2022 13:09:38 +0100 (CET)
Message-ID: <2525f804-6cc4-b040-475f-52d2090c00db@molgen.mpg.de>
Date:   Wed, 16 Mar 2022 13:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] mdadm: Respect config file location in man.
Content-Language: en-US
To:     Lukasz Florczak <lukasz.florczak@linux.intel.com>
References: <20220315085549.59693-1-lukasz.florczak@linux.intel.com>
 <20220315085549.59693-2-lukasz.florczak@linux.intel.com>
 <91ed523b-9518-1beb-039d-ab00b1bb0b44@molgen.mpg.de>
 <722c05$g3qed5@orsmga007-auth.jf.intel.com>
Cc:     linux-raid@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <722c05$g3qed5@orsmga007-auth.jf.intel.com>
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

Dear Lukasz,


Am 16.03.22 um 13:03 schrieb Lukasz Florczak:

> Thanks for reviewing my patch.

Thank you for your reply.

> On Tue, 15 Mar 2022 13:39:25 +0100, Paul Menzel wrote:

>> Am 15.03.22 um 09:55 schrieb Lukasz Florczak:
>>
>> It’d be great if you removed the dot/period at the end of the git
>> commit message summaries [1]. (Also in second patch.)
> 
> Noted.
> 
>>> Default config file location could differ depending on OS (e.g.
>>> Debian family).
>>
>> What is it an Debian?
> 
> Could you elaborate?

Sorry, I meant what is the location/path in Debian based systems, and 
what is the configured path before your patch.

>>   [...]
>>
>> Looks like an independent fix. Please separate into a separate commit.
> 
> It's just adding a missing option. I don't think that it deserves a
> separate commit. How about I will update the commit body to include
> this particular change?

Git makes it easy to handle small commits, so I favor two commits also 
because it wouldn’t be lost in case of a revert. But I have no say in 
the project, and opinions differ, so it’s just an opinion.

[…]


Kind regards,

Paul
