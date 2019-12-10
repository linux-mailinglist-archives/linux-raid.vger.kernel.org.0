Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70411118F5B
	for <lists+linux-raid@lfdr.de>; Tue, 10 Dec 2019 18:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLJRxU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Dec 2019 12:53:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37911 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfLJRxU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 10 Dec 2019 12:53:20 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iejhG-0000L7-JN
        for linux-raid@vger.kernel.org; Tue, 10 Dec 2019 17:53:18 +0000
Received: by mail-io1-f71.google.com with SMTP id p206so97145iod.13
        for <linux-raid@vger.kernel.org>; Tue, 10 Dec 2019 09:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4uVxvhnwYal33PxGgC8vyajMTY17WNQ2yzbPS8Matrw=;
        b=h9LxfuXiTxcUDT6+369ULSCO8i5C8Mmn26UT4EkNlU2/QENrCq/7UKF9F0NEwVmIAk
         vvthH5VZ7JimNZWDwFRt+NHdI4L6474U5h5+5C626Qo8XERcS5QD3FAJigN4gNhfnW/e
         m84CPjFHLqpMYjGJfjm08LITV8Z5dp3zCDIs+VZVrtKOo1vW4naBbKwDDcwo0Z2JBAPi
         8nWcR3+mcQynDR+ebT2ZWbna9zrR+LM9oRymVR/GvHB3WXnsX/uvQbpeirTN1nYEmhb0
         4eDgxGFIbY3ial0FuON50/3s/pzaJI7hqxSoh0JDS63aNtm1vRJ2wTiR0RGpCQes8w9P
         5n1g==
X-Gm-Message-State: APjAAAXNZ9vvIPCasmN3UqADBGs+1XQAOCwymY2EQBgym09MXje2j2u4
        lzjInOHxqogedG9q7roI6Be+ShS2CtgNojztwvL/WAP82/XVP3MWLirPV5mMUiyXbMT8jgjPJy1
        RBzRpYedRs6VrWp52wsZ/XkwxRIFgBqrorDErL+o=
X-Received: by 2002:a6b:f60e:: with SMTP id n14mr5223551ioh.241.1576000397644;
        Tue, 10 Dec 2019 09:53:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqygnzYgBJkiCVm2Zl/roEzOFTXYIyNJcvM/uLYmwq+yRK+u0tsL/8nGzbk1ky9eelk2V6pmyw==
X-Received: by 2002:a6b:f60e:: with SMTP id n14mr5223530ioh.241.1576000397321;
        Tue, 10 Dec 2019 09:53:17 -0800 (PST)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id s10sm851470ioc.4.2019.12.10.09.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 09:53:16 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:53:15 -0700
From:   dann frazier <dann.frazier@canonical.com>
To:     Jes Sorensen <jes@trained-monkey.org>
Cc:     Helmut Grohne <helmut@subdivi.de>, linux-raid@vger.kernel.org,
        "Maxin B. John" <maxin.john@intel.com>
Subject: Re: [PATCH] Respect $(CROSS_COMPILE) when $(CC) is the default
Message-ID: <20191210175315.GA99871@xps13.dannf>
References: <20191209205413.6839-1-dann.frazier@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209205413.6839-1-dann.frazier@canonical.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

[ + Maxin - apologies for omitting you for the original ]

On Mon, Dec 09, 2019 at 01:54:13PM -0700, dann frazier wrote:
> Commit 1180ed5 told make to only respect $(CROSS_COMPILE) when $(CC)
> was unset. But that will never be the case, as make provides
> a default value for $(CC). Change this logic to respect $(CROSS_COMPILE)
> when $(CC) is the default. Patch originally by Helmet Grohne.
> 
> Fixes: 1180ed5 ("Makefile: make the CC definition conditional")
> Signed-off-by: dann frazier <dann.frazier@canonical.com>
> ---
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index dfe00b0a..a33319a8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -46,7 +46,9 @@ ifdef COVERITY
>  COVERITY_FLAGS=-include coverity-gcc-hack.h
>  endif
>  
> -CC ?= $(CROSS_COMPILE)gcc
> +ifeq ($(origin CC),default)
> +CC := $(CROSS_COMPILE)gcc
> +endif
>  CXFLAGS ?= -ggdb
>  CWFLAGS = -Wall -Werror -Wstrict-prototypes -Wextra -Wno-unused-parameter
>  ifdef WARN_UNUSED
