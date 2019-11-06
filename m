Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF07FF1AB3
	for <lists+linux-raid@lfdr.de>; Wed,  6 Nov 2019 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbfKFQCw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Nov 2019 11:02:52 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44521 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKFQCv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 Nov 2019 11:02:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id a67so7668539edf.11
        for <linux-raid@vger.kernel.org>; Wed, 06 Nov 2019 08:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Q2kjcsafX2irxATMiI1DLqTaVIbvyjUAd5/rxyhoaHA=;
        b=CMa9vRUrUy/6J2P2t5KT6ES+tLn+MvLQCVf5KLDBVSK5EBkiuGtBAPPUYOZQ7btOBz
         RxKttlDdGyTPzZJHEV6l4raNxIcMC6GT8122nYJQhhrfjuq5cImf+3pkBgQ0EeOL53U1
         lVzJJchy40RGOPiNIZrMwT+gCYmBcYY40NKpDYtjIH808e8RYfB1HZtWnpMaxQIuwe8Q
         R6LVJs+SyHqGVAPlilmMNuWhc/7SO3C0r8/pQkD/mxSqoPzNQOQOdZSKav08tMvp71PZ
         FUj2bYyDWUPxSD6HNv1UtibyROftRDkuIkxdXTchA9lV4qLjaIEW34VEGSUgeZ5sidUI
         Zy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Q2kjcsafX2irxATMiI1DLqTaVIbvyjUAd5/rxyhoaHA=;
        b=KePe4kR9E5j7Uftm1dOuXVNE75pZTTBDSXiN/eGvhTl7UajPfxXLEehB/HEtFzo1uP
         XhLX8XgUn76l3AkZvcXBINchdhrpJPHwnxIy1r/eEuFUMYU6lSFMkDYt2iQEE1L+UGjL
         LFc5ndXWcsxtg5EwWDQONSKlD0eGVz4m8seOoXQJHUtgPx2tGDTe4wkgROh/E/LuEDIZ
         0nda18SbEYNCSF4jLEYQaoOoooNsL4j0hz5KNJM4o1c5tfN1YLmTLugpehBd6R1ciuu6
         vNKV3l0wi715o1p0DV/SuXrOy4M4fWRbEs1w59W54u7RWQzbpnBscTOTBjaiVqE029qI
         w8Pw==
X-Gm-Message-State: APjAAAVmreBt016i2aopKTM4mCut5O9KqG/uxWXnDPYMNctlK+1D7/hX
        0Z2K5NpOzoOVGrg078mhcviVXg3DCxX2Ew==
X-Google-Smtp-Source: APXvYqw93JpjhRUq1ev2zstsXjBoEn4T/oIAcmK2nh6TM4ssIHRdiTZeGG3j4rxWlvcIt8cCyUuhyw==
X-Received: by 2002:a17:906:9418:: with SMTP id q24mr34471064ejx.28.1573056169983;
        Wed, 06 Nov 2019 08:02:49 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:1c1:e73c:e916:21a0? ([2001:1438:4010:2540:1c1:e73c:e916:21a0])
        by smtp.gmail.com with ESMTPSA id f25sm45936edr.48.2019.11.06.08.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 08:02:49 -0800 (PST)
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Song Liu <liu.song.a23@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>
Cc:     Nigel Croxon <ncroxon@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20191104200157.31656-1-ncroxon@redhat.com>
 <5DC0C34B.1040102@youngman.org.uk>
 <CAPhsuW5bkFEk+t06JQufyYbzr-ckUfpQtgctoe6jy4wxzesBhw@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <7f512319-d7e3-edd1-3540-44581918d3cf@cloud.ionos.com>
Date:   Wed, 6 Nov 2019 17:02:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5bkFEk+t06JQufyYbzr-ckUfpQtgctoe6jy4wxzesBhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/5/19 10:11 PM, Song Liu wrote:
> On Mon, Nov 4, 2019 at 4:33 PM Wols Lists <antlists@youngman.org.uk> wrote:
>> On 04/11/19 20:01, Nigel Croxon wrote:
>>> The MD driver for level-456 should prevent re-reading read errors.
>>>
>>> For redundant raid it makes no sense to retry the operation:
>>> When one of the disks in the array hits a read error, that will
>>> cause a stall for the reading process:
>>> - either the read succeeds (e.g. after 4 seconds the HDD error
>>> strategy could read the sector)
>>> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
>>> seconds (might be even longer)
>> Okay, I'm being completely naive here, but what is going on? Are you
>> saying that if we hit a read error, we just carry on, ignore it, and
>> calculate the missing block from parity?
>>
>> If so, what happens if we hit two errors on a raid-5, or 3 on a raid-6,
>> or whatever ... :-)
> Based on my understanding (no data on this), the drive will retry read
> internally before return error. Therefore, host level retry doesn't really
> help. But I could be wrong.

The read which bypasses the cache could retry too, should it be
changed as well?

Thanks,
Guoqing
