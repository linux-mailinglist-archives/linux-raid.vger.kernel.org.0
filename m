Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEEAC10684F
	for <lists+linux-raid@lfdr.de>; Fri, 22 Nov 2019 09:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfKVIvt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 22 Nov 2019 03:51:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47035 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfKVIvt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 22 Nov 2019 03:51:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id t11so5235848eds.13
        for <linux-raid@vger.kernel.org>; Fri, 22 Nov 2019 00:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ho0HAVGMYrPxxEWFoh9z017YiGV5XPe0jF7ebrI/vDo=;
        b=EmD3eQkTcaQvh+2o8xOXDBG0NnRwekTmA95QubCorid2/U5h5vlgiQhUupY/sypwDt
         1vUpRnwq9oMhTQfu239hc8g6sHPlCbezZqxEUrtSbTqwtjYffALrvIj70h6WRKt0BI5y
         l4byr45m/EO5Sei83QJ0SQOkro4z/+Fow1LOkT78Sh2opNObEgWAWc7atdEwacfoDg59
         BqomsW3ZOjlJh34511FSNktdc06JiUNIhnZj9r/Ya5CoFlyEdNkLxFZZMJN7Kl98Wqi7
         VXsFprUWh9kSoMHDhds7xuWX1KZfvJzmuPmq/0KY9Nriod2K3z5jYcwM4NIEKmsWDdy0
         4aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ho0HAVGMYrPxxEWFoh9z017YiGV5XPe0jF7ebrI/vDo=;
        b=cbKMALdSGdD7locien2e42r2XQzJBhb1wBh6Woos1yaqpVv2pryUyT/uiij3xkb1hV
         W9HReg1Vz9AhDh03UMfm8bAYQ+DOon9Tptn4sSOuZl16tJPzo6VrYp9ObWrYN5aaQtCz
         PlqhozaTz/WcfiSg3/hLWK0buNQoYLmgnGeP2vxUw+YiaTfRU5IFYBgji9vG5MJ8XTEs
         QN0CvUh7vmLFTCQVHWaKxgzksInMmFSZY27pcNsS/+X1k4ZNpIZUFQnM7t6Y88KCwedZ
         iO4U6hYau9T+sh446dQ4QVQpKIDldWG530Wp+kYW4YR1m9aOli9YGajRyAyCAkRS4Dt3
         HcKQ==
X-Gm-Message-State: APjAAAXuTe3nirSCYStrP3juikllF0MuAxFIBJG4uFRHF4FfKRCeElmB
        K24bH4H+2mSzviUbzi/b/ORTZ2scwTs=
X-Google-Smtp-Source: APXvYqz/+/lp6F7f1uO784orLwZcn6TilvDL86arIt8ojXZT+io5WiD1uxq4yMOYpzIT912W0MtEyA==
X-Received: by 2002:a17:906:8697:: with SMTP id g23mr21232084ejx.177.1574412707795;
        Fri, 22 Nov 2019 00:51:47 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:5451:27b5:beda:ddad? ([2001:1438:4010:2540:5451:27b5:beda:ddad])
        by smtp.gmail.com with ESMTPSA id k26sm47214edv.27.2019.11.22.00.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 00:51:47 -0800 (PST)
Subject: Re: About raid5 lock up
To:     John Stoffel <john@stoffel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>, shinrairis@gmail.com,
        colyli@suse.de, Song Liu <liu.song.a23@gmail.com>
References: <a9f64be8-0f57-83f7-e7dd-2d6d4386a6f4@cloud.ionos.com>
 <24022.45678.691077.153563@quad.stoffel.home>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <dd1d94d4-d6d2-ff5a-0b1e-aae6cb03bacf@cloud.ionos.com>
Date:   Fri, 22 Nov 2019 09:51:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <24022.45678.691077.153563@quad.stoffel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/21/19 4:51 PM, John Stoffel wrote:
> Could you use something like a bunch of RAM disks on a large memory
> system to stress test the spin_lock?  Esp if you put in some dm-faulty
> devices on top?

I tried with block ram device directly, though I didn't use dm-faulty
devices on top of raid5.
> REally load it down with FIO tests, and then turn on a faulty disk to
> see how it reacts?

Thanks, I will give it a try.

Cheers,
Guoqing
