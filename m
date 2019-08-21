Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5D898206
	for <lists+linux-raid@lfdr.de>; Wed, 21 Aug 2019 19:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfHUR6N (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Aug 2019 13:58:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39709 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfHUR6M (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 21 Aug 2019 13:58:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so4117993qtu.6
        for <linux-raid@vger.kernel.org>; Wed, 21 Aug 2019 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z09c3yHGYouaWmD7DjP1NR9m4akIcxuzDL7mrJsBShA=;
        b=gzm8MLs4dtDAoXRE1IjWZEge8ngNeneliZL2YVq557aZeQcQ3w7ZaABfvP/r2LJm7i
         meshqohXzVYGMNOE+89PIWeMRwZ9TN1oj/Fh8fcvA0RFH7qkM3XFNtgIncF2pz+B7Rkn
         kpMP+52hJi4raZ17FJBKojVA97bU/BGdFQAERCZOQRhTBImJMUhuPG9ygI/oIVAhaWBY
         lyL6wEEM4nf0WFmzpSShFZ3SjmhJGkZfGeKX2Ehq5Uwfkkv7TCpgoes2qFSWB0ZMiJR6
         TYxMwbp7xo0AjAPIu8KOVa/sSBeGwK0ZFYE9J1Z1/elsBwTe+o1XZGhzJ+712MptwW+n
         TDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z09c3yHGYouaWmD7DjP1NR9m4akIcxuzDL7mrJsBShA=;
        b=bbpRXYlmcPVEg6eYy66mNgPAOIQJKFw5DnGWgQifCto1YTua6Aka3gGKi3XsY54ijD
         c5wAOF/kuxXtl3v7Olld0TahhrWAdD0YarVYR8D4n3mvRupP2D7oWar/q0DOZQukFstZ
         hgmEJG49xgmShm0DeTZnv12dcTB9JOPK+z5PRIdGne4csrJjW8xTSb7MPvUtLyh7L/BL
         A1eZFhYOqVYXjMtLKfEGSAvq6MB4q0Kp8dwwx10sQzhlGm5j4jZdMJocta4UCqXKPOzH
         cuPjVxuPVbOqgELZW9W2aMc42yBCb13+W6du9xTEheKQVq3r01RPV3Suf/fobRP00itt
         VQtg==
X-Gm-Message-State: APjAAAV2eutaWW3ifkI85lg0mnCef4kuwhLM3SaiRvEF34s5fsiTvSMW
        +mget5zL+jNQHr2GhGyRRz9HbDfsUbK69Fx2ckI=
X-Google-Smtp-Source: APXvYqz9KznGI5eyz45qzbaQQjGDdqq/HWq7c04rX91yWp0E5/hmE5jcp4UnDsyaDuN6MehdQVfZvr3vrW6Hl0lkDYY=
X-Received: by 2002:ac8:3258:: with SMTP id y24mr32209522qta.183.1566410291404;
 Wed, 21 Aug 2019 10:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190821132708.31378-1-ncroxon@redhat.com>
In-Reply-To: <20190821132708.31378-1-ncroxon@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 21 Aug 2019 10:58:00 -0700
Message-ID: <CAPhsuW6231Eh=bJRA7jJHnJOP=eFh7thOcNuEJX8_xN37PetvQ@mail.gmail.com>
Subject: Re: [PATCH] raid5 improve too many read errors msg by adding limits
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Heinz Mauelshagen <heinzm@redhat.com>, Xiao Ni <xni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Aug 21, 2019 at 6:27 AM Nigel Croxon <ncroxon@redhat.com> wrote:
>
> Often limits can be changed by admin. When discussing such things
> it helps if you can provide "self-sustained" facts. Also
> sometimes the admin thinks he changed a limit, but it did not
> take effect for some reason or he changed the wrong thing.
>
> V3: Only pr_warn when Faulty is 0.
> V2: Add read_errors value to pr_warn.
>
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>

Applied. Thanks!
Song
