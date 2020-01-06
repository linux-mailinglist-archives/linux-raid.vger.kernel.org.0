Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08C131075
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2020 11:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAFKWz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 05:22:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44168 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgAFKWz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 05:22:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id bx28so46955432edb.11
        for <linux-raid@vger.kernel.org>; Mon, 06 Jan 2020 02:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mfbLGrjQzVQ33ny8rZZpDoMNEPPnmCnFddh7tIjKUVs=;
        b=BF8UT8M4vAzlUC52TNJ3Lp9ZbCVwOrJzyQ5uUUjrgME9FnismSXXR2UmKeGyrj8SD1
         ZyHtiDg5U+UmYASjIyN2g5x1EugG9ajUv5dNo8SSYwGNAi+iDXV4E4CDy+Um/EXT4FJQ
         Xln8mKpdpg0n6zKAONPs/WPbKUgbUb5MpfiwMnzW2bA9GgDHq/OhXk7eTZntw1cKaYui
         sFHQ7R64xxO+3Yd08+dkSChVi033P53J61KlZB4ATdW4pbQXilowqBZQXWwJFEF9aSfk
         1o/fkksPvmBDcnY+SnWRUK6Ai4yBgtZPkb24A0Ux1/KE+qlMyFRsfgSP7Z6RdxjYVT1i
         6zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mfbLGrjQzVQ33ny8rZZpDoMNEPPnmCnFddh7tIjKUVs=;
        b=aE+b+IzKBVQx/Rie6BXDPlQK92ExAARO3OMrzTLic9wpRK72VhB0ToBy++tjaWK6uA
         CUXK+zGK0wXsfBHvCSRZqhlX7o74wKDr6IdL3Eb7GAciGK8nJgmDnrfgavzKA67sqjds
         28EUIuTma5ljfroBNsiD3GShEgfyd8JIdl0eeFD7DyGBlIELzH5gJxUsaHR1/seamwtA
         Wet4Mikkl7KoV7o/9P1V/LDBrKclZFvy7YH5td1ubR+uBxCVEosSTbdi+IEx5PH602WV
         D/E6Kz/VCNMaWxKPC8RUxOk/bM4mFF8VOqB5UaNrNUCk4O13lFubiTB/T84w+Mb63yBR
         CSTw==
X-Gm-Message-State: APjAAAVp4orPXSD1ySuwJtOGlF9gt0eyZeKCCqKEf9EkEDQJYyyHQb1e
        KyKf4s6oZoiIg+XIOyVsGHOLn/YPF1k=
X-Google-Smtp-Source: APXvYqy4FSalkY2k5FpkhfKbtOeZ7iSoHTGvABtHB4VBlvoQJVrU6acy0S8qi39Aa9q68AlctdGbLg==
X-Received: by 2002:a17:906:d7b4:: with SMTP id pk20mr106847509ejb.71.1578306172424;
        Mon, 06 Jan 2020 02:22:52 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:443c:bea1:ffb8:40f? ([2001:1438:4010:2540:443c:bea1:ffb8:40f])
        by smtp.gmail.com with ESMTPSA id by2sm7950417ejb.45.2020.01.06.02.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 02:22:50 -0800 (PST)
Subject: Re: [PATCH V3 10/10] md/raid1: introduce wait_for_serialization
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     Song Liu <liu.song.a23@gmail.com>, Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
 <20191223094902.12704-11-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW5WGdsvse_dPf1cG7Yj-TR6-+653ik1bJvjrNedtD-dPw@mail.gmail.com>
 <4eeb2d0b-de15-a8ac-3923-86e64e72663f@cloud.ionos.com>
Message-ID: <ef975b75-eb3c-c36e-2a1f-4b3bad920219@cloud.ionos.com>
Date:   Mon, 6 Jan 2020 11:22:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4eeb2d0b-de15-a8ac-3923-86e64e72663f@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 1/6/20 10:56 AM, Guoqing Jiang wrote:
>
>
> On 1/4/20 12:15 AM, Song Liu wrote:
>> On Mon, Dec 23, 2019 at 1:49 AM <jgq516@gmail.com> wrote:
>>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>>
>>> Previously, we call check_and_add_serial when serialization is
>>> enabled for write IO, but it could allocate and free memory
>>> back and forth.
>>>
>>> Now, let's just get an element from memory pool with the new
>>> function, then insert node to rb tree if no collision happens.
>>>
>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>> ---
>>>   drivers/md/raid1.c | 41 ++++++++++++++++++++++-------------------
>>>   1 file changed, 22 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>> index 48d553d7989a..cd810e195086 100644
>>> --- a/drivers/md/raid1.c
>>> +++ b/drivers/md/raid1.c
>>> @@ -56,32 +56,43 @@ static void lower_barrier(struct r1conf *conf, 
>>> sector_t sector_nr);
>>>   INTERVAL_TREE_DEFINE(struct serial_info, node, sector_t, 
>>> _subtree_last,
>>>                       START, LAST, static inline, raid1_rb);
>>>
>>> -static int check_and_add_serial(struct md_rdev *rdev, sector_t lo, 
>>> sector_t hi)
>>> +static int check_and_add_serial(struct md_rdev *rdev, struct r1bio 
>>> *r1_bio,
>>> +                               struct serial_info *si, int idx)
>>>   {
>>> -       struct serial_info *si;
>>>          unsigned long flags;
>>>          int ret = 0;
>>> -       struct mddev *mddev = rdev->mddev;
>>> -       int idx = sector_to_idx(lo);
>>> +       sector_t lo = r1_bio->sector;
>>> +       sector_t hi = lo + r1_bio->sectors;
>>>          struct serial_in_rdev *serial = &rdev->serial[idx];
>>>
>>> -       si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
>>> -
>>>          spin_lock_irqsave(&serial->serial_lock, flags);
>>>          /* collision happened */
>>>          if (raid1_rb_iter_first(&serial->serial_rb, lo, hi))
>>>                  ret = -EBUSY;
>>> -       if (!ret) {
>>> +       else {
>>>                  si->start = lo;
>>>                  si->last = hi;
>>>                  raid1_rb_insert(si, &serial->serial_rb);
>>> -       } else
>>> -               mempool_free(si, mddev->serial_info_pool);
>>> +       }
>>>          spin_unlock_irqrestore(&serial->serial_lock, flags);
>>>
>>>          return ret;
>>>   }
>>>
>>> +static void wait_for_serialization(struct md_rdev *rdev, struct 
>>> r1bio *r1_bio)
>>> +{
>>> +       struct mddev *mddev = rdev->mddev;
>>> +       struct serial_info *si;
>>> +       int idx = sector_to_idx(r1_bio->sector);
>>> +       struct serial_in_rdev *serial = &rdev->serial[idx];
>>> +
>>> +       if (WARN_ON(!mddev->serial_info_pool))
>>> +               return;
>>> +       si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
>>> +       wait_event(serial->serial_io_wait,
>>> +                  check_and_add_serial(rdev, r1_bio, si, idx) == 0);
>> Are we leaking si when raid1_rb_iter_first() failed?
>

Now, 'si' is only allocated once before wait_event, if check_and_add_serial
returns -EBUSY, then

> In that case, we just waiting for the disappear of collision, and si 
> will be
> used when no collision happen, remove_serial frees the memory finally.
>
> Or do I misunderstanding your question?

Thanks,
Guoqing
