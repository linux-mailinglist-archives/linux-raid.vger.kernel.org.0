Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE4285AA
	for <lists+linux-raid@lfdr.de>; Thu, 23 May 2019 20:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfEWSKE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 23 May 2019 14:10:04 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:44807 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbfEWSKE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 23 May 2019 14:10:04 -0400
Received: by mail-qt1-f180.google.com with SMTP id f24so7816084qtk.11
        for <linux-raid@vger.kernel.org>; Thu, 23 May 2019 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OYnyEcy7slTa9QcAJHom/Igbzw8StUyhZJTfyWe7VY=;
        b=DnLos3Afqu5VfnMQDemlHleb4iyMVYwc36KeQ5HoFPBIg8bxSknQDmjaRZhzJ1e5Bx
         bLUly1nIDTfNcCerZlAzh4LZL2oyYIXGN+T7wwTUkcBJaly5Slf46uAEcec89VehLE9o
         KGIG4/PEkuNsjG3/KIh8fbd0/TcGLDoot+rfkK5Meuo1Nm6NAFguuGbcvKhN3j3V6tZj
         6XoVVb76QwpbbHup8YlN7onF1MpHVfwLD70hVfH5E9khqxT+7WexzPUF3PZlZJWH/AHP
         L80LXaVSwn2lkTxK3xlBstWBAW3ExHRY+QlK73zLfl9dhYK+KcCdo8AvLUeZukaWE/Ah
         swqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OYnyEcy7slTa9QcAJHom/Igbzw8StUyhZJTfyWe7VY=;
        b=GxA0WvwHMxv2L18tkbbcA3NuyPt5OBqzgEHMyhP6vQHyqBwqjjq6bZRz91JwcVKO3/
         dIuWtVRAg1wHw+FizGJyFUlvxEnDJjOo+AiuVRkxTuDLGEDJ0SlykWNVz4tUyGTR45ZJ
         ft1SprVARdArxnOON/0Zydz+uiAgrC2S3I+4QewsjPtHvV3yOyMsBTpDVltlB5SZ9unY
         fawUH9bo8gp4npt/VSflgmJ2zcTo5vkPnkvxx5FImmZ7nUyswML3QSgg7JQ/jWjT0DIw
         HePo88UatBDoRIeAOf/bCs5d513Xg0lwZeVyA4seDnF/s9ih52GTw5wyLmPaCR3UEQJV
         FXHw==
X-Gm-Message-State: APjAAAWYfWg5uetY4TmylraLHhFxIv+2jjIzlHDMu0FOyalbzJ7bWdG+
        Qf0smdMJsxJhagJV8entzE9qKp5ywUyx8+h04H4c1g==
X-Google-Smtp-Source: APXvYqwUnlJuPNKIQdOG44tSoNeRJW6FQqEQ52LMDmhEfbmxXgLcdeS5z5fO6eDaK6ENJneqFdorl0quobUg6IetQmQ=
X-Received: by 2002:a0c:9539:: with SMTP id l54mr25822351qvl.24.1558635003500;
 Thu, 23 May 2019 11:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
 <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com> <ae69671c-7763-916e-5b45-0ff4741293eb@ziu.info>
In-Reply-To: <ae69671c-7763-916e-5b45-0ff4741293eb@ziu.info>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 23 May 2019 11:09:51 -0700
Message-ID: <CAPhsuW4yMSjzb0FCQsRWJCYmXNQM5Y2o_LCOE-6C7gTOcCNrEQ@mail.gmail.com>
Subject: Re: Few questions about (attempting to use) write journal + call traces
To:     Michal Soltys <soltys@ziu.info>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, May 23, 2019 at 3:42 AM Michal Soltys <soltys@ziu.info> wrote:
>
> On 5/22/19 8:27 PM, Song Liu wrote:
> > On Wed, May 22, 2019 at 6:18 AM Michal Soltys <soltys@ziu.info> wrote:
> >>
> >> Hi,
> >>
> >> As I started experimenting with journaled raids:
> >>
> >> 1) can another (raid1) device or lvm mirror (using md underneath) be used formally as a write journal ?
> >> 2) for the testing purposes, are loopback devices expected to work ?
> >>
> >> I know I can successfully create both of the above (case scenario below), but any attempt to write to such md device ends with hung tasks and D states.
> >>
> >>
> >> kernel 5.1.3
> >> mdadm 4.1
> >> btrfs filesystem with /var subvolume (where losetup files were created with fallocate)
> >>
> >> What I did:
> >>
> >> - six 10gb files as backings for /dev/loop[0-5]
> >> - /dev/loop[4-5] - raid1
> >> - /dev/loop[0-3] - raid5
> >>
> >> Now at this point both raids work just fine, separately. The problem starts if I create raid1 as raid5's journal (doesn't matter whether w-t or w-b). Any attempt to write to a device like that instantly ends with D and respective traces in dmesg:
> >
> > Hi Michal,
> >
> > Yes, the journal _should_ work with another md, lvm, or loop device.
> > Could you please share the commands you used in this test?
> >
> > Thanks,
> > Song
> >
>
> Actually, this seems to be unreleated to underlying devices - the culprit seems to be attempting to write to an array after adding journal, without stopping and reassembling it first. Details below.

Thanks for these experiments. Your analysis makes perfect sense.

Do you think you can continue the  experiments with the write journal before
this issue got fixed?

I am asking because this is not on the top of my list at this time. If
this is not
blocking other important tests, I would prefer to fix it at a later time.

Thanks,
Song

>
> 0) Common start
>
> # cd /var/tmp
> # for x in {0..5}; do fallocate -l 10g $x; done
> # for x in {0..5}; do losetup /dev/loop$x $x; done
>
>
>
> 1) Following from (0), *works*:
>
> # mdadm -C /dev/md/journ -N journ  -n2 -l1 -e1.2 /dev/loop[45]
> (wait for sync / or create with --assume-clean)
> # mdadm -C /dev/md/master -N master  -n4 -l5 -e1.2 --write-journal /dev/md/journ /dev/loop[0123]
> (wait for sync / or create with --assume-clean)
> # mdadm -Es >>/dev/mdadm.conf
>
> # dd if=/dev/zero of=/dev/md/master bs=262144 count=1
> (works)
>
> # mdadm -Ss
> # mdadm -A /dev/md/journ
> # mdadm -A /dev/md/master
>
> # dd if=/dev/zero of=/dev/md/master bs=262144 count=1
> (works)
>
>
>
> 2) Following from (0), *does not* work (adding journal afterwards):
>
> # mdadm -C /dev/md/journ -N journ  -n2 -l1 -e1.2 /dev/loop[45]
> (wait for sync / or create with --assume-clean)
> # mdadm -C /dev/md/master -N master  -n4 -l5 -e1.2 /dev/loop[0123]
> (wait for sync / or create with --assume-clean)
>
> # mdadm --readonly /dev/md/master
> # mdadm /dev/md/master --add-journal /dev/md/journ
>
> # dd if=/dev/zero of=/dev/md/master bs=262144 count=1
> (hangs)
>
> Variation of the above that does work:
>
> - adding journal afterwards
> - stopping both arrays
> - assembly
> - writing
>
>
> 3) Following from (0), *does not* work (adding correct journal after assembly with missing one):
>
> mdadm -C /dev/md/journ -N journ  -n2 -l1 -e1.2 /dev/loop[45]
> (wait for sync / or create with --assume-clean)
> mdadm -C /dev/md/master -N master  -n4 -l5 -e1.2 --write-journal /dev/md/journ /dev/loop[0123]
> (wait for sync / or create with --assume-clean)
> mdadm -Es >>/dev/mdadm.conf
> mdadm -Ss
>
> # mdadm -A --force /dev/md/master
> mdadm: Journal is missing or stale, starting array read only.
> mdadm: /dev/md/master has been started with 4 drives.
>
> # mdadm -A  /dev/md/journ
> mdadm: /dev/md/journ has been started with 2 drives.
>
> # mdadm /dev/md/master --add-journal /dev/md/journ
> mdadm: Journal added successfully, making /dev/md/master read-write
> mdadm: added /dev/md/journ
>
> # dd if=/dev/zero of=/dev/md/master bs=262144 count=1
> (hangs)
>
> Same variation as in (2) - stopping and assembling normally - works as well.
