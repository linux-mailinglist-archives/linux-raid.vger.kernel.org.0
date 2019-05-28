Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506442CC08
	for <lists+linux-raid@lfdr.de>; Tue, 28 May 2019 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfE1Qb6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 May 2019 12:31:58 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:46658 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1Qb6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 May 2019 12:31:58 -0400
Received: by mail-qk1-f173.google.com with SMTP id a132so23521144qkb.13
        for <linux-raid@vger.kernel.org>; Tue, 28 May 2019 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlRIX2pTqemrAcEdRz9eYtCg141nmtyqexsTSPb8R2s=;
        b=cK8ru32QAKRD+z4MKcsPE2uzXOUo9wpr1ZJj8pf+6+xenyWTJJYTAN6/p+TFuZ+oNW
         T1hPVCOyuo5HcJYrRyI6WJIvBowfRmDCdCnf6xiDNJ5/i2RvjskRcPqbYKKNTQP4XHzq
         shf/zHhHwuNW7GdGaAoUHULQd4KCBVV+RLYmJbxV3ObGUPwjnh7xZ7MkF7uKX/CjWr1x
         Zeq4mJncW8q1J7UmtPTmUh2XuXglLo+Vfzbr1y0WDSfKR8dAQtz23TX1ddPg1Z5hmXTA
         gZQ+q1PtfKR7fP/oP32kSVCa78ReWJrwUy4NP+vsBXUrVrl7E0hQbc/8+4eAKQnQEcBQ
         nSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlRIX2pTqemrAcEdRz9eYtCg141nmtyqexsTSPb8R2s=;
        b=GE2LLgXjSW0nrpOm/ea0cB6b0J3YNSgUFfbGoVvaFelZ9/pUAAqXJqWAcBce40S785
         ta9X6kbTupFK/o4AktzHtKaK8wXhjk6R9kbhEof49SuZEB1858qUprrxfECD5+2Au8Iy
         PjenVpe4WZf1OPVOyLk/zGMDy1Dc21zx+9vzGH9mVRXHuhqpqZWQ7IeWHWKRkxP3GxUN
         ZLKOvWjnpSnNZaT6sNqw5kqjobrEyZq3Hd/INq/u77HFR03EGNzEdVWDbkg6UQQfoTxw
         7ve5J2H4XqzxY98NPdkF4vqEHondkua8/qBwdHFkixHfKJARXP8i/1gBbquAcIFINuIo
         nsqw==
X-Gm-Message-State: APjAAAWAyTYE0yGj4K/GghQXdEgkjzRYcm3zGEi0At/RT30AYcxa4RS0
        OIP+w7gY/WMcGKLraOhvhmt4tI2iVmjJGDU++JlI1c5aWpU=
X-Google-Smtp-Source: APXvYqwLoJVOHdAtcf8i1ML9WEejBIjsCI1eng6MpODz9iW1NCXY5F9ux6Gt0NfpuSZWUtdzvxrRctxGd+Ysorxdwxw=
X-Received: by 2002:a0c:92c2:: with SMTP id c2mr82070828qvc.145.1559061117132;
 Tue, 28 May 2019 09:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
 <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com>
 <ae69671c-7763-916e-5b45-0ff4741293eb@ziu.info> <CAPhsuW4yMSjzb0FCQsRWJCYmXNQM5Y2o_LCOE-6C7gTOcCNrEQ@mail.gmail.com>
 <32f8bf8c-6a81-0490-f702-fa9cc41c38e9@ziu.info> <CAPhsuW6FOoOxfCMov0bTUeLrWYN6f8-ZisW9HLCRXKPJhHE1Hw@mail.gmail.com>
 <de217f41-52e1-886a-fa60-52cd830864ad@ziu.info>
In-Reply-To: <de217f41-52e1-886a-fa60-52cd830864ad@ziu.info>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 28 May 2019 09:31:45 -0700
Message-ID: <CAPhsuW6cwWToqd7ag7xZWb2uosFO=qc5a2d4DFdmwc7gOrcX7g@mail.gmail.com>
Subject: Re: Few questions about (attempting to use) write journal + call traces
To:     Michal Soltys <soltys@ziu.info>
Cc:     Xiao Ni <xni@redhat.com>, linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 27, 2019 at 2:46 AM Michal Soltys <soltys@ziu.info> wrote:
>
> On 5/24/19 7:51 PM, Song Liu wrote:
> > On Fri, May 24, 2019 at 3:51 AM Michal Soltys <soltys@ziu.info> wrote:
> >>
> >> On 5/23/19 8:09 PM, Song Liu wrote:
> >>>>>
> >>>>
> >>>> Actually, this seems to be unreleated to underlying devices - the culprit seems to be attempting to write to an array after adding journal, without stopping and reassembling it first. Details below.
> >>>
> >>> Thanks for these experiments. Your analysis makes perfect sense.
> >>>
> >>> Do you think you can continue the  experiments with the write journal before
> >>> this issue got fixed?
> >>>
> >>> I am asking because this is not on the top of my list at this time. If
> >>> this is not
> >>> blocking other important tests, I would prefer to fix it at a later time.
> >>>
> >>> Thanks,
> >>> Song
> >>>
> >>
> >> Yea it's fine. I can help with testing (whenever you sit down to this
> >> issues) as well.
> >>
> >> Question though - other than trying to add journal to existing live raid
> >> - is this feature overall safe to use (or are there any other know
> >> issues one should be aware of beforehand) ?
> >>
> > We (Facebook) have done some tests with it. However, we didn't put
> > it into production. The reason behind this decision was not reliability, but
> > performance concerns and high level directions. I think Redhat is
> > evaluating it.
> >
>
> Well I will give it a shot probably. My case scenario is that a bunch of
> sync-happy VMs on top of lvm+raid seem to be crushing performance
> (unless there are other reasons), even with very small disk usage.
>
> Out of curiosity - is the journal in writeback mode controllable in some
> way (e.g. frequency of how often it flushes to raid disks, whether it's
> space or time (or both) based ?).

It is combination of both time and space:

/*
 * log->max_free_space is min(1/4 disk size, 10G reclaimable space).
 *
 * In write through mode, the reclaim runs every log->max_free_space.
 * This can prevent the recovery scans for too long
 */
#define RECLAIM_MAX_FREE_SPACE (10 * 1024 * 1024 * 2) /* sector */
#define RECLAIM_MAX_FREE_SPACE_SHIFT (2)

/* wake up reclaim thread periodically */
#define R5C_RECLAIM_WAKEUP_INTERVAL (30 * HZ)
/* start flush with these full stripes */
#define R5C_FULL_STRIPE_FLUSH_BATCH(conf) (conf->max_nr_stripes / 4)
/* reclaim stripes in groups */
#define R5C_RECLAIM_STRIPE_GROUP (NR_STRIPE_HASH_LOCKS * 2)

However, we didn't expose knobs to tune these on a live system.

Thanks,
Song
>
>
>
>
> > + Xiao, who might be working on this.
> >
> > Thanks,
> > Song
> >
>
