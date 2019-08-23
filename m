Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2A39B5BE
	for <lists+linux-raid@lfdr.de>; Fri, 23 Aug 2019 19:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404540AbfHWRso (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 23 Aug 2019 13:48:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404533AbfHWRsn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 23 Aug 2019 13:48:43 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i1Dg2-0005tS-AJ
        for linux-raid@vger.kernel.org; Fri, 23 Aug 2019 17:48:42 +0000
Received: by mail-qk1-f198.google.com with SMTP id j81so9647903qke.23
        for <linux-raid@vger.kernel.org>; Fri, 23 Aug 2019 10:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wrt5oy4/Lk/zn6biMDS3TaRM8Qzmqq5AAbCxGGgNO9E=;
        b=sBAb+7fizz/SiByUeoP3dWhdRlwWOSyg9/KbMrBrzXZuMJHWdpRvdIIgad0YiYt3ds
         vbhsykReDSNhdWhgsXFUkohvA6PQ4x+0xrLOvf2ROfZK9Kej9ngnd0bQ/a6NHg2fytye
         9AtKM0or0WLtG78k6SQbcIDL7ffkxO2ZIp2odCHCHmSHdCyLOC3+5dO7eEHqNsO9ekrj
         6u5+jWQMjbYtm/K7uM0BHrUPPNenPk8EfY44nSUu7mZtc/KNmD9q9VQaXW27UAhFLgjW
         naPBiLjqqz01Xob2YKPNaxae9kxfm7O/OGyXfzQ7yYQZWK/N7ttgd4p5np1rsD3o5iJo
         uGOw==
X-Gm-Message-State: APjAAAVuvwDypDQ3NIEXQU+FrQbwFBoWaGjec1WtlSZvDqqrujU2LAhs
        g6k5XQxbAwXgKIPUKPzNeu+EDc79ttS/lSDZMaFhiZ2LXvtom5hXnJIM+0b52OomXdPQimhi4C9
        rKnIG/z41zqMaEuBWRlPgt/8mWnkLEpdoPh+KwD0=
X-Received: by 2002:a0c:f150:: with SMTP id y16mr4885547qvl.28.1566582520517;
        Fri, 23 Aug 2019 10:48:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwwYP83/BgBuHVGv5cpEZgKntXVceneWtqqF1OgQ0t61fb4vlyiuPP6uSFK2wjjwHC57/ohbQ==
X-Received: by 2002:a0c:f150:: with SMTP id y16mr4885521qvl.28.1566582520245;
        Fri, 23 Aug 2019 10:48:40 -0700 (PDT)
Received: from [192.168.1.203] ([191.13.61.137])
        by smtp.gmail.com with ESMTPSA id x15sm1619991qki.48.2019.08.23.10.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 10:48:39 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] md raid0/linear: Mark array as 'broken' and fail
 BIOs if a member is gone
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.com>
References: <20190822161318.26236-1-gpiccoli@canonical.com>
 <73C4747E-7A9E-4833-8393-B6A06C935DBE@fb.com>
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
Message-ID: <8163258e-839c-e0b8-fc4b-74c94c9dae1d@canonical.com>
Date:   Fri, 23 Aug 2019 14:48:35 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <73C4747E-7A9E-4833-8393-B6A06C935DBE@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 22/08/2019 18:55, Song Liu wrote:
> [...] 
>> +	if (unlikely(!(tmp_dev->rdev->bdev->bd_disk->flags & GENHD_FL_UP))) {
>> +		if (!test_bit(MD_BROKEN, &mddev->flags))
>> +			pr_warn("md: %s: linear array has a missing/failed member\n",
>> +				mdname(mddev));
>> +		set_bit(MD_BROKEN, &mddev->flags);
>> +		bio_io_error(bio);
>> +		return true;
>> +	}
>> +
> 
> Maybe we can somehow put this block in a helper and use it in both raid0
> and linear code?
> 
> Otherwise, looks good to me. 
> 
> Thanks,
> Song
> 

OK, so something as a function with a prototype like
"void md_is_broken(struct md_rdev *rd, const char *md_type)"
is good for you?
Then we can use that as the check if a member failed and in positive
case, we can print the message (if not printed before) and return to the
raid0/linear driver in order it fails the bio and returns.
I'd prefer keeping the bio out of the helper, agreed?

If you have suggestion for a better name, let me know.
Thanks,


Guilherme
