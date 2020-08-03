Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511D2239FDB
	for <lists+linux-raid@lfdr.de>; Mon,  3 Aug 2020 08:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHCGzW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 3 Aug 2020 02:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgHCGzW (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 3 Aug 2020 02:55:22 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2457206E9
        for <linux-raid@vger.kernel.org>; Mon,  3 Aug 2020 06:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596437721;
        bh=PKZ/bdwzKheTX9+n+97QPumlsgW0BLdLYr02JzRafwk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RYAcQxzk2xueIhokgkWCNqu4TU6g7tYpVFLaIkPDijddxF+YtAxNCxS+4m4/UsK8K
         czaUJtNUkd1MS2RkpD0V7DIaNdbL62EbN1Ff/Txif4zCkkTHfJccw0o5flcvhNDOrT
         LNq1EjidtIlAmet7ds7j0aiFDJT5kFuZHqXWlNlc=
Received: by mail-lj1-f173.google.com with SMTP id i10so3684951ljn.2
        for <linux-raid@vger.kernel.org>; Sun, 02 Aug 2020 23:55:21 -0700 (PDT)
X-Gm-Message-State: AOAM530mjb9O43pFW6L7eVL3KklKN2IDVmUzRKgjP2rGSmgCWiRYNISK
        doSBrZU629bv2bVrQV8VCdSngo/BSWiJFI37mco=
X-Google-Smtp-Source: ABdhPJwAzt3Tqszpdg8Nor4S0Mm9PbPUklf1oQPTXptgFkTn/HoIRG45VQt7RkdRY9+6xWKchea8NvYuseXvND1fKF4=
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr3108108ljc.350.1596437719943;
 Sun, 02 Aug 2020 23:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <1596188998-2994-1-git-send-email-allenpeng@synology.com>
In-Reply-To: <1596188998-2994-1-git-send-email-allenpeng@synology.com>
From:   Song Liu <song@kernel.org>
Date:   Sun, 2 Aug 2020 23:55:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW72=Mh8v2oYwcftyjescPi06tOt4XZJXebPvnKF+Ok1-Q@mail.gmail.com>
Message-ID: <CAPhsuW72=Mh8v2oYwcftyjescPi06tOt4XZJXebPvnKF+Ok1-Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix RCW bug and allow degraded raid6 do rmw
To:     allenpeng <allenpeng@synology.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jul 31, 2020 at 2:56 AM allenpeng <allenpeng@synology.com> wrote:
>
> From: ChangSyun Peng <allenpeng@synology.com>
>
> This patch fix io stuck in force reconstruct-write degraded raid5
> problem and allow degraded raid6 do rmw.
>
> ChangSyun Peng (2):
>   md/raid5: Fix Force reconstruct-write io stuck in degraded raid5
>   md/raid5: Allow degraded raid6 to do rmw

Thanks for the patches. Applied to md-next.

>
>  drivers/md/raid5.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> --
> 2.7.4
>
