Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5096226DC0
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 20:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgGTSGP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jul 2020 14:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgGTSGO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 Jul 2020 14:06:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C798DC061794
        for <linux-raid@vger.kernel.org>; Mon, 20 Jul 2020 11:06:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so21225076ljm.11
        for <linux-raid@vger.kernel.org>; Mon, 20 Jul 2020 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uI8ot/2J0X8mcn9Zfp2J49mB1lp08I2jN3wbAeSC/Pw=;
        b=Cz61HqTwOZ6IEwVnpU+vIjJ2UVZP/Mu4fKA2ydp8JL2VDpMC+nUU4axsRhH+TxIuMT
         7h9Jetot2Q2oMe1da303RP61HjMA+kS64YBC7m4CKaPJ6ZkKqgFan1xJh394/xLoayCV
         YJQKJ0gYeeODtQeM9+onNI6euuT5xsMXV1y1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uI8ot/2J0X8mcn9Zfp2J49mB1lp08I2jN3wbAeSC/Pw=;
        b=EE3Eu2ZT7ZCn7sx6u1uAkRscOHH6zQonA83Owvg8L2rZpCCiMneQpTSUp4EbsbMP+z
         VQfDSd+6QK1+k/aYwFvPuUP6Xcfe5DHJs8x85k/U2uqlT5DgL3cUFkiE3J/PxMTdODYk
         ehakXHi0KveybnzYHouliTJpj3LuD7X1OswG+x0xTtmIYF/ixVtnzz5GoILfn/JZO7+P
         CGyZ5IPUiIbUj7bk+U7DZ4MKT/2ZaxMzCWmXLYM0rhC2YIwNn3zQKlNUavzW0nT3aYRB
         uRfDVGwts6dxrK6orXQawf80J6onRbsI43FzAS1WD11H3wauMfShEtadXZ5LucuYzNQJ
         wmUg==
X-Gm-Message-State: AOAM531TGaQ8yoyzC7N33FYpIALK7SZ69nR9PfwH0U5+Mu/TvO68ZNR/
        Vtpr3wXbNtHuetvN31B00d3bU/VfMCM=
X-Google-Smtp-Source: ABdhPJzE8KEUR7ljXc5C3UeVUfI+TUQUCF2IDvsZUhwrGYFBnKS+WbCkhv4kBSNvNsn731t1MmwKGQ==
X-Received: by 2002:a2e:9dc6:: with SMTP id x6mr10196452ljj.94.1595268369014;
        Mon, 20 Jul 2020 11:06:09 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id j144sm3780049lfj.54.2020.07.20.11.06.07
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 11:06:07 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id k17so10229600lfg.3
        for <linux-raid@vger.kernel.org>; Mon, 20 Jul 2020 11:06:07 -0700 (PDT)
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr2412004lfr.142.1595268366796;
 Mon, 20 Jul 2020 11:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200720155902.181712-1-hch@lst.de> <20200720155902.181712-5-hch@lst.de>
In-Reply-To: <20200720155902.181712-5-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jul 2020 11:05:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimKMPiGP6n_HQUJ1rQ_6cT6hZH5rjQa_nfAgjB1mug+A@mail.gmail.com>
Message-ID: <CAHk-=wimKMPiGP6n_HQUJ1rQ_6cT6hZH5rjQa_nfAgjB1mug+A@mail.gmail.com>
Subject: Re: [PATCH 04/24] fs: move the putname from filename_create to the callers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jul 20, 2020 at 8:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This allows reusing the struct filename for retries, and will also allow
> pushing the getname up the stack for a few places to allower for better
> handling of kernel space filenames.

I find this _very_ confusing.

Now the rule is that filename_create() does the putname() if it fails,
but not if it succeeds.

That's just all kinds of messed up.

It was already slightly confusing how "getname()" was paired with
"putname()", and how you didn't need to check for errors, but at least
it was easy to explain: "filename_create() will  check errors and use
the name we got".

That slightly confusing calling convention made the code much more
compact, and nobody involved needed to do error checks on the name
etc.

Now that "slightly confusing" convention has gone from "slightly" to
"outright", and the whole advantage of the interface has completely
gone away, because now you not only need to do the putname() in the
caller, you need to do it _conditionally_.

So please don't do this.

The other patches also all make it *really* hard to follow when
putname() is done - because depending on the context, you have to do
it when returning an error, or when an error was not returned.

I really think this is a huge mistake. Don't do it this way. NAK NAK NAK.

Please instead of making this all completely messy and completely
impossible to follow the rule about exactly who does "putname()" and
under what conditions, just leave the slight duplication in place.

Duplicating simple helper routines is *good*. Complex and
hard-to-understand and non-intuitive rules are *bad*.

You're adding badness.

                 Linus
