Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BC92A8D6A
	for <lists+linux-raid@lfdr.de>; Fri,  6 Nov 2020 04:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKFDOO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Nov 2020 22:14:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKFDON (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 5 Nov 2020 22:14:13 -0500
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A53320782;
        Fri,  6 Nov 2020 03:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604632452;
        bh=4s9wN5sYltzm93qPjOjO1EkZ8dZJ1hOwxY3nUD9iXrQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZqxhykIrGN/Uv5G0nzk9KKZlQwO/YD6SIfDIWF0udm129DiQ1FJpr5YCWH28kRnLH
         e8FzRR3UMmCTdMaYy8yo47V/Y/3FWX/79ulSH8HeglP2HgAmpBgshzcoudnjWN4t69
         hF7y0O9r/c+xQvQK55Y/6eGUALxXHjDt7od8Ugnk=
Received: by mail-lf1-f49.google.com with SMTP id s30so5367790lfc.4;
        Thu, 05 Nov 2020 19:14:12 -0800 (PST)
X-Gm-Message-State: AOAM531SkRIclnbEfKlqbgoVpjirFhlFVXB2UnHZ4huHDjsSP3fz3p6X
        Pvvh6iRBt9e3j1VpX2OBaeQ8L2cmQqkSdRrga5M=
X-Google-Smtp-Source: ABdhPJyB8jL8hXKt5P8rAti/jfGy0ODqbgbIZSXDMAFijBZrz71IYS19Y2iMkmFexPlwEortnyV0Av/K9E3AidjbXLw=
X-Received: by 2002:a19:4b45:: with SMTP id y66mr23234lfa.482.1604632450558;
 Thu, 05 Nov 2020 19:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20201022012128.GA2103465@dragonet>
In-Reply-To: <20201022012128.GA2103465@dragonet>
From:   Song Liu <song@kernel.org>
Date:   Thu, 5 Nov 2020 19:13:59 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5+Lq7_kMF_FvJA5adZL80UM7perFR3LxEmueLguJ=Lpw@mail.gmail.com>
Message-ID: <CAPhsuW5+Lq7_kMF_FvJA5adZL80UM7perFR3LxEmueLguJ=Lpw@mail.gmail.com>
Subject: Re: [PATCH] md: fix a warning caused by a race between concurrent md_ioctl()s
To:     "Dae R. Jeong" <dae.r.jeong@kaist.ac.kr>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, yjkwon@kaist.ac.kr
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Oct 21, 2020 at 6:21 PM Dae R. Jeong <dae.r.jeong@kaist.ac.kr> wrote:
>
> Syzkaller reports a warning as belows.
> WARNING: CPU: 0 PID: 9647 at drivers/md/md.c:7169
> ...
> Call Trace:
> ...
> RIP: 0010:md_ioctl+0x4017/0x5980 drivers/md/md.c:7169
> RSP: 0018:ffff888096027950 EFLAGS: 00010293
> RAX: ffff88809322c380 RBX: 0000000000000932 RCX: ffffffff84e266f2
> RDX: 0000000000000000 RSI: ffffffff84e299f7 RDI: 0000000000000007
> RBP: ffff888096027bc0 R08: ffff88809322c380 R09: ffffed101341a482
> R10: ffff888096027940 R11: ffff88809a0d240f R12: 0000000000000932
> R13: ffff8880a2c14100 R14: ffff88809a0d2268 R15: ffff88809a0d2408
>  __blkdev_driver_ioctl block/ioctl.c:304 [inline]
>  blkdev_ioctl+0xece/0x1c10 block/ioctl.c:606
>  block_ioctl+0xee/0x130 fs/block_dev.c:1930
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:509 [inline]
>  do_vfs_ioctl+0xd5f/0x1380 fs/ioctl.c:696
>  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
>  __do_sys_ioctl fs/ioctl.c:720 [inline]
>  __se_sys_ioctl fs/ioctl.c:718 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
>  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> This is caused by a race between two concurrenct md_ioctl()s closing
> the array.
> CPU1 (md_ioctl())                   CPU2 (md_ioctl())
> ------                              ------
> set_bit(MD_CLOSING, &mddev->flags);
> did_set_md_closing = true;
>                                     WARN_ON_ONCE(test_bit(MD_CLOSING,
>                                             &mddev->flags));
> if(did_set_md_closing)
>     clear_bit(MD_CLOSING, &mddev->flags);
>
> Fix the warning by returning immediately if the MD_CLOSING bit is set
> in &mddev->flags which indicates that the array is being closed.
>
> Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called md_set_readonly or do_md_stop")
> Reported-by: syzbot+1e46a0864c1a6e9bd3d8@syzkaller.appspotmail.com
> Signed-off-by: Dae R. Jeong <dae.r.jeong@kaist.ac.kr>

Applied to md-next. Thanks!


> ---
>  drivers/md/md.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 98bac4f304ae..643f7f5be49b 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7590,8 +7590,11 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
>                         err = -EBUSY;
>                         goto out;
>                 }
> -               WARN_ON_ONCE(test_bit(MD_CLOSING, &mddev->flags));
> -               set_bit(MD_CLOSING, &mddev->flags);
> +               if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
> +                       mutex_unlock(&mddev->open_mutex);
> +                       err = -EBUSY;
> +                       goto out;
> +               }
>                 did_set_md_closing = true;
>                 mutex_unlock(&mddev->open_mutex);
>                 sync_blockdev(bdev);
> --
> 2.25.1
>
>
>
