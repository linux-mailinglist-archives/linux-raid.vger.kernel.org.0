Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB91076E5
	for <lists+linux-raid@lfdr.de>; Fri, 22 Nov 2019 19:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKVSCF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 22 Nov 2019 13:02:05 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36820 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVSCF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 22 Nov 2019 13:02:05 -0500
Received: by mail-qk1-f195.google.com with SMTP id d13so7074701qko.3
        for <linux-raid@vger.kernel.org>; Fri, 22 Nov 2019 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0iWBayjH5uNtX+pm1Neqr2JT5AsB9AshD2os6fZMCY=;
        b=QplrzAk+1/Y04vcXalRoJhSpw+8YKrwU2oR9Et8hffYBiPWxfF6BVpzgN1J6ljvrp5
         K4ZKp2X+nW/KlSX0RHezGA3J7tmXoiE16d1IV6KGYBQFPqUz9Ds0Ik77H8sDhqf+TM24
         MvGu2OAdKwezRBrQlUTn6QkEkwi4upxGMvjBC8Y56unHKqp315YV0XjBEAF6dNhaiL0M
         uoaRTmz7cE2O/tEdeQWjdJzjWukNHntOEpbS3Ai1ArI2kThgGkJNWOGM7faz0FwRXK/8
         MTg+90H09TE42hU54nUY9M3ErrvUyrcUyjCxSIBJvgnv8rwnVvXGLMkO//3FqaxSeimr
         m4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0iWBayjH5uNtX+pm1Neqr2JT5AsB9AshD2os6fZMCY=;
        b=VkQM5yyIYQWo16fzCxYxTj6Tk5qaOcixx0eyLc5i2PHoeWj2jO4kRNJUTHIch9l6Za
         lTIyr1pdWgAQRqJhj0Jywv0Lpx/WB2cIpWAZo511OJ4BwJS83je7eWG1gHp6VGZX5Ase
         4SfI3QomFwAvJ5XuJxf8IZIYlN5m3xkihTluuqYm57a1TmdGhDv9cr3Ul4bmRNtN9iW5
         kRvpBW7TJCsaPt9t1QZksE52st0kskfDeRTIGhYXSBxDh5usss4geC9J93tLj9UZaN9P
         BMD1QVRi4RhfBX+5eH7QIs+O7giajDaTvzYclIq0MnEx47oPiMARXVo3V7iF7gNpnQJs
         wDJQ==
X-Gm-Message-State: APjAAAVTC2zdbXnELPjSmNaAXk3lGz3q/m9/L2fLT1lOxHFYwqW0CtA5
        XFilgZPz77/xgnC65TsJM38hCI2Pju5RicDdr1DyfQ==
X-Google-Smtp-Source: APXvYqyjXs2DEa9eIwoQcs5Cz+uQwyFiN+lBRQuc7WkyCm8G3qgnRPPHBTuxhewCLegzzA4uY0kPRBGZqR9ZDdwkGAo=
X-Received: by 2002:ae9:de07:: with SMTP id s7mr13791958qkf.89.1574445723183;
 Fri, 22 Nov 2019 10:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20191120162935.9617-1-ncroxon@redhat.com> <CAPhsuW4H-0R20M382uH--rvCoH1kjP-WmtkeiCM0P0F3k2Ozhg@mail.gmail.com>
 <d5a909c8-fb1f-37fd-cf6c-3522d34c2535@redhat.com>
In-Reply-To: <d5a909c8-fb1f-37fd-cf6c-3522d34c2535@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 22 Nov 2019 10:01:52 -0800
Message-ID: <CAPhsuW6nohSBUJ5wUtQCr3dFJAWsD1WtFEOwF_316nnFGz5wzw@mail.gmail.com>
Subject: Re: [PATCH V2] raid5: avoid second retry of read-error
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Nov 21, 2019 at 12:13 PM Nigel Croxon <ncroxon@redhat.com> wrote:
>
>
> On 11/20/19 2:22 PM, Song Liu wrote:
> > On Wed, Nov 20, 2019 at 8:29 AM Nigel Croxon <ncroxon@redhat.com> wrote:
> >> The MD driver for level-456 should prevent re-reading read errors.
> >>
> >> For redundant raid it makes no sense to retry the operation:
> >> When one of the disks in the array hits a read error, that will
> >> cause a stall for the reading process:
> >> - either the read succeeds (e.g. after 4 seconds the HDD error
> >> strategy could read the sector)
> >> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
> >> seconds (might be even longer)
> > I am ok with the idea. But we need to be more careful.
> >
> >> The user can enable/disable this functionality by the following
> >> commands:
> >> To Enable:
> >> echo 1 > /proc/sys/dev/raid/raid456_retry_read_error
> >>
> >> To Disable, type the following at anytime:
> >> echo 0 > /proc/sys/dev/raid/raid456_retry_read_error
> >>
> >> Version 2:
> >> * Renamed *raid456* to *raid5*.
> >> * Changed set_raid5_retry_re routine to use 'if-then' to make cleaner.
> >> * Added set_bit R5_ReadError in retry_aligned_read routine.
> >>
> >> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
> >> ---
> >>   drivers/md/md.c    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >>   drivers/md/md.h    |  3 +++
> >>   drivers/md/raid5.c |  4 +++-
> >>   3 files changed, 52 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index 1be7abeb24fd..6f47489e0b23 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -125,6 +125,15 @@ static inline int speed_max(struct mddev *mddev)
> >>                  mddev->sync_speed_max : sysctl_speed_limit_max;
> >>   }
> >>
> >> +static int sysctl_raid5_retry_read_error = 0;
> > I don't think we need the sysctl. Per device knob should be sufficient.
>
> Have an example?
>
> Remember, someone might want to enable this before the initial sync.

I think we can enable this for initial sync via /sys/block/mdX/md/xxx. no?

Thanks,
Song
