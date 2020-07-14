Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5266F21FD71
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jul 2020 21:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgGNTfG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jul 2020 15:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgGNTfF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jul 2020 15:35:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DEFC08C5C1
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 12:35:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f5so24998282ljj.10
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmvrJI/J3yG66g6pPz5Il+RcCg67c3v/jT1iQASKlcc=;
        b=KIYXfollvDwZIWSi8MBvzI16dhsw+y4zL9hnXlh1UD0SE8cjPtPzh3zCIWaf7usmKY
         sJIPvwRi57eB+/xJI+6JaFihnvlQfFnptYDDF1G9FGiSyn3r0SxvQFRYD3v6hzm4/QTE
         v64cADt8D/wtG1AQ2083itD+hTnNb9/mL5p7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmvrJI/J3yG66g6pPz5Il+RcCg67c3v/jT1iQASKlcc=;
        b=EH7NPyXhDDF2el1FTrronnq6xCdezYnaCR+RDeQCXCLshVsTftskhG8uJcGe+3Tl9H
         MX1ChNhtmirOiJMEhZwJimzRZ61WgHfHt/sO5nx5g0TiL3Xye5ctMd9hj+QNwvcj+Zdz
         0ytkQUB4+oGmq0TR+RNc9LsA/c5xa31BCXzRUlHHCTj7rh//sT0sRL1u6+O1xWVhQJba
         KEbWjTEzNxSF5pbQTV0yyiUE9u6eeoI2gf72TR3seVHJHDiYH64bLMfzMvCrnFojwFR8
         f6K5agWhPqmHSZgwJ7T2YZvX+Tfq9UykyX1/QebfqxS5x6oEPn7c1XRxXr7HkhMvw2KA
         sg6w==
X-Gm-Message-State: AOAM533f71zywLQkVMapQ5KILGpVgifUnMmCcUlNhyGi+Jyq3xBX6Jwp
        F1etzwEUd1Amz2EpdCr6T39sFYh8lIk=
X-Google-Smtp-Source: ABdhPJykfvH7QV2MJlCtDkm+Um+3j1BSNXSUk7CjJxWIKT48vqqTQV5XTNeUkuiU4YvrCq8bfQJBLg==
X-Received: by 2002:a2e:9908:: with SMTP id v8mr2933901lji.186.1594755303260;
        Tue, 14 Jul 2020 12:35:03 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id u8sm5471339lff.7.2020.07.14.12.35.02
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 12:35:02 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u25so13061681lfm.1
        for <linux-raid@vger.kernel.org>; Tue, 14 Jul 2020 12:35:02 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr2908470lfd.31.1594755301618;
 Tue, 14 Jul 2020 12:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200714190427.4332-1-hch@lst.de>
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 12:34:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com>
Message-ID: <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com>
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

On Tue, Jul 14, 2020 at 12:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> this series starts to move the early init code away from requiring
> KERNEL_DS to be implicitly set during early startup.  It does so by
> first removing legacy unused cruft, and the switches away the code
> from struct file based APIs to our more usual in-kernel APIs.

Looks good to me, with the added note on the utimes cruft too as a
further cleanup (separate patch).

So you can add my acked-by.

I _would_ like the md parts to get a few more acks. I see the one from
Song Liu, anybody else in md land willing to go through those patches?
They were the bulk of it, and the least obvious to me because I don't
know that code at all?

              Linus
