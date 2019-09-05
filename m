Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD1CAA8F2
	for <lists+linux-raid@lfdr.de>; Thu,  5 Sep 2019 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbfIEQ0Z (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Sep 2019 12:26:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46860 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfIEQ0Y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Sep 2019 12:26:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id v11so3437356qto.13
        for <linux-raid@vger.kernel.org>; Thu, 05 Sep 2019 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xLxgGxcnSJhBLp0gDmsm+FbnHl+MentOIYTzeAqTfcY=;
        b=Jn3IO+eHCEvSJRJwH5lThc3IEvh0jKGOagoyw4bU9qMej4J6LD5IM3vKlXyM3eC0o1
         O6nUtRy46k6PVhazh8wSIwoh3xb77x5+tR2jh6Ran7xrCigea1pccnfBg+b6WiE2J3Aj
         CyQQTbZBsgysgz2SqK0t3F5OlyOHJc/Ol2xXV45VnFvOyAheQyHe9ihEmd1IOBxENY4s
         u+CyUIML3vbJecxD9o9/6WKKfHB0D0J5Gl/5VWJvobhKv1E3fHs5YmUfqDAsOPkRODuz
         zgIGYC8nkFtbvPYKPl/nsusMjZPgWnhEYW+AZrhOlj/L96EwuCYAGJeYeoszooU8Nbw6
         3RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLxgGxcnSJhBLp0gDmsm+FbnHl+MentOIYTzeAqTfcY=;
        b=Ok94YZ1rfWwHCufRJMvRz67U8hiQxGLJVd429gf9ev/s7WL4aTuvKPNFC2bw9+Rgsd
         Uiqv9CSyHPVlbm9xjH3hGOX8+3MLbCaP03xN4SgoV8KFM0i07fAWWxMMmdchoi9i/LOl
         x9kOBA17dlUYq/W5Huj4q33ioV3vYm9m8jhs6ATlPelpa79LoBL8J3/caKIeGrpiCQwF
         86t9CraU6q1gAhIrrrPbxvQGKIWLjjNF6qqcZ3pKf/46Zu8Ab1AVc1vuzuxCIdDHzuOZ
         uTufrGW/sHH1ZIPbTqMEQwLOtUaEUQtyoZHsUILklZpyQYSKMVHZPcIt2c8d2tkwu3fH
         xrrw==
X-Gm-Message-State: APjAAAUYRSgDEGFjimX0txZUb/813VX/mKhQ0YnDS+Hdmw4BNv9EiEpO
        61noG8atGaWmzfTNNdzsbpL5RQvpooKGyRE76p4=
X-Google-Smtp-Source: APXvYqyyaNOiad+TwlRxQ3Eo3KsqRqoYfiW0tTJTu0ByVQp5Qpjyf6LfyBpAFjChrEKJDiqwrTsMb1xrbpZ35UYbtp4=
X-Received: by 2002:ac8:c86:: with SMTP id n6mr4344592qti.345.1567700783606;
 Thu, 05 Sep 2019 09:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <9dd94796-4398-55c5-b4b6-4adfa2b88901@redhat.com> <fc3391a1-2337-4f9a-1f09-8a0882000084@redhat.com>
In-Reply-To: <fc3391a1-2337-4f9a-1f09-8a0882000084@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 5 Sep 2019 09:26:12 -0700
Message-ID: <CAPhsuW6ndXAHBnH_-ne2GvWyGVZFgFc5LQ=da+BF-_Us2tD_AA@mail.gmail.com>
Subject: Re: raid6 with dm-integrity should not cause device to fail
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Sep 5, 2019 at 6:10 AM Nigel Croxon <ncroxon@redhat.com> wrote:
>
> On 6/20/19 7:31 AM, Nigel Croxon wrote:
> > Hello All,
> >
> > When RAID6 is set up on dm-integrity target that detects massive
> > corruption, the leg will be ejected from the array.  Even if the issue
> > is correctable with a sector re-write and the array has necessary
> > redundancy to correct it.
> >
> > The leg is ejected because it runs up the rdev->read_errors beyond
> > conf->max_nr_stripes (600).
> >
> > The return status in dm-crypt when there is a data integrity error is
> > BLK_STS_PROTECTION.
> >
> > I propose we don't increment the read_errors when the bi->bi_status is
> > BLK_STS_PROTECTION.
> >
> >
> >  drivers/md/raid5.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> > index b83bce2beb66..ca73e60e33ed 100644
> > --- a/drivers/md/raid5.c
> > +++ b/drivers/md/raid5.c
> > @@ -2526,7 +2526,8 @@ static void raid5_end_read_request(struct bio * bi)
> >          int set_bad = 0;
> >
> >          clear_bit(R5_UPTODATE, &sh->dev[i].flags);
> > -        atomic_inc(&rdev->read_errors);
> > +        if (!(bi->bi_status == BLK_STS_PROTECTION))
> > +            atomic_inc(&rdev->read_errors);
> >          if (test_bit(R5_ReadRepl, &sh->dev[i].flags))
> >              pr_warn_ratelimited(
> >                  "md/raid:%s: read error on replacement device (sector
> > %llu on %s).\n",
>
>
> I'm up against this wall again.  We should continue to count errors
> returned by the lower layer,
>
> but if those errors are -EILSEQ, instead of -EIO, MD should not mark the
> device as failed.
>

Sorry for the very late reply.

I think the change is on the right direction. Please submit official patch so
we can discuss the details.

Thanks,
Song
