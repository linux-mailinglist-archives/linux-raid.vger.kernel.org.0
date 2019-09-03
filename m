Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF28A76AE
	for <lists+linux-raid@lfdr.de>; Wed,  4 Sep 2019 00:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfICWG3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 18:06:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32974 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfICWG2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 18:06:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so7521475qkb.0
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuuEw7ikF1y87jlTvk3YbH5lszYMAzlRGsxbh8QCL5g=;
        b=EmHN+WN7CM4UHq1zFuH8ZzeLg4oY0RbEPDzfzcmj2/3ACbmfZfnGz3HAv5o6VNQNEG
         ZBA+WBFPaIjxKK85z1aX21TkufBolCiV27zQ/wJ8Zgyk2EA5x5FtNHZI3FwjDJroz4Er
         YUYLMtSXGZyChS2V7rgffs8omt7Di/bomCClh1zRTx6tM7GkrmklOAgK59Hv2Gihjtk1
         xQ0HbHMwVqdq7qQ8N+rDx+DjvTX5+YGzLNSnq3w1RPPzEDEYGMdipaTDRc4gAEHPaJfw
         18XWWzG5GAo3CdQbCwq2iwHAzW+UfFWPhZ2Yhdg2BeDyvbYwHgzgIJLsyFFXxak+PuOQ
         YoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuuEw7ikF1y87jlTvk3YbH5lszYMAzlRGsxbh8QCL5g=;
        b=JjDVdcaIza4C0nt2tctbnJlbMH3+4fz1iA2o4pGNyZE/RgaE3rIdlQQNJOOy/ifpFx
         rDTSEI0swynxewIOVWs+c+Re75sX6D68TeT/0IVdpSLzvW7VRDX2JjWF6RLNY0esE5P2
         T/ENlc43Gf4ovJ7DZ1yDvxrCcqL1nZX3uhE9Yw2QJUpJmaCm9t6bjYSm4QdPhOjLjNJa
         3fW4LvrvhN7g1czQEA8mWTdcZWgv8KkfCKsqhriqvfS3VG3/lChrr9hiO0gyIQwyrY9L
         RsM4XHF/15jg3k5JTcTaQguj1tLintaJFBFNYznByZq09tWalDdHVIfkGiTY9X765hU0
         zF9Q==
X-Gm-Message-State: APjAAAXcFKP/QpauSKzS/KahYCJ/D0FjDu9B8D41OZ/0kAljCa8usUL3
        KC+7fTykrEend9FfpDHFss+NAvQqG+Rgp4xPRPY=
X-Google-Smtp-Source: APXvYqyZyfmDGtEDj0WITVVb+9k+O52aYk78xpVI79A/FdCanNh/h7QNKHtvS0RL/AgE52N/YQJodTyMD3JwDUkEwBk=
X-Received: by 2002:a05:620a:1391:: with SMTP id k17mr36906246qki.437.1567548387953;
 Tue, 03 Sep 2019 15:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190903094103.25151-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20190903094103.25151-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 3 Sep 2019 15:06:17 -0700
Message-ID: <CAPhsuW4Q+fgGdkHVBqCG6s4JF0JvyZD0SiW2w49WaJ3RJM5g1Q@mail.gmail.com>
Subject: Re: [PATCH] md/raid5: use bio_end_sector to calculate last_sector
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Sep 3, 2019 at 2:41 AM Guoqing Jiang <jgq516@gmail.com> wrote:
>
> Use the common way to get last_sector.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Applied. Thanks!
