Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7347CF23C3
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2019 01:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbfKGA5z (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Nov 2019 19:57:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42797 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfKGA5z (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 Nov 2019 19:57:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id n5so263997ljc.9
        for <linux-raid@vger.kernel.org>; Wed, 06 Nov 2019 16:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADT+a0qYDXuewdfXPkS3ftLLkYqnoQb9hQG3p9dU2hg=;
        b=bjrqqdWTnXapwuVCYv5rZQ/hQv1EpMpQsqNA32XbgENHIQ5bTi4K0ZAiM+dwP8bukx
         FC65wJdOMVQizhjVBZPerluIgOj+ZLqvL7k7vmfiDCFcUN1KrKBITpqK0oYK5EHF3DLA
         nK8GlD+xCpWKZSGCYge8CD8OFyQzaRy4TH2SDcMmx1yA/MRo0YpEDt4FVh0L1Q0o/uXr
         /uZfM1TjUOPVhxqvNEDixUDeiKGxCpztla0o5p/nIKKBiYbhLwJ0qfrve9oXRUYIJM6D
         nBhh0Hd58TISa57wMRsIAwlQNxA6aJaxaW9WlrSInueGL34hBDoXlhwR9rDvW9BM3M2J
         SGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADT+a0qYDXuewdfXPkS3ftLLkYqnoQb9hQG3p9dU2hg=;
        b=CB9udpSBQnr6+UAQa+CXt1ovBzxkDsMLKdi6wU2QD9Vgg7HKYaCUHfT8jwci6tQqZ4
         K4O4WTZHNnCtNmZg9FfkJvQa7QNLhdpBhqTxCFScp2sUihpyMLL0HuncVdbhfbDZzV4M
         Q5eUQAdcsalDvZOeixIc8xtJUm/yFJWewVWPHG97e360ZvaH++IkmECaGGTS/i7RKnoH
         P/lCUzvPbIA9cKd3sL0F+cwNzh0mKTuOHDYJKvKnzY6IdOIgB9CJ5Bo9e0FK0sM11EDw
         GXKVVkc0yorD43fPerkI7+2fYQ+NW5QYfdaotytK1y5BAp4Bz5eGhJapbC75ls+7Wi+v
         7CNg==
X-Gm-Message-State: APjAAAVfgqpzufdcYh0wmWYL+KmN6Fs98hV8clrFeuUL2/TxpVc+k24D
        cwsT4RQgKeL0pc5CBvhvR1k0LE7jR/zUW81X/aM=
X-Google-Smtp-Source: APXvYqyqaBAVjYW+g27Q56pIHCVuDC9ooC4SgCPof6jJJgkIeGRErZ097Edsnkkd9ZIogJ++jJF6lTRk8ROzzaIsJXI=
X-Received: by 2002:a2e:9981:: with SMTP id w1mr183876lji.205.1573088271984;
 Wed, 06 Nov 2019 16:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20191104200157.31656-1-ncroxon@redhat.com> <5DC0C34B.1040102@youngman.org.uk>
 <dc736544-465e-f4eb-ca6d-e7b135074839@redhat.com> <5DC2FA31.6060503@youngman.org.uk>
In-Reply-To: <5DC2FA31.6060503@youngman.org.uk>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Wed, 6 Nov 2019 18:57:40 -0600
Message-ID: <CAAMCDeeki_a8cXaOGKynBjzUwdkj3bqLndowAK00gPQs++-goQ@mail.gmail.com>
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Nigel Croxon <ncroxon@redhat.com>,
        Linux RAID <linux-raid@vger.kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

A lot would depend on what you get back from the disk.  If it reports
an actual confirmed media error generally it means the disk tried up
to it set time, if you get a failed to respond that would be something
to retry, but I think a failure to respond is not generally retried.
At one second with a average seek time of 10ms that means it attempted
to reread that sector close to 100 times without success.   Generally
the timeouts are 7 seconds if one does not change it so 700 or so
retries.   And for that timeout the application stops responding and 7
seconds is a long time.  Now if one wanted to add in retries one could
configured multipath to operate over the disks (with a single path)
and set the retry rules inside it.  I accidentally tested that as a
version of fedora a few years ago installed and enabled multipath and
when my raid machine booted up 1/2 of the raid6 disks were running
through multipath and 1/2 of them were not (race condition).  I did
not notice it for several days as it was cleanly working.

Error risks:
Assuming a disk fails 32k sections as a group (mine seem to almost
always re-write 8 sections of 8x512 each). so I am going to make
assumption that the disk is playing some sort of internal games, but
if it really is only 4k then all of the numbers below get much much
better.

Further assuming you have 1000 bad blocks on a disk and it is a 1tb
disk, then you have 31,250,000 sectors.    So the odds of hitting a
bad sector in the same part of another disk when you one error is
(disk_count*1000)/31250000, or about 1 in 4000.    Now while that
seems high, I would say that having all 8 disks with an average error
count of 1000 bad sectors on it would mean that your disks really
should have been replaced a long time ago.     When I have had disks
really acting badly typically only one disks has higher error counts
and one other has only a few, and the rest are clean.  The more
realistic would be 100 errors only on 2 disks reducing the odds to  1
in 156000.   And this is for the raid5 case, the raid6 case were one
needs to have 3 bad sectors at the same spot in the disk is much
safer.   And if you do happen to hit a 2 bad sectors in the raid5 case
the array will stop and you can then force it back online with all
disks.  The raid5 case is rather risky if one completely fails as disk
as then if you have any other bad sectors you have lost data, so I
don't know that I would ever run the raid5 case with spinning disks
anymore, this case is probably the most likely case one will run into
causing data loss.

On Wed, Nov 6, 2019 at 10:53 AM Wols Lists <antlists@youngman.org.uk> wrote:
>
> On 05/11/19 22:46, Nigel Croxon wrote:
> >
> > On 11/4/19 7:33 PM, Wols Lists wrote:
> >> On 04/11/19 20:01, Nigel Croxon wrote:
> >>> The MD driver for level-456 should prevent re-reading read errors.
> >>>
> >>> For redundant raid it makes no sense to retry the operation:
> >>> When one of the disks in the array hits a read error, that will
> >>> cause a stall for the reading process:
> >>> - either the read succeeds (e.g. after 4 seconds the HDD error
> >>> strategy could read the sector)
> >>> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
> >>> seconds (might be even longer)
> >> Okay, I'm being completely naive here, but what is going on? Are you
> >> saying that if we hit a read error, we just carry on, ignore it, and
> >> calculate the missing block from parity?
> >>
> >> If so, what happens if we hit two errors on a raid-5, or 3 on a raid-6,
> >> or whatever ... :-)
> >>
> >> Cheers,
> >> Wol
> >
> > This allows the device (disk) to fail faster.  All logic is the same.
> >
> > If there is a read error, it does not retry that read, it calculates
> >
> > the data from the other disks.  This patch removes the retry.
> >
> Ummm ...
>
> I suspect there is a very good reason for the retry ...
>
> Bear in mind I don't actually KNOW anything, you'll need to check with
> someone who knows about these things, but I get the impression that
> transient errors aren't that uncommon. It fails, you try again, it succeeds.
>
> So if you're going to go down that route, by all means re-calculate from
> parity if ONE read fails, but if you get more failures such that the
> raid fails, you need to retry those reads because there is a good chance
> they will succeed second time round.
>
> Cheers,
> Wol
>
