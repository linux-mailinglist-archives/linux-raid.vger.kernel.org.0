Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FCBA740F
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfICTxf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 15:53:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57682 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICTxe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 15:53:34 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i5Ers-0005Th-Ol
        for linux-raid@vger.kernel.org; Tue, 03 Sep 2019 19:53:32 +0000
Received: by mail-pf1-f197.google.com with SMTP id c5so6457498pfo.17
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 12:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:to:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=m4/iGFxysoqiJX5l6xY9vaEh4ZOwU9TUKtScGeLuxk4=;
        b=La3UjAt0ijC9r7n7dhBCbG+frDAxE/B/IA5Xz7t8AY3yfJmlI1CkudfBx6XGe3ZfgH
         bN1G8awZNIb/YhfDBzKxMxih+7iTA8Fxftvp7Kq3VTGhEjGET70pO4czAWkbIucqAnZh
         Ph8XsCses/4A5yEu3Jhksg6f0QTJV9gPN17ahbe/9jholzxsQo4fla+g46tNu+ClRw4W
         V+o3Q+jlm62Ho1BDbB2i0d970PE/njfv1pjZosIa6ftBoc00DrOguf9pu6x40aSuwlBT
         Ka1QHra42TWzM0kZ88oRzW98GM4NfwKjma4mE+nGKTrDogQTyrcHRofbuZBsj0lLJobt
         xp2g==
X-Gm-Message-State: APjAAAVwkEZI3OiCFWC5RRtalqFe7cqOtqMOuVaC7xvR1LsxyKL1VvjN
        h3W7tFwjf1T+JNZm8/DK5QWrVsHMSigy1XNR6wYyZXg0c8DPrJ1tn9mWHfwB66hisWs7QsvOH1S
        Pqgkojsad4CLOh3DWjDuHABV/A/jVx12Up/Nz794=
X-Received: by 2002:a17:90a:c086:: with SMTP id o6mr1041225pjs.24.1567540411619;
        Tue, 03 Sep 2019 12:53:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwiwXv/UYVHujb2Lh/xxxZ5lvm9Dvm2/i4Zu0bum67gm5u4ULLDhXn+dzw+u/pQGQ1xWX4NCw==
X-Received: by 2002:a17:90a:c086:: with SMTP id o6mr1041217pjs.24.1567540411500;
        Tue, 03 Sep 2019 12:53:31 -0700 (PDT)
Received: from [192.168.1.203] (201-93-37-171.dial-up.telesp.net.br. [201.93.37.171])
        by smtp.gmail.com with ESMTPSA id d20sm24787555pfq.88.2019.09.03.12.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:53:30 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] md raid0/linear: Mark array as 'broken' and fail
 BIOs if a member is gone
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.com>
References: <20190822161318.26236-1-gpiccoli@canonical.com>
 <73C4747E-7A9E-4833-8393-B6A06C935DBE@fb.com>
 <8163258e-839c-e0b8-fc4b-74c94c9dae1d@canonical.com>
 <F0E716F8-76EC-4315-933D-A547B52F1D27@fb.com>
 <5D68FEBC.9060709@youngman.org.uk>
 <CAHD1Q_ypdBKhYRVLrg_kf4L8LdXk8rgiiSQjtmoC=jyRv5M5jQ@mail.gmail.com>
To:     Wols Lists <antlists@youngman.org.uk>,
        linux-raid <linux-raid@vger.kernel.org>
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
Message-ID: <8a55b0b6-25a9-d76b-1a6a-8aaed8bde8a7@canonical.com>
Date:   Tue, 3 Sep 2019 16:53:20 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHD1Q_ypdBKhYRVLrg_kf4L8LdXk8rgiiSQjtmoC=jyRv5M5jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30/08/2019 08:25, Guilherme Piccoli wrote:
> Thanks a lot for all the suggestions Song, Neil and Wol - I'll
> implement them and resubmit
> (hopefully) Monday.
> 
> Cheers,
> 
> 
> Guilherme
> 

V4 sent:
https://lore.kernel.org/linux-block/20190903194901.13524-1-gpiccoli@canonical.com/T/#t

Wols, in order to reduce code size and for clarity, I've kept the helper
as "is_mddev_broken()" - thanks for the suggestion anyway!
Cheers,


Guilherme
