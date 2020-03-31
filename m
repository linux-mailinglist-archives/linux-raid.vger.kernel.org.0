Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB2199B15
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 18:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgCaQNM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Mar 2020 12:13:12 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55079 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbgCaQNL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 31 Mar 2020 12:13:11 -0400
Received: by mail-wm1-f51.google.com with SMTP id c81so3144329wmd.4
        for <linux-raid@vger.kernel.org>; Tue, 31 Mar 2020 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenkin.org; s=google;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M2pp7P2PsuukZKgn1B9PhBycmVwETO1qz0bAxr58MnY=;
        b=H/X7JpPKddeaLMmqU9oLK/qfQEKBisaGusx9f1UkR0baovylbyrznXU2UW6dsQe/id
         XcrjCWwgUr421iqGyY8fVtxyz8GgLSph/b0akBOrzMvA3cEXZd+XXoh519xXbkV2HTkL
         uS6p/ua6Zz43ma0RoL72nvvue6ctIKaGQi3PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M2pp7P2PsuukZKgn1B9PhBycmVwETO1qz0bAxr58MnY=;
        b=XlBpI+xb6lGmCcdRnS+yS4ucUqTq2lEj1nBvy4QvzR19rFk28MVTvH0Ie7+SXQ7TOO
         3KFTLDnRWn3e5wM3HD+bDUAbVXjGBcQMzgVQKmU+LDMUb6cP8uUSnVamMxGLYtSdN0sn
         j+yxSQjr97LyRt8ADGGkq/H4dgeilGhjSQdwM/5YjtQwoVsdBEdhZ7aCdgS8IYfFE6w5
         u3v3G+dnuhdmBG/IDCK7VAhKYBQH4RJZtNyxB8w+ld+CkL+AvKKQw+fHRXpXogvxtNI5
         FV9LoAPEhWIOvq7FRgdgYEpWqYwYP4t/HH2WrsxBzdJ3quh6UJfOVWnv7AvOmWsLAkht
         2RQw==
X-Gm-Message-State: ANhLgQ1unz54gSxq83q20uAz7IH/GGxyNb2WyjrErHSlzzDsn+OD+rSo
        +FhYHITBZlcBpONPiAVmQp7SguIRSX8=
X-Google-Smtp-Source: ADFU+vuGVeJNujlF1hUSEKyc8LsNrG2HPgSTi74tp3QgxjevXhSt/lCTZhuZrRzAeSeQSP2Smuk4mw==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr3960343wmi.37.1585671189282;
        Tue, 31 Mar 2020 09:13:09 -0700 (PDT)
Received: from [192.168.1.154] (cpc69403-oxfd27-2-0-cust350.4-3.cable.virginm.net. [82.15.57.95])
        by smtp.googlemail.com with ESMTPSA id a124sm2594220wmd.37.2020.03.31.09.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 09:13:08 -0700 (PDT)
Subject: Re: Raid-6 won't boot
From:   Alexander Shenkin <al@shenkin.org>
To:     Roger Heflin <rogerheflin@gmail.com>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
 <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk>
 <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
 <CAAMCDee6TcJ_wR6rkQw5V02KyqPQ+xDf+bK+pQPbbfaptO_Tvg@mail.gmail.com>
 <1f393884-dc48-c03e-f734-f9880d9eed96@shenkin.org>
 <CAAMCDedj7TQAAGzSfQgAftKSmrjNmzHgQUs-X2mQZyFPG62_-A@mail.gmail.com>
 <c8185f80-837e-9654-ee19-611a030a0d54@shenkin.org>
 <CAAMCDefr2FakGTz5ok-qvTZiDNTj87vQSWP9ynM_bxtnB=-fkw@mail.gmail.com>
 <fa7e9b6d-28f3-8c9f-0901-eeac761e382f@shenkin.org>
 <CAAMCDefXygV4CZdxadfRFAV+HeEqnY8nWG1hpsVi4tBf1PYYww@mail.gmail.com>
 <740b37a3-83fa-a03f-c253-785bb286cefc@shenkin.org>
 <CAAMCDecv1-rY9Rt1puDn6WPYxGZ1=Qzje1ju=7aEOonBzkekVw@mail.gmail.com>
 <98b9aff4-978c-5d8d-1325-bda26bf7997f@shenkin.org>
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
Message-ID: <0354b224-b762-915e-5f89-61c485fa0ec4@shenkin.org>
Date:   Tue, 31 Mar 2020 17:13:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <98b9aff4-978c-5d8d-1325-bda26bf7997f@shenkin.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 200330-0, 03/30/2020), Outbound message
X-Antivirus-Status: Clean
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

quick followup: trying a stop and assemble results in the message that
it "Failed to restore critical section for reshape, sorry".

On 3/31/2020 11:08 AM, Alexander Shenkin wrote:
> Thanks Roger,
> 
> It seems only the Raid1 module is loaded.  I didn't find a
> straightforward way to get that module loaded... any suggestions?  Or,
> will I have to find another livecd that contains raid456?
> 
> Thanks,
> Allie
> 
> On 3/30/2020 9:45 PM, Roger Heflin wrote:
>> They all seem to be there, all seem to report all 7 disks active, so
>> it does not appear to be degraded. All event counters are the same.
>> Something has to be causing them to not be scanned and assembled at
>> all.
>>
>> Is the rescue disk a similar OS to what you have installed?  If it is
>> you might try a random say fedora livecd and see if it acts any
>> different.
>>
>> what does fdisk -l /dev/sda look like?
>>
>> Is the raid456 module loaded (lsmod | grep raid)?
>>
>> what does cat /proc/cmdline look like?
>>
>> you might also run this:
>> file -s /dev/sd*3
>> But I think it is going to show us the same thing as what the mdadm
>> --examine is reporting.
>>
>> On Mon, Mar 30, 2020 at 3:05 PM Alexander Shenkin <al@shenkin.org> wrote:
>>>
>>> See attached.  I should mention that the last drive i added is on a new
>>> controller that is separate from the other drives, but seemed to work
>>> fine for a bit, so kinda doubt that's the issue...
>>>
>>> thanks,
>>>
>>> allie
>>>
>>> On 3/30/2020 6:21 PM, Roger Heflin wrote:
>>>> do this against each partition that had it:
>>>>
>>>>  mdadm --examine /dev/sd***
>>>>
>>>> It seems like it is not seeing it as a md-raid.
>>>>
>>>> On Mon, Mar 30, 2020 at 11:13 AM Alexander Shenkin <al@shenkin.org> wrote:
>>>>> Thanks Roger,
>>>>>
>>>>> The only line that isn't commented out in /etc/mdadm.conf is "DEVICE
>>>>> partitions"...
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Allie
>>>>>
>>>>> On 3/30/2020 4:53 PM, Roger Heflin wrote:
>>>>>> That seems really odd.  Is the raid456 module loaded?
>>>>>>
>>>>>> On mine I see messages like this for each disk it scanned and
>>>>>> considered as maybe possibly being an array member.
>>>>>>  kernel: [   83.468700] md/raid:md13: device sdi3 operational as raid disk 5
>>>>>> and messages like this:
>>>>>>  md/raid:md14: not clean -- starting background reconstruction
>>>>>>
>>>>>> You might look at /etc/mdadm.conf on the rescue cd and see if it has a
>>>>>> DEVICE line that limits what is being scanned.
>>>>>>
>>>>>> On Mon, Mar 30, 2020 at 10:13 AM Alexander Shenkin <al@shenkin.org> wrote:
>>>>>>> Thanks Roger,
>>>>>>>
>>>>>>> that grep just returns the detection of the raid1 (md127).  See dmesg
>>>>>>> and mdadm --detail results attached.
>>>>>>>
>>>>>>> Many thanks,
>>>>>>> allie
>>>>>>>
>>>>>>> On 3/28/2020 1:36 PM, Roger Heflin wrote:
>>>>>>>> Try this grep:
>>>>>>>> dmesg | grep "md/raid", if that returns nothing if you can just send
>>>>>>>> the entire dmesg.
>>>>>>>>
>>>>>>>> On Sat, Mar 28, 2020 at 2:47 AM Alexander Shenkin <al@shenkin.org> wrote:
>>>>>>>>> Thanks Roger.  dmesg has nothing in it referring to md126 or md127....
>>>>>>>>> any other thoughts on how to investigate?
>>>>>>>>>
>>>>>>>>> thanks,
>>>>>>>>> allie
>>>>>>>>>
>>>>>>>>> On 3/27/2020 3:55 PM, Roger Heflin wrote:
>>>>>>>>>> A non-assembled array always reports raid1.
>>>>>>>>>>
>>>>>>>>>> I would run "dmesg | grep md126" to start with and see what it reports it saw.
>>>>>>>>>>
>>>>>>>>>> On Fri, Mar 27, 2020 at 10:29 AM Alexander Shenkin <al@shenkin.org> wrote:
>>>>>>>>>>> Thanks Wol,
>>>>>>>>>>>
>>>>>>>>>>> Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
>>>>>>>>>>> reported.  The first (md126) in reported as inactive with all 7 disks
>>>>>>>>>>> listed as spares.  The second (md127) is reported as active
>>>>>>>>>>> auto-read-only with all 7 disks operational.  Also, the only
>>>>>>>>>>> "personality" reported is Raid1.  I could go ahead with your suggestion
>>>>>>>>>>> of mdadm --stop array and then mdadm --assemble, but I thought the
>>>>>>>>>>> reporting of just the Raid1 personality was a bit strange, so wanted to
>>>>>>>>>>> check in before doing that...
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Allie
>>>>>>>>>>>
>>>>>>>>>>> On 3/26/2020 10:00 PM, antlists wrote:
>>>>>>>>>>>> On 26/03/2020 17:07, Alexander Shenkin wrote:
>>>>>>>>>>>>> I surely need to boot with a rescue disk of some sort, but from there,
>>>>>>>>>>>>> I'm not sure exactly when I should do.  Any suggestions are very welcome!
>>>>>>>>>>>> Okay. Find a liveCD that supports raid (hopefully something like
>>>>>>>>>>>> SystemRescueCD). Make sure it has a very recent kernel and the latest
>>>>>>>>>>>> mdadm.
>>>>>>>>>>>>
>>>>>>>>>>>> All being well, the resync will restart, and when it's finished your
>>>>>>>>>>>> system will be fine. If it doesn't restart on its own, do an "mdadm
>>>>>>>>>>>> --stop array", followed by an "mdadm --assemble"
>>>>>>>>>>>>
>>>>>>>>>>>> If that doesn't work, then
>>>>>>>>>>>>
>>>>>>>>>>>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>>>>>>>>>>>>
>>>>>>>>>>>> Cheers,
>>>>>>>>>>>> Wol
