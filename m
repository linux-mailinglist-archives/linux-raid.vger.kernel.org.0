Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB7C4534
	for <lists+linux-raid@lfdr.de>; Wed,  2 Oct 2019 02:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfJBAzu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Oct 2019 20:55:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36592 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbfJBAzt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 1 Oct 2019 20:55:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so2401966pgk.3
        for <linux-raid@vger.kernel.org>; Tue, 01 Oct 2019 17:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DDsLE/BVSvW2ad3pzPsUne4j3kAv3DTYOSaOyiuU1vs=;
        b=RQNzOyfEw0J+eQ9dS8vs9E6pylLYp/Ngw7gRmrVGdNyY2VIjuZTok2HmqbBPbl9IN5
         MXPXS/P/CxMO5/k4p1IgI3QV+EWJ3qo9yjjLnndW0ebYkxINoWM0Utr4LR7TrCVhcrfe
         FacFXdH6Hs8c1Ev8EtUnt4TM7hpQNDSsV1IYsYvFJf2QhGmyNqw4F6rnrgqVXRSZGMmL
         gQMHDKPUdzHqyOkhT0XaR4S/wjTy+zCTpP4GR0peM1YFvfxF9K7Yk8cazGZS6nOpcvlb
         qd9ZJ4EVUjISgOyhvn2hzz+laPFuc33brFh1rTvOFzXZHokCByCvhO72cGcQiLo9kKDm
         tHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DDsLE/BVSvW2ad3pzPsUne4j3kAv3DTYOSaOyiuU1vs=;
        b=PZN5AY+QYeS2ROWD3w/d3mdoqHHa8CQo9qayG3l9LOGUCztFBhWuaprWg9k+on60Ym
         bSn6LmxFiagDwTjFCtMObcylG59TTGpoo/8x69x+3CD0BGhJTR2y82u7sE4YRF+RgT7w
         tuoBKnWXrG+KIZIHLdWvqNSv7MCn+YcfLT4F289kDVhXB0igPjqzsoF+9g1bpUhE6WUn
         VRI0o4KfgI2xDwZO/skr2tLUyVsLkROtS17mggGRamFQFMh1J89j4TT82+lWBjHnNirM
         IfpyZ9YAf0fCoRxxM+pUOAt+zbdH2i2qUQdBxq37+NFG5e8DREpuT9hIk1LUe54GUrrB
         0oHQ==
X-Gm-Message-State: APjAAAX5EmMmfdWnINaSa1KrmxBkarvR2paS50JLlWjqOX8NrPRV+bWw
        Ne1w+hXhho0s8Kp4TigJ1tPzlA==
X-Google-Smtp-Source: APXvYqw7rkTFtEmZJ7JOM2Ir9iOI1H5xXEco5/xFDhmBX+XL1WhzRIbgcmK6r3KXj4olzvZLIXPwzg==
X-Received: by 2002:a62:5c82:: with SMTP id q124mr1389925pfb.177.1569977747497;
        Tue, 01 Oct 2019 17:55:47 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e3sm3281565pjs.15.2019.10.01.17.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 17:55:46 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
To:     Song Liu <liu.song.a23@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <cover.1568994791.git.esyr@redhat.com>
 <CAPhsuW5CvJNRP5OO_M6XVd9q0x-CH9eADWR5oqdJP20eFScCFw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87d4b42f-7aa2-5372-27e4-a28e4c724f37@kernel.dk>
Date:   Tue, 1 Oct 2019 18:55:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5CvJNRP5OO_M6XVd9q0x-CH9eADWR5oqdJP20eFScCFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/1/19 5:12 PM, Song Liu wrote:
> On Fri, Sep 20, 2019 at 8:58 AM Eugene Syromiatnikov <esyr@redhat.com> wrote:
>>
>> Hello.
>>
>> This is a small fix of a typo (or, more specifically, some remnant of
>> the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
>> which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
>> with "H" is used in man page and everywhere else, it's probably worth
>> to make the name used in the fcntl.h UAPI header in line with it.
>> The two follow-up patches update usage sites of this constant in kernel
>> to use the new spelling.
>>
>> The old name is retained as it is part of UAPI now.
>>
>> Changes since v2[1]:
>>   * Updated RWF_WRITE_LIFE_NOT_SET constant usage
>>     in drivers/md/raid5-ppl.c:ppl_init_log().
>>
>> Changes since v1[2]:
>>   * Changed format of the commit ID in the commit message of the first patch.
>>   * Removed bogus Signed-off-by that snuck into the resend of the series.
> 
> Applied to md-next.

I think the core fs change should core in through a core tree, then
the md bits can go in at will after that.

-- 
Jens Axboe

