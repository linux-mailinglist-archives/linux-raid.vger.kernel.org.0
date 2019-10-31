Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FADEA8F8
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 02:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfJaBrU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 21:47:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33150 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfJaBrU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 30 Oct 2019 21:47:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id y39so6347955qty.0
        for <linux-raid@vger.kernel.org>; Wed, 30 Oct 2019 18:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0/1b84DsuMY3wmIexQMB7/BBxaXzijlvLS4Yv/4skMA=;
        b=EvEvlHsttLSSiOGNlqCClP9juRQJe9F4Bj0NZQf8iYLoo4GIdTMHTefwNEPlH5InP3
         dittPkJqUM/E2V5eUY61lRVifKqIp7CjbRMrJt4wnI0yiRkcKuuKJOX8pg155OspHYDX
         8CIHVGDc1cxlyuDHEaKK1A48Hd1bz1Gs/6NGuyl++kk01CI/E6AaPo3XzVMshDNZ8RiX
         +1K+h2/UjSKF/x3f/DQXBKjumEbf8Q/RJFpcZl61r29+vwl/zibfsMJ/tLEHwi/iZk+R
         jH7buOUcIN9qdYIPFUc0sJCzoYb66HCnYFtYfhRkedj4F0mx0fQYSNoib8ahx72iGn38
         pB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0/1b84DsuMY3wmIexQMB7/BBxaXzijlvLS4Yv/4skMA=;
        b=MFkmQY9jjFN6/H9UHqpenLeqSPsu85/9kSXO+MdYvvBzQabJZdTDsndMNJy6ptZVwT
         Ux4w/rGrIty1SuJUu+4Yj0R7xwMDCKA0e200Xbph0WH3MTcv6JoDLbtdjNU1dJzckNZo
         Mn1Y6DluUweII5n0m+1CMSD29Vo5qCcTqI3enBXTMfE6qkR2xCVxAMxuaZ+wzgZDeCdr
         fKzFQwdcviAJztdosJmcY9hM9zRpj99TrWELL4ucc4Ey9nYjsJaTsI9bFq5aiboOkOHa
         fCQnGAktAo5BNM7HWy1fN1YBugZvwQj12aIFsdzcHhr93rDsayKIqt90UYv4+ViNb9ZA
         Nvyg==
X-Gm-Message-State: APjAAAXREd62u5N79+UBs0gsHcW0JQ/ot7YENNIBT5IMbE4unp/MXTFG
        fFhl/V+IoPKz34XEggmNElA=
X-Google-Smtp-Source: APXvYqyGxnEIqbqDwaIxiG7pGxeNtObIdJA0cFRB3RWJuhhHgxv86BHEjRRvo1Hlr2WDQY5K5v3kpA==
X-Received: by 2002:a0c:b0fa:: with SMTP id p55mr2300868qvc.239.1572486437673;
        Wed, 30 Oct 2019 18:47:17 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1001? ([2620:10d:c091:480::8fd2])
        by smtp.gmail.com with ESMTPSA id 11sm1224353qkv.131.2019.10.30.18.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 18:47:16 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH mdadm] Makefile: support latest gcc:
 address-of-packed-member
To:     NeilBrown <neilb@suse.de>
Cc:     linux-raid@vger.kernel.org,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>
References: <87k18leqf2.fsf@notabene.neil.brown.name>
Message-ID: <1f57b1a1-70bd-15a4-4693-1b72aa5546f1@gmail.com>
Date:   Wed, 30 Oct 2019 21:47:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87k18leqf2.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/30/19 7:58 PM, NeilBrown wrote:
> 
> super-intel often takes the address of a packed member,
> and seems to work.
> So suppress this warning.
> (Earlier gcc ignore the new flag)
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

I am kinda in two minds about this. I started cleaning up some of the 
newer gcc stuff a while ago, but then got stuck on super-intel.c

I want the code to build, but I also feel super-intel.c needs cleaning 
up and made to use accessor functions or something like that to deal 
with these accesses in a better way?

Thoughts?

Cheers,
Jes


> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index dfe00b0a0be8..0768cc5b566e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -48,7 +48,7 @@ endif
>   
>   CC ?= $(CROSS_COMPILE)gcc
>   CXFLAGS ?= -ggdb
> -CWFLAGS = -Wall -Werror -Wstrict-prototypes -Wextra -Wno-unused-parameter
> +CWFLAGS = -Wall -Werror -Wstrict-prototypes -Wextra -Wno-unused-parameter -Wno-address-of-packed-member
>   ifdef WARN_UNUSED
>   CWFLAGS += -Wp,-D_FORTIFY_SOURCE=2 -O3
>   endif
> 

