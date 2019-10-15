Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B59D7AE9
	for <lists+linux-raid@lfdr.de>; Tue, 15 Oct 2019 18:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfJOQNg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Oct 2019 12:13:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37566 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJOQNg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 15 Oct 2019 12:13:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id n17so11991406qtr.4
        for <linux-raid@vger.kernel.org>; Tue, 15 Oct 2019 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+rlfg+JZQr8NtaqFXy0/un/bIQAqAc4AkQ7wHZCKrs=;
        b=kAYTgv9qxe4acn5ZzCLSEVfDfyw/LKC+v8xgxTr+wvsOMDlmbLoI4XhfpTJfb5ku2J
         apyWMyr7DDbuc/LP5ov749M3tdSUu5kVDWQuXge6/ymH3x8AZNYuMhnJAYngvs92jN0y
         WgyYsdBg/SxxeP08oIU5TEzJrUNWBKfogA6oHWHwBVeKYUvSkLZ5spXEIxXSUY9uv5YY
         IzjjvBCB4mHUaUwCV5GbgcKo20EUyVLJpRWzcS3iCsrJu4YqpVJ2SU4QC92ELVvhG/0L
         iZobfVzNuwsGWFDbBD3bDJ8aUwEUrToj4zxuQsueYzD3o4VEL/0CaTK6KRdIVrbf9u0M
         g7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+rlfg+JZQr8NtaqFXy0/un/bIQAqAc4AkQ7wHZCKrs=;
        b=hxc1026E7pmQr1mPAGdrK8pWMQjy8sCbGkt9jqOvy/nUP6hOOxTGhuZuxByDXJTCEw
         WR1Z0KbDnYKok5V2cG/5QIZbrYbOVP0exuBvFgmyA9U4HusZzmwtzHahCLLy2rNqCeTI
         Zf5b2HKDQaSfPP09rji9r1fKeGTau0qEaGYfmbtJ1wE0bqT0ZlgNwIEzeGl24Y3oFtDU
         NBmwYsugqlNIjQ6fgbe3l7fyBFcjRNC4vo3mEgj+Tu+75//2WCk1bjSzJ8BiQtXabBT6
         EWZpZAlEGfdF3PjAL/27uT3FwFKxFAmaCNjGlq99PWmU1N6EQTUncaCk/oSatlweyQnB
         Da9w==
X-Gm-Message-State: APjAAAVD5OQ4N4/mHyEKSq3q19fCbO1losWnVsmOodD4rlNdpXAV/9XV
        lBnzrQPPrKjOrlsU0is22Hk2aYCdiOc4vKNKVgw=
X-Google-Smtp-Source: APXvYqwIV28ZDchUTp7WBhLO86RmHrEGrZbc5FpCYa+VCwse60k/LNdJ6V31hM4Hioh9novU8mMOCzC9C0EODjKUpC4=
X-Received: by 2002:ac8:f86:: with SMTP id b6mr39317002qtk.308.1571156014727;
 Tue, 15 Oct 2019 09:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191015030230.13642-1-yuyufen@huawei.com>
In-Reply-To: <20191015030230.13642-1-yuyufen@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 15 Oct 2019 09:13:22 -0700
Message-ID: <CAPhsuW5hF-SkCX4n7dJnZfEwFnTF=egjwCOJxt695Fuh6L8K3A@mail.gmail.com>
Subject: Re: [PATCH v3] md: no longer compare spare disk superblock events in super_load
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Oct 14, 2019 at 10:35 PM Yufen Yu <yuyufen@huawei.com> wrote:
>
> We have a test case as follow:
>
>   mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] \
>         --assume-clean --bitmap=internal
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
> added to conf->mirrors[] array. In the end, raid array assemble
> and run fail.
>
> In fact, we can use the older disk sdb or sdc to assemble the array.
> That means we should not choose the 'spare' disk as the fresh disk in
> analyze_sbs().
>
> To fix the problem, we do not compare superblock events when it is
> a spare disk, as same as validate_super.
>
> Cc: <stable@vger.kernel.org>

I don't think we need to cc stable here, as this is not a critical fix.

> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>
> v1->v2:
>   fix wrong return value in super_90_load
> v2->v3:
>   adjust the patch format to avoid scripts/checkpatch.pl warning
> ---
>  drivers/md/md.c | 51 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 1be7abeb24fd..1be1deca3e3a 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1097,7 +1097,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>  {
>         char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
>         mdp_super_t *sb;
> -       int ret;
> +       int ret = 0;
>
>         /*
>          * Calculate the position of the superblock (512byte sectors),
> @@ -1111,14 +1111,12 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>         if (ret)
>                 return ret;
>
> -       ret = -EINVAL;
> -

I think ret is handled correctly in existing code. I would not recommend this
type of refactoring.

>         bdevname(rdev->bdev, b);
>         sb = page_address(rdev->sb_page);
>
>         if (sb->md_magic != MD_SB_MAGIC) {
>                 pr_warn("md: invalid raid superblock magic on %s\n", b);
> -               goto abort;
> +               return -EINVAL;
>         }
>
>         if (sb->major_version != 0 ||
> @@ -1126,15 +1124,15 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>             sb->minor_version > 91) {
>                 pr_warn("Bad version number %d.%d on %s\n",
>                         sb->major_version, sb->minor_version, b);
> -               goto abort;
> +               return -EINVAL;
>         }
>
>         if (sb->raid_disks <= 0)
> -               goto abort;
> +               return -EINVAL;
>
>         if (md_csum_fold(calc_sb_csum(sb)) != md_csum_fold(sb->sb_csum)) {
>                 pr_warn("md: invalid superblock checksum on %s\n", b);
> -               goto abort;
> +               return -EINVAL;
>         }
>
>         rdev->preferred_minor = sb->md_minor;
> @@ -1156,19 +1154,24 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>                 if (!md_uuid_equal(refsb, sb)) {
>                         pr_warn("md: %s has different UUID to %s\n",
>                                 b, bdevname(refdev->bdev,b2));
> -                       goto abort;
> +                       return -EINVAL;
>                 }
>                 if (!md_sb_equal(refsb, sb)) {
>                         pr_warn("md: %s has same UUID but different superblock to %s\n",
>                                 b, bdevname(refdev->bdev, b2));
> -                       goto abort;
> +                       return -EINVAL;
>                 }
>                 ev1 = md_event(sb);
>                 ev2 = md_event(refsb);
> -               if (ev1 > ev2)
> -                       ret = 1;
> -               else
> -                       ret = 0;
> +
> +               /*
> +                * Insist on good event counter while assembling, except
> +                * for spares (which don't need an event count)
> +                */
> +               if (sb->disks[rdev->desc_nr].state & (
> +                       (1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
> +                       if (ev1 > ev2)
> +                               ret = 1;

Just realized this:

If the first device being passed to load_super is a spare device, we still
have the same problem, no?

Thanks,
Song
