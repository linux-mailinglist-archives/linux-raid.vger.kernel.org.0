Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D538BF3853
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2019 20:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfKGTQj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 Nov 2019 14:16:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41906 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfKGTQj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 Nov 2019 14:16:39 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1iSnGn-0004VD-S0
        for linux-raid@vger.kernel.org; Thu, 07 Nov 2019 19:16:38 +0000
Received: by mail-pg1-f197.google.com with SMTP id t28so2577573pgl.21
        for <linux-raid@vger.kernel.org>; Thu, 07 Nov 2019 11:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Wdf5ro8aSI2bjKbPDP3c2Wp0puT+0BzPRyJUK9uV4YE=;
        b=aqteGzy2oRaDV+GBV3UdJ8Ppyr5gX/EwFyNOd7BnG3mDn3v2ARuZtc8DtTFIoVAc1P
         nVkf6JmRalTyDeY3sp/QYWL2Y8Cj2ysS3VsOEx6NmDlYu5Co16xwMkD1FMd4zuW93SfS
         n7hfYg97NCf0ecoYGqXbRSDoaRmAMW11N5Gb0jbfAyOvGR02Yzfp6trz66P4ANrOC8ud
         Sf0HccILRC+0nOwNrXVvl9cqBQEHT1aSaokighMAJaAbNn0vBuDqOIOUgUF+pVvcxQXS
         K/BOQVahYf5UpNtTnq4SJhBTTtn8j/ZY8KEidaf4Qs6FE/tKA/wt4baM5g7Rs67QdcnK
         GPpw==
X-Gm-Message-State: APjAAAVerHRs4+J7YoVk1xC0zRmYxbz9Necx9Lc+eOGLj0qC3JXzgkg8
        FAeC+6fkhWzZENlwGEIDgDiiLQkPKFL7JyCMBg/v6oftVETyfivY+iR1Yc6ff6xI/bkTMUH6D1b
        OC/a0Sud2OTSgiNr1Ag0xyUh7KYCBWaTTZz31h64=
X-Received: by 2002:a17:902:9a92:: with SMTP id w18mr5403127plp.186.1573154196538;
        Thu, 07 Nov 2019 11:16:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUDU5r2481ITlucK2QnTzeSfRjS4xfpjnseVpTVHtbBUVMs0bOUeelVZGNPRNRiQa7Dg9Zlg==
X-Received: by 2002:a17:902:9a92:: with SMTP id w18mr5403105plp.186.1573154196335;
        Thu, 07 Nov 2019 11:16:36 -0800 (PST)
Received: from [192.168.1.75] (201-93-37-232.dial-up.telesp.net.br. [201.93.37.232])
        by smtp.gmail.com with ESMTPSA id r184sm4082081pfc.106.2019.11.07.11.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:16:35 -0800 (PST)
Subject: Re: mdadm release cycle
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, NeilBrown <neilb@suse.de>
References: <3313d626-d84a-2c2a-4162-74097b3dc7b5@canonical.com>
 <c65f59ce-8aca-42b0-ebec-f5ebd9646f47@gmail.com>
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
Message-ID: <bcec0be6-beab-b624-e9b0-2d901f1a03c3@canonical.com>
Date:   Thu, 7 Nov 2019 16:16:28 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c65f59ce-8aca-42b0-ebec-f5ebd9646f47@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 07/11/2019 17:10, Jes Sorensen wrote:
> On 11/7/19 2:09 PM, Guilherme G. Piccoli wrote:
>> Hi folks, I'd like to ask how does the release cycle for mdadm work. I
>> noticed version 4.1 was released 1 year ago - is there a cadence for
>> version bumps?
> 
> There's no fixed schedule, if we feel there's enough updates in the code
> that justifies a release, I'll do a release.
> 
> Jes
> 

Thanks Jes!
