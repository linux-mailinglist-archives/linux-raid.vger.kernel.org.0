Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD72C1AB2
	for <lists+linux-raid@lfdr.de>; Tue, 24 Nov 2020 02:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgKXBKg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Nov 2020 20:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbgKXBKg (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 23 Nov 2020 20:10:36 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236A7208DB
        for <linux-raid@vger.kernel.org>; Tue, 24 Nov 2020 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606180235;
        bh=WdtXzs+uMdWJ3Skg71U73WjfAGmcWwQtJtTi9gbNNOY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g6OK09dr66sENcQNPFLTnoQrdPLsND30xOSnIMFK6ff93tDdhUVhsqirj27c97F5V
         AWL7MT0w31+WWyisHCXBRtftlSG1uDFHqy0jM4ylGgMSkxTVzZtsU30c9gYopP3mcP
         C+8+h242QnNK/vaefLDkQ7kLhNWF2SVKNxp5Mxz0=
Received: by mail-lj1-f176.google.com with SMTP id f24so7265838ljk.13
        for <linux-raid@vger.kernel.org>; Mon, 23 Nov 2020 17:10:28 -0800 (PST)
X-Gm-Message-State: AOAM530a1kD7h6+llPsbcexMu/8SB9pUJxD/CwkeXJCytBSYl6MYDlNZ
        GaiHwnx70a8CHPzPb8mzM9HnjtyZcDHtBKXrAwU=
X-Google-Smtp-Source: ABdhPJy24hbIVL0lBfOZxn1j29SNgNDNIrz0e80yPAP7Tk8GwJyBtrEIDlaEkW5RtQG83kZXQxjqeOiYp/p/lepYLzs=
X-Received: by 2002:a2e:8e76:: with SMTP id t22mr849873ljk.10.1606180226478;
 Mon, 23 Nov 2020 17:10:26 -0800 (PST)
MIME-Version: 1.0
References: <1605786094-5582-1-git-send-email-heming.zhao@suse.com>
In-Reply-To: <1605786094-5582-1-git-send-email-heming.zhao@suse.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 23 Nov 2020 17:10:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4omFykYG7bURDZ+0XbjedasMO=tXa_nCNe=RSiHMbdsQ@mail.gmail.com>
Message-ID: <CAPhsuW4omFykYG7bURDZ+0XbjedasMO=tXa_nCNe=RSiHMbdsQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] md/cluster bugs fix
To:     Zhao Heming <heming.zhao@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Xiao Ni <xni@redhat.com>, lidong.zhong@suse.com,
        NeilBrown <neilb@suse.de>, Coly Li <colyli@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Nov 19, 2020 at 3:42 AM Zhao Heming <heming.zhao@suse.com> wrote:
>
> Hello List,
>
> There are two patches to fix md-cluster bugs.
>
> The 2 different bugs can use same test script to trigger:
>
> ```
> ssh root@node2 "mdadm -S --scan"
> mdadm -S --scan
> for i in {g,h,i};do dd if=/dev/zero of=/dev/sd$i oflag=direct bs=1M \
> count=20; done
>
> echo "mdadm create array"
> mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sdg /dev/sdh \
> --bitmap-chunk=1M
> echo "set up array on node2"
> ssh root@node2 "mdadm -A /dev/md0 /dev/sdg /dev/sdh"
>
> sleep 5
>
> mkfs.xfs /dev/md0
> mdadm --manage --add /dev/md0 /dev/sdi
> mdadm --wait /dev/md0
> mdadm --grow --raid-devices=3 /dev/md0
>
> mdadm /dev/md0 --fail /dev/sdg
> mdadm /dev/md0 --remove /dev/sdg
> mdadm --grow --raid-devices=2 /dev/md0
> ```
>
> For detail, please check each patch commit log.
>

Applied the series to md-next. Thanks for the fix.

Song
