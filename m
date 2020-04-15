Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998F21AAB23
	for <lists+linux-raid@lfdr.de>; Wed, 15 Apr 2020 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392666AbgDOO5W (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Apr 2020 10:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392528AbgDOO5T (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Apr 2020 10:57:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836C8C061A0C
        for <linux-raid@vger.kernel.org>; Wed, 15 Apr 2020 07:57:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c7so5267005edl.2
        for <linux-raid@vger.kernel.org>; Wed, 15 Apr 2020 07:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3pWZxdrP+6cnPpWY9bG/HxNx2Z+lOuJxjicbDKkxwb0=;
        b=hM8Q2SrJiejdzZ2sKHL/+JKEmMM8zJ/97fqKDoB94DxCpS/PSaISS05LY0w6Xiow1K
         CX32/B1IkGZe5TVKVTzl4s0ipBjRsMp0luyZxIVyKpX5emaLMUesgSpZivLo/FMSxy8g
         K5mlqJmVg5zcG2iQUqCzYIpfy/sF5uDp6D6v22209ephrR2KqXeiMUEEovTCDz4HJubT
         EsACa2MmCE0/cBw1NiPn0rtrvoGnIFz9IKyLWlkk59TlREDtlR5TtbRmZiHS+Sym+m9D
         PVerYNyr4pMN/CsuWIsvOvSOzmisidQueocJfNg9i+H1DyJO1AebjKjAHaRk26CozMZx
         lAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3pWZxdrP+6cnPpWY9bG/HxNx2Z+lOuJxjicbDKkxwb0=;
        b=hXZ8uxTIqVa8rkqerbiG9cLqRjFFxwGx8yVjmYL0FCDa6ON6qG12oNlllq1uFJt+rU
         j3TUXP7ZDtEIMEz4SYVTAs/H3hLhJr/YR+Q2Qv4VPvVIOj+cTtWQwu4D+6downvqzVj6
         2tbLEgmlXAPQZDFchue+++hOOYOYFBUaIhAF5zllkudZ2C/j3bczb2iOU+34lM0zi1N5
         bSehSZIQ+ClYrtPbKvpW4/PdBqL5XvQU48ui3pckhKrNb+pBngC0gbLCqR9wlmoM4xvo
         WKdkhrfDO9Cscf+xV35qlFZCw6k2bhsWEx0EPWjAd3gyPqM6rZa202e+EY/CgPNTLX37
         UVRw==
X-Gm-Message-State: AGi0PuYRlS3AMs6bDnztt3zly2NiJ8LuJBoZ1DNeo5o9juIym7p+mdSG
        qzhVyT94Z88PZxWKYoENiOD+4g==
X-Google-Smtp-Source: APiQypJaF/s9R013K76NzVx9FXFhv0oohVrJ0Jbqcz3KidCtO+c7qpjjKN1UTdJNT0S1XhOXjSvoKQ==
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr9099417edu.40.1586962637195;
        Wed, 15 Apr 2020 07:57:17 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4886:3600:34d4:fc5b:d862:dbd2? ([2001:16b8:4886:3600:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id gg24sm488696ejb.66.2020.04.15.07.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 07:57:16 -0700 (PDT)
Subject: Re: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Coly Li <colyli@suse.de>, songliubraving@fb.com,
        linux-raid@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20200402081312.32709-1-colyli@suse.de>
 <fa7e30b9-7480-6c03-0f43-d561fed912fb@cloud.ionos.com>
 <5f27365b-768f-eb69-36ec-f4ed0c292c60@suse.de>
 <204e9fd0-3712-4864-2bf5-38913511e658@cloud.ionos.com>
 <20200415114814.GJ4629@dhcp22.suse.cz>
 <a1e83cb5-366c-17a7-3a4b-9cd8a54c3b48@cloud.ionos.com>
 <20200415142303.GN4629@dhcp22.suse.cz>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <b7584395-6230-36a6-9d78-dd1e1b630bbd@cloud.ionos.com>
Date:   Wed, 15 Apr 2020 16:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200415142303.GN4629@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 15.04.20 16:23, Michal Hocko wrote:
> On Wed 15-04-20 16:10:08, Guoqing Jiang wrote:
>> On 15.04.20 13:48, Michal Hocko wrote:
>>> On Thu 09-04-20 23:38:13, Guoqing Jiang wrote:
>>> [...]
>>>> Not know memalloc_noio_{save,restore} well, but I guess it is better
>>>> to use them to mark a small scope, just my two cents.
>>> This would go against the intentio of the api. It is really meant to
>>> define reclaim recursion problematic scope.
>> Well, in current proposal, the scope is just when
>> scribble_allo/kvmalloc_array is called.
>>
>> memalloc_noio_save
>> scribble_allo/kvmalloc_array
>> memalloc_noio_restore
>>
>> With the new proposal, the marked scope would be bigger than current one
>> since there
>> are lots of places call mddev_suspend/resume.
>>
>> mddev_suspend
>> memalloc_noio_save
>> ...
>> memalloc_noio_restore
>> mddev_resume
>>
>> IMHO, if the current proposal works then what is the advantage to increase
>> the scope.
> The advantage is twofold. It serves the documentation purpose because it
> is clear _what_ and _why_ is the actual allocation restricted context.
> In this case mddev_{suspend,resume} because XYZ and you do not have to
> care about __GFP_IO for _any_ allocation inside the scope.

Personally, I'd prefer fine grained protection scope, anyway just my own
flavor. And I think Song has his opinion about the proposal, I will respect
his decision.

Thanks,
Guoqing
