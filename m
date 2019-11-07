Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A64F3831
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2019 20:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfKGTJX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 Nov 2019 14:09:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41673 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbfKGTJW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 Nov 2019 14:09:22 -0500
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1iSn9k-0003ZT-9n
        for linux-raid@vger.kernel.org; Thu, 07 Nov 2019 19:09:20 +0000
Received: by mail-pg1-f198.google.com with SMTP id h12so2590332pgd.3
        for <linux-raid@vger.kernel.org>; Thu, 07 Nov 2019 11:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=iHrCqVsVbkfPeNc/tgdamij8UaFEosWwvZHjBKquC8w=;
        b=t8EsTeduplAtVy6j3CQd/JzJJxVGqBiCoTVdCXJ5Mx/ZU9GWAgJih+/3LcYwoEDVGl
         eqgTUdHWui67sAuW5fF7xPXTXAUugpYaKYbRdaX1JnClV0BsTs70qr8+8rQeVOvRE/Dg
         aHN2NBbSMhGcLtxQDJqv2+MZpkVsSyeMIvFIXC1p8XwpLqS8npZFU4BAMDlgRCv/HDNr
         OupWde1ltNiCboEXwAeS/AO2aIkfYW3DJduRHjEqJf752uY64cTzZzS/WwG2f8PuHEHL
         lQIUXmUuo7lpHEJ4ISjPMyjiuGLCeQzrBEc9wtIngbFrRqTG8BPjSClRe5MSS5ivatW1
         wNEA==
X-Gm-Message-State: APjAAAW3Fj0Qex7WrXkX/8poCZkazpxGyxqhlW12t6bY7JpcqosG6tPU
        mVUWdFsFqDOxNpNEp6NXqlQf1GSXkNmU5IVo3LgyAJizB8NPdKU8jpbgw88P7rvrcjrjgVKBRaK
        qW0H7kP4zPJCxJ1kXgeucS+/3d+i/t9PQPhSdVEo=
X-Received: by 2002:a17:90a:2662:: with SMTP id l89mr7604799pje.72.1573153758779;
        Thu, 07 Nov 2019 11:09:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+I5ZKOwM2GOzfDXBICJlWrp9iDMwwKn+99tiKQWArZFfWh9FmVeyqjPSZusC4VLPAgGiYYg==
X-Received: by 2002:a17:90a:2662:: with SMTP id l89mr7604777pje.72.1573153758579;
        Thu, 07 Nov 2019 11:09:18 -0800 (PST)
Received: from [192.168.1.75] (201-93-37-232.dial-up.telesp.net.br. [201.93.37.232])
        by smtp.gmail.com with ESMTPSA id x10sm2948017pgl.53.2019.11.07.11.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:09:17 -0800 (PST)
To:     linux-raid <linux-raid@vger.kernel.org>
Cc:     "jes.sorensen@gmail.com" <jes.sorensen@gmail.com>,
        NeilBrown <neilb@suse.de>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: mdadm release cycle
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
Message-ID: <3313d626-d84a-2c2a-4162-74097b3dc7b5@canonical.com>
Date:   Thu, 7 Nov 2019 16:09:08 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi folks, I'd like to ask how does the release cycle for mdadm work. I
noticed version 4.1 was released 1 year ago - is there a cadence for
version bumps?

Thanks in advance,


Guilherme
