Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8A11AA97C
	for <lists+linux-raid@lfdr.de>; Wed, 15 Apr 2020 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634073AbgDOOKQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Apr 2020 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732615AbgDOOKM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Apr 2020 10:10:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F390C061A0C
        for <linux-raid@vger.kernel.org>; Wed, 15 Apr 2020 07:10:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a25so28649wrd.0
        for <linux-raid@vger.kernel.org>; Wed, 15 Apr 2020 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IwvLbPWAJpTjTSUTRtLtj3dLZEqGEN2iqWU025JoQ3M=;
        b=UNrIUPrAoVxEljqDI8cGk759NLLDMdkRS0Iae6EiLUtSopLr3YNelRxs5nGMwvUZlY
         bNejilb2pr/m11ejYS4XCbY2HrbaU88kkbGvk5tPrsdp3B4eV3G7lsecgaIfLuMEgoDY
         Zkk8BprhvPxTbEGqV/3qhCNz+1aHSZ/n4sZiMiWc6fyKgI5QotoCvNGf/VcVohwkd90Y
         CLnlr8D7h9d86H1twHcWVnABOtMuNkehrgPs/V/cWUk55IirETbdBSyx30OdfEizPd3p
         cE+4cjp7cQRegv/T6H1MU6UL6apUuaPunIqZQJmi9obPlGKt+U3ySpYpMdYmHCon84V0
         X2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IwvLbPWAJpTjTSUTRtLtj3dLZEqGEN2iqWU025JoQ3M=;
        b=s5yLWmBTCcentc7OIV7CJkHIqBY2BMI0/Lq27Rb8F+0o7XRYigRa3A59j/2J2KtbtE
         THDNkPClu1qoGU1ZQScOw4q4AhH2z8In3ozLGFwkHoMboO2OmLRK6DVkAKCPdTie34CT
         yNRNDBKUmK08w+xXWjO+GS5/OLl0XW6eHIIzphAzgjGrITTu/BwhqH2gqaOLBBhfM8wl
         AL9a0HSrWeE4eSLLNniCQYLf7XXtwEf1fkwuk6VtR1k3MEoZR6BM/pYSdGqeIAtBEzfi
         sy05FRJ9+CHbxoSGKuyVvKDJVt3iAEn8hByORcleq3czmXZMJRcUehAq4jW4h8jM03yv
         Jchw==
X-Gm-Message-State: AGi0PubrfdPV9HISFOvKxe5Vpar6MCaOaQ847WfXY0OOHH9600J3vDPM
        SWU7MrPvcGB5iurzJ2OEX7yiSA==
X-Google-Smtp-Source: APiQypLDp9j1wds3rIRlSTB+6DKlE8YztsML/dQH9z9X7VGDuPrGJV6reCJEDq+Rw6Hlo2sD1Qu2jw==
X-Received: by 2002:a5d:4b43:: with SMTP id w3mr1315458wrs.208.1586959810069;
        Wed, 15 Apr 2020 07:10:10 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4886:3600:34d4:fc5b:d862:dbd2? ([2001:16b8:4886:3600:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id k3sm14047694wru.90.2020.04.15.07.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 07:10:09 -0700 (PDT)
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
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <a1e83cb5-366c-17a7-3a4b-9cd8a54c3b48@cloud.ionos.com>
Date:   Wed, 15 Apr 2020 16:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200415114814.GJ4629@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 15.04.20 13:48, Michal Hocko wrote:
> On Thu 09-04-20 23:38:13, Guoqing Jiang wrote:
> [...]
>> Not know memalloc_noio_{save,restore} well, but I guess it is better
>> to use them to mark a small scope, just my two cents.
> This would go against the intentio of the api. It is really meant to
> define reclaim recursion problematic scope.

Well, in current proposal, the scope is just when 
scribble_allo/kvmalloc_array is called.

memalloc_noio_save
scribble_allo/kvmalloc_array
memalloc_noio_restore

With the new proposal, the marked scope would be bigger than current one 
since there
are lots of places call mddev_suspend/resume.

mddev_suspend
memalloc_noio_save
...
memalloc_noio_restore
mddev_resume

IMHO, if the current proposal works then what is the advantage to 
increase the scope.
If all the callers of mddev_suspend/resume could suffer from the 
deadlock issue due to
recursing fs io, then it is definitely need to use the new proposal.

> If there is a clear entry point where any further allocation recursing to FS/IO could deadlock
> then it should be used at that level.

Agree.

At the end of mddev_suspend, I guess there is no FS/IO could happen to 
the array,
because mddev->suspended++ and quiesce(mddev, 1) are called previously in
mddev_suspend. And it makes me curious to go through to the call chain:

layout_store / chunk_size_store / update_raid_disks / update_array_info 
/ md_check_recovery
         => pers->check_reshape => raid{5,6}_check_reshape => check_reshape
         => resize_chunks => scribble_alloc(..., GFP_NOIO)

Perhaps I missed something, but seems all the 5 original callers are not 
called between
mddev_suspend and mddev_resume, if so, then with the new proposal, 
scribble_alloc()
could not be protected by the memalloc_noio_{save,restore}.

> This might be a lock which is
> taken from the reclaim or like this case a device is suspended and no IO
> is processed so anything that would wait for an IO or rely on IO making
> progress in the reclaim path would deadlock.

Thanks for teaching.

> Please have a look at Documentation/core-api/gfp_mask-from-fs-io.rst
> and let me know is something could be made more clear or explicit.
> I am more than happy to improve the documentation.

Thanks again for your lighting, will read it.

Regards,
Guoqing
