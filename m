Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B44209BBD
	for <lists+linux-raid@lfdr.de>; Thu, 25 Jun 2020 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390814AbgFYJNm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 25 Jun 2020 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgFYJNl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 25 Jun 2020 05:13:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9AC061573
        for <linux-raid@vger.kernel.org>; Thu, 25 Jun 2020 02:13:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a1so5170606ejg.12
        for <linux-raid@vger.kernel.org>; Thu, 25 Jun 2020 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Xk+ISe6rZxn7YfNzgtx9PgXW8sHoU7QknPuyDDYEQNA=;
        b=jWYrGNo0yJ1nXZHqoHA/WBiX/QsrPmXjhoKW1gpCbqrVw0DTx3raAxDtu5b+NOZ4r0
         I1Pz7xDZCDTyXAfv+4QlZ/9q89TMMbtpQItqrfw9phCevKdWFHF0jELnKQd6x+oxarZc
         kmZh9AenA/Of/D4aROyN7QoP/VktJI1kvrflhxJOHzYW+emaSn19O7Cw8WA+/Nyz5Gqk
         d6hrlD8PtUWpwJU38Ws8+M4JRSMimXWSD4rYFSib32vUpLXqqKNlhg2mBprhRb0FTxwM
         8kWY3cle3ArIBS3L7Mpq8Z2bINgHc/G9xlIkw6oXkztsvg3CpFXSQxElakDOFJX7W6JN
         looA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xk+ISe6rZxn7YfNzgtx9PgXW8sHoU7QknPuyDDYEQNA=;
        b=LAId3Cch5FxOEA8tj85BfB/C7fJdPiN8HtPdAHIgSqe8pwx8s+JMVflf+uweJ21yVX
         oMaG+uLkLtKQm+Fht4r9hRKrxC5RnvstS/VTpo6yDL8rzieSrMxZpuFdgwr3SMpYe3MT
         COz2NjA9ounRwP3Y56hzf+3F7VHuPE0Z8PXEYwisDCP/7TvC2aAj+LXjkpLeHyXWn5vC
         hJxCXoJCzyYeCoucE6xSpuVr086uOcEtyVHRoXRu1969sozZ6NHxgY/6Pn6Ego6JRu5m
         ParxHFj0KiD4XALb7zDWy6kBFP4wOJEsBCTVKOVtkzTlFGClEahRNKJJ1eiRiQ9Humc3
         6rlw==
X-Gm-Message-State: AOAM530wpRh4ITfsGDlnCZrQ8KKt5M5DCatoAtv2iFRteXweBMgE1DIu
        ztwy4xJnFMHBqF+w1YfPqz4aRg==
X-Google-Smtp-Source: ABdhPJzWdVpMqxmtWgPOOUIweiDUOloRUk/VOvX1HmzrbuvdcOw/ODB4Id5KGIIY2J5t2IwuKK/7Ug==
X-Received: by 2002:a17:906:148b:: with SMTP id x11mr30067979ejc.282.1593076420274;
        Thu, 25 Jun 2020 02:13:40 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:898:8772:ff54:afa? ([2001:1438:4010:2540:898:8772:ff54:afa])
        by smtp.gmail.com with ESMTPSA id r16sm2133038edi.2.2020.06.25.02.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 02:13:39 -0700 (PDT)
Subject: Re: [PATCH] mdraid: fix read/write bytes accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>, jeffm@suse.com,
        linux-raid@vger.kernel.org, song@kernel.org
Cc:     nfbrown@suse.com, colyli@suse.com
References: <20200605201953.11098-1-jeffm@suse.com>
 <ed552b4b-b19a-cc85-05f4-0a0dc0d6fac2@intel.com>
 <fb3b18e6-9dda-6633-e25e-a141718f630b@cloud.ionos.com>
 <ac89af6c-1610-61b5-d275-304e6e54947f@intel.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <236cffb5-ab4a-0559-6f37-321347895189@cloud.ionos.com>
Date:   Thu, 25 Jun 2020 11:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ac89af6c-1610-61b5-d275-304e6e54947f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 6/23/20 6:48 PM, Artur Paszkiewicz wrote:
> On 6/23/20 4:21 PM, Guoqing Jiang wrote:
>> Hi Artur,
>>
>> On 6/8/20 9:13 AM, Artur Paszkiewicz wrote:
>>> On 6/5/20 10:19 PM, jeffm@suse.com wrote:
>>>> The i/o accounting published in /proc/diskstats for mdraid is currently
>>>> broken.  md_make_request does the accounting for every bio passed but
>>>> when a bio needs to be split, all the split bios are also submitted
>>>> through md_make_request, resulting in multiple accounting.
>>> Hi Jeff,
>>>
>>> I sent a patch a few days ago which should fix this issue. Can you check
>>> it out?
>>>
>>> https://marc.info/?l=linux-raid&m=159102814820539
>> I need to account some extra statistics for bio such as latency and size,
>> so it is kind of relies on your patch, then I read the code again.
>>
>> And besides my previous comment. I think you don't need clone bio for all
>> personalities. For md-multipath, raid1 and raid10, you can track the start
>> time by add it to those structures (multipath_bh, r1bio and r10bio), then
>> one extra copy could be avoided.
>>
>> What do you think?
> You're right, cloning can be avoided for those personalities. I wanted
> to keep it clean and centralized in the generic md code. I think we
> should have a common completion callback and some common request
> structure for all md personalities, like struct md_io which I'm using in
> my patch.How about we add it to the existing stucts like r1bio etc. and
> use that for io accounting, and clone the bio with the struct otherwise?
> Or maybe remove the cloning from the personalities and instead make the
> bio cloned in md_make_request available to them? Does this make sense?

Centralization definitely has it's advantage, but given the difference
among personalities, not sure it is possible or make sense to clone bio
in common md layer.

For raid1/10, we at least need to care about barrier and read balance
before clone bio, and I would prefer to not change current mechanism
since it is really a big modification from my understanding.

Thanks,
Guoqing
