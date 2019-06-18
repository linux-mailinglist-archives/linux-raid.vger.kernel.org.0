Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B941549D3E
	for <lists+linux-raid@lfdr.de>; Tue, 18 Jun 2019 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfFRJai (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 05:30:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55856 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFRJah (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 18 Jun 2019 05:30:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so2400162wmj.5
        for <linux-raid@vger.kernel.org>; Tue, 18 Jun 2019 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oldum-net.20150623.gappssmtp.com; s=20150623;
        h=from:reply-to:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dWRDBkKspVu167uCjC9ypvfgPBdPUiIiR5TDZx+BS90=;
        b=0AD3vjRZoP5ey5OwHIA2yi80MkXha2YJTbid9lcf5+mfbXN+oxS5WAPzs1IgmVSxNH
         VWbzMg5Aoz/R5q+tvDaK/aRAHoWlMtZnbk8f8WwMkVf1ni6eFz40AU/xKhG3hhAkXvR+
         T4b/1vfA2rJmA/l53enwP8ihROyvnly5Qnm9rBJ4wJrPmSLyH2ObVY/4olRawzKpW05W
         gtx+2qiOispRPBFxOctKXNH8aP0kjykY6Qh1gmySkz8XP4VUv/MVSWRhICJG9yWsYUuu
         bytDB5H6IiRkao3x/HR2r9FMqzUHgk4auCrr3YUPM7wYqNmFe8QgYd9BxvPgApkZ9s1c
         a5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:subject:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=dWRDBkKspVu167uCjC9ypvfgPBdPUiIiR5TDZx+BS90=;
        b=Fa3ocynn1705rGlqVCt1862PYNpiAeh0vVXCeTmY8VmIylLs8m8sbTD86InchUObdw
         Fq44YKqrsB3/l9f8uDushtddwgJlidHYLkUvTrb5yweFd+QykzFLbL78EdvbiA1SrIgU
         IHqxWmDe9Hbe1kGBd7MDCKXDNys9SoiJM/M/rcvtpGdhJk2ZcjHDKi9LFGQOF81VwNpR
         d6RcXf6i1FARhDdJ+QxzJfrSleUHcw8ancb2+MLV5UJvEaxsK9j0yeMZW5BFCHXIhCI+
         RmnGsgJGSjplkQY+xYsCfvUxrcYEL3X5doXYS6rXJ99fel7agNhojhjhY720EV9IXqsr
         iBGg==
X-Gm-Message-State: APjAAAXy007ndRd9foDfdlqLyaALYXrgQB8Qsq7eExMuU+o8REVts1GE
        LHE+ulOBK+tcXNj41UrpW+YfjOabFmpOww==
X-Google-Smtp-Source: APXvYqy0eK4KOft45lNnMAXi5Hl/YeOyQziKW/geq+WsgZCAREFIcD1wxr+0JX/J2iHZEws93rj2Ow==
X-Received: by 2002:a1c:c003:: with SMTP id q3mr2639414wmf.42.1560850235025;
        Tue, 18 Jun 2019 02:30:35 -0700 (PDT)
Received: from [10.98.7.83] ([149.235.255.3])
        by smtp.googlemail.com with ESMTPSA id v65sm1974335wme.31.2019.06.18.02.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 02:30:34 -0700 (PDT)
From:   Nikolay Kichukov <hijacker@oldum.net>
X-Google-Original-From: Nikolay Kichukov <nikolay@oldum.net>
Reply-To: nikolay@oldum.net
Subject: Re: [PATCH 1/5] md/raid1: fix potential data inconsistency issue with
 write behind device
To:     Guoqing Jiang <gqjiang@suse.com>, Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190614091039.32461-1-gqjiang@suse.com>
 <20190614091039.32461-2-gqjiang@suse.com>
 <CAPhsuW6eYaqxmHzHeu8UzXXx+DH-2FkEtQcWfvHp-YKTVe2U6Q@mail.gmail.com>
 <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com>
 <CAPhsuW4YqH46jiSH9OEzUMf3rBCoJPa_=+ekVEi5s==sx=SWRQ@mail.gmail.com>
 <545a6f2a-7dab-e6b6-649a-6e6e67f10e0e@suse.com>
Message-ID: <dcc1af10-6e45-464a-bb6d-e4f5e446788a@oldum.net>
Date:   Tue, 18 Jun 2019 11:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <545a6f2a-7dab-e6b6-649a-6e6e67f10e0e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

Is there a proper patch formatted variant of this where I can download
and test? Or is it included in a released kernel already?

I am seeing an issue, where one of the write-mostly disks in a 3 disk
raid1 array consisting of one ssd and 2 spinning disks(write-mostly) is
causing the mismatch_cnt to go as high as 1,5 million and a repair does
not fix it. So this looks like a good potential resolver.

Thanks,
-Nik

On 6/18/19 6:58 AM, Guoqing Jiang wrote:
>
>
> On 6/18/19 12:41 PM, Song Liu wrote:
>> On Mon, Jun 17, 2019 at 8:41 PM Guoqing Jiang <gqjiang@suse.com> wrote:
>> <snip>
>>
>>>>> +};
>>>> Have we measured the performance overhead of this?
>>>> The linear search for every IO worries me.
>>>   From array's view, I think the performance will not be impacted,
>>> because write IO is complete
>>> after it reached all the non-writemostly devices.
>>>
>> Hmm... How about the cpu utilization rate? Have you got chance
>> to do some simple benchmarking?
>>
>
> I can't see the impact of cpu in simple test, because it really
> depends on
> how slow the writemostly device is.
>
> And the modern multi-queue device (also flagged as writemostly) would
> be fast enough to handle the write-behind IO in time, which means there
> should only a few (or zero) elements in wb_list, but it is a potential
> issue
> which need to be addressed.
>
> Thanks,
> Guoqing
