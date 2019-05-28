Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8572CC0C
	for <lists+linux-raid@lfdr.de>; Tue, 28 May 2019 18:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE1Qcs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 May 2019 12:32:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43073 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfE1Qcs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 May 2019 12:32:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so796939qka.10
        for <linux-raid@vger.kernel.org>; Tue, 28 May 2019 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrsvr74sBqMY5nWQcLG5/uXJx9J3jweOmlDXCopchGI=;
        b=UYYTrB5GkipmZcpq7w7zpAAr0RSr32zcsrpksbViQ6CaNXKfjUxMwptsrYpNJXVf4F
         TQdb4MhEe2NjKKfcLKKOFo/RBdnSYIJ9jlK17O9fDV9M6rSdv21JFqmMVyu25zNqK0pY
         gJPusy5C1IXNRfe2+iU7l0KGthBLEtKzZixXxH5hSytgdNioJcjfwO2g0vocBSk2/7hO
         t54dWXXa5kk3100/bpZ9+yBOYs/io4VonPMXoFY+sIG8g74UO50FMMenJjIHsal5SRFz
         vKzqRSNvSwd94NXNKNMdUht92NjQSFk+wkG7ULgeul8xsXaSeL7lTGNCjivd/qBrCURL
         C0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrsvr74sBqMY5nWQcLG5/uXJx9J3jweOmlDXCopchGI=;
        b=Lvz/bmtKCfgZhB4qicBiT8IrdtM/f1i6FK6vXp2mDTSlNZ91NyewRWS1KytP36QVTc
         SnsXE9XZAKwraMR6NVZa/M4AAubL54tR7Wl9YMvR9b4+IMjRgzk8xScqGXmrCoUDr7LJ
         4tFfXAhPhSUL1mjCqpCaGJ8iFzwzru1W9U0nfFvQdFDyKW5sDiLLAQqz1Sm4Vsu4j1+x
         1dlo5RbEVQshhjHo67U2y2E0TuTl+FWDW6DkuXeiA+yIviYCJ/w09355NWp7D8L0uuOR
         PF/KHNgd3NFBju4kPmymzA9sGs15n+CHLCJArANDAKLexIXQ2sC+zTc6ZUKSm/aYf5d3
         Lqqg==
X-Gm-Message-State: APjAAAW45D55ttHJXn7VmzxkNwCikANIHlD1OifB2ZT933Ul9ke4LOJz
        r9qia0dWBMNldyE61XUGwJ6XTOeDR0VIjZ3aP/k=
X-Google-Smtp-Source: APXvYqxldq+qqv5/4/D7MXvmGlQaJFNP1zVnUeFwvfBPHT+LfTbZ/gIx//4UuCtXy6neSMpDy8KVHrsaqM9VQWFjWGs=
X-Received: by 2002:a0c:bf4f:: with SMTP id b15mr1926633qvj.24.1559061167788;
 Tue, 28 May 2019 09:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <1559047314-8460-1-git-send-email-xni@redhat.com>
In-Reply-To: <1559047314-8460-1-git-send-email-xni@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 28 May 2019 09:32:36 -0700
Message-ID: <CAPhsuW4PvNx_MP=wSuD_ZGHFdgPF_bsNmDUP-d3VH171FDCoHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] raid5-cache: Need to do start() part job after adding
 journal device
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Michal Soltys <soltys@ziu.info>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, May 28, 2019 at 5:42 AM Xiao Ni <xni@redhat.com> wrote:
>
> In d5d885fd(md: introduce new personality funciton start()) it splits the init
> job to two parts. The first part run() does the jobs that do not require the
> md threads. The second part start() does the jobs that require the md threads.
>
> Now it just does run() in adding new journal device. It needs to do the second
> part start() too.
>
> Fixes: f6b6ec5cfac(raid5-cache: add journal hot add/remove support)
> Reported-by: Michal Soltys <soltys@ziu.info>
> Signed-off-by: Xiao Ni <xni@redhat.com>

Thanks Xiao!

I will process this fix.

Song

> ---
>  drivers/md/raid5.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 7fde645..0e52f1d 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7680,7 +7680,7 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>  static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>  {
>         struct r5conf *conf = mddev->private;
> -       int err = -EEXIST;
> +       int ret, err = -EEXIST;
>         int disk;
>         struct disk_info *p;
>         int first = 0;
> @@ -7695,7 +7695,14 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>                  * The array is in readonly mode if journal is missing, so no
>                  * write requests running. We should be safe
>                  */
> -               log_init(conf, rdev, false);
> +               ret = log_init(conf, rdev, false);
> +               if (ret)
> +                       return ret;
> +
> +               ret = r5l_start(conf->log);
> +               if (ret)
> +                       return ret;
> +
>                 return 0;
>         }
>         if (mddev->recovery_disabled == conf->recovery_disabled)
> --
> 2.7.5
>
