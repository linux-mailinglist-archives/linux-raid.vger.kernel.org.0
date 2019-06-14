Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7C046C1D
	for <lists+linux-raid@lfdr.de>; Fri, 14 Jun 2019 23:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfFNVtK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 17:49:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44109 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNVtJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 14 Jun 2019 17:49:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id p144so2632043qke.11
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fe8OPzK4ylgQUzfwAUgUMz7b7wA77H9y31KSA/LET1g=;
        b=nMnTxyrppx0wi2TdQxdUOh908SCG5F7hl08sudDkm+CIkWL5lp2OCJOHisGf7Sa4M8
         xu3IzskR5YReVsUIMN9qhhJfoWn6/w/xvOMOG7LZrKVJR428/t/19rDZttkD1hZlo7U0
         7sXZz9v1NS/yvQdU8LN6g5dJ53FjIxTYiUzjrzCSb5JAOIsa4bryOkPSsfPfzxL1g6Y5
         kKSBCOowRB7Y7ASRRyI59TMDXkE/lbF/Qn2XF40v7Q3xSoMmNOvIg5F6LBXUep0BAdI0
         rYhLU+NTs624RrdJ5Kl39vm2AvX0ucseVgEFcmPWRcy3JHOOk920pf2TdejkjcFWS1le
         EIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fe8OPzK4ylgQUzfwAUgUMz7b7wA77H9y31KSA/LET1g=;
        b=linIDAWCEN2IGfWPHjjdDVaEMKFm/5MIm2es+bSaU1KksZIryuyz4xNNIbBDbdbbxA
         p+XTSXZmWTp23NDzAkiBJdQ6da4YJ2dn7RGCxRQRhnjaAnKWV+ZxpHq5JeOECk4BSTgl
         ahif8HAxarDvIFl9KQzE4H/1TiPEbk4wKznp26shn2tqbTyTSyGtbhJPv8BaDVcjYK5U
         IQovku4Zx+ecWX3oL80/+XPbCRR4CXwzlrQ9dp+9LcjE4a69csH5/W5lIvWEDm693H00
         j1fGGJf/EmMm1J+hhmB/Ry8eFDykU4mLUqGP04+lTuHf5Jsa1Mezg6fT8NF/fflSjufR
         pDfg==
X-Gm-Message-State: APjAAAVlThSssDKT7f6UZJwUlhWkNg83zhxM68ytWrWk9AuhIw3kONML
        m84qjBgFMwKGt7WLNzxCpgh3LXHs6NBeoWMLq+E=
X-Google-Smtp-Source: APXvYqw+E/Hzez7wwyuIm662GJlLRq9qcsvQVt/KUJT18PnB79y3yMkZTdox730Z9AosbNSPAEf6mIzVEY2jDgxQzpM=
X-Received: by 2002:a37:c45:: with SMTP id 66mr60089617qkm.31.1560548948902;
 Fri, 14 Jun 2019 14:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190613141141.15483-1-mariusz.tkaczyk@intel.com>
In-Reply-To: <20190613141141.15483-1-mariusz.tkaczyk@intel.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 14 Jun 2019 14:48:57 -0700
Message-ID: <CAPhsuW7-LgfVi-ucTZCDEA0+4raQvNaHeWVJxBLcBDTLWLv8mA@mail.gmail.com>
Subject: Re: [PATCH] md: fix for divide error in status_resync
To:     Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jun 13, 2019 at 8:09 AM Mariusz Tkaczyk
<mariusz.tkaczyk@intel.com> wrote:
>
> Stopping external metadata arrays during resync/recovery causes
> retries, loop of interrupting and starting reconstruction, until it
> hit at good moment to stop completely. While these retries
> curr_mark_cnt can be small- especially on HDD drives, so subtraction
> result can be smaller than 0. However it is casted to uint without
> checking. As a result of it the status bar in /proc/mdstat while stopping
> is strange (it jumps between 0% and 99%).
>
> The real problem occurs here after commit 72deb455b5ec ("block: remove
> CONFIG_LBDAF"). Sector_div() macro has been changed, now the
> divisor is casted to uint32. For db = -8 the divisior(db/32-1) becomes 0.
>
> Check if db value can be really counted and replace these macro by
> div64_u64() inline.
>
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>

This looks good! Thanks for the fix.

> ---
>  drivers/md/md.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 04f4f131f9d6..9a8b258ce1ef 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7607,9 +7607,9 @@ static void status_unused(struct seq_file *seq)
>  static int status_resync(struct seq_file *seq, struct mddev *mddev)
>  {
>         sector_t max_sectors, resync, res;
> -       unsigned long dt, db;
> -       sector_t rt;
> -       int scale;
> +       unsigned long dt, db = 0;
> +       sector_t rt, curr_mark_cnt, resync_mark_cnt;
> +       int scale, recovery_active;
>         unsigned int per_milli;
>
>         if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||
> @@ -7709,11 +7709,16 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
>          */

Could you please also update comments before this section? (sector_t
is always u64 now).

Thanks,
Song

>         dt = ((jiffies - mddev->resync_mark) / HZ);
>         if (!dt) dt++;
> -       db = (mddev->curr_mark_cnt - atomic_read(&mddev->recovery_active))
> -               - mddev->resync_mark_cnt;
> +
> +       curr_mark_cnt = mddev->curr_mark_cnt;
> +       recovery_active = atomic_read(&mddev->recovery_active);
> +       resync_mark_cnt = mddev->resync_mark_cnt;
> +
> +       if (curr_mark_cnt >= (recovery_active + resync_mark_cnt))
> +               db = curr_mark_cnt - (recovery_active + resync_mark_cnt);
>
>         rt = max_sectors - resync;    /* number of remaining sectors */
> -       sector_div(rt, db/32+1);
> +       rt = div64_u64(rt, db/32+1);
>         rt *= dt;
>         rt >>= 5;
>
> --
> 2.16.4
>
