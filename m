Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3E1D20C6
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 23:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEMVRl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 17:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgEMVRl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 13 May 2020 17:17:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D84C061A0C
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 14:17:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f4so291392pgi.10
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oFblN7s4CBe5t3cptQfQUl+Gm5EJuzUzhsAu0lcOvXQ=;
        b=XBOGmYiFT9jg3PUR8HJymbrTxiWWWGhUS3ZXSs4Mdpl2zWJbv3dGMcOrUQ5GRRJaeZ
         T/9quU8LJnrrrFmgKJvvJAAL88y0++Y1LkwVGC2gH7Jsa/lpgIIDtpRkupZ22PrDalfk
         GKfxrsA6p9yqIvZv+614NyNPpqIVp+/HPtELMaWhg3EjTTYOqnjcgwqlKh2Y01YXITgO
         YbY4/Oin8nDCVkH0qV8OKvQmZiMJgOwC9ZKmJZv/xcogDmh7Rr1XEgn8EGiRxQKVOnP4
         B055a3JxrzhJVvWWEpteNVMrN/Smnl4V1lD8Yxa9ACcqX0O5sYL39wlsTaqxIHR/fbkt
         aAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oFblN7s4CBe5t3cptQfQUl+Gm5EJuzUzhsAu0lcOvXQ=;
        b=s5oCOvGHqGc2kr+utpY7VWszu8mpdiLP4et9pzrZHrEdWOkSgJ3wfLIX6AC54sV2xI
         FG5Fv8YGv0Ih52v64uPEDpNeYIzf5Tj5KgtgDEWIGGAo6W6gsyL1AeFEWW3kiwExSOgt
         xAv5y1h4APzxxCwbvqaYSUmdCijWrSTsOUeCH3IelSiIqq+3jGTbGBkyY4/urIDzNBd3
         fqFsTEdBku9v8UCmCtiyBaHW+lyLQhGj5O7VXBLN79nUoVK5YVM04SrWZMPgfzV2Fd3U
         R2/fnOLsaoCZ8AxysO/ISe9en7tDwCntdCoTGsm8zWdb1hrysxlzr6g1pe8vi4CW0LU5
         xO+Q==
X-Gm-Message-State: AOAM533N7GGTPm6pi6uQlCjcwpUHxeu/jVyuvDzHbyWtJRPXNijK0H4Y
        aIIUNWppX991XX3JvP3fUuJwMA==
X-Google-Smtp-Source: ABdhPJxb+9cA+AdYtfc+5UT7/+HbHSpvVFjbdvwgxYXoPJPnwy19Peleoupvboe4QXJ1x6hjBnv9Kg==
X-Received: by 2002:aa7:8c53:: with SMTP id e19mr1157250pfd.264.1589404659277;
        Wed, 13 May 2020 14:17:39 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::1150? ([2620:10d:c090:400::5:adac])
        by smtp.gmail.com with ESMTPSA id 6sm410919pfj.123.2020.05.13.14.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 14:17:38 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20200513
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Coly Li <colyli@suse.de>, Christoph Hellwig <hch@infradead.org>,
        David Jeffery <djeffery@redhat.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>
References: <196CD868-7B35-4174-AFAF-9786943E4B0C@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f147a193-8eb4-e1a6-6cd6-12284845876a@kernel.dk>
Date:   Wed, 13 May 2020 15:17:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <196CD868-7B35-4174-AFAF-9786943E4B0C@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/13/20 2:42 PM, Song Liu wrote:
> Hi Jens, 
> 
> Please consider pulling the following changes for md-next on top of your
> for-5.8/drivers branch. 

Pulled, thanks.

-- 
Jens Axboe

