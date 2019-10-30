Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29317E93FE
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 01:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfJ3AFZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 20:05:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56772 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfJ3AFZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 29 Oct 2019 20:05:25 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iPbUI-0007qe-Ll
        for linux-raid@vger.kernel.org; Wed, 30 Oct 2019 00:05:22 +0000
Received: by mail-il1-f199.google.com with SMTP id a17so510508ilb.20
        for <linux-raid@vger.kernel.org>; Tue, 29 Oct 2019 17:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2MC+npABTTHSznlud1g4Ic4IEIM45pQgB7RdFM+yQxU=;
        b=WxDV69eI6C189Twu5JBL35EQL5+M2j1jp8qhGMiueyDLAlryB109y0AfFfPAi1J2WO
         Z3JbwT193OStBbunONcq/zLZ1FjH/nAPXJw4W3Y+u7ZdhbOyxbbw8bMyzWXBxBK0GDeO
         4rpByvJMdbF0hHJQQyFz4Dp7ZPyXMfQHndo9rMtVfzlszKCPfN/bi/XubjClPh7gVJvJ
         I/d/BKt/nLxC1rNH+67s5hrHjwMAyNqo5cyvdnKCM6f0E3ONud6aoPW1Wmpqj/7FKBXZ
         uHT9BIENadEqI2F9CytQ9XFtenUwIkmW99v5HG4H4HdfZAmQDDoOqnuFqOMWV8PKbbmD
         Bhjg==
X-Gm-Message-State: APjAAAWhoyTvVAPcR9Lfhk+u7nKxVoepQ3nYpT5MgqVfwDD/fzTiK3kx
        5QgK022xCaoNZnpFt4rrOzVj9bl1Nl1yw3kh4kz/7Sm6H2VNzG8zL5JFxbsj18hUcge3T6VK3FV
        0rw9Ps0AOlG6QviWrigfhTT7rTDyOaCIFna/DP30=
X-Received: by 2002:a92:b314:: with SMTP id p20mr30342702ilh.80.1572393921317;
        Tue, 29 Oct 2019 17:05:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSkZ99TYYAYa+/0mjI+DpuLMvr9or2TGdmOIyMAKaG9K1C8sXijtsfK7F5TK1vB2IpT0u/xg==
X-Received: by 2002:a92:b314:: with SMTP id p20mr30342656ilh.80.1572393920850;
        Tue, 29 Oct 2019 17:05:20 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id d197sm51088iog.15.2019.10.29.17.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 17:05:20 -0700 (PDT)
Date:   Tue, 29 Oct 2019 18:05:19 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Andreas <a@hegyi.info>
Cc:     linux-raid@vger.kernel.org
Subject: Re: raid0 layout issue documentation / confusions
Message-ID: <20191030000519.GA2854@xps13.dannf>
References: <1389f13b-eaf0-7ae2-d99b-697ae008f2c9@hegyi.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1389f13b-eaf0-7ae2-d99b-697ae008f2c9@hegyi.info>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Oct 29, 2019 at 10:21:25PM +0100, Andreas wrote:
> (I wanted to react to the thread "admin-guide page for raid0 layout issue", but I just registered and I don't know how to respond to
> existing messages.)
> 
> I would like to make some suggestions regarding the recent
> raid0 layout patch, as it made my system unbootable, and
> it took me quite some time to figure out what was wrong
> and how to fix it. I also encountered  confusion on the
> web. I am just a regular user, not a programmer or linux
> guru, so take my suggestions as such.
>
> * Everywhere where the values are documented, all three of
> 0, 1, and 2 should be explicitly documented (not only two
> of them). If I am not mistaken, 0 means "unset", 1 means
> "old layout" (kernel 3.14 and older), 2 means "new layout"
> (3.15 and later).

Off-by-one there - it is older than 3.14 vs. 3.14 and later.

> * When trying to assemble existing array but without the
> kernel parameter set (i.e. set to 0) it silently fails.
> Only in the kernel ring buffer there is a message:
>  md/raid0:md0: cannot assemble multi-zone RAID0 with default_layout setting
>  md/raid0: please set raid.default_layout to 1 or 2
> 
>   When trying to create a raid0 array, it gives an error, but it is not helpful:
>     mdadm: Defaulting to version 1.2 metadata
>     mdadm: RUN_ARRAY failed: Unknown error 524
> 
> For both cases, and both places (mdamd and dmesg) should be more informative.
> 
> * The recommended parameter value for new raid0 arrays should be made clear. I guess it's 2.

Thanks for mentioning this - my understanding is that neither is
inherently better than the other, and I've noted as much in my patch.

> * Various places where documentation could (or should) be added:
> 	- mdamd error messags
> 	- kernel ring buffer messages
> 	- mdadm man page
> 	- mdadm wiki
> 	- kernel parameter documentation pages
> 
> Confusions:
> * The definition of the parameter values is wrong in the patch description:
> https://github.com/torvalds/linux/commit/c84a1372df929033cb1a0441fb57bd3932f39ac9#diff-158c54ea7ccae01a77ae3f5d44ab0f94
> it says 0 is old, 1 is new. Please fix, because this
> contributes to confusion, and may even lead to data
> corruption.

Sorry, we can't retroactively change a commit message.

> * On the raid mailing list
> https://www.spinics.net/lists/raid/msg63337.html someone
> said "new (1) and old (2) vs. unset (0)". No one objected,
> but I guess that this is also wrong?
> 
> * Two webpages (of the rare ones on this issue) are conflicting on what is the meaning of parameter 1 and 2.
>         https://blog.icod.de/2019/10/10/caution-kernel-5-3-4-and-raid0-default_layout/ says 1 is old, 2 is new.
>         https://www.reddit.com/r/linuxquestions/comments/debx7w/mdadm_raid0_default_layout/ says 2 is old, 1 is new.
> 
> * https://blog.icod.de/2019/10/10/caution-kernel-5-3-4-and-raid0-default_layout/
> suggests that the kernel parameters should be set in GRUB
> as GRUB_CMDLINE_LINUX_DEFAULT="raid0.default_layout=2" (or
> 1), but in my opinion it should set
> GRUB_CMDLINE_LINUX_DEFAULT because
> GRUB_CMDLINE_LINUX_DEFAULT is not used in recovery mode,
> but GRUB_CMDLINE_LINUX is. So, please document all
> possible (recommended) ways to set the parameter: GRUB,
> /etc/modprobe.d/00-local.conf, and
> /sys/module/raid0/parameters/default_layout.

Getting into the specifics of configuring individual bootloaders in
the kernel docs is a slippery slope. We can tell you what to set, but your
bootloader docs (or pages like the above) need to tell you how to set it.
That said, if you find incorrect documentation out there, it would be
appreciated if you could ask the site owner to correct it.

> * I was also wondering why the patch had to disable
> assembling if it was a working array on my system. Isn't
> it obvious, based on the kernel version with which it
> worked before the update, whether it should be 1 or 2? Why
> wasn't it possible to first automatically set the default
> kernel variable in grub.cfg and then do the update?

IMO, that's really an issue for distributions to consider, as the kernel
doesn't know what version you previously booted. However, note that
just because you're upgrading from say 5.0.1 to 5.0.2, doesn't mean
that you hadn't written to your array with, say, 3.12 in the past. And
maybe all of your data was written w/ 3.12 and layout=1 is the best
choice.

> * Why is this parameter actually a *kernel* parameter.
> While not very likely, it is possible that two arrays with
> different layouts (needing different parameter settings)
> will end up in the same machine. In such a case any
> parameter choice may lead to data corruption. I would
> think that the layout parameter is a property of the
> specific array, so it should be in the meta-data of the
> array itself.

It is - as noted in my admin-guide patch, you can also set this on a
per-array basis via sysfs while the array is stopped.

  -dann
