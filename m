Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7051C993D
	for <lists+linux-raid@lfdr.de>; Thu,  7 May 2020 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEGSYw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 May 2020 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGSYw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 May 2020 14:24:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FED9C05BD43
        for <linux-raid@vger.kernel.org>; Thu,  7 May 2020 11:24:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l19so858974lje.10
        for <linux-raid@vger.kernel.org>; Thu, 07 May 2020 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NiDFnNzXdAXRR5EX5BWS5LpipKme2O1EIZpecXIQ/j8=;
        b=IvortYJIBflSPO5R2xTSqNAvq6zmMtHomXjLeZa4X6GXhxu7NTHiQIP8I4/9r/RC9U
         7zySoViYhS9G4YCcsMf3j4yrZbfkwcOe8lyo2p/8Uz3VJmieHgC0Z5d34j1aQMwUcRqU
         zsBGFbog14MyPTlVdui7cZDYTZK2oJTJpjfg/SolrH/YeUYqHx2v3cYjwzroYq9YeqK8
         1V1nZCkEWfk7w/uTi0lwHtR1zdGKnNbr8ZRuJh7+KaNl+N1skVWduew0qaquQa7d8Ohg
         ExgqRh6V1B4xMbmebPmMXxldKFw8JCJ7RQb0IkxqnFXFzwS9xdy4P8ocpcSZj5y9CjSb
         Kk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NiDFnNzXdAXRR5EX5BWS5LpipKme2O1EIZpecXIQ/j8=;
        b=N7Fyy2Gzj5/5Gx8Lt7USM+4a5IGrh6bXQM1fwwJA37SqJ8/CmvlameJzheYE3D/oIO
         lbhWlFlkb309aZ2rHuPDbx4ETUF0nwEqMxFzzK2g9onCPtonJs1slrJmuUsiEuCxZlpX
         Df5J/n/rlQi5BM4bRb40LwuwEHF59ZZXziXjyTs7Y7kE3CCFmFlZ3DqKy4qITaEiREs3
         96QEZEaP8TTej9kOezOYiPYHXJvswg26cla6fasqS+k2MNAefUp4Tw6gLk2f06ZsGDWx
         6zm0ZrQK7+ootlZRqwLNk1x20HIc9kOCNDi56/xAw2jgYoWmmit8Wt+Guwkh2wj2Vhr1
         4uPQ==
X-Gm-Message-State: AGi0PuaIzhON9D5pVW4mJIZZUaRXcaA/nUftUZ6uEhwJAleFLpuhk4UF
        JjeFp/sOXyxJ+/uZiO2LmaWxJ2AYYTFxtfi2mXkw0g==
X-Google-Smtp-Source: APiQypIQd27dC8gOR/D67tsu6RmQPJePItA/PZAMkvuLBf/cVIo/UtyF6k3KxsKX/Zwx2z2Go8XKsYe3waa3FqeG/Zo=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr8538180ljp.209.1588875887645;
 Thu, 07 May 2020 11:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <b0e91faf-3a14-3ac9-3c31-6989154791c1@yandex.pl>
In-Reply-To: <b0e91faf-3a14-3ac9-3c31-6989154791c1@yandex.pl>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Thu, 7 May 2020 13:24:36 -0500
Message-ID: <CAAMCDef6hKJsPw3738KJ0vEEwnVKB-QpTMJ6aSeybse-4h+y6Q@mail.gmail.com>
Subject: Re: [general question] rare silent data corruption when writing data
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Have you tried the same file 2x and verified the corruption is in the
same places and looks the same?

I have not as of yet seen write corruption (except when a vendors disk
was resetting and it was lying about having written the data prior to
the crash, these were ssds, if your disk write cache is on and you
have a disk reset this can also happen), but have not seen "lost
writes" otherwise, but would expect the 2 read corruption I have seen
to also be able to cause write issues.  So for that look for scsi
notifications for disk resets that should not happen.

I have had a "bad" controller cause read corruptions, those
corruptions would move around, replacing the controller resolved it,
so there may be lack of error checking "inside" some paths in the
card.  Lucky I had a number of these controllers and had cold spares
for them.  The give away here was 2 separate buses with almost
identical load with 6 separate disks each and all12 disks on 2 buses
had between 47-52 scsi errors, which points to the only component
shared (the controller).

The backplane and cables are unlikely in general cause this, there is
too much error checking between the controller and the disk from what
I know.

I have had pre-pcie bus (PCI-X bus, 2 slots shared, both set to 133
cause random read corruptions, lowering speed to 100 fixed it), this
one was duplicated on multiple identical pieces of hw with all
different parts on the duplication machine.

I have also seen lost writes (from software) because someone did a
seek without doing a flush which in some versions of the libs loses
the unfilled block when the seek happens (this is noted in the man
page, and I saw it 20years ago, it is still noted in the man page, so
no idea if it was ever fixed).  So has more than one application been
noted to see the corruption?

So one question, have you seen the corruption in a path that would
rely on one controller, or all corruptions you have seen involving
more than one controller?  Isolate and test each controller if you
can, or if you can afford to replace it and see if it continues.


On Thu, May 7, 2020 at 12:33 PM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> Note: this is just general question - if anyone experienced something sim=
ilar or could suggest how to pinpoint / verify the actual cause.
>
> Thanks to btrfs's checksumming we discovered somewhat (even if quite rare=
) nasty silent corruption going on on one of our hosts. Or perhaps "corrupt=
ion" is not the correct word - the files simply have precise 4kb (1 page) o=
f incorrect data. The incorrect pieces of data look on their own fine - as =
something that was previously in the place, or written from wrong source.
>
> The hardware is (can provide more detailed info of course):
>
> - Supermicro X9DR7-LN4F
> - onboard LSI SAS2308 controller (2 sff-8087 connectors, 1 connected to b=
ackplane)
> - 96 gb ram (ecc)
> - 24 disk backplane
>
> - 1 array connected directly to lsi controller (4 disks, mdraid5, interna=
l bitmap, 512kb chunk)
> - 1 array on the backplane (4 disks, mdraid5, journaled)
> - journal for the above array is: mdraid1, 2 ssd disks (micron 5300 pro d=
isks)
> - 1 btrfs raid1 boot array on motherboard's sata ports (older but still f=
ine intel ssds from DC 3500 series)
>
> Raid 5 arrays are in lvm volume group, and the logical volumes are used b=
y VMs. Some of the volumes are linear, some are using thin-pools (with meta=
data on the aforementioned intel ssds, in mirrored config). LVM
> uses large extent sizes (120m) and the chunk-size of thin-pools is set to=
 1.5m to match underlying raid stripe. Everything is cleanly aligned as wel=
l.
>
> With a doze of testing we managed to roughly rule out the following eleme=
nts as being the cause:
>
> - qemu/kvm (issue occured directly on host)
> - backplane (issue occured on disks directly connected via LSI's 2nd conn=
ector)
> - cable (as a above, two different cables)
> - memory (unlikely - ECC for once, thoroughly tested, no errors ever repo=
rted via edac-util or memtest)
> - mdadm journaling (issue occured on plain mdraid configuration as well)
> - disks themselves (issue occured on two separate mdadm arrays)
> - filesystem (issue occured on both btrfs and ext4 (checksumed manually) =
)
>
> We did not manage to rule out (though somewhat _highly_ unlikely):
>
> - lvm thin (issue always - so far - occured on lvm thin pools)
> - mdraid (issue always - so far - on mdraid managed arrays)
> - kernel (tested with - in this case - debian's 5.2 and 5.4 kernels, happ=
ened with both - so it would imply rather already longstanding bug somewher=
e)
>
> And finally - so far - the issue never occured:
>
> - directly on a disk
> - directly on mdraid
> - on linear lvm volume on top of mdraid
>
> As far as the issue goes it's:
>
> - always a 4kb chunk that is incorrect - in a ~1 tb file it can be from a=
 few to few dozens of such chunks
> - we also found (or rather btrfs scrub did) a few small damaged files as =
well
> - the chunks look like a correct piece of different or previous data
>
> The 4kb is well, weird ? Doesn't really matter any chunk/stripes sizes an=
ywhere across the stack (lvm - 120m extents, 1.5m chunks on thin pools; mdr=
aid - default 512kb chunks). It does nicely fit a page though ...
>
> Anyway, if anyone has any ideas or suggestions what could be happening (p=
erhaps with this particular motherboard or vendor) or how to pinpoint the c=
ause - I'll be grateful for any.
