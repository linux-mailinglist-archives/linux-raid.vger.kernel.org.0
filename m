Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D7C1397B9
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 18:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgAMRb5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 12:31:57 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:41794 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgAMRb4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 13 Jan 2020 12:31:56 -0500
Received: by mail-qt1-f170.google.com with SMTP id k40so9769999qtk.8
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 09:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awIO8wUIudnFFV7aQB7Dh5AUDu7wfXXyn9MKTEXVDwc=;
        b=eUNgJZJiVlZAXQln3smvfW2wozVOH/XKrt8H4zfo1XMOlbq+EH0OgLexE6VBpR4eC4
         yH7MICsIZgeXO9mDgAvKRHlBuPwygVBM1lhNc2tgFJvvsUQMm0EH/emyBkH7nt85Xm37
         GVV2F3Hr4b/tqfEb8p2Say3rF65fIFqF1LTonboa1yuvKloZPlzvX7uFLLx8futpX432
         QvvIYsOqUpR5eUJJ3+SQAdm0Skb9xaImtTswqteVqzCthgS8IZQAe7DEeD6Sx3LqrrJ0
         gqOyvxYqiDL9XI3yjBJEv7zPo832LVM0zwNSFcAlpumJcO7wChncqLPYheSEQY9Y3O6k
         aChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awIO8wUIudnFFV7aQB7Dh5AUDu7wfXXyn9MKTEXVDwc=;
        b=pNuoZYls6GK5rE5nA2WACIeVfJGiGlUpZ7FJt2CWv+s/JOOQ8LHNq5jmdg0yanuzKI
         UXwCpaOD5eIMqnQb4cXLDTc/w6jJ+FvVlCmGDVOT80CqYX4LVFgxcG0gTMfJrQN3F2FP
         hmexjF1GS6uxKGoJZ2d4sKQDuB5wXNrATy0scwY4budNcH5Bqy1jbGg7r1lGqSHK1QLN
         rboH5T+pS8lmy65L4JSZG+VeSUzgJD32xd1vIb/+iafGNSQdDLqWs52gBSyE6lOwnaGZ
         Nh6oyOH2YO81uJWOloqg/7kEwFQ5erKUVMEl5IoIPqm8K0F2PPYVmeYAN/6c6rC7WNy5
         Lr5w==
X-Gm-Message-State: APjAAAWqwMxC0Ds4vCgfikL/UvH2y+pwQXVDR/ouQDurb5HMmuyAp6Bw
        pAj4F5k6YY5fbwdlZ6tKHe5okbracJDkmLVdY86Pmw==
X-Google-Smtp-Source: APXvYqyI7MXPgWiIUhKhnLu6cMVoSj1jOv0VsD1NCWL9H4f8XDjwxho3lxn+hiDJdcVklcu/E/gs/SofGM3HpCmTqPE=
X-Received: by 2002:ac8:6784:: with SMTP id b4mr10941032qtp.27.1578936715984;
 Mon, 13 Jan 2020 09:31:55 -0800 (PST)
MIME-Version: 1.0
References: <54384251-9978-eb99-e7ec-2da35f41566c@inview.de> <5E1C86F4.4070506@youngman.org.uk>
In-Reply-To: <5E1C86F4.4070506@youngman.org.uk>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 13 Jan 2020 09:31:44 -0800
Message-ID: <CAPhsuW45052b5OjoWgQhs0r50CeisBS3ya3nGi74Jr0_8HDB5A@mail.gmail.com>
Subject: Re: Reassembling Raid5 in degraded state
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Christian Deufel <christian.deufel@inview.de>,
        linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jan 13, 2020 at 7:04 AM Wols Lists <antlists@youngman.org.uk> wrote:
>
> On 13/01/20 09:41, Christian Deufel wrote:
> > My plan now would be to run mdadm --assemble --force /dev/md3 with 3
> > disk, to get the Raid going in a degraded state.
>
> Yup, this would almost certainly work. I would recommend overlays and
> running a fsck just to check it's all okay before actually doing it on
> the actual disks. The event counts say to me that you'll probably lose
> little to nothing.
>
> > Does anyone have any experience in doing so and can recommend which 3
> > disks I should use. I would use sdc1 sdd1 and sdf1, since sdd1 and sdf1
> > are displayed as active sync in every examine and sdc1 as it is also
> > displayed as active sync.
>
> Those three disks would be perfect.
>
> > Do you think that by doing it this way I have a chance to get my Data
> > back or do you have any other suggestion as to get the Data back and the
> > Raid running again?
>
> You shouldn't have any trouble, I hope. Take a look at
>
> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>
> and take note of the comment about using the latest mdadm - what version
> is yours (mdadm --version)? That might assemble the array no problem at all.
>
> Song, Neil,
>
> Just a guess as to what went wrong, but the array event count does not
> match the disk counts. Iirc this is one of the events that cause an

Which mismatch do you mean?

> assemble to stop. Is it possible that a crash at the wrong moment could
> interrupt an update and trigger this problem?

It looks like sdc1 failed first. Then sdd1 and sdf1 got events for sdc1 failed.
Based on super block on sdd1 and sdf1, we already have two failed drive,
so assemble stopped.

Does this answer the question?

Thanks,
Song
