Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5F5212FBB
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jul 2020 01:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGBXAs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 19:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgGBXAr (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 19:00:47 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2868820781
        for <linux-raid@vger.kernel.org>; Thu,  2 Jul 2020 23:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593730847;
        bh=Tq75lDVLggxNi2EOUxSWmW1OuCgYVFIu8zXkDjNO0Ug=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hwweSxsfbIMEud1J6HmsibvELsRKAbV7cLDZu3J3Z2MNh788w+/BaSk4DFNL21EHC
         K06o2cXtYJizEsOFmpIKDk8uFMwNdI5V8YOvmF4W41PG3+lR00J0awVxWQk90kjX7D
         0oEGxzUYUswUlgJULZvu/+nesQSDJyK9za0icn0M=
Received: by mail-lj1-f177.google.com with SMTP id d17so19643762ljl.3
        for <linux-raid@vger.kernel.org>; Thu, 02 Jul 2020 16:00:47 -0700 (PDT)
X-Gm-Message-State: AOAM5339J7yR0LBnb7eLLQYdSiEsqy2uSYh/8hlZXnUiONQmWjWq0GaE
        ER0HQAW8C2/qFr4rtxbpvjM61+YFAgasgj8tPIQ=
X-Google-Smtp-Source: ABdhPJyLNC2Yg1Qis9HHV97LQgQXJT+ei0N85Wy1oe4cnkQlu7LFvDazzT5icRZubU/LA+l/amndcKW/Kzj7aPxz+rU=
X-Received: by 2002:a2e:9eca:: with SMTP id h10mr18214952ljk.273.1593730845356;
 Thu, 02 Jul 2020 16:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200702120628.777303-1-yuyufen@huawei.com>
In-Reply-To: <20200702120628.777303-1-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 2 Jul 2020 16:00:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7PgJV-bjaa8v=Zrhd0MqPmjew1dF-Qi0FP6i-809YAQg@mail.gmail.com>
Message-ID: <CAPhsuW7PgJV-bjaa8v=Zrhd0MqPmjew1dF-Qi0FP6i-809YAQg@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] md/raid5: set STRIPE_SIZE as a configurable value
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

On Thu, Jul 2, 2020 at 5:05 AM Yufen Yu <yuyufen@huawei.com> wrote:
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

Higher level question: do we need to support page size that is NOT 4kB
times power
of 2? Meaning, do we need to support 12kB, 20kB, 24kB, etc. If we only
supports, 4kB,
8kB, 16kB, 32kB, etc. some of the logic can be simpler.

Thanks,
Song
