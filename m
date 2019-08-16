Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD490B8B
	for <lists+linux-raid@lfdr.de>; Sat, 17 Aug 2019 01:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfHPXuD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 19:50:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32772 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfHPXuD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 16 Aug 2019 19:50:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id v38so7977328qtb.0
        for <linux-raid@vger.kernel.org>; Fri, 16 Aug 2019 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABZeWfvDXPxS9+C+lPMp3krXNqJWCnWJYaryFgYIrYQ=;
        b=We0c8tRAd/vKvtAEwkkOEka+zIcTG1qb41N8Cm/tCLQ4xHPVhafaD8KRDAeH0l5Pvs
         M6i6QsoP9E/OOeCWSfypz8gORztVcML5TRxjRWfse3QHXc4xr0m8cJ8uUoJcrzDVefef
         U6lzliC9oSmg9qGJrYvj7Oz1RZkFIIBQ44YUgM/qFNjHV/FJSoDRrV4iMdaPab+KO+KM
         o20CzDdPABhb1suk5Fabmee3De0+fmmHzOUAv5DwN8Q/sMl45dCCD6Mha8yUmC2KIzpv
         yBbDr1iSIn5piV16jce9vDXwP5F0IrrTTSQsUpKDaCWO5QJHuPU0KOLaeyfJtY9/E+mT
         wnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABZeWfvDXPxS9+C+lPMp3krXNqJWCnWJYaryFgYIrYQ=;
        b=eZE8tGQOV9CdOgnAOfdd9x5Q8G6aoiUpYcuzmDOv5A6gBnISRuGoUS8SzLUD/EYXNk
         pXj0mcykcPt60Mbncx6ga0+G7IKEavDhu+JXbbrCC+mmk0cElLAB2T3uSoObBQuKeYuF
         4XJFRHrNztF67U3NqX0goE6e6/TvW00mejT81q9XLZenC8j+h1YBI9a07MfSpKl3TBvP
         p3Iq8KCePtMU5SH2MZ4pWLnYKXBOQheT1Opn+ybq/gy5ZdJ2lQopDHTNhCwBa8o1XGIx
         tNzccyuIA2rRuh2hHJ1JzNIFMyP8KYkEqbyfCRXdzuzsGGU+km4fySFFKyU/v1KailSF
         4HJA==
X-Gm-Message-State: APjAAAU+51noUJgllRtj4iiAEqjVk5edqZWOcokaq/bMO19Asz7gnCKH
        4Xwk2twh07nptENuCYmwoYniG7R8LRpemEYOW1c=
X-Google-Smtp-Source: APXvYqwOEaLHOWLWEOQWmcvMi8QX15GBSIyE5+BLP3R/tfZ0kms03eCfLWdKCq/qMWDnFBOdsrADDZif+jFghnl594w=
X-Received: by 2002:ac8:34aa:: with SMTP id w39mr11256430qtb.118.1565999402003;
 Fri, 16 Aug 2019 16:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190812153039.13604-1-ncroxon@redhat.com> <f79ead58-9feb-4b0b-5f29-fd1a4f10342f@redhat.com>
 <CAPhsuW5+vk4Ln84JSe-QEt-O2xee9d63B8aGEpxFLVfZWADEfA@mail.gmail.com> <875zmxj3cf.fsf@notabene.neil.brown.name>
In-Reply-To: <875zmxj3cf.fsf@notabene.neil.brown.name>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 16 Aug 2019 16:49:51 -0700
Message-ID: <CAPhsuW4JFMpqp__7BwKy+p1bDk_CndzpTRgTRSdxt22b=MqO0w@mail.gmail.com>
Subject: Re: [PATCH] raid5 improve too many read errors msg by adding limits
To:     NeilBrown <neilb@suse.com>
Cc:     Xiao Ni <xni@redhat.com>, Neil F Brown <nfbrown@suse.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Aug 15, 2019 at 6:39 PM NeilBrown <neilb@suse.com> wrote:
>
[...]
> >> Hi Nigel
> >>
> >> Is it better to print rdev->read_errors too? So it can know the error
> >> numbers and the max nr stripes
> >
> > I think rdev->read_errors is more useful here.
> >
> > Hi Neil,
> >
> > I have a question for this case: this patch changes an existing pr_warn() line,
> > which in theory, may break user scripts that grep for this line from dmesg.
> > How much do we care about these scripts?
>
> I don't think we need to care about this.  Kernel log message aren't
> normally considered part of the ABI.
> However in this case, it might actually be more readable to have just
> add another line:
>
>   md/raid:md0: 513 read_errors, > 512 stripes
>   md/raid:md0: Too many read errors, failing device sda1
>

Thanks Neil. I like this idea.

Song
