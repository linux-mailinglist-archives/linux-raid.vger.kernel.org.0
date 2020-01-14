Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0317B139E2A
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jan 2020 01:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgANA2S (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 19:28:18 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:39960 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgANA2R (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 13 Jan 2020 19:28:17 -0500
Received: by mail-pg1-f182.google.com with SMTP id k25so5517371pgt.7
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 16:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tQDUzDmt3jnJIukdVNCfWhIvKFVS5h302KklE9IZK+I=;
        b=C1phCWFldQ5O5dqjxHqlVa/j9lqlLai1G6NwVuGuq6gk9FRSAfyQGIBhrSnxE6Alo1
         GanxxyqzgKZn/auuBEiBdx02/7GPMdWoJcSrIWWp2WbOAMSV+hU8+WU6UN1S/qeo1ydt
         RpcWg0Bp0NRisnXLi/MRWRoLiUhnPoHAilFtJRW+J/od3WqreWrJAGSb+9BCS9QWgUTV
         iXVFnR0Nij+Vn+cZmrvk8kiV43yX3rm/H8gHRuPSSa0InsDfdtprmIQo7Lj+nYTBFW3O
         o313pJ07DZyZDV6UDuiD1Btnfut3LMHtwCTXHr1UjqYhJwkLvxU3Hsp8KlxYJrD0lhnq
         Xjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQDUzDmt3jnJIukdVNCfWhIvKFVS5h302KklE9IZK+I=;
        b=U3M52yvFXCjwUBgC/m9bab9iCaRY9O5e5WH0kjgUkjqQPyuhlTJ757JJhgGpBmMz6R
         DS6f/xrVM4DCud2PIVr909e8xvfTIHOrpSqEDFMt4yf2VhI+Zrn099RYsiqZTo/15BR8
         IiPMncyoGDDKn/X3W+zssy1d/aBGlFDd4rL6495blvT2ksLO7p8G4vJl6Ic2DgdMsNXV
         B9zwmqStV4ACERLr27nPBO66bXT/rQMntTnuPMgxCH2i5HA85b04QIs43NKQlXEMmCdG
         8cZ/Q5VjWLz420guMHsuQoUxkJEF7fNCV9bnanmba3a5n56oZNb05Q4/DDmElwsYyOa5
         9/Rg==
X-Gm-Message-State: APjAAAWnA4rFfe471mXVDy4AxDICK1za2KZ/Cvs8fXgm12liqR/9kyJg
        gJI3xvRx/qMCV8XGe/wnzXADTA==
X-Google-Smtp-Source: APXvYqzEEMDPOHSf4D+xOflh6QER6ECsMWgh7rLZejE3PkkXrn2bkxe5AkjN10ltzVLCl6DMrJJOWA==
X-Received: by 2002:a63:4c4f:: with SMTP id m15mr23652135pgl.346.1578961696536;
        Mon, 13 Jan 2020 16:28:16 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y197sm15715827pfc.79.2020.01.13.16.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 16:28:16 -0800 (PST)
Subject: Re: [GIT PULL] md-next 20200113
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "liuzhengyuan@kylinos.cn" <liuzhengyuan@kylinos.cn>,
        Kernel Team <Kernel-team@fb.com>
References: <153C0E51-CDFC-430C-8125-486CCC73406D@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c51a429c-dbe7-7631-361b-eae2d27bb876@kernel.dk>
Date:   Mon, 13 Jan 2020 17:28:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <153C0E51-CDFC-430C-8125-486CCC73406D@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/13/20 12:55 PM, Song Liu wrote:
> Hi Jens, 
> 
> Please consider pull the following changes for md-next on top of your for-5.6/block 
> branch (I didn't find for-5.6/drivers branch). 

No driver changes are queued up yet, the core is very slow as well.
It'll be a slow round! I forked off the driver branch with this pull,
thanks.

-- 
Jens Axboe

