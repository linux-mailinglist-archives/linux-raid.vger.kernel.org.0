Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1729984BB6
	for <lists+linux-raid@lfdr.de>; Wed,  7 Aug 2019 14:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfHGMfe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 7 Aug 2019 08:35:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41581 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfHGMfe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 7 Aug 2019 08:35:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so87985672wrm.8
        for <linux-raid@vger.kernel.org>; Wed, 07 Aug 2019 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzfiKrOfhO3DLsT1TlErtHyd7ui9YJUBIjOmwytOTlI=;
        b=GVi7fMSAjlMO9idivA3+c6CjKv4HWaNruHvJBIQSMbDCDgCMLDr7pl9xz5LQzuFgrt
         /wkrhUnI4jRlhCJ1oajcqv2Wd8f3itiCuT2ZZQultAoxeEKSm5vQ0Q9ZSeA0g9YoHFk/
         NyG7WP0Q5BUNG02hgQmPYaBHNW7vV80/NE09Cz1IQ+NBy8/u2hU4eDDpXOAjC465i9zM
         mlHUUMWRBSwsxTE7bzGEjg5eTHCk6pxVnWpV/1POYLXj7BjFg17ECg1irV8VfPpTJEI4
         HBJdcWcFtjR2FqWrbXOc5uEC/tDYLerIbUy0830FyGZ1NTIwSVnAWFLgd2BtkhDxdN8/
         umVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzfiKrOfhO3DLsT1TlErtHyd7ui9YJUBIjOmwytOTlI=;
        b=cyHnn/VaJM/M+/lBVXv0KEWhoDYV0zJzyM2MBcLAK6sy9vdRtuSoAtTFgn2ZWUNVgo
         V0Z5fFYIxECLJg63gY7btCkn0Y7pEmI7h1STp1bp1QTbdKzQ+H1ORPEA0wE1YVz/k4bT
         jNoB5/thGsc3zaUkt2EeJ7WYGdWZLnpRRa59gDrOGooH/TzMEHoBjuTpCRtJi0LLFJMz
         3dyf5LgbgjP3dk5Xvu/7pL928B9oEVufahgdCXDyV5QRajyEZiMwWQ7AejM3VF8BpD8u
         D3aruwi0RuZ8+GgOs5qxbJXnSzy0J1EDxWUbE7ft4lS3158V2wJsE3FqklQ4oNSzv8zc
         ma3w==
X-Gm-Message-State: APjAAAVEmqT06OrTgzTtdQOE79FqlsVKXgie9Es6lm5vl67OU18c8VNm
        scNwv9098+7lDYMmQDr2xt/7wXzPpeZmpqxIjWCTLQ==
X-Google-Smtp-Source: APXvYqwdbQmIHPnEVap4ssVFw6r+F1SKoVRLrwBJRqCX8DzyReJycSvWfGErwOXUDFFaO+UUv1taWQ6Ma8eIk9nIuWs=
X-Received: by 2002:adf:f204:: with SMTP id p4mr11158616wro.317.1565181331907;
 Wed, 07 Aug 2019 05:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEkotpvVz8FA78vNFh0qZv3kEMNrXXfVPEUC=MhH0pMCZA@mail.gmail.com>
 <0a83fde3-1a74-684c-0d70-fb44b9021f96@molgen.mpg.de> <CAMGffE=_kPoBmSwbxvrqdqbhpR5Cu2Vbe4ArGqm9ns9+iVEH_g@mail.gmail.com>
 <CAMGffEkcXcQC+kjwdH0iVSrFDk-o+dp+b3Q1qz4z=R=6D+QqLQ@mail.gmail.com>
 <87h86vjhv0.fsf@notabene.neil.brown.name> <CAMGffEnKXQJBbDS8Yi0S5ZKEMHVJ2_SKVPHeb9Rcd6oT_8eTuw@mail.gmail.com>
 <CAMGffEkfs0KsuWX8vGY==1dym78d6wsao_otSjzBAPzwGtoQcw@mail.gmail.com>
 <87blx1kglx.fsf@notabene.neil.brown.name> <CAMGffE=cpxumr0QqJsiGGKpmZr+4a0BiCx3n0_twa5KPs=yX1g@mail.gmail.com>
In-Reply-To: <CAMGffE=cpxumr0QqJsiGGKpmZr+4a0BiCx3n0_twa5KPs=yX1g@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 7 Aug 2019 14:35:20 +0200
Message-ID: <CAMGffEm41+-DvUu_MhfbVURL_LOY8KP1QkTWDcFf7nyGLK7Y3A@mail.gmail.com>
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

On Wed, Aug 7, 2019 at 8:36 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> On Wed, Aug 7, 2019 at 1:40 AM NeilBrown <neilb@suse.com> wrote:
> >
> > On Tue, Aug 06 2019, Jinpu Wang wrote:
> >
> > > On Tue, Aug 6, 2019 at 9:54 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> > >>
> > >> On Tue, Aug 6, 2019 at 1:46 AM NeilBrown <neilb@suse.com> wrote:
> > >> >
> > >> > On Mon, Aug 05 2019, Jinpu Wang wrote:
> > >> >
> > >> > > Hi Neil,
> > >> > >
> > >> > > For the md higher write IO latency problem, I bisected it to these commits:
> > >> > >
> > >> > > 4ad23a97 MD: use per-cpu counter for writes_pending
> > >> > > 210f7cd percpu-refcount: support synchronous switch to atomic mode.
> > >> > >
> > >> > > Do you maybe have an idea? How can we fix it?
> > >> >
> > >> > Hmmm.... not sure.
> > >> Hi Neil,
> > >>
> > >> Thanks for reply, detailed result in line.
> >
> > Thanks for the extra testing.
> > ...
> > > [  105.133299] md md0 in_sync is 0, sb_flags 2, recovery 3, external
> > > 0, safemode 0, recovery_cp 524288
> > ...
> >
> > ahh - the resync was still happening.  That explains why set_in_sync()
> > is being called so often.  If you wait for sync to complete (or create
> > the array with --assume-clean) you should see more normal behaviour.
> I've updated my tests accordingly, thanks for the hint.
> >
> > This patch should fix it.  I think we can do better but it would be more
> > complex so no suitable for backports to -stable.
> >
> > Once you confirm it works, I'll send it upstream with a
> > Reported-and-Tested-by from you.
> >
> > Thanks,
> > NeilBrown
>
> Thanks a lot, Neil, my quick test show, yes, it fixed the problem for me.
>
> I will run more tests to be sure, will report back the test result.
Hi Neil,

I've run our regression tests with your patch, everything works fine
as expected.

So Reported-and-Tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>

Thank you for your quick fix.

The patch should go to stable 4.12+

Regards,
Jack Wang

>
> Regards,
> Jack Wang
>
> >
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 24638ccedce4..624cf1ac43dc 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -8900,6 +8900,7 @@ void md_check_recovery(struct mddev *mddev)
> >
> >         if (mddev_trylock(mddev)) {
> >                 int spares = 0;
> > +               bool try_set_sync = mddev->safemode != 0;
> >
> >                 if (!mddev->external && mddev->safemode == 1)
> >                         mddev->safemode = 0;
> > @@ -8945,7 +8946,7 @@ void md_check_recovery(struct mddev *mddev)
> >                         }
> >                 }
> >
> > -               if (!mddev->external && !mddev->in_sync) {
> > +               if (try_set_sync && !mddev->external && !mddev->in_sync) {
> >                         spin_lock(&mddev->lock);
> >                         set_in_sync(mddev);
> >                         spin_unlock(&mddev->lock);
