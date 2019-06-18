Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127594987F
	for <lists+linux-raid@lfdr.de>; Tue, 18 Jun 2019 06:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfFRE6s (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 00:58:48 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:58030 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFRE6r (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Tue, 18 Jun 2019 00:58:47 -0400
Received: from linux-fcij.suse (prva10-snat226-1.provo.novell.com [137.65.226.35])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Mon, 17 Jun 2019 22:58:37 -0600
Subject: Re: [PATCH 1/5] md/raid1: fix potential data inconsistency issue with
 write behind device
To:     Song Liu <liu.song.a23@gmail.com>, Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190614091039.32461-1-gqjiang@suse.com>
 <20190614091039.32461-2-gqjiang@suse.com>
 <CAPhsuW6eYaqxmHzHeu8UzXXx+DH-2FkEtQcWfvHp-YKTVe2U6Q@mail.gmail.com>
 <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com>
 <CAPhsuW4YqH46jiSH9OEzUMf3rBCoJPa_=+ekVEi5s==sx=SWRQ@mail.gmail.com>
From:   Guoqing Jiang <gqjiang@suse.com>
Message-ID: <545a6f2a-7dab-e6b6-649a-6e6e67f10e0e@suse.com>
Date:   Tue, 18 Jun 2019 12:58:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4YqH46jiSH9OEzUMf3rBCoJPa_=+ekVEi5s==sx=SWRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 6/18/19 12:41 PM, Song Liu wrote:
> On Mon, Jun 17, 2019 at 8:41 PM Guoqing Jiang <gqjiang@suse.com> wrote:
> <snip>
>
>>>> +};
>>> Have we measured the performance overhead of this?
>>> The linear search for every IO worries me.
>>   From array's view, I think the performance will not be impacted,
>> because write IO is complete
>> after it reached all the non-writemostly devices.
>>
> Hmm... How about the cpu utilization rate? Have you got chance
> to do some simple benchmarking?
>

I can't see the impact of cpu in simple test, because it really depends on
how slow the writemostly device is.

And the modern multi-queue device (also flagged as writemostly) would
be fast enough to handle the write-behind IO in time, which means there
should only a few (or zero) elements in wb_list, but it is a potential issue
which need to be addressed.

Thanks,
Guoqing
