Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447BD1E452D
	for <lists+linux-raid@lfdr.de>; Wed, 27 May 2020 16:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgE0OFf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 27 May 2020 10:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbgE0OFf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 27 May 2020 10:05:35 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0655C08C5C1
        for <linux-raid@vger.kernel.org>; Wed, 27 May 2020 07:05:34 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b27so14392112qka.4
        for <linux-raid@vger.kernel.org>; Wed, 27 May 2020 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=crnB5mJ/or+sek9y5i8lwdccBMEjXT5LF3lAhbEbG3I=;
        b=fLIki6OGgeMg6at0bNniZaz+Fs4kXbkNwKHFICizBCYjY9Jd8O1R6Staly0XHY9PsR
         3PRfKFAh49nJmmxc0msYExGBhEUQqthCvPsc1OUHyGhzJ4+QOlchBAGmdqzYM4svOBve
         Tnvr9qmXRa9E5ITBuCz3umSYv3vSLhu9vZpGtj7r6sZ1UDb3jRRXhUm4K2lCFj9QJIls
         5OB5BblXpH8+x1unsXgbQDBrmLKMXvly9JeEPdqUaAS9WFq18fVU/WbsHtmmh8cTuRz4
         h2ZA9CdYCWOJIPLLgfaEm+owoa52QBCc9mYy/vKpyIsjEWX1nUtr45+igNAyeT3ze23f
         4zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=crnB5mJ/or+sek9y5i8lwdccBMEjXT5LF3lAhbEbG3I=;
        b=X5yOuCo/o1kqiUaiiwP2DiMWX0kLyBVec0F+SYHhqOxaDexrtYQuM9iNQwVBatbsX8
         yy68aXETOLnLYiMddCTvv/fwf7PadWs8NQRvhW5k/UrfSDflUwBinYtA0y5D8rbcAz0P
         V+G4ep8OJTF/cYIwSPkXaHIR20hnLIswvnqWmbdkJ0t3hsGLxgvBRL0NNrmgEkog/G3x
         HzcC49CRBnx6puYIriTAqiM0mqrnwveDaMWcmjpq3IE8aHw3MHCTZD0xUmr3m5NiDww9
         CJMUu0i00g6kHWfByorrLuUy/Sf3T56MO5qnPN3XZmqz6EL9xPqN63ur3OQ6t3DULuMD
         CjiA==
X-Gm-Message-State: AOAM533rVsh8FvLdl/xkGJT/kJeTj3tHU3qtPOdGgxOxxtUcHjDCon10
        O1pp+FivPvkLeml61GLrnFGfnOiD
X-Google-Smtp-Source: ABdhPJxuqWArMidGl4lLRdpPa1QBg1juRbHGgrDimwz9mU+FNkizAgog4a5j0GXuUBhOrrfIXI5tlg==
X-Received: by 2002:ae9:ef8c:: with SMTP id d134mr4352976qkg.66.1590588333484;
        Wed, 27 May 2020 07:05:33 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::107f? ([2620:10d:c091:480::1:8061])
        by smtp.gmail.com with ESMTPSA id r37sm2352124qtk.34.2020.05.27.07.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 07:05:32 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] Block overwriting existing links while manual assembly
To:     Kinga Tanska <kinga.tanska@intel.com>, linux-raid@vger.kernel.org
References: <20200527071443.20998-1-kinga.tanska@intel.com>
Message-ID: <1a2efdb3-e669-f4db-b718-7252dd9dde0c@gmail.com>
Date:   Wed, 27 May 2020 10:05:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527071443.20998-1-kinga.tanska@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/27/20 3:14 AM, Kinga Tanska wrote:
> Manual assembly with existing link caused overwriting
> this link. Add checking link and block this situation.
> 
> Change-Id: I29ef58636e8fd8583bcaef1b28b6cf2edec385ef
> Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
> ---
>  Assemble.c | 4 ++++
>  1 file changed, 4 insertions(+)

Looks fine to me, but what is that non-standard Change-Id: tag you added?

Thanks,
Jes

> diff --git a/Assemble.c b/Assemble.c
> index 6b5a7c8e..92616251 100644
> --- a/Assemble.c
> +++ b/Assemble.c
> @@ -1482,6 +1482,10 @@ try_again:
>  				name = content->name;
>  			break;
>  		}
> +		if (mddev && map_by_name(&map, mddev) != NULL) {
> +			pr_err("Cannot create device with %s because is in use\n", mddev);
> +			goto out;
> +		}
>  		if (!auto_assem)
>  			/* If the array is listed in mdadm.conf or on
>  			 * command line, then we trust the name
> 

