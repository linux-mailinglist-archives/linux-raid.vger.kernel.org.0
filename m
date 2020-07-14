Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41EC21E7F2
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jul 2020 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGNGRm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jul 2020 02:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgGNGRm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Jul 2020 02:17:42 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D298221E8;
        Tue, 14 Jul 2020 06:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594707462;
        bh=tVvKmkDwjOWKtYnQwCdwRPJ1H7o5sE4gOhRBkFToH/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WfVe7njjv/NJVNeTtgJF6Chu9iGzDgGhqNUuWquFDX04G+wo3URpGw9idKUe2iOFk
         dAVoRPjub6IUhayrU7OKVvdPGnAbJtiSnWnDZu8txQ/L7cYg5IczBpigZ/fD0yQ+Lo
         Y9G+iEVpcHlUr0hp7OgqhLgiFfM0vL/hx/Kem6Ok=
Received: by mail-lj1-f173.google.com with SMTP id s9so21048428ljm.11;
        Mon, 13 Jul 2020 23:17:41 -0700 (PDT)
X-Gm-Message-State: AOAM5330kN63P33JNNGohXr4FOIAe4FEvSgdCUsqH+9aXSKbx7K2fpBS
        VPSNhLr45C3L9Z9nNQm2yWHTyN7Da08Nj7EQqs0=
X-Google-Smtp-Source: ABdhPJyISwHb0fKgxvB/jlGkf85k8l8fFNQJWx/3voQzIJIOPbXVRcr5u3p9BejqhSR0xuHCwr93duRGf6IOlFiQ7j4=
X-Received: by 2002:a2e:9996:: with SMTP id w22mr1661469lji.446.1594707460008;
 Mon, 13 Jul 2020 23:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200709233545.67954-1-junxiao.bi@oracle.com>
In-Reply-To: <20200709233545.67954-1-junxiao.bi@oracle.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Jul 2020 23:17:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7seCUnt3zt6A_fjTS2diB7qiTE+SZkM6Vh=G26hdwGtg@mail.gmail.com>
Message-ID: <CAPhsuW7seCUnt3zt6A_fjTS2diB7qiTE+SZkM6Vh=G26hdwGtg@mail.gmail.com>
Subject: Re: [PATCH] md: fix deadlock causing by sysfs_notify
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jul 9, 2020 at 4:36 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>
> The following deadlock was captured. The first process is holding 'kernfs_mutex'
> and hung by io. The io was staging in 'r1conf.pending_bio_list' of raid1 device,
> this pending bio list would be flushed by second process 'md127_raid1', but
> it was hung by 'kernfs_mutex'. Using sysfs_notify_dirent_safe() to replace
> sysfs_notify() can fix it. There were other sysfs_notify() invoked from io
> path, removed all of them.
>
[...]
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>

Thanks for the patch. It looks good in general. One question though, do we
need the same change the following line in md.c:level_store()?

    sysfs_notify(&mddev->kobj, NULL, "level");

Thanks,
Song

[...]
