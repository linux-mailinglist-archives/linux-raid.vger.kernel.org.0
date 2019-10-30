Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C870DEA78C
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 00:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfJ3XMH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 19:12:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43374 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJ3XMH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 30 Oct 2019 19:12:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id c26so5795060qtj.10
        for <linux-raid@vger.kernel.org>; Wed, 30 Oct 2019 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrVcZV44vu/XaCUNg9rDXaGF+DPf9vlWiaM283i8LnM=;
        b=PlHim/WYj9P5GG6BPocr6F9E4l0JVVE2YTB9JjUZdzzE1+plzQoIlSNOhxTfLX3giM
         geSPkTFBaoRSvnU/VYH2/dzKtZbnw3u+djWByOipmVKlknENvn7FKT207RoOujaa38wO
         e4qrOCUajIeF883YPj41qVDh1R8jBw5kJQMg286FZUP6R2K0HOS45oG8tf2nseYYOGiX
         IqlMpUMVKBj90YFAaFt4L02EXNvzA/TwqKVnqd4d8b5eukZjVzAXPvTexG2f7+fepk7u
         oHSrR+UBKvUvIZRkGxdpQ3FH87orKsO+356J+pylSY5RhOO2pG295F8dOaGhZVxUXCah
         8/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrVcZV44vu/XaCUNg9rDXaGF+DPf9vlWiaM283i8LnM=;
        b=GSUnpRT3QK6Plm7zoRXV/50tksjIIUR8IVGw8kVthl90DVv5MYqJFRde/wzkTu7s2h
         A6lDT809jpRZ5rmGZhGnDtNUtcwSg+Ea/O6QIMAqyGF7wgkhrVy6O3T699rw5JkUKxFC
         OaCuk86lXSaF1un7jsqFtUGWBbXBGHCr7KxKPn93kvvpPgBU/awfRJQKiwaJQYcuKWzu
         YFwAY/N8dn592nnebZOdclYtObDFoxoIb81Kp4teBqjzY0tRmzI61en3z//V4wvOKGHE
         VjY6RbS5ECmelPJCY7HqHzkeKO5qAh+yot+oDWE7AO7g1R8RZ+uOmQUxLkIO1j4uzEOr
         UoGw==
X-Gm-Message-State: APjAAAWxlHVAUYI1q3SbVZwVom1OtQWyM1MfHzDjHIQTbbzuRxgRtU1I
        oxH08J8Bupr8Lutl4nAAevWAtYARvJ1bc/SeNkE=
X-Google-Smtp-Source: APXvYqwMDeht4q+tqz6EbY0IfMMym0PIbiCcOzUGfUeGir7mMhWZ96au/g7LNHQ1/jAItSdLSnVqnyDDaVUZFMl8rcI=
X-Received: by 2002:ad4:50a8:: with SMTP id d8mr1685143qvq.8.1572477126488;
 Wed, 30 Oct 2019 16:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <25373b220163b01b8990aa049fec9d18@iki.fi> <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
 <f1de00a04761370d90018f288b9b2996@iki.fi> <CAPhsuW4pddLHge+tkz2pvsPv9xgXi=WvVH3ck5KTF7EkNgE2iA@mail.gmail.com>
 <2054f286c123d9b9bcc66faf0d6f7d10@iki.fi> <CAPhsuW68wmVQ6eH3o_eE+BkDXSfWHy7kEcsMj04uEzAGigbwkg@mail.gmail.com>
 <0d3573affc5c44ff169120f8667f5780@iki.fi> <CAPhsuW5hj6-BOwifzQ5DRBaAWTCazgNF8oS3MtFf=4r-ioBaRw@mail.gmail.com>
 <2952af29aba2680d5c6d17b9351bc15d@iki.fi> <CAPhsuW6HsL2GS+G5cYfjhjiZi4ZGsSj60ov=YgQUngbNkt9bPw@mail.gmail.com>
 <c8b37bc022aca270102fe7114be7051e@iki.fi>
In-Reply-To: <c8b37bc022aca270102fe7114be7051e@iki.fi>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 30 Oct 2019 16:11:55 -0700
Message-ID: <CAPhsuW46r7dx5LO8=9q+UsHUVU1Q87Fo4OOyGFLUvKx9Q1tSKQ@mail.gmail.com>
Subject: Re: RAID6 gets stuck during reshape with 100% CPU
To:     Anssi Hannula <anssi.hannula@iki.fi>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Oct 30, 2019 at 11:25 AM Anssi Hannula <anssi.hannula@iki.fi> wrote:
>
> Song Liu kirjoitti 2019-10-29 23:55:
> > On Tue, Oct 29, 2019 at 1:45 PM Anssi Hannula <anssi.hannula@iki.fi>
> > wrote:
> >>
> >> Song Liu kirjoitti 2019-10-29 22:28:
> >> > On Tue, Oct 29, 2019 at 12:05 PM Anssi Hannula <anssi.hannula@iki.fi>
> >> > wrote:
> >> >>
> >> >> Song Liu kirjoitti 2019-10-29 08:04:
> >> >> > I guess we get into "is_bad", case, but it should not be the case?
> >> >>
> >> >> Right, is_bad is set, which causes R5_Insync and R5_ReadError to be
> >> >> set
> >> >> on lines 4497-4498, and R5_Insync to be cleared on line 4554 (if
> >> >> R5_ReadError then clear R5_Insync).
> >> >>
> >> >> As mentioned in my first message and seen in
> >> >> http://onse.fi/files/reshape-infloop-issue/examine-all.txt , the MD
> >> >> bad
> >> >> block lists contain blocks (suspiciously identical across devices).
> >> >> So maybe the code can't properly handle the case where 10 devices have
> >> >> the same block in their bad block list. Not quite sure what "handle"
> >> >> should mean in this case but certainly something else than a
> >> >> handle_stripe() loop :)
> >> >> There is a "bad" block on 10 devices on sector 198504960, which I
> >> >> guess
> >> >> matches sh->sector 198248960 due to data offset of 256000 sectors (per
> >> >> --examine).
> >> >
> >> > OK, it makes sense now. I didn't add the data offset when checking the
> >> > bad
> >> > block data.
> >> >
> >> >>
> >> >> I've wondered if "dd if=/dev/md0 of=/dev/md0" for the affected blocks
> >> >> would clear the bad blocks and avoid this issue, but I haven't tried
> >> >> that yet so that the infinite loop issue can be investigated/fixed
> >> >> first. I already checked that /dev/md0 is fully readable (which also
> >> >> confuses me a bit since md(8) says "Attempting to read from a known
> >> >> bad
> >> >> block will cause a read error"... maybe I'm missing something).
> >> >>
> >> >
> >> > Maybe try these steps?
> >> >
> >> > https://raid.wiki.kernel.org/index.php/The_Badblocks_controversy#How_do_I_fix_a_Bad_Blocks_problem.3F
> >>
> >> Yeah, I guess those steps would probably resolve my situation. BTW,
> >> "--update=force-no-bbl" is not mentioned on mdadm(8), is it on
> >> purpose?
> >> I was trying to find such an option earlier.
> >>
> >> If you don't need anything more from the array, I'll go ahead and try
> >> clearing the seemingly bogus bad block lists.
> >
> > Please go ahead. We already got quite a few logs.
>
> Seems that was indeed the issue, clearing the bad block log allowed the
> reshape to continue normally.

That's great news!

Song
