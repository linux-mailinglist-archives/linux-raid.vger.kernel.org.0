Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1704999904
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2019 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388492AbfHVQUk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 22 Aug 2019 12:20:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41682 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbfHVQUk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 22 Aug 2019 12:20:40 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i0pkt-0000Hi-2x
        for linux-raid@vger.kernel.org; Thu, 22 Aug 2019 16:16:07 +0000
Received: by mail-qt1-f199.google.com with SMTP id 38so7055307qtx.3
        for <linux-raid@vger.kernel.org>; Thu, 22 Aug 2019 09:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q0aNycXsSnwLf3vqQdFLiM1ZARJzzFHaCgk1ijpSvsE=;
        b=M3FGqTbXQs33TI4XYLjGWlPDTsSz6J/L88WhGoSCLyFfyhpTi1aux42H8Qr2U5saSp
         5gf94OArfWO6SCiqQx6S42ULHBHrPMz6zM+nlek+OA56F/EG62Gjk+/REfwbOEkLE94Z
         ETlMe3oNnnS8xKe5KrhRFCjpLCEBVgOs3FzECpPkTahN1ME5tqOcZZm0opv/+9D+sw8U
         XEQSqnjpyfkDgfrlGbH2z7DGgKYML4hEbpuBNQLxhkrI/0jUXTR+7C4luuSHSbLelHSn
         K0P6IRBe3bgRsoV+qDMOp1PtIKCimD5VpcivZgnm2tJGOtrQvRmcXUeBluX4cCjxV/3z
         Xgvg==
X-Gm-Message-State: APjAAAV38F0dmYUR5+DRpnQums2sI/Rwo3jHviOyMbNJ+KVz9GrWNi3R
        CrBN4lbKwN/EiLuRd8HSZpXvXDLhglMeTkLnft4KEocbdYzFHyRYjkm+TH+KxuItjR7dQlI47lL
        XJeSCFvBydk2F7Y3XErvV0mX+lB0decvyaYc8Zws=
X-Received: by 2002:a05:620a:1287:: with SMTP id w7mr14090792qki.25.1566490566248;
        Thu, 22 Aug 2019 09:16:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxW81skd/ojKHMqB2NA2J1P9pBOYLY8x774SefeP60xASWhlQBa5s02ATMEO0flfPVfXfvQCA==
X-Received: by 2002:a05:620a:1287:: with SMTP id w7mr14090776qki.25.1566490566142;
        Thu, 22 Aug 2019 09:16:06 -0700 (PDT)
Received: from [192.168.1.75] ([191.13.61.137])
        by smtp.gmail.com with ESMTPSA id b127sm72453qkc.22.2019.08.22.09.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:16:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] md raid0/linear: Introduce new array state
 'broken'
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <liu.song.a23@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        NeilBrown <neilb@suse.com>
References: <20190816134059.29751-1-gpiccoli@canonical.com>
 <CAPhsuW7aGze5p9DgNAe=KakJGXTNqRZpNCtvi8nKxzS2MPXrNQ@mail.gmail.com>
 <1f16110b-b798-806f-638b-57bbbedfea49@canonical.com>
 <1725F15D-7CA2-4B8D-949A-4D8078D53AA9@fb.com>
 <4c95f76c-dfbc-150c-2950-d34521d1e39d@canonical.com>
 <8E880472-67DA-4597-AFAD-0DAFFD223620@fb.com>
 <c35cd395-fc54-24c0-1175-d3ea0ab0413d@canonical.com>
 <B7287054-70AC-47A8-BA5A-4D3D7C3F689F@fb.com>
 <d0a3709e-c3a9-c0b1-c3c1-bf5a6d6932af@canonical.com>
 <EB40716A-CD63-46B1-97B8-B8C039E08548@fb.com>
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
Message-ID: <f6c361ea-5f46-5a13-2b53-e48e404c91e2@canonical.com>
Date:   Thu, 22 Aug 2019 13:16:02 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <EB40716A-CD63-46B1-97B8-B8C039E08548@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/08/2019 16:22, Song Liu wrote:
> [...] 
> 
> I think this makes sense. Please send the patch and we can discuss
> further while looking at the code. 

Thanks Song, just sent the V3:
lore.kernel.org/linux-block/20190822161318.26236-1-gpiccoli@canonical.com

Cheers,


Guilherme
