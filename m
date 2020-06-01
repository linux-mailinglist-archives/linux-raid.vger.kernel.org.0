Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129B51EA57B
	for <lists+linux-raid@lfdr.de>; Mon,  1 Jun 2020 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgFAOCZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 1 Jun 2020 10:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAOCY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 1 Jun 2020 10:02:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29441C05BD43
        for <linux-raid@vger.kernel.org>; Mon,  1 Jun 2020 07:02:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x1so9290273ejd.8
        for <linux-raid@vger.kernel.org>; Mon, 01 Jun 2020 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FuZRtCC3DOfhNngu3YhaZ5qP7ZM6sCMMmOtj/YVS6fo=;
        b=BZ0+uiEH7RcxjcASfcVci/FfafN+qNmuRxCWCLfsTbkWk268HGSC0/RxL20qsShoIV
         K8Mn+bJHkHXwruUjujwoUJnY6vkKzNp+ue75FMiyxKHKwLzup3VfiIESgHT2X0zc83XD
         gKB6TU6wj8KT8BDtjbQAZh6jtahfpqWvT8DgRShh7aNGUC7wCxM46c7MAtuahge4KW/a
         YG1o8dNRY1lIWnp6Mp/mPGgmZIdVDj0XnazDweXeoHAv6LrE/znDonq5CnQXlqis9ibZ
         M1Dzk7khhP8NCxeU0vOXFe7nzc8a3Vg6bFf5yePLWyCVI2KL0rKVPY7ZB6lYfJvGbcNB
         p3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FuZRtCC3DOfhNngu3YhaZ5qP7ZM6sCMMmOtj/YVS6fo=;
        b=SETx4cqwsKK9LIWiLqJnYpcMcctqsAhS3H+tvQbt9A0Ojg9Ulr4zPXN4/f1P78CMmR
         gzd22Cm6LiNz/hBl2+4nFpzJp/ii15fCygZI0tJmEM8dicrdOGmSqFyzEhrZrkx6kppO
         09KEOCaSlvL/VhSLqF2e0kmIL8XQ76CFkw9tAe9pbiVzlU9EnMKhtCgOrK0bsK3wLBRo
         BW74rd9HM6lH1K46pdcOKRwULfBUT2Ivo2Sx0Y6Ap9Lb6BJQNu/Mvwuy2H4paHm3JgkL
         dhJjhs7ghKnTT4/YXUACcpZA0TcyxvO17j/fygnWjHPC+a9uzJ/3Zzalg5vlWnfzaMBH
         pU3g==
X-Gm-Message-State: AOAM531Qxj/5Txjbb9Tvoq0JMT7Ik2D4ll+0IyEYfIPKbLPXpT+ucG0m
        ZsUeWNMQLNCG7B+eezrws/EmHg==
X-Google-Smtp-Source: ABdhPJwRRMlkwmTgOJLAR5gH6c5eZQp2H2Y8XecV7qv4ND6Z2SQ6ypKh6rXn03ALbODLUyeqI9XICA==
X-Received: by 2002:a17:907:9f0:: with SMTP id ce16mr19083964ejc.476.1591020141821;
        Mon, 01 Jun 2020 07:02:21 -0700 (PDT)
Received: from ?IPv6:2001:16b8:486c:9200:f967:9014:5748:3cac? ([2001:16b8:486c:9200:f967:9014:5748:3cac])
        by smtp.gmail.com with ESMTPSA id m30sm15135575eda.16.2020.06.01.07.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 07:02:21 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] md/raid5: set STRIPE_SIZE as a configurable
 value
To:     Yufen Yu <yuyufen@huawei.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, neilb@suse.com, colyli@suse.de,
        xni@redhat.com, houtao1@huawei.com
References: <20200527131933.34400-1-yuyufen@huawei.com>
 <f0ab9a2d-696b-b21f-faec-370cd7c3ed3a@cloud.ionos.com>
 <e373279d-9cc0-3a47-e6dd-887de0162d63@huawei.com>
 <71f662d7-9aee-a130-c41d-67a691514ef6@cloud.ionos.com>
 <555121b6-fe76-4827-7b8f-7a22ba04ed82@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <9acfb512-88ee-b4b0-88d4-94841e72d31a@cloud.ionos.com>
Date:   Mon, 1 Jun 2020 16:02:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <555121b6-fe76-4827-7b8f-7a22ba04ed82@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/30/20 4:15 AM, Yufen Yu wrote:
>
>
> On 2020/5/29 20:22, Guoqing Jiang wrote:
>> On 5/29/20 1:49 PM, Yufen Yu wrote:
>>>> The 4k rand write performance drops from 100MB/S to 15MB/S?! How 
>>>> about other
>>>> io sizes? Say 16k, 64K and 256K etc, it would be more convincing if 
>>>> 64KB stripe
>>>> has better performance than 4KB stripe overall.
>>>>
>>>
>>> Maybe I have not explain clearly. Here, the fio test result shows 
>>> that 4KB
>>> STRIPE_SIZE is not always have better performance. If applications 
>>> request
>>> IO size mostly are bigger than 4KB, likely 1MB in test, set 
>>> STRIPE_SIZE with
>>> a bigger value can get better performance.
>>>
>>> So, we try to provide a configurable STRIPE_SIZE, rather than fix 
>>> STRIPE_SIZE as 4096. 
>>
>> Which means if you set stripe size to 64KB then you should guarantee 
>> the io size should
>> always bigger then 1MB, right? Given that, I don't think it makes 
>> lots of sense.
>>
>
> No, I think you misunderstood. This patchset just want to optimize 
> RAID5 performance
> for systems whose PAGE_SIZE is bigger than 4KB, likely 64KB on ARM64. 
> Without this
> patchset, STRIPE_SIZE is equal to 64KB, means each IO size issued to 
> array disk at
> least 64KB each time, Right? But filesystems usually issue bio in the 
> unit of 4KB,
> means sometimes required 4KB but read or write 64KB on disk actually. 
> That would
> waste resources.

Yes,, it is hard for me to understand your way is better than just make 
stripe size equals to
4KB.

>
> After this patchset, we set STRIPE_SIZE as default 4KB. For systems 
> like X86, which
> just support 4KB PAGE_SIZE, it will not have any effect. But for 64KB 
> arm64 system,
> it **normally** can get better performance on filesystems base on 
> raid5, like dbench test.
>
> fio test just want to say that, we can also configure STRIPE_SIZE with 
> a bigger value
> than default 4KB on 64KB ARM64 system when applications mostly issue 
> big IO. It can
> get better performance for reducing IO split in RAID5.

I do think the flexibility is not enough, if someone set stripe size to 
64KB by any chance,
people could complain the performance of raid5 really sucks if the io is 
not big. And it is
not realistic to let people rebuild the module in case the io size is 
changed, so it would be
more helpful if the stripe size can be changed dynamically without 
recompile code.

Thanks,
Guoqing
