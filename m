Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01FD399B11
	for <lists+linux-raid@lfdr.de>; Thu,  3 Jun 2021 08:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFCG4h (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Jun 2021 02:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFCG4h (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 3 Jun 2021 02:56:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69FFC613EE
        for <linux-raid@vger.kernel.org>; Thu,  3 Jun 2021 06:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622703293;
        bh=sTg+6FF5WZkydKldWWuRlbSbpeiuSa7aYiB4rqHU62g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gn33l0EusXqSrUgjBGM+V5NmWMsserP2ardPVVFVZqVian/KQvKsuddklRv/LjxHO
         uav6sgI4cmD4sBs2UfrrNL+WpFAYMGwL0EuzGa7PBQarpAjm48enpwBu9EiAlo+Uce
         b/FVYpC/ZynLtbKpELHV9Bm6P7Lr/0TFtfm+hwhHq7SahJUMFsJXfGrexwC/RyAOCA
         5ZxKIwApIpbZTNuP4xfClmsqeqZG1ZrGPXA12xADC2VZmcWqiGW4A/464Y2SeM7VAv
         F2oHOsesB1n58dhgRA00nDVzy8ada0rzsdYUylsANI2p8hWqFQB5jQZaWwD5DLMrG1
         K35cOGGTF6fFw==
Received: by mail-lj1-f179.google.com with SMTP id o8so5847493ljp.0
        for <linux-raid@vger.kernel.org>; Wed, 02 Jun 2021 23:54:53 -0700 (PDT)
X-Gm-Message-State: AOAM530TaSaHu2xGN+C2CP9TplWZNnPK3r+tCrQA3nbUpg6MdSDpspY7
        S1fWiq2oEk6+9nlZC3v+VLov+/uqitHE7mM/6j8=
X-Google-Smtp-Source: ABdhPJzdKcpKsjzbX5iDn1/rdZHc7jhXXsucreA2InY/n8z321KUierRsNk5rAaw9u7gB8aE5G34z4TknaYAB+1mkZY=
X-Received: by 2002:a2e:2243:: with SMTP id i64mr4675185lji.344.1622703291799;
 Wed, 02 Jun 2021 23:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210525094623.763195-1-jiangguoqing@kylinos.cn>
 <20210601011946.1299847-1-jiangguoqing@kylinos.cn> <be04b7a2-d963-f83d-61d1-a1216097fe26@gmail.com>
In-Reply-To: <be04b7a2-d963-f83d-61d1-a1216097fe26@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 2 Jun 2021 23:54:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4uue=XtAE_tNHUHYbngq7n0pCC4MhpoEX6JRpqFk6mWw@mail.gmail.com>
Message-ID: <CAPhsuW4uue=XtAE_tNHUHYbngq7n0pCC4MhpoEX6JRpqFk6mWw@mail.gmail.com>
Subject: Re: [Update PATCH V3 2/8] md: add io accounting for raid0 and raid5
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jun 2, 2021 at 6:17 PM Guoqing Jiang <jgq516@gmail.com> wrote:
>
>
>
> On 6/1/21 9:19 AM, Guoqing Jiang wrote:
> > From: Guoqing Jiang <jgq516@gmail.com>
> >
> > We introduce a new bioset (io_acct_set) for raid0 and raid5 since they
> > don't own clone infrastructure to accounting io. And the bioset is added
> > to mddev instead of to raid0 and raid5 layer, because with this way, we
> > can put common functions to md.h and reuse them in raid0 and raid5.
> >
> > Also struct md_io_acct is added accordingly which includes io start_time,
> > the origin bio and cloned bio. Then we can call bio_{start,end}_io_acct
> > to get related io status.
> >
> > Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> > Hi Song,
> >
> > Please consider apply the updated patch which has minor changes based on
> > Christoph's comment.
> >
> > 1. don't create io_acct_set for raid1 and raid10.
> > 2. update comment for md_account_bio.
>
> Pls ignore this given it didn't check all the places before io_acct_set.
> Do you want an incremental patch against for-next branch or a fresh
> one to replace current patch in the tree?

Hi Guoqing,

Thanks for the hard work on this. Please send a fix patch on top of current
md-next.

Song
