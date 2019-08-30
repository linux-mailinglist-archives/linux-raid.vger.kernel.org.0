Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD7CA3717
	for <lists+linux-raid@lfdr.de>; Fri, 30 Aug 2019 14:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfH3Ms2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 30 Aug 2019 08:48:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53295 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfH3Ms2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 30 Aug 2019 08:48:28 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i3gKH-0000UX-My
        for linux-raid@vger.kernel.org; Fri, 30 Aug 2019 12:48:25 +0000
Received: by mail-pf1-f197.google.com with SMTP id x1so5265567pfq.2
        for <linux-raid@vger.kernel.org>; Fri, 30 Aug 2019 05:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3B311aOKf6/H7N61CF4bou7LUlCA79yh6nnh0SwNi/Q=;
        b=S6Bt1FrQzryXNM1Vz5gcSBsyMIMIyvscqQlSgPmSMLnl+TOcRHaS3qxWK06Xj2WUvq
         EDUdlKIA4g8WYwDdptSQdIWYObrA3e8olGlDexP39DqtnlCLSQmxxNf1yapZzs35tuyg
         8+qYIbGpP0LhZSxU5m2a1aM7vPH/YlasB+GIEgk45hDwgod+7rbzpk9RnG5KUK/y2hJJ
         FCQ/JiZ/e2kfNJxOMUQ4yRV2pvrx8hw7G0uRp9aJ3lAPBp5cYB2h1me9vLkhUQXtseL8
         qEUNzGlYgrGSwuDaZL1BjAd77J+d8eaJkgyLs1ixqv/WDAyyqYya0e5sN34lU3B1FB+4
         uVvA==
X-Gm-Message-State: APjAAAXsmUyF28IeiagPkIU3Fg5hfdZWxkUhEF773TPMwQe3VgqXE7JT
        /XrKKFzsajzYqzP/grJB6geO0GUhoyqfypK+B3HVj3TkcCKV6ja5wmdMfSqr/KN75vGju0gcQPL
        sHOElKN3bvttnbgydMMpXVnkTBMPzTveVLkZ4Vys=
X-Received: by 2002:aa7:8b0f:: with SMTP id f15mr17989425pfd.235.1567169304542;
        Fri, 30 Aug 2019 05:48:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxH9FffgY03+3ukV083CL3t5W7RGoTCxctd0RJaul7GbYkOx6jLTZSFn1Wnh+ToobhMYKpIFg==
X-Received: by 2002:aa7:8b0f:: with SMTP id f15mr17989403pfd.235.1567169304280;
        Fri, 30 Aug 2019 05:48:24 -0700 (PDT)
Received: from [192.168.1.201] (200-158-227-228.dsl.telesp.net.br. [200.158.227.228])
        by smtp.gmail.com with ESMTPSA id m13sm9765525pgn.57.2019.08.30.05.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 05:48:23 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
To:     NeilBrown <neilb@suse.de>
Cc:     linux-raid@vger.kernel.org, jay.vosburgh@canonical.com,
        Song Liu <songliubraving@fb.com>, liu.song.a23@gmail.com,
        dm-devel@redhat.com, Neil F Brown <nfbrown@suse.com>,
        linux-block@vger.kernel.org, jes.sorensen@gmail.com
References: <20190822161318.26236-1-gpiccoli@canonical.com>
 <20190822161318.26236-2-gpiccoli@canonical.com>
 <87a7brf4or.fsf@notabene.neil.brown.name>
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
Message-ID: <1a215cee-cbbb-ec3a-937a-2bcfb8049fef@canonical.com>
Date:   Fri, 30 Aug 2019 09:48:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87a7brf4or.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks Neil! CCing Jes, also comments inline:


On 30/08/2019 05:17, NeilBrown wrote:
>> [...]
>> +	char arrayst[12] = { 0 }; /* no state is >10 chars currently */
> 
> Why do you have an array?  Why not just a "char *".
> Then all the "strncpy" below become simple pointer assignment.

OK, makes sense! I'll try to change it.


>> [...]  
>>  int WaitClean(char *dev, int verbose)
>>  {
>> @@ -1116,7 +1120,8 @@ int WaitClean(char *dev, int verbose)
>>  			rv = read(state_fd, buf, sizeof(buf));
>>  			if (rv < 0)
>>  				break;
>> -			if (sysfs_match_word(buf, clean_states) <= 4)
> 
> Arg.  That is horrible.  Who wrote that code???
> Oh, it was me.  And only 8 years ago.

rofl, happens!


> sysfs_match_word() should return a clear "didn't match" indicator, like
> "-1".
> 
> Ideally that should be fixed, but I cannot really expect you to do that.
> 
> Maybe make it
>    if (clean_states[sysfs_match_word(buf, clean_states)] != NULL)
>  ??
> or
>    if (sysfs_match_word(buf, clean_states) < ARRAY_SIZE(clean_states)-1)
> 
> Otherwise the patch looks ok.

OK, thanks for the review! I'll try to change that in V4 too.
cheers,


Guilherme
