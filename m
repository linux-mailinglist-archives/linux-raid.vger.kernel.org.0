Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45A87A812
	for <lists+linux-raid@lfdr.de>; Tue, 30 Jul 2019 14:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfG3MTJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jul 2019 08:19:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37126 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfG3MTI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Jul 2019 08:19:08 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsR5u-0004w8-U3
        for linux-raid@vger.kernel.org; Tue, 30 Jul 2019 12:19:07 +0000
Received: by mail-pf1-f200.google.com with SMTP id 6so40724217pfi.6
        for <linux-raid@vger.kernel.org>; Tue, 30 Jul 2019 05:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=duNeCgPARK5/DNYmXliLtl2PHvOx7FRmtH6Afr/ogZ8=;
        b=MIQELctmGvLH9XoqDs8i5kDA75s9pffZqWi8Te/diKkDC3JE84uLwrVBUx3aQ0PGMF
         d8mBdgFnfsVaP8lTW+vv7U4fFbcpxJ+bXi9veRPCBL6bg1wAN+wcEAJ/m4DTLBwKWN8K
         MV68JJp/tQ+aKO6uEj+Vl0POUEU5LeebQSEswlXbXiQurSDg2AxEva3NgmEOPcMkedAu
         bNw8gwrFvsF97Te4EvacB9gxL3KL12ctX1zq+hBpoVmd3JmszaGXw2LYFF3h4FwhbjF+
         P33B++UbQewaCQiEACK/CCxWViTb8Y8J914evG1+f780Z4jvwpW5Qb3f+is/9lJNX/WB
         NIPw==
X-Gm-Message-State: APjAAAVb7EiY16W3dBsgMzrWU/e+3uVkSJ7KJH1b0ptSGMKwZwT8m9HR
        VrMTuBf9nv5XYtKJbe7MCCqxSTuQhGI31oCDqLCIZsrpYRe5uKVRxJrZHOKOXBhI5p/NzyFon1n
        NT3lmS0iUmEKiu3ClJjTgibmpNRbmdEWhwwYx0oA=
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr42586385pfd.207.1564489145723;
        Tue, 30 Jul 2019 05:19:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz3VqyZIP60VysathrWyL1Khg+ulJL5jfJ25tNxj1jx8o8wkADOY5OI0aR6Pr1uAwShW4fTiQ==
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr42586372pfd.207.1564489145562;
        Tue, 30 Jul 2019 05:19:05 -0700 (PDT)
Received: from [192.168.1.202] ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id e189sm45931655pgc.15.2019.07.30.05.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 05:19:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for
 raid0
To:     Bob Liu <bob.liu@oracle.com>, linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        jay.vosburgh@canonical.com, neilb@suse.com, songliubraving@fb.com
References: <20190729203135.12934-1-gpiccoli@canonical.com>
 <20190729203135.12934-2-gpiccoli@canonical.com>
 <d730c417-a328-3df3-1e31-32b6df48b6ad@oracle.com>
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
Message-ID: <000c20fe-3bcd-2dff-a5ab-9a294bdc7746@canonical.com>
Date:   Tue, 30 Jul 2019 09:18:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d730c417-a328-3df3-1e31-32b6df48b6ad@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30/07/2019 03:20, Bob Liu wrote:
> [...]
>> + * broken
>> + *     RAID0-only: same as clean, but array is missing a member.
>> + *     It's useful because RAID0 mounted-arrays aren't stopped
>> + *     when a member is gone, so this state will at least alert
>> + *     the user that something is wrong.
> 
> 
> Curious why only raid0 has this issue? 
> 
> Thanks, -Bob

Hi Bob, I understand that all other levels have fault-tolerance logic,
while raid0 is just a "bypass" driver that selects the correct
underlying device to send the BIO and blindly sends it. It's known to be
a performance-only /lightweight solution whereas the other levels aim to
be reliable.

I've quickly tested raid5 and rai10, and see messages like this on
kernel log when removing a device (in raid5):

[35.764975] md/raid:md0: Disk failure on nvme1n1, disabling device.
md/raid:md0: Operation continuing on 1 devices.

The message seen in raid10 is basically the same. As a (cheap)
comparison of the complexity among levels, look that:

<...>/linux-mainline/drivers/md# cat raid5* | wc -l
14191

<...>/linux-mainline/drivers/md# cat raid10* | wc -l
5135

<...>/linux-mainline/drivers/md# cat raid0* | wc -l
820

Cheers,


Guilherme
