Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2A8221D31
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 09:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgGPHUY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 03:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgGPHUX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Jul 2020 03:20:23 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7804E206F5
        for <linux-raid@vger.kernel.org>; Thu, 16 Jul 2020 07:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594884022;
        bh=PUNzyuQvIFR/Iu7H+LXadfwMHRC47kayq4FETrRP4NE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=orlBPAFmmgwN4vJiFEbkud0SI3l5lb3rEbl3Eg6agxSGaukkRYmpWu4d5hdRmMK8a
         dOsMnr9jH9zg4pO7TxT+Hdl5vqRJqNES200sblXxVEoZ1ifAiDKdYh7dRvg+Py/+3+
         Bbq/li+7B3b/7kP3farBj6kRF2Tgt6MC9S/sfLwQ=
Received: by mail-lj1-f181.google.com with SMTP id x9so5977113ljc.5
        for <linux-raid@vger.kernel.org>; Thu, 16 Jul 2020 00:20:22 -0700 (PDT)
X-Gm-Message-State: AOAM5330FlMt+/d08Ht/VkyqW2iuFgVMKWPRNB4lCuVwOuWwUwJG/81o
        lIjc0aWE5yVPxP1XzwIiO88wDMxnPjG2sJO8eBE=
X-Google-Smtp-Source: ABdhPJx7SBhd1u0hwr+qWHtmUW0uCOi0bBm7DaJxGJw2dLqwd0cNMdCqGIrBfIkbx3B4l5MTnc8L1aRKqI9y4ZhwKiw=
X-Received: by 2002:a2e:8707:: with SMTP id m7mr1273389lji.350.1594884020775;
 Thu, 16 Jul 2020 00:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200715124257.3175816-1-yuyufen@huawei.com>
In-Reply-To: <20200715124257.3175816-1-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 16 Jul 2020 00:20:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4ON3U9GXygpMsTxWGfQr8XH1H8GHn-VPUmOBfOqAEWdw@mail.gmail.com>
Message-ID: <CAPhsuW4ON3U9GXygpMsTxWGfQr8XH1H8GHn-VPUmOBfOqAEWdw@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] md/raid5: set STRIPE_SIZE as a configurable value
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 15, 2020 at 5:42 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
> Hi, all
>
>  For now, STRIPE_SIZE is equal to the value of PAGE_SIZE. That means, RAID5
>  will issue each bio to disk at least 64KB when PAGE_SIZE is 64KB in arm64.
>  However, filesystem usually issue bio in the unit of 4KB. Then, RAID5 may
>  waste resource of disk bandwidth.
>
>  To solve the problem, this patchset try to set stripe_size as a configuare
>  value. The default value is 4096. We will add a new sysfs entry and set it
>  by writing a new value, likely:
>
>         echo 16384 > /sys/block/md1/md/stripe_size

[...]

> V6:
>  * Convert stripe_size and stripe_sectors from 'unsigned int' to
>    'unsigned long' avoiding compiler warning.
>  * Add a new member of stripes_per_page into r5conf, avoiding to
>    compute each time.
>  * Cover mddev->private with mddev_lock(mddev) for raid5_store/show_stripe_size().
>  * Get rid of too many WARN_ON() and BUG_ON().
>  * Unfold raid5_get_page_index() into raid5_get_dev_page() directly.

We are running out of time before the upcoming merge window, so we may not
be able to ship the whole set. How about we ship 01, and 11 in this
merge window,
and the rest in the next merge window? Would the array get most of the
performance benefit with these 2 patches? Do you see other issues with
this path?

Also I would like to minimize changes for PAGE_SIZE==4096 systems. Ideally,
we can hide these changes from these system in ifdef's, like:

#if PAGE_SIZE == DEFAULT_STRIPE_SIZE
#define STRIPE_SIZE            PAGE_SIZE
#define STRIPE_SHIFT           (PAGE_SHIFT - 9)
#define STRIPE_SECTORS         (STRIPE_SIZE>>9)
#endif

#if PAGE_SIZE != DEFAULT_STRIPE_SIZE
unsigned long           stripe_size;
unsigned int            stripe_shift;
unsigned long           stripe_sectors;
#endif

#if PAGE_SIZE != DEFAULT_STRIPE_SIZE
#define RAID5_STRIPE_SIZE(conf) DEFAULT_STRIPE_SIZE
#else
#define RAID5_STRIPE_SIZE(conf) ((conf)->stripe_size)
#endif

And then use RAID5_STRIPE_SIZE(conf) in the rest of the code.

Thanks,
Song
