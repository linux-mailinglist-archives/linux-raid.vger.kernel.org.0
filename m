Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B942E17C7E5
	for <lists+linux-raid@lfdr.de>; Fri,  6 Mar 2020 22:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCFVd6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 6 Mar 2020 16:33:58 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43870 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFVd6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 6 Mar 2020 16:33:58 -0500
Received: by mail-vs1-f65.google.com with SMTP id 7so2479955vsr.10
        for <linux-raid@vger.kernel.org>; Fri, 06 Mar 2020 13:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7xubHOjg5UOs2gWKqFwx7rUQivP3Y6+h/C+nWzvxZg=;
        b=Nw556J6FItH56h1/eR3sgXy1sNpkEWAQKvM99GhYio3tVWZFuA0ejstP1MV8ZHmPm+
         vvJkbz+LRzQhB9iF324FufUJSKw0D2h5JVab+2Kt5hW/uirlkR74BurNmY8LzjNh9gsj
         a1klE29mab60lXDFG2Hq+f8GFfsFs34zFKrtNdqRvHzFAO9mWicLlb30C7LGWnJhWmsy
         SfLqib6GOiIYmoBjmaiEdswFBY0n3yrFeRGymtenADXZVQbJI32Ptb9NLt8Q89AcTsYF
         2I18zB5wMahkLxOCknPuhMYeQvoVsgjwBov22IDFHsuIN7hztukTzChef8qNbdD81UjU
         V0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7xubHOjg5UOs2gWKqFwx7rUQivP3Y6+h/C+nWzvxZg=;
        b=PN9NAOzrFKXC5vxDTD5s+xriY2vDHytn4nf3cthRo11UK0eodHHYVo72QC6NicEEsW
         pZNiG0QAetpj0NGYLAktAghbPCyVRh7s4fEqJeREV/SXM1fvSHevDqsrlQiT860BFWRe
         3CYB8Na/tf5cVuB3PjrSo+d6fMRUWCD0xv/XFpEmt1WC/5vNtk45cFqCex3kgqask6Y2
         Q5UQmNpokyT0gezUalIBhbLinh/s9yNdVtyXGeW3VgBQ1DkAi5M4zLXsm6slnoJOKBrg
         qGf6RHgUJz9OhPD8bxmy1fF/vesf4RzDj4TGvYr/T1//gxefOTpe4S1anmi3Sg9YbBc4
         upbg==
X-Gm-Message-State: ANhLgQ1AyIZaNSq4Ruz0nANzD2Bi4BXBsrbIFjtIgBbm8RI3qkxRW/b7
        fi4qsHVTSYNIv1WGC18GbVbx2OqAR7EerA0VMmE=
X-Google-Smtp-Source: ADFU+vuy5MWlyxCHoclBrJdH/fpRcnIqaXylFJaEPu7Kvfh0JrDkvHt7LC2iTSnlwFb67M0D39TYMEt1adFRBaS4Q+I=
X-Received: by 2002:a67:f41a:: with SMTP id p26mr3816597vsn.222.1583530436937;
 Fri, 06 Mar 2020 13:33:56 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW74+m1tk4BGgyQRCcx1cU5W=DKWL1mq7EpriW6s=JajVg@mail.gmail.com>
 <CAD9gYJ+3gP+6aannsjzq=L0DsQ-dC2wj4SJfU3+n-t3pG0q3pg@mail.gmail.com> <5E61354C.2090901@youngman.org.uk>
In-Reply-To: <5E61354C.2090901@youngman.org.uk>
From:   William Morgan <therealbrewer@gmail.com>
Date:   Fri, 6 Mar 2020 15:33:45 -0600
Message-ID: <CALc6PW6HYK_6UAtUVz4nmXF=BOwRrkt9HQFb0wpL5BM8tU9N4w@mail.gmail.com>
Subject: Re: Need help with degraded raid 5
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Jinpu Wang <jinpuwang@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Mar 5, 2020 at 11:22 AM Wols Lists <antlists@youngman.org.uk> wrote:
>
> On 05/03/20 14:53, Jinpu Wang wrote:
> > "mdadm /dev/md0 -a /dev/sdl1"  should work for you to add the disk
> > back to array, maybe you can check first with "mdadm -E /dev/sdl1" to
> > make sure.
>
> Or better, --re-add or whatever the option is. If it can find the
> relevant data in the superblock, like bitmap or journal or whatever, it
> will just bring the disk up-to-date. If it can't, it functions just like
> add, so you've lost nothing but might gain a lot.
>
> Cheers,
> Wol

I tried re-add and I get the following error:

bill@bill-desk:~$ sudo mdadm /dev/md0 --re-add /dev/sdl1
mdadm: Cannot open /dev/sdl1: Device or resource busy

sdl is not mounted, and it doesn't seem to be a device mapper issue:

bill@bill-desk:~$ sudo dmsetup table
No devices found

Here is the current state of sdl:

bill@bill-desk:~$ sudo mdadm -E /dev/sdl1
/dev/sdl1:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x9
     Array UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
           Name : bill-desk:0  (local to host bill-desk)
  Creation Time : Sat Sep 22 19:10:10 2018
     Raid Level : raid5
   Raid Devices : 4

 Avail Dev Size : 15627786240 (7451.91 GiB 8001.43 GB)
     Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
    Data Offset : 264192 sectors
   Super Offset : 8 sectors
   Unused Space : before=264112 sectors, after=0 sectors
          State : clean
    Device UUID : 8c628aed:802a5dc8:9d8a8910:9794ec02

Internal Bitmap : 8 sectors from superblock
    Update Time : Mon Mar  2 17:41:32 2020
  Bad Block Log : 512 entries available at offset 40 sectors - bad
blocks present.
       Checksum : 7b89f1e6 - correct
         Events : 10749

         Layout : left-symmetric
     Chunk Size : 64K

   Device Role : spare
   Array State : AAA. ('A' == active, '.' == missing, 'R' == replacing)

What am I overlooking?
