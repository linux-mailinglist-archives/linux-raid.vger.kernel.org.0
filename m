Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07D94CF9
	for <lists+linux-raid@lfdr.de>; Mon, 19 Aug 2019 20:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfHSSbB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 19 Aug 2019 14:31:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50107 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSSbB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 19 Aug 2019 14:31:01 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hzmQk-0001Zl-G7
        for linux-raid@vger.kernel.org; Mon, 19 Aug 2019 18:30:58 +0000
Received: by mail-pl1-f199.google.com with SMTP id v13so2491184plo.4
        for <linux-raid@vger.kernel.org>; Mon, 19 Aug 2019 11:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G+Wxx2hNOhv0fKs6IaWzcXuNgeSIac44n5R8U9Wy5/w=;
        b=gYFgw6rPdTqGdVodKWSxAWS6gicS6Uh7DYu7lcfbQ7nrOJku/6J6K+LO2hH9R0LL6b
         QTka/IpEn9FiBvHYMBXT+n5rsVJmlFeid87VeeNqEXqUmokjN1AQ+IrIRJe/byqiXyvu
         PcL2e7mllTntHpC24Ge6jTYtMshDPakOqfPA7l+AwUBkExWVcJojVifryF6xE8F4hf+e
         BbFYLTaEa9juMeClG/CGtBt6AzPMjblG0veqEO8ReuS6NCgOLN7cHoZPbIuZStQLCXRy
         +Afe7YDpwMKqzFu8ffrJBFR5/76/L+IijpunYgia7xYakvXyB3HE8MG71aWXhFleB6SZ
         xAhA==
X-Gm-Message-State: APjAAAUh6z0XbP2f8Ga4H65a2AiaeqhqVlB2eleqw74W9kChNGc0PNwW
        3GOYZPyHm0pf0WdVAIgn1la7VS2SOXtUkVlNQ0ZlIKj23MotnNVRXzW8E4wkLfvhwAFAY3oLRfp
        PEFYyfekarVuqF3cP4V/ymLRylN0hsotCfaDYbGI=
X-Received: by 2002:a17:902:9f82:: with SMTP id g2mr7871795plq.63.1566239457255;
        Mon, 19 Aug 2019 11:30:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzwuBBFkKb/6HkNHIrDzsJA6fI+J2eg/ci41PQfY8YcQ4gyI+X12S9D0qZfdAixbCPy7jLkjg==
X-Received: by 2002:a17:902:9f82:: with SMTP id g2mr7871776plq.63.1566239457072;
        Mon, 19 Aug 2019 11:30:57 -0700 (PDT)
Received: from [192.168.1.75] ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id y23sm18290666pfr.86.2019.08.19.11.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 11:30:56 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] md raid0/linear: Introduce new array state
 'broken'
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
References: <20190816134059.29751-1-gpiccoli@canonical.com>
 <CAPhsuW7aGze5p9DgNAe=KakJGXTNqRZpNCtvi8nKxzS2MPXrNQ@mail.gmail.com>
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
Message-ID: <1f16110b-b798-806f-638b-57bbbedfea49@canonical.com>
Date:   Mon, 19 Aug 2019 15:30:46 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7aGze5p9DgNAe=KakJGXTNqRZpNCtvi8nKxzS2MPXrNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 19/08/2019 15:10, Song Liu wrote:
> [...]
> 
> If we merge this with the MD_BROKEN patch, would the code look simpler?
> 
> Thanks,
> Song
> 

Hi Song, I don't believe it changes the complexity/"appearance" of the
code. Both patches are "relatives" in the ideas' realm, but their code
is different in nature. My goal in splitting them was to make more
bisect-able changes.

But feel free to merge them in a single patch or let me know if you
prefer that way and I can do it.

There's also a chance I haven't understood your statement/question
correctly heh - if that's the case, please clarify me!
Cheers,

Guilherme
