Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A722A163
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 23:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgGVVbO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 17:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgGVVbN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 17:31:13 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E9F22B43
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 21:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595453473;
        bh=8qq8fRG+TsoqjZ26FdO9zsWY5bLktCmrzt2TvqHSs8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0hikaNwGu/9x5I51i1CjR5c7331flyAvLB51Wd5RsjoP4yU9yQWXiemXrcwNeKdVW
         KAbTQmMLuPG4M64raXN3sMvA6aROP68tZ2wfq9CBIOli6//htdqBjWGxDd3TCQ7jPk
         85YKu3iXDyTPW/4sah6CwCidY/xSXlZwzgzgZaGg=
Received: by mail-lj1-f169.google.com with SMTP id j11so4096063ljo.7
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 14:31:13 -0700 (PDT)
X-Gm-Message-State: AOAM531MbCXhQvV957X5TWgzHElWzb/kbGWRzKRmQi7ywHXESyfRHeTX
        BV4sV2g8ArKln3Tpb27BAor1kdSeXvRfKDs2C94=
X-Google-Smtp-Source: ABdhPJzze99u071fR+h2uvjRiAygDx8/5ewgRy9iovPtfhMO8mo7RLjkBHgVV2If4upvwg1vzAbgIVWCUjGfh53oGjM=
X-Received: by 2002:a2e:6a12:: with SMTP id f18mr481548ljc.392.1595453471388;
 Wed, 22 Jul 2020 14:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <202007230512.Ql0lYtJc%lkp@intel.com>
In-Reply-To: <202007230512.Ql0lYtJc%lkp@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 22 Jul 2020 14:31:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW66LPe0feQtgns=Tp2JYvUNT6vDnqg6j1inq+WT8uQrsQ@mail.gmail.com>
Message-ID: <CAPhsuW66LPe0feQtgns=Tp2JYvUNT6vDnqg6j1inq+WT8uQrsQ@mail.gmail.com>
Subject: Re: [song-md:md-next 9/14] ERROR: modpost: "__udivdi3" undefined!
To:     kernel test robot <lkp@intel.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, kbuild-all@lists.01.org,
        linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 22, 2020 at 2:21 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
> head:   fe630de009d0729584d79c78f43121e07c745fdc
> commit: e236858243d7a8e0ac60972d2f9522146088a736 [9/14] md/raid5: set default stripe_size as 4096
> config: m68k-sun3_defconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e236858243d7a8e0ac60972d2f9522146088a736
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "__udivdi3" [drivers/md/raid456.ko] undefined!

Yufen, could you please look into this one? I guess it is caused by ilog2().

Thanks,
Song
