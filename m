Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F54262430
	for <lists+linux-raid@lfdr.de>; Wed,  9 Sep 2020 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgIIAs6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 8 Sep 2020 20:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgIIAs5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 8 Sep 2020 20:48:57 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD080218AC;
        Wed,  9 Sep 2020 00:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599612537;
        bh=mXIdCidWMc8j3cKhWk7me5rFmN/mRf6OwzZWL3L98lc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=drkujQ9OYjwkFu7SJHOooDQKM+niHuKf8HGv1QsEkZHu2UMcMHbfwVllAIPEpp6gT
         QK7JMWmU9vHuK07q0DVAtFq3T+9vJv1PrDHt9jEoXdnCsxVhhCdpV2LbR+adpW1DTU
         fwv/3swpoS2o6ug+PaSNKMV3oIa3oOCrCaK0TSnk=
Received: by mail-lj1-f169.google.com with SMTP id v23so1299892ljd.1;
        Tue, 08 Sep 2020 17:48:56 -0700 (PDT)
X-Gm-Message-State: AOAM532tpwZHY6fXPnqWTDDaKvifxFj0AiBJoCkMlEQheeDvCkuoDwCh
        kjihRQch5e/WKpELanuPR8aKyMkw19PcqAMKqUQ=
X-Google-Smtp-Source: ABdhPJyW+BNlX5EgPgNxpO1PqBng2m2nh31PbmdtIIDgnGAQqDTLBynh33DuHPEiqIPnOP2E8qZygETysllWqsPLT1Y=
X-Received: by 2002:a2e:7602:: with SMTP id r2mr554663ljc.10.1599612535222;
 Tue, 08 Sep 2020 17:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200908012351.1092986-1-ming.lei@redhat.com> <20200908012351.1092986-2-ming.lei@redhat.com>
In-Reply-To: <20200908012351.1092986-2-ming.lei@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 8 Sep 2020 17:48:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5hz19joxgO8dHJ1==ZXp+RsFgGbvHZFyvV8tE4jh_VCw@mail.gmail.com>
Message-ID: <CAPhsuW5hz19joxgO8dHJ1==ZXp+RsFgGbvHZFyvV8tE4jh_VCw@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] percpu_ref: add percpu_ref_inited() for MD
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Veronika Kabatova <vkabatov@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Sep 7, 2020 at 6:24 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> MD code uses perpcu-refcount internal to check if this percpu-refcount
> variable is initialized, this way is a hack.
>
> Add percpu_ref_inited() for MD so that the hack can be avoided.
>
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Tested-by: Veronika Kabatova <vkabatov@redhat.com>
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Song Liu <song@kernel.org>
