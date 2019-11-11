Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5139F70B4
	for <lists+linux-raid@lfdr.de>; Mon, 11 Nov 2019 10:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfKKJ3p (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 Nov 2019 04:29:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37951 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfKKJ3p (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 11 Nov 2019 04:29:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id s10so11381936edi.5
        for <linux-raid@vger.kernel.org>; Mon, 11 Nov 2019 01:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=V9mFHHLeGY2V0PkgBu80Os5t48Xfv1cGm0sWnJh9iRs=;
        b=gP2DcVa/fitBEm0p7njrEtRD3Cy5MYVeqwVmqBM1qyQ7xWZ6E+kBHlZPZxGOtyIr5m
         Bm7VAjgFRFujK9+WZTRVUCZ7YHCJjGgGJM3yBZVu4c0Zj10SG/h9nEwMbsUwS2a/ugie
         sxIXAnTjrojA75e7tFZMsgY9gOsuUCuZj67Y2qZHS5eEiPkdsqA1nRnDsBDHxYHrvE6Y
         hEmQAbiuu9Wk0+jdPQGesgjV8/hGZ6UorSryT0EAInZh210wVhPddrsIMcc9akDAfmgP
         8TNjCSneapPNmi4mxd5ZeYSeyog3b08A+py318OmgDg37yL+NQ+B8nDCuERnvzUWzTdv
         u/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V9mFHHLeGY2V0PkgBu80Os5t48Xfv1cGm0sWnJh9iRs=;
        b=D8TaZ8oV/pgIH7wOSeAer4b1mOMr9Vn1bG1zu+huOAYWTd+55PzCBySL4yD6AhbKei
         WIV1fnt/LF6OqPFaoDpDGpKAcFMgnXHENPRPvWLzI2n9k9ysXVyB3GXfWRsdzzxohHTg
         932hqWYlxROVuP0i7HxAA5bqwvy2/Dk8DaF4/dXzK1lXyovQwEN9mUmtAee+kWhkLlwh
         JObBel3vx8066kgybdhcWvhW2CsG85c40brWD3vIVH0hXY9Nm5EwgGPcFMQQsU3LvVZC
         QijGwnKey+1oKtZY8NMk6eLMn1tqTcK9HRGwnPq/OIxIYXomPsdCFS08fP+gQDg5eEf5
         HGIQ==
X-Gm-Message-State: APjAAAXGz9BlhLIe+6BCttDY4aqARWQd2uLTQoPyjaPsHEI0f/oKm0ML
        WbQMasfti52zJafQxmrfQMP9K/M3Bis9wQ==
X-Google-Smtp-Source: APXvYqzGJXXAtlM/UqxLqJ2A9iKyg4m5okQhnm+ax3Fo1tnJqV7smhPhJr0gTr654XULZNDm+3q53A==
X-Received: by 2002:a17:906:c293:: with SMTP id r19mr21692622ejz.69.1573464582187;
        Mon, 11 Nov 2019 01:29:42 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:4de3:f9ba:6e9b:388d? ([2001:1438:4010:2540:4de3:f9ba:6e9b:388d])
        by smtp.gmail.com with ESMTPSA id e13sm509165edv.42.2019.11.11.01.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 01:29:41 -0800 (PST)
Subject: Re: [PATCH 6/8] md: switch from list to rb tree for IO serialization
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
 <20191101142231.23359-7-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW4tFUO4UAWyRoMsPTWKBq7=fe0jj-9ojP=r2oF2_OgrQw@mail.gmail.com>
 <961f17f4-77bc-f9c7-035d-4333b11a60ee@cloud.ionos.com>
 <CAPhsuW5tSEFpbUKJ-EP_RyabmsRQzBTX18Mkbw6WyUG+M2rkVQ@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <22ef2aa6-9133-bf76-eacc-d7520974b759@cloud.ionos.com>
Date:   Mon, 11 Nov 2019 10:29:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5tSEFpbUKJ-EP_RyabmsRQzBTX18Mkbw6WyUG+M2rkVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/9/19 12:20 AM, Song Liu wrote:
> On Wed, Nov 6, 2019 at 2:43 AM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>>
>>
>> On 11/5/19 11:03 PM, Song Liu wrote:
>>> On Fri, Nov 1, 2019 at 7:23 AM <jgq516@gmail.com> wrote:
>>>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>>>
>>>> Obviously, IO serialization could cause the degradation of
>>>> performance. In order to reduce the degradation, it is better
>>>> to replace link list with rb tree.
>>>>
>>>> And with the inspiration of drbd_interval.c, a simpler
>>> Can we reuse the logic in drdb_interval.c instead of duplicating it?
>>>
>> Yes, I thought about it, but we need to move the logic from drbd to
>> a common place before we can reuse it. And seems pat_rbtree.c
>> has the similar implementation, so we can reduce a lot duplication.
>>
>> But it definitely needs more efforts to put the logic to a common place
>> since it involves different subsystems,  which means we have to wait it
>> for a longer time. Or we just add the logic here, then try to refactor the
>> common code later.
> I would prefer we at least try the move. If we got push back from drbd
> maintainers, we can go back to current approach.

Ok, I will give it a try.

Thanks,
Guoqing
