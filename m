Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9C223B8F
	for <lists+linux-raid@lfdr.de>; Fri, 17 Jul 2020 14:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGQMpy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Jul 2020 08:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQMpy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 17 Jul 2020 08:45:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AA6C061755
        for <linux-raid@vger.kernel.org>; Fri, 17 Jul 2020 05:45:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so10550831ejd.13
        for <linux-raid@vger.kernel.org>; Fri, 17 Jul 2020 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9xvPSMBem/pR7YMRXNCAZo01WGfYyqBh72zcLuQhLOE=;
        b=T2xCKPHzt11i0abBH1Myc7f+p2KaRN4b8q3zD+nXuArIq8pPXg2vUb/STQ8KyasGLn
         yflECKzF6rh1l5DuR8Dhn1NLGROJyln+XlV7oVDDBzwU8Rj677pAZbba65TPz4SAYhP5
         waq0MN7KnYkokAM1wIfmWrqQu6CwRW11MDRxtNU1BiUbCU7Etk5LIJQXWenAz88RMyAu
         3+QJLaTHVahAB/WoJOzxbb/HoJN0Y6K7i9D7Iztk8UOIDMm50uhoZkSrGnOZOQUnkyw6
         zvfKL7Wpcw3L0jOUNU1aUWeiAof0tbvxVVaqjIyg76wCMInD95zf6NSRrm9A8mYMHCSy
         f0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9xvPSMBem/pR7YMRXNCAZo01WGfYyqBh72zcLuQhLOE=;
        b=Im+/cSBpb8XQH+xtp7lBOgLPYhOaYpWsALQCPr7jkbmiJC/fq9wHwdivBMN3N70JgU
         apG5lYLo53Tjxfp8CPPqmI9d3wkmOvvGn+S6852txCeKqWUeDUOlrJiZxIdxQfrgaz2K
         nmWCNYR/Ia+y0wbTuAyeSEdcWr3gAWdR3ngKFH/9fROAfQY2e81BwroORZ6ZDgBcotHa
         Qe+qGFX116d7+ugR1f8jho6RfSX5QaDCnCIlgwwPa334n1zlADDdcDFf1agp2PUyPBrP
         ba15M0aR7A9oAdOjqqKfmZGIxDeArZQZRJjLwHBcFIRlx5PRRKRTdxZkW5ldVUyeLqZ2
         or5A==
X-Gm-Message-State: AOAM532JqJFsvUz8xMgBW3dGnVJcg/M0Sl/kDXij8Ul/S5Dl7mxL+vAe
        UPquncF7qDGH9TuPSnVlpGtwdLMvNbW3cg==
X-Google-Smtp-Source: ABdhPJwNXXPYG6k6Yjxts3HSKu3HSeL+tiaWMGCGX5fO8TePCqftZiaEVVWEwPmn783UY9oSeWBizQ==
X-Received: by 2002:a17:907:72c7:: with SMTP id du7mr7937900ejc.248.1594989950268;
        Fri, 17 Jul 2020 05:45:50 -0700 (PDT)
Received: from [192.168.178.33] (i5C747D06.versanet.de. [92.116.125.6])
        by smtp.gmail.com with ESMTPSA id s14sm8004658edq.36.2020.07.17.05.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 05:45:49 -0700 (PDT)
Subject: Re: [PATCH v4] md: improve io stats accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20200703091309.19955-1-artur.paszkiewicz@intel.com>
 <82ac5fe5-e61d-e031-6a64-60b6e1dd408d@cloud.ionos.com>
 <CAPhsuW4Xc19jJyxzOUcfoE+HrKH=bogC55=-dt04z6phn0Wu5Q@mail.gmail.com>
 <CAPhsuW6HjN0hZ8E998XBpg+WxP5uhZO0on-M-tQ45kpFO5XHqg@mail.gmail.com>
 <db93b8ae-25a1-5b50-7360-1f9c8e0661c3@intel.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <677e39d3-ec87-7e93-09c6-c40aabd303f1@cloud.ionos.com>
Date:   Fri, 17 Jul 2020 14:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <db93b8ae-25a1-5b50-7360-1f9c8e0661c3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/17/20 12:44 PM, Artur Paszkiewicz wrote:
> On 7/16/20 7:29 PM, Song Liu wrote:
>> I just noticed another issue with this work on raid456, as iostat
>> shows something
>> like:
>>
>> Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s
>> avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
>> nvme0n1        6306.50 18248.00  636.00 1280.00    45.11    76.19
>> 129.65     3.03    1.23    0.67    1.51   0.76 145.50
>> nvme1n1       11441.50 13234.00 1069.50  961.00    71.87    55.39
>> 128.35     3.32    1.30    0.90    1.75   0.72 146.50
>> nvme2n1        8280.50 16352.50  971.50 1231.00    65.53    68.65
>> 124.77     3.20    1.17    0.69    1.54   0.64 142.00
>> nvme3n1        6158.50 18199.50  567.00 1453.50    39.81    76.74
>> 118.13     3.50    1.40    0.88    1.60   0.73 146.50
>> md0               0.00     0.00 1436.00 1411.00    89.75    88.19
>> 128.00    22.98    8.07    0.16   16.12   0.52 147.00
>>
>> md0 here is a RAID-6 array with 4 devices. %util of > 100% is clearly
>> wrong here.
>> This only doesn't happen to RAID-0 or RAID-1 in my tests.
>>
>> Artur, could you please take a look at this?
> Hi Song,
>
> I think it's not caused by this patch, because %util of the member
> drives is affected as well. I reverted the patch and it's still
> happening:
>
> Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
> md0             20.00      2.50     0.00   0.00    0.00   128.00   21.00      2.62     0.00   0.00    0.00   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
> nvme0n1         13.00      1.62   279.00  95.55    0.77   128.00    4.00      0.50   372.00  98.94 1289.00   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    5.17 146.70
> nvme1n1         15.00      1.88   310.00  95.38    0.53   128.00   21.00      2.62   341.00  94.20 1180.29   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00   24.80 146.90
> nvme2n1         16.00      2.00   310.00  95.09    0.69   128.00   19.00      2.38   341.00  94.72  832.89   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00   15.84 146.80
> nvme3n1         18.00      2.25   403.00  95.72    0.72   128.00   16.00      2.00   248.00  93.94  765.69   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00   12.26 114.30
>
> I was only able to reproduce it on a VM, it doesn't occur on real
> hardware (for me). What was your test configuration?

Just FYI,  I suspect it could be related to the commit 2b8bd423614c595
("block/diskstats: more accurate approximation of io_ticks for slow disks").

Thanks,
Guoqing
