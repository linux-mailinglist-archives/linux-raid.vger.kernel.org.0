Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E37A76D6
	for <lists+linux-raid@lfdr.de>; Wed,  4 Sep 2019 00:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfICWUL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 18:20:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60989 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfICWUL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 18:20:11 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i5H9k-0002kq-VA
        for linux-raid@vger.kernel.org; Tue, 03 Sep 2019 22:20:09 +0000
Received: by mail-qt1-f198.google.com with SMTP id m6so13085193qtk.23
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 15:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=u0k3XnaaOH+YvkPPo0BqIKxocTRXrQHC0zFyGWZv4eg=;
        b=UIMzChoGTrz1pvBl2fxZAcAB0IgNfPwbq2eyXqhGb/mzCAi8i5FkUFKmPI7dikd8h9
         pWYEbytZBEVtIY6Ok9b+7GNIzHu9bjuOZE4X/1ul44sqK3WRLPKylNEMxHnvhl/2c1a/
         JfcvxwaZ90eoWEQQEMPEdL9Gzc01htJJXaTr9dqqT37YSYNhoW+TWNq4rFE1XzM2bHBc
         vZt7Ffxzig1fhsGBoPHhk2f8Ri00mK1LTtkRe2Z3Sw64rAHQxM6l3Ol8nOtRD1+OjpYq
         61b0ctT10OfEhd53OrtCNlxonMCmKmnzgKbvvVieIvSo4v5n4DdYOepJ21zjnh8wkhvd
         IEJg==
X-Gm-Message-State: APjAAAUl9TBBvGDoya80J+zSKSOGUN2FvHRTrn8/LdCHz0BtQGEOAxIO
        tDGRXAUYXs3ctL6JwO/oF5bz0x7aOK31a9HApn3Zosf9K+KR8ckTCsJaaH02k1eGl9OqfIqD++N
        r7ndNKbU1vkwnfOm/BDqxrOT/ugIKa2kEYSRs0XY=
X-Received: by 2002:a37:4a8d:: with SMTP id x135mr35319754qka.472.1567549208183;
        Tue, 03 Sep 2019 15:20:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxu1D2zYJ06nd5yZW9zEhNaIRg1S5Xyi0L1I8Gx7RslRfRbxnXGaaDntVnwvIFQ9lx3oP6aXw==
X-Received: by 2002:a37:4a8d:: with SMTP id x135mr35319746qka.472.1567549208041;
        Tue, 03 Sep 2019 15:20:08 -0700 (PDT)
Received: from [192.168.1.203] (201-93-37-171.dial-up.telesp.net.br. [201.93.37.171])
        by smtp.gmail.com with ESMTPSA id r19sm10188022qte.63.2019.09.03.15.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 15:20:07 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] md raid0/linear: Mark array as 'broken' and fail
 BIOs if a member is gone
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>,
        "liu.song.a23@gmail.com" <liu.song.a23@gmail.com>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        "jes.sorensen@gmail.com" <jes.sorensen@gmail.com>,
        NeilBrown <neilb@suse.de>
References: <20190903194901.13524-1-gpiccoli@canonical.com>
 <E393EAA5-6A9D-464A-A70E-56A258559712@fb.com>
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
Message-ID: <cfb3d90f-ff93-7ddd-9178-7542cab3b17b@canonical.com>
Date:   Tue, 3 Sep 2019 19:20:02 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <E393EAA5-6A9D-464A-A70E-56A258559712@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 03/09/2019 18:56, Song Liu wrote:
> [...] 
> Applied to md-next. 
> 
> Thanks!
> 

Thanks a lot Song!
How can we get the mdadm counterpart applied?
