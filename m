Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACAA2E139
	for <lists+linux-raid@lfdr.de>; Wed, 29 May 2019 17:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfE2PgF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 May 2019 11:36:05 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:36768 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2PgE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 29 May 2019 11:36:04 -0400
Received: by mail-qk1-f175.google.com with SMTP id g18so1773190qkl.3
        for <linux-raid@vger.kernel.org>; Wed, 29 May 2019 08:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33ujMkhYRMlEl9qCz9vLUYEQe6UGNTgkgLROz1vUI5Q=;
        b=IPmgLyNSp3jKYUSARKo8UKtkW8oq3KTIOtkJb3N9X7el/qQnd8dkJZ4v1eNbCSBWTT
         Y5/8fBiNaUmQKxlxhhsBXu2qwfmg2P/RBBMx3JwSy4MVOJ31YZ9Llhrr0srcjidtE2IT
         2f8BiRsReJMZkLIxTa7MS0LwtYgs7y9eLDC7DqOTXWh70hZXC8oq9L1GQkZn09RHmQ27
         GncU345DvRDzzR6mM5YYnr3MCYbEEhd0EamsRZgyymsjPPqNESTjwPSuv14Ag4yDZEx9
         elsStnb6V4rdTK4enfOSMgADMuN+lcdAHh18zx9p7n0EnDR57X/dQB/iso7QQZEeRrtQ
         qNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33ujMkhYRMlEl9qCz9vLUYEQe6UGNTgkgLROz1vUI5Q=;
        b=jsM66yvxQxf2vVBzb07lmbNluGDlF72OuSYhhln8shLX3+88yWhcTZ5MpbdA4/tW9M
         fe/SeZWvYLw3g7uDvXSyrGh+E1CoL1ebk7cDdUJlYGR1sjGD8DbDu96O3v2mdfY1FQrM
         umViv0/N60cos8FQ1Jx2df5SjyacpI5q2Y81P/9qdgijWzKIx+AxYF63BTDY+LUy7irb
         Z3cxjJdLXsTrX1aml4DJsrAYQCmJey1pMCy1d7U0NFFjTGG5+6vtuRAAnmM9CSWkVIK0
         lqySvKzsgCK6fHoseBEB+dkFBE2sdIqOIV7ON8awNEinCd3ypYhgJXciUvrLIlqG8nJ8
         Xr0w==
X-Gm-Message-State: APjAAAWkpX+EyJwINHqQGU/gulQWpL4Z9AGJ5fcXQ7wp/IJ6AuDCuQce
        s+XDLuT0qRuhFydayBj4Z5asNtkQhP8Fc72ZU+s=
X-Google-Smtp-Source: APXvYqxhg7sVIKhA3n9b+m0JDiw886YYQR5/vlY9zTK2ZypgHpVJ0K+FD6jcV6th5z08NRoyxJeO0plCyKixcQDlbv8=
X-Received: by 2002:ae9:ee0b:: with SMTP id i11mr16186742qkg.96.1559144163725;
 Wed, 29 May 2019 08:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
 <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com>
 <ae69671c-7763-916e-5b45-0ff4741293eb@ziu.info> <CAPhsuW4yMSjzb0FCQsRWJCYmXNQM5Y2o_LCOE-6C7gTOcCNrEQ@mail.gmail.com>
 <32f8bf8c-6a81-0490-f702-fa9cc41c38e9@ziu.info> <CAPhsuW6FOoOxfCMov0bTUeLrWYN6f8-ZisW9HLCRXKPJhHE1Hw@mail.gmail.com>
 <de217f41-52e1-886a-fa60-52cd830864ad@ziu.info> <CAPhsuW6cwWToqd7ag7xZWb2uosFO=qc5a2d4DFdmwc7gOrcX7g@mail.gmail.com>
 <a6f2f02b-f0c9-99be-48c0-19dad8d5cb82@ziu.info>
In-Reply-To: <a6f2f02b-f0c9-99be-48c0-19dad8d5cb82@ziu.info>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 29 May 2019 08:35:52 -0700
Message-ID: <CAPhsuW6zKZOx0x4iof_GYQzzDjsC2yy=uVeb3M_g4n1s42FA5g@mail.gmail.com>
Subject: Re: Few questions about (attempting to use) write journal + call traces
To:     Michal Soltys <soltys@ziu.info>
Cc:     Xiao Ni <xni@redhat.com>, linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, May 29, 2019 at 5:31 AM Michal Soltys <soltys@ziu.info> wrote:
>
> On 5/28/19 6:31 PM, Song Liu wrote:
> > On Mon, May 27, 2019 at 2:46 AM Michal Soltys <soltys@ziu.info> wrote:
> >>>>
> >>>> Question though - other than trying to add journal to existing live raid
> >>>> - is this feature overall safe to use (or are there any other know
> >>>> issues one should be aware of beforehand) ?
> >>>>
> >>> We (Facebook) have done some tests with it. However, we didn't put
> >>> it into production. The reason behind this decision was not reliability, but
> >>> performance concerns and high level directions. I think Redhat is
> >>> evaluating it.
> >>>
> >>
> >> Well I will give it a shot probably. My case scenario is that a bunch of
> >> sync-happy VMs on top of lvm+raid seem to be crushing performance
> >> (unless there are other reasons), even with very small disk usage.
> >>
> >> Out of curiosity - is the journal in writeback mode controllable in some
> >> way (e.g. frequency of how often it flushes to raid disks, whether it's
> >> space or time (or both) based ?).
> >
> > It is combination of both time and space:
> >
> > /*
> >   * log->max_free_space is min(1/4 disk size, 10G reclaimable space).
> >   *
> >   * In write through mode, the reclaim runs every log->max_free_space.
> >   * This can prevent the recovery scans for too long
> >   */
> > #define RECLAIM_MAX_FREE_SPACE (10 * 1024 * 1024 * 2) /* sector */
> > #define RECLAIM_MAX_FREE_SPACE_SHIFT (2)
> >
> > /* wake up reclaim thread periodically */
> > #define R5C_RECLAIM_WAKEUP_INTERVAL (30 * HZ)
> > /* start flush with these full stripes */
> > #define R5C_FULL_STRIPE_FLUSH_BATCH(conf) (conf->max_nr_stripes / 4)
> > /* reclaim stripes in groups */
> > #define R5C_RECLAIM_STRIPE_GROUP (NR_STRIPE_HASH_LOCKS * 2)
> >
> > However, we didn't expose knobs to tune these on a live system.
> >
>
> Would (probably) be awesome one day to have those exposed somehow.

I think Shaohua spent quite some time to make them work well without
tuning. But we sure can add knobs if we see clear benefits.

>
> Few extra questions:
>
> 1) if I have journal in w-b mode, will echoing write-through to
> journal_mode block until all the data is safe on the actual raid devices ?

Yes, it will first flush all data in cache.

>
> 2) if (for any reason) I need to remove the journal device live -
> assuming (1) is sufficient - is --fail & --remove the correct way to do so ?
>
I think the best way is to make it write-through first, then do --fail
and --remove.
After that, the array will be read-only. We need to reassemble it and force it
to run without journal.

Thanks,
Song
