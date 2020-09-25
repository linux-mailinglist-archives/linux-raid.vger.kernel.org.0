Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E972789ED
	for <lists+linux-raid@lfdr.de>; Fri, 25 Sep 2020 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgIYNtx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 25 Sep 2020 09:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgIYNtw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 25 Sep 2020 09:49:52 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE0C0613CE
        for <linux-raid@vger.kernel.org>; Fri, 25 Sep 2020 06:49:52 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 34so2615472pgo.13
        for <linux-raid@vger.kernel.org>; Fri, 25 Sep 2020 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4clcgGPds3bmvgfh8eFvxDdVD8ehYyeTGx+JENl9kiw=;
        b=YxP0gaNlHO6KRVSEw8oKlAVm59V6nbT4lTEK16VlNnDJht617tjkz1RNP+gYQTg34c
         ihJ8PZFMJbCwxfaSk8ERjLs9/IikixOovuHGbmVrCc5WmmP4FoVkGCQsV+pO9c0oii4W
         vztObhyVrLphGOYGlAHo5aY49YSmtMaReyQWmvHkw9LHpz21oIMrPXW1FGlj+B/kgogz
         o7dA3gvlBcM7vNNxkJHitFx0hllxt1kGrFJTyHH/LBAN5bLg+r7NmfnYKq/wDYwx5gCy
         WOOopzeFHlFJbaDs8+rTQeZwGO4BzOsyINPAY0XJrtdDLmPrdNQ8R2NRz60WoNMZn/YR
         UqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4clcgGPds3bmvgfh8eFvxDdVD8ehYyeTGx+JENl9kiw=;
        b=Ewg+VEgwircuB2EJojUynGg+CKr+Rfjm5EOAMH1Z8jyaZ6a2rk7Tye+iXDJjqXxO2N
         f4hutnfH3pkeDoJ9C+PzIUj0BYVnDdGj05lgzQJ3tKdfGlc26Uf3RxxUGBZptH51n7Ad
         CIsyjBfFn3mNk11U6nk+q5LMPTCVuj6/Jo2Zd+gpgFTbhEWIFkm91PYFw+gMWILXoOzO
         IaDNlAV/J/YQRI/c+lSkW/rtGqD238/ttPObGiZpVPILPaPNGS+NeU6t8m0oC4SBpesa
         ImqqY5CWUsMXrsEkWMtSUutYNZMh8U9QGBg01vuE3htaqLepAxfSdTxJpqiSYVDMz9RL
         ajEg==
X-Gm-Message-State: AOAM53081TsCDnrplJ2f0Gde/HWbL84GnDdQ8NTqEfsEJrshTp3nvIqY
        hn1r8H2S2asXok559tRVlMvblA==
X-Google-Smtp-Source: ABdhPJy8l2eV6aZf2OGf2Wo0a4fCgWq3y2kOqQKZddHW6qyvTIwbNwPaCJq9k0/nbZ6NfP0uF9UBMQ==
X-Received: by 2002:a17:902:ed12:b029:d2:166:6411 with SMTP id b18-20020a170902ed12b02900d201666411mr4424457pld.59.1601041792471;
        Fri, 25 Sep 2020 06:49:52 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id gt11sm2128643pjb.48.2020.09.25.06.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 06:49:51 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20200924
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Xianting Tian <tian.xianting@h3c.com>, Xiao Ni <xni@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
References: <AB173AED-FC49-4098-BFF4-CF94438CFA94@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3772d42-2cb7-39bf-f380-2f10850c3af2@kernel.dk>
Date:   Fri, 25 Sep 2020 07:49:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <AB173AED-FC49-4098-BFF4-CF94438CFA94@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/24/20 5:54 PM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following changes on top of your for-5.10/drivers
> branch. 

Pulled, thanks.

In the future, can you please include a summary of changes in your pull
request?

-- 
Jens Axboe

