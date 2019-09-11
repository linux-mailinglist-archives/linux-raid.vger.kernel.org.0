Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8BB05D7
	for <lists+linux-raid@lfdr.de>; Thu, 12 Sep 2019 01:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfIKXE0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Sep 2019 19:04:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38054 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfIKXE0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Sep 2019 19:04:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id x5so22577758qkh.5
        for <linux-raid@vger.kernel.org>; Wed, 11 Sep 2019 16:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xaj/u99mrBv2SBExEK7NMyJ4bi+MELOAg4QNW+VTDlI=;
        b=fbOTtfCDznFMXLPX1VlsOO9CiCIjqEq1wbLkSUvZ2P/pDUDhm4KXvJmw9AJnXmkx1j
         IMOI9tIXObFuvFEFaqPJeWlt/OTpvPZNtGozXo6p6MwLHCmmGoznx2TL10L6tDwQzWGB
         8EswHOMR6A+2t2BhAsrPSjZfr1X33QsdWHoZqvki1iM6hJumRKKo8ze3WqaSmrGPyPeR
         lHXYXRfBiFq/7RrEZtO4NSKeMcK7Xj63urUCuQsXy2wxIQqUmoi9/YDmu0bfF4l9f0M3
         gsBrax0GiKYJfxftZwG0z9k2/o2h0LNvxkYDwcgGhphAW7ur8gGsAe2T8NyvkqNmnCNf
         5Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xaj/u99mrBv2SBExEK7NMyJ4bi+MELOAg4QNW+VTDlI=;
        b=QXGsYTMpZYfYispypDOSOCRbYYJN40qXozXvYxsvBFjb7PpB+ck3/t/rxGFHN8/HAZ
         FJhywBWWRXqdFwThegzhrqtsp5Wfbm2HXm5ak/5LQtfnN978f5dbDUWpZ4Ai8wuK/aPG
         jsxyJe5UJuixBSDjNajfpZQDDsT+LzBDs2BHShIm4ryUiygSAyG0zwmDhmOkP9QhUfeW
         p+1yfM8l6mFN0trOd30CEO8F+RqxhaC3QL/+/7TNWuhQufqbv3nE1k4JzvDoCSQu7Og/
         4ISve23rbdtHyH2uJm1yk3Zv+P0Gmh3TtOg5Aj+dyRXITDjORazbO6yeBI07uBqBKtYn
         xRnA==
X-Gm-Message-State: APjAAAXSio/5j0D+QL19f5HfDWEjp+BqLhvzGk7l1MjVXxcdHFTbbMoG
        5U3flkCtMI2VITQkW/dnz6d//n9D16P+MxlTrARP+pfw+Uk=
X-Google-Smtp-Source: APXvYqwIM0I0ITQGAkvKcl7pOc5LbaVxc6AKpws4NdxidSK2eUI/XIrPotl+6a81nXpbUNVskyoMpUeRQIDMmVGQviA=
X-Received: by 2002:a37:aac9:: with SMTP id t192mr37813725qke.31.1568243064393;
 Wed, 11 Sep 2019 16:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190902071623.21388-1-yuyufen@huawei.com>
In-Reply-To: <20190902071623.21388-1-yuyufen@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 12 Sep 2019 00:04:13 +0100
Message-ID: <CAPhsuW5f+ai26=6op9Jbud_9U=w-VGHGv0suSu1C=oZ8sJ9S1g@mail.gmail.com>
Subject: Re: [PATCH] md: no longer compare spare disk superblock events in super_load
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>, neilb@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Sep 2, 2019 at 8:04 AM Yufen Yu <yuyufen@huawei.com> wrote:
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

Can we just check 1<<MD_DISK_ACTIVE? I think MD_DISK_SYNC is not
necessary.

> +                       if (ev1 > ev2)
> +                               ret = 1;
>         }
>         rdev->sectors = rdev->sb_start;
>         /* Limit to 4TB as metadata cannot record more than that.
> @@ -1513,7 +1516,7 @@ static __le32 calc_sb_1_csum(struct mdp_superblock_1 *sb)
>  static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_version)
>  {
>         struct mdp_superblock_1 *sb;
> -       int ret;
> +       int ret = 0;
>         sector_t sb_start;
>         sector_t sectors;
>         char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
> @@ -1665,10 +1668,14 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
>                 ev1 = le64_to_cpu(sb->events);
>                 ev2 = le64_to_cpu(refsb->events);
>
> -               if (ev1 > ev2)
> -                       ret = 1;
> -               else
> -                       ret = 0;
> +               /* Insist of good event counter while assembling, except for
> +                * spares (which don't need an event count) */
> +               if (rdev->desc_nr >= 0 &&
> +                   rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
> +                   (le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
> +                    le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))

Can we use MD_DISK_ROLE_SPARE in this check?

Thanks,
Song
