Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98721F719
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jul 2020 18:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgGNQSx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jul 2020 12:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgGNQSx (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Jul 2020 12:18:53 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605622251F;
        Tue, 14 Jul 2020 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594743532;
        bh=Arizj3kFgzEcL3Koyf1IoHEpYlDKy+RYAsYt5BODwnc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T+my6tgyXE9IQIVevvThSfjhdhNcDPwiHAF99JP8td1Zbp4KR5sqD9/YD2xWrm7NE
         8CTBTmZU52RSRd4L/WoM9hOaWIQaquWQ7Xo9JjUzbLP0jQXfn4sKo5bl5eHw4Pz4OY
         D8r6aXgKdnsXBHBMV/bu2MrBr4sRiqkkzN/8IFQA=
Received: by mail-lj1-f180.google.com with SMTP id e8so23595707ljb.0;
        Tue, 14 Jul 2020 09:18:52 -0700 (PDT)
X-Gm-Message-State: AOAM530l7QIKT++9ZK2mt90lFDekE1KO0T7XPm9vHNO/9tyUHEKiorkM
        6kIGlKwhxEy921haOFjTEiA4++KQDPoXbEcu8tQ=
X-Google-Smtp-Source: ABdhPJyZyZCLfuoyTSGGY8RWN0T4zhEj7y1fQH0Eoe71BRYQetrHSV3OxgPcdQvc0QB7QrW9affifMlT3VJPWRtxWxo=
X-Received: by 2002:a2e:88c6:: with SMTP id a6mr2700501ljk.27.1594743530708;
 Tue, 14 Jul 2020 09:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200709233545.67954-1-junxiao.bi@oracle.com> <CAPhsuW7seCUnt3zt6A_fjTS2diB7qiTE+SZkM6Vh=G26hdwGtg@mail.gmail.com>
 <de97a2c1-fba0-5276-7748-f0155088ad0d@oracle.com>
In-Reply-To: <de97a2c1-fba0-5276-7748-f0155088ad0d@oracle.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 14 Jul 2020 09:18:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4GQK7hS4AOpJJ1mEE8gbFgo+n+XCQ2fvW94QnZhA6ivQ@mail.gmail.com>
Message-ID: <CAPhsuW4GQK7hS4AOpJJ1mEE8gbFgo+n+XCQ2fvW94QnZhA6ivQ@mail.gmail.com>
Subject: Re: [PATCH] md: fix deadlock causing by sysfs_notify
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jul 13, 2020 at 11:41 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>
> On 7/13/20 11:17 PM, Song Liu wrote:
>
> > On Thu, Jul 9, 2020 at 4:36 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
> >> The following deadlock was captured. The first process is holding 'kernfs_mutex'
> >> and hung by io. The io was staging in 'r1conf.pending_bio_list' of raid1 device,
> >> this pending bio list would be flushed by second process 'md127_raid1', but
> >> it was hung by 'kernfs_mutex'. Using sysfs_notify_dirent_safe() to replace
> >> sysfs_notify() can fix it. There were other sysfs_notify() invoked from io
> >> path, removed all of them.
> >>
> > [...]
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> > Thanks for the patch. It looks good in general. One question though, do we
> > need the same change the following line in md.c:level_store()?
> >
> >      sysfs_notify(&mddev->kobj, NULL, "level");
>
> Thanks for the review. This one is not in io path, looks it's safe. I
> can change it if you want to align it with others.

This one is the only leftover. Let's also change it.

Thanks,
Song
