Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCFECA0C9
	for <lists+linux-raid@lfdr.de>; Thu,  3 Oct 2019 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfJCO6o (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Oct 2019 10:58:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43140 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfJCO6o (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 3 Oct 2019 10:58:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so2627624qke.10
        for <linux-raid@vger.kernel.org>; Thu, 03 Oct 2019 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wS1PbsPMkBiDvleTeqLuzam7fpjw09jnpSeepZxN4eg=;
        b=DEBg7nrgYwzvwqObPUJo6qkYObyj9t0sdWZs8P7csqWrQZsx1Syr2Ecujp+SvzPl30
         nNB4NPHNuu7Bury9xQvXXKry22NVinaE2PRUjQynfBKCA7dOUDWVZzthoiWQfHrRFtId
         ihpAuoI2uvagki1RV/4yCPts1zh21QtVGwo097f1o4iqOhRHF3WrYoDBdOQfvQxZZ2lB
         H6/hqxOpdSOb4G7I06lL7/mlXL4h+T0/+OuvtUK2wOj/qr5W5Q9j1KiwND75h95eW5hh
         RVs+WQUvc4lTrpDJeseKFUkzv9QoVpxjdMNCAUFMiBl/iV148NO2G7S4CC2VVBnoyLvo
         KKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wS1PbsPMkBiDvleTeqLuzam7fpjw09jnpSeepZxN4eg=;
        b=ClPNQC7yTy2cm2zS63lZq+rfSFovpJcf7KHTwqDoKrIA1qAhWMl34Ei6GPEOFJsQ1I
         YAOCj3K34A4Xc/wLC09v7fMR/vi9YbGYq6qzdXvqif9Qqo9v4eMer7JwNSoJz+/mzjV4
         pktLF8F8DHWSLfnkzlZ/BG9ku7LKLrDypbYTFzbj57hoyx3M6tCfsu3JIzWcM79ewgW3
         uBCoPi1o7gHn48av57rcCpGyRGYfUXjhOj89jJJReGt+eU7B29YBnfth6J37YvP4tJIh
         UqfcKfbLFGtblq5XmNEDjUhZAjLleJFpfa4bX/DZvmDqtQQDPRj9g2zOpapb4OCWQPtb
         FdBQ==
X-Gm-Message-State: APjAAAVQs0zFL/rt9qHB3w4wC0uN7U7YXACNdY/jb/h7MzBOjwSQLK6L
        2c/Ja1AgmB0VB+C9IEmsGrAYrdsP
X-Google-Smtp-Source: APXvYqyO+/gSulcDu3HMw2mncE10wwYNxrzQOrRIgyA0VZdiX1v5Dy+fMMCHNpvw1n3sIsYBHFgDbA==
X-Received: by 2002:a37:7d04:: with SMTP id y4mr3914598qkc.34.1570114722236;
        Thu, 03 Oct 2019 07:58:42 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a3:10fb:a464:42a6:e226:d387? ([2620:10d:c091:500::3:da5])
        by smtp.gmail.com with ESMTPSA id l3sm1903866qtc.33.2019.10.03.07.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 07:58:41 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] imsm: save current_vol number
To:     Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20191003075225.22840-1-mariusz.tkaczyk@intel.com>
Message-ID: <a947db4a-702d-2a5f-4d45-ed15823cf013@gmail.com>
Date:   Thu, 3 Oct 2019 10:58:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003075225.22840-1-mariusz.tkaczyk@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/3/19 3:52 AM, Mariusz Tkaczyk wrote:
> The imsm container_content routine will set curr_volume index in super
> for getting volume information. This flag has never been restored to
> original value, later other function may rely on it.
> 
> Restore this flag to original value.
> ---
>   super-intel.c | 2 ++
>   1 file changed, 2 insertions(+)


Hi Mariusz,

Please remember the standard signed-off-by for patch submissions.

Thanks,
Jes


> diff --git a/super-intel.c b/super-intel.c
> index d7e8a65f..39264bef 100644
> --- a/super-intel.c
> +++ b/super-intel.c
> @@ -7826,6 +7826,7 @@ static struct mdinfo *container_content_imsm(struct supertype *st, char *subarra
>   	int sb_errors = 0;
>   	struct dl *d;
>   	int spare_disks = 0;
> +	int current_vol = super->current_vol;
>   
>   	/* do not assemble arrays when not all attributes are supported */
>   	if (imsm_check_attributes(mpb->attributes) == 0) {
> @@ -7993,6 +7994,7 @@ static struct mdinfo *container_content_imsm(struct supertype *st, char *subarra
>   		rest = this;
>   	}
>   
> +	super->current_vol = current_vol;
>   	return rest;
>   }
>   
> 

