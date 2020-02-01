Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253DD14F670
	for <lists+linux-raid@lfdr.de>; Sat,  1 Feb 2020 05:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgBAEmC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 31 Jan 2020 23:42:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42564 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgBAEmC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 31 Jan 2020 23:42:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id e8so1002629plt.9
        for <linux-raid@vger.kernel.org>; Fri, 31 Jan 2020 20:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ODQlr1dO1D7jlhYdFlp0/9g77csm7naKHYHWRpHQs1Q=;
        b=gtikg4R4uX3TDVv8V4AdECOxqMbOqqPTrp6YHMj20W82Byv3bz6wlyiLwyWAyPJe37
         N/NYDiGuEmHDD10sxBekvA6WqV4iZ6CNG6RWAKCMGKpU3Y+m44FQLOokXXDGalZ6F+k/
         JqzkWOkJ8Uiv4LVDRLaM75mQrEZHDJ9uUNGkw31+605J3OG43ePzfBT3FSv1K/NNOUZ6
         +VMpQ0tFMIUT+8sE7VtaLjscjxJ4CMGJoRYsALUv9Ig5QDUuklh8jkRtDZyVEWaC72da
         1ncIf1aKHMa7/9dSGaNWDMu67mSiFXdg3/Mk9Kk8iJ5bm7czJ5YtgZ1KcJUDpgXS/F5l
         VorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ODQlr1dO1D7jlhYdFlp0/9g77csm7naKHYHWRpHQs1Q=;
        b=UFeVW+vvf1PpT2SXhzTq4F9IrHA8HULn6gWxWU45v0SgHZXiD3HKJ7besHrUTAbDsG
         Q/RW1BEk9iG9c9v7JkaKdgGKGDN+nejQlT0NuSWUu/BDv20+25vXB2IhBp3CURCtc/H+
         pqfbH98tSQCG1R0GGm9p4Ijmj8q0KYP1GtYk9tMZLZiKnuYdccqvoFni9I54Elw/1JOl
         CwkK0aj9XSAYMA29GvRMZC3r2S/ZJ0FPSRgdeEMtFpAR4Um94ezLOXw4atmtDrZcJE/5
         cke2RexnvfMqGfu4I2WaWxLUPXAziCLQKMJs+Bwnzd4m57+x4qUbu2HPtaabdp2BVrbM
         P1Lw==
X-Gm-Message-State: APjAAAXDgg5rAxLet/nI/GDtXVv1Iwkf/yrotTotlyLImOrSoMKeKqkc
        hb3kxCy3rCacMcX5IWiygQGbGQ==
X-Google-Smtp-Source: APXvYqyLgW1ePhBE2NOBpHAIwI7T29hqFj8fs68ZM74cVKQIk3IJnAiOKtItpqiEdnn1q5odFFDQrg==
X-Received: by 2002:a17:902:bb8d:: with SMTP id m13mr13391534pls.157.1580532121585;
        Fri, 31 Jan 2020 20:42:01 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id e2sm11746672pfh.84.2020.01.31.20.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 20:42:00 -0800 (PST)
Subject: Re: [PATCH 1/2] block: introduce polling on bio level
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
References: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
 <20200126044138.5066-2-andrzej.jakowski@linux.intel.com>
 <de27b35e-a713-dc9d-5164-0397c0dff285@kernel.dk>
 <20200131063527.GC6267@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ffb832a5-e946-2575-d820-8c8831e2ed99@kernel.dk>
Date:   Fri, 31 Jan 2020 21:41:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131063527.GC6267@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/30/20 11:35 PM, Christoph Hellwig wrote:
> On Wed, Jan 29, 2020 at 09:01:49PM -0700, Jens Axboe wrote:
>> blk_poll() used to be a pointer in the queue, but since we just had
>> one implementation, we got rid of it. Might make sense to
>> reintroduce that, and just make it an optimized indirect call. I
>> think that would be prettier than add the bio hack in the middle of
>> it, and you're having to add a queue pointer anyway.
> 
> Well, the other reason is to avoid an indirect call for the blk-mq
> case, which are fairly expensive.  In fact I'm pretty sure we avoid
> indirect calls from the bio layer into blk-mq entirely for the fast
> path at the moment, and it would be great to keep it that way.

Sure, my suggestion was to provide it as an alternative - if set,
then call that. Though with the optimized indirect calls, at least
it's just a branch, actual call is the same.

This patch sets a bit in no mans land right now. It's duplicating
the main loop, and it's shoved in the middle of the function. This
has to get cleaned up.

-- 
Jens Axboe

