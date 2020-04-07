Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84B71A0D0C
	for <lists+linux-raid@lfdr.de>; Tue,  7 Apr 2020 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgDGLrF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Apr 2020 07:47:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33270 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgDGLrF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 Apr 2020 07:47:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so3559923wrd.0
        for <linux-raid@vger.kernel.org>; Tue, 07 Apr 2020 04:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenkin.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CX6G9FJhRaLD7fU2S/gebT1PoVoWPvS+wx4b0p8hyDo=;
        b=W6f8eBjV/aOG2Qejx2b6mY518qTZH8f0IvA8x5rLNKEK62gK3rLG90Klo6TExZHwfu
         otRTT3rfmn6U//UQCq5lcM1QR+jZ+iVZhFK0Qdd7Mvhz+5YKjR0ig0lL968fwhqrEtSQ
         A/CGnhspdZm1NwNkR5acybF92u/8DDsO7iXd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CX6G9FJhRaLD7fU2S/gebT1PoVoWPvS+wx4b0p8hyDo=;
        b=C70OhwTfmnWIez6CTbwTeLPYGeYkCUwsdkfyjwPKII63aGfZgl5nIIaHaYDLwGTIK7
         icXVtpG+JIQixNF5WOLiuEADkHkaYLKRCzZdt7oS01KwQUoqsGTBLwgW3/XIvnKrVw5p
         v0DeCIMD0B5TNS70o77Bl9aQVItaSwIKC8fX3efB4foUK+BD2/pFL/1lU6dts/I8zKt6
         DCyps2D/BfNzpc0/kyLfk1/qlq3t9EZGdrb1k6/6WWeSFruTploaTfUX5OMxmgwz89Ll
         UhlM4b+TEdqlMP9zsd7PEo5HW0f9Y5P/9HNANquOgHOsqtgHo4wgDbFN38jZkzgTrlpR
         1A0Q==
X-Gm-Message-State: AGi0PuYLAxpY52+Ve2/z1vF9I6dCpOFpLWNaldqforMddyA4++n4sTgR
        roHPkAcZGS9Gz45hWLHOW000p64M0C4=
X-Google-Smtp-Source: APiQypKnI90ctPISqkRuVtDfOlxNp+EOdbSeHOzqLromEjXvx/1B4EzD239g+DYlYJP0WO0D1oPdCg==
X-Received: by 2002:adf:a459:: with SMTP id e25mr2348062wra.402.1586260022497;
        Tue, 07 Apr 2020 04:47:02 -0700 (PDT)
Received: from [192.168.1.154] (cpc69403-oxfd27-2-0-cust350.4-3.cable.virginm.net. [82.15.57.95])
        by smtp.googlemail.com with ESMTPSA id d10sm10175491wrp.9.2020.04.07.04.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 04:47:01 -0700 (PDT)
Subject: Re: Raid-6 cannot reshape
To:     Phil Turmel <philip@turmel.org>,
        Wols Lists <antlists@youngman.org.uk>,
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
Message-ID: <618f5171-785f-09b0-8748-d2549d22c0ab@shenkin.org>
Date:   Tue, 7 Apr 2020 12:46:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b9bb796e-08cd-e10a-d345-992e5f3abea7@turmel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 200406-0, 04/06/2020), Outbound message
X-Antivirus-Status: Clean
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 4/7/2020 12:28 PM, Phil Turmel wrote:
> Hi Allie,
> 
> On 4/7/20 6:25 AM, Alexander Shenkin wrote:
>>
>>
>> On 4/6/2020 9:34 PM, Phil Turmel wrote:
>>> On 4/6/20 12:27 PM, Wols Lists wrote:
>>>> On 06/04/20 17:12, Roger Heflin wrote:
>>>>> When I looked at your detailed files you sent a few days ago, all of
>>>>> the reshapes (on all disks) indicated that they were at position 0, so
>>>>> it kind of appears that the reshape never actually started at all and
>>>>> hung immediately which is probably why it cannot find the critical
>>>>> section, it hung prior to that getting done.   Not entirely sure how
>>>>> to undo a reshape that failed like this.
>>>>
>>>> This seems quite common. Search the archives - it's probably something
>>>> like --assemble --revert-reshape.
>>>
>>> Ah, yes.  I recall cases where mdmon wouldn't start or wouldn't open the
>>> array to start moving the stripes, so the kernel wouldn't advance.
>>> SystemD was one of the culprits, I believe, back then.
>>
>> Thanks all.
>>
>> So, is the following safe to run, and a good idea to try?
>>
>> mdadm --assemble --update=revert-reshape /dev/md127 /dev/sd[a-g]3
> 
> Yes.
> 
>> And if that doesn't work, add a force? >
>> mdadm --assemble --force --update=revert-reshape /dev/md127 /dev/sd[a-g]3
> 
> Yes.
> 
>> And adding --invalid-backup if it complains about backup files?
> 
> Yes.
> 
>> Thanks,
>> Allie
> 
> Phil
> 

Thanks Phil,

The --invalid-backup parameter was necessary to get this up and running.
 It's now up with the 7th disk as a spare.  Shall I run fsck now, or can
I just try to grow again?

proposed grow operation:
> mdadm --grow -raid-devices=7 --backup-file=/dev/usb/grow_md127.bak
/dev/md127
> mdadm --stop /dev/md127
> umount /dev/md127 # not sure if this is necessary
> resize2fs /dev/md127

Thanks,
Allie

assemble operation results:

root@ubuntu-server:/home/ubuntu-server# mdadm --assemble
--invalid-backup --update=revert-reshape /dev/md127 /dev/sd[a-g]3
mdadm: device 12 in /dev/md127 has wrong state in superblock, but
/dev/sdg3 seems ok
mdadm: /dev/md127 has been started with 6 drives and 1 spare.

root@ubuntu-server:/home/ubuntu-server# cat /proc/mdstat
Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5]
[raid4] [raid10]
md127 : active raid6 sda3[6] sdg3[9](S) sde3[7] sdf3[8] sdd3[5] sdc3[2]
sdb3[4]
      11680755712 blocks super 1.2 level 6, 512k chunk, algorithm 2
[6/6] [UUUUUU]
      bitmap: 0/22 pages [0KB], 65536KB chunk

md126 : active (auto-read-only) raid1 sdf1[8] sde1[7] sdg1[9] sda1[6]
sdd1[5] sdc1[2] sdb1[4]
      1950656 blocks super 1.2 [7/7] [UUUUUUU]

unused devices: <none>

