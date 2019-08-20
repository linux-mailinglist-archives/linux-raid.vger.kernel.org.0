Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87BC96BA0
	for <lists+linux-raid@lfdr.de>; Tue, 20 Aug 2019 23:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfHTVlV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 20 Aug 2019 17:41:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45008 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTVlV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 20 Aug 2019 17:41:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id d79so12486qke.11
        for <linux-raid@vger.kernel.org>; Tue, 20 Aug 2019 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=too+BMVgpfw83aAALw2P+Zlqh4hDkfhUAosim4dvYjg=;
        b=Q7RM3oFmIHp6TS+64BunlCxmdCbsxQiJTpZEQ8+Ywnp6HBHcOXbSNMftpvk7CHVSTY
         cnJce+CiXeSMZRz//0ReSNR4gx0P6dDXvjLcWJ0sYeRcE6tItcZx8QwjdMttef8kDkXw
         TN1gTrp1rPNwL9SMPrQJ7IHUxyz2VV1Yk5pCYoByDF+DP8fk8gEtc5fjJAnePqu9KAn7
         BQlf+nKaNx0XJv2ZcUPLOybmEvKso/NTPIcnLETCUNAu6phvQEvtFlHdywSWj8qEmBJf
         LK063l3n+OM7QQI8DCDyQ0QWtiuX2iOasCTEQ+5P2E7AKGi/v9gsJS4ez5pwtopqH+oh
         aqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=too+BMVgpfw83aAALw2P+Zlqh4hDkfhUAosim4dvYjg=;
        b=C/nx1mgVHAUmvOIDFOcUsj9Y8vmwuKJK9WvfwhKFiOfq/1NWDVi96UKngl0Xfg79BB
         /kzuK3BzkOsgEZcAQtBLtX3U5wA3eA72iVFxrAnhoR4rkpKk9mqRDwFljseNuYOG0pkH
         XOdVyoVPXTAvEouhOgB0YaAe7JKylWpKvsf1gq3IWyQ03HnKqfk3L9gJankyF+mjIIWx
         0JQ7d7vF5sflJWMzmVUenBbHMs3bIOiwjWZA+4pbo1K9ArSyluNningSGLtN6KT4qmcZ
         6cGblTm6bBz77Ez6ReivI9CNRzngLkeQnI/YmJjOMGLYK9gmFGuTuYWmuY4Rxc8NEXP5
         OHPg==
X-Gm-Message-State: APjAAAWys+6nZXgbgckNOl1ab1ONNhS8N+JwfnYJ0Fh2R8YOYWCiZf7i
        h3wFYQr9xZMZR/WUZ5se6qhnejQphzCgriKZ6SxhbqhZ
X-Google-Smtp-Source: APXvYqyq2+IHKl77tKW0NA4UDWnknqDXwjinYvkakNdVeqkfAIQ6cqoW0vDGeFBXJiOg3yU0JghII7QmF9EZgcjy+lE=
X-Received: by 2002:ae9:e714:: with SMTP id m20mr26978186qka.72.1566337280784;
 Tue, 20 Aug 2019 14:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190812153039.13604-1-ncroxon@redhat.com> <f79ead58-9feb-4b0b-5f29-fd1a4f10342f@redhat.com>
 <CAPhsuW5+vk4Ln84JSe-QEt-O2xee9d63B8aGEpxFLVfZWADEfA@mail.gmail.com>
 <875zmxj3cf.fsf@notabene.neil.brown.name> <9770f0c0-58a3-c283-02c0-25c0f94dc514@redhat.com>
 <CAPhsuW4T-ccC_kCycyuYENj2918aUDN9w6kt-eN_-K4761UTPQ@mail.gmail.com> <23c37f55-db8e-07f7-9229-b8ea705e4d63@redhat.com>
In-Reply-To: <23c37f55-db8e-07f7-9229-b8ea705e4d63@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 20 Aug 2019 14:41:09 -0700
Message-ID: <CAPhsuW5M+Z3ExvOn9xi7rYJDRzoXwCJwb63MCMFsoVhczaQYcA@mail.gmail.com>
Subject: Re: [PATCH] raid5 improve too many read errors msg by adding limits
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     NeilBrown <neilb@suse.com>, Xiao Ni <xni@redhat.com>,
        Neil F Brown <nfbrown@suse.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Aug 20, 2019 at 7:30 AM Nigel Croxon <ncroxon@redhat.com> wrote:
>
>
> On 8/16/19 7:52 PM, Song Liu wrote:
> > On Fri, Aug 16, 2019 at 10:02 AM Nigel Croxon <ncroxon@redhat.com> wrote:
> > [...]
> >> [  +0.000008] md/raid:md127: 793 read_errors, > 781 stripes
> >> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000018] md/raid:md127: 794 read_errors, > 781 stripes
> >> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000009] md/raid:md127: 795 read_errors, > 781 stripes
> >> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000008] md/raid:md127: 796 read_errors, > 781 stripes
> >> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000018] md/raid:md127: 797 read_errors, > 781 stripes
> >> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000008] md/raid:md127: 798 read_errors, > 781 stripes
> >> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000017] md/raid:md127: 799 read_errors, > 781 stripes
> >> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000008] md/raid:md127: 800 read_errors, > 781 stripes
> >> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000008] md/raid:md127: 801 read_errors, > 781 stripes
> >> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000021] md/raid:md127: 802 read_errors, > 781 stripes
> >> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000009] md/raid:md127: 803 read_errors, > 781 stripes
> >> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000009] md/raid:md127: 804 read_errors, > 781 stripes
> >> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.000008] md/raid:md127: 805 read_errors, > 781 stripes
> >> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> >> [  +0.928614] md: md127: requested-resync interrupted.
> >>
> > This is a little too noisy. How about we only pr_warn() for
> > test_bit(Faulty) == 0?
> > (This is not directly related to this patch, but since we are at it).
> >
> > Thanks,
> > Song
> From: Nigel Croxon <ncroxon@redhat.com>
> Date: Mon, 19 Aug 2019 16:01:04 -0400
> Subject: [PATCH]  raid5 improve too many read errors msg by adding limits
>
> Often limits can be changed by admin. When discussing such things
> it helps if you can provide "self-sustained" facts. Also
> sometimes the admin thinks he changed a limit, but it did not
> take effect for some reason or he changed the wrong thing.
>
> V3: Only pr_warn when Faulty is 0.
> V2: Add read_errors value to pr_warn.
>
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
> ---
>   drivers/md/raid5.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 7fde645d2e90..6812cefea308 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -2557,10 +2557,15 @@ static void raid5_end_read_request(struct bio * bi)
>                   (unsigned long long)s,
>                   bdn);
>           } else if (atomic_read(&rdev->read_errors)
> -             > conf->max_nr_stripes)
> -            pr_warn("md/raid:%s: Too many read errors, failing device
> %s.\n",
> -                   mdname(conf->mddev), bdn);
> -        else
> +            > conf->max_nr_stripes) {
> +            if (!test_bit(Faulty, &rdev->flags)) {
> +                pr_warn("md/raid:%s: %d read_errors, > %d stripes\n",
> +                   mdname(conf->mddev), atomic_read(&rdev->read_errors),
> +                   conf->max_nr_stripes);
> +                pr_warn("md/raid:%s: Too many read errors, failing
> device %s.\n",
> +                   mdname(conf->mddev), bdn);
> +            }
> +        } else
>               retry = 1;
>           if (set_bad && test_bit(In_sync, &rdev->flags)
>               && !test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
> --

This looks good, but I have got some git issue applying the patch.

Please double check with ./scripts/checkpatch.pl and resend with git-send-email.

Thanks,
Song
