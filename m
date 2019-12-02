Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B633A10EE06
	for <lists+linux-raid@lfdr.de>; Mon,  2 Dec 2019 18:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfLBRSZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Dec 2019 12:18:25 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45114 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLBRSZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Dec 2019 12:18:25 -0500
Received: by mail-qv1-f65.google.com with SMTP id c2so103555qvp.12
        for <linux-raid@vger.kernel.org>; Mon, 02 Dec 2019 09:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGzR27wy69+EjWxN2zfLzVCHQ96cZFbdpeYytzEQVvE=;
        b=IXDxd9xbIVRJU9rVe3wAJw1bitM6x+vgQZMiSt8CdBrQZ8wGusvMifn3npedCKG5Kk
         Jw+AjGRgLnYA8oFGzrrRaebGFdUc9+OkZwZp+CnCKY8DBxX2G1aTezc5tc3UizQw4eA1
         LCUm2biK6gtaT2MHjBZGJP867xX8b9a8x+hpcxKngwKjybE/GWYmDLRoXavq3ZNlTMk8
         82U0GLuIsEJgaC1Bp0RZCYb8/XVuaWG/rEAejWxt89Y4e5qIgtdnmhXrfSoy/y1HWq84
         RXWundAeKcse1wLJqlgqZGgpgJMsNFGCKG7cc64FKcZZJck54aXeCyUlksBoIt9ywX3q
         vcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGzR27wy69+EjWxN2zfLzVCHQ96cZFbdpeYytzEQVvE=;
        b=rYk+K7Xn2+MeSsvio2K5K/zY1zirzqQpx2inNu1WoNmPgrdUY+2A3EBBFP9zSwSLne
         tmM3DO2Q5d5tXCB6lwB3N8p0h2e7qNYv1XFqy7pEaiB3cpSC42l+G3RxCpSGTQaPfsiR
         Q2OXNIYZIGj+BKmGZL4NRO9nb8OIgH60in/OIIX0drqYkc7rSZIrtfp1V/TLLAkT/Eoi
         Xe0ZmyROENC3oMJ7OlGS7Y6h6d0CbkpO2LCtpXIaMV3URMiDGIO1/i6JzAvj83KIaOY8
         VKX/HvbKLVQfNRBVRfiQ2wVmJDP1ADK9tt+e+umK4VBj1vt1WqQFkt1R0PiS+IvSnzVu
         rLjQ==
X-Gm-Message-State: APjAAAWOPU86AbDQmTj4x0/W0qq4gvelSJ2wKDIgXrRNac2T0WidP5ia
        tvJdWkFoawUBm7h29F+rmI8AFrhVXjNYz4gcj/4=
X-Google-Smtp-Source: APXvYqyyS9sZ+SxGV0ZlmLsuaCimipGJ6ZFaJCrw6gAyT1uYVfe+ADSWtdzQkAhOs5VKum/Z075N+vAiQvHnzHfYlFs=
X-Received: by 2002:ad4:580b:: with SMTP id dd11mr33594889qvb.242.1575307104569;
 Mon, 02 Dec 2019 09:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20191127165750.21317-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191127165750.21317-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 2 Dec 2019 09:18:11 -0800
Message-ID: <CAPhsuW59uJ6dyVJOQ5t67peAdQNn9_gqVgEnbfTuLiVbODsuvg@mail.gmail.com>
Subject: Re: [PATCH] raid5: need to set STRIPE_HANDLE for batch head
To:     Guoqing Jiang <jgq516@gmail.com>, Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks for the fix!

On Wed, Nov 27, 2019 at 8:58 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> With commit 6ce220dd2f8ea71d6afc29b9a7524c12e39f374a ("raid5: don't set

In the future, please keep only 12 bytes of the commit hash. I will
fix it this time.

> STRIPE_HANDLE to stripe which is in batch list"), we don't want to set
> STRIPE_HANDLE flag for sh which is already in batch list.
>
> However, the stripe which is the head of batch list should set this flag,
> otherwise panic could happen inside init_stripe at BUG_ON(sh->batch_head),
> it is reproducible with raid5 on top of nvdimm devices per Xiao oberserved.
>
> Thanks for Xiao's effort to verify the change.

Xiao, please reply with your "Tested-by".

Thanks,
Song
