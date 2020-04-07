Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E561A0BC0
	for <lists+linux-raid@lfdr.de>; Tue,  7 Apr 2020 12:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgDGK2a (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Apr 2020 06:28:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36722 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgDGKZT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 Apr 2020 06:25:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so3271694wrm.3
        for <linux-raid@vger.kernel.org>; Tue, 07 Apr 2020 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenkin.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dzJEbZ+kAlxGzvfqL9cIvGKdJeGu3oAeRY0SM/lBibY=;
        b=G15Q84NDjxB8hxzdkL7SbEyYXUTZ5hSwMfEg79y6eAadnNvloGOH2/AytL9YpSbpYB
         KeYn5rTThGBorN/JniRdXzZ0hdfT0ChDyGWOMvN1wLnGovY/V+pyAsTOzWLGEPmZJSb5
         GkRrYsIvAqdqkgHNI//2pU/IqowLeuQ9b2D/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dzJEbZ+kAlxGzvfqL9cIvGKdJeGu3oAeRY0SM/lBibY=;
        b=afI4SkDr3GIER/2/RzgJ5GDfd7bAwXNCvX46ss3RrbB+ezwdpgFA52b7cF5gAzORh0
         CO7fpVxXxwPSnOTi9bw227ugdzhW2TBDltKcvimTJtEa2igYsGWuYtDa6D5rrpL0iAZX
         Cah1o/3nkqHXSkhwJtFp57RtXGF2fJav/FW/bRoBw4/8P/sfGLwB/Z2IXb0CdINGr0hu
         C6R+hMN91fSaP0k7ojtbyTPD2TkFCHPy/vSrfKsFIy+Yl+Wmj3C3y2jbBYGMIG75yixf
         Df55R6JF3gAEKnU5Fm51meFUBc9x05PbSLMJT3usGMK+wjLSuEk7tDCeNjOl/wvbCxcq
         qIrQ==
X-Gm-Message-State: AGi0PuYPo8l/OYKipCSORthvo8KyXKHfUP8Mb4b0D8tovuZGe4Wu5B61
        CvfymjwXP1X8iGr06xVLFQXlLPF0ZKjQOg==
X-Google-Smtp-Source: APiQypKa5jsl0NcLy6CeczidOUHnWFee///X2S5IDmZswTaQr8A6vmp4WB2d2/rokCKfky3T51/ZKA==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr2059491wrn.237.1586255116680;
        Tue, 07 Apr 2020 03:25:16 -0700 (PDT)
Received: from [192.168.1.154] (cpc69403-oxfd27-2-0-cust350.4-3.cable.virginm.net. [82.15.57.95])
        by smtp.googlemail.com with ESMTPSA id b7sm31004717wrn.67.2020.04.07.03.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 03:25:15 -0700 (PDT)
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
Message-ID: <945332b3-6a47-c2b3-7d1e-70a44f6fd370@shenkin.org>
Date:   Tue, 7 Apr 2020 11:25:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <08d66411-5045-56e1-cbad-7edefa94a363@turmel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 200406-0, 04/06/2020), Outbound message
X-Antivirus-Status: Clean
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 4/6/2020 9:34 PM, Phil Turmel wrote:
> On 4/6/20 12:27 PM, Wols Lists wrote:
>> On 06/04/20 17:12, Roger Heflin wrote:
>>> When I looked at your detailed files you sent a few days ago, all of
>>> the reshapes (on all disks) indicated that they were at position 0, so
>>> it kind of appears that the reshape never actually started at all and
>>> hung immediately which is probably why it cannot find the critical
>>> section, it hung prior to that getting done.   Not entirely sure how
>>> to undo a reshape that failed like this.
>>
>> This seems quite common. Search the archives - it's probably something
>> like --assemble --revert-reshape.
> 
> Ah, yes.  I recall cases where mdmon wouldn't start or wouldn't open the
> array to start moving the stripes, so the kernel wouldn't advance.
> SystemD was one of the culprits, I believe, back then.

Thanks all.

So, is the following safe to run, and a good idea to try?

mdadm --assemble --update=revert-reshape /dev/md127 /dev/sd[a-g]3

And if that doesn't work, add a force?

mdadm --assemble --force --update=revert-reshape /dev/md127 /dev/sd[a-g]3

And adding --invalid-backup if it complains about backup files?

Thanks,
Allie
