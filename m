Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5133A4A535
	for <lists+linux-raid@lfdr.de>; Tue, 18 Jun 2019 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfFRPVn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 11:21:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40213 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfFRPVn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 18 Jun 2019 11:21:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so15775074qtn.7
        for <linux-raid@vger.kernel.org>; Tue, 18 Jun 2019 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIdhO5r8AUBtehE0A36kELF3aKO79PbE6MPQIIKCmCk=;
        b=d2w9StWIOHVIa8npUMJH1bN5AvHU/sSKpHxc++cucxo9ld29MQz0Ii2Lp2DM1Bn/yx
         jMQP3XV6cCqFGKzkAfK4ZibX1BCcdXn+UffgqFMLvX2FiAguyq3NuUilShOSAPQAX5Gq
         8hA0dBvMPmTkpHSd3vW6nE+HMxrqLvZVfYTF3trrN7hdYXlUwBAX/fkeUhpVkPkS1cIx
         8l+uPyTK05jQjgopc6LknQSH+JDKrGkcWFhT6VtIyi6r4cCSpJYx/2E93XCPmXa2OdYe
         YJ4g/HtjJu9iRqFfUSbyYpLbr7FSg9khYWXQg4A8OZqSLxpTtwSIdxFc1vm+2GzH66vZ
         mZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIdhO5r8AUBtehE0A36kELF3aKO79PbE6MPQIIKCmCk=;
        b=BTpIgg3YY2r49Ndyo4rnEyhWjxtqs9uKAmxDBIQgxcimLcNxv7SEKjEkUKVP7DJQ7X
         CMopGzRdymxcR+id2cbfZ8utighpoIV80vYTv/tucK/vQulatsR+bcp+gCvxZbXXM65Q
         JYR2JazWqdw/jW55z13ymAPYaANeI5uTNwA5NzKddguLDbVyZ1aiMdjNjJ8bqixatLlr
         WpFM+im56CljYBId48wjC0UqdCbC3j8XT8WFwLLaXVtJgys5vqWdYWWrqIa/fnU62+89
         oM8MySdLUSyV5M9GLwMCKxgCsRRgjzfC2jczdP4VgltcFQo6Fquac6yjziPCOtmJ9oxn
         oY9Q==
X-Gm-Message-State: APjAAAWgxe+wXABSr9EJXWgJ9Vtb8tUzc/n1AhZvCFlOJrpQLi7+l/4h
        ge/no0cGywGZ0M2qhC0jLDDmxCisuYsC8QlCoiI=
X-Google-Smtp-Source: APXvYqylpggUamHBRrGzkarepM2I+2LLuLrUDeFFfRU1bsOpR3Pv3qydmV7Vnm8U7uhyGrS9mmdldtHD9Qazc8mG5hw=
X-Received: by 2002:a0c:d0fc:: with SMTP id b57mr28169152qvh.78.1560871302217;
 Tue, 18 Jun 2019 08:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190613141141.15483-1-mariusz.tkaczyk@intel.com> <CAPhsuW7-LgfVi-ucTZCDEA0+4raQvNaHeWVJxBLcBDTLWLv8mA@mail.gmail.com>
In-Reply-To: <CAPhsuW7-LgfVi-ucTZCDEA0+4raQvNaHeWVJxBLcBDTLWLv8mA@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 18 Jun 2019 08:21:31 -0700
Message-ID: <CAPhsuW5pE1fvMqoOe5e=4o=zV3a3aY=WG0GRVoEV9sOzbo4h3g@mail.gmail.com>
Subject: Re: [PATCH] md: fix for divide error in status_resync
To:     Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jun 14, 2019 at 2:48 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Thu, Jun 13, 2019 at 8:09 AM Mariusz Tkaczyk
> <mariusz.tkaczyk@intel.com> wrote:
> >
> > Stopping external metadata arrays during resync/recovery causes
> > retries, loop of interrupting and starting reconstruction, until it
> > hit at good moment to stop completely. While these retries
> > curr_mark_cnt can be small- especially on HDD drives, so subtraction
> > result can be smaller than 0. However it is casted to uint without
> > checking. As a result of it the status bar in /proc/mdstat while stopping
> > is strange (it jumps between 0% and 99%).
> >
> > The real problem occurs here after commit 72deb455b5ec ("block: remove
> > CONFIG_LBDAF"). Sector_div() macro has been changed, now the
> > divisor is casted to uint32. For db = -8 the divisior(db/32-1) becomes 0.
> >
> > Check if db value can be really counted and replace these macro by
> > div64_u64() inline.
> >
> > Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
>
> This looks good! Thanks for the fix.
>
> > ---
> >  drivers/md/md.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 04f4f131f9d6..9a8b258ce1ef 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -7607,9 +7607,9 @@ static void status_unused(struct seq_file *seq)
> >  static int status_resync(struct seq_file *seq, struct mddev *mddev)
> >  {
> >         sector_t max_sectors, resync, res;
> > -       unsigned long dt, db;
> > -       sector_t rt;
> > -       int scale;
> > +       unsigned long dt, db = 0;
> > +       sector_t rt, curr_mark_cnt, resync_mark_cnt;
> > +       int scale, recovery_active;
> >         unsigned int per_milli;
> >
> >         if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||
> > @@ -7709,11 +7709,16 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
> >          */
>
> Could you please also update comments before this section? (sector_t
> is always u64 now).

Never mind, I fixed the comments while applying the patch.

Song
