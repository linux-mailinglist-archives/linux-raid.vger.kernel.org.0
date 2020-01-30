Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF514D574
	for <lists+linux-raid@lfdr.de>; Thu, 30 Jan 2020 05:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgA3EBy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 Jan 2020 23:01:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41311 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgA3EBx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 29 Jan 2020 23:01:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so773872pfw.8
        for <linux-raid@vger.kernel.org>; Wed, 29 Jan 2020 20:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0l4DJgLIXCRFuUpZPD/nKDAWnBZ6DMkiOzCjCg1IyjQ=;
        b=nOV1KCwvZk8F8XYCa/VmcUCXfHHQXvNM2Eup4z+qNijEjBmCuH+O6eH2CzRyZlutym
         9blVkqZPAXjDOyM725E6EP3GaiUmFOIr3mNRc3V8lNzanZG1gD9p4/cZdKgmS2qpQzwf
         kmvA2KU6G/Q+VVPhgFrGsbZXJw63PKricNKPbI4RpbY6gIch0gv6NYi2a1heaJzdSZj9
         zSLMpqYnZqyb0+XZuDs1gMDU49JyeDyvPX00pdrj/N00tGDHc/w7wolkfYRR9c8CYqxO
         qc7fWFHSeQgS7GWnnLqte/TabZiE8UKYk/Qbv960jbGNdBYrXPPt9C7mmdDfdeHCtjGH
         RnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0l4DJgLIXCRFuUpZPD/nKDAWnBZ6DMkiOzCjCg1IyjQ=;
        b=HtNB5vmhcxMnoWMFCPgB6l6pnRFQ2a5i3n0ltQCHwJKk6P65TX4qpfTROO+3rbXCPc
         Lny1W3t8u/YrKfp1hOikprB1R4TtAPukD3arAc2KATBDpz/lvGHDjz+YJvh84nkZvlxh
         rZR1eTDihkcvodd0lnPRJBAwIZQQiJxGjYSrahjF2XKgJvmqvGP8gnWNHIcl+A9/8xpY
         SwdMHLDEQ8C3WwaIJ26Hwd0FrLhd2pXEFE85AIF8YwBy9fUMtSCcfKb2h+vW93CcCd5v
         K6iPq7VQ/25/xOZSGWfqy4XNcN6h0g/O7kuqck2hov13fLyvWpBttgC8aqVKsoutCNAl
         Jogw==
X-Gm-Message-State: APjAAAU98NiRO51NnCbF/eXXpVpa/WBb5pj+alqlLg1b8o6iW9KHq70N
        Cz/NTBFb4FuDWBes6DWuVjND7R0FlT0=
X-Google-Smtp-Source: APXvYqznUOBPd9Nnnlg3RZXWzXpIt0bdEmhovGPOGqm5DvjPSzJHYLU/2/WcgLsL4qTBw+gCr5wjRg==
X-Received: by 2002:aa7:93a4:: with SMTP id x4mr3034307pff.42.1580356911747;
        Wed, 29 Jan 2020 20:01:51 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id a185sm4328733pge.15.2020.01.29.20.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 20:01:51 -0800 (PST)
Subject: Re: [PATCH 1/2] block: introduce polling on bio level
To:     Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        song@kernel.org
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
References: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
 <20200126044138.5066-2-andrzej.jakowski@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de27b35e-a713-dc9d-5164-0397c0dff285@kernel.dk>
Date:   Wed, 29 Jan 2020 21:01:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200126044138.5066-2-andrzej.jakowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/25/20 9:41 PM, Andrzej Jakowski wrote:
> In current implementation it is possible to perform IO polling if
> underlying device is block-mq device. Is is not possible however to do
> polled IO on stackable block devices like MD.
> 
> We have explored two paths for enabling IO polling on bio devices. First
> idea revolved around rewriting MD to block-mq interface but it proved to
> be complex. In the second idea we have built a prototype which
> introduced new operation on request_queue - bio_poll_fn. bio_poll_fn if
> provided by stackable block driver is called when user polls for IO
> completion. bio_poll_fn approach was initially discussed and confirmed
> with Jens.
> 
> We managed to collect performance data on RAID-0 volume built on top of
> 2xP4800X devices with polling on and off. Here are the results:
> Polling      QD       Latency         IOPS
> ----------------------------------------------
> off           1       12.03us         78800
> off           2       13.27us        144000
> off           4       15.83us        245000
> off           8       31.14us        253000
> off          16       63.03us        252000
> off          32      128.89us        247000
> off          64      259.10us        246000
> off         128      517.27us        247000
> on            1        9.00us        108000
> on            2        9.07us        214000
> on            4       12.00us        327000
> on            8       21.43us        369000
> on           16       43.18us        369000
> on           32       85.75us        372000
> on           64      169.87us        376000
> on          128      346.15us        370000

blk_poll() used to be a pointer in the queue, but since we just had
one implementation, we got rid of it. Might make sense to
reintroduce that, and just make it an optimized indirect call. I
think that would be prettier than add the bio hack in the middle of
it, and you're having to add a queue pointer anyway.

Alternatively, do it like you did, but have it be:

if (q->poll_fn)
	return q->poll_fn(...);

instead of duplicating most of the core of the function with essentially
the same thing, just calling ->bio_poll_fn() instead of mq_ops->poll().

In other words, I like the feature, but I think the implementation
currently leaves a lot to be desired. It should be nicely integrated,
not some hack off to the side.

-- 
Jens Axboe

