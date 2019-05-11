Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8EE01A964
	for <lists+linux-raid@lfdr.de>; Sat, 11 May 2019 22:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEKUW7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 11 May 2019 16:22:59 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:36598 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKUW7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 11 May 2019 16:22:59 -0400
Received: by mail-it1-f172.google.com with SMTP id e184so2266316ite.1
        for <linux-raid@vger.kernel.org>; Sat, 11 May 2019 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1lbVkppUSlid5xT0g/CF6isgqqkcraIimZxOAEAkaig=;
        b=vQpBUys5ONJEo6iRZWmv6PbsLR2YeFRHBhURI2mrQWdd9/iiRKfXh7wzaeg32Ejarp
         TuwgKDiisIPon1ETJhMNmE73k7KdA5Us2vjFHEzzZUMKowp/3k6uKWTtpApaLk6F2ll1
         6Y2HqQZTrhpuaPAJxjB72aP8RpBr6l0fSK4Wq5cvOmLDjuXpGnlrbijGVnUqUr0E+VVc
         3e9zC7Q6ZU8Zk+9BwAtbeduTCmJFBmKMUOWNqY67wfsWnw68edUc/FBnji1WGiKWzQmx
         Gf7+nLsVR7MvX2kOdywGLlLaOYDOiVvUHtsjuxeomFr8WSFFBc6MoKJ2cq3YGAArGOqc
         qU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1lbVkppUSlid5xT0g/CF6isgqqkcraIimZxOAEAkaig=;
        b=jcoAy2D4Dsw72PBVvCaX13Rb2t5a2kxOsVVH73SoN1MSJ05tGvV+Isf6pU0XbxC9ap
         PIYzzwIO16GxNfAy2JOAHMVTwgXlI7flVVABp78neubg7IZYCtoY1vMW+GOVhfaNy0t9
         4dLQgx36r8nGEM8bduLsce/B8BqAIgRuof2KbwyfossFRw2ocq2WzF65fbL64pnYvbLq
         qSr87psr4rsJ1qeQklvYK8zUl+70eC9LyWzrYcWWDljMh6538eetPtTdSY7PjzXj1d5W
         i4LIRfh5ZF2qSuhLyjermUaz6+FI0fBcUp3w3SPTVHp7o5tS0nmghbAzHLbyhTKsvF6a
         bJ6w==
X-Gm-Message-State: APjAAAXWv/VgAMSjPWJ7ONARk6vN+1rvOtC539huH6Z/FLe5NCJFGrxO
        zOENO0PPbGOjsvH8PseqHrgvJIj/ycOljt+W58OhDmZ02KI=
X-Google-Smtp-Source: APXvYqzZxqfL5rl9fZlwkilbpkyybekjlV3nPlskDTBfgLPPwV4PxSjI+W1C/YKFgrc2Stek6luJgKjAQSAtF3J1Frg=
X-Received: by 2002:a24:3988:: with SMTP id l130mr6038107ita.13.1557606178645;
 Sat, 11 May 2019 13:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJH6TXgE10cF=+greYkDOCZVbGSZnQxbKg2+kdUBaw_ie+gWMw@mail.gmail.com>
 <CAJH6TXgJ3822AgdhUWj+h458O1A=_tRtiW2+GUuFM05DxJuS0Q@mail.gmail.com>
 <9fc493d1-b7e5-1134-6117-398aaa007e44@aei.mpg.de> <CAJH6TXgumKC4exPfDXkYoDLc8rudPs-8rcnf3zNfiaHuFDKg1w@mail.gmail.com>
 <696361643.11485543.1557064317062.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <696361643.11485543.1557064317062.JavaMail.zimbra@karlsbakk.net>
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Sat, 11 May 2019 22:22:46 +0200
Message-ID: <CAJH6TXhy=WiRGOW7oQT5PqviKdZj_MMy3jMa71hXjB19h9XQFw@mail.gmail.com>
Subject: Re: best way to replace all disks
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc:     Carsten Aulbert <carsten.aulbert@aei.mpg.de>,
        Linux Raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I've found an SATA to USB adapter. Currently, i'm replacing properly
one disk at time, to a bigger one,
by converting the 2-way raid1 to a 3way raid1

Seems to work properly, raid is rebuilding with no issue, but kernel
is complaining something:

bio too big device md4 (248 > 240)

should I be worried about this ? Tomorrow i'll remove the  USB
adapter, remove 2 of the old disks, put the new disk directly in the
sata slot and add a new sata disk.


Il giorno dom 5 mag 2019 alle ore 15:52 Roy Sigurd Karlsbakk
<roy@karlsbakk.net> ha scritto:
>
> > unfortunately I can't change the server. I have tons of custom,
> > closed-source software
> > that won't run on newer hardware, that's why i have to use the current =
one.
> >
> > Yes, i'm planning a replacement, but is not something quick to do,
> > i'll need many month
> > redeveloping, in-house, the current closed-source software. Until
> > that, I have to keep the
> > data safe.
> >
> > technically I can use a new hardware, but I can't upgrade the
> > operating system (a very old slackware,
> > if I remember properly) or these closed-source software wont run anymor=
e
> >
> > maybe the faster solution would be to add a cheap (which one?) HBA
> > controller that supports more than 4 SATA disks,
> > move all disks to this new controller and then convert, one by one,
> > each 2way mirror to a 3way mirror:
>
> I'd suggest you get a new and fancy machine with good, large drives and a=
 lot of memory. Use two smallish drives for the root and the rest for the d=
ata in whatever RAID leve you prefer. Then setup kvm on top and create a ne=
w, empty virtual machine onto which you rsync the old machine with everythi=
ng there. If it's an old slackware, chances are it's running lilo and not g=
rub. This should also be doable, although perhaps some issues with virt-man=
ager (the gui from which you can manage the VMs). This is what I've done wi=
th old, outdated machines to keep them safe until they eventually die or ar=
e replaced by something new.
>
> Vennlig hilsen
>
> roy
> --
> Roy Sigurd Karlsbakk
> (+47) 98013356
> http://blogg.karlsbakk.net/
> GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
> --
> Hi=C3=B0 g=C3=B3=C3=B0a skaltu =C3=AD stein h=C3=B6ggva, hi=C3=B0 illa =
=C3=AD snj=C3=B3 rita.
