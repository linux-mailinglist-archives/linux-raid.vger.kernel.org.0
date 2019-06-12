Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834A242F4C
	for <lists+linux-raid@lfdr.de>; Wed, 12 Jun 2019 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfFLSsj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Jun 2019 14:48:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55276 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfFLSsj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 12 Jun 2019 14:48:39 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hb8IW-0008JB-SC
        for linux-raid@vger.kernel.org; Wed, 12 Jun 2019 18:48:36 +0000
Received: by mail-wr1-f71.google.com with SMTP id e6so7701251wrv.20
        for <linux-raid@vger.kernel.org>; Wed, 12 Jun 2019 11:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/sqcpVKxZj4PB2u1+J3qG3Iq9vFtOeiH35zGJmow4g=;
        b=t0u6p6263W/Ut0WFdy+6xQc+M1w3x54ruL0sv2DOt/tiLSOzTY+3+weYrrUPnZymdY
         pGZiGCSFu/Q+hs2TU73PQV61ceP9PIOY/w34DulrqDJURjIRHTp/pk4n+d11kyXFB12/
         bASf9xyR/osuA46lXdL0npgdBkPYDAOPGAsgDrel4o9n4C6lowjBJWOjknJA/I33f2vD
         28rh7e/Efxuygv3ct1lc1neibvzLCIpGi/Kv2moVKSJTZaBI9WDPD4uAJnq4dY2TOcyd
         lUo0DqJDOx18u99yI3P4sRTZwF/3UD9oVOCWUVOtgd4C/Wg0qfUxTczTVncZK+zvAI1a
         t51g==
X-Gm-Message-State: APjAAAVygayMII22k4XLevjHjigwmFyQf6ZdCphhTv3nVcsKe+4AtK+H
        gSvX7Tl/dr0VjH+d/1pAK1WNHOAtBNIbYTOuYHSVat0R4/oV20Ok+vAGs8zRrSYytCNU6qAshdC
        PKRxUD7oSHEplyhJ/FzL6ieHv8HELK+krnpiHnvwFHL3zoGLHQDmYqCQ=
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr414109wmj.155.1560365316506;
        Wed, 12 Jun 2019 11:48:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx6phQL1bo7mvDjvbreNkFlAF5JIygP0kbJi5i6SVxhCaUFSkGll1cKNcDFnl9xf3OlftrPj+7NtBdxiMP+r4g=
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr414095wmj.155.1560365316327;
 Wed, 12 Jun 2019 11:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190523172345.1861077-1-songliubraving@fb.com>
 <20190523172345.1861077-2-songliubraving@fb.com> <3d77dc37-e4be-2395-7067-5a9b6a71bf3a@canonical.com>
 <20190612164958.GB31124@kroah.com> <CAHD1Q_yoda7MUWDU5H4FKGK6tgmFXEEK9cvg20QJNrsgNgHnZQ@mail.gmail.com>
 <20190612184322.GF1513@sasha-vm>
In-Reply-To: <20190612184322.GF1513@sasha-vm>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Wed, 12 Jun 2019 15:48:00 -0300
Message-ID: <CAHD1Q_w76cZy9_6vTXuK-OOc-BgxXrjp_dfgox-+tZq=gA0Hnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] md/raid0: Do not bypass blocking queue entered for
 raid0 bios
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

OK perfect, thank you both!

On Wed, Jun 12, 2019 at 3:43 PM Sasha Levin <sashal@kernel.org> wrote:
>
> On Wed, Jun 12, 2019 at 03:07:11PM -0300, Guilherme Piccoli wrote:
> >On Wed, Jun 12, 2019 at 1:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Wed, Jun 12, 2019 at 01:37:24PM -0300, Guilherme G. Piccoli wrote:
> >> > +Greg, Sasha
> >>
> >> Please resend them in a format that they can be applied in.
> >>
> >> Also, I need a TON of descriptions about why this differs from what is
> >> in Linus's tree, as it is, what you have below does not show that at
> >> all, they seem to be valud for 5.2-rc1.
> >
> >Thanks Greg, I'll work on it. Can this "ton" of description be a cover-letter?
>
> Please just add it to the commit message. We might need to refer to it
> in the future and cover letter will just get lost.
>
> --
> Thanks,
> Sasha
