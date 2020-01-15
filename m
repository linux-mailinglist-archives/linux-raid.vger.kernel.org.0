Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F11FD13BA54
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jan 2020 08:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgAOHaF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jan 2020 02:30:05 -0500
Received: from mail-vk1-f180.google.com ([209.85.221.180]:45521 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOHaE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Jan 2020 02:30:04 -0500
Received: by mail-vk1-f180.google.com with SMTP id g7so4409014vkl.12
        for <linux-raid@vger.kernel.org>; Tue, 14 Jan 2020 23:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ni9bRMVShW8s56o4vwZ/G7h5broRTIrtYdzJwKPCdg=;
        b=MpOiTlZPCtpkDo2gGjJaYb8pD/BCfH3ziHXHn5q1cixIGtJ9f3XbGNVLrtZb2mfuwn
         Ei+Y9OTnvRLFEf8V0UXj1rObE+XVFtzHRvwi8XDnl6Epxo6+/BjBNiKbIcwWhth9Jax7
         kvSpAuwW3FE7OjGz3Yq+XTiqtBKYC+Sul0LiNi1Unrsg/phfgxrt8dbmB9ECiFcTkSAr
         w2mtjI5SzP32JAiJ0Bcm1YtkyOJ86WPmgZ98EVooMz5EROSbmguCfcOdypGdO2yOo0+V
         V5acHvoDPDb5B9bB0aD6YG1KY+8cdcJyn+X2lMjkb4gnkCu9nTkIX89IXyB2WRxnjRWh
         4KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ni9bRMVShW8s56o4vwZ/G7h5broRTIrtYdzJwKPCdg=;
        b=bZHwHi7rSIuaQNJDivDrXavBNMhfqqfXSSCTtXjXVZmrB7HxuL9+FzTe7K/WbuOgQC
         WCUX4I+2HT0zsW2VFtAz6wZLGh4dXKwMdQyoQGH4eCqB/JfWV2IxAqoap/megf8hNzqe
         jyLv8z7pzOdNQ3STw1hEIzFAjSbR7STdkXQb5YVJubJ460vPK7usQ2SQXjImwE1wfuEh
         7e4pnTspyVI1IwzrnlJydHd9bA8ZVqq4HUrIp6X4Vat2wcusHkDwds5HcwfS7idigUsE
         cSuaN7XGSJnfDqoT2a36eTT+GFXauHTegiXTwyYOdWYqYqdVRxt4PuPYi3lddC6Qek5+
         CBcg==
X-Gm-Message-State: APjAAAXfyA55S8Oml6CUDIxEeZ223h92rl8WLpAV/2Gh9CkZmCnzI4tf
        ARSeCD7axxNhMg9V0OfouI9JTb5nHA1vufsS2g/UBA==
X-Google-Smtp-Source: APXvYqwRdtiNnRdeEw924tuDunHJmNxZG01p5VrL9pubFANaE/FlMJCcNHicXDKk+GvdjGeFhf32g5er1LXRm5g6LoE=
X-Received: by 2002:a1f:8f44:: with SMTP id r65mr16616412vkd.8.1579073403439;
 Tue, 14 Jan 2020 23:30:03 -0800 (PST)
MIME-Version: 1.0
References: <CAEWf3EDf-CwMz660RjRAtL==fa-Xc2XVpbrJL_Xqw24ZTZ18Zg@mail.gmail.com>
 <20200108122538.GB16146@metamorpher.de>
In-Reply-To: <20200108122538.GB16146@metamorpher.de>
From:   Marco Heiming <myx00r@gmail.com>
Date:   Wed, 15 Jan 2020 08:31:01 +0100
Message-ID: <CAEWf3EA4rG_Xa-xvDNTMuQLQhOh1RuDaogttfAZ1_CWvBb0zfQ@mail.gmail.com>
Subject: Re: Raid 5 cannot be re-assembled after disk was removed
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thank you so far Andreas.

I was able to re-assemble the array with the defective disk (sdd in
this case) and the old spare (sde).
It was rebuilding over night and now it looks like this:

mdadm --detail -v /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Wed Jan  7 18:14:37 2015
        Raid Level : raid5
        Array Size : 8790405120 (8383.18 GiB 9001.37 GB)
     Used Dev Size : 2930135040 (2794.39 GiB 3000.46 GB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Thu Jan  9 19:37:16 2020
             State : clean
    Active Devices : 4
   Working Devices : 4
    Failed Devices : 0
     Spare Devices : 0

  Layout : left-symmetric
  Chunk Size : 512K

Consistency Policy : bitmap

              Name : NAS:0  (local to host NAS)
              UUID : 7b0eee59:07f87155:bdad1d0e:6e3cbad6
            Events : 280445

    Number   Major   Minor   RaidDevice State
       4       8       64        0      active sync   /dev/sde
       1       8       16        1      active sync   /dev/sdb
       3       8       32        2      active sync   /dev/sdc
       0       8       48        3      active sync   /dev/sdd

I was able to mount the array in read-only and it looks like the data
is fine; i also ran a btrfs check in read-only mode and it found no
errors.
So far so good :)

Although disk sdd is still reporting an increasing read error rate via SMART:
smartctl -a /dev/sdd | grep "Raw_Read_Error_Rate"
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       764
therefore i need to replace this disk in the next days.

Thank you so far for your help.


Am Mi., 8. Jan. 2020 um 13:25 Uhr schrieb Andreas Klauer
<Andreas.Klauer@metamorpher.de>:
>
> On Wed, Jan 08, 2020 at 10:31:28AM +0100, Marco Heiming wrote:
> >        0       8        0        -      spare   /dev/sda
>
> Your spare was /dev/sda
>
> > mdadm --examine /dev/sd[b-z]
>
> Here you deliberately examine sdb-z, so what happened to sda?
>
> You mentioned drive letters changed, but is it really not there anymore?
>
> If you don't know which drives you synced in the array then who does...?
>
> Regards
> Andreas Klauer
