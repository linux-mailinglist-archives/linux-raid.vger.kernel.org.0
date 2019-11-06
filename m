Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397C2F142B
	for <lists+linux-raid@lfdr.de>; Wed,  6 Nov 2019 11:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfKFKnn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Nov 2019 05:43:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43885 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfKFKnn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 Nov 2019 05:43:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id w6so1513063edx.10
        for <linux-raid@vger.kernel.org>; Wed, 06 Nov 2019 02:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OlZV1U1AkgpgwDN1UQoRJ9qD4DHKT3lRm6kN2LRY1hQ=;
        b=bbZi00ylK7G8DgcMzAbuSqP+GlP7NI6Zqso5OGDyWjnmCW/GO8Of3XX7jKZpdlZUf8
         OLgl3MGHNtfFqRDWOP/viuX87gjDff75TEA2/c4kKejbsaDTYC29AN69LtspUgxACoIS
         T52B0zMKd6SpgpYZkpZMDKaiP9eLNZdWwOjnutZI7bAe6iJ4DUH6q/0kIJ8TmuiCON6k
         zu3UcndaEsJgrqdOL+Kx4BWFrL0PzWpvubmynPRJzUuyO+lr7BaAc4FPsV4R4NT9ex4Q
         QQrFfqy6tZhy8ghOnYJdPu0ZCYfQKT58K+0F3Q7VQ4NOlLHmiST8tAuYm6onvczfSdPX
         0Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OlZV1U1AkgpgwDN1UQoRJ9qD4DHKT3lRm6kN2LRY1hQ=;
        b=KLsnyEOdQKy4bda6jmMj2RkbloV0ca8e2xJYUb/IU3aek/Mtc3i5HS9GDRDNkuS3OK
         uVOvY++GArN7PftX+OcXY9T22Myeim7pY+zkYgXFnzhAbGcOL0Fzqcx3547i7q+PBZPx
         5Zpuo+tai9raLEF+gv8vxMgKluK/r8vy0lxc5Fugf2vbQtVy2CrTrINzKP9BNlVnkrXp
         /cftgtn3AR6R1r424wxigXAD6YUKQtGFuJ9tqo5B0Kp5g2p0XHJyvpWdOwyvxE9zNoM6
         ekOwNWvKPI92QA42heGSWDXaQaU4v9T7LCbQ4lRnJN/BW1T3wQIE9H4tO64SfhuKAA4e
         eg6w==
X-Gm-Message-State: APjAAAXOnTkbhSKFfl3q3/wJZbWAmjtNdz4j5N3oqJdImBYbX3iQXgif
        l+86rp8jp0c9AJnYEWS7i1lzIO8fW61mVg==
X-Google-Smtp-Source: APXvYqzWk0Vq7Z/54mDuR2SSKYB2X72RmNiG+NZCPfX+6DCoqxeQRBdRWn6GuAnFDH17QOrYFU+/Tw==
X-Received: by 2002:a17:906:bfc6:: with SMTP id us6mr34052460ejb.51.1573037019672;
        Wed, 06 Nov 2019 02:43:39 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:1c1:e73c:e916:21a0? ([2001:1438:4010:2540:1c1:e73c:e916:21a0])
        by smtp.gmail.com with ESMTPSA id l64sm1036859edl.86.2019.11.06.02.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 02:43:39 -0800 (PST)
Subject: Re: [PATCH 6/8] md: switch from list to rb tree for IO serialization
To:     Song Liu <liu.song.a23@gmail.com>, Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
 <20191101142231.23359-7-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW4tFUO4UAWyRoMsPTWKBq7=fe0jj-9ojP=r2oF2_OgrQw@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <961f17f4-77bc-f9c7-035d-4333b11a60ee@cloud.ionos.com>
Date:   Wed, 6 Nov 2019 11:43:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4tFUO4UAWyRoMsPTWKBq7=fe0jj-9ojP=r2oF2_OgrQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/5/19 11:03 PM, Song Liu wrote:
> On Fri, Nov 1, 2019 at 7:23 AM <jgq516@gmail.com> wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> Obviously, IO serialization could cause the degradation of
>> performance. In order to reduce the degradation, it is better
>> to replace link list with rb tree.
>>
>> And with the inspiration of drbd_interval.c, a simpler
> Can we reuse the logic in drdb_interval.c instead of duplicating it?
>

Yes, I thought about it, but we need to move the logic from drbd to
a common place before we can reuse it. And seems pat_rbtree.c
has the similar implementation, so we can reduce a lot duplication.

But it definitely needs more efforts to put the logic to a common place
since it involves different subsystems,  which means we have to wait it
for a longer time. Or we just add the logic here, then try to refactor the
common code later.

Thanks,
Guoqing


