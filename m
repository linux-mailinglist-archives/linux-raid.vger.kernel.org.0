Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0350279A4D
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388213AbfG2UuL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 16:50:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43583 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbfG2UuI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 29 Jul 2019 16:50:08 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsCar-0002q1-VK
        for linux-raid@vger.kernel.org; Mon, 29 Jul 2019 20:50:06 +0000
Received: by mail-pf1-f198.google.com with SMTP id 6so39250087pfz.10
        for <linux-raid@vger.kernel.org>; Mon, 29 Jul 2019 13:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+XMk/43ITQRym8v4Qdx3eFC21tUKiobsXb5aceQcHUs=;
        b=Gqaf8gTjcPIbJlT2IxG08kzfqvUqggwVaqpcB8P2FrdXoQ32dO2+JB1CDeOmhpAren
         sujCVoH4VVa1mCgJZAwQcPgXPvc3uqC+GC7DzmdP5noZFF9V60Ixz7L+dwAmK04t2A4D
         4pPl+Hhv6+lG0BcASAuBBq/iI2INBLtgAzLOWNfPfOzdOLwpzoP/JXIEPEYgEniPMzf/
         YWOpLBjH+vdCLCfkDRMvgsVGoveE9iWPVwH8CnW5iOjev1fkw8fh8bW68Dkemth0yBCR
         JFDKIe1zhZPHk/qh7yA+QW70nKY5j6Rmo9DlOSJ2WyNSCUQib3Dl3CsZPLlFV8Kk0/oZ
         Aw1A==
X-Gm-Message-State: APjAAAV07oCaGwd7utcq4jzWZ19vNw0SAKJhB1NdNs2nPXaXsiQ86aN9
        FcRythkWYxW/pJDGsPsKDYtQYHyHdQEA+6I3n4kVpOC9PmcElvyVXrIefeMgDDIXxTRIqnggGjQ
        1rCK0bjGb4XKQyx08blqFYWiTRpZeYM1lOY6kto8=
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr105442012pld.6.1564433404787;
        Mon, 29 Jul 2019 13:50:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzaUg3ADJPjfnAjCJyPt9dLggL/fkXvIF9JUqX9bu89XttSG2+HLu5IvXqgA8k8lD4EPCAhPA==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr105441989pld.6.1564433404363;
        Mon, 29 Jul 2019 13:50:04 -0700 (PDT)
Received: from [192.168.1.202] ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id v184sm58410396pgd.34.2019.07.29.13.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:50:03 -0700 (PDT)
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jay.vosburgh@canonical.com,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
References: <20190729193359.11040-1-gpiccoli@canonical.com>
 <20190730011850.2f19e140@natsu>
 <053c88e1-06ec-0db1-de8f-68f63a3a1305@canonical.com>
 <20190730013655.229020ea@natsu>
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
Message-ID: <ac032580-d2cb-5616-1101-46993b14466e@canonical.com>
Date:   Mon, 29 Jul 2019 17:49:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730013655.229020ea@natsu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 29/07/2019 17:36, Roman Mamedov wrote:
> On Mon, 29 Jul 2019 17:27:15 -0300
> "Guilherme G. Piccoli" <gpiccoli@canonical.com> wrote:
> 
>> Hi Roman, I don't think this is usual setup. I understand that there are
>> RAID10 (also known as RAID 0+1) in which we can have like 4 devices, and
>> they pair in 2 sets of two disks using stripping, then these sets are
>> paired using mirroring. This is handled by raid10 driver however, so it
>> won't suffer for this issue.
>>
>> I don't think it's common or even makes sense to back a raid1 with 2
>> pure raid0 devices.
> 
> It might be not a usual setup, but it is a nice possibility that you get with
> MD. If for the moment you don't have drives of the needed size, but have
> smaller drives. E.g.:
> 
> - had a 2x1TB RAID1;
> - one disk fails;
> - no 1TB disks at hand;
> - but lots of 500GB disks;
> - let's make a 2x500GB RAID0 and have that stand in for the missing 1TB
> member for the time being;
> 
> Or here's for a detailed rationale of a more permanent scenario:
> https://louwrentius.com/building-a-raid-6-array-of-mixed-drives.html
> 

Oh, that's nice to know, thanks for the clarification Roman.
I wasn't aware this was more or less common.

Anyway, I agree with you: in this case, it's a weak point of raid0 to be
so slow to react in case of failures in one member. I hope this patch
helps to alleviate the issue.
Cheers,


Guilherme
