Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7F74D882
	for <lists+linux-raid@lfdr.de>; Thu, 20 Jun 2019 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfFTS1O (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 Jun 2019 14:27:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38662 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfFTS1N (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 20 Jun 2019 14:27:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so4196475qtl.5
        for <linux-raid@vger.kernel.org>; Thu, 20 Jun 2019 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtPNuG/RH5YOF5P2yPkQHJ1yvLrjROHkL/ZaS0KDWl4=;
        b=K+zAayuBEzznK/fmQ90TvDsdNDKXwI4oz/0rsRLTmV2gJb1zeUDti7XwuVwQtNNNrm
         /6t81eCKKV4tSCGGL4sWngCijzdC+sRBHMQhXJHPqONdYW/ytE23iaGZpz/xcEAfPdc9
         ffncHWaGyrcgMPol8nwoWxBMGMD0ocq4XyseObs7XDZEgjNqwcWgi2fh0Si0MtKLnhyW
         orrRVEHnokaCdgpgxey446Tu51bI6e4mnoUGdD9smpemLULHl6Kumud+92UgbxlM0MzN
         9nowBLscUOHwOgoE5zvmGriSlhDDQD6fDlNpE5YBuew/gpudEpvidfEZoU+8CRa+FIQT
         MLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtPNuG/RH5YOF5P2yPkQHJ1yvLrjROHkL/ZaS0KDWl4=;
        b=JfHA7qMTHfdASLSkmzgX9bvfm5bAfDILlqgYN1DKTzuy0slzJVv9C/MRIf4XDCEqjZ
         E/alP1n8JuqaQoVEgaSHjYN3tx1lX4JK2VZD+WkCYjmVIqXva5ifSsS97FRQThNKgoRS
         iTjWffJ55iRQDtj25tc34Zl+5PbmB6vbNIbYprtsnzla6Y9xpnkR3TRutEaMCG0uNUph
         K7+b5LsVUSuzsg+/MmyFFoNlL2s+zh6CHwxDV0ACXYFmOolc6wcoIbcYRdYR9zi5iuHQ
         YAqUM38Uov8y0n1b52rAViAciyMdIJCiBNwn85BZKbP0cJTMuLQaqTeZgqc8obTb98/Q
         qLVw==
X-Gm-Message-State: APjAAAWBgjpbcYHH4hY6FoalGPTMEgEGsR/QgD81R7gS7Qs24+ggTWqx
        0uXkZg3JOlZiA5UgPgRcFxYkyIOrAi45K40kZLac4Q==
X-Google-Smtp-Source: APXvYqzyi/KZ8E0s7YfZ+d5gxcnPnW8sWSSDIr4CqNSaMYfGQL5jqIC5zUYAh+5M/M8d0p9c7r3VrpJgWE0tZca60gc=
X-Received: by 2002:a0c:d0fc:: with SMTP id b57mr41113953qvh.78.1561055232664;
 Thu, 20 Jun 2019 11:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190614091039.32461-2-gqjiang@suse.com> <20190619093046.14066-1-gqjiang@suse.com>
 <CAPhsuW5wuqL=q6THJKwS1ZDkqZLyXaz2gGM7yr==UDOpKOhTVg@mail.gmail.com> <e355dae1-06bf-262a-4365-b172db664068@suse.com>
In-Reply-To: <e355dae1-06bf-262a-4365-b172db664068@suse.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 20 Jun 2019 11:27:01 -0700
Message-ID: <CAPhsuW5NoA_0uAJ8Jqi8f_joQ+6MGEMj2ih+r9onRajqYRFejA@mail.gmail.com>
Subject: Re: [PATCH 1/5 V2] md/raid1: fix potential data inconsistency issue
 with write behind device
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jun 19, 2019 at 7:55 PM Guoqing Jiang <gqjiang@suse.com> wrote:
>
>
>
> On 6/20/19 1:28 AM, Song Liu wrote:
> > On Wed, Jun 19, 2019 at 2:10 AM Guoqing Jiang <gqjiang@suse.com> wrote:
> >>
> >> For write-behind mode, we think write IO is complete once it has
> >> reached all the non-writemostly devices. It works fine for single
> >> queue devices.
> >>
> >> But for multiqueue device, if there are lots of IOs come from upper
> >> layer, then the write-behind device could issue those IOs to different
> >> queues, depends on the each queue's delay, so there is no guarantee
> >> that those IOs can arrive in order.
> >>
> >> To address the issue, we need to check the collision among write
> >> behind IOs, we can only continue without collision, otherwise wait
> >> for the completion of previous collisioned IO.
> >>
> >> And WBCollision is introduced for multiqueue device which is worked
> >> under write-behind mode.
> >>
> >> But this patch doesn't handle below cases which could have the data
> >> inconsistency issue as well, these cases will be handled in later
> >> patches.
> >>
> >> 1. modify max_write_behind by write backlog node.
> >> 2. add or remove array's bitmap dynamically.
> >> 3. the change of member disk.
> >>
> >> Reviewed-by: NeilBrown <neilb@suse.com>
> >> Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
> >
> > Applied to https://github.com/liu-song-6/linux/tree/md-next
> >
> > Thanks Guoqing!
> >
>
> Thanks Song! BTW, maybe you need to update the git tree information in
> MAINTAINER file, then people can track md tree well.

I am asking for a kernel.org repo. I will update it once that is done.

>
> And could you take a look at other 4 patches as well? Thanks.

Will do.

Thanks,
Song
