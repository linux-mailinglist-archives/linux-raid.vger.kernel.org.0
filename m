Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE7A76AD
	for <lists+linux-raid@lfdr.de>; Wed,  4 Sep 2019 00:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfICWGE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 18:06:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37894 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfICWGE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 18:06:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id b2so18501697qtq.5
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KxI9gDGe4H35iDkCDjrJmMx4nU/hLZjpWZsASeh4gH8=;
        b=ZiPpR2tfqhGVfJTPj/vOuGcClMGQ3bfSNH5j0iw15NKQlOBfRLCHwxiEFroFxmkSWK
         lN0/2fs96xm1eIyROYvTyqmn3IPpZO/WnIDOK0z1GXvAKccj+sZxaPF3ByByS1R6PxO4
         /ZqyftS+6ZWr7AULMJ6nTmQCcdO3sN/mtPUr27BPf+rhjeFSWn43+dLkkhzEB8mpJk/M
         qM57moQ4iVJbunFcfq8j4TAfvWwBDCoK2jyF71d7g2hamxkZruvwBvzXlRnitZlB9u4q
         eA4u5vRgadoQJfftaMd22DlYE5gr0pYjugTn13skTORsISE+yVCZztTzVqs7qah8kqtn
         AAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxI9gDGe4H35iDkCDjrJmMx4nU/hLZjpWZsASeh4gH8=;
        b=PnH18KV+rpgkGjoeQB9UTBolffH4V/UmZhrub4yvfby5ohzUc/S90VaFim/6BxB7pC
         YptxKST+bc/+TTV/HWH5m8qG/gz/GRVku0zMhf/hXGV0vQe0I/cPuSk98DFvVvhuTYfg
         ZTfocEAAhq+rcuonkrVa3FYlZOODi8ECPbz2r91p9DzX/unv39x6NBkXZrhEL7nPrsME
         38DFnEX9R+2QtPm1JKAShivtdU85TuvLBV573Ig66dyaETghgOsv14uCZ8ug8mo8EHMz
         V9gIfpYYAjrhtBUdM9m35n6gM1cFhX6FdBAJmxfg/3HxYVjhwTwTswRp5PZL153sFl14
         1kYw==
X-Gm-Message-State: APjAAAXDQAEoa6Im1qQwRT8MvZfND6GmREOvzPV0mGgGiWtx69Vo05Qa
        FH0+7oo5ESoyTc+SXHiqOa3lwK6awSqsp2wv9eY=
X-Google-Smtp-Source: APXvYqwUyoFWp9Xh6lg/1rzmIe7ONjTs/2QOSsdYk9+vquds7U8w8Iaq1mOMBm8V9kD2uo0tMpcZ4RTOah3JevIFqGQ=
X-Received: by 2002:ad4:4c08:: with SMTP id bz8mr14530280qvb.81.1567548363420;
 Tue, 03 Sep 2019 15:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190903131241.656-1-yuyufen@huawei.com>
In-Reply-To: <20190903131241.656-1-yuyufen@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 3 Sep 2019 15:05:52 -0700
Message-ID: <CAPhsuW6umweH-m1wPG5uSG5W-8YS1zN12M2597PApttqz-QDgA@mail.gmail.com>
Subject: Re: [PATCH v2] md/raid1: fail run raid1 array when active disk less
 than one
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>, neilb@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Sep 3, 2019 at 5:52 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
> When run test case:
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
> mdadm run fail with kernel message as follow:
> [  172.986064] md: kicking non-fresh sdb from array!
> [  173.004210] md: kicking non-fresh sdc from array!
> [  173.022383] md/raid1:md1: active with 0 out of 4 mirrors
> [  173.022406] md1: failed to create bitmap (-5)
>
> In fact, when active disk in raid1 array less than one, we
> need to return fail in raid1_run().
>
> Reviewed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Applied to md-next.

Thanks!
