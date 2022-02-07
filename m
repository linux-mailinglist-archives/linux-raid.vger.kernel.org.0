Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1104F4AB645
	for <lists+linux-raid@lfdr.de>; Mon,  7 Feb 2022 09:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiBGIEZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 7 Feb 2022 03:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242721AbiBGHyv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 7 Feb 2022 02:54:51 -0500
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:54:49 PST
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D886AC043184
        for <linux-raid@vger.kernel.org>; Sun,  6 Feb 2022 23:54:49 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee58.dynamic.kabel-deutschland.de [95.90.238.88])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3FA6161E64846;
        Mon,  7 Feb 2022 08:48:29 +0100 (CET)
Message-ID: <ed944c96-7112-6a72-2a9b-2f809ddf3ba6@molgen.mpg.de>
Date:   Mon, 7 Feb 2022 08:48:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] fix multiple definition linking error due to missing
 extern
Content-Language: en-US
To:     =?UTF-8?Q?Dirk_M=c3=bcller?= <dmueller@suse.de>
References: <20220206205137.21717-1-dmueller@suse.de>
Cc:     linux-raid@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220206205137.21717-1-dmueller@suse.de>
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

Dear Dirk,


Am 06.02.22 um 21:51 schrieb Dirk Müller:

It’d be great of you added a prefix in the commit message summary. Maybe:

> lib/raid6/test: fix multiple definition linking error due to missing extern

> GCC 10+ defaults to -fno-common, which enforces proper declaration of
> external references using "extern". without this change a link would

Nit: Without

> fail with:
> 
>    lib/raid6/test/algos.c:28: multiple definition of `raid6_call';
>    lib/raid6/test/test.c:22: first defined here
> 
> Signed-off-by: Dirk Müller <dmueller@suse.de>

Thank you for properly analyzing and fixing it in a better way than my 
(non-working) attempt [1].

Should it be tagged for the stable series, that means CC’ed to 
<stable@vger.kernel.org>?

> ---
>   lib/raid6/test/test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/raid6/test/test.c b/lib/raid6/test/test.c
> index a3cf071941ab..ab0459150a61 100644
> --- a/lib/raid6/test/test.c
> +++ b/lib/raid6/test/test.c
> @@ -19,7 +19,7 @@
>   #define NDISKS		16	/* Including P and Q */
>   
>   const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
> -struct raid6_calls raid6_call;
> +extern struct raid6_calls raid6_call;
>   
>   char *dataptrs[NDISKS];
>   char data[NDISKS][PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


[1]: 
https://lore.kernel.org/linux-raid/20220126114144.370517-3-pmenzel@molgen.mpg.de/T/#u
