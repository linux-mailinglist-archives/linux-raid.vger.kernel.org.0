Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFBCF07FA
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 22:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfKEVOm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 16:14:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38382 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbfKEVOm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 Nov 2019 16:14:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id p20so12967341qtq.5
        for <linux-raid@vger.kernel.org>; Tue, 05 Nov 2019 13:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C80ad+6svXp0DS0DoHtoC1qZcQoGwsgkypayjqyc/pw=;
        b=cyt4s5l9f4sxowoXeRKW/N+wZair3qKtdvBiN5Obbgs2dT6OIaQpbXsWpO8xYhgGOr
         yyoRTxzc9y5AxSuksQ28A73RaqJKqBONqazLC2FDBt3pQoKFuhWgqsZ+48z84fD141lO
         NVKIS7GMomMfikAsBCjZIsrR0A24wZBgt3TF/ZlXM7AANR1UqCK9OgqNLQIcPOkohG6c
         CIcoBT5gP9qInYJZHrMP1EffFFBBwrMi7kQM0Qq+uO2nk3gBQnsUOPUNjqgFdq20inzy
         nszr/KcGCh8CFis0MsvDAh1TaPCd6qM5KrLequKx5lyYwjNuVKKuV9vVQ6Hue5TUQvi8
         lBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C80ad+6svXp0DS0DoHtoC1qZcQoGwsgkypayjqyc/pw=;
        b=qyKfs//PgWCZ4nDdJAjPs+L2sCxGGZt39Jjqn7ZA+WXD3MNvpM2mT5r/weJ/AGQDZu
         RCkPTcPgoUYmcafCDuiL8HG+DTqwC3PbXtEKKEOLJCsNW6MNTkf6SgfugAxnOysZuJhc
         WY2i6haHRGNbuav1FEwk+wXt4GdJt8pz98eptEGWqhKFzuc+mnmv1F0oaPCK0qBenkf+
         yIC0jRTA5WmKMqbcDcotwFic/2aAm9qTiPAERqh4XKCmqGQ+6/6ax/JJMryTknc8wCEy
         X2zRYyFWcfAB7/GoExhFMnD4oVFkQk+7o6nM8YaiWbIzmHFw/KsZKnsFkiUIZam22AzC
         nzbw==
X-Gm-Message-State: APjAAAWndbLfpQkkKTN0+aMbQxY/51obW/L/eZtzQvOUw9rMPWBzxN+N
        KjHP5CWjkCqysgePYbN8kZHsMy4mecuXeC316wo=
X-Google-Smtp-Source: APXvYqxOlfwt0LdIkk8yPAy84Oc0oxYEgKPYGJaxMpunB7Motcx/X2kP/6iCN7PtAiLNkC+JFPx8vybtR3Ip9YItRc4=
X-Received: by 2002:ac8:2f45:: with SMTP id k5mr19777659qta.183.1572988480854;
 Tue, 05 Nov 2019 13:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20191104200157.31656-1-ncroxon@redhat.com>
In-Reply-To: <20191104200157.31656-1-ncroxon@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 5 Nov 2019 13:14:30 -0800
Message-ID: <CAPhsuW7J-3ewXRvB9H1m44L_sVnuKBGTLcuRiKKN4YLRNivxtQ@mail.gmail.com>
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Nigel Croxon <ncroxon@redhat.com>,
        Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Nov 4, 2019 at 12:02 PM Nigel Croxon <ncroxon@redhat.com> wrote:
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
>
> The user can enable/disable this functionality by the following
> commands:
> To Enable:
> echo 1 > /proc/sys/dev/raid/raid456_retry_read_error
>
> To Disable, type the following at anytime:
> echo 0 > /proc/sys/dev/raid/raid456_retry_read_error
>
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
> ---
>  drivers/md/md.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/md/md.h    |  3 +++
>  drivers/md/raid5.c |  3 ++-
>  3 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 6f0ecfe8eab2..75b8b0615328 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -125,6 +125,12 @@ static inline int speed_max(struct mddev *mddev)
>                 mddev->sync_speed_max : sysctl_speed_limit_max;
>  }
>
> +static int sysctl_raid456_retry_read_error = 0;
> +static inline void set_raid456_retry_re(struct mddev *mddev, int re)
> +{
> +       (re ? set_bit : clear_bit)(MD_RAID456_RETRY_RE, &mddev->flags);

Let's just keep this
if (re)
     set_bit(...);
else
     clear_bit(..);

> +}
> +
>  static int rdev_init_wb(struct md_rdev *rdev)
>  {
>         if (rdev->bdev->bd_queue->nr_hw_queues == 1)
> @@ -213,6 +219,13 @@ static struct ctl_table raid_table[] = {
>                 .mode           = S_IRUGO|S_IWUSR,
>                 .proc_handler   = proc_dointvec,
>         },
> +       {
> +               .procname       = "raid456_retry_read_error",
> +               .data           = &sysctl_raid456_retry_read_error,
> +               .maxlen         = sizeof(int),
> +               .mode           = S_IRUGO|S_IWUSR,
> +               .proc_handler   = proc_dointvec,
> +       },
>         { }
>  };

How about we add this to md_redundancy_attrs instead?

Thanks,
Song
