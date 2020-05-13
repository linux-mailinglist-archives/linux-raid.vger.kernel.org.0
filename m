Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD711D1E89
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 21:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbgEMTHR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 15:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbgEMTHR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 13 May 2020 15:07:17 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20DB12054F;
        Wed, 13 May 2020 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589396837;
        bh=6ic+6n1wGdR4/pvLTH/MP65+OfXLiPfd9XYBKnzj5LE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EBccvFjgyFZKOaGw8K7zRaf94Y0GYjmBm3DVxnG/mr99sytI1GEXGGKNw4h1testq
         YAXlpbUlELnBw+zbEXKgNTYCv0DWPQ++h5wrBnqJCFQZKmFrf1MHkGFqn6URrD1VCb
         X8sLenn4g31EV+qEfTegBWcSzb8rseKCo48bNsoc=
Received: by mail-lj1-f172.google.com with SMTP id g4so830654ljl.2;
        Wed, 13 May 2020 12:07:16 -0700 (PDT)
X-Gm-Message-State: AOAM530Q2aiSgi1JMAXi6o0n/3IsLjfLZE3GLQigXM2lVMT2Ana1ItaB
        EocEJMtZ+cY7uZqvcBo+I07hPc7Y/MMRWL2TmXE=
X-Google-Smtp-Source: ABdhPJwhjKXZi/3px+fkVHMw+xlVjv1OBZRwcd2CD1ekChseDXAGim42sSfrsnEAiUSt7Io9FYoYMR4DfNKC8IhTYnw=
X-Received: by 2002:a05:651c:1025:: with SMTP id w5mr331990ljm.113.1589396834316;
 Wed, 13 May 2020 12:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200507192209.GA16290@embeddedor>
In-Reply-To: <20200507192209.GA16290@embeddedor>
From:   Song Liu <song@kernel.org>
Date:   Wed, 13 May 2020 12:07:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5auRH2K5YyxGL6P4sy7hugF1N2s3AVj7GYOj_9EWKmFA@mail.gmail.com>
Message-ID: <CAPhsuW5auRH2K5YyxGL6P4sy7hugF1N2s3AVj7GYOj_9EWKmFA@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, May 7, 2020 at 12:17 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>

[...]

>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to md-next. Thanks!
