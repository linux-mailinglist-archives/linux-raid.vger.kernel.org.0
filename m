Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9656C78AF3
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 13:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbfG2LzA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 07:55:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41551 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387637AbfG2LzA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 29 Jul 2019 07:55:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so59020679eds.8
        for <linux-raid@vger.kernel.org>; Mon, 29 Jul 2019 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+iITdkBI4Lu/rfn83CSy6RYwBOi+56VbfZhBgY++oqY=;
        b=F7ceOPfcDXgwYLTTK6r3DZwbFVCyZZ2/X+J7AW3YPduc/5h4GFsbUfhZc0IqnAftZd
         JXEivjVnarxglNSFxgrzSowrJzZr9ylEnHz1d8mHmVQ/0GNEpW3xnBBSb1vc8itx+JIw
         mDYiEHoCqZtspYwW4wjQTuDeakX4mAMw5rQd6iQh9CuZdxsLcps0X4/zuyXuRAQ5xRw0
         ii3kkB6+GukWKGh1gzz6TD3LXl90dt11//KqqK0jj784pp1wZgfGXCwOs2dKeLYDB3D8
         cdut7hUJ5woqtsr1+GRCqh8C1lofztnvmp3jZfj5SRA9uEzYPAcIAM9DmBpV8RK8Gr0u
         yalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+iITdkBI4Lu/rfn83CSy6RYwBOi+56VbfZhBgY++oqY=;
        b=m3+MD9/V5jbhItfIMN6PDEOVSJXkzTPkGbPYapaN+/9VW/Pz8x46fClz5/ewVkX7ZC
         QZapWUAIYhvBWpAHG3SHVPX/LtDJieZir/nehzChj4+ZTY6z2GeMERjcIisEOro/CCTk
         CJJzrT8MoyR8A8shJtGRQiw2F3926oR8qRXewYR3aaDFunvnlq8wzincmXkhe4eLMJWY
         rcKPbZVq91e64Pw4xXirLwFY950cHdAWj0ZjehgxPJ7qR8x81ydr47vHh8wGtgXUGx6R
         7S8iXVbbiDCOZKq0T1w/a+IkOrOLSTcl+WFROAMGWChpvhlr+wkSdFtlxr371b1HF8gB
         Yd7Q==
X-Gm-Message-State: APjAAAVLmOgglyvuHts+D6DraNxa5n8NdL5J2R3idezwl2YD6PVVwfPV
        J5sjd9J2lUPn4zVeyhww2/tPedT5ZO0=
X-Google-Smtp-Source: APXvYqzeqEt6wBalXypk4bwHqin1+k67KNVmGcfE/i4t1foonpBsfkdzw6KS7lcOv2AUi4s5i4/2cw==
X-Received: by 2002:a17:906:19d3:: with SMTP id h19mr84332606ejd.300.1564401298625;
        Mon, 29 Jul 2019 04:54:58 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:e5f9:3830:1b1f:5b33? ([2001:1438:4010:2540:e5f9:3830:1b1f:5b33])
        by smtp.gmail.com with ESMTPSA id ni7sm8218237ejb.57.2019.07.29.04.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 04:54:57 -0700 (PDT)
Subject: Re: [PATCH] md/raid1: fix a race between removing rdev and access
 conf->mirrors[i].rdev
To:     Yufen Yu <yuyufen@huawei.com>, liu.song.a23@gmail.com
Cc:     neilb@suse.com, houtao1@huawei.com, zou_wei@huawei.com,
        linux-raid@vger.kernel.org
References: <20190726060051.16630-1-yuyufen@huawei.com>
 <e387c59b-4de4-eb6e-5bfd-2e5ba10ca741@cloud.ionos.com>
 <b98073c3-4b81-dd4a-09b1-47e277c24961@huawei.com>
 <538db63a-d316-5783-f45b-b8310d19b7b9@cloud.ionos.com>
 <d3bec7ef-4e35-8a32-8b11-cda5e99b453d@cloud.ionos.com>
 <3e6b5faf-a588-8cf0-1c49-8ffd15532a19@cloud.ionos.com>
 <913a04be-a00c-849c-a064-f2cde477dbe6@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <d123f888-0f3c-2ba1-5c53-c13586236551@cloud.ionos.com>
Date:   Mon, 29 Jul 2019 13:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <913a04be-a00c-849c-a064-f2cde477dbe6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/29/19 1:36 PM, Yufen Yu wrote:
> I don't think this can fix the race condition completely.
> 
> -               p->rdev = NULL;
>                   if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>                           synchronize_rcu();
> +                       p->rdev = NULL;
>                           if (atomic_read(&rdev->nr_pending)) {
> 
> If we access conf->mirrors[i].rdev (e.g. raid1_write_request()) after RCU grace period,
> synchronize_rcu() will not wait the reader. Then, it also can cause NULL pointer dereference.
> 
> That is the reason why we add the new flag 'WantRemove'. It can prevent the reader to access
> the 'rdev' after RCU grace period.


How about move it to the else branch?

@@ -1825,7 +1828,6 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
                         err = -EBUSY;
                         goto abort;
                 }
-               p->rdev = NULL;
                 if (!test_bit(RemoveSynchronized, &rdev->flags)) {
                         synchronize_rcu();
                         if (atomic_read(&rdev->nr_pending)) {
@@ -1833,8 +1835,10 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
                                 err = -EBUSY;
                                 p->rdev = rdev;
                                 goto abort;
-                       }
-               }
+                       } else
+                               p->rdev = NULL;
+               } else
+                       p->rdev = NULL;

After rcu period, the nr_pending should be not zero in your case.

Thanks,
Guoqing
