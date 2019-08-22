Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0AAC998FD
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2019 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfHVQSq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 22 Aug 2019 12:18:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41621 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfHVQSq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 22 Aug 2019 12:18:46 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i0pms-0000YS-G0
        for linux-raid@vger.kernel.org; Thu, 22 Aug 2019 16:18:10 +0000
Received: by mail-qk1-f199.google.com with SMTP id m2so6328603qkk.10
        for <linux-raid@vger.kernel.org>; Thu, 22 Aug 2019 09:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8QrTJ5W9qm7UW8vRx30IPgmXV1thh8eTl373s/Dfifs=;
        b=GSPYhwGbvtRHZWBSvjO5ywFMqppoqGHIuI7uOpyI6xm4eRhYBkweEt1RuD3cOIYANH
         oZzprZikwtwRmAt0xGNNIOwwN1Z03pfdlPjfxT2SL5/exXXPaZwgvqpAWSFc+KQyW3/K
         nnUuToUE0M/pIX+aK/17IGtz7HX7OsXJEK+jddtecdUdKZcc6qsZcTFVL/qRnqyoHcuV
         mGzhMbb46uquteK/63S3A8FvGrmL78fWI0tlDrdUut2q/CcslfLfD2lA8lEPbb91rpUr
         uvXxzR7NKjnaIVU/FLHMJjcXBndCMS9iKnPPHHbIL8q1IjIVZ+qWrH0i/idhgeBQTW+B
         8OMw==
X-Gm-Message-State: APjAAAWDuyJ+6Q78eIBIVmpFONZq/Qjx5yhrA1q8j1hbVAOJ/EElOUMb
        5fo3ZKAu6qToDznvHia2YszC1FELJOwyi3RadkoS1pbPNYR235DotLNPA4/XGdYPhlhVuoqqg96
        e5NR4IgVngqy/kcqaOUMkdY9pM/l072d9tnz4doc=
X-Received: by 2002:a05:620a:15f1:: with SMTP id p17mr21710483qkm.246.1566490689736;
        Thu, 22 Aug 2019 09:18:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCnBPyl9YSdmpehF6GV9WrxDVxb/9qvN8HdNkJRmJmIsQvRet5zkEAJP94OUz2/BcrsKHQ3Q==
X-Received: by 2002:a05:620a:15f1:: with SMTP id p17mr21710461qkm.246.1566490689616;
        Thu, 22 Aug 2019 09:18:09 -0700 (PDT)
Received: from [192.168.1.75] ([191.13.61.137])
        by smtp.gmail.com with ESMTPSA id k16sm51099qki.119.2019.08.22.09.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:18:08 -0700 (PDT)
Subject: Re: [PATCH v2] md raid0/linear: Fail BIOs if their underlying block
 device is gone
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        jay.vosburgh@canonical.com, NeilBrown <neilb@suse.com>,
        Song Liu <songliubraving@fb.com>
References: <20190816133441.29350-1-gpiccoli@canonical.com>
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
Message-ID: <9356da3b-d5b3-24d2-d109-3ea5916f717a@canonical.com>
Date:   Thu, 22 Aug 2019 13:18:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816133441.29350-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

V3 just sent:
lore.kernel.org/linux-block/20190822161318.26236-1-gpiccoli@canonical.com

The code was merged with the 'broken' state patch.
Cheers,


Guilherme
