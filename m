Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FD124C79F
	for <lists+linux-raid@lfdr.de>; Fri, 21 Aug 2020 00:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgHTWNU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 Aug 2020 18:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgHTWNU (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 20 Aug 2020 18:13:20 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24CC0207DA
        for <linux-raid@vger.kernel.org>; Thu, 20 Aug 2020 22:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597961599;
        bh=7Nva6PxbRQFCymZAN1IgIh5Q7X7SALeQCoYr4QyaxwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G8b0ih7wTBLA+uxelt1DkE/RGGECxaI36NYVMejvBxJMKxKxbl+JTe5TfltFvrKYz
         ufQ0eNHgToPy6olORpMslT6/T3p0+HAmZv0gQdjnX/9Db+/d6pKzqbfFHcah60XN00
         dCo+NqFpsOnk0y2swLDV6G1TuYR8pN9iU/fvMzoQ=
Received: by mail-lj1-f180.google.com with SMTP id h19so3789921ljg.13
        for <linux-raid@vger.kernel.org>; Thu, 20 Aug 2020 15:13:19 -0700 (PDT)
X-Gm-Message-State: AOAM532rShspRhntc+dwEVv1q08mW5PZrDQY2vi/gKMqDhX87/n+QpSi
        SJskmZSHkUTqk5la+eR7EDhcpl0FS+2T5M+318M=
X-Google-Smtp-Source: ABdhPJyy6KJ5MBbVZDy5sy3gH5LglvhRlksg6tINkFv1enCC3LspUPddhf3iQ80qRENkUmhmW7RXoZbSNjH31zdQDK4=
X-Received: by 2002:a2e:5748:: with SMTP id r8mr45793ljd.27.1597961597478;
 Thu, 20 Aug 2020 15:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <1597306476-8396-1-git-send-email-xni@redhat.com>
 <1597306476-8396-4-git-send-email-xni@redhat.com> <CAPhsuW4sa8PBC8sn4u+9SBMEHkinoAr2jRss1bSsvV+WQ+yPuA@mail.gmail.com>
 <21012936-9397-40f9-115b-87dda93d9017@redhat.com>
In-Reply-To: <21012936-9397-40f9-115b-87dda93d9017@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 20 Aug 2020 15:13:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6fuhEL60Wnjr5O33+pX0Bo+xS9xVHSan6VXE6YfR-U-A@mail.gmail.com>
Message-ID: <CAPhsuW6fuhEL60Wnjr5O33+pX0Bo+xS9xVHSan6VXE6YfR-U-A@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] md/raid10: improve raid10 discard request
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, Coly Li <colyli@suse.de>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Aug 20, 2020 at 12:22 AM Xiao Ni <xni@redhat.com> wrote:
[...]

> +
> +       if (conf->reshape_progress != MaxSector &&
> +           ((bio->bi_iter.bi_sector >= conf->reshape_progress) !=
> +            conf->mddev->reshape_backwards))
> +               geo = conf->prev;
> +
> +       stripe_size = (1<<geo.chunk_shift) * geo.raid_disks;
>
> This could be raid_disks << chunk_shift
>
> +       stripe_mask = stripe_size - 1;
>
> Does this work when raid_disks is not power of 2?
>
> In test I used 5 disks to create the raid10 too, it worked well. Could you explain what
> you worried in detail?

Say we have geo.raid_disks == 5, and geo.chunk_shift == 8. Then we get
stripe_size == 0x500 and stripe_mask == 0x4ff == b'100 1111 1111
Is this the proper stripe_mask?

Thanks,
Song
