Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8F7C2B1
	for <lists+linux-raid@lfdr.de>; Wed, 31 Jul 2019 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfGaNEj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 31 Jul 2019 09:04:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40428 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfGaNEi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 31 Jul 2019 09:04:38 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsoHU-0004Zn-EW
        for linux-raid@vger.kernel.org; Wed, 31 Jul 2019 13:04:36 +0000
Received: by mail-pl1-f198.google.com with SMTP id q11so37427154pll.22
        for <linux-raid@vger.kernel.org>; Wed, 31 Jul 2019 06:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZVJqYCt6y7kDQk5e4VajzmV5IXeiBUBYB5EIHeYIrC0=;
        b=HcGonF/vQyiFc1w8ITi8iy4ZVfLMLYGxlJYM4jJCKlxKVeDVocqvX2w/It8Q695cL6
         pPySfJ+LIMllk5DfDb1vmKGFzljpjOLVjUp5O2SnGXZBARwdRhR09G3dePJzm+wo64Fj
         QqfWoRnR7F/Dks+EFkM45OUX4KanYkl943tinbOj1OHXNrIyZDMNEOfvIIMTFYDk299C
         pcS5us7KRVbQtMN4aZzcCtgNu/pAYn0YD7KITl7gNBYw7wBCbnzDugNelFKA3Lec6DKk
         2acP7ryLH0n8U+NAqayHmYl8htriTwiFXZ+u6/j1NZfmjf0hf88ijoD6cKoadvA6B9cR
         5j2Q==
X-Gm-Message-State: APjAAAXWfrj39e0+ZkSngXAu5X06YLETiHfY9gpfDtwl9PVcn32Mea9w
        Xnl28mRtO9xWm7TVFikqPZaHJhFKnPOkIkVqCTdldPrVjVIksYOOoCltLSDBBnBZ/EnQG5vFZkA
        iPQaSxRSFs58GbaFgV//AlymgPuyns5lAtyFl1BU=
X-Received: by 2002:a17:902:b591:: with SMTP id a17mr39314899pls.96.1564578275201;
        Wed, 31 Jul 2019 06:04:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwR1CH6m9mU2cXXtekQvrfWE11ZuQqjWDIftLSWs2cw2Yuy7o81N8NFr/tfEfOAEV580sOfRw==
X-Received: by 2002:a17:902:b591:: with SMTP id a17mr39314886pls.96.1564578275053;
        Wed, 31 Jul 2019 06:04:35 -0700 (PDT)
Received: from [192.168.1.202] ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id b126sm103400673pfa.126.2019.07.31.06.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 06:04:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for
 raid0
To:     NeilBrown <neilb@suse.com>, Bob Liu <bob.liu@oracle.com>,
        linux-raid@vger.kernel.org
Cc:     jay.vosburgh@canonical.com, songliubraving@fb.com,
        dm-devel@redhat.com, Neil F Brown <nfbrown@suse.com>,
        linux-block@vger.kernel.org
References: <20190729203135.12934-1-gpiccoli@canonical.com>
 <20190729203135.12934-2-gpiccoli@canonical.com>
 <d730c417-a328-3df3-1e31-32b6df48b6ad@oracle.com>
 <87ftmnkpxi.fsf@notabene.neil.brown.name>
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
Message-ID: <9dd836f8-7358-834f-8d29-cd0db717d01b@canonical.com>
Date:   Wed, 31 Jul 2019 10:04:23 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87ftmnkpxi.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30/07/2019 21:28, NeilBrown wrote:
> On Tue, Jul 30 2019, Bob Liu wrote:
>>
>>
>> Curious why only raid0 has this issue? 
> 
> Actually, it isn't only raid0.  'linear' has the same issue.
> Probably the fix for raid0 should be applied to linear too.
> 
> NeilBrown
> 

Thanks Neil, it makes sense! I didn't considered "linear" and indeed,
after some testing, it reacts exactly as raid0/stripping.

In case this patch gets good acceptance I can certainly include
md/linear in that!
Cheers,


Guilherme
