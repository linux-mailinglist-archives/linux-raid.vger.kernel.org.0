Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB76A228F75
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 06:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgGVE6f (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 00:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgGVE6f (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 00:58:35 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51F7207BB
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 04:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595393915;
        bh=4xJjOet6aMbSSfKTPz4c2D6LQuQYtIwlg/Va2+RwxI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D4ckfUfhjDAgiK4cfBExtGFxQP+F6q1PdRDCUeW8NZbEU7x0G3vjBhDWDb05mdeQF
         SOQvBOWwM9cM1qHDhcgNj4k63WpteehkRLMVQeXTyjZcm2QFE9jRwFilyD+71Vv8yR
         tkyPaOLEEGYiCRK/omUSaCACxRSKtCxCcqu7hYtI=
Received: by mail-lj1-f177.google.com with SMTP id h22so1043795lji.9
        for <linux-raid@vger.kernel.org>; Tue, 21 Jul 2020 21:58:34 -0700 (PDT)
X-Gm-Message-State: AOAM530lq/AZN4VRIeqfK2Dp+Ko20xMYPP3P6CVyiZ62/tQcr/1IPnJp
        OpGAzfQeU02bV85JGCIZEwUOI/QrbXNKVvQAqyw=
X-Google-Smtp-Source: ABdhPJyyjrs1byJlWbQ3mv7l8+DfevniZ2tUTjZmdZyuH0wvEJUIaKaRWm1hN44C2HuEC1Vyczs3uTyjk15fLZRI0wo=
X-Received: by 2002:a2e:9996:: with SMTP id w22mr15476989lji.446.1595393913238;
 Tue, 21 Jul 2020 21:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200718092909.4020424-1-yuyufen@huawei.com>
In-Reply-To: <20200718092909.4020424-1-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 21 Jul 2020 21:58:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4MQK06f6weM2NPpDRMbOdLfpfXsH75Y2V178XpD92BPw@mail.gmail.com>
Message-ID: <CAPhsuW4MQK06f6weM2NPpDRMbOdLfpfXsH75Y2V178XpD92BPw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] md/raid5: set STRIPE_SIZE as a configurable value
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Jul 18, 2020 at 2:28 AM Yufen Yu <yuyufen@huawei.com> wrote:
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
>
>  Normally, using default stripe_size can get better performance. So, NeilBrown
>  have suggested just to fix the it as 4096. But, out test result shows that
>  a big value of stripe_size may have better performance when size of issued
>  IOs are mostly bigger than 4096. Thus, in this patchset, we still want to
>  set stripe_size as a configurable value.
>
>  This patchset just set STRIPE_SIZE as a configurable value for "PAGE_SIZE != 4096"
>  system, likely arm64 with 'PAGE_SIZE=64KB'. It doesn't make any difference for
>  'PAGE_SIZE == 4096' system, likely x86.
>
>  To save memory used by stripe_head, I will send the related optimiation patchset later.

Applied to md-next. Thanks!
