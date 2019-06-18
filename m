Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0AC4A426
	for <lists+linux-raid@lfdr.de>; Tue, 18 Jun 2019 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfFROj3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 10:39:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:47089 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFROj3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 18 Jun 2019 10:39:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so15536207qtn.13
        for <linux-raid@vger.kernel.org>; Tue, 18 Jun 2019 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=src1M9ugFRKfGKSeXtfzb+uquY/EdEQdLxlf9cRAlWw=;
        b=XVuzjDqjZ+CIVoUJapGYai3wGwf4xrda9lqO4suQhanE6FTO0LPJAeO8wlacYvl/aj
         tvO7A0DaDgUlbKDISjsempX7zHkDrGHRQ0cC0tyeBHf/eQXxB7ypKD9Rg+mhG7YM02gW
         rRm+bRe+qjH6PVkICwOPbgU7jXyKzEdbPOktBMTEkgQE6LD+bKWjWzwjVFvV9Xl7kg2O
         W7R8BwxxKpexbStYjhp0x/KuE8pLDPRwlSj76AEgnvqA4luFvkQqLUrlkxtQmEL3UdYj
         tgA4OWccD6jFKorZPOdbs7JeCW+fthy2REYOKPtWXmVYf+POSZjE5er/oWXU26vcVpuZ
         tOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=src1M9ugFRKfGKSeXtfzb+uquY/EdEQdLxlf9cRAlWw=;
        b=H2+vU582/M6BRDbeLS8vnYzE22iuum8bH6xGb8Lkbt9QXambtXEiadPt7WxD3ihr7H
         A0p3vMFdCFL379FtKXz/vY/KHM1qAQHALr5ANB36n7QRm4yBSaZdEPAAMdzNF7/19Zk4
         iN7IW8XtnnfdiwswMc0zTdcBZt4/KeS/hflg/nzaLh63NFcTlqbrnu6MytwfxdRQfTrw
         ROa4Gyf5HJTFLj6CKvBqBwyKJrKahRiWlEy6Nv5R4zqYAdTq7zU1MGpXN7oszy1cE+tO
         i6JQ7qwgflPNbm81PWT+mkiLMsWcucvjZYTL0ijGyWZFHlRTzsA72PWcwpwXTRD4+q80
         0RUA==
X-Gm-Message-State: APjAAAW9jIw25/DEjYcxVToU5Gg056Za77tc37gTHbnBNrmU16oRGXqS
        zJhaZ8q9Fy3iN11+fBs7JpwUio9lPGFbI+XPx5xqeM+0
X-Google-Smtp-Source: APXvYqxnB98kfPG0HTUuPB3G1uum3s5BpAmEoQaCFFy9QxNsLJi7XqwnAhHmbcMocEPzpgoiSkJGEg352kXzdm4EggU=
X-Received: by 2002:a0c:d0fc:: with SMTP id b57mr27927565qvh.78.1560868768430;
 Tue, 18 Jun 2019 07:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190614091039.32461-1-gqjiang@suse.com> <20190614091039.32461-2-gqjiang@suse.com>
 <CAPhsuW6eYaqxmHzHeu8UzXXx+DH-2FkEtQcWfvHp-YKTVe2U6Q@mail.gmail.com>
 <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com> <6d5373a4-7aeb-336a-a234-3b386f9e2ef4@suse.com>
In-Reply-To: <6d5373a4-7aeb-336a-a234-3b386f9e2ef4@suse.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 18 Jun 2019 07:39:17 -0700
Message-ID: <CAPhsuW4YBhixhdGkvue5evnLwRU_wEmEgOcEiLA0urePcWTq0w@mail.gmail.com>
Subject: Re: [PATCH 1/5] md/raid1: fix potential data inconsistency issue with
 write behind device
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 18, 2019 at 1:35 AM Guoqing Jiang <gqjiang@suse.com> wrote:
>
>
>
> On 6/18/19 11:41 AM, Guoqing Jiang wrote:
> >>>
> >>> +static int check_and_add_wb(struct md_rdev *rdev, sector_t lo,
> >>> sector_t hi)
> >>> +{
> >>> +       struct wb_info *wi;
> >>> +       unsigned long flags;
> >>> +       int ret = 0;
> >>> +       struct mddev *mddev = rdev->mddev;
> >>> +
> >>> +       wi = mempool_alloc(mddev->wb_info_pool, GFP_NOIO);
> >>> +
> >>> +       spin_lock_irqsave(&rdev->wb_list_lock, flags);
> >>> +       list_for_each_entry(wi, &rdev->wb_list, list) {
> >> This doesn't look right. We should allocate wi from mempool after
> >> the list_for_each_entry(), right?
> >
> > Good catch, I will use an temp variable in the iteration since
> > mempool_alloc
> > could sleep.
>
> After a second thought, I think it should be fine since wi is either
> reused to record the sector range or freed after the iteration.
>
> Could you elaborate your concern? Thanks.

First, we allocated wb_info and stored the ptr to wi. Then we use
same wi in list_for_each_entry(), where the original value of wi is
overwritten:

#define list_for_each_entry(pos, head, member)                          \
        for (pos = list_first_entry(head, typeof(*pos), member);        \
             &pos->member != (head);                                    \
             pos = list_next_entry(pos, member))

So we are leaking the original wi from mempool_alloc, right?
And we probably over writing one element on wb_list.

Did I read it wrong?

Thanks,
Song
