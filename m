Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5834965887
	for <lists+linux-raid@lfdr.de>; Thu, 11 Jul 2019 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfGKOKS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 11 Jul 2019 10:10:18 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33028 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGKOKS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 11 Jul 2019 10:10:18 -0400
Received: by mail-ua1-f66.google.com with SMTP id g11so2526212uak.0
        for <linux-raid@vger.kernel.org>; Thu, 11 Jul 2019 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MN3Bi1S2xrd4ujHVxTpiRUcSQD4rSoXK+fFtaeXrQoE=;
        b=MvSqlWipQzSgBuQh6rykc/SsEYcSa5Bp9g8fG65R3NCzxnFICArmXSKVZP2LZTc7Sv
         PwemHUoiQEFXVn8ElMZvFZlBhVLv1KcxlJgkZJkusR5odWj3QfC6pcCQvfvg7C5TSi+X
         cTNeCB4McSn/T+qRQ12xbYu41xe1jIkS4eIJvguS4Gl+iGPg+o3sSr59Uc0FwEYExqqk
         3Eby0r1XvRg9Lf2r0dQGCkxk2A09NOzaZcvm3KXxvz05P7BpLatPdMd6xualvH0Z2lKo
         1HQ/tziHBuc5NZZ1JHcIPdsA/KRLxRbNORa4HhuGjzikVO6obyiuluYTULiYr9MyDBap
         QBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MN3Bi1S2xrd4ujHVxTpiRUcSQD4rSoXK+fFtaeXrQoE=;
        b=uhyNFvo2+Rg4G7pPo+cT4H+lyV976wYH4xoklljyYeNFkbY/ppXPrBdzmThL0T0+5I
         n9Hm0idgVGj9d/kZHsTDQC2MDpwwe321SfxtNFr8h4UPoKm5pjA0yUWsizt4vGS2sloZ
         DgjMCUH70w85B8NcPgl1ZqHGWCkTB+37dwbUUfqf1Tm3zQ+ZVsgvZxDBRitA4nQWE/rj
         usNjbbxOES7dzSwYKGp4ZUHvqUL/JQ2N+/U2QrDsRNegwYTDZDJ6jOSQBGKL16KibPKl
         SQ5U98OrBsHEMboeGmOxr//ijHSplC+OaWRHJuTKwbpf0vvrzpHDsK9iY8Z6+2vigqtk
         SrNQ==
X-Gm-Message-State: APjAAAXksVYVpG/CPnopa0RFPZK2bri2Eh8jUuXp4wI1gg1ufScCgO+B
        n1syK4Hhf32wjSXUH/qleMEjuxlUnIA=
X-Google-Smtp-Source: APXvYqy2XWMupMQhXPTSUxqe8iB6wSl2CEHD220I3iTbWOw1h5Sg10fQzyGLZ+tw1mp2GCFs51pmWQ==
X-Received: by 2002:ab0:740e:: with SMTP id r14mr4471273uap.108.1562854216363;
        Thu, 11 Jul 2019 07:10:16 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1004? ([2620:10d:c091:480::b609])
        by smtp.gmail.com with ESMTPSA id u65sm1793870vsu.34.2019.07.11.07.10.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 07:10:15 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] imsm: Change in --detail-platform for NVMe devices
To:     Blazej Kucman <blazej.kucman@intel.com>, linux-raid@vger.kernel.org
References: <20190711065911.3237-1-blazej.kucman@intel.com>
Message-ID: <2465b2ae-f3d4-a050-7161-ed6c9525110f@gmail.com>
Date:   Thu, 11 Jul 2019 10:10:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711065911.3237-1-blazej.kucman@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/11/19 2:59 AM, Blazej Kucman wrote:
> Change NVMe controller path to device node path
> in mdadm --detail-platform and print serial number.
> 
> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
> ---
>  super-intel.c | 75 ++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 38 insertions(+), 37 deletions(-)

So my primary concern with this patch is if it has any negative impact
on older kernels, given that you change the assumptions for how it walks
/sys? I didn't look in detail, but I want to make sure we don't break
things if we don't have to.

Cheers,
Jes
