Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE01E4B08A
	for <lists+linux-raid@lfdr.de>; Wed, 19 Jun 2019 05:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfFSD7n (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 23:59:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35049 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfFSD7n (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 18 Jun 2019 23:59:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so18293136qto.2
        for <linux-raid@vger.kernel.org>; Tue, 18 Jun 2019 20:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5zj6N1FKESl7M0BFJqVluFD7qEfwU1oV6w+tOUQwqQ=;
        b=kulxVyRR8mlKcpdkvQOk0r9fYUtcA0N3S5AzwNlC+hKGM0/zJT8wi0KgU1meh5FENY
         t6uMeZaYu20lNVPWujwjUXNe6WgzoPVw5QIHetuDWBJKcaKEOsuF2juBpL8RQcQ+WDfp
         +GdJBJ0l5ORwkV0wbux13OMZEIfXKFmpPJwHSWKq4OsugYQ2MOzpJtGN8N1tFH6hTj+Z
         Q2gZxCk0v2NpCoK31BibCbBfdAdyfC9s3oBENIzTfsXxeUWQ0ZZk6wfCDn8M2y5LVEFP
         WkpL+n3a0WQbdWgNfx7Qoik9zWMkrLxSuQG0UhF2YjTWxsyCdCI5cXimVtA/AoVEn1Ho
         3l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5zj6N1FKESl7M0BFJqVluFD7qEfwU1oV6w+tOUQwqQ=;
        b=AZROQ5Z8wCIwKUqMk1xsRPvP78PKsrcCtmqIlziQPNgKORwfwONrSiJg6Wu/ee82PY
         EiJVlDFjJ0LxPhy/RCLAD6QaLv39BThp4wVesl6Vtbtl0E7I6AAUH9saJyOWGIonHIrB
         mM9GgL8c1Ymf/C3IIb1JoIHQWJ1YpICnWjTO89i+6V+8l/3nFvbdkZ7YZQHjl1MNgK1z
         2GPlU6Pp5yM7tGD8hznD2svpRLyUZLMQRee7N/eNO8lDIjyOz7A1UzSzh/1WxBVjVweK
         nuoftJVPTOZQn/K99VP31FU1Xm9P9L/FqwPjPBvwgVM+KXRYnRr0YO2+9iiTQW8IoyoV
         9Z4A==
X-Gm-Message-State: APjAAAW6aoqRDBqRWFOHjr9YxCpIjH/WfJJ/pc6Us3r0wyaajajdo4rn
        zqCUzQCWt2pxYrBbAiGXxGX9oG9VSlj/kRvGdQb6xQ==
X-Google-Smtp-Source: APXvYqzVTmfI7kxTQN1CGSMRi/CeKv7RBZFQ1eVduvCY7K1rvAukQ6goy10eerrnAGR/4TOaee2lHYEIA9w0ao5GCDk=
X-Received: by 2002:a0c:c68d:: with SMTP id d13mr8428443qvj.145.1560916782699;
 Tue, 18 Jun 2019 20:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190614091039.32461-1-gqjiang@suse.com> <20190614091039.32461-2-gqjiang@suse.com>
 <CAPhsuW6eYaqxmHzHeu8UzXXx+DH-2FkEtQcWfvHp-YKTVe2U6Q@mail.gmail.com>
 <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com> <6d5373a4-7aeb-336a-a234-3b386f9e2ef4@suse.com>
 <CAPhsuW4YBhixhdGkvue5evnLwRU_wEmEgOcEiLA0urePcWTq0w@mail.gmail.com> <543a63e4-5b8a-2b11-9201-32f935c9b175@suse.com>
In-Reply-To: <543a63e4-5b8a-2b11-9201-32f935c9b175@suse.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 18 Jun 2019 20:59:31 -0700
Message-ID: <CAPhsuW7hJPzn8qJpLfVgv+bhe1oWhsyij2CG4P-59=6b_DcTKg@mail.gmail.com>
Subject: Re: [PATCH 1/5] md/raid1: fix potential data inconsistency issue with
 write behind device
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 18, 2019 at 8:54 PM Guoqing Jiang <gqjiang@suse.com> wrote:
>
>
>
> On 6/18/19 10:39 PM, Song Liu wrote:
> > On Tue, Jun 18, 2019 at 1:35 AM Guoqing Jiang <gqjiang@suse.com> wrote:
> >>
> >>
> >>
> >> On 6/18/19 11:41 AM, Guoqing Jiang wrote:
> >>>>>
> >>>>> +static int check_and_add_wb(struct md_rdev *rdev, sector_t lo,
> >>>>> sector_t hi)
> >>>>> +{
> >>>>> +       struct wb_info *wi;
> >>>>> +       unsigned long flags;
> >>>>> +       int ret = 0;
> >>>>> +       struct mddev *mddev = rdev->mddev;
> >>>>> +
> >>>>> +       wi = mempool_alloc(mddev->wb_info_pool, GFP_NOIO);
> >>>>> +
> >>>>> +       spin_lock_irqsave(&rdev->wb_list_lock, flags);
> >>>>> +       list_for_each_entry(wi, &rdev->wb_list, list) {
> >>>> This doesn't look right. We should allocate wi from mempool after
> >>>> the list_for_each_entry(), right?
> >>>
> >>> Good catch, I will use an temp variable in the iteration since
> >>> mempool_alloc
> >>> could sleep.
> >>
> >> After a second thought, I think it should be fine since wi is either
> >> reused to record the sector range or freed after the iteration.
> >>
> >> Could you elaborate your concern? Thanks.
> >
> > First, we allocated wb_info and stored the ptr to wi. Then we use
> > same wi in list_for_each_entry(), where the original value of wi is
> > overwritten:
> >
> > #define list_for_each_entry(pos, head, member)                          \
> >          for (pos = list_first_entry(head, typeof(*pos), member);        \
> >               &pos->member != (head);                                    \
> >               pos = list_next_entry(pos, member))
> >
> > So we are leaking the original wi from mempool_alloc, right?
>
> Yes, you are right, thanks for the details.
>
> > And we probably over writing one element on wb_list.
>
> Will change it to:
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 93dff41c4ff9..f1ea17b14b6e 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -85,7 +85,7 @@ static void lower_barrier(struct r1conf *conf,
> sector_t sector_nr);
>
>   static int check_and_add_wb(struct md_rdev *rdev, sector_t lo,
> sector_t hi)
>   {
> -       struct wb_info *wi;
> +       struct wb_info *wi, *temp_wi;
>          unsigned long flags;
>          int ret = 0;
>          struct mddev *mddev = rdev->mddev;
> @@ -93,9 +93,9 @@ static int check_and_add_wb(struct md_rdev *rdev,
> sector_t lo, sector_t hi)
>          wi = mempool_alloc(mddev->wb_info_pool, GFP_NOIO);
>
>          spin_lock_irqsave(&rdev->wb_list_lock, flags);
> -       list_for_each_entry(wi, &rdev->wb_list, list) {
> +       list_for_each_entry(temp_wi, &rdev->wb_list, list) {
>                  /* collision happened */
> -               if (hi > wi->lo && lo < wi->hi) {
> +               if (hi > temp_wi->lo && lo < temp_wi->hi) {
>                          ret = -EBUSY;
>                          break;
>                  }

This looks good.

Thanks!
Song
