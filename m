Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E00AEF0E
	for <lists+linux-raid@lfdr.de>; Tue, 10 Sep 2019 18:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389459AbfIJQBL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Sep 2019 12:01:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50367 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388685AbfIJQBK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 10 Sep 2019 12:01:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id c10so178218wmc.0
        for <linux-raid@vger.kernel.org>; Tue, 10 Sep 2019 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yoqSCGJDimeAmGG1PhKE/2xuxpN/d8L2WCvnDSXDhDs=;
        b=GxwIGKIRsw2Aqm13Er4E+q5G/d9IU6j91Ao9GDXlI4fgmKsroX/I4y+Bnam60lEHgR
         dGN1gU4p4+mfvQerlLO8BmAS+buF5rAPRk5VuZSgWCeli/rqWkRTKYbTww/iIZA5j2x8
         KcSPOvm0qpyhxZaT9IQx9dIIIQsW/9Rb3gjq4bGB4+b1+JAAUD/Artudx26gtPENIygo
         sOGH8AnnBANNu9ScL/asLLzfZ7Yjlo1tt5MDwgWkpagFhIMBehWr3qcw5Z7qsuhksP3R
         sI6CVzgXcuNqGCVyvz30IXglWX10a+q80Dgioam7vGhReHpNjZTyTBR6yLvFwgGolHpT
         QGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yoqSCGJDimeAmGG1PhKE/2xuxpN/d8L2WCvnDSXDhDs=;
        b=WaOVY8AE3XMckGwOgkmiyIJA0d2j6gP+mCSDGetNAMQlFHzTQWLI53BECz84dE5ZUF
         oC5r87tUefYj5Q4lj6pZcIaEIykp+e6wsjwLYaJDbZs6+6izv1Vu3yIZGAms5+B4VcJX
         JTdojRju2dB7e6J/qYtJZG7BNg5nLAVXlYPWnoZ7Y0AnH7qccUAUMBmHj9XM3RL0OBlo
         ihDJgFmkvLAwm15+AWcCIu2gGW1WArBgsNvz8+RWD+l5PnfGfbj/4dtJbpDN0zUuJzR7
         Mn1GKfIrZoaUEYuPjKatasyBNxQCpJQCgifu0S+Z3f40u2gj6Z5q/j+OVsKt+8UiNL8k
         P6TQ==
X-Gm-Message-State: APjAAAWB5TN0gwp4fBBw5BLM1/6sLGQpjRwO3HosjG4l0izNKvXpIbN+
        4ySxzAuvT3yF6tb5ltkMYvzVPoiYDJA=
X-Google-Smtp-Source: APXvYqwYe+xlgI6JEEc5Jwqcn8WkI09s1ChqKn2ymRLLV3RJaA9tjI73pzqj0zmzrQwFB6Jlp403ww==
X-Received: by 2002:a05:600c:212:: with SMTP id 18mr166102wmi.168.1568131267613;
        Tue, 10 Sep 2019 09:01:07 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:70ef:99b1:3a5:1e44? ([2001:1438:4010:2540:70ef:99b1:3a5:1e44])
        by smtp.gmail.com with ESMTPSA id m17sm20283268wrs.9.2019.09.10.09.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 09:01:06 -0700 (PDT)
Subject: Re: [PATCH] md/raid0: avoid RAID0 data corruption due to layout
 confusion.
To:     Song Liu <songliubraving@fb.com>, NeilBrown <neilb@suse.de>,
        Guoqing Jiang <jgq516@gmail.com>
Cc:     Coly Li <colyli@suse.de>, NeilBrown <neilb@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de>
 <87blwghhq7.fsf@notabene.neil.brown.name>
 <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com>
 <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de>
 <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com>
 <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de>
 <87pnkaardl.fsf@notabene.neil.brown.name>
 <242E3FBD-C969-44E1-8DC7-BFE9E7CBE7FD@fb.com>
 <87ftl5avtx.fsf@notabene.neil.brown.name>
 <33AD3B45-E20D-4019-91FA-CA90B9B3C3A9@fb.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <58722139-ebc0-f49f-424a-c3b1aa455dd8@cloud.ionos.com>
Date:   Tue, 10 Sep 2019 18:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <33AD3B45-E20D-4019-91FA-CA90B9B3C3A9@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 9/10/19 5:45 PM, Song Liu wrote:
> 
> 
>> On Sep 10, 2019, at 12:33 AM, NeilBrown <neilb@suse.de> wrote:
>>
>> On Mon, Sep 09 2019, Song Liu wrote:
>>
>>> Hi Neil,
>>>
>>>> On Sep 9, 2019, at 7:57 AM, NeilBrown <neilb@suse.de> wrote:
>>>>
>>>>
>>>> If the drives in a RAID0 are not all the same size, the array is
>>>> divided into zones.
>>>> The first zone covers all drives, to the size of the smallest.
>>>> The second zone covers all drives larger than the smallest, up to
>>>> the size of the second smallest - etc.
>>>>
>>>> A change in Linux 3.14 unintentionally changed the layout for the
>>>> second and subsequent zones.  All the correct data is still stored, but
>>>> each chunk may be assigned to a different device than in pre-3.14 kernels.
>>>> This can lead to data corruption.
>>>>
>>>> It is not possible to determine what layout to use - it depends which
>>>> kernel the data was written by.
>>>> So we add a module parameter to allow the old (0) or new (1) layout to be
>>>> specified, and refused to assemble an affected array if that parameter is
>>>> not set.
>>>>
>>>> Fixes: 20d0189b1012 ("block: Introduce new bio_split()")
>>>> cc: stable@vger.kernel.org (3.14+)
>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>>
>>> Thanks for the patches. They look great. However, I am having problem
>>> apply them (not sure whether it is a problem on my side). Could you
>>> please push it somewhere so I can use cherry-pick instead?
>>
>> I rebased them on block/for-next, fixed the problems that Guoqing found,
>> and pushed them to
>>   https://github.com/neilbrown/linux md/raid0
>>
>> NeilBrown
> 
> Thanks Neil!

Thanks for the explanation about set the flag.

> 
> Guoqing, if this looks good, please reply with your Reviewed-by
> or Acked-by.

No more comments from my side, but I am not sure if it is better/possible to use one
sysfs node to control the behavior instead of module parameter, then we can support
different raid0 layout dynamically.

Anyway, Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Thanks,
Guoqing
