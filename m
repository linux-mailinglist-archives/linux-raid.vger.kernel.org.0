Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4941E7D13
	for <lists+linux-raid@lfdr.de>; Fri, 29 May 2020 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgE2MWe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 May 2020 08:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2MWd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 29 May 2020 08:22:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457BEC03E969
        for <linux-raid@vger.kernel.org>; Fri, 29 May 2020 05:22:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h21so1885657ejq.5
        for <linux-raid@vger.kernel.org>; Fri, 29 May 2020 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GLxqAc7vCn4t/TxtOd+MjiaaOvXZmgYPhLhBPUnCebY=;
        b=cZv8/vk+dUMDeTXIsxh8SAUK7epx7jz9h38NgMkUkhC/senCQpPAytOdKQ0SW7srow
         xQd5anTMHzIq3IYbB3ybdVBQs+WTRZivVD0j0C6UWfDLHCDo5LXUVAQNZpOy1s/AL4Du
         BcxzlL16Bxse/4WWg/KDEgo2uLLJbDdYdspLujwv623BSVaDr7odRRvQ2+uNXHk2tP+P
         d2APw2QlIzCZXk0RoJaD/Q6V6VgjS07HqbhkPFbXSuTB9cwpVMQffM5VcDnQ3Wf5zDJn
         m9+lcEKQID/p0l6W3BfM+YBGm5hccVdD8wG3Al4YEYV0FPVJPItlU7noYXHzGIoRX2lE
         vUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GLxqAc7vCn4t/TxtOd+MjiaaOvXZmgYPhLhBPUnCebY=;
        b=V4/anIOpHuBZ3r+HqG/R22IhJmhvqhtAI52gOJGULg2o/VIrizSJhszTbCjlY/Pc5o
         s0gIknwYq0FcdzjWULLwdCqa6g8gNYxEs2Anc8qlK5wbSpUmSXM2yIEAYRFPuGVGaqcw
         Ccb6e7YpDcBotoXZLyTHfIkO+yhaAqoz8EWuqEr+HBWwQQBsWdTStkZThiUJDJ3u38+Q
         u+bSrKngZSqVWdfQhQW+Eec9St97fHGdEa1hLonB8l7SiuX8b0RQC2YiXN0WzXieMDNf
         zwssklZTgAkBtcg0rAkH66LZXjKy1mWhL2XW6MO609bhTcurjtEynzNLg/QnYUwMZ6Vi
         2jEA==
X-Gm-Message-State: AOAM533yX7b6/F/GY5U5X7aHaBsBPyJO2RqLd+IxSDkqPPPONwGee63Q
        h8Got711OBgzFHh1NDKJW7Jo4A==
X-Google-Smtp-Source: ABdhPJxTi2T/uKr52SSeIn8ZD7Um/p9H3cnUsKaJi9AsgQGFc0u53gCjHEvvUKkHMtQcD7RFVhIo7w==
X-Received: by 2002:a17:906:a48:: with SMTP id x8mr1812112ejf.89.1590754951958;
        Fri, 29 May 2020 05:22:31 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4826:7300:a436:5e5d:3e25:d8b3? ([2001:16b8:4826:7300:a436:5e5d:3e25:d8b3])
        by smtp.gmail.com with ESMTPSA id v6sm7367118ejv.120.2020.05.29.05.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 05:22:31 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] md/raid5: set STRIPE_SIZE as a configurable
 value
To:     Yufen Yu <yuyufen@huawei.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, neilb@suse.com, colyli@suse.de,
        xni@redhat.com, houtao1@huawei.com
References: <20200527131933.34400-1-yuyufen@huawei.com>
 <f0ab9a2d-696b-b21f-faec-370cd7c3ed3a@cloud.ionos.com>
 <e373279d-9cc0-3a47-e6dd-887de0162d63@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <71f662d7-9aee-a130-c41d-67a691514ef6@cloud.ionos.com>
Date:   Fri, 29 May 2020 14:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e373279d-9cc0-3a47-e6dd-887de0162d63@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/29/20 1:49 PM, Yufen Yu wrote:
>> The 4k rand write performance drops from 100MB/S to 15MB/S?! How 
>> about other
>> io sizes? Say 16k, 64K and 256K etc, it would be more convincing if 
>> 64KB stripe
>> has better performance than 4KB stripe overall.
>>
>
> Maybe I have not explain clearly. Here, the fio test result shows that 
> 4KB
> STRIPE_SIZE is not always have better performance. If applications 
> request
> IO size mostly are bigger than 4KB, likely 1MB in test, set 
> STRIPE_SIZE with
> a bigger value can get better performance.
>
> So, we try to provide a configurable STRIPE_SIZE, rather than fix 
> STRIPE_SIZE as 4096. 

Which means if you set stripe size to 64KB then you should guarantee the 
io size should
always bigger then 1MB, right? Given that, I don't think it makes lots 
of sense.

Anyway, just my $0.02.

Thanks,
Guoqing
