Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCE13FDC
	for <lists+linux-raid@lfdr.de>; Sun,  5 May 2019 16:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfEEOAp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 May 2019 10:00:45 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:41132 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfEEOAp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 5 May 2019 10:00:45 -0400
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 10:00:44 EDT
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id E29523C0224;
        Sun,  5 May 2019 15:51:58 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id HH0GpHCqLyq4; Sun,  5 May 2019 15:51:57 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 8A0313C023E;
        Sun,  5 May 2019 15:51:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net 8A0313C023E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1557064317;
        bh=nY9FxM6G7VdwKFnVcb7Gjd/JPzbT7PRd6RSWi4zhERc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DKWC4qJ3DcI69ELDrKFtygrQdF+vGu7F+9Y+6VjYBq01xeTdWxmLRHFyex1U6CPzR
         0BnaIkOjsX8qFE3jzXwz3RYeTUBQg0hByj/iYMEl4zp8dwSY6rNBcxZ+D/PSQor7+2
         WY2J7q70aIAuiitoomsz0buZs/4ZOmTO70fTDlpdBJ7Ea7hESkXyEEzD6t94G7fgCl
         MGEoNBOE1a3EijH5Q033IJNiCjH5KpHW6wMYBXNt1/ok7wi0cim8XDUq4w/f3xw+kL
         nehGUp+hBaIS3PaMJRLJKvxn/yKYfMJ8TC7e+Clpqs/sJxZZdnT9cvbTfdvxs3J/W/
         PRH7KtnIyynMg==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id BVc0CHOjGe8K; Sun,  5 May 2019 15:51:57 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 5D5C93C0224;
        Sun,  5 May 2019 15:51:57 +0200 (CEST)
Date:   Sun, 5 May 2019 15:51:57 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc:     Carsten Aulbert <carsten.aulbert@aei.mpg.de>,
        Linux Raid <linux-raid@vger.kernel.org>
Message-ID: <696361643.11485543.1557064317062.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <CAJH6TXgumKC4exPfDXkYoDLc8rudPs-8rcnf3zNfiaHuFDKg1w@mail.gmail.com>
References: <CAJH6TXgE10cF=+greYkDOCZVbGSZnQxbKg2+kdUBaw_ie+gWMw@mail.gmail.com> <CAJH6TXgJ3822AgdhUWj+h458O1A=_tRtiW2+GUuFM05DxJuS0Q@mail.gmail.com> <9fc493d1-b7e5-1134-6117-398aaa007e44@aei.mpg.de> <CAJH6TXgumKC4exPfDXkYoDLc8rudPs-8rcnf3zNfiaHuFDKg1w@mail.gmail.com>
Subject: Re: best way to replace all disks
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:91.186.71.4]
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF66 (Mac)/8.8.10_GA_3786)
Thread-Topic: best way to replace all disks
Thread-Index: KNbTtg6PAcp7OSpV0fAoOSlO/GfL8w==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> unfortunately I can't change the server. I have tons of custom,
> closed-source software
> that won't run on newer hardware, that's why i have to use the current on=
e.
>=20
> Yes, i'm planning a replacement, but is not something quick to do,
> i'll need many month
> redeveloping, in-house, the current closed-source software. Until
> that, I have to keep the
> data safe.
>=20
> technically I can use a new hardware, but I can't upgrade the
> operating system (a very old slackware,
> if I remember properly) or these closed-source software wont run anymore
>=20
> maybe the faster solution would be to add a cheap (which one?) HBA
> controller that supports more than 4 SATA disks,
> move all disks to this new controller and then convert, one by one,
> each 2way mirror to a 3way mirror:

I'd suggest you get a new and fancy machine with good, large drives and a l=
ot of memory. Use two smallish drives for the root and the rest for the dat=
a in whatever RAID leve you prefer. Then setup kvm on top and create a new,=
 empty virtual machine onto which you rsync the old machine with everything=
 there. If it's an old slackware, chances are it's running lilo and not gru=
b. This should also be doable, although perhaps some issues with virt-manag=
er (the gui from which you can manage the VMs). This is what I've done with=
 old, outdated machines to keep them safe until they eventually die or are =
replaced by something new.

Vennlig hilsen

roy
--
Roy Sigurd Karlsbakk
(+47) 98013356
http://blogg.karlsbakk.net/
GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
--
Hi=C3=B0 g=C3=B3=C3=B0a skaltu =C3=AD stein h=C3=B6ggva, hi=C3=B0 illa =C3=
=AD snj=C3=B3 rita.
