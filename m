Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6654130FCD
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2020 10:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFJ43 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 04:56:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45454 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFJ43 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 04:56:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so46874988edw.12
        for <linux-raid@vger.kernel.org>; Mon, 06 Jan 2020 01:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IlJfFeQf3wvY03nwsAEWwM2veiihfvuJEnfIR3zXwgk=;
        b=fAA4ufzSlVzPGiCHIGy1eOB78ZScTdTYWIlLmmSGuziFUA7eC77mPoZ9G7BZGRQ2HS
         WmgHZlf2SMxrjpMsL+jv/Y5EusSYANE2ekW9u6/ka51n5Gp8BFBqx/KNkJsoJxTq+8Ff
         mk5ds10rVI4JoJ0IM0wmpbr4RWzED3+tvi9MpWVVePxcP+513oq4oA1pVEuDakel9YiN
         uvhZ7lNHta0eyvozy8yaI363tG3bd9mhO8CzGOpRrxgQvMEOr3EiW3n8FhE6VNyAj+Wv
         cWwxOek9X4TR/23gDY5k9QK/iV3jblRDyl+LBSxYaeN+5SwH10Td6WFO/t0EG0n3Nzi4
         SmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IlJfFeQf3wvY03nwsAEWwM2veiihfvuJEnfIR3zXwgk=;
        b=oO0cwS5GP8li6jLIF5i2MR4mpoK/LSwUGy0O9KPZmf5e0IrALM9bFQrfwg1j0lmMYA
         nTS1mdJSR9j+mDhIMt2efvU7R1ZfFh+wvGFEN3YcP6nVoCvQWJuLCo0C6yXw494W/IdZ
         6mmzKWNnuROZ+Ae4v5DnarYMWfQIALuefFU7AGBHd87v2tWNmcnrcTXwipTt0O2kJ2OY
         Uj34IZkRgWYSthN2UaTBUDlWd3fxXpwVHlpMPMfI84kZqWUKUIysubYNxzPIVzG2DPgR
         a1MVXOLnyrcNQKyzgYVH25ITTjBX/PjsZ/I/txmCC2bMPuID6YubhqRnJCyLOH22NtOC
         UzJg==
X-Gm-Message-State: APjAAAVeX1/y5lfTCxPBeJJzgeqmJ8u16u6qjkzOEphL5yTX2hcpb7FG
        9PP6UhWbU2W+B2XXXrx6m2JuALPeQIk=
X-Google-Smtp-Source: APXvYqzT3li7yu3/4hI7cLFQ3W6ijSiuIFvB0YeTD0S/6jzI7ghJZUVs8J/7nyO0uWFJEOCWtwPh/g==
X-Received: by 2002:a05:6402:3132:: with SMTP id dd18mr104004324edb.118.1578304586960;
        Mon, 06 Jan 2020 01:56:26 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:443c:bea1:ffb8:40f? ([2001:1438:4010:2540:443c:bea1:ffb8:40f])
        by smtp.gmail.com with ESMTPSA id a24sm6248729edr.84.2020.01.06.01.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 01:56:25 -0800 (PST)
Subject: Re: [PATCH V3 10/10] md/raid1: introduce wait_for_serialization
To:     Song Liu <liu.song.a23@gmail.com>, Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
 <20191223094902.12704-11-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW5WGdsvse_dPf1cG7Yj-TR6-+653ik1bJvjrNedtD-dPw@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <4eeb2d0b-de15-a8ac-3923-86e64e72663f@cloud.ionos.com>
Date:   Mon, 6 Jan 2020 10:56:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5WGdsvse_dPf1cG7Yj-TR6-+653ik1bJvjrNedtD-dPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 1/4/20 12:15 AM, Song Liu wrote:
> On Mon, Dec 23, 2019 at 1:49 AM <jgq516@gmail.com> wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> Previously, we call check_and_add_serial when serialization is
>> enabled for write IO, but it could allocate and free memory
>> back and forth.
>>
>> Now, let's just get an element from memory pool with the new
>> function, then insert node to rb tree if no collision happens.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   drivers/md/raid1.c | 41 ++++++++++++++++++++++-------------------
>>   1 file changed, 22 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 48d553d7989a..cd810e195086 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -56,32 +56,43 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
>>   INTERVAL_TREE_DEFINE(struct serial_info, node, sector_t, _subtree_last,
>>                       START, LAST, static inline, raid1_rb);
>>
>> -static int check_and_add_serial(struct md_rdev *rdev, sector_t lo, sector_t hi)
>> +static int check_and_add_serial(struct md_rdev *rdev, struct r1bio *r1_bio,
>> +                               struct serial_info *si, int idx)
>>   {
>> -       struct serial_info *si;
>>          unsigned long flags;
>>          int ret = 0;
>> -       struct mddev *mddev = rdev->mddev;
>> -       int idx = sector_to_idx(lo);
>> +       sector_t lo = r1_bio->sector;
>> +       sector_t hi = lo + r1_bio->sectors;
>>          struct serial_in_rdev *serial = &rdev->serial[idx];
>>
>> -       si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
>> -
>>          spin_lock_irqsave(&serial->serial_lock, flags);
>>          /* collision happened */
>>          if (raid1_rb_iter_first(&serial->serial_rb, lo, hi))
>>                  ret = -EBUSY;
>> -       if (!ret) {
>> +       else {
>>                  si->start = lo;
>>                  si->last = hi;
>>                  raid1_rb_insert(si, &serial->serial_rb);
>> -       } else
>> -               mempool_free(si, mddev->serial_info_pool);
>> +       }
>>          spin_unlock_irqrestore(&serial->serial_lock, flags);
>>
>>          return ret;
>>   }
>>
>> +static void wait_for_serialization(struct md_rdev *rdev, struct r1bio *r1_bio)
>> +{
>> +       struct mddev *mddev = rdev->mddev;
>> +       struct serial_info *si;
>> +       int idx = sector_to_idx(r1_bio->sector);
>> +       struct serial_in_rdev *serial = &rdev->serial[idx];
>> +
>> +       if (WARN_ON(!mddev->serial_info_pool))
>> +               return;
>> +       si = mempool_alloc(mddev->serial_info_pool, GFP_NOIO);
>> +       wait_event(serial->serial_io_wait,
>> +                  check_and_add_serial(rdev, r1_bio, si, idx) == 0);
> Are we leaking si when raid1_rb_iter_first() failed?

In that case, we just waiting for the disappear of collision, and si will be
used when no collision happen, remove_serial frees the memory finally.

Or do I misunderstanding your question?

Thanks,
Guoqing
