Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860022E13B
	for <lists+linux-raid@lfdr.de>; Wed, 29 May 2019 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfE2Pgw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 May 2019 11:36:52 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:45754 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2Pgw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 29 May 2019 11:36:52 -0400
Received: by mail-qt1-f169.google.com with SMTP id t1so3085190qtc.12;
        Wed, 29 May 2019 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh+uCvg9Ehlaf4PsAsYgISeDSBil4a+MqI32Y7jAvJA=;
        b=oDh+RgDOkQCRBxWgYMB4AGxlvrPnYUvMC/2C8w151oc5uI8PjyZNxOgV+63Argut26
         Y6FBLzKI2Qaftjq0W9cmSakjrCdzkkpg9ZG59D6DPb4XHnCE4dTfJwgU/VP0L7tOtv37
         gah6svGEoH72Rr7fkGmWKfSoTs99mxhRlCf1V6Vs9g4VgPIdwBU68z3kvEP6zkLZeOG5
         2Q4KCnZcO5Lpv25m++9A1f7PIWkPcwwJMHI3/jvnNqn8CnnJtgOE/+KCrtryFBOoFjXz
         3va6V4fza7XzYIbV9Q/QUlyeiSXbnZ2CvKaxX/w/Ksn4n82qVZTDQ6VzLcuBQpGdwXvA
         RV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh+uCvg9Ehlaf4PsAsYgISeDSBil4a+MqI32Y7jAvJA=;
        b=MmJTRnpXsZ4aWUQB2YPjjIsVZXsc9iutV/+cmp/p0bVDkOL503cDszL7hc1Haau7GB
         R9KlER3/eg0BV2Mg4UMf6fHPcb/UUO8w6okcTKl91E9ugqE37W/3lkbGqasC0caustWh
         RwfPnaDHp5N/C6rUT6KHw2oUhB77hDYhzyAaClVjY0HN5lx431mW17JJtVz1B/Ng/0xd
         GLPoUtlCFMKU7ag9V36AofjTvWUjJ5O3qiMyla6WlICU3G5K87nefmJI+tPIgleLwNmr
         hObswU5M7cTYWcK62cJiw2Ov12J8NquVkalAbcl9D6ce2b8ej/8Kpdb+DMsZYq5HjmND
         oEjQ==
X-Gm-Message-State: APjAAAXNlggLha2rC8VYZnBnrPfSsstyPYxcPUEByRqNRQ5DPxJIRX8b
        qwT1sGr5Q7xXvZHdfN1law4i80CFinX38onaQwo=
X-Google-Smtp-Source: APXvYqx8MjdIIDxEGAah4McIj00qG9T4qDZL7XhKg4RCy3IFrNtYcGg8t6BNDwNXFpN47MfGiH3xki6t8+QjG8pPGXU=
X-Received: by 2002:a0c:87cb:: with SMTP id 11mr4898969qvk.190.1559144211489;
 Wed, 29 May 2019 08:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <3a28d64f-9f13-277a-a8f9-3cdf87034200@moore.sydney>
 <CAPhsuW5ngOxnddZp37nKe0KtsRTYxi-N1O2ARUqBbHbYJ=ASSg@mail.gmail.com>
 <263f25f0-e4e3-ace5-e8cc-96c8367549bf@redhat.com> <d689cdb8feb428a15ceca4aac2769dec@fritscher.net>
In-Reply-To: <d689cdb8feb428a15ceca4aac2769dec@fritscher.net>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 29 May 2019 08:36:40 -0700
Message-ID: <CAPhsuW74OKdQEauzGnk=WcKh1eNovXJb8d_yu_vmBG=fNJJcBA@mail.gmail.com>
Subject: Re: Optimising raid on 4k devices
To:     michael@fritscher.net
Cc:     Xiao Ni <xni@redhat.com>, Matthew Moore <matthew@moore.sydney>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-raid-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, May 29, 2019 at 12:19 AM <michael@fritscher.net> wrote:
>
> Am 2019-05-29 09:09, schrieb Xiao Ni:
> > On 05/29/2019 12:21 AM, Song Liu wrote:
> >> On Sun, May 26, 2019 at 2:27 AM Matthew Moore <matthew@moore.sydney>
> >> wrote:
> >>> Hi all,
> >>>
> >>> I'm setting up a RAID6 array on 8 * 8TB drives, which are obviously
> >>> using 4k sectors.  The high-level view is XFS-on-LUKS-on-mdraid6.
> >> Are these driver 4kB native or 512e?
> >
> > Hi Song
> >
> > What's the meaning of "4kB native" and "512e" here?
> > The sector size is 4kB or 512 byte?
> >
> >>
> >> For 4kB native, you don't need to do anything.
> >>
> >> For 512e, just make sure NOT to create RAID on top of non-4kB-aligned
> >> partitions.
> >
> > Could you explain more about this?
> >
> > Regards
> > Xiao
>
> Hello,
>
> 4kB = they expose their 4k sectors also at the interface.
> 512e = internally, they use (in far the most cases) 4kB sectors
> internally, but emulate 512 byte sectors at the interface. Which can
> make things slow if structures are not aligned at 4kB boundaries.
>
> Best regards,
> Michael Fritscher

Thanks Michael! That's exactly what I meant.

Song
