Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42D59036C
	for <lists+linux-raid@lfdr.de>; Fri, 16 Aug 2019 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfHPNs1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 09:48:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54967 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfHPNs1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 16 Aug 2019 09:48:27 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hycaf-0001r4-LP
        for linux-raid@vger.kernel.org; Fri, 16 Aug 2019 13:48:25 +0000
Received: by mail-qk1-f198.google.com with SMTP id q62so543242qkd.3
        for <linux-raid@vger.kernel.org>; Fri, 16 Aug 2019 06:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=79d/sdbXYtwwOa4n/jMG+dfgVY7Mn4hMqbid0OI3YuY=;
        b=kJbhc3/HzDVwwrhvDxttUDy3qStEgND5tdpwrsV/FtbaqDBZcWqm6XbRCA85PTcPRM
         Ne3FuTqQN2sp/i7QQufbyeds2x2dA7Tlwhz0Yk/34cnyjF6y2Xl58NxbJPMOs9RvTbOp
         SUJnMqkEZ3Wilwyd3dPtjnRs2UE6tnYLYtsbDp5Rg6bqo0Xu0/USeAoNJokEq7P2GUNQ
         Sz00OCIdadubJuW/ogNk/S0cFLJv/tvX5OzRuoutpxW0ipbO248VbBd0tNGegK3PcCgS
         uExD4VJPCecb/8qL7qboGSEQfFHoiHZ6RQxSyvPM7rSmniCvOMqI2YB4YbCiidsn1qRV
         CesQ==
X-Gm-Message-State: APjAAAVZWovIBQMGpkV/LJu+aCV90VA1di61T7OYaNzZ7edej8lyvcOr
        zsLdSH9FcAjKXj4iaiejc/g4kx4HSrP26SPOL7nKO6Ie5HcQ7ySiyZoTHLAj8Ff03abomtsdcLh
        ZZ2kriQAjDZfuT6r6iB7nkqTGtgzHWrZ/l7+WABs=
X-Received: by 2002:ac8:5053:: with SMTP id h19mr8734963qtm.196.1565963304913;
        Fri, 16 Aug 2019 06:48:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy+eQMJ4sK3OxMayt6beDeiCE3aW7VAeep53Nvc9Y39FVuY4gVpby6z0uWwsqhOuvJf18sOxw==
X-Received: by 2002:ac8:5053:: with SMTP id h19mr8734946qtm.196.1565963304788;
        Fri, 16 Aug 2019 06:48:24 -0700 (PDT)
Received: from [192.168.1.203] ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id e15sm2185377qtr.51.2019.08.16.06.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 06:48:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for
 raid0
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
References: <20190729203135.12934-1-gpiccoli@canonical.com>
 <20190729203135.12934-2-gpiccoli@canonical.com>
 <CAPhsuW5n9TCZjVT3QnFhHkbfPTvh7ifFiNXypOHouL5ByZS7+w@mail.gmail.com>
 <037ef0ef-1a34-f522-6b31-e388906a87fa@canonical.com>
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
Message-ID: <5c63662a-2cea-bcd7-9f09-b09a68a156c4@canonical.com>
Date:   Fri, 16 Aug 2019 10:48:19 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <037ef0ef-1a34-f522-6b31-e388906a87fa@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

V2 just sent:
lore.kernel.org/linux-block/20190816134059.29751-1-gpiccoli@canonical.com

Thanks,


Guilherme
