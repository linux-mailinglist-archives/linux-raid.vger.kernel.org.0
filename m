Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB6D4B0B
	for <lists+linux-raid@lfdr.de>; Sat, 12 Oct 2019 01:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfJKXhU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 11 Oct 2019 19:37:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46083 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfJKXhT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 11 Oct 2019 19:37:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id u22so16242324qtq.13
        for <linux-raid@vger.kernel.org>; Fri, 11 Oct 2019 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okWhpn+GzFD6qEDYdUqL6MsUUEVQynHQQBiXZa7K9N8=;
        b=fMuhtbjjixB6/c5aiKEvS1kKq5R7AeO8/VvDBiL8iPW14OJPGyram4urrQRHrjWlb+
         /+48+SZqcj8HSIMG3NpIImxzUcBVEp0RO3JVZXKZ7JdgbugCj9Gq8x32IbP6kgrwm3PR
         bxr3J08VceZFbWE50OUZiZr0lfgTZM+iyPRKC+FpCl0B4wqPvxC3LySJtTvBQEkKZ7g0
         cVjFDwyznFAZOTmKo3cDxvFaA4ibIPYzZczRbYINeqa3NfZDlT4WVuPa+gb4rn7Gc//Q
         utZ9AInCVdpvOcxcESO/m/F/VIEDVtIVj+ySZWcrF7bGA8t4zFT6tkQQfhqta3pcchhY
         OF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okWhpn+GzFD6qEDYdUqL6MsUUEVQynHQQBiXZa7K9N8=;
        b=j+bANlNy+KFVQzMHsfoneZxeni/UdAIiW1GVLwpZUpvuMnxF6NtQ40o4e/GYUKzM3x
         EZtcViED84L7GncbEWm31gDZ2OryydH2FUpbDbKz6dtTFwS6R9eMToSZ9My4Tv0Z1oQS
         l5t/Vato0VlrsRqE3rwpCYnTk7jx9yLPyNepAofxbn72iZcsDyQ1x6vUM4kO8WhrcrJi
         /KiGog+181RKZYRo/JnjabPDMugXiVbZ8xQDo0y/sSrMWDCKqqhBL2Tj4891fp8vWSJh
         98+V80zBdsZkkV/ioGkdTSyIlrzzwrgcPSQ6JPuLIZ8bcbWdYw0Qqi+fHXbaZL6jSBEf
         1bWA==
X-Gm-Message-State: APjAAAUdqmtoVNtg6kvKCd6neaim63A+hz8HYOM9KocRJnrHoguBEjsF
        dM+XgK3xeVrd7f2Gq6D6iOFwyDz097MeS+HaUXg=
X-Google-Smtp-Source: APXvYqwYBQswftPfmWZSm4ljUIy4Yw8NBl3qUu96F4PF62/PiaAcp1ilvA2xn7v0Ad1vhj/TmnIG2HFu2KH6QRa0v00=
X-Received: by 2002:ad4:50a8:: with SMTP id d8mr19138820qvq.8.1570837038944;
 Fri, 11 Oct 2019 16:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRSmLtoqBrW40rVwazwC464ma_qjPxnJ3uobpfPRbCOagnnJQ@mail.gmail.com>
 <20191008081628.GA5526@metamorpher.de>
In-Reply-To: <20191008081628.GA5526@metamorpher.de>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 11 Oct 2019 16:37:07 -0700
Message-ID: <CAPhsuW4gLcQU+6BJWJ7Lda=d5UFjNk5R5KmQNp-BN8X+CnXwnw@mail.gmail.com>
Subject: Re: md/raid0: avoid RAID0 data corruption due to layout confusion. ?
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     "David F." <df7729@gmail.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Oct 8, 2019 at 1:17 AM Andreas Klauer
<Andreas.Klauer@metamorpher.de> wrote:
>
> On Tue, Oct 08, 2019 at 12:09:12AM -0700, David F. wrote:
> > Hi,
> >
> > "So we add a module parameter to allow the old (0) or new (1) layout
> > to be specified, and refused to assemble an affected array if that
> > parameter is not set."
>
> Not 100% sure about this but I think it's new (1) and old (2) vs. unset (0).
>
> You can set it like any other kernel/module parameter
> or with sysfs in /sys/module/raid0/parameters/default_layout
>
> > Why couldn't it use an integrity logic check to determine which layout
> > version is used so it just works?
>
> Define integrity logic check. Check what and how?
> Same reason why md can't decide correctness on parity mismatch.
>
> So unfortunately this is outsourced to the sysadmins great
> and unmatched wisdom. Which is a difficult choice to make,
> as if I understand correctly, the corruption would be at
> the end of the device where it's harder to notice than if
> the superblock at the start was missing...
>
> Unless you know the mismatch-size raid0 was created a long
> time ago or running off old kernel, try new first, then old.
>
> (
>     What happens if you happen to have one RAID of each type?
>     Shouldn't this be recorded in metadata then...?
> )

Thanks Andreas!

David, you may consider adding "raid0.default_layout=?" to your kernel
command line options.

Song
