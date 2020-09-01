Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA6C2587A3
	for <lists+linux-raid@lfdr.de>; Tue,  1 Sep 2020 07:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgIAFpn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Sep 2020 01:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgIAFpl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 1 Sep 2020 01:45:41 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3BCF2098B
        for <linux-raid@vger.kernel.org>; Tue,  1 Sep 2020 05:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598939141;
        bh=bgKCrpVs0kvIAN7ST4m7JCJqxroSTcI7AdqIdhFqvSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lKz/eyF09NQSsmeTvBmkdl63guQI2DakeMY/bSio1NK9VOvDj0cYqtbi9VtcBj/k0
         OXLet1d2/WBC0q1DtPffEi/Ub7azUnl9SMq0WptloRUKKUkHIQUeIqnh9G1gqS1ZVg
         AJNkSvixILDaKKOSyEpolJw2uqmNqsUlA5oBa+88=
Received: by mail-lj1-f180.google.com with SMTP id b19so1713052lji.11
        for <linux-raid@vger.kernel.org>; Mon, 31 Aug 2020 22:45:40 -0700 (PDT)
X-Gm-Message-State: AOAM531K27skb5y5jdPtADP6ntl94wsX0J/s40Mb8zQc3J91hzSE4nHL
        blHFtrOA02YonD69j37dZF3VU3rgBYYCPgf5gGA=
X-Google-Smtp-Source: ABdhPJy8+pHpKUkg5Dy8EdTyLGYwRMr81L+S/mJRHz256UtA+Q0aLNneN9GgWNk3EAjjo1J49aQwaQIXW02F5KuJBsk=
X-Received: by 2002:a2e:9c15:: with SMTP id s21mr102924lji.27.1598939139219;
 Mon, 31 Aug 2020 22:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <1598334183-25301-1-git-send-email-xni@redhat.com>
 <1598334183-25301-5-git-send-email-xni@redhat.com> <CAPhsuW55WD0iNSEtu9xwV4zEDWxAu_ycMM6ecpoz_DXcooeMLw@mail.gmail.com>
 <4ae2de9d-86ad-cb41-243f-bc9859e0165f@redhat.com> <7a352087-c84b-b263-5138-32ce50ecb0ac@redhat.com>
In-Reply-To: <7a352087-c84b-b263-5138-32ce50ecb0ac@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 31 Aug 2020 22:45:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4EhUdK_D=CENz9wud8R+9juz77hGrinOztec8fgGFfUQ@mail.gmail.com>
Message-ID: <CAPhsuW4EhUdK_D=CENz9wud8R+9juz77hGrinOztec8fgGFfUQ@mail.gmail.com>
Subject: Re: [PATCH V5 4/5] md/raid10: improve raid10 discard request
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Coly Li <colyli@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Aug 31, 2020 at 7:36 AM Xiao Ni <xni@redhat.com> wrote:
>
>
>
> On 08/31/2020 04:37 PM, Xiao Ni wrote:
> >
> >
> > On 08/29/2020 06:16 AM, Song Liu wrote:
> >> On Mon, Aug 24, 2020 at 10:43 PM Xiao Ni <xni@redhat.com> wrote:
> >> [...]
> >>> ---
> >>>   drivers/md/raid10.c | 254
> >>> +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>>   1 file changed, 253 insertions(+), 1 deletion(-)
> >>>
> >> [...]
> >>> +
> >>> +static void raid10_end_discard_request(struct bio *bio)
> >>> +{
> >>> +       struct r10bio *r10_bio = bio->bi_private;
> >>> +       struct r10conf *conf = r10_bio->mddev->private;
> >>> +       struct md_rdev *rdev = NULL;
> >>> +       int dev;
> >>> +       int slot, repl;
> >>> +
> >>> +       /*
> >>> +        * We don't care the return value of discard bio
> >>> +        */
> >>> +       if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
> >>> +               set_bit(R10BIO_Uptodate, &r10_bio->state);
> >> We don't need the test_bit(), just do set_bit().
> > Coly suggested to do test_bit first to avoid write memory. If there
> > are so many requests and the
> > requests fail, this way can improve performance very much.
> >
> > But it doesn't care the return value of discard bio. So it should be
> > ok that doesn't set R10BIO_Uptodate here.
> > I'll remove these codes. What do you think?
>
> Hi Song
>
> Sorry, for this problem, it still needs to set R10BIO_Uptodate. Because
> in function raid_end_bio_io it needs to use this
> flag to justify whether set BLK_STS_IOERR or not. So is it ok to test
> this bit first before setting this bit here?
>
Let's keep the test_bit() and set_bit().

Please send fixes on top of 1/5. I will handle them when I apply the patch.

Thanks,
Song
