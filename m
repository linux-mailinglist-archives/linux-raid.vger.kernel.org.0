Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358BE198514
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 22:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgC3UFK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 16:05:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36275 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgC3UFK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Mar 2020 16:05:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so213569wme.1
        for <linux-raid@vger.kernel.org>; Mon, 30 Mar 2020 13:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenkin.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=AlN68G1MuAnVBUUCI0XN+6l/6r8NanpBng6n9Hej/p8=;
        b=GVnngLxHL1RUBlwpIF5OjC/KMLltj536MUN3UMyxODws6lvz8XDOUqeDinnBBWw1rf
         yJ1BbcKoKDGCNl8Zsvgj3QdTm9s0gb0znvBxfDn8IBXpl+Wd0xPN4SjNW1YISMPNJ/yH
         KIFuxdX1Ahi/klh/hdU8vSuIIJUDqn1p5R78I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=AlN68G1MuAnVBUUCI0XN+6l/6r8NanpBng6n9Hej/p8=;
        b=XWMjOezAbyEPEtLLqA2bSdhczrCe0VZ9dWXhd3n9cBRi0wNTPjuoTSPZPJ3vtdBXOp
         pdGy/nl8v1SAv1MyDf0wC/wN3goyAmXLSQHlkwY8dTmBTNXyLSY5iaDfAh5DXajS4H0h
         CWFlafzWiPyMGWeSggi1p2ywJODl0gle5fYngxAn4WxAM3pHUJpX277RkzEbf+cjZTTn
         b6CUNhLqIqRlSKwbEv91LeiCoNvKCqmD9mToefk8dp6zGfYptYbNZb+7FBjcqZbo4axw
         RbhQtY4wzt3fHLNoLfBu6yTtVa/MM4cH+l6y+crOlJcCd3WvhZbVDOFfU0NWFs75Hlfr
         jYig==
X-Gm-Message-State: ANhLgQ3Yczn4Hq/rNx/L2LUpk3DhrJr660ldW/sW9sYixi6q54UKMlXB
        i+kNBTEUMFMzDHFmuFzZ74ThEIYNKKjTng==
X-Google-Smtp-Source: ADFU+vvnDYnpwBn0ITHg8b0LkOOxudyzjf4l4PqFRIUjlMZP55wcJ5K2Cy38VvgMqNSv8UqNrMwpQw==
X-Received: by 2002:a05:600c:21da:: with SMTP id x26mr887916wmj.47.1585598706882;
        Mon, 30 Mar 2020 13:05:06 -0700 (PDT)
Received: from [192.168.1.154] (cpc69403-oxfd27-2-0-cust350.4-3.cable.virginm.net. [82.15.57.95])
        by smtp.googlemail.com with ESMTPSA id 5sm20961161wrs.20.2020.03.30.13.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 13:05:05 -0700 (PDT)
Subject: Re: Raid-6 won't boot
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
Message-ID: <740b37a3-83fa-a03f-c253-785bb286cefc@shenkin.org>
Date:   Mon, 30 Mar 2020 21:05:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAAMCDefXygV4CZdxadfRFAV+HeEqnY8nWG1hpsVi4tBf1PYYww@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------9E46969FD00FD09420421B54"
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This is a multi-part message in MIME format.
--------------9E46969FD00FD09420421B54
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

See attached.  I should mention that the last drive i added is on a new
controller that is separate from the other drives, but seemed to work
fine for a bit, so kinda doubt that's the issue...

thanks,

allie

On 3/30/2020 6:21 PM, Roger Heflin wrote:
> do this against each partition that had it:
>
>  mdadm --examine /dev/sd***
>
> It seems like it is not seeing it as a md-raid.
>
> On Mon, Mar 30, 2020 at 11:13 AM Alexander Shenkin <al@shenkin.org> wrote:
>> Thanks Roger,
>>
>> The only line that isn't commented out in /etc/mdadm.conf is "DEVICE
>> partitions"...
>>
>> Thanks,
>>
>> Allie
>>
>> On 3/30/2020 4:53 PM, Roger Heflin wrote:
>>> That seems really odd.  Is the raid456 module loaded?
>>>
>>> On mine I see messages like this for each disk it scanned and
>>> considered as maybe possibly being an array member.
>>>  kernel: [   83.468700] md/raid:md13: device sdi3 operational as raid disk 5
>>> and messages like this:
>>>  md/raid:md14: not clean -- starting background reconstruction
>>>
>>> You might look at /etc/mdadm.conf on the rescue cd and see if it has a
>>> DEVICE line that limits what is being scanned.
>>>
>>> On Mon, Mar 30, 2020 at 10:13 AM Alexander Shenkin <al@shenkin.org> wrote:
>>>> Thanks Roger,
>>>>
>>>> that grep just returns the detection of the raid1 (md127).  See dmesg
>>>> and mdadm --detail results attached.
>>>>
>>>> Many thanks,
>>>> allie
>>>>
>>>> On 3/28/2020 1:36 PM, Roger Heflin wrote:
>>>>> Try this grep:
>>>>> dmesg | grep "md/raid", if that returns nothing if you can just send
>>>>> the entire dmesg.
>>>>>
>>>>> On Sat, Mar 28, 2020 at 2:47 AM Alexander Shenkin <al@shenkin.org> wrote:
>>>>>> Thanks Roger.  dmesg has nothing in it referring to md126 or md127....
>>>>>> any other thoughts on how to investigate?
>>>>>>
>>>>>> thanks,
>>>>>> allie
>>>>>>
>>>>>> On 3/27/2020 3:55 PM, Roger Heflin wrote:
>>>>>>> A non-assembled array always reports raid1.
>>>>>>>
>>>>>>> I would run "dmesg | grep md126" to start with and see what it reports it saw.
>>>>>>>
>>>>>>> On Fri, Mar 27, 2020 at 10:29 AM Alexander Shenkin <al@shenkin.org> wrote:
>>>>>>>> Thanks Wol,
>>>>>>>>
>>>>>>>> Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
>>>>>>>> reported.  The first (md126) in reported as inactive with all 7 disks
>>>>>>>> listed as spares.  The second (md127) is reported as active
>>>>>>>> auto-read-only with all 7 disks operational.  Also, the only
>>>>>>>> "personality" reported is Raid1.  I could go ahead with your suggestion
>>>>>>>> of mdadm --stop array and then mdadm --assemble, but I thought the
>>>>>>>> reporting of just the Raid1 personality was a bit strange, so wanted to
>>>>>>>> check in before doing that...
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Allie
>>>>>>>>
>>>>>>>> On 3/26/2020 10:00 PM, antlists wrote:
>>>>>>>>> On 26/03/2020 17:07, Alexander Shenkin wrote:
>>>>>>>>>> I surely need to boot with a rescue disk of some sort, but from there,
>>>>>>>>>> I'm not sure exactly when I should do.  Any suggestions are very welcome!
>>>>>>>>> Okay. Find a liveCD that supports raid (hopefully something like
>>>>>>>>> SystemRescueCD). Make sure it has a very recent kernel and the latest
>>>>>>>>> mdadm.
>>>>>>>>>
>>>>>>>>> All being well, the resync will restart, and when it's finished your
>>>>>>>>> system will be fine. If it doesn't restart on its own, do an "mdadm
>>>>>>>>> --stop array", followed by an "mdadm --assemble"
>>>>>>>>>
>>>>>>>>> If that doesn't work, then
>>>>>>>>>
>>>>>>>>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>>>>>>>>>
>>>>>>>>> Cheers,
>>>>>>>>> Wol

--------------9E46969FD00FD09420421B54
Content-Type: text/plain; charset=UTF-8;
 name="sda3.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sda3.txt"

L2Rldi9zZGEzOgogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYwogICAgICAgIFZlcnNpb24g
OiAxLjIKICAgIEZlYXR1cmUgTWFwIDogMHg1CiAgICAgQXJyYXkgVVVJRCA6IGM3MzAzZjYy
OmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjCiAgICAgICAgICAgTmFtZSA6IHVidW50dToy
CiAgQ3JlYXRpb24gVGltZSA6IFN1biBGZWIgIDUgMjM6Mzk6NTggMjAxNwogICAgIFJhaWQg
TGV2ZWwgOiByYWlkNgogICBSYWlkIERldmljZXMgOiA3CgogQXZhaWwgRGV2IFNpemUgOiA1
ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQogICAgIEFycmF5IFNpemUgOiAx
NDYwMDk0NDY0MCAoMTM5MjQuNTUgR2lCIDE0OTUxLjM3IEdCKQogICAgRGF0YSBPZmZzZXQg
OiAyNjIxNDQgc2VjdG9ycwogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMKICAgVW51c2Vk
IFNwYWNlIDogYmVmb3JlPTI2MjA1NiBzZWN0b3JzLCBhZnRlcj0wIHNlY3RvcnMKICAgICAg
ICAgIFN0YXRlIDogYWN0aXZlCiAgICBEZXZpY2UgVVVJRCA6IDEwYmRiZWQ1OmNiNzBjOGE5
OjU2NmMzODRkOmVjNGM5MjZlCgpJbnRlcm5hbCBCaXRtYXAgOiA4IHNlY3RvcnMgZnJvbSBz
dXBlcmJsb2NrCiAgUmVzaGFwZSBwb3MnbiA6IDAKICBEZWx0YSBEZXZpY2VzIDogMSAoNi0+
NykKCiAgICBVcGRhdGUgVGltZSA6IFR1ZSBGZWIgMjUgMDk6MjE6MjcgMjAyMAogIEJhZCBC
bG9jayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMK
ICAgICAgIENoZWNrc3VtIDogMzAwZjY5NDUgLSBjb3JyZWN0CiAgICAgICAgIEV2ZW50cyA6
IDMxNjQ4NQoKICAgICAgICAgTGF5b3V0IDogbGVmdC1zeW1tZXRyaWMKICAgICBDaHVuayBT
aXplIDogNTEySwoKICAgRGV2aWNlIFJvbGUgOiBBY3RpdmUgZGV2aWNlIDAKICAgQXJyYXkg
U3RhdGUgOiBBQUFBQUFBICgnQScgPT0gYWN0aXZlLCAnLicgPT0gbWlzc2luZywgJ1InID09
IHJlcGxhY2luZykK
--------------9E46969FD00FD09420421B54
Content-Type: text/plain; charset=UTF-8;
 name="sdb3.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sdb3.txt"

L2Rldi9zZGIzOgogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYwogICAgICAgIFZlcnNpb24g
OiAxLjIKICAgIEZlYXR1cmUgTWFwIDogMHg1CiAgICAgQXJyYXkgVVVJRCA6IGM3MzAzZjYy
OmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjCiAgICAgICAgICAgTmFtZSA6IHVidW50dToy
CiAgQ3JlYXRpb24gVGltZSA6IFN1biBGZWIgIDUgMjM6Mzk6NTggMjAxNwogICAgIFJhaWQg
TGV2ZWwgOiByYWlkNgogICBSYWlkIERldmljZXMgOiA3CgogQXZhaWwgRGV2IFNpemUgOiA1
ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQogICAgIEFycmF5IFNpemUgOiAx
NDYwMDk0NDY0MCAoMTM5MjQuNTUgR2lCIDE0OTUxLjM3IEdCKQogICAgRGF0YSBPZmZzZXQg
OiAyNjIxNDQgc2VjdG9ycwogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMKICAgVW51c2Vk
IFNwYWNlIDogYmVmb3JlPTI2MjA1NiBzZWN0b3JzLCBhZnRlcj0wIHNlY3RvcnMKICAgICAg
ICAgIFN0YXRlIDogYWN0aXZlCiAgICBEZXZpY2UgVVVJRCA6IGNmNzBkYWQ1OjBjOWZmNWY2
OmVkZTY4OWYyOmNjZWUyZWIwCgpJbnRlcm5hbCBCaXRtYXAgOiA4IHNlY3RvcnMgZnJvbSBz
dXBlcmJsb2NrCiAgUmVzaGFwZSBwb3MnbiA6IDAKICBEZWx0YSBEZXZpY2VzIDogMSAoNi0+
NykKCiAgICBVcGRhdGUgVGltZSA6IFR1ZSBGZWIgMjUgMDk6MjE6MjcgMjAyMAogIEJhZCBC
bG9jayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMK
ICAgICAgIENoZWNrc3VtIDogNjQ0NjY3YmIgLSBjb3JyZWN0CiAgICAgICAgIEV2ZW50cyA6
IDMxNjQ4NQoKICAgICAgICAgTGF5b3V0IDogbGVmdC1zeW1tZXRyaWMKICAgICBDaHVuayBT
aXplIDogNTEySwoKICAgRGV2aWNlIFJvbGUgOiBBY3RpdmUgZGV2aWNlIDEKICAgQXJyYXkg
U3RhdGUgOiBBQUFBQUFBICgnQScgPT0gYWN0aXZlLCAnLicgPT0gbWlzc2luZywgJ1InID09
IHJlcGxhY2luZykK
--------------9E46969FD00FD09420421B54
Content-Type: text/plain; charset=UTF-8;
 name="sdc3.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sdc3.txt"

L2Rldi9zZGMzOgogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYwogICAgICAgIFZlcnNpb24g
OiAxLjIKICAgIEZlYXR1cmUgTWFwIDogMHg1CiAgICAgQXJyYXkgVVVJRCA6IGM3MzAzZjYy
OmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjCiAgICAgICAgICAgTmFtZSA6IHVidW50dToy
CiAgQ3JlYXRpb24gVGltZSA6IFN1biBGZWIgIDUgMjM6Mzk6NTggMjAxNwogICAgIFJhaWQg
TGV2ZWwgOiByYWlkNgogICBSYWlkIERldmljZXMgOiA3CgogQXZhaWwgRGV2IFNpemUgOiA1
ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQogICAgIEFycmF5IFNpemUgOiAx
NDYwMDk0NDY0MCAoMTM5MjQuNTUgR2lCIDE0OTUxLjM3IEdCKQogICAgRGF0YSBPZmZzZXQg
OiAyNjIxNDQgc2VjdG9ycwogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMKICAgVW51c2Vk
IFNwYWNlIDogYmVmb3JlPTI2MjA1NiBzZWN0b3JzLCBhZnRlcj0wIHNlY3RvcnMKICAgICAg
ICAgIFN0YXRlIDogYWN0aXZlCiAgICBEZXZpY2UgVVVJRCA6IGY4ODM5OTUyOmVhYmEyZTlj
OmMyYzQwMWQ0OjNlMDU5MmE1CgpJbnRlcm5hbCBCaXRtYXAgOiA4IHNlY3RvcnMgZnJvbSBz
dXBlcmJsb2NrCiAgUmVzaGFwZSBwb3MnbiA6IDAKICBEZWx0YSBEZXZpY2VzIDogMSAoNi0+
NykKCiAgICBVcGRhdGUgVGltZSA6IFR1ZSBGZWIgMjUgMDk6MjE6MjcgMjAyMAogIEJhZCBC
bG9jayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMK
ICAgICAgIENoZWNrc3VtIDogNWQxOThiMDYgLSBjb3JyZWN0CiAgICAgICAgIEV2ZW50cyA6
IDMxNjQ4NQoKICAgICAgICAgTGF5b3V0IDogbGVmdC1zeW1tZXRyaWMKICAgICBDaHVuayBT
aXplIDogNTEySwoKICAgRGV2aWNlIFJvbGUgOiBBY3RpdmUgZGV2aWNlIDIKICAgQXJyYXkg
U3RhdGUgOiBBQUFBQUFBICgnQScgPT0gYWN0aXZlLCAnLicgPT0gbWlzc2luZywgJ1InID09
IHJlcGxhY2luZykK
--------------9E46969FD00FD09420421B54
Content-Type: text/plain; charset=UTF-8;
 name="sdd3.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sdd3.txt"

L2Rldi9zZGQzOgogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYwogICAgICAgIFZlcnNpb24g
OiAxLjIKICAgIEZlYXR1cmUgTWFwIDogMHg1CiAgICAgQXJyYXkgVVVJRCA6IGM3MzAzZjYy
OmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjCiAgICAgICAgICAgTmFtZSA6IHVidW50dToy
CiAgQ3JlYXRpb24gVGltZSA6IFN1biBGZWIgIDUgMjM6Mzk6NTggMjAxNwogICAgIFJhaWQg
TGV2ZWwgOiByYWlkNgogICBSYWlkIERldmljZXMgOiA3CgogQXZhaWwgRGV2IFNpemUgOiA1
ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQogICAgIEFycmF5IFNpemUgOiAx
NDYwMDk0NDY0MCAoMTM5MjQuNTUgR2lCIDE0OTUxLjM3IEdCKQogICAgRGF0YSBPZmZzZXQg
OiAyNjIxNDQgc2VjdG9ycwogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMKICAgVW51c2Vk
IFNwYWNlIDogYmVmb3JlPTI2MjA1NiBzZWN0b3JzLCBhZnRlcj0wIHNlY3RvcnMKICAgICAg
ICAgIFN0YXRlIDogYWN0aXZlCiAgICBEZXZpY2UgVVVJRCA6IDg3NWEwZGJkOjk2NWE5OTg2
OjFiNzhlYjNkOmUxNWZlZTUwCgpJbnRlcm5hbCBCaXRtYXAgOiA4IHNlY3RvcnMgZnJvbSBz
dXBlcmJsb2NrCiAgUmVzaGFwZSBwb3MnbiA6IDAKICBEZWx0YSBEZXZpY2VzIDogMSAoNi0+
NykKCiAgICBVcGRhdGUgVGltZSA6IFR1ZSBGZWIgMjUgMDk6MjE6MjcgMjAyMAogIEJhZCBC
bG9jayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMK
ICAgICAgIENoZWNrc3VtIDogYzczZTBmM2YgLSBjb3JyZWN0CiAgICAgICAgIEV2ZW50cyA6
IDMxNjQ4NQoKICAgICAgICAgTGF5b3V0IDogbGVmdC1zeW1tZXRyaWMKICAgICBDaHVuayBT
aXplIDogNTEySwoKICAgRGV2aWNlIFJvbGUgOiBBY3RpdmUgZGV2aWNlIDMKICAgQXJyYXkg
U3RhdGUgOiBBQUFBQUFBICgnQScgPT0gYWN0aXZlLCAnLicgPT0gbWlzc2luZywgJ1InID09
IHJlcGxhY2luZykK
--------------9E46969FD00FD09420421B54
Content-Type: text/plain; charset=UTF-8;
 name="sde3.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sde3.txt"

L2Rldi9zZGUzOgogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYwogICAgICAgIFZlcnNpb24g
OiAxLjIKICAgIEZlYXR1cmUgTWFwIDogMHg1CiAgICAgQXJyYXkgVVVJRCA6IGM3MzAzZjYy
OmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjCiAgICAgICAgICAgTmFtZSA6IHVidW50dToy
CiAgQ3JlYXRpb24gVGltZSA6IFN1biBGZWIgIDUgMjM6Mzk6NTggMjAxNwogICAgIFJhaWQg
TGV2ZWwgOiByYWlkNgogICBSYWlkIERldmljZXMgOiA3CgogQXZhaWwgRGV2IFNpemUgOiA1
ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQogICAgIEFycmF5IFNpemUgOiAx
NDYwMDk0NDY0MCAoMTM5MjQuNTUgR2lCIDE0OTUxLjM3IEdCKQogICAgRGF0YSBPZmZzZXQg
OiAyNjIxNDQgc2VjdG9ycwogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMKICAgVW51c2Vk
IFNwYWNlIDogYmVmb3JlPTI2MjA1NiBzZWN0b3JzLCBhZnRlcj0wIHNlY3RvcnMKICAgICAg
ICAgIFN0YXRlIDogYWN0aXZlCiAgICBEZXZpY2UgVVVJRCA6IDYzNWVmNzFiOmU0YWRkOTI1
OjMwYWU0ZjBhOmY2YjQ2NjExCgpJbnRlcm5hbCBCaXRtYXAgOiA4IHNlY3RvcnMgZnJvbSBz
dXBlcmJsb2NrCiAgUmVzaGFwZSBwb3MnbiA6IDAKICBEZWx0YSBEZXZpY2VzIDogMSAoNi0+
NykKCiAgICBVcGRhdGUgVGltZSA6IFR1ZSBGZWIgMjUgMDk6MjE6MjcgMjAyMAogIEJhZCBC
bG9jayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMK
ICAgICAgIENoZWNrc3VtIDogNTI0NGYxOTYgLSBjb3JyZWN0CiAgICAgICAgIEV2ZW50cyA6
IDMxNjQ4NQoKICAgICAgICAgTGF5b3V0IDogbGVmdC1zeW1tZXRyaWMKICAgICBDaHVuayBT
aXplIDogNTEySwoKICAgRGV2aWNlIFJvbGUgOiBBY3RpdmUgZGV2aWNlIDYKICAgQXJyYXkg
U3RhdGUgOiBBQUFBQUFBICgnQScgPT0gYWN0aXZlLCAnLicgPT0gbWlzc2luZywgJ1InID09
IHJlcGxhY2luZykK
--------------9E46969FD00FD09420421B54
Content-Type: text/plain; charset=UTF-8;
 name="sdf3.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sdf3.txt"

L2Rldi9zZGYzOgogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYwogICAgICAgIFZlcnNpb24g
OiAxLjIKICAgIEZlYXR1cmUgTWFwIDogMHg1CiAgICAgQXJyYXkgVVVJRCA6IGM3MzAzZjYy
OmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjCiAgICAgICAgICAgTmFtZSA6IHVidW50dToy
CiAgQ3JlYXRpb24gVGltZSA6IFN1biBGZWIgIDUgMjM6Mzk6NTggMjAxNwogICAgIFJhaWQg
TGV2ZWwgOiByYWlkNgogICBSYWlkIERldmljZXMgOiA3CgogQXZhaWwgRGV2IFNpemUgOiA1
ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQogICAgIEFycmF5IFNpemUgOiAx
NDYwMDk0NDY0MCAoMTM5MjQuNTUgR2lCIDE0OTUxLjM3IEdCKQogICAgRGF0YSBPZmZzZXQg
OiAyNjIxNDQgc2VjdG9ycwogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMKICAgVW51c2Vk
IFNwYWNlIDogYmVmb3JlPTI2MjA1NiBzZWN0b3JzLCBhZnRlcj0wIHNlY3RvcnMKICAgICAg
ICAgIFN0YXRlIDogYWN0aXZlCiAgICBEZXZpY2UgVVVJRCA6IGRjMGJkYThjOjI0NTdmYjRj
OmY4N2E0YmVjOjhkNWI1OGVkCgpJbnRlcm5hbCBCaXRtYXAgOiA4IHNlY3RvcnMgZnJvbSBz
dXBlcmJsb2NrCiAgUmVzaGFwZSBwb3MnbiA6IDAKICBEZWx0YSBEZXZpY2VzIDogMSAoNi0+
NykKCiAgICBVcGRhdGUgVGltZSA6IFR1ZSBGZWIgMjUgMDk6MjE6MjcgMjAyMAogIEJhZCBC
bG9jayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMK
ICAgICAgIENoZWNrc3VtIDogYTgzNmJiYWUgLSBjb3JyZWN0CiAgICAgICAgIEV2ZW50cyA6
IDMxNjQ4NQoKICAgICAgICAgTGF5b3V0IDogbGVmdC1zeW1tZXRyaWMKICAgICBDaHVuayBT
aXplIDogNTEySwoKICAgRGV2aWNlIFJvbGUgOiBBY3RpdmUgZGV2aWNlIDUKICAgQXJyYXkg
U3RhdGUgOiBBQUFBQUFBICgnQScgPT0gYWN0aXZlLCAnLicgPT0gbWlzc2luZywgJ1InID09
IHJlcGxhY2luZykK
--------------9E46969FD00FD09420421B54
Content-Type: text/plain; charset=UTF-8;
 name="sdg3.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sdg3.txt"

L2Rldi9zZGczOgogICAgICAgICAgTWFnaWMgOiBhOTJiNGVmYwogICAgICAgIFZlcnNpb24g
OiAxLjIKICAgIEZlYXR1cmUgTWFwIDogMHg1CiAgICAgQXJyYXkgVVVJRCA6IGM3MzAzZjYy
OmQ4NDhkNDI0OjI2OTU4MWM4OjgzYTA0NWVjCiAgICAgICAgICAgTmFtZSA6IHVidW50dToy
CiAgQ3JlYXRpb24gVGltZSA6IFN1biBGZWIgIDUgMjM6Mzk6NTggMjAxNwogICAgIFJhaWQg
TGV2ZWwgOiByYWlkNgogICBSYWlkIERldmljZXMgOiA3CgogQXZhaWwgRGV2IFNpemUgOiA1
ODQwMzc3ODU2ICgyNzg0LjkxIEdpQiAyOTkwLjI3IEdCKQogICAgIEFycmF5IFNpemUgOiAx
NDYwMDk0NDY0MCAoMTM5MjQuNTUgR2lCIDE0OTUxLjM3IEdCKQogICAgRGF0YSBPZmZzZXQg
OiAyNjIxNDQgc2VjdG9ycwogICBTdXBlciBPZmZzZXQgOiA4IHNlY3RvcnMKICAgVW51c2Vk
IFNwYWNlIDogYmVmb3JlPTI2MjA1NiBzZWN0b3JzLCBhZnRlcj0wIHNlY3RvcnMKICAgICAg
ICAgIFN0YXRlIDogYWN0aXZlCiAgICBEZXZpY2UgVVVJRCA6IGRjODQyZGMzOjA5YzkxMGM3
OmMzNTFjMzA3OmUyMzgzZDEzCgpJbnRlcm5hbCBCaXRtYXAgOiA4IHNlY3RvcnMgZnJvbSBz
dXBlcmJsb2NrCiAgUmVzaGFwZSBwb3MnbiA6IDAKICBEZWx0YSBEZXZpY2VzIDogMSAoNi0+
NykKCiAgICBVcGRhdGUgVGltZSA6IFR1ZSBGZWIgMjUgMDk6MjE6MjcgMjAyMAogIEJhZCBC
bG9jayBMb2cgOiA1MTIgZW50cmllcyBhdmFpbGFibGUgYXQgb2Zmc2V0IDcyIHNlY3RvcnMK
ICAgICAgIENoZWNrc3VtIDogOTlmYzVhYjMgLSBjb3JyZWN0CiAgICAgICAgIEV2ZW50cyA6
IDMxNjQ4NQoKICAgICAgICAgTGF5b3V0IDogbGVmdC1zeW1tZXRyaWMKICAgICBDaHVuayBT
aXplIDogNTEySwoKICAgRGV2aWNlIFJvbGUgOiBBY3RpdmUgZGV2aWNlIDQKICAgQXJyYXkg
U3RhdGUgOiBBQUFBQUFBICgnQScgPT0gYWN0aXZlLCAnLicgPT0gbWlzc2luZywgJ1InID09
IHJlcGxhY2luZykK
--------------9E46969FD00FD09420421B54--
