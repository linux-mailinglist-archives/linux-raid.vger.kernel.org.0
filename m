Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC022214E7
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 21:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGOTNq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGOTNJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Jul 2020 15:13:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DCFC061755
        for <linux-raid@vger.kernel.org>; Wed, 15 Jul 2020 12:13:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n22so389991ejy.3
        for <linux-raid@vger.kernel.org>; Wed, 15 Jul 2020 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8vvTO88e5N0KKnPYZQ+VIh9I/hNH1j0oOLC/5lUcoLI=;
        b=Je0Hw30gPfabICZKc5HlrWanaO9ppa1ddYhGikEMm12Otv1uQ5VQzjApg2+4b6ymCG
         0FmJ6yCFhKkyyqeKAGBLdr3fg12r/XFb4Gz1tGOFErF22MIEKsUJ/y+bFtNX8aUZ8Qk/
         lOr7lc2bW7j3H6aTguMOnL5eVy6j5pqxvLl2si93c3sgQYjQ0RpAnl+vEz8Q6gWzTUsE
         Jw2viVz73FUjMO4jxfB/AZiqJIz6FbLWhXtOcjGo2gHSYHmbh7e/DdknRELcSvMurU+w
         06nTF6JNXYk271eQBWQ+YwIy7T1lAR4IB+br7Jsav3FbFhrCC5O9fPO0R/7tf8uGWm5e
         /r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8vvTO88e5N0KKnPYZQ+VIh9I/hNH1j0oOLC/5lUcoLI=;
        b=hJB8zo8Ig9ZpSkzWMesDFuPDNUDhrPWtIajqnBDaOah/clcIk1fFNMqGgO5jzGjtHo
         egcJdcVkIm2sMzfweUqjH14Qs0qU/uFhvpljDonF2X3g5Y4EJu5kTxgXwS3yCbPXN5/W
         ePhZ4YgnEyQCjgKxPRmXnq3Fkj1ADfm1eri1/KnlV1KFBZqh1RGZWmyOnNLYITP7mMu2
         K5Aq+H1cNf+XrJ9Ub6mKZgvNNTfHo9B5nZpI3D8JheTna/wvX35BrsBtkBm1ynSpPTR/
         AB9un6WCcRgzcy2yqZ5UOrLbipF9kKJLp/oGQKObFCdZcxxVUmlP5pTx9wAHMzX1JMHT
         NzRg==
X-Gm-Message-State: AOAM531xQnO/3dbz4b+DrT+J1APPOrVl33OxoQgjMX85mX+5TvPi3FTw
        NshOpEm30U3UwQ41tTQ65qG4SyZKJ4a4hu3Y
X-Google-Smtp-Source: ABdhPJzaiIo2THLOMjEgeywAAbxcE3WL50CGmQgrGMn/6DCaXHzD1OKBjiPE3TMk4N1dbWflkSqNSQ==
X-Received: by 2002:a17:906:c459:: with SMTP id ck25mr427765ejb.177.1594840379162;
        Wed, 15 Jul 2020 12:12:59 -0700 (PDT)
Received: from [192.168.178.33] (i5C746824.versanet.de. [92.116.104.36])
        by smtp.gmail.com with ESMTPSA id s24sm2821111ejv.110.2020.07.15.12.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 12:12:58 -0700 (PDT)
Subject: Re: cluster-md mddev->in_sync & mddev->safemode_delay may have bug
To:     "heming.zhao@suse.com" <heming.zhao@suse.com>,
        linux-raid@vger.kernel.org
Cc:     neilb@suse.com
References: <a29f8374-cc64-cc87-71cb-507c43aff503@suse.com>
 <91c60c65-11c4-35e7-41d2-77a1febc3249@cloud.ionos.com>
 <57e70970-814b-3a55-35cc-b1415a301895@suse.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <c5b3d5c0-bfc5-37b7-b00e-f6f10b5edc3f@cloud.ionos.com>
Date:   Wed, 15 Jul 2020 21:12:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <57e70970-814b-3a55-35cc-b1415a301895@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/15/20 8:40 PM, heming.zhao@suse.com wrote:
> Hello Guoqing,
>
> Thank you for your kindly reply and review comments. I will resend 
> that patch later.
>
> Do you know who take care of cluster-md field in this mail list?
> I want he/she to shed a little light on me.

I think no one is dedicated to it, and Song covers all the md stuffs. I 
can comment it
once I am not busy.

Thanks,
Guoqing

