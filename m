Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDBED6C5F
	for <lists+linux-raid@lfdr.de>; Tue, 15 Oct 2019 02:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfJOAGt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 14 Oct 2019 20:06:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36543 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfJOAGs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 14 Oct 2019 20:06:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so17566358qkc.3
        for <linux-raid@vger.kernel.org>; Mon, 14 Oct 2019 17:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smotI4xETmXp5rQVYd1OFXjaRAoweMXOdsU1vpG8dsc=;
        b=LbO+msOb/4ucytccy7DVI5apkRY/rmqFI+LWDDlkGQslHL4eVF1XbRuYMayGpPc8Kj
         uW9+8ZyaO57LTOaChVEe5vpVvE1yNGm15y4kXMBylcqf+eYtPJfxmjo2cPgiWNsbHJn/
         U2n/OcSln5ZczrR13cFU+or7FVGCRWAKjuFPhDbpuOcKjSVvDDAjVhN1quDsqruoOKzR
         XoaU/vAMBkcbyCB3TGHhRQTysUZ/FO8ORZqWYFesnmQ+02GJDqnJON9j22JwZMddOhex
         +++AYG+ENkltAB3pe081dnHrx4d8RUurdDoJsrYk7iI5I9EE576/R8c+63Qg2mLfMYs7
         yo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smotI4xETmXp5rQVYd1OFXjaRAoweMXOdsU1vpG8dsc=;
        b=KV32EMZKv84MJ0znSB6UjvKAkulftsEdd/zjSHn5sC7aLIZtk1ing4F3SL4TCrcju7
         wbxk+dtXtPCg0+MeGn+yeTBnzCkl/m5MTpXtugR/WJ69Uu1aW9NXMW9XKrUb3wXhdhmz
         WrzTk2CLFl8ZteIC3NMVuzSsKT2LMuf/rXU7Gob/gKr0XrC8qOzvT5YLyjNEBh595Hjf
         MzlWuY2uCl5KH/F/c0vPrjyx8IZ/WZ7hk2gcUeHcpBkej8aKsxe5E05VP4dkFQV0Figc
         dqOrMWb910A0KI1AMBMH8rC+ub2r1sQSdSlr1XFlXDPQW+J20fK4ZVjOIyKPsQ4LwKLm
         7dLw==
X-Gm-Message-State: APjAAAX11ulAHi0To2mENLmzLQOnOqvA2Hc3VJ7GZsWY2PhPYBv9fu4S
        1tbmR7iVgDXJmKQVw2+yIZGRaf7Gt/z2ochBGYQ=
X-Google-Smtp-Source: APXvYqyKzqJTd2l2eTwovyHPeAXJD9FYf24V8y1kqvLp3gCIbjUH50om5WabxEGFPiFBPCr19PKfJJeF9m0/uyINhYo=
X-Received: by 2002:a37:553:: with SMTP id 80mr33040912qkf.353.1571098007888;
 Mon, 14 Oct 2019 17:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <b9b8f42f-cc55-b165-2430-f0c9731002d1@gmail.com> <CAPhsuW5WiJ9+bKi7Sfra36gCBXF2=38eBu7O_xYL9NYhgn0WbA@mail.gmail.com>
In-Reply-To: <CAPhsuW5WiJ9+bKi7Sfra36gCBXF2=38eBu7O_xYL9NYhgn0WbA@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 14 Oct 2019 17:06:35 -0700
Message-ID: <CAPhsuW4V6_jV3w+oY+03Vhd9kgyLY773FWmJ=1dqmPHTpkHW4Q@mail.gmail.com>
Subject: Re: md/raid0: avoid RAID0 data corruption due to layout confusion. ?
To:     DrYak <doktor.yak@gmail.com>, NeilBrown <neilb@suse.de>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Oct 14, 2019 at 9:30 AM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Mon, Oct 14, 2019 at 2:23 AM DrYak <doktor.yak@gmail.com> wrote:
> >
> > Hello,
> >
> > I just wanted to point a small thing:
> >
> > On 2019-10-12 01:37, Song Liu wrote:
> > >
> > > David, you may consider adding "raid0.default_layout=?" to your kernel
> > > command line options.
> > >
> > > Song
> >
> > Currently there is a slight mis-match in the actual kernel module:
> > the warning message display "raid.default_layout=?" (missing zero)
> > instead of "raid0..." (how indeed it should be used).
>
> Good catch! The warning should say raid0. Let me fix it.
>

I am about to push the following patch.

Is your official name DrYak?

@Neil, could you please review this change?

Thanks,
Song

====================================================

From ab2b8af0b8ebafe57d66f440acdf9dc9d6190556 Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Mon, 14 Oct 2019 16:58:35 -0700
Subject: [PATCH] md/raid0: fix warning message for parameter default_layout

The message should match the parameter, i.e. raid0.default_layout.

Cc: NeilBrown <neilb@suse.de>
Reported-by: DrYak <doktor.yak@gmail.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/raid0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f61693e59684..1e772287b1c8 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -154,7 +154,7 @@ static int create_strip_zones(struct mddev *mddev,
struct r0conf **private_conf)
        } else {
                pr_err("md/raid0:%s: cannot assemble multi-zone RAID0
with default_layout setting\n",
                       mdname(mddev));
-               pr_err("md/raid0: please set raid.default_layout to 1 or 2\n");
+               pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
                err = -ENOTSUPP;
                goto abort;
        }
--
2.17.1
