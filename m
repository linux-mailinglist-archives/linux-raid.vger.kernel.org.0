Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA18FD49
	for <lists+linux-raid@lfdr.de>; Fri, 16 Aug 2019 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfHPIK4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 04:10:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37882 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHPIK4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 16 Aug 2019 04:10:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so704931wrt.4
        for <linux-raid@vger.kernel.org>; Fri, 16 Aug 2019 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MS61GMgEvdHYUsX/D1TRCCawW8p8Qqopt15uSqVsXJY=;
        b=Y0WaWiAsWj46fzLNk/Pk0gg1cBEpKiTtG9ViFT+7Egli+OeoljqrIP2l00vNM64iHo
         N6F3+VxxeK3ilnbUrBoUj5t4ZOPkUtcxGtBbGUq48YlLWIUtumboc8S/DQw9tMFIa6ZN
         IiYMgeMsDdVAvOxwFYwMlkwivyiCtw5gZSEE6Trpuqq2JHCHldvD8yF0DFkiEfboJSqb
         6mf8wA34wB0R0oMrWzPHIEGkVTQQ2secG6Lnll1IomQRQTrUvacMAdWQFqglRF93HmQP
         Ex3HBc8K1O+05TmmMWjdfeufc4NoUCBcFl1GvxLxxPL4WjLVy3pvwz7+lBZuor5chmyZ
         0/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MS61GMgEvdHYUsX/D1TRCCawW8p8Qqopt15uSqVsXJY=;
        b=ea1Y8G7HIl4LZT51eO52zy1JVjJyZnnAQRrqBUIwLYONIoCg4jUdrVS3xT2yD5dHou
         s0/MQ58iWtSBloWkGqSc0+Rf+O8qN7ziBcQHpZD+ZwN7vYof1KBrzqSajreK8u412c+u
         w/csTIf4apm0J4BtCShRByreeWf41ihXbbnr55qwUDjspzlcGsnSH82DB8kpup7EMIC/
         NI5Eio6AJMJMUsDMn5X1rm6I3mXEUT1q0oqSxhL0H/uvTlBgMxxk+zo6u/UNQBmXvtPC
         Hr9Dbl/Cw6LSa6/76QG3b47xQu4kUlDF4pt5tHUmGVRlngDtUsiQOWIsgLAPkcO8r8Qt
         hkiQ==
X-Gm-Message-State: APjAAAUn9QYE+IF674LVTO+qEWcxafvmT2TdCRxrI61Tmk3PH/UvyMsd
        o/8D1FSeJlZ4vOFXQT0oxc4oazQmF2yQY6WUwzoibg==
X-Google-Smtp-Source: APXvYqwafOormkwlcyK+ZlFMv6/CTaDla48+B+XDU17HTGTU4m3SZ5JBPeSo9IVg/8m6HDIO35UgWA3sUADVHt57e7Q=
X-Received: by 2002:a5d:5701:: with SMTP id a1mr9260849wrv.95.1565943054219;
 Fri, 16 Aug 2019 01:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEkotpvVz8FA78vNFh0qZv3kEMNrXXfVPEUC=MhH0pMCZA@mail.gmail.com>
 <0a83fde3-1a74-684c-0d70-fb44b9021f96@molgen.mpg.de> <CAMGffE=_kPoBmSwbxvrqdqbhpR5Cu2Vbe4ArGqm9ns9+iVEH_g@mail.gmail.com>
 <CAMGffEkcXcQC+kjwdH0iVSrFDk-o+dp+b3Q1qz4z=R=6D+QqLQ@mail.gmail.com>
 <87h86vjhv0.fsf@notabene.neil.brown.name> <CAMGffEnKXQJBbDS8Yi0S5ZKEMHVJ2_SKVPHeb9Rcd6oT_8eTuw@mail.gmail.com>
 <CAMGffEkfs0KsuWX8vGY==1dym78d6wsao_otSjzBAPzwGtoQcw@mail.gmail.com>
 <87blx1kglx.fsf@notabene.neil.brown.name> <CAMGffE=cpxumr0QqJsiGGKpmZr+4a0BiCx3n0_twa5KPs=yX1g@mail.gmail.com>
 <CAMGffEm41+-DvUu_MhfbVURL_LOY8KP1QkTWDcFf7nyGLK7Y3A@mail.gmail.com>
In-Reply-To: <CAMGffEm41+-DvUu_MhfbVURL_LOY8KP1QkTWDcFf7nyGLK7Y3A@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 16 Aug 2019 10:10:43 +0200
Message-ID: <CAMGffEn8FkjoQjno0kDzQcr6pcSXr3PGGfsErnhv0HN0+zEwhg@mail.gmail.com>
Subject: Re: Bisected: Kernel 4.14 + has 3 times higher write IO latency than
 Kernel 4.4 with raid1
To:     NeilBrown <neilb@suse.com>
Cc:     Neil F Brown <nfbrown@suse.com>,
        Alexandr Iarygin <alexandr.iarygin@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Aug 7, 2019 at 2:35 PM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> On Wed, Aug 7, 2019 at 8:36 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> >
> > On Wed, Aug 7, 2019 at 1:40 AM NeilBrown <neilb@suse.com> wrote:
> > >
> > > On Tue, Aug 06 2019, Jinpu Wang wrote:
> > >
> > > > On Tue, Aug 6, 2019 at 9:54 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> > > >>
> > > >> On Tue, Aug 6, 2019 at 1:46 AM NeilBrown <neilb@suse.com> wrote:
> > > >> >
> > > >> > On Mon, Aug 05 2019, Jinpu Wang wrote:
> > > >> >
> > > >> > > Hi Neil,
> > > >> > >
> > > >> > > For the md higher write IO latency problem, I bisected it to these commits:
> > > >> > >
> > > >> > > 4ad23a97 MD: use per-cpu counter for writes_pending
> > > >> > > 210f7cd percpu-refcount: support synchronous switch to atomic mode.
> > > >> > >
> > > >> > > Do you maybe have an idea? How can we fix it?
> > > >> >
> > > >> > Hmmm.... not sure.
> > > >> Hi Neil,
> > > >>
> > > >> Thanks for reply, detailed result in line.
> > >
> > > Thanks for the extra testing.
> > > ...
> > > > [  105.133299] md md0 in_sync is 0, sb_flags 2, recovery 3, external
> > > > 0, safemode 0, recovery_cp 524288
> > > ...
> > >
> > > ahh - the resync was still happening.  That explains why set_in_sync()
> > > is being called so often.  If you wait for sync to complete (or create
> > > the array with --assume-clean) you should see more normal behaviour.
> > I've updated my tests accordingly, thanks for the hint.
> > >
> > > This patch should fix it.  I think we can do better but it would be more
> > > complex so no suitable for backports to -stable.
> > >
> > > Once you confirm it works, I'll send it upstream with a
> > > Reported-and-Tested-by from you.
> > >
> > > Thanks,
> > > NeilBrown
> >
> > Thanks a lot, Neil, my quick test show, yes, it fixed the problem for me.
> >
> > I will run more tests to be sure, will report back the test result.
> Hi Neil,
>
> I've run our regression tests with your patch, everything works fine
> as expected.
>
> So Reported-and-Tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> Thank you for your quick fix.
>
> The patch should go to stable 4.12+

Hi Neil,

I hope you're doing well, just a soft ping? do you need further
testing from my side?

Please let me know how can we move the fix forward.

Thanks,
Jack Wang
