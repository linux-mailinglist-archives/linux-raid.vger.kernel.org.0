Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B3021A69F
	for <lists+linux-raid@lfdr.de>; Thu,  9 Jul 2020 20:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgGISJG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Jul 2020 14:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgGISJC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 Jul 2020 14:09:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC9DC08C5DC
        for <linux-raid@vger.kernel.org>; Thu,  9 Jul 2020 11:09:02 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y13so1695658lfe.9
        for <linux-raid@vger.kernel.org>; Thu, 09 Jul 2020 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLUY2+cROQWDH9LIMjuUg8XLSdiwCev/lP1hc9DwpHE=;
        b=Xw17pp3QVH4SLTeelEhTcbB9WI56tYv4leZAltXzvEIWNs50TewZI2tfSpQ7QZMxH6
         5F3rhBO6EWtqhrcf2t3KoUtkNyWFvvLaN2SzNstCrzohcqjTqUHBNcOnAIhq1Jin6fEG
         t49EF28LHN/k7FfZi6olVrtLnJMu540l0OAEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLUY2+cROQWDH9LIMjuUg8XLSdiwCev/lP1hc9DwpHE=;
        b=Ey941C5bfqEDkGqwzf5ZXysuK+belx8hJbFb3KT8zQzByBFCok785SihTZpeFbk7bF
         YuezOyqUuU8FXV3Bn1RcyQDFnwIlnROrOBL6FeuifE/4SpVUJzqO9C21X/oe3Kgz+MLB
         7wem4pUVpCvEc+zaxG9I1nqYRhfTuFs0zGJA/Yka9/Ftve5IFRz4bsbaAIEbwS3rJQoJ
         uSzk8TCh3g+MB/FxbR5uEgR+IcSEb8nlJgxTqNo0T6tPwyG/Uzdvv8FStEhed/CeBjq0
         2L1snO3B83gjk+DmjVuSClzQAHAeE5ES4g6tkcu6fIBtIS/FnRCNhkDNoPtHMHrOZ3Ta
         Sw6g==
X-Gm-Message-State: AOAM533g/0hMOyM4hDzJJoMNHqNuGCARHt3SY6C+QdlSpkMVioZNY9BS
        psuh0omZRJqX9Y6K9adN7GfExF7iUgA=
X-Google-Smtp-Source: ABdhPJyBLSM3QZdh2KZSt7TC1gesFnzKNnlXLxPITqOU6/9LsYKM192T9Ld8GHI2Uhi25Tqz2NIY4w==
X-Received: by 2002:a19:7f55:: with SMTP id a82mr40525730lfd.112.1594318140448;
        Thu, 09 Jul 2020 11:09:00 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id e16sm1049943ljn.12.2020.07.09.11.08.59
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:08:59 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h22so3436697lji.9
        for <linux-raid@vger.kernel.org>; Thu, 09 Jul 2020 11:08:59 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr36562158ljj.102.1594318138800;
 Thu, 09 Jul 2020 11:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200709151814.110422-1-hch@lst.de>
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jul 2020 11:08:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibathZJc6oSfgBdw7qhW75eF1ukg9y3bMXFfmp5t_uig@mail.gmail.com>
Message-ID: <CAHk-=wibathZJc6oSfgBdw7qhW75eF1ukg9y3bMXFfmp5t_uig@mail.gmail.com>
Subject: Re: decruft the early init / initrd / initramfs code v2
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

On Thu, Jul 9, 2020 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no really good tree for this, so if there are no objections
> I'd like to set up a new one for linux-next.

All looks good to me. I had a wish-list change for one of the patches
that I sent a reply out for, but even without that it's clearly an
improvement.

Of course, I just looked at the patches for sanity, rather than
testing anything. Maybe there's something stupid in there. But it all
looked straightforward. So Ack from me, with the hope that you'd do
that "vfs_chown/chmod()" thing.

                Linus
