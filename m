Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22A6104435
	for <lists+linux-raid@lfdr.de>; Wed, 20 Nov 2019 20:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfKTTWe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 20 Nov 2019 14:22:34 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34632 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfKTTWe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 20 Nov 2019 14:22:34 -0500
Received: by mail-qk1-f196.google.com with SMTP id b188so876047qkg.1
        for <linux-raid@vger.kernel.org>; Wed, 20 Nov 2019 11:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/rCqXwAwI31zuYry+y2TROKuf76K9dxa1/zd+MANWCo=;
        b=ZLbbug+aqxwvbjHK4BHhNAGZdxAv9HmZKuwAP6d9XdMvT1sehArD7r/1UMJhTno+FI
         go3aO1HLczSkTcRVpYs5YlDg1JeuiHZhUPI/MUnnIB6fEb4i+6UrQehc5AkrarhEDuxc
         qsWedPgz+BHe+GJtOKUbaMnUtDzR/xC78ZRb8HJIC2no+gi6+gaDRzw6IGsn5RWrryl0
         aMA5MsVnI3L3sVGNxUxybjaA1Puh9UOJL2WaYGHeqvJ8+EjM3kRCW19bCry6CT3G+K2b
         qqgmsaTaUaNtMjcwu68ElQAPqP3CBKbrkRIhha999wfL2K8B0rW8kfvsJTlQV+sQgEdn
         a16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/rCqXwAwI31zuYry+y2TROKuf76K9dxa1/zd+MANWCo=;
        b=fWqYoMhPx/pwiZd2j44PffwkiOUC0V79eEYjnRv7qKTvM2cpTUa2sAiuHNYuJEPHw2
         XhJvyvcIPCOFBeKmGh5OWkpkFotAFmuyXqAzADI5FtoSLzAhTBJh5d988j9Aj995HBgI
         AKlbrac3b/JXXyftJngGzlUw8aGcatagV68zeav8UHKzLgX5stH97Dr8ExyquFxai43y
         hARvy5J/we6VKK0DNBUDcS0P6hHUL2f8RYd1X0HDfSzpRzzgei7+o88ieg/8eYutp8Qs
         rMTAI4aqgmtNwuqB1/f7mhEBOxE+/l7eHxTJOcQBKym2P0ch2PX4HGQdQ/Xv9ttPCB4e
         /LKw==
X-Gm-Message-State: APjAAAWZoM7TK1gzVK4A2CxBU6l0Nn8TuoqZWAORkDXA21AMYN3Jq8nY
        /POKHGOPDrKbtoql3VUdVQmiJMJmqY/BX++p4aM=
X-Google-Smtp-Source: APXvYqx5pUGPomiGKxOfr9DMZ01sifz6JcMZ8SpmZQ1us/MLn9wBpKw4TUfos6i7uqon8tTj2B3d/6cqUWo40u7acig=
X-Received: by 2002:ae9:de07:: with SMTP id s7mr3833919qkf.89.1574277751302;
 Wed, 20 Nov 2019 11:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20191120162935.9617-1-ncroxon@redhat.com>
In-Reply-To: <20191120162935.9617-1-ncroxon@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 20 Nov 2019 11:22:20 -0800
Message-ID: <CAPhsuW4H-0R20M382uH--rvCoH1kjP-WmtkeiCM0P0F3k2Ozhg@mail.gmail.com>
Subject: Re: [PATCH V2] raid5: avoid second retry of read-error
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Nov 20, 2019 at 8:29 AM Nigel Croxon <ncroxon@redhat.com> wrote:
>
> The MD driver for level-456 should prevent re-reading read errors.
>
> For redundant raid it makes no sense to retry the operation:
> When one of the disks in the array hits a read error, that will
> cause a stall for the reading process:
> - either the read succeeds (e.g. after 4 seconds the HDD error
> strategy could read the sector)
> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
> seconds (might be even longer)

I am ok with the idea. But we need to be more careful.

>
> The user can enable/disable this functionality by the following
> commands:
> To Enable:
> echo 1 > /proc/sys/dev/raid/raid456_retry_read_error
>
> To Disable, type the following at anytime:
> echo 0 > /proc/sys/dev/raid/raid456_retry_read_error
>
> Version 2:
> * Renamed *raid456* to *raid5*.
> * Changed set_raid5_retry_re routine to use 'if-then' to make cleaner.
> * Added set_bit R5_ReadError in retry_aligned_read routine.
>
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
> ---
>  drivers/md/md.c    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/md/md.h    |  3 +++
>  drivers/md/raid5.c |  4 +++-
>  3 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 1be7abeb24fd..6f47489e0b23 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -125,6 +125,15 @@ static inline int speed_max(struct mddev *mddev)
>                 mddev->sync_speed_max : sysctl_speed_limit_max;
>  }
>
> +static int sysctl_raid5_retry_read_error = 0;

I don't think we need the sysctl. Per device knob should be sufficient.

> +static inline void set_raid5_retry_re(struct mddev *mddev, int re)
> +{
> +       if (re)
> +               set_bit(MD_RAID5_RETRY_RE, &mddev->flags);
> +       else
> +               clear_bit(MD_RAID5_RETRY_RE, &mddev->flags);
> +}
> +
>  static int rdev_init_wb(struct md_rdev *rdev)
>  {
>         if (rdev->bdev->bd_queue->nr_hw_queues == 1)
> @@ -213,6 +222,13 @@ static struct ctl_table raid_table[] = {
>                 .mode           = S_IRUGO|S_IWUSR,
>                 .proc_handler   = proc_dointvec,
>         },
> +       {
> +               .procname       = "raid5_retry_read_error",
> +               .data           = &sysctl_raid5_retry_read_error,
> +               .maxlen         = sizeof(int),
> +               .mode           = S_IRUGO|S_IWUSR,
> +               .proc_handler   = proc_dointvec,
> +       },
>         { }
>  };
>
> @@ -4721,6 +4737,32 @@ mismatch_cnt_show(struct mddev *mddev, char *page)
>
>  static struct md_sysfs_entry md_mismatches = __ATTR_RO(mismatch_cnt);
>
> +static ssize_t
> +raid5_retry_re_show(struct mddev *mddev, char *page)
> +{
> +       return sprintf(page, "RAID456 retry Read Error = %u\n",
> +                      test_bit(MD_RAID5_RETRY_RE, &mddev->flags));
> +}
> +
> +static ssize_t raid5_retry_re_store(struct mddev *mddev, const char *buf, size_t len)
> +{
> +       int retry;
> +
> +       if (!mddev->private)
> +               return -ENODEV;
> +
> +       if (len > 1 ||
> +           kstrtoint(buf, 10, &retry) ||
> +           retry < 0 || retry > 1)
> +               return -EINVAL;
> +
> +       set_raid5_retry_re(mddev, retry);
> +       return len;
> +}
> +
> +static struct md_sysfs_entry md_raid5_retry_read_error =
> +__ATTR(raid5_retry_read_error, S_IRUGO|S_IWUSR, raid5_retry_re_show, raid5_retry_re_store);
> +
>  static ssize_t
>  sync_min_show(struct mddev *mddev, char *page)
>  {
> @@ -5272,6 +5314,7 @@ static struct attribute *md_redundancy_attrs[] = {
>         &md_suspend_hi.attr,
>         &md_bitmap.attr,
>         &md_degraded.attr,
> +       &md_raid5_retry_read_error.attr,
>         NULL,
>  };
>  static struct attribute_group md_redundancy_group = {
> @@ -5833,6 +5876,8 @@ static int do_md_run(struct mddev *mddev)
>         if (mddev_is_clustered(mddev))
>                 md_allow_write(mddev);
>
> +       set_raid5_retry_re(mddev, sysctl_raid5_retry_read_error);
> +
>         /* run start up tasks that require md_thread */
>         md_start(mddev);
>
> @@ -8411,6 +8456,7 @@ void md_do_sync(struct md_thread *thread)
>         else
>                 desc = "recovery";
>
> +       set_raid5_retry_re(mddev, sysctl_raid5_retry_read_error);
>         mddev->last_sync_action = action ?: desc;
>
>         /* we overload curr_resync somewhat here.
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index c5e3ff398b59..6703a7d0b633 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -254,6 +254,9 @@ enum mddev_flags {
>         MD_BROKEN,              /* This is used in RAID-0/LINEAR only, to stop
>                                  * I/O in case an array member is gone/failed.
>                                  */
> +       MD_RAID5_RETRY_RE,      /* allow user-space to request RAID456
> +                                * retry read errors
> +                                */

The use of "RE" and "re" is not clear. Let's just keep full name like
*retry_read.

Also, please keep the default as "do retry". So it is the same behavior as
older kernels.

>  };
>
>  enum mddev_sb_flags {
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 223e97ab27e6..0b627fface78 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -2567,7 +2567,8 @@ static void raid5_end_read_request(struct bio * bi)
>                 if (retry)

Can we include checks for MD_RAID5_RETRY_RE in the logic to decide whether
to do "retry = 1"? I think that will keep the logic cleaner.

>                         if (sh->qd_idx >= 0 && sh->pd_idx == i)
>                                 set_bit(R5_ReadError, &sh->dev[i].flags);
> -                       else if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) {
> +                       else if ((test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) ||
> +                             (test_bit(MD_RAID5_RETRY_RE, &conf->mddev->flags))) {
>                                 set_bit(R5_ReadError, &sh->dev[i].flags);
>                                 clear_bit(R5_ReadNoMerge, &sh->dev[i].flags);
>                         } else
> @@ -6163,6 +6164,7 @@ static int  retry_aligned_read(struct r5conf *conf, struct bio *raid_bio,
>                 }
>
>                 set_bit(R5_ReadNoMerge, &sh->dev[dd_idx].flags);
> +               set_bit(R5_ReadError, &sh->dev[dd_idx].flags);

Do we need this w/ and w/o MD_RAID5_RETRY_RE?
