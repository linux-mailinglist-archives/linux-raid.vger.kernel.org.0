Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1215346D3D
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 02:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfFOAjx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 20:39:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:47003 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOAjx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 14 Jun 2019 20:39:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so4527632qtn.13
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 17:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZfky0pC0FeXNm8JQzJReaJM3gpArv/0/JyXivVUd9A=;
        b=KNoARwycyFxvQZGlEvrKlgOHyow1CWAAdn0Uy9ABgTntjh9xo05Zgy7Z783hLQUhUb
         a+HpQMRh7ybnYEafXWlthSdmA5jGrIpu2Mi/sZgZavwJmBak4eV9emcldtMSWTlppa27
         UNWTQtjdOW/5lzd/nmFzmvv4am60gr9EyrwOk3r0JHCy6k/R7KXXn0bBEtE1UvS/msaJ
         EY2kWybo88/VlN2EH098q5h77aOA5GZyjCzFJ5Rc6jHhOFRhBFbMOAtvSnJzqmYQBibe
         BP8maJjhgr3iwqUJTwVrsS0aEfulij7A1Seeyy0AhkfWTPttEeWBAEL9fu1cf8Aeg9u8
         3+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZfky0pC0FeXNm8JQzJReaJM3gpArv/0/JyXivVUd9A=;
        b=uZkWutmWrDPcCnUy2zuswh59en9NDHzQKxGygpZGlYrWvcN0ixYGzlDVB6e/7ku6bY
         U4n7CsKQTJXUBkmkGWBZNPx/B7RTqT0SKv2bIAO4sZ66SfFfdUB6w3WuJP3cKhXZ4+0d
         f/bUYBGZLmW4kQIgbS2Pq6ARqy5BX6pAmMvioRb/IEmkkj35dIV09dBPDx1sBoqUSpGM
         cNex2mQ1HfFmYVE5qgkb1gli9oADTvijVyqUez86kEuKSLtaaV2D/wRQ0999U21Kr67C
         voxJoFY/NRKEfaDXkFyC4i3A2+1mnfalHSEltdJXUcFlJKcZzMDbBmCRWpECC1FSohCR
         AR4g==
X-Gm-Message-State: APjAAAXsCaVoa3P3E9SXV2F2G7IQp1DJe4XjxweSd9RJ9A6oIAiLfWdY
        +3JuwoVBUqtiSPImeQ2fH8ZtC3aR8bvUKsWhqRi45g==
X-Google-Smtp-Source: APXvYqxyJ3DLrl569JynCf60bn0MaRiYBRWJkxVnoHz7afZQJiONpcxv9w8gghyZg86PgG5AxckGur0aMqJ/1QHW59E=
X-Received: by 2002:a0c:9695:: with SMTP id a21mr10825635qvd.24.1560559192379;
 Fri, 14 Jun 2019 17:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
In-Reply-To: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 14 Jun 2019 17:39:41 -0700
Message-ID: <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
Subject: Re: md0: bitmap file is out of date, resync
To:     Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jun 14, 2019 at 3:57 PM Mathias G <newsnet-mg-2016@tuxedo.ath.cx> wrote:
>
> Hello together
>
> For a long time now (surely since the beginning of 2018) I have the
> problem that every now and then after a reboot of the system (PC
> workstation) the RAID-1 is resynchronized.

To be clear, this does not happen every time, right?

>
> Possibly the problem occurs mostly or always after an kernel update
> kernel, but there are cases (like today) where no update was made.
>
> The RAID-1 consisting of 2x 2TB SATA HDD
>
> The RAID is built with mdadm, at the earlier days with header version
> 0.x, but also completely rebuilt (because of this problem) with header
> version 1.2
>
> The Linux system is a Debian "testing" (version 10.0)
>
> Current kernel version: 4.19.0-5-amd64 #1 SMP Debian 4.19.37-3
> (2019-05-15) x86_64 GNU/Linux
>
> But the problem was already at version: 4.17.0-1-amd64 #1 SMP Debian
> 4.17.8-1 (2018-07-20) x86_64 GNU/Linux
>
> The log entry in kern.log (after restart) when the RAID needs to be
> resynchronized:
> > Jun 14 23:11:01 $hostname kernel: [    2.132085] md/raid1:md0: not clean -- starting background reconstruction
> > Jun 14 23:11:01 $hostname kernel: [    2.132088] md/raid1:md0: active with 2 out of 2 mirrors
> > Jun 14 23:11:01 $hostname kernel: [    2.132245] md0: bitmap file is out of date (228834 < 228835) -- forcing full recovery
> > Jun 14 23:11:01 $hostname kernel: [    2.132297] md0: bitmap file is out of date, doing full recovery

And the bitmap is stored in a file? And the file is on a different disk, right?

Thanks,
Song

>
> The new synchronization will look like this (today):
> > $ cat /proc/mdstat
> > Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5] [raid4] [raid10]
> > md0 : active raid1 sdb1[0] sdc1[3]
> >       1953382464 blocks super 1.2 [2/2] [UU]
> >       [=====>...............]  resync = 25.7% (502785344/1953382464) finish=216.8min speed=111498K/sec
> >       bitmap: 13/15 pages [52KB], 65536KB chunk
> >
> > unused devices: <none>
>
> I suspected once that something would not stop correctly before shutting
> down, but how could you debug something like that?
>
> I already tried to replug all SATA cables - without success. In the
> meantime even a new mainboard/CPU/RAM is installed and one of the two
> SATA 2TB disks is replaced by a new one. But the the problem remained :-/
>
> While searching the internet I found a partially similar problem [1] but
> without an solution.
>
> Does anyone have any idea how I could narrow down or fix the problem?
>
> Thanks a lot!
>
> [1] https://www.spinics.net/lists/raid/msg47475.html
> --
> kind regards
>  mathias
