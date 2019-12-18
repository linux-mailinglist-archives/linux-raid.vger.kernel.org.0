Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D74124B79
	for <lists+linux-raid@lfdr.de>; Wed, 18 Dec 2019 16:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfLRPVx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 18 Dec 2019 10:21:53 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39740 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfLRPVx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 18 Dec 2019 10:21:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so1962921eds.6
        for <linux-raid@vger.kernel.org>; Wed, 18 Dec 2019 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=w2TYc3X5F1+pKlPGMTDMJxTpnr4QeJUwqvIFBGbUsRo=;
        b=LzNhIq0udSz5l1vL2aoBDzkNqnaLDS+Bf3b7mUnl3KV7EckS/RwcfS0oFBEEEYZFp8
         7WaVKRsF39qmndaj6eZ/6pizc3qL4sW0Lqy6+7luczfQuoXk9n9Aw9VkZKNm3j4zsHcS
         ego0HmRNMbTXloLiOXdRJmFiZXJHK3NDaNOwOS7JcSvBE+tAceDI0EMmaYF/Y3Sr6cvI
         gn/fIXxO+VFlFAfHPGepIP4OoAP0xKRrm2riEMpe15vtDjxewVkMJLzWXfTNpPrxmUqg
         ikCw9DImAsVkul+BdxYuX0xE/IbjZwle8mpgEMBvtXenFCIc31ZesdksvB7SxldcokZ5
         ni4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w2TYc3X5F1+pKlPGMTDMJxTpnr4QeJUwqvIFBGbUsRo=;
        b=kAC7mwwHPmXrtuuB86AE2K6OXKBFCXEnr1qpkmPKBtQ9mEKJUzjS5fPXnq2irVFw1P
         OFVf9f8/qJNQ/C1wF9KAMwELYHLciWj5KmR5d49Ox9NJnrAH5h5QcSSZs3FQKjcDYyCt
         DWDgWHumGPhGQbHeLGbhnlh+qhB/x5KukNEmfrT5YhLrR+dFowklaZeF7vp6/2gxi+wA
         Z6Z+0ZEIpsm/DCU/5jUmFuboExPUYTlPoE2V3qJWo0JC5Ykz1VdTFtX+3aeXZvXwfHCz
         5uh0nV9QmK18vjqO4DosjnZI26C+vTTM51n92zYC0a79+8t/i3bn2qMwjH9qMqslhav4
         P6Aw==
X-Gm-Message-State: APjAAAU3i482KFgnWaOoB0H5PGBw7+1nGcYahje4H0xKV+bARnRo86vL
        HzfXNQLCNUS9Iemup/mXU+JtBoXOl68=
X-Google-Smtp-Source: APXvYqxQWdSGevlibmSscxTRAUgermtlC2BDuWSUXJ9Vz/ek9pxBWWpla1SVY5eVm5zHDu09G5K6gw==
X-Received: by 2002:a50:cd1c:: with SMTP id z28mr3012049edi.20.1576682511225;
        Wed, 18 Dec 2019 07:21:51 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:980f:fddd:828f:9ec3? ([2001:1438:4010:2540:980f:fddd:828f:9ec3])
        by smtp.gmail.com with ESMTPSA id nq3sm105488ejb.73.2019.12.18.07.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 07:21:50 -0800 (PST)
Subject: Re: [PATCH v2 2/9] md: prepare for enable raid1 io serialization
To:     Song Liu <liu.song.a23@gmail.com>, Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
 <20191121103728.18919-3-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW6aKNVcRQR9Hov2=cO2X8L-qGO9VFPKq7DNA+7M_TMw4A@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <1ec78b34-8e03-ef59-260b-f37070ea505b@cloud.ionos.com>
Date:   Wed, 18 Dec 2019 16:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6aKNVcRQR9Hov2=cO2X8L-qGO9VFPKq7DNA+7M_TMw4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 12/18/19 2:17 AM, Song Liu wrote:
> On Thu, Nov 21, 2019 at 2:37 AM <jgq516@gmail.com> wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> 1. The related resources (spin_lock, list and waitqueue) are needed for
>> address raid1 reorder overlap issue too, so add "is_force" parameter to
>> funcs (mddev_create/destroy_serial_pool). The parameter is set to true
>> if we want to enable or disable raid1 io serialization in later patch.
> Looks like is_force is always the same as "rdev == NULL"? Can we remove the
> is_force argument and use rdev == NULL instead? I guess it will also simplify
> the functions.

Ok, will remove it.

Thanks,
Guoqing
