Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86A1799E9
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 22:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfG2U1b (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 16:27:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43013 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfG2U1a (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 29 Jul 2019 16:27:30 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsCEy-0001c8-Rb
        for linux-raid@vger.kernel.org; Mon, 29 Jul 2019 20:27:29 +0000
Received: by mail-pg1-f199.google.com with SMTP id t18so28991861pgu.20
        for <linux-raid@vger.kernel.org>; Mon, 29 Jul 2019 13:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MaekBACqSdm0Cv0kET0YVM5UjbEWf5Z7KHF+w2h47zE=;
        b=Rp+CXnMD4/dSFqpvc00xeqDxUKAu9I71TbHPl8xACpXiHd3Ks0KfGB//vlmdwl9JFs
         1A8BlJ/naADnNIGBR1QTJtZcwQJYt4WAF6qxwSmnaWW3MveqyJ3o0aivWCRp/5GMuT5j
         4H7MUFdsMbHGNyWW+SIJ8WCUpoL4YROUOi2p722Y/jUcQHAfH0eUkSPcJ7cGir0t4Enr
         E0mGFeukT1mL3IyBKKIO/vNjVt13/sTP9U1CLai6/uhmjrv0/6mwcVf29Us2b9NoWlDD
         iTRNMZFR7hhtVjqrIdSjLNVIo6yPAgDDOD4UPNKcNaNvn4yFZW4RtvXu4EzfZmAzSbdA
         kWzg==
X-Gm-Message-State: APjAAAUm6ifN97xvKQNS/uu45JYJRg78cXrUBstZ42waCEuAVjcmpUT0
        ltj4kIUQunS+PPeaHaZumG35az3aAnftvo/eNfxUF/sn+WcaU1H/zy5zBY93X+rjv8CXXPjEV4H
        /xc8tkykkSTKv9f2LCnJupAalzqAjmTFIMciBocM=
X-Received: by 2002:a63:5c15:: with SMTP id q21mr79513509pgb.199.1564432047546;
        Mon, 29 Jul 2019 13:27:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4/pLh9DzTr1UAut9rnbFH5HGyR6rsm/IUS1OMP3fUvcNHL6cpZohM6eqwe61q/Bvb+ZovXw==
X-Received: by 2002:a63:5c15:: with SMTP id q21mr79513486pgb.199.1564432047257;
        Mon, 29 Jul 2019 13:27:27 -0700 (PDT)
Received: from [192.168.1.202] ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id q24sm56238914pjp.14.2019.07.29.13.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:27:26 -0700 (PDT)
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jay.vosburgh@canonical.com,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
References: <20190729193359.11040-1-gpiccoli@canonical.com>
 <20190730011850.2f19e140@natsu>
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
Message-ID: <053c88e1-06ec-0db1-de8f-68f63a3a1305@canonical.com>
Date:   Mon, 29 Jul 2019 17:27:15 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730011850.2f19e140@natsu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 29/07/2019 17:18, Roman Mamedov wrote:
> On Mon, 29 Jul 2019 16:33:59 -0300
> "Guilherme G. Piccoli" <gpiccoli@canonical.com> wrote:
> 
>> Currently md/raid0 is not provided with any mechanism to validate if
>> an array member got removed or failed. The driver keeps sending BIOs
>> regardless of the state of array members. This leads to the following
>> situation: if a raid0 array member is removed and the array is mounted,
>> some user writing to this array won't realize that errors are happening
>> unless they check kernel log or perform one fsync per written file.
>>
>> In other words, no -EIO is returned and writes (except direct ones) appear
>> normal. Meaning the user might think the wrote data is correctly stored in
>> the array, but instead garbage was written given that raid0 does stripping
>> (and so, it requires all its members to be working in order to not corrupt
>> data).
> 
> If that's correct, then this seems to be a critical weak point in cases when
> we have a RAID0 as a member device in RAID1/5/6/10 arrays.
> 

Hi Roman, I don't think this is usual setup. I understand that there are
RAID10 (also known as RAID 0+1) in which we can have like 4 devices, and
they pair in 2 sets of two disks using stripping, then these sets are
paired using mirroring. This is handled by raid10 driver however, so it
won't suffer for this issue.

I don't think it's common or even makes sense to back a raid1 with 2
pure raid0 devices.
Thanks for your comment!
Cheers,


Guilherme
