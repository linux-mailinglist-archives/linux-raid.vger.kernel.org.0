Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5D903BE
	for <lists+linux-raid@lfdr.de>; Fri, 16 Aug 2019 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfHPONa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 10:13:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37273 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfHPONa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 16 Aug 2019 10:13:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so6237022qto.4
        for <linux-raid@vger.kernel.org>; Fri, 16 Aug 2019 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qy5GDw4YnDtRNrWZXbg7LJXln11ADySzzmhI8UzudsQ=;
        b=fSMKCPnHG4ExdkclmkRtaFJ4+0SLl0oO4Bdpbt5vh7Y2EDwFUJvMaoJjEehgBSlJkk
         ZNR0hKzHl0h3rbuIopBb3jM82YxqQ4ttVRX5fcouoeARgRvJ1d/i5nHMhZcjBJr6Axdq
         RS38q5FRD44WMLhtOhHl2kqBqKSdODJltH6BeBWAPq+WOiZQW49umxxaCZMsuGMXDaop
         qzbbxBzSdylKWQjo4uEtr4WBVdIInTZndqSJsjYqkULx0HutPIiVEHsMzUkiQVF1GWmr
         E4khu1Lt6EGZPbh+EzK0E496Nb/z4LtBj8xcVXERwgFauLHTmuwpb0MtVl+n4EnKhhlh
         MyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qy5GDw4YnDtRNrWZXbg7LJXln11ADySzzmhI8UzudsQ=;
        b=g0f0CeLW+Xvo9rQhZVvWuZMbhJqjIMVvb43bkl9d9AkUxriyIDWAFJBuNYTHyr2ot4
         9GmRXGKsJf0bePOTRS0PobdAm6gferAj3EFBPuO1Hh+lMfofWsoOgM5mGd4BK7qskqEG
         4WkstX/5Xqaj7ltvCero5zEeBiRG0IuQaGYW2wq3VU08Hh/YkZVucFJsLoshTQRBSLuk
         63vedD4dyAthYDXorwiRtNlLQg+ZHiR0TdJffbOTK8Cb8fQmRm/gz8aResL/3PPTrzag
         JUPpOM2AktPOKa6FYGHBRd/H4KF4XGnMyfYAMyed5bqLanqWlWLQVzTiTggt9nGHnBBq
         YFGA==
X-Gm-Message-State: APjAAAWhdBov+Pi96YY+VvTfNV4kDv5Fe/7kEi8Nqz3Hinivu0Se2wMC
        FgBoi9G8x//yaBySvfBtn7UnUCV+
X-Google-Smtp-Source: APXvYqxbv7ldKtba8LcUcOf+juZhvo4giqh/qb6bsS+iVfygQg/31hb6TzCJqA+HgKBlDCN4yjq7Rg==
X-Received: by 2002:ac8:1c42:: with SMTP id j2mr8770737qtk.68.1565964808524;
        Fri, 16 Aug 2019 07:13:28 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::108b? ([2620:10d:c091:480::e737])
        by smtp.gmail.com with ESMTPSA id o29sm3213178qtf.19.2019.08.16.07.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 07:13:27 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] imsm: data offset support during first volume creation
To:     Krzysztof Smolinski <krzysztof.smolinski@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20190816092633.12889-1-krzysztof.smolinski@intel.com>
Message-ID: <b67c7f90-43aa-8eca-acbb-562ee6a8c8e1@gmail.com>
Date:   Fri, 16 Aug 2019 10:13:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190816092633.12889-1-krzysztof.smolinski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/16/19 5:26 AM, Krzysztof Smolinski wrote:
> When creating first volume in IMSM container --data-offset
> parameter can be provided to specify volume data offset (reserve
> space preceding volume start). When no value is provided then 1 MiB
> default value is used.
> 
> Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
> ---
>  mdadm.8.in    | 12 ++++++---
>  mdadm.c       | 28 +++++++++++++--------
>  mdadm.h       |  7 +++---
>  super-intel.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  util.c        |  2 +-
>  5 files changed, 101 insertions(+), 28 deletions(-)

A couple of minor nits:

> diff --git a/mdadm.c b/mdadm.c
> index 1fb80860..7fdad606 100644
> --- a/mdadm.c
> +++ b/mdadm.c
> @@ -384,21 +384,27 @@ int main(int argc, char *argv[])
>  		case O(CREATE,ChunkSize):
>  		case O(BUILD,'c'): /* chunk or rounding */
>  		case O(BUILD,ChunkSize): /* chunk or rounding */
> +		{
> +			unsigned long long tmp_chunk;

Please don't do this, it's incredibly ugly. Just declare tmp_chunk
globally in the function if you have to. You're using it again below as
well.

> +		if (sector_size == 4096)
> +			super->create_offset = convert_to_4k_data_offset(data_offset);
> +		else
> +			super->create_offset = data_offset;
> +	} else if (data_offset == INVALID_SECTORS && super->current_vol == 0) {
> +		// set default data offset for first volume
> +		super->create_offset = DEFAULT_VOLUME_DATA_OFFSET / super->sector_size;

Use proper comments please

Cheers,
Jes
