Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96775A75AB
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 22:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfICUwi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 16:52:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46249 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfICUwi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 16:52:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id v11so828041qto.13
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qv5DBvzJclWf1sGwRpXpHmjZdp8k7G1ivBkLrGwGkUc=;
        b=otnNTQXXwhcoM6/sBv7yLGx8QHIX2c4XuHV6RcVL8PijDQAeJIHNAkZYuwVgNU31KR
         hKyOb8oZ5+NWG1j5wNOA2gXjJrQ8xTnz69cyc3Tsgnxtm3c6XZjFUz0akSYbO1GTBwar
         65ccsGfHW3+BmQwgAhbcC0kuJjzQ38IdvDC9pTJhIg4EoB3iXtFq4lC6iF4McAlsZAM1
         R0ooGAwdXZmL8ADLC2W0UBTaqxuwuIw1P+QQ9Ln0NpSvTfwLy+E3DTw7Q8qF/9l8ObBq
         3tDeOsjji9kruCbE1bNLaGXWzUyaXfBkoc/7QfmlN3ZjfpUIl4CiBu/pNIl5xR9Zwa7O
         p79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qv5DBvzJclWf1sGwRpXpHmjZdp8k7G1ivBkLrGwGkUc=;
        b=kFVgcKjxDQhBhtSMMxpIGXEVao6jv6QegXDAzfUH/tULrBbCUwnBA5WGbRUeK3rBW4
         A94+rDkSb5Da+DNmaWFP5zv9rlR6cWslvTq0hBMGzPAHox/SY0JEzCQiypfxaqjWW/FN
         DcYAYz87ypbT9/zg2BziUbQ8zGvVB4TmN1ihDLn50GIZ3D0PQp9datY3/kEPruD55kRN
         67qzV7B44lvm/r++gxcZVxNA8kAf7ZUODSIZVYCk8GHmm8jFC0UYx1yLoumiJK9VDHoU
         G/oGhmNoZbL6B0SPUxC/0vM6w70c8besEt2rD+uPzd/Crkux4ChmhU+4U+giIXQZD1qO
         rdhQ==
X-Gm-Message-State: APjAAAXHJs/0iSG9yKJal7/2To4jf6PkUYMMQf+L0v+NlTFfW72smyNl
        3h2JBoR9X3UX2lucVOITEosskeeMDcmo9ftAvVA=
X-Google-Smtp-Source: APXvYqxJbVA4b7f5G7AAdxq2HQ45bSawAFuVbHEru9EEqYqSL9rxM93zrIH11QuWC79hKUYqUPfZbXblIVVOLg9N8Ak=
X-Received: by 2002:ac8:3021:: with SMTP id f30mr29902069qte.193.1567543957020;
 Tue, 03 Sep 2019 13:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190902071623.21388-1-yuyufen@huawei.com>
In-Reply-To: <20190902071623.21388-1-yuyufen@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 3 Sep 2019 13:52:25 -0700
Message-ID: <CAPhsuW6DsR3qJg5M81UZQCoXCENfZ_b-q8h5G4QBPn9fbitudQ@mail.gmail.com>
Subject: Re: [PATCH] md: no longer compare spare disk superblock events in super_load
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>, neilb@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Sep 2, 2019 at 12:04 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
> We have a test case as follow:
>
>   mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] --assume-clean --bitmap=internal
>   mdadm -S /dev/md1
>   mdadm -A /dev/md1 /dev/sd[b-c] --run --force
>
>   mdadm --zero /dev/sda
>   mdadm /dev/md1 -a /dev/sda
>
>   echo offline > /sys/block/sdc/device/state
>   echo offline > /sys/block/sdb/device/state
>   sleep 5
>   mdadm -S /dev/md1
>
>   echo running > /sys/block/sdb/device/state
>   echo running > /sys/block/sdc/device/state
>   mdadm -A /dev/md1 /dev/sd[a-c] --run --force
>
> When we readd /dev/sda to the array, it started to do recovery.
> After offline the other two disks in md1, the recovery have
> been interrupted and superblock update info cannot be written
> to the offline disks. While the spare disk (/dev/sda) can continue
> to update superblock info.
>
> After stopping the array and assemble it, we found the array
> run fail, with the follow kernel message:
>
> [  172.986064] md: kicking non-fresh sdb from array!
> [  173.004210] md: kicking non-fresh sdc from array!
> [  173.022383] md/raid1:md1: active with 0 out of 4 mirrors
> [  173.022406] md1: failed to create bitmap (-5)
> [  173.023466] md: md1 stopped.
>
> Since both sdb and sdc have the value of 'sb->events' smaller than
> that in sda, they have been kicked from the array. However, the only
> remained disk sda is in 'spare' state before stop and it cannot be
> added to conf->mirrors[] array. In the end, raid array assemble and run fail.
>
> In fact, we can use the older disk sdb or sdc to assemble the array.
> That means we should not choose the 'spare' disk as the fresh disk in
> analyze_sbs().
>
> To fix the problem, we do not compare superblock events when it is
> a spare disk, as same as validate_super.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  drivers/md/md.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 24638ccedce4..350e1f152e97 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1092,7 +1092,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>  {
>         char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
>         mdp_super_t *sb;
> -       int ret;
> +       int ret = 0;
>
>         /*
>          * Calculate the position of the superblock (512byte sectors),
> @@ -1160,10 +1160,13 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>                 }
>                 ev1 = md_event(sb);
>                 ev2 = md_event(refsb);
> -               if (ev1 > ev2)
> -                       ret = 1;
> -               else
> -                       ret = 0;
> +
> +               /* Insist on good event counter while assembling, except
> +                * for spares (which don't need an event count) */
> +               if (sb->disks[rdev->desc_nr].state & (
> +                       (1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
> +                       if (ev1 > ev2)
> +                               ret = 1;

Instead of skipping the test, I guess we should make sure refsb passes
a non-spare sb?
In other words, we should fix the refdev of the super_*_load function.

Does this make sense?

Thanks,
Song
