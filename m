Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C2F2AF62E
	for <lists+linux-raid@lfdr.de>; Wed, 11 Nov 2020 17:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKKQXp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Nov 2020 11:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgKKQXo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Nov 2020 11:23:44 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3EC0617A6
        for <linux-raid@vger.kernel.org>; Wed, 11 Nov 2020 08:23:43 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u21so2831254iol.12
        for <linux-raid@vger.kernel.org>; Wed, 11 Nov 2020 08:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s4Jgqy8FHGYsxGd2uxg+9lGtU2p6NtadNFvzPdnxd2s=;
        b=HZsNKlo2UT9eRHtIwf289PTytKLb+zC8ek6E2dbj+f9F9pstXmXwaxqLvfcUbGalxN
         7Oddm2Wzh03m6vCQyr+ZlxLXiTaEetSry4XhA+EQxPZK5u22S4cQ2tA+19gy85pl0EZm
         Nt1au8XgQB6b1OgnynW0QwK26oe+DPu/U5nM7FzkpfFR3ecq4TzPZUU3+iQVCJ6lMYP9
         TinPfa4Va++MxpxAGgGeKk7iIJlnt8noV7Rn/gsf5YNLrMEWieECbH0dZGJG2fgNh0F3
         FM1tsPApkc2WvAbxES7anE/7P/cltGtV32WLSNJ0In4d0In83NeR8d45aH7hZ92FOetl
         HoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s4Jgqy8FHGYsxGd2uxg+9lGtU2p6NtadNFvzPdnxd2s=;
        b=QCBeRQTJprrdsozpREX8H4TlsqiewZbVDr+BNQGWYbWF6AVcgjmtcJT1WfexpiRyLn
         9X19w9B1LirBhDK6n5bMPJjgB52L7A3wrZsANRvjv7OrQvNvuZI8B7wx8Bkk0iexxTGr
         FnavexHh4Xj7V6D8yRTtX7QbgNa/NdbM0cUnjHuRTxK5uZIhFsDD6r1lCnjfrdOUdK2G
         U1zs/A+jHSSkmHDgj+6EzJdMi7DLlK0PM17hoD8ERzDFoNpndI5/6f/dTBbAwbn0y5LJ
         TI6tUQ02L+Giby86BMZ8/s2iZVG+VCuBZUQ/J3QMaPgz7MqYhFSD3DCXoAzP+kXwyiOB
         wbqA==
X-Gm-Message-State: AOAM532/tl3K1iCKnMSw6M0VwqvBsvX/jKOrV368oLhnH3NtRThD2Rmw
        ycKfXlct0psB2a74MoYY/DLtTw==
X-Google-Smtp-Source: ABdhPJzHHGmG1XrS7WDG6d3tzoxSvq+xuGBnqMcFnvnMWf0b7Gy9hUgmOrM9tqcOMGUk5yzj63tLLw==
X-Received: by 2002:a5d:9d16:: with SMTP id j22mr19163231ioj.172.1605111822389;
        Wed, 11 Nov 2020 08:23:42 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v9sm1439555ilh.6.2020.11.11.08.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 08:23:41 -0800 (PST)
Subject: Re: block ioctl cleanups v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
References: <20201103100018.683694-1-hch@lst.de>
 <20201111075802.GB23010@lst.de>
 <92a7c6e5-fe8b-e291-0dce-ecd727262a2e@kernel.dk>
 <20201111162035.GA23772@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <10469de3-10a9-c8b5-8e95-05a014b1c24a@kernel.dk>
Date:   Wed, 11 Nov 2020 09:23:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111162035.GA23772@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/11/20 9:20 AM, Christoph Hellwig wrote:
> On Wed, Nov 11, 2020 at 09:13:05AM -0700, Jens Axboe wrote:
>> On 11/11/20 12:58 AM, Christoph Hellwig wrote:
>>> Jens, can you take a look and possibly pick this series up?
>>
>> Looks good to me - but what is the final resolution on the BLKROSET
>> propagation?
> 
> Do it properly including a hard read only flag.  Martin has an old
> patch that I'm going to forward port.  For now I think we need to
> adjust dasd to match the behavior of all drivers, so that we can fix
> the common code to behave more like dasd in the next step.

I applied the series, so just send something for this on top.

-- 
Jens Axboe

