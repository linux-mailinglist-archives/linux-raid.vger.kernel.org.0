Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95C031262C2
	for <lists+linux-raid@lfdr.de>; Thu, 19 Dec 2019 13:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLSM7i (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Dec 2019 07:59:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42978 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfLSM7i (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Dec 2019 07:59:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id e10so4781487edv.9
        for <linux-raid@vger.kernel.org>; Thu, 19 Dec 2019 04:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ksvedoybv88c8/mZQip6lDcGy9NuRjGs/88DgzV4g2c=;
        b=bJnIEMO/OCYyC9H2bWYjAPtXcATPAn0dT3yxr6YMvi4ulifkDJQkQFHZutebiAo/vm
         e+foI6zCwcQ3dRsPeXfc2litXNJmaE/QIdooBgO+nUIMqs2FeKU47EpSk1i7iIH0wVQn
         8KDp+NH+6xthlUdRJqNfMNtlRSqfX1sRLjmKjntba5LBKfEQFgvEQMasQa1NmFCvHEJg
         KcyT9bTVf33YOHJ94cqoajiuP+YW2E2bMVgDu3eaWfWNUiPcbfOc6mOISlTQQUK1pmWf
         fQXRiRMUptYQSnOqbXgJeJE2zbhtqMF4x4anOWQrx7rSGdsYCltyvnJ6gFu+bMoiYWTN
         zmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ksvedoybv88c8/mZQip6lDcGy9NuRjGs/88DgzV4g2c=;
        b=MLvEg1uLM8Zb6eDboAQzpYMDzAn6fx9nYhOkvxgWWyKG57C6TCaGWsPf+R0MH4pQ0H
         SFpDAEyVAR1K4noDdQI4/0mbe87IC3Rn0Twl6f4HsrLG4jdCASS77DxqerGI96+hl6yR
         jWwOhcvHmWL7POrmk8TygCZvxqfAPYTdLywplJZwwisSqsc4rbctTojtzqIKU2sfzUUN
         7m7IcJbsWIS28/nV9PeG8RpsT5hNO5FF6jVwSMM04Uj4BvTcxa3inS3TZL91dM1e5Lar
         kxemlnxRvqYXHl/nIUTj3mS3dBSi9Y1mU0RZiW+ZejENuAryZxeSHHkr0B1cXnVcISS6
         vz1A==
X-Gm-Message-State: APjAAAWo4knZ5pVkqxrlm3IVfOixA66/fVDcsaZ31CAi3snTuEhZd3Li
        hOiIu0l8B9GpqmJTbofRltA7wy+VRqY=
X-Google-Smtp-Source: APXvYqxO07O+hk85QDOcLJIsyBtOjoPTSU/pEN0eUhFtMR0W45hw5UuxuEe+CXSIb5tl9exV2iLV7w==
X-Received: by 2002:aa7:c994:: with SMTP id c20mr8905565edt.113.1576760376318;
        Thu, 19 Dec 2019 04:59:36 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:980f:fddd:828f:9ec3? ([2001:1438:4010:2540:980f:fddd:828f:9ec3])
        by smtp.gmail.com with ESMTPSA id nq3sm493754ejb.73.2019.12.19.04.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 04:59:35 -0800 (PST)
Subject: Re: [PATCH v2 1/9] md: rename wb stuffs
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
 <20191121103728.18919-2-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW5gxOPSRGtcquZZNLdq49OgaoKr5WGXvP9dZvALtiSeSQ@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <b92ff3c7-6fd9-9c6a-81c8-9f867d066808@cloud.ionos.com>
Date:   Thu, 19 Dec 2019 13:59:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5gxOPSRGtcquZZNLdq49OgaoKr5WGXvP9dZvALtiSeSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 12/18/19 8:13 PM, Song Liu wrote:
> On Thu, Nov 21, 2019 at 2:37 AM <jgq516@gmail.com> wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> Previously, wb_info_pool and wb_list stuffs are introduced
>> to address potential data inconsistence issue for write
>> behind device.
>>
>> Now rename them to serial related name, since the same
>> mechanism will be used to address reorder overlap write
>> issue for raid1.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> [...]
>>                  rdev_for_each(rdev, mddev) {
>>                          if (test_bit(WriteMostly, &rdev->flags) &&
>> -                           rdev_init_wb(rdev))
>> +                           rdev_init_serial(rdev))
>>                                  creat_pool = true;
> As we are renaming things, let's also change creat_pool => create_pool.

Good catch, I will add a new patch to fix the typo since I don't
want mix different goals in the same patch.

Thanks,
Guoqing
