Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED97B05ED
	for <lists+linux-raid@lfdr.de>; Thu, 12 Sep 2019 01:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfIKXeU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Sep 2019 19:34:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37414 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfIKXeU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Sep 2019 19:34:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id g13so27094367qtj.4
        for <linux-raid@vger.kernel.org>; Wed, 11 Sep 2019 16:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMcovcgR+/IhOK0jLzR2k0qConsVQf6gyO4yGxeohZY=;
        b=uG6jy4GpVyG7qwmMcisjobBY9h71sPWwF54AkN1xAfvpKe1b8yme+piqzC/YTiIBdc
         hMBMBLwDB0MKv38OuBppITO09yP64eOtQAuNjGwYHHg49pOIxEHR6MT2pZXu7SA7tcst
         KXV1zPIhOtywUKPum826Dgk+iaKHsui1cu52HXPbJGKPKa6jxak4u+gBj7HCjMIKams/
         Ou1WXt2FvzwHU32Y8lHFwsK3AXm+ra0IzS3+Hv95lMU1AZGsNn4BqHGSMUHmtSnWI7o7
         kt+hhfZXhY4kFKNMHOMhYwcuVIOAo1QrA1Engan0XzWwD5OWC9EgyP9MglTs9a2hjZcd
         r5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMcovcgR+/IhOK0jLzR2k0qConsVQf6gyO4yGxeohZY=;
        b=awtFRMBnzX6LP9vByIT5a6xeMqSVyLOIU+AqfCYW1WEDdaD4OSSaWZBEEm1YTxm9dM
         +TFBYYy7xpFod130CSj2IJzOYnL8bzg8+9CXSiyd5+EBEDhaTnEgXhn8fg3AqPg0DaFP
         gxS0qblpXlbhV1F+JpoNHcldPk176OXISYMq6/9me8Uda5/UwR8TOu5TnPsIxqd+iMCv
         p1vqM34SG7X9GnSZRQ5S8s6fdRXcZyNtqKP3ZfhCHvjifml8SVa5E8nyWbiSQXJVJuCf
         M1VI3jlyyVqAec59K59MXpXFU/8wxtNAGgRa7yBb53m3oIdLGk1N7nJSvLYU7ZgjdSMt
         4xdA==
X-Gm-Message-State: APjAAAVYRbYRtoAQ9QO27TSI/y6XLEGwirGyS1gQGB/hmF7lNCUQ/jZc
        j2tx+nZVZZW2sRSmiVr6X8h9vFCn0rAX+D/ql0Q=
X-Google-Smtp-Source: APXvYqzXDmUyFPEN5rQP2oEdo5OXkcjCtErph+1kN9ggI3y7ueoL4Dhlp7Y5ujxWI3rQCbLWtCDqhJQg+GPvDeovwvA=
X-Received: by 2002:ac8:4787:: with SMTP id k7mr37404000qtq.58.1568244859184;
 Wed, 11 Sep 2019 16:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190902071623.21388-1-yuyufen@huawei.com> <CAPhsuW5f+ai26=6op9Jbud_9U=w-VGHGv0suSu1C=oZ8sJ9S1g@mail.gmail.com>
In-Reply-To: <CAPhsuW5f+ai26=6op9Jbud_9U=w-VGHGv0suSu1C=oZ8sJ9S1g@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 12 Sep 2019 00:34:07 +0100
Message-ID: <CAPhsuW4s2Er6jJ=13ghQPa34_KbPnP76U_-6p+Qb6o-WCeqsvg@mail.gmail.com>
Subject: Re: [PATCH] md: no longer compare spare disk superblock events in super_load
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>, neilb@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Sep 12, 2019 at 12:04 AM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Mon, Sep 2, 2019 at 8:04 AM Yufen Yu <yuyufen@huawei.com> wrote:
> >
> > We have a test case as follow:
> >
> >   mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] --assume-clean --bitmap=internal
> >   mdadm -S /dev/md1
> >   mdadm -A /dev/md1 /dev/sd[b-c] --run --force
> >
> >   mdadm --zero /dev/sda
> >   mdadm /dev/md1 -a /dev/sda
> >
> >   echo offline > /sys/block/sdc/device/state
> >   echo offline > /sys/block/sdb/device/state
> >   sleep 5
> >   mdadm -S /dev/md1
> >
> >   echo running > /sys/block/sdb/device/state
> >   echo running > /sys/block/sdc/device/state
> >   mdadm -A /dev/md1 /dev/sd[a-c] --run --force
> >
> > When we readd /dev/sda to the array, it started to do recovery.
> > After offline the other two disks in md1, the recovery have
> > been interrupted and superblock update info cannot be written
> > to the offline disks. While the spare disk (/dev/sda) can continue
> > to update superblock info.
> >
> > After stopping the array and assemble it, we found the array
> > run fail, with the follow kernel message:
> >
> > [  172.986064] md: kicking non-fresh sdb from array!
> > [  173.004210] md: kicking non-fresh sdc from array!
> > [  173.022383] md/raid1:md1: active with 0 out of 4 mirrors
> > [  173.022406] md1: failed to create bitmap (-5)
> > [  173.023466] md: md1 stopped.
> >
> > Since both sdb and sdc have the value of 'sb->events' smaller than
> > that in sda, they have been kicked from the array. However, the only
> > remained disk sda is in 'spare' state before stop and it cannot be
> > added to conf->mirrors[] array. In the end, raid array assemble and run fail.
> >
> > In fact, we can use the older disk sdb or sdc to assemble the array.
> > That means we should not choose the 'spare' disk as the fresh disk in
> > analyze_sbs().
> >
> > To fix the problem, we do not compare superblock events when it is
> > a spare disk, as same as validate_super.
> >
> > Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> > ---
> >  drivers/md/md.c | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 24638ccedce4..350e1f152e97 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -1092,7 +1092,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
> >  {
> >         char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
> >         mdp_super_t *sb;
> > -       int ret;
> > +       int ret = 0;
> >
> >         /*
> >          * Calculate the position of the superblock (512byte sectors),
> > @@ -1160,10 +1160,13 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
> >                 }
> >                 ev1 = md_event(sb);
> >                 ev2 = md_event(refsb);
> > -               if (ev1 > ev2)
> > -                       ret = 1;
> > -               else
> > -                       ret = 0;
> > +
> > +               /* Insist on good event counter while assembling, except
> > +                * for spares (which don't need an event count) */
> > +               if (sb->disks[rdev->desc_nr].state & (
> > +                       (1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
>
> Can we just check 1<<MD_DISK_ACTIVE? I think MD_DISK_SYNC is not
> necessary.
>
> > +                       if (ev1 > ev2)
> > +                               ret = 1;
> >         }
> >         rdev->sectors = rdev->sb_start;
> >         /* Limit to 4TB as metadata cannot record more than that.
> > @@ -1513,7 +1516,7 @@ static __le32 calc_sb_1_csum(struct mdp_superblock_1 *sb)
> >  static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_version)
> >  {
> >         struct mdp_superblock_1 *sb;
> > -       int ret;
> > +       int ret = 0;
> >         sector_t sb_start;
> >         sector_t sectors;
> >         char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
> > @@ -1665,10 +1668,14 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
> >                 ev1 = le64_to_cpu(sb->events);
> >                 ev2 = le64_to_cpu(refsb->events);
> >
> > -               if (ev1 > ev2)
> > -                       ret = 1;
> > -               else
> > -                       ret = 0;
> > +               /* Insist of good event counter while assembling, except for
> > +                * spares (which don't need an event count) */
> > +               if (rdev->desc_nr >= 0 &&
> > +                   rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
> > +                   (le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
> > +                    le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
>
> Can we use MD_DISK_ROLE_SPARE in this check?

Actually, this check is good. No need to fix. Sorry for the confusion.

Thanks,
Song
