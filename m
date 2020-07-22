Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474D8228F7D
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 07:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGVFBZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 01:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVFBY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 01:01:24 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DFF6207BB
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 05:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595394084;
        bh=KX3LnosIXa4aH56+Ji6xI5oj37lG64WkTEgSwSQGusw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rh7J+B6wEOi+6B4QLFg//vroFQx225lg/amrwt73/0HVlMp9q+miPhUDOe7n7W0Mq
         dEaR3RvFoVBSkOucG3pYITJuV9wEbyNTtG3Fovn1WWYwBdopHhiFxvEybChVhYrxCY
         uXRMZ3CBYAB6D/bYbaDCdje6cfQ6iaSHAozJa4fo=
Received: by mail-lj1-f181.google.com with SMTP id s9so1040885ljm.11
        for <linux-raid@vger.kernel.org>; Tue, 21 Jul 2020 22:01:23 -0700 (PDT)
X-Gm-Message-State: AOAM530gX+gN6N1vvGlFKyW4IdyTPq3w32ucqgoqrHECf9YA6LHwBALj
        EsAyqnq0jFHgePNEctLJ/V2rJvHZl5m/SIc2Zwc=
X-Google-Smtp-Source: ABdhPJza29jXsVKl8KRCiAMuRUVf7NEvMUJulFqwiyo2FFoE7p7VkhzpBP+9X8jTq58ocq4GmTExTdf8hxDp8DE4o8Y=
X-Received: by 2002:a2e:3003:: with SMTP id w3mr4006723ljw.273.1595394082434;
 Tue, 21 Jul 2020 22:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <1595268533-7040-1-git-send-email-heming.zhao@suse.com>
In-Reply-To: <1595268533-7040-1-git-send-email-heming.zhao@suse.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 21 Jul 2020 22:01:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4SH-XwJwJj9Z=E0Ym-om2+LJD54Uk=xxmcn7McDMJsKg@mail.gmail.com>
Message-ID: <CAPhsuW4SH-XwJwJj9Z=E0Ym-om2+LJD54Uk=xxmcn7McDMJsKg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] md_cluster: bugs fix
To:     Zhao Heming <heming.zhao@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jul 20, 2020 at 11:09 AM Zhao Heming <heming.zhao@suse.com> wrote:
>
> v5:
> - change safemode_delay patch code by neil's comments.
> - modify safemode_delay patch comments:
>   - remove useless analysis
>   - limit line in 75 chars
> - add neil's reviewd info in rmmod patch.

Applied to md-next. Thanks!

Song
