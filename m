Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0D1B2C8A
	for <lists+linux-raid@lfdr.de>; Tue, 21 Apr 2020 18:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDUQWj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Apr 2020 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUQWj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Apr 2020 12:22:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990FCC061A10
        for <linux-raid@vger.kernel.org>; Tue, 21 Apr 2020 09:22:37 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j3so14572026ljg.8
        for <linux-raid@vger.kernel.org>; Tue, 21 Apr 2020 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=METThiIPjM743qBzJzqyCHKuHmbZIzO064QA4Ujo2cs=;
        b=r2ONugxKPErNk1al1TRkHBAaAtW1bnFPYX5MZACbAfzwxuBzV95to6NV1qst8Fwwop
         KSsTbBKHfGSH5LvGQiUN1XaQMYJf9CNho2JjXqY199kBLEog8WqhHqmZyndMSqyANu3I
         N9r81a1yMTwEcDDm065C+QVC8rS77GenFaRKrn5euki8L34AGcnOnfysXdBaAbRfTyA9
         F00QYy+WyQ50tK5+2zL2uBi38uK+Ht8GUR0LazITF8iIKErMST7zp+hLSkBuICkqv1sZ
         IyS5xM80SSrXI0M+Vj0gaPHjF33Z3U8O1NKWJzqAdfOtrgSjOOiqOvQXWrWJNwpX9bOA
         u2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=METThiIPjM743qBzJzqyCHKuHmbZIzO064QA4Ujo2cs=;
        b=XfMG9m4T4LhDgqXkOLYRA3kyJZYlM1y2KKvhPkdL4xi0kgs5mGUseBUi2tZJxmIKC/
         QZO1l1JzBDNOQGMVVMTKM3rxob/EIHZf1829xiEubKQ0DX3Y7B4gBTdfm0+xAA59Qkkc
         eXOwRXmuBHuI7f7wW631WSAexqiQ7EPcgGH1u3wmDk8GHFHXvEMMez7Dx1ru54Lssh2F
         DshnNoRfIhmLA/n9/Dgszp2b4RVK4n6f2bO2zvTAKgS/mBh7aZTi0qWUyWkewnDRFThW
         04+a41Kl0dug6rZdjxFHM7wVEap9MJBsKn5YMf5Ts40vkiUrO8wSasTce3/BesIZEmUL
         OB0Q==
X-Gm-Message-State: AGi0PuYPoTM1BR1S51PPmrLSDXH2GB9GsTeLSNPp9fcbgJoUljWTXjSt
        QXxF7cN0SQOupY+4q2WBxSw2T+p7KVv29NFkDDGUN/MEHjQ=
X-Google-Smtp-Source: APiQypKT0QVoZIteeCTk8AODytxKyV6oYk7LsTW+CLyGS+7k7WiKZebgic5nb9k3fNz/IH8wTNatybcNVkSusKbRMGg=
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr119645ljp.95.1587486156010;
 Tue, 21 Apr 2020 09:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAM++EjGaFBh8ZChnyY0p=du0CKFT1WVikSNYyUUcJhuKwQf4sQ@mail.gmail.com>
In-Reply-To: <CAM++EjGaFBh8ZChnyY0p=du0CKFT1WVikSNYyUUcJhuKwQf4sQ@mail.gmail.com>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Tue, 21 Apr 2020 11:22:24 -0500
Message-ID: <CAAMCDeegCE4x26L4OYttiABxvxiu4qYykAo-b-53G-qW8Ua1Hw@mail.gmail.com>
Subject: Re: Recovering From RAID5 Failure
To:     Leland Ball <lelandmball@gmail.com>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Do a smartctl --all /dev/sdX against each disk and post that.


On Tue, Apr 21, 2020 at 11:16 AM Leland Ball <lelandmball@gmail.com> wrote:
>
> Hello,
>
> I have an old NAS device (Iomega StorCenter ix4-200d  2.1.48.30125)
> which has failed to warn me that things were going awry. The NAS is
> now in a state that appears unrecoverable from its limited GUI, and is
> asking for overwrite confirmation on all 4 drives (1.8TB WD drives).
> This smells of data loss, so I hopped on the box and did some
> investigating:
>
> I can "more" to find data on each of two partitions for each of the 4
> drives /dev/sd[abcd][12] so the drives are functioning in some
> capacity. I believe this is running in a RAID 5 configuration, at
> least that's what the settings state.
>
> Here's what I'm working with...
> # mdadm --version
> mdadm - v2.6.7.2 - 14th November 2008
>
> I believe the array was first created in 2011. Not sure if the disks
> have been replaced since then, as this array was given to me by a
> friend.
>
> I am unsure of how I should go about fixing this, and which (if any)
> drives truly needs replacing. My next step would be to try:
> # mdadm /dev/md1 --assemble /dev/sda2 /dev/sdb2 /dev/sdc2 /dev/sdd2
> (and if that didn't work, maybe try the --force command?). Would this
> jeopardize data like the --create command can?
>
> I've compiled output from the following commands here:
> https://pastebin.com/EmqX3Tyq
> # fdisk -l
> # cat /etc/fstab
> # cat /proc/mdstat
> # mdadm -D /dev/md0
> # mdadm -D /dev/md1
> # mdadm --examine /dev/sd[abcd]1
> # mdadm --examine /dev/sd[abcd]2
> # cat /etc/lvm/backup/md1_vg
> # dmesg
> # cat /var/log/messages
>
> I don't know if md0 needs to be fixed first (if it's even
> malfunctioning). I have never administered RAID volumes at this level
> before. Would appreciate any help you can provide. Thanks!
