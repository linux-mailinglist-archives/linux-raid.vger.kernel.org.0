Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ABE5245AC
	for <lists+linux-raid@lfdr.de>; Thu, 12 May 2022 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241692AbiELGZf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 May 2022 02:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350196AbiELGZe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 12 May 2022 02:25:34 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A80C59972;
        Wed, 11 May 2022 23:25:32 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeace.dynamic.kabel-deutschland.de [95.90.234.206])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4C1EE61EA192A;
        Thu, 12 May 2022 08:25:29 +0200 (CEST)
Message-ID: <290eada6-226a-6570-1860-c4ca1d680993@molgen.mpg.de>
Date:   Thu, 12 May 2022 08:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] md: remove most calls to bdevname
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20220512061913.1826735-1-hch@lst.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220512061913.1826735-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Christoph,


Thank you for the patch.

Am 12.05.22 um 08:19 schrieb Christoph Hellwig:
> Use the %pg format specifier to save on stack consuption and code size.

consu*m*ption

Did you do any measurements?

[…]


Kind regards,

Paul
