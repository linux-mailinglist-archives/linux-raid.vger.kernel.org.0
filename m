Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2F213673
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jul 2020 10:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGCIdw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jul 2020 04:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCIdv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jul 2020 04:33:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B4C08C5C1
        for <linux-raid@vger.kernel.org>; Fri,  3 Jul 2020 01:33:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lx13so14676595ejb.4
        for <linux-raid@vger.kernel.org>; Fri, 03 Jul 2020 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lEyKEqEgVK1OnOU8D9GSLqQuoQYo9UQzQ41iAGwnL7Q=;
        b=YfdmSaWawTw4IqEhI+LQnduGp9yoQFDcasrZn+TLFfg9+xv6i1f3UjhpCVJA66eMYC
         25oY5CSKQs4ZjQ9A7wF6YjH3s0wzZbndXTtO5AMkefqXXAVokJNgt0UqRrA11ZT9++/1
         KkdE0zlErOFYYCZ/0KgDryP7AWCZd05obe5vAkIqcoMpqSugB1vjxLNg9mpsPT5ot4xN
         ldOTJwPTPn6aqsvc+/1guH1hUyv0qVgyOFr/Hi9WekWmf3LscN0JSScYANbXuGmar1kJ
         iFCSubsYQwg5ZRXqnHrltY1RXypLdrhxfUCsOvQehCVEpWIPRqAdNbloZUec8E4TDEps
         VWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lEyKEqEgVK1OnOU8D9GSLqQuoQYo9UQzQ41iAGwnL7Q=;
        b=RAHtV86z7tLv03vd6eEK0VGo+zJsl7DBbDfjC141SGOmSuUWjIAf8kPyzR80rpkK/g
         EhQTe+Wrg9km9OfPLqw9zuBQ6iQqGt1l2w9EzWFgUhZqrt5GE7NvMLvXpfq0NYlbfU+v
         HzQc6S6k5x01rs5XPV1Ebhb5KlcBMcawBJgh7Nt4v0m/kTFkxmpBPvblIZjTBaKJNXi2
         xF9QMffrBSafEZAuo4JfORkngLtU3n4Q8H9wT7SQEN+RM8A+6Fgx9GilkOy6o2A5LEDM
         Ww/7D4kib43cO8eIVokEpidwYCIIjB1rYpMMJ/Sa4eZ5xEcos18R6QKdxhQTWSHJPFgz
         4o7A==
X-Gm-Message-State: AOAM530pQWNHq3WJR0jc6fjIYbUJc8kWEYU1UGyUAI8bga6556sEHBwS
        bcZhOCiKK4raGxOAs8emAuZOloANW82rNxMB
X-Google-Smtp-Source: ABdhPJzPpxgRF9j5PrLx5a47e307oVk1bias+8vEzkzqWvYTKH52dq9fr74MRu9XuGyW7TVeIHL5+A==
X-Received: by 2002:a17:906:7115:: with SMTP id x21mr30667586ejj.86.1593765230151;
        Fri, 03 Jul 2020 01:33:50 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:60ce:5ee7:9c1b:dbd8? ([2001:1438:4010:2540:60ce:5ee7:9c1b:dbd8])
        by smtp.gmail.com with ESMTPSA id kt1sm8732062ejb.78.2020.07.03.01.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 01:33:49 -0700 (PDT)
Subject: Re: [PATCH v3] md: improve io stats accounting
To:     Song Liu <song@kernel.org>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20200702142926.4419-1-artur.paszkiewicz@intel.com>
 <CAPhsuW5eMPMH1HcMXi67Ci0rbWhVyiuLodVZB_oaGbrR7abTJQ@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <aea49756-c6f6-a4a3-3e23-9928e0878c80@cloud.ionos.com>
Date:   Fri, 3 Jul 2020 10:33:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5eMPMH1HcMXi67Ci0rbWhVyiuLodVZB_oaGbrR7abTJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/2/20 11:25 PM, Song Liu wrote:
> On Thu, Jul 2, 2020 at 7:29 AM Artur Paszkiewicz
> <artur.paszkiewicz@intel.com> wrote:
>> Use generic io accounting functions to manage io stats. There was an
>> attempt to do this earlier in commit 18c0b223cf99 ("md: use generic io
>> stats accounting functions to simplify io stat accounting"), but it did
>> not include a call to generic_end_io_acct() and caused issues with
>> tracking in-flight IOs, so it was later removed in commit 74672d069b29
>> ("md: fix md io stats accounting broken").
>>
>> This patch attempts to fix this by using both bio_start_io_acct() and
>> bio_end_io_acct(). To make it possible, a struct md_io is allocated for
>> every new md bio, which includes the io start_time. A new mempool is
>> introduced for this purpose. We override bio->bi_end_io with our own
>> callback and call bio_start_io_acct() before passing the bio to
>> md_handle_request(). When it completes, we call bio_end_io_acct() and
>> the original bi_end_io callback.
>>
>> This adds correct statistics about in-flight IOs and IO processing time,
>> interpreted e.g. in iostat as await, svctm, aqu-sz and %util.
>>
>> It also fixes a situation where too many IOs where reported if a bio was
>> re-submitted to the mddev, because io accounting is now performed only
>> on newly arriving bios.
>>
>> Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> Thanks Artur and Guoqing!
>
> I run quick test with this. Seems it only adds proper statistics to
> raid5 array, but
> not to raid0 array. Is this expected?

Because bio_endio is not called, and it is same for linear and faulty.
I think we have to  clone bio for them ..., then it is better to do the
job in the personality layer.

1. For md-multipath, raid1 and raid10, track start time by change the
multipath_bh, r1bio and r10bio.

2. For raid5, override the bi_end_io like this.

3. Then other personalities have to clone bio ...

Thanks,
Guoqing
