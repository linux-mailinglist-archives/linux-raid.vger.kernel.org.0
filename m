Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9338E1959CE
	for <lists+linux-raid@lfdr.de>; Fri, 27 Mar 2020 16:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgC0P1r (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 27 Mar 2020 11:27:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42907 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0P1r (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 27 Mar 2020 11:27:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so11858065wrx.9
        for <linux-raid@vger.kernel.org>; Fri, 27 Mar 2020 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenkin.org; s=google;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WSCB6a9dxEKqc9Dwh3P2dyNm8ruyA6pbx4uMpVL+KOY=;
        b=X4gsaCsiNu2iTYIJ3j82DsiH+WOBk6E9syWQNvZ18QSRMUJk9QQ4uQiLn23wyPMJr5
         lpXgckrfQAhSIh5yqQNTTXKIWluxXRpxawkPl4/NV//bKgyCkRgRV5HTNUwdKHzF3Wen
         0xZ7j4Iww0vaBM9tfLmXzanr7d9LHy8hwBxwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WSCB6a9dxEKqc9Dwh3P2dyNm8ruyA6pbx4uMpVL+KOY=;
        b=q1kYNIC7A3R3FhFzHGghAi6PcHSreb90+W0P64nCXj5suu4HMlr9r7yLyYgIDRy+e5
         ujB/6r8rFG1q2bYJeofIhUDpntJ4XLab9wtJaGox4OpvNpf3S/j1hwK9CcBGHx4mnm5u
         AgZ+YU5YRjhvKy2nSditzcMR78a6FUNrOLK3OcACJZVPKr4QhHsFRWHhMLZ5M7GwWeJL
         WjTE6I0tstKMQTcPhCZ6GznH8WtN9mNb1hf+ZJQ7kKa2jxo7u+xbGzz39P15Ute9k3Ng
         DWOinvwoqrBm021aAyvEseBIU6UhI+H0XtvSKBwdE3T++NqFDrEas315DrxFqA3YtKze
         5BLQ==
X-Gm-Message-State: ANhLgQ1+KvkApxykpo6dZvjKSXiY5675PJjdCGjdhQ4sinPGDL6/wOCB
        DEC29aU6GyEFm/C5ah21Gb2MKS7WAVw=
X-Google-Smtp-Source: ADFU+vu4xgJ5n3els+il6TqpisMxWS0tVbYSaApKUNrDGYgwnk3CSO/fTm+UaBwM6yVKRfOaRaoErg==
X-Received: by 2002:adf:feca:: with SMTP id q10mr15418853wrs.199.1585322864073;
        Fri, 27 Mar 2020 08:27:44 -0700 (PDT)
Received: from [192.168.1.154] (cpc69403-oxfd27-2-0-cust350.4-3.cable.virginm.net. [82.15.57.95])
        by smtp.googlemail.com with ESMTPSA id p16sm8188431wmi.40.2020.03.27.08.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 08:27:43 -0700 (PDT)
Subject: Re: Raid-6 won't boot
To:     antlists <antlists@youngman.org.uk>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
 <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk>
From:   Alexander Shenkin <al@shenkin.org>
Autocrypt: addr=al@shenkin.org; prefer-encrypt=mutual; keydata=
 mQENBE1dbG8BCACgMArnyVGKmnRGsdbTeDHSmAIZnuOitigsD1oEiBaAFE7uKsXTMWn1jKeu
 QocRN5l2eBUCrGB+oyTutebbNOxlGU1Y4eTjOsChuSXkYVS3lxqDwIdj1FpuDQw1jFetYtSz
 KEGBFOfXSvdIs7keTeSRbB4GU+nz612k9I1kjYfVKXMMK39PqaemVx3SDqEKoTx++/h4y9Dw
 Vk0QJcB6r5tARr2HMjUdW7QM9jf4RoU+8j+n8zDMKTgvPJF2xYvf/RwrY8EUgFz5cQ1TcIbl
 2vOsycpwLkL8QtuLAW2ylgjqp0u/Em8Eu4bBVG/kjx0Cj4rG845TcCxfmu2Ie/gWGdfrABEB
 AAG0IkFsZXhhbmRlciBTaGVua2luIDxhbEBzaGVua2luLm9yZz6JATgEEwECACIFAk1dbG8C
 GwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJENqfFYlMlYrSmy4H+gPMexnwlxFZ/2+G
 zbsJB0EMmlNcMDBqZoelxAMk3wFhhrmu0Z4R+KUJs8AK42RCktk5NLooqMLyOQa8sSI5jq0y
 71y/Ujle4WqJFnea9C0BwxHI7lQAwXFgsDH5/ZG/JrX/3EZkmLvYV/a63QbjnhrVo0zv1+r1
 9tuRekvBWwVKi03e+TyZgU4VbQg5GWGS7Iv4VibbPlficuZ5sSmF4Mn9YgduPi3M0vU/I67o
 q4ETVE3PY8e2o1I9zKL3SLQJE5J1wDPHiuJTpPvPAxlxMABmdpMeLyV5n9XZ2mderGGlfPTV
 fAnBRhvUZA5FdjU56WLWkfx4/gBNKwbRrhvfV8K5AQ0ETV1sbwEIAOt0HMNQhG3RprVQ/R36
 sZB0/CrJzPOwt+Rz1UWOaqzB3c7KkjpvgOTh21G9VGEmjCa+Y0RievO7viu65L7/lD8kxjL7
 3g1t0CyTnXjrlVER/ntV5ZpCAU6t9LEaGJcpunEbtV3RZxqlP6furXl5+AzYR3SgvybbB6Bx
 bUxBrtVbqKbI1UsfB1s5bYR3MCX1IbH+ieovWwtkXYmo2V/1sFgi4ikBQ7TtYnjKSSbl7Bll
 ZbW0ZEmJpCLgqQesLWUiEDLiW7Ce7Bfl1//nwekS/9G7xajS+WFx5XxB2OR7nHcwBWbw70mI
 i+k0DxPFy7+hEngP23UO6iZFzJWVjWFHY9UAEQEAAYkBHwQYAQIACQUCTV1sbwIbDAAKCRDa
 nxWJTJWK0nvJB/wJd6904rR49X9XhLY38FK710w0wMVxSsZIzLZhPFAO3ymv7DUknOUWNVPL
 M3OtVjS1rMIR1VeAjYsp2uxBUOYHHyU4dvC/6Un4jHMU4Y/+WBngG7TvcxczNK3mHzPAXGYM
 PraBN/PyEYt3lbeYdLpPrCOditwD2IFTss+hkUDUTAzzDd5rb1IufGZGUILFnYQI7mHTcbFM
 nYnIbd2xamCtTmAxylCygaBVFAuwMf48N8V9IljdMysvM89+N2aHveDgZUMZPuMBq1N46QsL
 qRYo5UFd8OPrY3xKLMdjaI7jGcjeHG2g83Mu9zT6P8dh0GuZfa51FNdknHpC/5OG5HRr
Message-ID: <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
Date:   Fri, 27 Mar 2020 15:27:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks Wol,

Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
reported.  The first (md126) in reported as inactive with all 7 disks
listed as spares.  The second (md127) is reported as active
auto-read-only with all 7 disks operational.  Also, the only
"personality" reported is Raid1.  I could go ahead with your suggestion
of mdadm --stop array and then mdadm --assemble, but I thought the
reporting of just the Raid1 personality was a bit strange, so wanted to
check in before doing that...

Thanks,
Allie

On 3/26/2020 10:00 PM, antlists wrote:
> On 26/03/2020 17:07, Alexander Shenkin wrote:
>> I surely need to boot with a rescue disk of some sort, but from there,
>> I'm not sure exactly when I should do.  Any suggestions are very welcome!
> 
> Okay. Find a liveCD that supports raid (hopefully something like
> SystemRescueCD). Make sure it has a very recent kernel and the latest
> mdadm.
> 
> All being well, the resync will restart, and when it's finished your
> system will be fine. If it doesn't restart on its own, do an "mdadm
> --stop array", followed by an "mdadm --assemble"
> 
> If that doesn't work, then
> 
> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
> 
> Cheers,
> Wol
