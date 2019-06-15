Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B99846EBE
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 09:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfFOHiB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 15 Jun 2019 03:38:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39212 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfFOHiB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 15 Jun 2019 03:38:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so4730553wrt.6
        for <linux-raid@vger.kernel.org>; Sat, 15 Jun 2019 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WWmwPwW4Av4jOB3RtrFnC0dPmfjtG0O4Z8d7tV6rfm0=;
        b=xevwZ9GXhr/EEXOk8kVssolHAKYzhC61SJ283Ki5MVs71oUrMZdKmrO2IfvzJK6s0x
         QVHAVecb6Q8gLquAfqv0sKUdGMBLv0SUSJYEV0azEl8dnQwfHafnlPsSp0k+RdgjZyQc
         BtwSYJ/2B2HhCmxcEi1odbM7zYVffWe+O/AqJ9CrSpNyMczNgR8bQfe0KgZfaWsobU4v
         WkyKtYAOMIRZLwI0YOuoEkynSFQx+nc7hjsERF2VOFDt8Ei+g02s5k2DdCYBrM7zO2cN
         KY4NIjmgssImcn56r7e4pPc0ra+ym2Z5Sok0O3pSt7G2aupR6fQfX9mOqrrV8vbjrtOT
         JljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WWmwPwW4Av4jOB3RtrFnC0dPmfjtG0O4Z8d7tV6rfm0=;
        b=BPqYyWCYrJ7nKCQeSepzMKXIr1pBwMyLTvGx+2Ofk8UavpWMCtrFjWsQbHg4CA68/K
         3qAdZP9Rbd9B34Wa3QecYhfhx+Pwzi3YLrjQWHDhC5e6DrVTJAd54cHBbYt/bJqtkBop
         JUP7wyfGq+7vYTZ4Ju7ZgTaS1V7ucvIWaU46/gO5FyOX8hKbBlgGUHjxaIK2BIMJtRO5
         Lf+Xc0hWJ07ergvmeoY/nSToa4vL+vVvkUnWhiPCrx7GTRt6bQbwQ+PkVDvgWEqpJuAY
         uVClUqC0j9gajsElsdps5Swh/6puJlGWznuzg1RhVGxllMiXCT1VD3/ORcFauRR1gRUv
         Ywgg==
X-Gm-Message-State: APjAAAUA4G0GiS/HgcyQ33h/tShJjlPaUPweFrLN8/+keqZmDeAYI9y1
        zhtFJl9YOVkcb+ps2FeEtz5MlQ==
X-Google-Smtp-Source: APXvYqzhBfyP1PQTPTcbsVDrQzbBRlIU5I60+AAe91uUKPe2b9/SiGVDrihiC5xWqRNXO7vTKTFd5g==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr4450393wrp.312.1560584279092;
        Sat, 15 Jun 2019 00:37:59 -0700 (PDT)
Received: from [192.168.88.149] ([62.170.2.124])
        by smtp.gmail.com with ESMTPSA id t140sm1586510wmt.0.2019.06.15.00.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 00:37:58 -0700 (PDT)
Subject: Re: [PATCH 0/8] md: for-5.3 changes
To:     Song Liu <songliubraving@fb.com>, linux-raid@vger.kernel.org
Cc:     kernel-team@fb.com
References: <20190614224111.3485077-1-songliubraving@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ac185a2f-4ba1-c375-b976-e30154fb89bf@kernel.dk>
Date:   Sat, 15 Jun 2019 01:37:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614224111.3485077-1-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/14/19 4:41 PM, Song Liu wrote:
> Hi Jens,
> 
> These are md patches for 5.3. Please consider apply them to your
> (to be created) for-5.3/block branch.

Applied, thanks.

-- 
Jens Axboe

