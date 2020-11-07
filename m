Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9C22AA1BB
	for <lists+linux-raid@lfdr.de>; Sat,  7 Nov 2020 01:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgKGARs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 6 Nov 2020 19:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbgKGARs (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 6 Nov 2020 19:17:48 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7680D2087E
        for <linux-raid@vger.kernel.org>; Sat,  7 Nov 2020 00:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604708267;
        bh=w9AHeUgsbS21qz/kGcH7wQrUOhCa3nGk39KYZmKBWBU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wpLfaLJCPHhfvLyvVJOY5FkVhxwxJTrUV+TtfvIYyph6I4ScJ98CUgGImlbf/cZB5
         sRzCzXpVS0j9rofnkqEl8O0nmiNg2Vlo4Uj8UV9s94Nas+06PB8rqHjg6qNgA4mkNa
         qV+Eti+KT/1ytLLE15kVhuye9/L9+/YQfeLsr/jY=
Received: by mail-lj1-f175.google.com with SMTP id y25so2408204lja.9
        for <linux-raid@vger.kernel.org>; Fri, 06 Nov 2020 16:17:47 -0800 (PST)
X-Gm-Message-State: AOAM533hVJxJ2zwFy01k9ya18FVM0PEkttijEnczmhAYloe0tLJkUCb2
        hgPNxcDkHmeWuDd7+XrNBgMHWHCLrxOz0iWdxdE=
X-Google-Smtp-Source: ABdhPJziaqEfNV66C+cLVUgINMAMRoZt2wdxkqIlyo0FDbmHOKHjVQw3rdeafRh/fdcCok345SlIY/mPZ+nxJFVSdjw=
X-Received: by 2002:a2e:6d09:: with SMTP id i9mr1707330ljc.10.1604708263677;
 Fri, 06 Nov 2020 16:17:43 -0800 (PST)
MIME-Version: 1.0
References: <1604581888-27659-1-git-send-email-heming.zhao@suse.com>
In-Reply-To: <1604581888-27659-1-git-send-email-heming.zhao@suse.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 6 Nov 2020 16:17:32 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4GqAXQ=6Hx5FjYhECxmVHDKC0j2oiqx6Q5OLvqe9F9nA@mail.gmail.com>
Message-ID: <CAPhsuW4GqAXQ=6Hx5FjYhECxmVHDKC0j2oiqx6Q5OLvqe9F9nA@mail.gmail.com>
Subject: Re: [PATCH 1/2] md/cluster: reshape should returns error when remote
 doing resyncing job
To:     Zhao Heming <heming.zhao@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        lidong.zhong@suse.com, Xiao Ni <xni@redhat.com>,
        NeilBrown <neilb@suse.de>, Coly Li <colyli@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Nov 5, 2020 at 5:11 AM Zhao Heming <heming.zhao@suse.com> wrote:
>
> Test script (reproducible steps):
> ```
> ssh root@node2 "mdadm -S --scan"
> mdadm -S --scan
> mdadm --zero-superblock /dev/sd{g,h,i}
> for i in {g,h,i};do dd if=/dev/zero of=/dev/sd$i oflag=direct bs=1M \
> count=20; done
>
> echo "mdadm create array"
> mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sdg /dev/sdh
> echo "set up array on node2"
> ssh root@node2 "mdadm -A /dev/md0 /dev/sdg /dev/sdh"
>
> sleep 5
>
> mdadm --manage --add /dev/md0 /dev/sdi
> mdadm --wait /dev/md0
> mdadm --grow --raid-devices=3 /dev/md0
>
> mdadm /dev/md0 --fail /dev/sdg
> mdadm /dev/md0 --remove /dev/sdg
>  #mdadm --wait /dev/md0
> mdadm --grow --raid-devices=2 /dev/md0
> ```

I found it was hard for me to follow this set. IIUC, the two patches try to
address one issue. Please add a cover letter and reorganize the descriptions
like:

  cover-letter: error behavior, repro steps, analysis, and maybe describe the
             relationship of the two patches.
  1/2 and 2/2: what is being fixed.

Thanks,
Song

[...]
