Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9231A1267
	for <lists+linux-raid@lfdr.de>; Tue,  7 Apr 2020 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDGREJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Apr 2020 13:04:09 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46150 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGREI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 Apr 2020 13:04:08 -0400
Received: by mail-wr1-f44.google.com with SMTP id y44so1180951wrd.13
        for <linux-raid@vger.kernel.org>; Tue, 07 Apr 2020 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenkin.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sm68cV5z+1gsI5/5zOcwR5UwXWEWU5b8eQpCMBzAzRA=;
        b=IoUpXaeMA7lO665fDDaCwMbTtIa707/e1k75RAMA3bo7C8YcDfwzSO1c82UeebtErg
         LwMaawUpMI6Gcd9CEL1BlxIwANMgGb+FE3rgcDZFnfNtQMrqsy2QenTznNHKEcXw58p+
         sn3GDDdKCScWc4AQo5AvH33lRfmK5H6kGlkk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sm68cV5z+1gsI5/5zOcwR5UwXWEWU5b8eQpCMBzAzRA=;
        b=lYtkDPlQ476AhPKuJzygridwRa+GnK9djpOF0YJ8SexceqfA1T+juwDwsVdCDhSvgJ
         EcBVkySlGn8WcsaHYwQsvihED1NTHktG3a7OKepL1P042DeG8k2sL5ZSKPQmdpk/BcAK
         GRYIzwTSIimxnTDHIuaUHZvuZng/CmtGOkm/rxOHNUy+SHA6imxC6qMbCMP6i3njZVnT
         gVEqX23Di7dESC8mey+gm7esU17Dflpo5ch2skkchOh6S6+7K0SE0rBQE0hoGzRXwPu/
         7oen7NeZ5/ZhPlU716OFuOp4hZnH5xP7e7tBKmUdOp0xHH3o9pJKTMWqQlsIalKD76jz
         k63Q==
X-Gm-Message-State: AGi0PubViJrZu2P02l/YlyK25cHWyIexaqmgWa3iM0/on9JsMX6NYObE
        8h/3CCSB1cRfPvxVN/+yhRDzz58nhcA=
X-Google-Smtp-Source: APiQypIFr1IJc0aVBICaWTATly5hA1BYcMI+VE+Vz0wp0m0hoal3QU0u4C7MlVw92zsKnfodMk6Glw==
X-Received: by 2002:a5d:51d1:: with SMTP id n17mr2967841wrv.206.1586279046044;
        Tue, 07 Apr 2020 10:04:06 -0700 (PDT)
Received: from [192.168.1.154] (cpc69403-oxfd27-2-0-cust350.4-3.cable.virginm.net. [82.15.57.95])
        by smtp.googlemail.com with ESMTPSA id f5sm22401863wrj.95.2020.04.07.10.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 10:04:05 -0700 (PDT)
Subject: Re: Raid-6 cannot reshape
To:     antlists <antlists@youngman.org.uk>,
        Phil Turmel <philip@turmel.org>,
        Roger Heflin <rogerheflin@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
References: <24a0ef04-46a9-13ee-b8cb-d1a0a5b939fb@shenkin.org>
 <6b9b6d37-6325-6515-f693-0ff3b641a67a@shenkin.org>
 <3135fb29-cfaa-d8ac-264d-fd3110217370@shenkin.org>
 <CAAMCDecyr4R_z3-E8HYwYM4CyQtAY_nBmXdvvMkTgZCcCp7MjQ@mail.gmail.com>
 <5E8B5865.9060107@youngman.org.uk>
 <08d66411-5045-56e1-cbad-7edefa94a363@turmel.org>
 <945332b3-6a47-c2b3-7d1e-70a44f6fd370@shenkin.org>
 <b9bb796e-08cd-e10a-d345-992e5f3abea7@turmel.org>
 <618f5171-785f-09b0-8748-d2549d22c0ab@shenkin.org>
 <38852671-9c5a-3807-0284-41f902e5f81b@turmel.org>
 <44069d88-f838-2b8b-1002-a1fff5502d2d@turmel.org>
 <61e30bc4-469f-32ed-06e8-d1b4e1fd6740@shenkin.org>
 <572ec112-21ff-7da5-81d2-a91b08277a2c@youngman.org.uk>
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
Message-ID: <bb0313a6-e826-63c5-dd68-7a64a17a3ae7@shenkin.org>
Date:   Tue, 7 Apr 2020 18:04:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <572ec112-21ff-7da5-81d2-a91b08277a2c@youngman.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 200407-0, 04/07/2020), Outbound message
X-Antivirus-Status: Clean
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks all,

My file system was a total mess, everything dropped into lost + found.
I've put everything back into what I think are the right directory
structures, and nice to not have all my data lost (i think)... but i may
just do a clean install of a new os once i have it up, running, and
grown again... many thanks to all...  (and btw, it's growing nicely with
ubuntu 18 at the moment...)

allie

On 4/7/2020 4:08 PM, antlists wrote:
> On 07/04/2020 14:19, Alexander Shenkin wrote:
>> Re re-growing, I was hoping that running on a newer mdadm (4.1) might
>> fix the problem, and if i still encountered it, perhaps running the
>> following might unstick it:
>>
>> echo frozen > /sys/block/md0/md/sync_action
>> echo reshape > /sys/block/md0/md/sync_action
>>
>> But, I personally have no idea what happened (really), nor why...:-(
> 
> iirc pretty much all these reports come from oldish Ubuntu systems ...
> 
> What happened *could* be that you have an updated franken-kernel, plus
> an old mdadm, and the mess needs an Igor to stitch it all together...
> 
> If you ARE going to try the grow again, I'd use an up-to-date recovery
> system to run the grow, and then reboot back in to the old Ubuntu once
> your system is back.
> 
> And seriously think about upgrading your distro to the latest LTS.
> 
> Cheers,
> Wol
