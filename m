Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E6E228D06
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 02:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgGVARl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Jul 2020 20:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgGVARl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Jul 2020 20:17:41 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02449206F2
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 00:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595377060;
        bh=tSs+7ub+Y76F1aHPXVNMz1qWdGVcVB2BhHZ1WTxL1N0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h2v+Kr6XdbJBTLa9th0R2+j+/XqY4vdDer970w0HjdUvJZ6Z89n/5SCinWVwOVnsX
         5pmx/enqXGpdCbj1ear96cMnh4Zfd+sM7fX/pgPEAEb/IdARzJpXYpfcJbdNKvH3ZL
         WeIW0BG1A9EDwPhjv1TromdpZ/VsfjYA4lKVzg8o=
Received: by mail-lj1-f170.google.com with SMTP id b25so584791ljp.6
        for <linux-raid@vger.kernel.org>; Tue, 21 Jul 2020 17:17:39 -0700 (PDT)
X-Gm-Message-State: AOAM530JRkbvRKWKztUJjcVJxrAP7iMqOevaNrvbrjS2EqhicE9jUWRW
        a6OxNnuuPYdpDWtyvNGGRhVhnf5grb4kGy2V6y8=
X-Google-Smtp-Source: ABdhPJyFThGd83snSLiG5EJ18MY9gpkacVg/iWFW1r8JATD5QYlVe8g2S02xjJSPvm1ja/CwHnLIedR44zBg4Gtieu8=
X-Received: by 2002:a2e:88c6:: with SMTP id a6mr13824594ljk.27.1595377058313;
 Tue, 21 Jul 2020 17:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <1595221108-10137-1-git-send-email-xni@redhat.com>
 <1595221108-10137-4-git-send-email-xni@redhat.com> <ead4cd95-3a17-7ab6-3494-d1ac6bcc4d1f@suse.de>
 <f1aae07b-bdec-82ec-51a3-85de4b7e695c@suse.de>
In-Reply-To: <f1aae07b-bdec-82ec-51a3-85de4b7e695c@suse.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 21 Jul 2020 17:17:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7=zvCANj6YcQciPHpAohOpv-XQ=eMBHrcBUmdoEBZ9yw@mail.gmail.com>
Message-ID: <CAPhsuW7=zvCANj6YcQciPHpAohOpv-XQ=eMBHrcBUmdoEBZ9yw@mail.gmail.com>
Subject: Re: [PATCH V1 3/3] improve raid10 discard request
To:     Coly Li <colyli@suse.de>
Cc:     Xiao Ni <xni@redhat.com>, linux-raid <linux-raid@vger.kernel.org>,
        Nigel Croxon <ncroxon@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, Jul 19, 2020 at 10:38 PM Coly Li <colyli@suse.de> wrote:
>
> On 2020/7/20 13:26, Coly Li wrote:
> > On 2020/7/20 12:58, Xiao Ni wrote:
> >> Now the discard request is split by chunk size. So it takes a long tim=
e to finish mkfs on
> >> disks which support discard function. This patch improve handling raid=
10 discard request.
> >> It uses  the similar way with raid0(29efc390b).
> >>
> >> But it's a little complex than raid0. Because raid10 has different lay=
out. If raid10 is
> >> offset layout and the discard request is smaller than stripe size. The=
re are some holes
> >> when we submit discard bio to underlayer disks.
> >>
> >> For example: five disks (disk1 - disk5)
> >> D01 D02 D03 D04 D05
> >> D05 D01 D02 D03 D04
> >> D06 D07 D08 D09 D10
> >> D10 D06 D07 D08 D09
> >> The discard bio just wants to discard from D03 to D10. For disk3, ther=
e is a hole between
> >> D03 and D08. For disk4, there is a hole between D04 and D09. D03 is a =
chunk, raid10_write_request
> >> can handle one chunk perfectly. So the part that is not aligned with s=
tripe size is still
> >> handled by raid10_write_request.
> >>
> >> If reshape is running when discard bio comes and the discard bio spans=
 the reshape position,
> >> raid10_write_request is responsible to handle this discard bio.
> >>
> >> I did a test with this patch set.
> >> Without patch:
> >> time mkfs.xfs /dev/md0
> >> real4m39.775s
> >> user0m0.000s
> >> sys0m0.298s
> >>
> >> With patch:
> >> time mkfs.xfs /dev/md0
> >> real0m0.105s
> >> user0m0.000s
> >> sys0m0.007s
> >>
> >> nvme3n1           259:1    0   477G  0 disk
> >> =E2=94=94=E2=94=80nvme3n1p1       259:10   0    50G  0 part
> >> nvme4n1           259:2    0   477G  0 disk
> >> =E2=94=94=E2=94=80nvme4n1p1       259:11   0    50G  0 part
> >> nvme5n1           259:6    0   477G  0 disk
> >> =E2=94=94=E2=94=80nvme5n1p1       259:12   0    50G  0 part
> >> nvme2n1           259:9    0   477G  0 disk
> >> =E2=94=94=E2=94=80nvme2n1p1       259:15   0    50G  0 part
> >> nvme0n1           259:13   0   477G  0 disk
> >> =E2=94=94=E2=94=80nvme0n1p1       259:14   0    50G  0 part
> >>
> >> v1:
> >> Coly helps to review these patches and give some suggestions:
> >> One bug is found. If discard bio is across one stripe but bio size is =
bigger
> >> than one stripe size. After spliting, the bio will be NULL. In this ve=
rsion,
> >> it checks whether discard bio size is bigger than 2*stripe_size.
> >> In raid10_end_discard_request, it's better to check R10BIO_Uptodate is=
 set
> >> or not. It can avoid write memory to improve performance.
> >> Add more comments for calculating addresses.
> >>
> >> Signed-off-by: Xiao Ni <xni@redhat.com>
> >
> > The code looks good to me, you may add my Reviewed-by: Coly Li
> > <colyli@suse.de>
> >
> > But I still suggest you to add a more detailed commit log, to explain
> > how the discard range of each component disk is decided. Anyway this is
> > just a suggestion, it is up to you.
> >
> > Thank you for this work.
>
> In raid10_end_discard_request(), the first 5 lines for local variables
> declaration, there are 3 lines starts with improper blanks (should be
> tab '\t'). You may find this minor issue by checkpatch.pl I guess.
>
> After fixing this format issue, you stil have my Reviewed-by :-)
>
> Coly Li

Thanks to Xiao for the patch And thanks to Coly for the review.

I did an experiment with a patch to increase max_discard_sectors,
like:

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 14b1ba732cd7d..0b15397ebfaf9 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3762,7 +3762,7 @@ static int raid10_run(struct mddev *mddev)
        chunk_size =3D mddev->chunk_sectors << 9;
        if (mddev->queue) {
                blk_queue_max_discard_sectors(mddev->queue,
-                                             mddev->chunk_sectors);
+                                             UINT_MAX);
                blk_queue_max_write_same_sectors(mddev->queue, 0);
                blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
                blk_queue_io_min(mddev->queue, chunk_size);

This simple change reduces the run time of mkfs.xfs on my SSD
from 5+ minutes to about 14 seconds. Of course this is not as good
as ~2s seconds with the set. But I wonder whether the time saving
justifies extra complexity. Thoughts on this?

Also, as Coly mentioned, please run checkpatch.pl on the patches.
I have seen warnings on all 3 patches in the set.

Thanks,
Song
