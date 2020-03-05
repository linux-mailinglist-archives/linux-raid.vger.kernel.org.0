Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5246017A828
	for <lists+linux-raid@lfdr.de>; Thu,  5 Mar 2020 15:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCEOx3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Mar 2020 09:53:29 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:35848 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCEOx3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Mar 2020 09:53:29 -0500
Received: by mail-lj1-f175.google.com with SMTP id 195so6407626ljf.3
        for <linux-raid@vger.kernel.org>; Thu, 05 Mar 2020 06:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G1zUnEQbyaLq6RvHA3LUPNVrqTkpasaq/pMmOs10qXg=;
        b=GwHGB3tkr91vFJip2qXdwvUEnWPPwDx3+axW3fEZOg3wogBbpzmoJcmBlY+j6vMKZl
         JIWTo/WmcWYiULECfqby0KdbXgB9TUApL+J6FeBXqoZvbscTx80TngoFPi3fKkN5g1XN
         2UPNTEADwJ1WNpe3UylyL+p7Si41+eFW97cria4NfVOxeZGBw+Dqkv71RF8JTxcqtQsp
         Nkox/xYb38s9BR4DFYMd0Wu8+UiD3hwMEYtMIpkptfinqjvDgze9uaFAeVmfXEn53UZF
         VvONpXq6eDqNEEppHuySlLBVqWaS+CV7WyweSkVZPeA0wQ0oCUchqdTTguYiFUVObdrL
         GEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G1zUnEQbyaLq6RvHA3LUPNVrqTkpasaq/pMmOs10qXg=;
        b=tqD9k8ReVDuXdAqEX94cASatN4WVC0BsfO+C5p6Z+op0/FkhHG4RgqyCuQ1cXLlJHc
         hcra0Po0xgkooqpCNKnlDFzsTGw49qUiEm+SBADMOB7jRuZ6dGrmByLbu7uCztv0AvbL
         jyujjbYlgeiUh+T/WgmwOeQwlao45N8B2EUNot+pMf0ZEVLKPhbMdPcvjnR1Rump6srR
         WUuqe96eID3CmZK0VZde7l6dfiNoL5d/1KMb5KAcPIsL1cVCaEvFNfwncJtmHTdEQm7a
         ayMMRoYbgwhhQXf5EtaXxaG5eb+Ez941PZLaaLPHGJN5u91tb2XIAlKUl4wNLoxS7DY5
         2xgA==
X-Gm-Message-State: ANhLgQ2QfdZl92Gyr3IYdBjCTBXVr1poB/+QaH8G0YLM5gbJzgVq132p
        zzDaPa13sWPkxmkjN0pQ59vs8icfLLUBDVn8ICethw==
X-Google-Smtp-Source: ADFU+vvMe997bMW+7Du3d6wIIINLOthx49zRMoDHKAchvDxtqkFExuyXFPzZMlrEOppbF2eh9s+GRsH5YduhUBZYx1o=
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr5390739ljj.81.1583420007411;
 Thu, 05 Mar 2020 06:53:27 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW74+m1tk4BGgyQRCcx1cU5W=DKWL1mq7EpriW6s=JajVg@mail.gmail.com>
In-Reply-To: <CALc6PW74+m1tk4BGgyQRCcx1cU5W=DKWL1mq7EpriW6s=JajVg@mail.gmail.com>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Thu, 5 Mar 2020 15:53:16 +0100
Message-ID: <CAD9gYJ+3gP+6aannsjzq=L0DsQ-dC2wj4SJfU3+n-t3pG0q3pg@mail.gmail.com>
Subject: Re: Need help with degraded raid 5
To:     William Morgan <therealbrewer@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

William Morgan <therealbrewer@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=885=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:33=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hello,
>
> I'm working with a 4 disk raid 5. In the past I have experienced a
> problem that resulted in the array being set to "inactive", but with
> some guidance from the list, I was able to rebuild with no loss of
> data. Recently I have a slightly different situation where one disk
> was "removed" and marked as "spare", so the array is still active, but
> degraded.
>
> I've been monitoring the array, and I got a "Fail event" notification
> right after a power blip which showed this mdstat:
>
> Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5]
> [raid4] [raid10]
> md0 : active raid5 sdm1[4](F) sdj1[0] sdk1[1] sdl1[2]
>       23441679360 blocks super 1.2 level 5, 64k chunk, algorithm 2 [4/3] =
[UUU_]
>       bitmap: 0/59 pages [0KB], 65536KB chunk
>
> unused devices: <none>
>
> A little while later I got a "DegradedArray event" notification with
> the following mdstat:
>
> Personalities : [raid6] [raid5] [raid4] [linear] [multipath] [raid0]
> [raid1] [raid10]
> md0 : active raid5 sdl1[4] sdj1[1] sdk1[2] sdi1[0]
>       23441679360 blocks super 1.2 level 5, 64k chunk, algorithm 2 [4/3] =
[UUU_]
>       [>....................]  recovery =3D  0.0% (12600/7813893120)
> finish=3D113621.8min speed=3D1145K/sec
>       bitmap: 2/59 pages [8KB], 65536KB chunk
>
> unused devices: <none>
>
> which seemed to imply that sdl was being rebuilt, but then I got
> another "DegradedArray event" notification with this:
>
> Personalities : [raid6] [raid5] [raid4] [linear] [multipath] [raid0]
> [raid1] [raid10]
> md0 : active raid5 sdl1[4](S) sdj1[1] sdk1[2] sdi1[0]
>       23441679360 blocks super 1.2 level 5, 64k chunk, algorithm 2 [4/3] =
[UUU_]
>       bitmap: 2/59 pages [8KB], 65536KB chunk
>
> unused devices: <none>
>
>
> I don't think anything is really wrong with the removed disk however.
> So assuming I've got backups, what do I need to do to reinsert the
> disk and get the array back to a normal state? Or does that disk's
> data need to be completely rebuilt? And how do I initiate that?
>
> I'm using the latest mdadm and a very recent kernel. Currently I get this=
:
>
> bill@bill-desk:~$ sudo mdadm --detail /dev/md0
> /dev/md0:
>            Version : 1.2
>      Creation Time : Sat Sep 22 19:10:10 2018
>         Raid Level : raid5
>         Array Size : 23441679360 (22355.73 GiB 24004.28 GB)
>      Used Dev Size : 7813893120 (7451.91 GiB 8001.43 GB)
>       Raid Devices : 4
>      Total Devices : 4
>        Persistence : Superblock is persistent
>
>      Intent Bitmap : Internal
>
>        Update Time : Mon Mar  2 17:41:32 2020
>              State : clean, degraded
>     Active Devices : 3
>    Working Devices : 4
>     Failed Devices : 0
>      Spare Devices : 1
>
>             Layout : left-symmetric
>         Chunk Size : 64K
>
> Consistency Policy : bitmap
>
>               Name : bill-desk:0  (local to host bill-desk)
>               UUID : 06ad8de5:3a7a15ad:88116f44:fcdee150
>             Events : 10407
>
>     Number   Major   Minor   RaidDevice State
>        0       8      129        0      active sync   /dev/sdi1
>        1       8      145        1      active sync   /dev/sdj1
>        2       8      161        2      active sync   /dev/sdk1
>        -       0        0        3      removed
>
>        4       8      177        -      spare   /dev/sdl1

"mdadm /dev/md0 -a /dev/sdl1"  should work for you to add the disk
back to array, maybe you can check first with "mdadm -E /dev/sdl1" to
make sure.

Regards,
Jack Wang
