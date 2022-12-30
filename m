Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0AC65218D
	for <lists+linux-raid@lfdr.de>; Tue, 20 Dec 2022 14:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiLTN3X (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 20 Dec 2022 08:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiLTN25 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 20 Dec 2022 08:28:57 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6FB1159
        for <linux-raid@vger.kernel.org>; Tue, 20 Dec 2022 05:28:36 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5AB3C60027FC1;
        Tue, 20 Dec 2022 14:28:35 +0100 (CET)
Message-ID: <b3b9c211-5374-7d3c-d65f-e738d4ce3046@molgen.mpg.de>
Date:   Tue, 20 Dec 2022 14:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] manage: move comment with function description
Content-Language: en-US
To:     Kinga Tanska <kinga.tanska@intel.com>
Cc:     linux-raid@vger.kernel.org, jes@trained-monkey.org, colyli@suse.de,
        xni@redhat.com
References: <20221220051433.14987-1-kinga.tanska@intel.com>
 <20221220051433.14987-3-kinga.tanska@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221220051433.14987-3-kinga.tanska@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Kinga,


Thank you for sending the iteration. Please mark the iteration. The 
switch -v/--reroll-count helps with that.

Am 20.12.22 um 06:14 schrieb Kinga Tanska:
> Moving commit description from the body of function

s/commit/function/

> outside to obey kernel coding style.

Maybe:

Move the function description from the function body to outside to obey 
kernel coding style.

> Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>

With that fixed:

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>

> ---
>   Manage.c | 72 ++++++++++++++++++++++++++++++++++----------------------
>   1 file changed, 44 insertions(+), 28 deletions(-)

[…]


Kind regards,

Paul
