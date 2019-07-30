Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABA47A882
	for <lists+linux-raid@lfdr.de>; Tue, 30 Jul 2019 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfG3Mas (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jul 2019 08:30:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37369 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbfG3Maq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Jul 2019 08:30:46 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsRHA-0005je-70
        for linux-raid@vger.kernel.org; Tue, 30 Jul 2019 12:30:44 +0000
Received: by mail-pg1-f199.google.com with SMTP id 30so40439204pgk.16
        for <linux-raid@vger.kernel.org>; Tue, 30 Jul 2019 05:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=epsg8o9SJ8QYu2h+n3GBIMR7ashpfZp82u6PNELR9R0=;
        b=ZokmzKYE9Hgg0toyubmKLaTBTtAe5NvQ+PpTrH6bpkoIUBNhC7zCYkKfuB4wIHB9nN
         T4eGZ7dscMZIyWDYtzhmufSzzhFdHeDybF2okzJoWvHMMTbq+WE1C/qWZHhmql+BJKdp
         dOni0IsD/pRq1Pvn0aB5j/8/0eerKwt1BqwfTTK1pQxULsuUVqLxepb9MuHIm5CBleQp
         cXih1seQEvnaZkUOD0vHxgBTTlxfgwnSB3Upe7iXhR1xFV97+5MIllMB8hZwL+nNhkYb
         /27YiFusjbdJDbyXyrJWzAka6C0aeXH0/CXWgcKdCFNQcd72RpPkI+bjlPgXjlFFX1qj
         GZLA==
X-Gm-Message-State: APjAAAXx9XG/bTcS8jQB/tjHemykzwnDh5sW6kzxGV26mmLAsAZje5kC
        DrEtiV6VqA6G33bTUxvK/MOguKnnyLjm1g6Y5kOn+BhN5/D4GRAYsCvz/H7OX25rK9a3Toijkcl
        shh+C1GaOA2tA/Ua30QRYUXIrPa3wmLMZuwTfjOU=
X-Received: by 2002:a17:902:8a94:: with SMTP id p20mr114567049plo.312.1564489842818;
        Tue, 30 Jul 2019 05:30:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0VsDJiydDk2IU/zaDnE7MxD9OWWEeZZZ3QAEoamnUMMOh2M43oOlEha15TE8IWLdFKfsSxA==
X-Received: by 2002:a17:902:8a94:: with SMTP id p20mr114567041plo.312.1564489842701;
        Tue, 30 Jul 2019 05:30:42 -0700 (PDT)
Received: from [192.168.1.202] ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id 85sm69146580pfv.130.2019.07.30.05.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 05:30:41 -0700 (PDT)
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
To:     NeilBrown <neilb@suse.com>, linux-raid@vger.kernel.org
Cc:     jay.vosburgh@canonical.com, Song Liu <songliubraving@fb.com>,
        dm-devel@redhat.com, Neil F Brown <nfbrown@suse.com>,
        linux-block@vger.kernel.org
References: <20190729193359.11040-1-gpiccoli@canonical.com>
 <87zhkwl6ya.fsf@notabene.neil.brown.name>
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
Message-ID: <6400083b-3cf3-cbc6-650a-c3ae6629b14c@canonical.com>
Date:   Tue, 30 Jul 2019 09:30:31 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87zhkwl6ya.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 29/07/2019 21:08, NeilBrown wrote:
>[...]
>> +	if (unlikely(test_bit(MD_BROKEN, &mddev->flags))) {
>> +		bio_io_error(bio);
>> +		return BLK_QC_T_NONE;
>> +	}
> 
> I think this should only fail WRITE requests, not READ requests.
> 
> Otherwise the patch is probably reasonable.
> 
> NeilBrown

Thanks for the feedback Neil! I thought about it; it seemed to me better
to deny/fail the reads instead of returning "wrong" reads, since a file
read in a raid0 will be incomplete if one member is missing.
But it's fine for me to change that in the next iteration of this patch.

Cheers,


Guilherme
