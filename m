Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC1E9984B
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2019 17:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389598AbfHVPfj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 22 Aug 2019 11:35:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40021 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732936AbfHVPfj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 22 Aug 2019 11:35:39 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i0p7g-0004Dg-Vr
        for linux-raid@vger.kernel.org; Thu, 22 Aug 2019 15:35:37 +0000
Received: by mail-qk1-f200.google.com with SMTP id q62so6213093qkd.3
        for <linux-raid@vger.kernel.org>; Thu, 22 Aug 2019 08:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M5EnEAL/bRHik5jIOYUY0D3cuVp93WL25phV5a6tTNk=;
        b=fNSIDFPpTmJRYIAM3gRgQLIW0S+cbQiYXyJ/ItDAVbfxko3l+y+Iu1OwO/AP3sLd+C
         ddGpXcPREttKWe8exC1BufLVJctydfUKE8JJvgZonOLpZagRVZiKoV5NLFY4Nnggyh71
         ZywhgEqav6OTSYKbuzLUOkSVOYd9kG4NyPGjN+iHdAemiDyoCDHGG2EsuHEeUvOPPCha
         wX38wFbuFzfcTvFnKdhnkA/IE1Cs18PUGeLS5qNvdqET7jsxIq8GqwnPSmiHkhUJbXxE
         +lG+zGjQNv0FrAsZdxsMPt3WBp/l9cq5CCRQpsy/7Xe2uRtE34jpDmoGCND6spA0wwNc
         UG4g==
X-Gm-Message-State: APjAAAXpn9q/DGpdIPvW8aTWiX9/NlrwmbUCk9kYEZD+LzOkAvtQc+lo
        +GQSkggpFxV0160ZCze3BNS1B3ebHeEJ/YBxzX0sA8nKtOiGRnYdYy+qA8Rxn+2fYSon/QfBccc
        RhyYP1rPaH+/HAlAuxZShZCGUBl9ZzRUSGRUpWTY=
X-Received: by 2002:ae9:f441:: with SMTP id z1mr36860737qkl.211.1566488136232;
        Thu, 22 Aug 2019 08:35:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGzdLjvFv92ssETOIZN4joGmP6jTkywjUBlxfV0PqGlqrsA2O7elyclc9RFTHookRnGHw+RA==
X-Received: by 2002:ae9:f441:: with SMTP id z1mr36860714qkl.211.1566488136021;
        Thu, 22 Aug 2019 08:35:36 -0700 (PDT)
Received: from [192.168.1.75] ([191.13.61.137])
        by smtp.gmail.com with ESMTPSA id w1sm11867390qte.36.2019.08.22.08.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 08:35:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] md raid0/linear: Introduce new array state
 'broken'
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        jay.vosburgh@canonical.com, NeilBrown <neilb@suse.com>,
        Song Liu <songliubraving@fb.com>
References: <20190816134059.29751-1-gpiccoli@canonical.com>
 <ca2096ca-8cb2-468f-89d4-24cd059b8a6b@cloud.ionos.com>
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
Message-ID: <51d10dea-4148-6a2c-8e70-7cc977ce1def@canonical.com>
Date:   Thu, 22 Aug 2019 12:35:31 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ca2096ca-8cb2-468f-89d4-24cd059b8a6b@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 22/08/2019 05:49, Guoqing Jiang wrote:
> Hi,

Hi Guoqing, thanks for the review!


> 
> On 8/16/19 3:40 PM, Guilherme G. Piccoli wrote:
>> +static bool linear_is_missing_dev(struct mddev *mddev)
>> +{
>> +    struct md_rdev *rdev;
>> +    static int already_missing;
>> +    int def_disks, work_disks = 0;
>> +
>> +    def_disks = mddev->raid_disks;
>> +    rdev_for_each(rdev, mddev)
>> +        if (rdev->bdev->bd_disk->flags & GENHD_FL_UP)
>> +            work_disks++;
>> +
>> +    if (unlikely(def_disks - work_disks)) {
> 
> If my understanding is correct, after enter the branch,
> 
>> +        if (already_missing < (def_disks - work_disks)) {
> 
> the above is always true since already_missing should be '0', right?
> If so, maybe the above checking is pointless.

The variable 'already_missing' is static, so indeed it starts with 0.
When there are missing disks, we'll enter the 'if(def_disks -
work_disks)' and indeed print the message. But notice we'll set
'already_missing = def_disks - work_disks', so we won't enter the if and
print the message anymore _unless_ a new member is removed and
'already_missing' gets unbalanced with regards to 'def_disks - work_disks'.

The idea behind it is to show a single message whenever a new member is
removed. The use of a static variable allows us to do that.

Nevertheless, this path will be dropped in the V3 that is ready to be sent.
Cheers,


Guilherme
