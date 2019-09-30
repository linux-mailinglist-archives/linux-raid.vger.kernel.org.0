Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB8C2713
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfI3Ups (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 16:45:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37975 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730693AbfI3Ups (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Sep 2019 16:45:48 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1iF1Ws-00057Z-IH
        for linux-raid@vger.kernel.org; Mon, 30 Sep 2019 19:40:18 +0000
Received: by mail-pl1-f199.google.com with SMTP id d1so5837346plj.9
        for <linux-raid@vger.kernel.org>; Mon, 30 Sep 2019 12:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=09P9hryk4X9pxrU6lU1eu8xnMAXUu4sGNFiOeA8zkAc=;
        b=fbbzi1pk8aANcyw/mvnd0RvbUz4U6he/ctQgewfJxUUDwOIIghrRDkmhUL0x3BbUGP
         BzjHk8heA4+ItF1nZBex0jqai1cf1ba8QcQPQYn1hERiHaZ4EMRkaQqfCiGkAIXoATNM
         KXe101OqIj3RHrcb74HABC5tVtx/6OLCPKmyXp8DrZRsHWFFRw3jBBpgiGr+vxze0t01
         +tGNT9JHId1TPVBItTotJdgigLKyvMrb+SCfSrYC18nNrZfgjaxWnztVDv9i1xcBB7fq
         wgLF8lwCpOwwqiOdxZ5CmNmefb07i6cGyOxj16nGFZU9jHbrFx+JIZ0m1xUyTBXniYcH
         HUSA==
X-Gm-Message-State: APjAAAWd81eLcbIOKKpUTFw8RobdVPItKUaC+zXXyL5dwUztT2t/cjT/
        pe0VqThVH97/58Z95CqxoxKzs9VfC7dymz3bG9E7tA9a7eB3z73aPMcEzx+BupmU6asH/4j1444
        wHmGGRQFBbvaeEqmvDWZCjSqY2vrzIzBFc7Pj5D8=
X-Received: by 2002:a17:90a:264a:: with SMTP id l68mr1039494pje.74.1569872417341;
        Mon, 30 Sep 2019 12:40:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZ8h4rNs89cKWhr/JmybSS+4c+v6Mw1oFylzJu67DnGjq96+R4Zln+w1cF96kir99q9ot53A==
X-Received: by 2002:a17:90a:264a:: with SMTP id l68mr1039458pje.74.1569872416994;
        Mon, 30 Sep 2019 12:40:16 -0700 (PDT)
Received: from [192.168.1.75] (201-0-39-188.dsl.telesp.net.br. [201.0.39.188])
        by smtp.gmail.com with ESMTPSA id o60sm373324pje.21.2019.09.30.12.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 12:40:15 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
To:     Jes Sorensen <jes.sorensen@gmail.com>, linux-raid@vger.kernel.org
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        jay.vosburgh@canonical.com, liu.song.a23@gmail.com,
        nfbrown@suse.com, NeilBrown <neilb@suse.de>,
        Song Liu <songliubraving@fb.com>
References: <20190903194901.13524-1-gpiccoli@canonical.com>
 <20190903194901.13524-2-gpiccoli@canonical.com>
 <608284db-7b82-6545-74bf-7a9f1d578c2f@gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <a7796eb4-f28f-9360-2ad2-a76d472c2e4c@canonical.com>
Date:   Mon, 30 Sep 2019 16:40:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <608284db-7b82-6545-74bf-7a9f1d578c2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30/09/2019 16:36, Jes Sorensen wrote:
> [...]
> Applied thanks!
> 
> I fixed up one minor nit rather than having to do the merry-go-round by
> email one more time:
> 
>> diff --git a/Monitor.c b/Monitor.c
>> index 036103f..cf0610b 100644
>> --- a/Monitor.c
>> +++ b/Monitor.c
> [snip]
> 
>> @@ -1116,7 +1119,8 @@ int WaitClean(char *dev, int verbose)
>>               rv = read(state_fd, buf, sizeof(buf));
>>               if (rv < 0)
>>                   break;
>> -            if (sysfs_match_word(buf, clean_states) <= 4)
>> +            if (sysfs_match_word(buf, clean_states)
>> +                < (int)ARRAY_SIZE(clean_states)-1)
> 
> I moved the < up to the correct line where it belongs, and added spaces
> ") - 1)"
> 
> Cheers,
> Jes


Thanks a lot Jes, much appreciated!
Cheers,


Guilherme
