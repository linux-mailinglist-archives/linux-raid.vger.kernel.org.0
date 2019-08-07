Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE07284492
	for <lists+linux-raid@lfdr.de>; Wed,  7 Aug 2019 08:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfHGGhE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 7 Aug 2019 02:37:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43995 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfHGGhE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 7 Aug 2019 02:37:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so15551740wru.10
        for <linux-raid@vger.kernel.org>; Tue, 06 Aug 2019 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UOTzIvTHyuYL5EsfJh2K8Yw6JipW2ciuvxj5LJOI/Y=;
        b=Hkn3/WpJcWrUR5amiC65KIPAo8sMspv3PSpDs3jG9GadiWTBrMaGhwp//rWJLT8m9w
         1PUr2Y9y48+b4xyk53kfqPRycdUlvxJ2XLLuQ0GUKpGm8IiP9x7brqpHTJePi8Y//fUh
         lKmNTr3d7pT13XSH9TKdE+KZ+v2kNWNFdBsWPvS7SwA08gsi1gl5mj3HfhP9vZBvs58k
         uur8DmaecgQp5Q27oN6U42ryNGDTe43SM/SdWLXESHRW/MhQ8cH6CGOSPkkEUS95wd3M
         PfQlXp8FrV/TUbIQZy5fRs5hV3kSv4nYjkVeHdPNkfxPlXvLpMuHfm4vqIO7a8fbHaZw
         FoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UOTzIvTHyuYL5EsfJh2K8Yw6JipW2ciuvxj5LJOI/Y=;
        b=OFMceWzvA9NjRm0SSSNkgGV+OIAmvaFRvbWf77lGZ0bA5q3ipn9ScFMtC2qYb/v22h
         33vDfyfaQa/PfjEngZf+ZofpxWd9c0Ck15bDBF/gz11b11/uv21sbCaZd787yICkdN/u
         6r58mrhhHkxl4JFfm12lqB7LAHl3mS9HVNcC+RYRmgyWEqYuP9HaieC3PZ4G+66Me2Hz
         qnT5TJpYQozqcY4fjEso8zQTv87FAptRB+/OCa9JBDcApIRbZF9aYmbScs40sLToAjUA
         GMtG487/Xpcw+FAtw/svPZLF7IA0rAW7jBZI8/iKzhUOQf46UV2ZOW/15Nt6sA7sQu+r
         hhIA==
X-Gm-Message-State: APjAAAXUE9lmil7mQ9DD6C439klRL95/DcAQi9lMlqTvcVvjOEwm5Z4b
        wqpjT0oOBoQ2+J/Pej0VaWgpewd/zYkSu1X13M0GWQ==
X-Google-Smtp-Source: APXvYqyieRhslHzasqKVzYVl3xiRFOWD7yVCmtxH+g86PNeQ3qbW6A6YKzk2bayCrGl9zePLwE+kvYii9QXyePKlJzk=
X-Received: by 2002:adf:ea87:: with SMTP id s7mr8888555wrm.24.1565159822192;
 Tue, 06 Aug 2019 23:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEkotpvVz8FA78vNFh0qZv3kEMNrXXfVPEUC=MhH0pMCZA@mail.gmail.com>
 <0a83fde3-1a74-684c-0d70-fb44b9021f96@molgen.mpg.de> <CAMGffE=_kPoBmSwbxvrqdqbhpR5Cu2Vbe4ArGqm9ns9+iVEH_g@mail.gmail.com>
 <CAMGffEkcXcQC+kjwdH0iVSrFDk-o+dp+b3Q1qz4z=R=6D+QqLQ@mail.gmail.com>
 <87h86vjhv0.fsf@notabene.neil.brown.name> <CAMGffEnKXQJBbDS8Yi0S5ZKEMHVJ2_SKVPHeb9Rcd6oT_8eTuw@mail.gmail.com>
 <CAMGffEkfs0KsuWX8vGY==1dym78d6wsao_otSjzBAPzwGtoQcw@mail.gmail.com> <87blx1kglx.fsf@notabene.neil.brown.name>
In-Reply-To: <87blx1kglx.fsf@notabene.neil.brown.name>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 7 Aug 2019 08:36:51 +0200
Message-ID: <CAMGffE=cpxumr0QqJsiGGKpmZr+4a0BiCx3n0_twa5KPs=yX1g@mail.gmail.com>
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

On Wed, Aug 7, 2019 at 1:40 AM NeilBrown <neilb@suse.com> wrote:
>
> On Tue, Aug 06 2019, Jinpu Wang wrote:
>
> > On Tue, Aug 6, 2019 at 9:54 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> >>
> >> On Tue, Aug 6, 2019 at 1:46 AM NeilBrown <neilb@suse.com> wrote:
> >> >
> >> > On Mon, Aug 05 2019, Jinpu Wang wrote:
> >> >
> >> > > Hi Neil,
> >> > >
> >> > > For the md higher write IO latency problem, I bisected it to these commits:
> >> > >
> >> > > 4ad23a97 MD: use per-cpu counter for writes_pending
> >> > > 210f7cd percpu-refcount: support synchronous switch to atomic mode.
> >> > >
> >> > > Do you maybe have an idea? How can we fix it?
> >> >
> >> > Hmmm.... not sure.
> >> Hi Neil,
> >>
> >> Thanks for reply, detailed result in line.
>
> Thanks for the extra testing.
> ...
> > [  105.133299] md md0 in_sync is 0, sb_flags 2, recovery 3, external
> > 0, safemode 0, recovery_cp 524288
> ...
>
> ahh - the resync was still happening.  That explains why set_in_sync()
> is being called so often.  If you wait for sync to complete (or create
> the array with --assume-clean) you should see more normal behaviour.
I've updated my tests accordingly, thanks for the hint.
>
> This patch should fix it.  I think we can do better but it would be more
> complex so no suitable for backports to -stable.
>
> Once you confirm it works, I'll send it upstream with a
> Reported-and-Tested-by from you.
>
> Thanks,
> NeilBrown

Thanks a lot, Neil, my quick test show, yes, it fixed the problem for me.

I will run more tests to be sure, will report back the test result.

Regards,
Jack Wang

>
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 24638ccedce4..624cf1ac43dc 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8900,6 +8900,7 @@ void md_check_recovery(struct mddev *mddev)
>
>         if (mddev_trylock(mddev)) {
>                 int spares = 0;
> +               bool try_set_sync = mddev->safemode != 0;
>
>                 if (!mddev->external && mddev->safemode == 1)
>                         mddev->safemode = 0;
> @@ -8945,7 +8946,7 @@ void md_check_recovery(struct mddev *mddev)
>                         }
>                 }
>
> -               if (!mddev->external && !mddev->in_sync) {
> +               if (try_set_sync && !mddev->external && !mddev->in_sync) {
>                         spin_lock(&mddev->lock);
>                         set_in_sync(mddev);
>                         spin_unlock(&mddev->lock);
