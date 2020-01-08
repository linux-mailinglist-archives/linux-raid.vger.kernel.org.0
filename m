Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835F9133F46
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jan 2020 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgAHK11 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jan 2020 05:27:27 -0500
Received: from mail-vk1-f172.google.com ([209.85.221.172]:38486 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAHK11 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 Jan 2020 05:27:27 -0500
Received: by mail-vk1-f172.google.com with SMTP id d17so815580vke.5
        for <linux-raid@vger.kernel.org>; Wed, 08 Jan 2020 02:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0b20jO2PuV7WjDbA18zgIq93F5KAEAPY/Jsj/xTSwIg=;
        b=NjXWFtWm2ipJaD8b2sLdxMr73X2hmrpcAGKWCcSXGW78sjCHAkR79bLp4ZnfjzVV1z
         sQEy0PZMyuor+xtZh7jYZ5xc1yIUtNfGZ2B3OzL3lTS7BKsVv7DGbBjGhiI6dDYDq9ow
         0TZFDOcR4mwTUd12xM1AHEvvawAWh/tbgjRlaJsosaDefP8Xqv2oZGyqv+Uy0EHH8kz7
         LYg6HurAf5c5rQpsx+4apqX1rJ9Ipbn9eKHq7RRO1x0yaF1HyZM+2F6FWRN/dj+OaQoY
         U6CJifcNlr1D4gU9XA2Pue5KO8kV04dU4Ef/KWfSijbi8g1KafUCDpUFFrg9w+y24b4N
         /d1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0b20jO2PuV7WjDbA18zgIq93F5KAEAPY/Jsj/xTSwIg=;
        b=CdFdpkxPPykLimZw0b2Az3YrzrHmKmu2T7j7juG+y9w2JRdMNp2UjDlvRmDPbk/lyl
         sN6jIDeE789JBMZFZ69GrGDt9P6lk0BS2JVYB04id8e8R14z2JTcdWZZu62Riah6pOZU
         1XjW7BAC4Rlu9lSg4Ym3Ury3YzDAuk7ltaWVlX6TJ+ZTtT1mFUXQbFqrT4yxNUW4H/IM
         yIvcLZwcpBqc71qJHR/DBvA7A1EMM5OChyKV4Lz4mzdXAOEOAhW/qr/i0I/CQHXWLu0/
         eax3PktaJE4iS2E+Dx6kcxSHazMR84wkmqbukeqBtHpdaucCx/n3J2dqVgV8+1tWZdfz
         Zk6w==
X-Gm-Message-State: APjAAAVrk2ZxYaC39IV1lT38x/dTBbhb7f+8Dx5H10VVh9vHYXTq4ZQZ
        6+jYlwbdkWnRhw130T2R3kJL51ghfaaem+93+CF5JJRu
X-Google-Smtp-Source: APXvYqwxmV+8mdU06scj/Fm/u6XI7rJHzEsDQsxSgKa1gaFa8DEaaHlGnO4V2NGAwNpq86OIcn/R8FKYEaI7e3l09pM=
X-Received: by 2002:a1f:d583:: with SMTP id m125mr2417887vkg.17.1578479246080;
 Wed, 08 Jan 2020 02:27:26 -0800 (PST)
MIME-Version: 1.0
References: <CAEWf3EDf-CwMz660RjRAtL==fa-Xc2XVpbrJL_Xqw24ZTZ18Zg@mail.gmail.com>
 <20200108100327.GA15483@metamorpher.de>
In-Reply-To: <20200108100327.GA15483@metamorpher.de>
From:   Marco Heiming <myx00r@gmail.com>
Date:   Wed, 8 Jan 2020 11:28:32 +0100
Message-ID: <CAEWf3EAD72E7McA-=WnBSquvKhJKh9jsEExJ2Sus9hfSH=HSpA@mail.gmail.com>
Subject: Re: Raid 5 cannot be re-assembled after disk was removed
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> A three disk raid5 with spare (odd, why not raid6 then?)
Because the 4th disk was not in the initial setup and i never moved
from raid5 to raid6.

> or whatever reason, it's a 4 disk raid5 now.
This is because i activated the spare disk so it could sync but after
sync finished i failed and removed the defective disk but somehow the
raid was not rebuilding.
The array was not mounted since the 4th (previously spare) was added.

> You can't assemble a 4 disk raid5 with only 2 drives.
I would like to make the 4 disk raid5 to a 3 disk raid5 and assemble
this one with 3 drives.
Can't i assemble the array with the (hopefully) fine 2 disks first
(without redudancy) and then add the 3rd disk to build up redudancy
and resync to it?
Or recreate with --assume-clean with 3 disks?
I could also try to reconnect the defective disk - it is still working
but has some read errors - and add it back to the array if this helps.

Thanks

Am Mi., 8. Jan. 2020 um 11:03 Uhr schrieb Andreas Klauer
<Andreas.Klauer@metamorpher.de>:
>
> On Wed, Jan 08, 2020 at 10:31:28AM +0100, Marco Heiming wrote:
> > So here is what what it looked like at the time it was working:
> >
> > mdadm -D /dev/md0
> > /dev/md0:
> >   Creation Time : Wed Jan  7 18:14:37 2015
> >      Raid Level : raid5
> >      Array Size : 5860270080 (5588.79 GiB 6000.92 GB)
> >   Used Dev Size : 2930135040 (2794.39 GiB 3000.46 GB)
> >    Raid Devices : 3
> >   Total Devices : 4
>
> A three disk raid5 with spare (odd, why not raid6 then?)
>
> > Somehow the spare was not activated and so the array degraded was inactive.
> >
> > I activated the spare and the array was syncing.
>
> Then something went wrong in this step.
> It seems like you did something else.
>
> > mdadm --examine /dev/sd[b-z]
> > /dev/sdb:
> >   Creation Time : Wed Jan  7 18:14:37 2015
> >      Raid Level : raid5
> >    Raid Devices : 4
> >
> >  Avail Dev Size : 5860274096 (2794.40 GiB 3000.46 GB)
> >      Array Size : 8790405120 (8383.18 GiB 9001.37 GB)
> >   Used Dev Size : 5860270080 (2794.39 GiB 3000.46 GB)
>
> For whatever reason, it's a 4 disk raid5 now.
>
> Array size went up from 6000GB to 9000GB accordingly.
>
> >    Device Role : Active device 1
> >    Array State : AAA. ('A' == active, '.' == missing, 'R' == replacing)
>
> And one disk is missing so no redundancy here.
>
> > When i try to assemble the array with the two (hopefully) fine drives it fails:
>
> You can't assemble a 4 disk raid5 with only 2 drives.
>
> Your examine also only gave two disks out of 4.
>
> You need 3 drives with good data on them, and a 4th drive to restore redundancy.
> Whether you have those 3 drives, only you yourself know...
>
> Regards
> Andreas Klauer
