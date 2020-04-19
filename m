Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0B1AFAD7
	for <lists+linux-raid@lfdr.de>; Sun, 19 Apr 2020 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDSNlm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Apr 2020 09:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgDSNlm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 19 Apr 2020 09:41:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE85C061A0C
        for <linux-raid@vger.kernel.org>; Sun, 19 Apr 2020 06:41:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w145so5655426lff.3
        for <linux-raid@vger.kernel.org>; Sun, 19 Apr 2020 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRWDu/HyiI7UxPpphGxVwxouMNwwdZvh1cpNj4ekiZU=;
        b=a4/vUfIiEO5TnwpMgkDzcyNB4IYYXBg4uVpJ82d/QIxV9KIAfguD3wMMe9WmP4jgHL
         NclPMXwCeiDxvrx3LZRIALGqyYicFK21A56Aj4eLcAKJIDLJk1qKWKyR3mpn9R2cDPi9
         bJvb/fa8BE5UC3/eZiWTLjqK49Gc1iTE5lnrLecSR/5hCdIXcfLZ3lnMxEvxXdQO+aof
         JcNukmwdY6ypDTDx8V8P9LvSat8J3dzwBsdbbN05TaeJ0xc+dayFk/gc3EmXGUx21zlQ
         sUTQd5j7v4k6a4TW3MUlIAU5CqsXLYboLCfS687z1c4GmmKCL93SbM6isJCtLpZMhf54
         tOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRWDu/HyiI7UxPpphGxVwxouMNwwdZvh1cpNj4ekiZU=;
        b=Ipuv7AI0XWgiYC9Xd85HofEgJInkD1m942SXkDs81nPaga/KJPUIJhLTrtINSycJvo
         9ir0UPDr8LSRUBADD+4+xl2CMz61C596LyD67sCis0VDBiEMUK4unmpecMHu/LRB007x
         fPIA7AqlkYNlkEgRjwo3JSpvbbeCEMt9RL1G1UTuZu3PDVL31B/FJd9FLzyOcVV9jII+
         Lr0xYQliBECivXIuTgKhzRWukaTZZ/Zp19+taUWkbIihEATg/ZO9urOt/NfsmbDA5JLK
         UIGCDcWTK02L1QaQeBAjzIA8QF7Q+DtSXvmOKHEDS9CadzY0PXRzQG/LDB5LOQ0/zZNW
         RDPA==
X-Gm-Message-State: AGi0Puae62MWN1vAhV4yWHxLCDAdjj8/Kn1UxdYTJMvQx5+ubUY8qMem
        JLUIYxQ/OV7dA6qMS3tzJY4TCEC+688yGNwDaz6NjRQf
X-Google-Smtp-Source: APiQypLUTS9LAi8lyt6oW7zCV1ic7dmvxJV5AiO7hQVmfAstKhneaF3upERJJQXtierz+RWdKtNT/y5KrYjT1FL4nng=
X-Received: by 2002:a19:4014:: with SMTP id n20mr7225377lfa.6.1587303700012;
 Sun, 19 Apr 2020 06:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <f81b931b-2599-6ae1-bc4a-11eb0daea339@shenkin.org>
In-Reply-To: <f81b931b-2599-6ae1-bc4a-11eb0daea339@shenkin.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Sun, 19 Apr 2020 08:41:27 -0500
Message-ID: <CAAMCDefJK3iAOguZ03H=dciW_8afGEb_gvFZd5+JSnidXxK6QQ@mail.gmail.com>
Subject: Re: raid1 + raid6 setup recommendations
To:     Alexander Shenkin <al@shenkin.org>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

So mine I used to have raid1 for boot, I gave up on that and simply
put the boot disk on a non-raided SSD.    I figure I can reinstall the
OS easily and get the raid6 to work, I do have something copying
critical config files into a directory in the raid6 to facilitate a
rebuilt.  So far I have done a clean reinstall of the OS disk 2-3
times and brought the raid6 across.   I also have ,nofail on the fstab
options for the raid6, this makes sure if the raid has an issue that
the OS still boots to full multiuser mode and on the network so I can
more easily login and fix whatever issue it was.   My boot SSD is also
500GB as the stuff I have that writes all of the time write to that
disk (motion/security cam software, and Mythtv recordings/DB). so that
the raid6 can spin down most of the time.  There is a nightly copy job
that moves the data to the raid6.   I write say 150GB/day to the ssd
has 59% life remaining and has been used like this for around 3 years.

On Sun, Apr 19, 2020 at 2:06 AM Alexander Shenkin <al@shenkin.org> wrote:
>
> Hi all,
>
> I recently recovered my raid6 that had a problem during a reshape.  My
> system no longer boots, so I'm taking the opportunity to install a new,
> clean OS.  I have 7 disks with /boot mounted on a ~1.5 GB raid1 spread
> across partitions on all disks, and / mounted on a 15TB raid6 with
> partitions across all disks (~3 TB / disk).  11TB of that 15TB raid6 is
> filled with data I'd prefer not to lose.  I was going to use the same
> layout to install ubuntu server 18, but partman is not able to mount the
> raid6 for some reason (it thinks it's ext2, when it's ext4).
>
> I've gotten some feedback saying that it's not wise to use a huge raid
> to mount at /, and that it might be better to mount the principal OS on
> a separate mount point so that it can be formatted.  I don't know if I'm
> able to use LVM at this point, given that I have data I don't want to
> lose on the raid6.  It would be convenient to create another device at
> this point so that I could format it and presumably get around partman's
> inability to mount my raid6 at /...
>
> So, the question is, do you agree that it's better to separate out the
> OS in another raid array or mount point?  If so, is LVM an option at
> this point, or should I somehow shrink the raid6 to make room for
> another partition across all disks for another raid for the OS?
> Finally, if so, (and perhaps this is beyond the scope of this list),
> which root directories would you put where?
>
> Many thanks,
>
> Allie
>
