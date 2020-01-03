Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6818712FD13
	for <lists+linux-raid@lfdr.de>; Fri,  3 Jan 2020 20:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgACTeP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Jan 2020 14:34:15 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37894 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgACTeP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Jan 2020 14:34:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so34629719qki.5
        for <linux-raid@vger.kernel.org>; Fri, 03 Jan 2020 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXD8W1U4BDZ7W2tnWZzBTN95uH1icP+PAns5//u6S8o=;
        b=tkhNk3nyIAqT62S6Lf8bRN5uDFcPUEado+5bD1EymJpNR+dwg+bwCLu7+bFxdcxJBZ
         Z7PFynjEUIvFF2zO0qqb90f8pAA7X3dRzhdkppSogh/5cccTjEFf1bdYvVyCnRYP3fND
         CDuOmhP3vUC8yPihHrPLQPboDkwQhLO+EdcFFx/l6C0rML9iYbjlsQOXglwIDNU60b9K
         9FE2Oq7V08TDYimVsjKZPU9Sm+W0/s+2dkdCwsgnMYVnJfKAelPpDn3x8t3mUNY+4F5k
         UbXpRCsD3EvOsyYrAwZ3aBUy2WGpPuRw6VlLlq22Cul090n2LmEtBZd+4JsjVkBHqqt1
         LT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXD8W1U4BDZ7W2tnWZzBTN95uH1icP+PAns5//u6S8o=;
        b=knaAxON1DrbwPtp2aj/FrnugrSR41BvbYkvcFLzXZstcl/uor5mfdyUGVuVGqM1mZ5
         ithwSuzdUGUXSYQi8ueWW7makl1Pg+HYaeZCqhTETg/V/BOeWa6+3ErNCovG0ebsvBG8
         c+qKZKgwCXjHC253NadUgi8qmXtYD+Cy+gMTvmD5pKnD1vjy0ABHWK3VAvGmbOdi/8Pe
         X4pJq9YRwjr2GBRSoCNJBFUZ2lvTYGBXR22thoRPxqXO8oDpXsAFadZtY4BcglXyYmqb
         A4Pyt8ceJFyPHnMOYVTBO6CbmHyPDbdVxi0asi2zNmB6MtTyF6ccHdRbIpsJeS121FWI
         XeTw==
X-Gm-Message-State: APjAAAX7Cvm4Am+e+68cwOtUO9zZEX1UB0q36VcuNoIxcIFHAr8ol5Pw
        fJg5+ZDZTbmMDB9SoKSNeAMZIaIEBolS1+j93jG4fg==
X-Google-Smtp-Source: APXvYqxipRNL+OrkUmu+QkwKhwPRMWeHEQPgjNGzFwXXPCgtjnJjKwBD1noXJ7WUT+25qfNOl5BTIEoUxEVo6yCjU9g=
X-Received: by 2002:ae9:e103:: with SMTP id g3mr67033453qkm.353.1578080054214;
 Fri, 03 Jan 2020 11:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20191220144629.11054-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191220144629.11054-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 3 Jan 2020 11:34:03 -0800
Message-ID: <CAPhsuW4ExiB4ExOmxFOkxSwRUcc+8CnN+MVhF_dtzhJuSmJXkg@mail.gmail.com>
Subject: Re: [PATCH] raid5: remove worker_cnt_per_group argument from alloc_thread_groups
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Dec 20, 2019 at 6:47 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> We can use "cnt" directly to update conf->worker_cnt_per_group
> if alloc_thread_groups returns 0.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Applied to md-next. Thanks for the clean up!

Song
