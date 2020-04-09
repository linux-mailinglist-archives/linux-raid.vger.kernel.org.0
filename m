Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E6A1A3C1E
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 23:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgDIVr6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 17:47:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40438 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDIVr6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 Apr 2020 17:47:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id w26so39326edu.7
        for <linux-raid@vger.kernel.org>; Thu, 09 Apr 2020 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nQ7X55Vorcg2juqYxw2daKTu1MPnuP9DhOHmiC6nk68=;
        b=MflPfauPBmW6H2XumIEQ4NkRnGwr9fu/JhcKqUSzhIIwIyKPhlC3J4hhk/l5Mnqx3b
         osPYgty3++Jcm01bvlIvuhouP6ci/ktzK4oTgfq7XaRWc99TTiG4Wjfjrz2rglNjLnDS
         StzHt6hNfnWze9WboMxXFVJka9IFm3hvU9wzw3XJYZADG389KhVOx/o1j+zB4a4+KqPP
         hdVn6zd0BauRlcNqOOryCvcSWE5s/bRIZf8K5YPTx+ObiR3ZqwJa626ec5cqe+F341bh
         2jcRUhZiquH/g/2GYU8nct2RbyGC7dNfAmxMHEIB8g5iUCi5DWyx7GfSTV6kgDPOMcl5
         2uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nQ7X55Vorcg2juqYxw2daKTu1MPnuP9DhOHmiC6nk68=;
        b=RoNr9MNz0eFgZ9O08vWpeLpB7G0cjuVgcBXwuh3fEXiEO0TsGQDLr4E3irjqbJeOru
         Y4TtFPH3yY5zg//3IKRRHIO4RHvB5cacsBIKWOdAaVK/ld+8ZOhG2KUplw6mVc2BZSPX
         XZqiYhqIwpZ8qV91LSe9zkWwOH4brOraMKzN/q5TSDvIykDSO0sgtCXzPdXwQG1LozuD
         qLze2n7DxXCHoXSxOG8iUmYSQnIv8KwlajNxsy3rz1xw1vVYvnliu23x4P8b8WGFFGX4
         f/ZCcN0nxB6B8vKH9Q1gFFDSms5C6X5t3rsWIHiG0JDxgl4HUW2lLlw8Ae/rWsOpKSqC
         gHuw==
X-Gm-Message-State: AGi0PubBXsDQf6g5kwFhvmVh66pJ203tLGxRFkAgQxVbSgbvn0icFide
        GU75368S29J1n+Mvf1G1LTH4jY2X+aU=
X-Google-Smtp-Source: APiQypKe+k/D3NoCor+lOUqqSz3dUf+zjWWqRATIW84YnDv5Tkrt8ex+ZsRPdz37Yb3fAt83hu0uQA==
X-Received: by 2002:a50:8d02:: with SMTP id s2mr2119008eds.81.1586468876574;
        Thu, 09 Apr 2020 14:47:56 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4805:100:34d4:fc5b:d862:dbd2? ([2001:16b8:4805:100:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id f12sm18451edw.42.2020.04.09.14.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 14:47:56 -0700 (PDT)
Subject: Re: [PATCH 0/4] md: fix lockdep warning
To:     Song Liu <song@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW4rWa_ZCX=3eW9Xk_jtZdu+uKX4HZtbfEJfS9ms4a+OSg@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <76835eb0-d3a7-c5ea-5245-4dcf21a40f7c@cloud.ionos.com>
Date:   Thu, 9 Apr 2020 23:47:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4rWa_ZCX=3eW9Xk_jtZdu+uKX4HZtbfEJfS9ms4a+OSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 09.04.20 09:25, Song Liu wrote:
> Thanks for the fix!
>
> On Sat, Apr 4, 2020 at 3:01 PM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>> Hi,
>>
>> After LOCKDEP is enabled, we can see some deadlock issues, this patchset
>> makes workqueue is flushed only necessary, and the last patch is a cleanup.
>>
>> Thanks,
>> Guoqing
>>
>> Guoqing Jiang (5):
>>    md: add checkings before flush md_misc_wq
>>    md: add new workqueue for delete rdev
>>    md: don't flush workqueue unconditionally in md_open
>>    md: flush md_rdev_misc_wq for HOT_ADD_DISK case
>>    md: remove the extra line for ->hot_add_disk
> I think we will need a new workqueue (2/5). But I am not sure about
> whether we should
> do 1/5 and 3/5. It feels like we are hiding errors from lock_dep. With
> some quick grep,
> I didn't find code pattern like
>
>         if (work_pending(XXX))
>                 flush_workqueue(XXX);

Maybe the way that md uses workqueue is quite different from other 
subsystems ...

Because, this is the safest way to address the issue. Otherwise I 
suppose we have to
rearrange the lock order or introduce new lock, either of them is tricky 
and could
cause regression.

Or maybe it is possible to  flush workqueue in md_check_recovery, but I 
would prefer
to make less change to avoid any potential risk.

Thanks,
Guoqing
