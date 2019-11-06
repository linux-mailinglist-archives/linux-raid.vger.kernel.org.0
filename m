Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46DF1466
	for <lists+linux-raid@lfdr.de>; Wed,  6 Nov 2019 11:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfKFKxC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Nov 2019 05:53:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46092 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfKFKxC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 Nov 2019 05:53:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id x11so8872107eds.13
        for <linux-raid@vger.kernel.org>; Wed, 06 Nov 2019 02:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uTyK1eF/ml9Hij3z6MDY8twYCN7Z3QKiDhrR3n0xDFs=;
        b=OEa1VrfAS8wWfQh7ziUBKOaW8EkHOkNactzhLflShWLsi5uvBCvQy7QhRb0+1UJRAS
         Z9Uu/yqp0sgQX8ro6YeTgp0wJ0rXeaJrCoFxw2rkCW/Uq6/5rKVK2Wzwh4GVhagdwiyj
         iPBg3mRqF3MzCoXh3KCoBbQdrumHIxUuqLgIHTVteS20G5fAuhBHhcjCDsfsDTBzbOel
         Q9PX8+/KfALEVu5VKgT2HSJvRexIW/9pICLqGU5smbBQFFLo506uTzIWseGqFkORzxOo
         Mra5jZ7DImvWoJIUZ0NEezL04cU8SpbYmPtxF/w3UmtfZKbhSYHBIgEcoIiqcc1yhSP9
         tRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uTyK1eF/ml9Hij3z6MDY8twYCN7Z3QKiDhrR3n0xDFs=;
        b=SvpR5k65NbhQTKu0YSUds8zhAyoAYGzS8uSBGz6LXWEWtSKJgO2r9PfuA1LAO6E/08
         r4jMZmcmOqjGpLCe76nY7wYzsiVWTTqaEYzu7xINATMlKIcEfHpIiRJ7f3C9mLu9cr4j
         7mM4YvK7tS8AbBAAIM7NImkLBA0EI007Zkjy4qMQRLj0tn9tuPQ4mNynOuFwVVt0OGRO
         HnOzdWxYBEfsfol7G2pPVuYLP+SZGOKhybzfg7tILx6u6E2ropCDEse+JBq/Jw9G8wyK
         A3IKl+pBf9lX46jEBLkc9TJgj3S1UKgy1Co1XZ/U7KcXkvu7SX8nz9Yk2TWGtLOScUsd
         qwrA==
X-Gm-Message-State: APjAAAX/1fCFwI1ZupYwn6irAzM1dv7vJ/zoUxfC8AMt49erX99LxT0c
        FMNOChPN5dFNr6r+c1E+okvuD2AP0uE4BA==
X-Google-Smtp-Source: APXvYqz++IqO/Kp5tte6ti32hkATQURarq4+971C3WGQ+7NgJGg62Ksgl4l6bir7pDNaTgydpR/Fhw==
X-Received: by 2002:a05:6402:1397:: with SMTP id b23mr1888501edv.196.1573037580030;
        Wed, 06 Nov 2019 02:53:00 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:1c1:e73c:e916:21a0? ([2001:1438:4010:2540:1c1:e73c:e916:21a0])
        by smtp.gmail.com with ESMTPSA id e13sm1123060edm.29.2019.11.06.02.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 02:52:59 -0800 (PST)
Subject: Re: [PATCH 7/8] md/raid1: use bucket based mechanism for IO
 serialization
To:     jgq516@gmail.com, liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
 <20191101142231.23359-8-guoqing.jiang@cloud.ionos.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <0f4f0056-a8a1-c5e3-ca1a-7778cbeab97b@cloud.ionos.com>
Date:   Wed, 6 Nov 2019 11:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191101142231.23359-8-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/1/19 3:22 PM, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> Since raid1 had already used bucket based mechanism to reduce
> the conflict between write IO and resync IO, it is possible to
> speed up performance for io serialization with refer to the
> same mechanism.
>
> To align with the barrier bucket mechanism, we created arrays
> (with the same number of BARRIER_BUCKETS_NR) for spinlock, rb
> tree and waitqueue. Then we can reduce lock competition with
> multiple spinlocks, boost search performance with multiple rb
> trees and also reduce thundering herd problem with multiple
> waitqueues.
>
> Of course, we need to deal with below conditions:
> 1. Handle the failure of memory allocation since more memory
> are needed. So the two functions (rdev_uninit_serial and
> rdevs_uninit_serial) are introduced.
>
> 2. Free those allocated memory when serialization is disabled.
> Which means mddev_destroy_serial_pool is also need when backlog
> is cleared, write is stopped or bitmap is destroyed, so add
> is_suspend parameter to mddev_destroy_serial_pool to make it
> fits in all cases.
>
> Also no need to export mddev_create_serial_pool since it is
> only called in md-mod module.
>

[...]

>   /*
> @@ -160,13 +221,17 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
>   

[...]

>   		noio_flag = memalloc_noio_save();
>   		mddev->serial_info_pool =
>   			mempool_create_kmalloc_pool(NR_SERIAL_INFOS,
> @@ -175,6 +240,7 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
>   		if (!mddev->serial_info_pool)
>   			pr_err("can't alloc memory pool for writemostly\n");
>   		mddev->serialize_policy = true;
> +abort:
>   		if (!is_suspend)
>   			mddev_resume(mddev);
>   	}
> @@ -186,8 +252,8 @@ EXPORT_SYMBOL_GPL(mddev_create_serial_pool);

Hmm, I forgot to remove the EXPORT_SYMBOL_GPL per the patch header,
will update the patch in next version.

Thanks,
Guoqing

