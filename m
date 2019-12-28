Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E740B12BECA
	for <lists+linux-raid@lfdr.de>; Sat, 28 Dec 2019 21:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfL1UFN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 28 Dec 2019 15:05:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfL1UFN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 28 Dec 2019 15:05:13 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164F9208C4
        for <linux-raid@vger.kernel.org>; Sat, 28 Dec 2019 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577563513;
        bh=FHWvG+TTmva5BuY5n8iy94DFRjUINEXVCPYlt+r7yN0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X2mMgXXoxfFBLGjpjVrZJ93zzSFeske8DkiDgLeEYExvA+QGKiiNSdpmvrOAg3c3D
         S9EwtCsjmoZnGCdAo3DkU1mpnxSUaYMJVEyacFTBRELJ+n9YqdpQdI77U99A+GH+OF
         TdstDkMUZ6SHuTW4ungqpW0fJ2imYq0BN4x0TfHo=
Received: by mail-qk1-f177.google.com with SMTP id z76so24190183qka.2
        for <linux-raid@vger.kernel.org>; Sat, 28 Dec 2019 12:05:13 -0800 (PST)
X-Gm-Message-State: APjAAAWZYA/TdyK2jgimtoPspSfEpwiK3cHuc/0ROueBKBgnWPvZk6Tx
        Jg/Nf4izLZRykFET73kHbQaqScB74/3DZ9TpzKw=
X-Google-Smtp-Source: APXvYqx1wHA8dC7xKqHVtV6rtfr4NLvznrLdy1ACwmBNJ7afWU1NeGgGj+R2sls5RJqwP/gIKv8Re2DzcbFFV0S4/sM=
X-Received: by 2002:ae9:e103:: with SMTP id g3mr42466893qkm.353.1577563512227;
 Sat, 28 Dec 2019 12:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20191219172318.GA4028@avx2>
In-Reply-To: <20191219172318.GA4028@avx2>
From:   Song Liu <song@kernel.org>
Date:   Sat, 28 Dec 2019 12:05:01 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5HYfZgi0XZYnK0aSTxgOk5=uLkieKme_n6fMd=458L_Q@mail.gmail.com>
Message-ID: <CAPhsuW5HYfZgi0XZYnK0aSTxgOk5=uLkieKme_n6fMd=458L_Q@mail.gmail.com>
Subject: Re: [PATCH] md: delete unused struct md_thread::private
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Dec 19, 2019 at 9:23 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

This patch is straightforward, but please still include a brief commit log.

Thanks,
Song
