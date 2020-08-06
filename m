Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EE723D458
	for <lists+linux-raid@lfdr.de>; Thu,  6 Aug 2020 02:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHFAF4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 5 Aug 2020 20:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgHFAFz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 5 Aug 2020 20:05:55 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E9A22CA1;
        Thu,  6 Aug 2020 00:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596672355;
        bh=oIfxdQYMGGRcf4FFk5rarC4BVcqtGzF4ioTvjVmScwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wea4rl2EcIB1d8t+3viei6oImNHZUA77Fcop0ISmSmAc8xC/Ex7thzO01CG8JXH1x
         urdHUaZ6L5eyQEQzuXN5vy7goY1Qy5i7x1JI3fjXJ/kIq6cFZHmb7Xdk+rS+2hiJD/
         UNJLcLo8bSBllHoFYkTJnLWhfPHnd5pqQhLOJc4k=
Received: by mail-lf1-f45.google.com with SMTP id s9so25225379lfs.4;
        Wed, 05 Aug 2020 17:05:54 -0700 (PDT)
X-Gm-Message-State: AOAM532hiZGhDFI8hN5GLgkWTU59UndoCv7Rx1V3sGRznRhBRqGFC15t
        Jx+nlkvaZutx7GWMBAZ1sVrTCF/TgMq/SrMHuZw=
X-Google-Smtp-Source: ABdhPJwSimaBo0c3bd2yLxKN8annl6N/CE59QJ0FE4AQhd0fnZufJmwgEE7WpiF3ShrD3KC4KL7ydVnWLAXJ4O/KBW4=
X-Received: by 2002:a19:7710:: with SMTP id s16mr2678194lfc.162.1596672353031;
 Wed, 05 Aug 2020 17:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200805002718.50839-1-junxiao.bi@oracle.com>
In-Reply-To: <20200805002718.50839-1-junxiao.bi@oracle.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 5 Aug 2020 17:05:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6m3B509L58Adrzw6k+34SMYbXKrk8vxARhcnNJfz8k1Q@mail.gmail.com>
Message-ID: <CAPhsuW6m3B509L58Adrzw6k+34SMYbXKrk8vxARhcnNJfz8k1Q@mail.gmail.com>
Subject: Re: [PATCH] md: get sysfs entry after redundancy attr group create
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Aug 4, 2020 at 5:29 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>
> "sync_completed" and "degraded" belongs to redundancy attr group,
> it was not exist yet when md device was created.
>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: e1a86dbbbd6a ("md: fix deadlock causing by sysfs_notify")
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>

Applied to md-next. Thanks!
