Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E26155D45
	for <lists+linux-raid@lfdr.de>; Fri,  7 Feb 2020 19:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBGSA6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 13:00:58 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46336 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGSA5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Feb 2020 13:00:57 -0500
Received: by mail-ot1-f54.google.com with SMTP id g64so85922otb.13
        for <linux-raid@vger.kernel.org>; Fri, 07 Feb 2020 10:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AD5shSHEG52RIRwAi7+mfIugiVFY8/hTVO52jhWK+pk=;
        b=ocjVy6kRKTbFJYKZozPLO03IDN+1ZvBnhodCAWucggQIxPZ/iz9BmsfjTwUgNvpnFY
         NgJbbU4tk22T6nN6HvMpekyq6uYQvmvftRaq8qrJY1c7esqnkFaN5S42m9mi1wynElqm
         E2scq+kV+p2MM8RksnGcrHy98yI3QdBeUlXZHzPSwlNp1jkp2cs1imq7m6nvKXFb6QP/
         tY3pzSFvy2svZJDh6sXJA16naXNOTwEnYbRVcAt2OYy2kQ4I907f2K4MT6kuuSpILzHa
         zf86RrWaotVAgCFkaQwI/lIC6hkPW2i8HpspV0G7iXqlFak89ObJRBF0gxb8T6oY1Lv/
         pDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AD5shSHEG52RIRwAi7+mfIugiVFY8/hTVO52jhWK+pk=;
        b=ZgNHeinTdZDhaozTX3alFmMc44Tf/YSJO9FGohhN3agWTeBbKirTzJl6+GOZqy1Nfe
         MVDqHRBhxuRTKRMivfN7dtNuavIFChdKglsQCTw+UHP8xt41XbpOgx5jjk0XUZPpwLfy
         1DZEpqj/0wEnAxG/s467AUMvtJM+qCj9Rbpxs6EiL66IUTfEn5wcH8EsBg56cxeQmvaL
         1VcaKBEKYiccPQr39k0qLGL7maanJ1lrDXa7NkyvKVAuCpa+GfTB+WeAlrNP6o90U4kY
         KUGRJNriBpS+BEIeIJopI5rtyBebK7kIcAwpnDFcJ8vgANFA4s80kqyqK8O+sixZCm3w
         3RhA==
X-Gm-Message-State: APjAAAW4SDbDKSngGl9uRvNZpJGJ00zJ1ObYZnFJBlC1FedbwBgoudhN
        c8fC4Q3rzONH/XFbjzqvl/Mn13e1n22rV73u3mU=
X-Google-Smtp-Source: APXvYqyLYgrbCxe6sZYUnP8sNsuxz49gqlGWY6CdCCz5HAwFXlirf643UHqRfxaoVzDsC1QXu4EVDo8mHIJYpNewjDI=
X-Received: by 2002:a9d:6544:: with SMTP id q4mr401287otl.269.1581098455492;
 Fri, 07 Feb 2020 10:00:55 -0800 (PST)
MIME-Version: 1.0
References: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
 <b75c2dc2-d14e-39dc-0c06-7bab53fa7cb8@thelounge.net> <CAPpdf5882kxxkK2YrEmWWcM2X=ffcV+YB-GFTck2Qi34ufWE2g@mail.gmail.com>
 <f4146b7d-3ff3-e08d-4dac-1ac9a3de138e@thelounge.net>
In-Reply-To: <f4146b7d-3ff3-e08d-4dac-1ac9a3de138e@thelounge.net>
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Fri, 7 Feb 2020 12:00:19 -0600
Message-ID: <CAPpdf5-5mSL_MJpeASjvwG2L7JX2owW2WhptKQiME5mqh0KN9A@mail.gmail.com>
Subject: Re: Question
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Feb 7, 2020 at 11:30 AM Reindl Harald <h.reindl@thelounge.net> wrote:
>
>
>
> Am 07.02.20 um 17:26 schrieb o1bigtenor:
> > On Fri, Feb 7, 2020 at 9:53 AM Reindl Harald <h.reindl@thelounge.net> wrote:
> >>
> >> Am 07.02.20 um 16:49 schrieb o1bigtenor:
> >>> Running a Raid-10 array made up of 4 - 1 TB drives on a debian testing
> >>> (11) system.
> >>> mdadm - v4.1 - 2018-10-01 is the version being used.
> >>>
> >>> Some weirdness is happening - - - vis a vis - - - I have one directory
> >>> (not small) that has disappeared. I last accessed said directory
> >>> (still have the pdf open which is how I could get this information)
> >>> 'Last accessed 2020-01-19 6:32 A.M.'  as indicated in the 'Properties'
> >>> section of the file in question.
> >>>
> >>> Has been suggested to me that I make the array read only until this is resolved.
> >>> I have space on the the array on a different system to recover this array.
> >>> Suggestions on how to do both of the above would be aprreciated
> >>
> >> directories on a filesystem on top of a RAID don't disappear silently -
> >> my bet is a simple drag&drop move or deletion aka PEBCAK
> >
> > I checked with bash - - history  and in about 500 items there is no mention of
> > such. Looked in log files and can't find anything either. Quite
> > puzzling - - - -
> > that's why I'm asking here.
> >
> > And yes - - - I am aware that all too often I'm the problem. I've
> > gotten a lot more
> > careful that I was even 5 years ago - - - grin.
>
> if you shave no system error showing any evidence you are wrong here -
> even if it would be true witout any errors message you are wrong here
> because it's the same as asking if your neighbours dog pissed on your wall
>
> even with a filesystem error you are wrong here and it's impossible that
> the raid forget about exactly one folder because that layer don't now
> about folders and the FS would puke if a complete area desiapperas at
> running fsck - period

I understand that this is a highly unusual occurrence.

That's why I'm asking here.

Regards
