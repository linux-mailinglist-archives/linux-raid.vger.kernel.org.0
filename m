Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3A1BF090
	for <lists+linux-raid@lfdr.de>; Thu, 30 Apr 2020 08:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgD3Gtx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 Apr 2020 02:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgD3Gtx (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 Apr 2020 02:49:53 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BAA321BE5
        for <linux-raid@vger.kernel.org>; Thu, 30 Apr 2020 06:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588229392;
        bh=lQIZzdF6gz/8iIQZ48kIYq70hK/vXARpNU3XHf9f4lc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ec+3u6Hboladpe0nwNMt39ECnR4K6yGyeCdzGRcq8fe7wR+owy5UP5fQSlAPNrQdV
         Qe1CmdKGGlnvLmNsO4l4O2UQfKO0HfYidWWQ7AZCaAywi9zYTVvTtFhmBvR5EToP7M
         JmeZaHxxpDCMYUoMP/cODV+IOVeCGwzbB+AusJo8=
Received: by mail-lj1-f175.google.com with SMTP id u6so5244330ljl.6
        for <linux-raid@vger.kernel.org>; Wed, 29 Apr 2020 23:49:52 -0700 (PDT)
X-Gm-Message-State: AGi0PuYFpqK4OScS2d2nsOmgMuS6IkCQzmJ8fTGiE6/u668MNGvDHCf9
        5oRCaZEt0XSHaWCzbtfNBW0B1HzUzSfTdN7YSjE=
X-Google-Smtp-Source: APiQypKt7jD1Aww2OwbaPVmbVW67REXj/fLwOjF1Vz9Fr8kxniv49cqJPynMw802gJs5RXag+IJ38ydiRhB5/V3kduQ=
X-Received: by 2002:a2e:9258:: with SMTP id v24mr1204259ljg.109.1588229390610;
 Wed, 29 Apr 2020 23:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200409115258.19330-1-colyli@suse.de>
In-Reply-To: <20200409115258.19330-1-colyli@suse.de>
From:   Song Liu <song@kernel.org>
Date:   Wed, 29 Apr 2020 23:49:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5EBYxNu2fqDO_jPbSuiGyUF5qgUCSLJYPAr2b6VPSytQ@mail.gmail.com>
Message-ID: <CAPhsuW5EBYxNu2fqDO_jPbSuiGyUF5qgUCSLJYPAr2b6VPSytQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] improve memalloc scope APIs usage
To:     Coly Li <colyli@suse.de>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>, mhocko@suse.com,
        kent.overstreet@gmail.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Apr 9, 2020 at 4:53 AM <colyli@suse.de> wrote:
>
> From: Coly Li <colyli@suse.de>
>
> Hi folks,
>
> The motivation of this series is to fix the incorrect GFP_NOIO flag
> usage in drivers/md/raid5.c:resize_chunks(). I take the suggestion
> from Michal Hocko to use memalloc scope APIs in unified entry point
> mddev_suspend()/mddev_resume(). Also I get rid of the incorect GFP_NOIO
> usage for scribble_alloc(), and remove redundant memalloc scope APIs
> usage in mddev_create_serial_pool(), also as Song Liu suggested, update
> the code comments on the header of scribble_alloc().
>
> Thank you in advance for the review and comments.
>
> Coly Li

Applied to md-next. Thanks for the fix. And Thanks Michal and Guoqing
for great inputs.

Song
