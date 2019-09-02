Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F1A5AF0
	for <lists+linux-raid@lfdr.de>; Mon,  2 Sep 2019 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfIBQBJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 12:01:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37277 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfIBQBJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Sep 2019 12:01:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id f22so16058217edt.4
        for <linux-raid@vger.kernel.org>; Mon, 02 Sep 2019 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hQDG6Cfu5bklSIXjfF0IV1KQ+pK7JJ7ZK8I/UoOf7kM=;
        b=iT83xLp30ls86Rrv37uB76sOCOmfmXuzyk0oHx5LO8ld8Iu7U6/Rv1R2yNDogyaeqx
         72d3bE2sy/2k3IYkyfRJl2R2vaqWhzTs/jDGW1z57MCreStHtoB2SsvKxB4ACbKgJX8H
         zASmbqsQkpor2aEU2Xh/f7487VMQZCP3h/dfE4Lm6bUi51bqf22hD9jEFR1gCuunNKVk
         42TFC+wmjw8Buy08+PyGNIhTFi1znzuqE45hYw/v1yk0i7AfzWF7KZ1m4E9Nn2ydCI8R
         W1y+wu3Hdacr16uprWWzw2BbQ2Zd4EQzedmVZlofZGgYaq1FSgbtOeK7b4hn4TeGoCVw
         p38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hQDG6Cfu5bklSIXjfF0IV1KQ+pK7JJ7ZK8I/UoOf7kM=;
        b=aAPsplPsmQuffp5CH5FqhjlfvVwyofTq3yuwhnTRxnaDfGPqdn02Es4LSUXAgZzRWJ
         zYrtBB7CUp09zJJQ5s9f6x7z66VDqOGajBZbBw0rceB2isjvYHNnwZWDE0UBgX1yNxOv
         Ofd+/Cn42hDty4yTCn1x3zn+eU45WVgrL9oulMKE/TwQFYSqM3ou5yDG+uXgpVYfTtEO
         +oMrPU1hLm/076PcLRQBmRRm7a7yJTNiqdyLXehfGJf7RZ8YuFQShPJQfqKETbCB2Jf/
         h9U+EiKuVDQD96aXf4xNAPQVUvzwEq6+ZbaGWRUh3pylhT34xH8nRiTX0EiVm90npYg4
         oS4w==
X-Gm-Message-State: APjAAAW6Srj+K4R+1mI//ds1ijkc77mNspGLJ1VjyZv3hqrqbwR4m/AQ
        sJS6byakQT1tojWXFITh29vRptPUK86HKqJjxRo=
X-Google-Smtp-Source: APXvYqy3kE704FfMR4ey0dB6oPJbhKnoVcD7pXuoaFRFb01Bw/lnQIhudx24D4hYomXanQtKGTKMAdz923oDxE6hjxw=
X-Received: by 2002:a17:906:1d11:: with SMTP id n17mr15772676ejh.68.1567440067078;
 Mon, 02 Sep 2019 09:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
 <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
 <5D6CF46B.8090905@youngman.org.uk> <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com>
 <2ce6bd67-d373-e0fc-4dba-c6220aa4d8cb@turmel.org>
In-Reply-To: <2ce6bd67-d373-e0fc-4dba-c6220aa4d8cb@turmel.org>
From:   =?UTF-8?Q?Krzysztof_Jak=C3=B3bczyk?= <krzysiek.jakobczyk@gmail.com>
Date:   Mon, 2 Sep 2019 18:00:50 +0200
Message-ID: <CA+ojRwmnpg6eLbzvXU51sLUmUVUdZnpbF71oafKtvdoApX3e1Q@mail.gmail.com>
Subject: Re: Fwd: mdadm RAID5 to RAID6 migration thrown exceptions, access to
 data lost
To:     Phil Turmel <philip@turmel.org>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Gentlemen,

Just in order for me not to mix anything important I will quickly
summarize what I'm about to do:
I will try to release all the files that are being used on the target
md0, by checking what is still being used with "lsof /data" and then
will kill the processes that are still trying to use the array.
After the files are being unlocked I will perform the outdated host shutdow=
n.
I will boot a thumbstick on that computer with SystemRescueCD and will
try to assemble the array with the "mdadm --assemble --scan -v --run"
applying --force if necessary.

Please confirm me if my understanding is correct.

Best regards,
Krzysztof Jakobczyk

pon., 2 wrz 2019 o 16:32 Phil Turmel <philip@turmel.org> napisa=C5=82(a):
>
> Good morning Krzysztof,
>
> On 9/2/19 7:30 AM, Krzysztof Jak=C3=B3bczyk wrote:
> > Thank you for your input and I'll wait with further steps until confirm=
ation!
> >
> > Best regards,
> > Krzysztof Jakobczyk
> >
> > pon., 2 wrz 2019 o 12:52 Wols Lists <antlists@youngman.org.uk> napisa=
=C5=82(a):
> >>
> >> On 02/09/19 11:05, Krzysztof Jak=C3=B3bczyk wrote:
> >>> My questions are the following:
> >>>
> >>> What to do in order to move the reshape process forward?
> >>
> >> I'll leave that to others, but my gut reaction is just to restart it
> >> (don't follow my advice! Wait for someone else to say it's safe :-)
>
> Don't do anything more in your current kernel and mdadm version.
>
> >>> Do you think the data on the md0 is safe?
> >>
> >> Yes I do.
>
> I agree.
>
> >>> How to access the data on md0 if I cannot cd to it?
> >>>
> >> Wait for the system to (be) recover(ed).
> >>
> >>> What are those stack traces in the dmesg output?
>
> Those are from an unrelated process (postgres) that is stuck.  It might
> be stuck as a side effect of not being able to reach data on your array.
>
> >>> Help will be greatly appreciated.
> >>>
> >> MAKE SURE you've got a rescue disk with the latest mdadm and an
> >> up-to-date kernel. I strongly suspect you've got an out-of-date system=
 -
> >> mdadm 3.2.2 is pretty ancient. This sounds to me like a well-known
> >> problem from back then, and if I'm right the fix is as simple as booti=
ng
> >> into a up-to-date recovery system, letting the reshape complete, and
> >> then booting back into the old system.
> >>
> >> Can someone else confirm, please!!!
>
> Yes, this is what I would do.  Do as clean a shutdown as you can on your
> system as-is.  Reboot into a rescue environment that has a current
> mdadm.  (I am a fan of SystemRescueCD, on a thumb drive, but others
> should work fine too.)
>
> Note that device names may change from kernel to kernel--you will want
> to use smartctl to verify which drive serial number is on which device
> name and adjust your command lines accordingly.
>
> You will likely have to use --assemble --force, specifying all relevant
> devices, as I doubt the current kernel will cleanly shutdown, and
> therefore some superblock data will prevent auto-start.  If you used a
> backup file in your reshape command, you will need to supply it to your
> --assembly command.  (Backup files are not generally needed, and reduce
> reshape performance.)
>
> If reshape does not resume, supply the output of "mdadm -E" for all of
> your member partitions, and "smartctl -iA -l srterc" for the devices.
> When you paste the above into your email client, turn off word wrapping
> so the long lines won't be mangled.
>
> >> Cheers,
> >> Wol
>
> Regards,
>
> Phil
