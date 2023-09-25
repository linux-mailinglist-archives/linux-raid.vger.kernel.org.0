Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A167AE2B0
	for <lists+linux-raid@lfdr.de>; Tue, 26 Sep 2023 01:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjIYX7N (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 Sep 2023 19:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIYX7N (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 Sep 2023 19:59:13 -0400
Received: from mail.ultracoder.org (unknown [188.227.94.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360E0FB
        for <linux-raid@vger.kernel.org>; Mon, 25 Sep 2023 16:59:06 -0700 (PDT)
Message-ID: <6a1165f7-c792-c054-b8f0-1ad4f7b8ae01@ultracoder.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultracoder.org;
        s=mail; t=1695686343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OcpcVSseTv22dG966otowFWLiyckgbFh26e9DJiCe4U=;
        b=ap0rWR094Yo3lk3EfzCk0lmg4j1xWveUZZMEgMTWJuRVS/dpfPBmRoXOfZisMsNw/C7kSk
        uJR/PwmutkJB0LjPgg/82Pb2Z84dRoASuxdxP/suOUPtEdMPW72HUGBj+2erM5MSoWiccr
        0knMOARCekfbBb71hoxPmz8d8dTktEqMlxQcrRB3HSdVKg938jzUOqC+Pdt7eC66BEQC1Y
        D99gcSAOI1vlmO+LNTiUmLBTuQ0aE7xto2bQ0oJ2zD27/wRYAoRU/KjX1Pfo6WIQl/4Vzv
        VjbU/ksBLDzIKqV1BLpNQq+QJbWXZH47SAsemNLWsF0trNyS4EFrsY6Li69Vcg==
Date:   Tue, 26 Sep 2023 02:59:02 +0300
MIME-Version: 1.0
From:   Kirill Kirilenko <kirill@ultracoder.org>
Subject: Re: fstrim on raid1 LV with writemostly PV leads to system freeze
To:     Yu Kuai <yukuai1@huaweicloud.com>
References: <0e15b760-2d5f-f639-0fc7-eed67f8c385c@ultracoder.org>
 <ZQy5dClooWaZoS/N@redhat.com> <20230922030340.2eaa46bc@nvm>
 <6b7c6377-c4be-a1bc-d05d-37680175f84c@huaweicloud.com>
Content-Language: ru-RU, en-US
Cc:     Roman Mamedov <rm@romanrm.net>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
In-Reply-To: <6b7c6377-c4be-a1bc-d05d-37680175f84c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 25.09.2023 05:58 +0300, Yu Kuai wrote:
> Roman and Kirill, can you test the following patch?
>
> Thanks,
> Kuai
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 4b30a1742162..4963f864ef99 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1345,6 +1345,7 @@ static void raid1_write_request(struct mddev
> *mddev, struct bio *bio,
>         int first_clone;
>         int max_sectors;
>         bool write_behind = false;
> +       bool is_discard = (bio_op(bio) == REQ_OP_DISCARD);
>
>         if (mddev_is_clustered(mddev) &&
>              md_cluster_ops->area_resyncing(mddev, WRITE,
> @@ -1405,7 +1406,7 @@ static void raid1_write_request(struct mddev
> *mddev, struct bio *bio,
>                  * write-mostly, which means we could allocate write
> behind
>                  * bio later.
>                  */
> -               if (rdev && test_bit(WriteMostly, &rdev->flags))
> +               if (!is_discard && rdev && test_bit(WriteMostly,
> &rdev->flags))
>                         write_behind = true;
>
>                 if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {

Thank you. I can confirm, that your patch eliminates freezes during
'fstrim' execution. Tested on kernel 6.5.0.
Still 'fstrim' takes more than 2 minutes, but I believe it's normal to a
file system with 1M+ inodes.

Probably I'm wrong here, but to me this doesn't look like a solution,
more like a masking the real problem.
Even with TRIM operations split in 1MB pieces, I don't expect kernel to
freeze.

