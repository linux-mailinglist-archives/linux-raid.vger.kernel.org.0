Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FD3205454
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbgFWOVx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 10:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbgFWOVx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Jun 2020 10:21:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA3DC061573
        for <linux-raid@vger.kernel.org>; Tue, 23 Jun 2020 07:21:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so5439499ejb.2
        for <linux-raid@vger.kernel.org>; Tue, 23 Jun 2020 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=M9FcvvFbDMPUWGlRM9wrueShxUr3KlukMapi2NAPKUY=;
        b=bnJpwG8CiPaBClxnmD2teyW1pcfjZzncNFOHcXMEV87b6QySpXPBj0nhaJuDdk1DMi
         Hu25lF9SHOsqnyUZLVO+kgAtTLAQGs3iB9IayFGfHVZqiArR4XmtNloNyYMZumtbcBFv
         f4atudjcrEEhhf7bpwR1iHAQg9oVeNibhDEhnpn5s+maH02HvhBS1m4gvGGSYXEIOZy7
         0VdlZP5wbZh96ndSX2la3Jr0h20WGgGotbt5d7EZOJKAaJKqDM7izNEuNm4LVzvfUDkr
         /a9pMF2/RPIw/Evf7Au89dZn2leQzIJVBRYvFU2Iffu9bYSgus8laEHcfrXFQhUO88rr
         nXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M9FcvvFbDMPUWGlRM9wrueShxUr3KlukMapi2NAPKUY=;
        b=NbRvspOOMgmghhBNA9F1Dh2aSAQHvkIHRSSxqtvb+CoKXpqsfxehnVgvHX5kygja5e
         RmHMoMbjYXLkujS3Jykt0zsiXC0RYyKpdDJlBoUnagsGqFyECnbU8xDYf/4FENEMVA4n
         nx/Kw2yYWrDONHCRLTrzAjOQEIfsY4XjOdgL3NmtZO0rIApCaqAxq6LV5Eo1L0KGcxcf
         wYRhIX83i7heWm1Gcd9Xn9hRXc8GEYC2Nv/buYeVC1jXhbBRBFoXBGdphimcQbGZ4xSC
         FiQQqoFCegeAA9uDvKyTmL1/VbeEmbHa2Qr3UpBvmAYuQvKrjAc4+f7u62NWEtZA9u4E
         +76Q==
X-Gm-Message-State: AOAM530l42t+JjT0C73lHWrDHlt5T5lpVsr9TZKOae+zxfK1e5OGsn4w
        1YArszOPzW64ajU/ucOf10tPBTYZZHxzGg==
X-Google-Smtp-Source: ABdhPJzDC/IPFHe2pojBpKvqyzBboWj9gHnLrFUlGHKjKhr7Gk7mXZNry9Fsze5tUa8BqDRHbn3p3g==
X-Received: by 2002:a17:907:1110:: with SMTP id qu16mr21064898ejb.539.1592922110573;
        Tue, 23 Jun 2020 07:21:50 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:d4a1:df27:206c:676d? ([2001:1438:4010:2540:d4a1:df27:206c:676d])
        by smtp.gmail.com with ESMTPSA id a7sm14810630edx.3.2020.06.23.07.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 07:21:50 -0700 (PDT)
Subject: Re: [PATCH] mdraid: fix read/write bytes accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>, jeffm@suse.com,
        linux-raid@vger.kernel.org, song@kernel.org
Cc:     nfbrown@suse.com, colyli@suse.com
References: <20200605201953.11098-1-jeffm@suse.com>
 <ed552b4b-b19a-cc85-05f4-0a0dc0d6fac2@intel.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <fb3b18e6-9dda-6633-e25e-a141718f630b@cloud.ionos.com>
Date:   Tue, 23 Jun 2020 16:21:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ed552b4b-b19a-cc85-05f4-0a0dc0d6fac2@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Artur,

On 6/8/20 9:13 AM, Artur Paszkiewicz wrote:
> On 6/5/20 10:19 PM, jeffm@suse.com wrote:
>> The i/o accounting published in /proc/diskstats for mdraid is currently
>> broken.  md_make_request does the accounting for every bio passed but
>> when a bio needs to be split, all the split bios are also submitted
>> through md_make_request, resulting in multiple accounting.
> Hi Jeff,
>
> I sent a patch a few days ago which should fix this issue. Can you check
> it out?
>
> https://marc.info/?l=linux-raid&m=159102814820539

I need to account some extra statistics for bio such as latency and size,
so it is kind of relies on your patch, then I read the code again.

And besides my previous comment. I think you don't need clone bio for all
personalities. For md-multipath, raid1 and raid10, you can track the start
time by add it to those structures (multipath_bh, r1bio and r10bio), then
one extra copy could be avoided.

What do you think?

Thanks,
Guoqing
