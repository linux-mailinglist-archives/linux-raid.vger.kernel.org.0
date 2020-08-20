Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1C24AC3B
	for <lists+linux-raid@lfdr.de>; Thu, 20 Aug 2020 02:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHTAdP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 19 Aug 2020 20:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgHTAdP (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 19 Aug 2020 20:33:15 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BDB20885;
        Thu, 20 Aug 2020 00:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597883594;
        bh=3l/w2O5akRgsmLKW822D+h7KpzfmQAREhsNut0acb88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LHM0spli8a+Ks91qeosSQyO0SyvYKhlXdCspZS/wFJCdzVOgcEx8tla/8SfEca9Bz
         VxTHyfiTYCFvfqssKNjle+yjC7tHH/iqWtJK44giXpAy4yLUgjWfdVtvDdPp81xBVR
         IgQIOeYDO9pQYIsO2l9IyrIegAS02OmlVX18cFdI=
Received: by mail-lf1-f48.google.com with SMTP id j22so96235lfm.2;
        Wed, 19 Aug 2020 17:33:14 -0700 (PDT)
X-Gm-Message-State: AOAM5310cU+2Pb11I+Uv66kvg08geO2H+FtX7TixmTISiK1HR4xpkEsD
        Hn71Q5wf+Qzxax9UjDA84RWRs8heFzVLsp2FPF8=
X-Google-Smtp-Source: ABdhPJy+Vsx6a462h7J5Pc9ZaLy/3hOyZVBo0ipdYDRMBhPUWjfeRNjF2u+4jPw+BtZoIjYiH87E+lblPzYfrHufAYY=
X-Received: by 2002:ac2:4881:: with SMTP id x1mr311819lfc.162.1597883592706;
 Wed, 19 Aug 2020 17:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200818054206.6612-1-tian.xianting@h3c.com>
In-Reply-To: <20200818054206.6612-1-tian.xianting@h3c.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 19 Aug 2020 17:33:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4gkOOuG899FKromGDL9A2MQve3jdkD_BbgEi+EhiygEA@mail.gmail.com>
Message-ID: <CAPhsuW4gkOOuG899FKromGDL9A2MQve3jdkD_BbgEi+EhiygEA@mail.gmail.com>
Subject: Re: [PATCH] md: only calculate blocksize once and use i_blocksize()
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Aug 17, 2020 at 10:49 PM Xianting Tian <tian.xianting@h3c.com> wrote:
>
> We alreday has the interface i_blocksize(), which can be used
> to get blocksize, so use it.
> Only calculate blocksize once and use it within read_page().
>
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>

Thanks for the patch. Applied to md-next.
