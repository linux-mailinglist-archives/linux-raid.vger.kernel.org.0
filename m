Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F354357A590
	for <lists+linux-raid@lfdr.de>; Tue, 19 Jul 2022 19:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiGSRk4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 19 Jul 2022 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiGSRkz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 19 Jul 2022 13:40:55 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F42BAD
        for <linux-raid@vger.kernel.org>; Tue, 19 Jul 2022 10:40:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l11so11646296qvu.13
        for <linux-raid@vger.kernel.org>; Tue, 19 Jul 2022 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16aRIEanN2gABeiNaU8QLpSCWgUp78sT/SR77aKYJ1k=;
        b=oZ2BUjDN+Ey+RES/RUVRGw/rp1AzxhDcgwtAq9B3Kwtu5rycqpCVU45dLTMQqNx4tH
         wAsK7JKD1ETWfwmPa7Bwhv8ZkijcfCjhpdgV5Dbub/wfPx/D9Xl/2vsAt8lz8qXYN6Gw
         SPGGOP19ZlhtGYhRSDCfIDTDE6EUpFEvXDa8mkTv1wE9yc4C+MgdpqUk7rwaAKT/4rhi
         S1DV1KNKH3R1kjIyABSNiJAnyge9SwaySH8S+DCBmWk5ZXv4qk2FDdlTkVXXCgT4MY15
         VlQuAdBsC6ZspOgi39gadD+XAVVzq0fjtWF3CpuP60Az6LUtA31tsFjEFdZoLGajv/RU
         xePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16aRIEanN2gABeiNaU8QLpSCWgUp78sT/SR77aKYJ1k=;
        b=XGwUD0MWy0g302oiXymSwXM1d7lL1GFBfhmhP2QCmR3KE+jBgSLFIVhk3huxTK3Wkv
         5eTWuAp5xGyWna7YIIwQ/TLWXuU6K9alc8T08XnYxH5wW6sSzjdNbXofx6ex0J/819dw
         lFiKzByQPAqyCjgQt2MH6alfxc6bNvEY81XEK3kIICPtXD6gxiPw1jQaz1SiKLnfehfA
         XGolN8ielFGccIGiCkIzuenizFHwONReTQRocE/4eR6HcYv13tBQXryyJ0m+AMsP7IFI
         gCbc4Dr+a6OtbydN2GlBmZCgscxygtfL955KG3u+a73uq7YxMkmsKWCxDaG4bUxDx/08
         376w==
X-Gm-Message-State: AJIora8I7CM2s7tfhE70J+tfXASghljBEiIeSE/QzTiipgWU1OvdmTJC
        cs3Pan+NRN9S8YwId3m3Stt/eMdGImjBwjURplDmvcZZr1U=
X-Google-Smtp-Source: AGRyM1sCDs92uGlJ6IDkBxhGVD0BhvhGNJiXKlwjnmiXtLKiEeXShqkkGh0Ts/+KS76ai7uDMKsoIKqcJxMgWdIHK/w=
X-Received: by 2002:a05:6214:d0e:b0:473:16b:8953 with SMTP id
 14-20020a0562140d0e00b00473016b8953mr26852831qvh.75.1658252454148; Tue, 19
 Jul 2022 10:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <87o7xmsjcv.fsf@esperi.org.uk> <d28a695e-1958-d438-b43d-65470c1bbe7a@youngman.org.uk>
 <8ac1185f-1522-6343-c6c4-19bd307858f4@sotapeli.fi> <0cbb4267-2b0d-5e34-97e0-5e4d13f3275b@youngman.org.uk>
In-Reply-To: <0cbb4267-2b0d-5e34-97e0-5e4d13f3275b@youngman.org.uk>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Tue, 19 Jul 2022 12:40:43 -0500
Message-ID: <CAAMCDedhuJJakP03kGGk65abimKj7igg=19RTnsxvZa_uFmKLQ@mail.gmail.com>
Subject: Re: 5.18: likely useless very preliminary bug report: mdadm raid-6
 boot-time assembly failure
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Jani Partanen <jiipee@sotapeli.fi>, Nix <nix@esperi.org.uk>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

It worked fine for me on Fedora so long as I change it to use
python2.7, like the note warned about.

One has to love languages/standards (NOT) that make simple almost
pointless changes to something that has been around forever, and was a
standard, but is now being removed and breaks significant amounts of
code.


On Tue, Jul 19, 2022 at 12:21 PM Wols Lists <antlists@youngman.org.uk> wrote:
>
> On 19/07/2022 10:17, Jani Partanen wrote:
> > Sorry to jump in but could you suggest something what is quite much
> > default programs, not something that works only debian or something..
> > lsdrv on Fedora 36 spit this:
> >   ./lsdrv
> >    File "/root/lsdrv/./lsdrv", line 323
> >      os.mkdir('/dev/block', 0755)
> >                             ^
> > SyntaxError: leading zeros in decimal integer literals are not
> > permitted; use an 0o prefix for octal integers
> >
> Well, LAST I TRIED, it worked fine on gentoo, so it's certainly not
> Debian-specific.
>
> I did have to tell it to use Python 2.7 because gentoo defaulted to 3.
> Apparently it's since been updated, but I haven't (tried to) use it for
> a while.
>
> I've just googled your error, and it looks like a Python-2-ism, so it's
> nothing to do with the distro, and everything to do with the Python
> version change. (As I did warn about in my original post!)
>
> Cheers,
> Wol
