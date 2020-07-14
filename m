Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8B021FD65
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jul 2020 21:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgGNTbX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jul 2020 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGNTbW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jul 2020 15:31:22 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36366C061755
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 12:31:22 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u12so229398lff.2
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPk5LMoGoThBA0eFxbivhO2pS56bC/86EhKFPKHKu4c=;
        b=VLmnr+RKkXZkAascGHD+AaCNa6Y2XPywcyp6v/mdbuMkz/hf+hhfE1/nd7RM0JXapm
         cVYAMBvwJI3Gd5pMjW+DZXpL4Lk84F0PSZHOcvKhlEII13xTPasta+T1CpQkTxCpx6DR
         hsyOPnSmMSJKICLP2tLHfz+bnE3r2Zf/mvQgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPk5LMoGoThBA0eFxbivhO2pS56bC/86EhKFPKHKu4c=;
        b=mEagLF1I10n1bpnx3l8VzOKeSCsZtxsYhQFbjBqLUJOeu6nDOdj6E/X5Xk4eEguMQe
         gTkjDtBbaGGgjAeQLmHwalo/ELY5yeJNC6ulHzU5C7Dusl6ScFZ2CnNeCY20JZWtYsSL
         9QT2sFod/EOIC2OrYYj6zXbvvzZDC7r7InJSv/SPu07XiHXS/8UfgV4B8J15JhfonqTa
         /d1xwxMHtUzpqmhrN+k0byqg/0nEQHH1d8jI72l617op+cDvlexS/8VNSkyYvJZdgk7Y
         1a+gb8thDzb3Y/r3q7ohZ8/VY/z5Jo6Lu6eUWaj5N9IsQ9ReYMYkH+SPpUOT7Szra4Wk
         U44Q==
X-Gm-Message-State: AOAM533mQn+mWCy7uZqgEDg9y02Y91yK2M5y1nqqe5aW1eKt4d0IWjZg
        u6QQyCC23J3G4rwV1AOkjIuanNZB6zw=
X-Google-Smtp-Source: ABdhPJyYTh8deOQFidNfWrJRZZ6AZRCQiqavU3fswQJ3Adx7rw3vXdLBpNiKpdk1nymfIeaiPJqI9A==
X-Received: by 2002:a19:4805:: with SMTP id v5mr2962177lfa.75.1594755080286;
        Tue, 14 Jul 2020 12:31:20 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id l26sm4834224ljc.131.2020.07.14.12.31.18
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 12:31:19 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id q7so25022783ljm.1
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 12:31:18 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr3168247ljj.312.1594755078276;
 Tue, 14 Jul 2020 12:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-18-hch@lst.de>
In-Reply-To: <20200714190427.4332-18-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 12:31:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDbHL7x5Jx-CSz97=nVg4V_q45DsokX+X-Y-yZV4rPvw@mail.gmail.com>
Message-ID: <CAHk-=whDbHL7x5Jx-CSz97=nVg4V_q45DsokX+X-Y-yZV4rPvw@mail.gmail.com>
Subject: Re: [PATCH 17/23] initramfs: switch initramfs unpacking to struct
 file based APIs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jul 14, 2020 at 12:09 PM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to mess with file descriptors from in-kernel
> code, switch the initramfs unpacking to struct file based write
> instead.

Looking at this diff, I realized this really should be cleaned up more.

 +                       wfile = filp_open(collected, openflags, mode);
> +                       if (IS_ERR(wfile))
> +                               return 0;
> +
> +                       vfs_fchown(wfile, uid, gid);
> +                       vfs_fchmod(wfile, mode);
> +                       if (body_len)
> +                               vfs_truncate(&wfile->f_path, body_len);
> +                       vcollected = kstrdup(collected, GFP_KERNEL);

That "vcollected" is ugly and broken, and seems oh-so-wrong.

Because it's only use is:


> -               ksys_close(wfd);
> +               fput(wfile);
>                 do_utime(vcollected, mtime);
>                 kfree(vcollected);

which should just have done the exact same thing that you did with
vfs_chown() and friends: we already have a "utimes_common()" that
takes a path, and it could have been made into "vfs_utimes()", and
then this whole vcollected confusion would go away and be replaced by

        vfs_truncate(&wfile->f_path, mtime);

(ok, with all the "timespec64 t[2]" things going on that do_utime()
does now, but you get the idea).

Talk about de-crufting that initramfs unpacking..

But I don't hate this patch, I'm just pointing out that there's room
for improvement.

             Linus
