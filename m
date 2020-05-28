Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2F1E6363
	for <lists+linux-raid@lfdr.de>; Thu, 28 May 2020 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390876AbgE1OKq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 May 2020 10:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390727AbgE1OKp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 28 May 2020 10:10:45 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2596920888
        for <linux-raid@vger.kernel.org>; Thu, 28 May 2020 14:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590675045;
        bh=yNeBPYwdLPTycfQJT4ZS1T62q9dq/QMHJXyf+BTu/C0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tl8u50cSkF3VGt9FqrzaXUuQMFklYYAlnc8QU43CyVSNqBUi2hqi3+ADXiTjJ5phK
         PpOTsu2OhMOJPsV7NTiG+1OA9H7gHfbNgBi3D0ohXoXpazCmJCNV0eU9JBJzzgF+Kg
         X3YcxMd3gaO1uGuHL+aDLdtd93W6ChtC4N0p/JjM=
Received: by mail-lf1-f48.google.com with SMTP id e125so16661200lfd.1
        for <linux-raid@vger.kernel.org>; Thu, 28 May 2020 07:10:45 -0700 (PDT)
X-Gm-Message-State: AOAM530IlQr+wBwOxsoj0xzs1ml+Pi+/6JpmR6yq1eK5tO/IYdiDwsII
        4QIYM1aWl44kbCffA0jKaIaKC11clBwK5QK36P8=
X-Google-Smtp-Source: ABdhPJw3CpddUs3JrXef2pFCXkYkRHOdeWad5dqDs9ED6A5dWuxtlrpJU1bDp6XWMyY7MKggP5CnWKNCr1c9yu4pQ5s=
X-Received: by 2002:a05:6512:3329:: with SMTP id l9mr1725538lfe.138.1590675043209;
 Thu, 28 May 2020 07:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200527131933.34400-1-yuyufen@huawei.com>
In-Reply-To: <20200527131933.34400-1-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 28 May 2020 07:10:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7hVgM7yiaBg0Pkaci4NStEdyduCp1+yMf9aguKfm4jKQ@mail.gmail.com>
Message-ID: <CAPhsuW7hVgM7yiaBg0Pkaci4NStEdyduCp1+yMf9aguKfm4jKQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] md/raid5: set STRIPE_SIZE as a configurable value
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Coly Li <colyli@suse.de>, Xiao Ni <xni@redhat.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, May 27, 2020 at 6:20 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
> Hi, all
>
>  For now, STRIPE_SIZE is equal to the value of PAGE_SIZE. That means, RAID5 will
>  issus echo bio to disk at least 64KB when PAGE_SIZE is 64KB in arm64. However,
>  filesystem usually issue bio in the unit of 4KB. Then, RAID5 will waste resource
>  of disk bandwidth.
>

Thanks for the patch set.

Since this is a big change, I am planning to process this set after
upcoming merge window.
Please let me know if you need it urgently.

Song
