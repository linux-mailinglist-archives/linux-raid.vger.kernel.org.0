Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1442123C51
	for <lists+linux-raid@lfdr.de>; Wed, 18 Dec 2019 02:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfLRBRa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 20:17:30 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46060 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRBRa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 20:17:30 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so140368qkl.12
        for <linux-raid@vger.kernel.org>; Tue, 17 Dec 2019 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vzl/otApMLvBNWefCrSHgy2r8EiPDuURnjpjX4l7gwg=;
        b=NNTe//7vOJPXYugyxCtBvvYpnIUbQC8o+D8K0SvkSo3dTW+yuhC0iMTs6WrzMJWBrN
         qY4QtEn/jyHAoaQC0x/yqwSf/5ZMnfGi3tYdA8N7D3RtbJb8Tgp8kOh3CZFcVpfwgSnC
         vUr4YeNmpmSzG2615GE9C/O7I8C+bIDplD4FyGdHhoT6QX6OF9N0KOIwiSh4w4zeDph1
         Ueoyc9+WjAghscuKy3Uz7A1EJrDgSLcJFrvFVHNmZmynfO1EbJGoXlxGIu280udrVvni
         okz3BBhhl+BwspWsXeA3mA4C7OeOr4o58BhkiwXF745EVmueDaJMpPeJpVKVQ6Q/iK0d
         FhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vzl/otApMLvBNWefCrSHgy2r8EiPDuURnjpjX4l7gwg=;
        b=KtMgDiqo9HYpsjM3ipZYz5z4ljvdOxAyoCiwYgnsadBBUE6GC5xJtflBbYOMOAr995
         ucGJZfMabPW/K71Dwc9y4ASUvq/WiPDrmuE36vnMioHT5XDCotDPIvvA7uN0KirCv+az
         a9zYfmawTe+By/RWSLCAwVxBw+/xMcLJuuQDiVG/231QvazRRweNIq/5zD/tnrqq9mb8
         T9GdfrvCBJkoDfQPL0TdnBKf5/oRcOhRLrqzjGrf0D3EGv9zUEaFtpE41Gw87iBC/H1e
         iCoAui+cgxfeeThHGitlcJe79zZV0Uo2i27FDMYPpFddRoCo3iukLpiELzVfhh3i4esg
         3BlA==
X-Gm-Message-State: APjAAAW0FQ0DIlxGHYCcj9wv1gBeXieyKBtJ9Vb/dpMct+cqhxFhJU7x
        aBXT1FcjWophB6e/AncQMqjh1Oys0jdzJtj0GyphwA==
X-Google-Smtp-Source: APXvYqw9JbD4xm9KRaLeRx0VnCN8dZwLL0OYduveQp1yWaQMf48v2ZtQF1CbZgKDuvuVg/cuhoEhfmK3uHO+VHGAD3U=
X-Received: by 2002:a37:8b85:: with SMTP id n127mr1035988qkd.353.1576631849698;
 Tue, 17 Dec 2019 17:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com> <20191121103728.18919-3-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191121103728.18919-3-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 17 Dec 2019 17:17:18 -0800
Message-ID: <CAPhsuW6aKNVcRQR9Hov2=cO2X8L-qGO9VFPKq7DNA+7M_TMw4A@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] md: prepare for enable raid1 io serialization
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Nov 21, 2019 at 2:37 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> 1. The related resources (spin_lock, list and waitqueue) are needed for
> address raid1 reorder overlap issue too, so add "is_force" parameter to
> funcs (mddev_create/destroy_serial_pool). The parameter is set to true
> if we want to enable or disable raid1 io serialization in later patch.

Looks like is_force is always the same as "rdev == NULL"? Can we remove the
is_force argument and use rdev == NULL instead? I guess it will also simplify
the functions.

Thanks,
Song
