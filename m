Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4B711BBCC
	for <lists+linux-raid@lfdr.de>; Wed, 11 Dec 2019 19:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfLKSfK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Dec 2019 13:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbfLKSfK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 11 Dec 2019 13:35:10 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F8A2464B
        for <linux-raid@vger.kernel.org>; Wed, 11 Dec 2019 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576089309;
        bh=kfQZy94Ui+hOeEnJYnzzMtHAFtnjSRWh9PcRgFNk9aM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eoPB6fr3gzOOAcoieWG8KG3nVyuRqfNnxxtgXHSING+LXBD98IfdabArOEsQLs48L
         8T859Q65gJUpp7qMN6ftrPgk0v1SZ5g6SlJVl837DyV5PTTM3xy4OpTXrYnRimHg06
         FbxIT9LdpLcV9knDQ5MdViv+6z5dTjgerKN845KY=
Received: by mail-qv1-f41.google.com with SMTP id p2so6159392qvo.10
        for <linux-raid@vger.kernel.org>; Wed, 11 Dec 2019 10:35:09 -0800 (PST)
X-Gm-Message-State: APjAAAXEKJ4fvji7fzAYaFZKw8wpG05Q8YlADYFthvzg9po3EVM+WNhe
        WU/prtHYnpIkyxrx6nca2hLWp7XrQBNqdkZnMuc=
X-Google-Smtp-Source: APXvYqzzOeujM+lAyIcCstwvHlhMa3HtqAkuhd7GLy6Jl5qRRn+PDEH6fcsLeQmYGFTkbp1X8UayrjJCk2w2LCEccFs=
X-Received: by 2002:ad4:44ee:: with SMTP id p14mr4332040qvt.114.1576089308651;
 Wed, 11 Dec 2019 10:35:08 -0800 (PST)
MIME-Version: 1.0
References: <b894dad1-56b9-b87f-c6d5-cbcdea8c1add@huawei.com>
In-Reply-To: <b894dad1-56b9-b87f-c6d5-cbcdea8c1add@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 11 Dec 2019 10:34:57 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7ieqQccS_c0tzALO-crhqysRf+Eg6en3hd6o_DjgfGZA@mail.gmail.com>
Message-ID: <CAPhsuW7ieqQccS_c0tzALO-crhqysRf+Eg6en3hd6o_DjgfGZA@mail.gmail.com>
Subject: Re: [PATCH V2] md: raid1: check whether rdev is null before reference
 in raid1_sync_request func
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, NeilBrown <neilb@suse.de>,
        Song Liu <songliubraving@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Yufen Yu <yuyufen@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nate Dailey <nate.dailey@stratus.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Mingfangsen <mingfangsen@huawei.com>, guiyao@huawei.com,
        yanxiaodan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Dec 9, 2019 at 6:42 PM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>
> In raid1_sync_request func, rdev should be checked whether it is null
> before reference.
>
> --
> V1->V2: remove Fixes tag suggested by Guoqing Jiang

For future patches, please put "v1 -> v2" after the SoB tag. And add
"---" before it.
Then, this part will be removed during git-am.

Applied with minor change.

Thanks,
Song

>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  drivers/md/raid1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index a409ab6f30bc..0dea35052efe 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -2782,7 +2782,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
>                                 write_targets++;
>                         }
>                 }
> -               if (bio->bi_end_io) {
> +               if (rdev != NULL && bio->bi_end_io) {
>                         atomic_inc(&rdev->nr_pending);
>                         bio->bi_iter.bi_sector = sector_nr + rdev->data_offset;
>                         bio_set_dev(bio, rdev->bdev);
> --
> 2.24.0.windows.2
>
>
