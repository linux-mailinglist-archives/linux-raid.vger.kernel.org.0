Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68F21364A9
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jan 2020 02:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgAJBTV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Jan 2020 20:19:21 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:40810 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbgAJBTU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 Jan 2020 20:19:20 -0500
Received: by mail-vs1-f41.google.com with SMTP id g23so282078vsr.7
        for <linux-raid@vger.kernel.org>; Thu, 09 Jan 2020 17:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0eV9tF9S6hoV8Ra38E7awG3jokoqvcft+s2UZeugrQ=;
        b=ZTYYieXR85EdcnSw1w+NFMTqJSvUdVkvwiZrBJmVsAvalLjHbcPgXLSS4jwpdU0XY/
         dU3B2U0Lex43DNI0cy1XSsOBREHqzg2lnrh04CcYLOWusrsPfbhbC5uR9MkblRQED5MK
         9GgIY5w25ggiYqciy9FErslUa0AhQ8PM6OfpA5KWpY5FfSR+fexYPj9fMqHtajc4ylZV
         ptnH7QYnS0prEH78UDblnoy4EwYJ4enzhvCK7NdQi9dwe9jgeF9eo+HX1/+JQY2W6EKD
         SVBqNSymTm1Itu5dQ6XwTDzbkYVzWXhWN8nOqXuYpM9g/8x26V2H8i/7r3ZtrGvw5iXD
         D+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0eV9tF9S6hoV8Ra38E7awG3jokoqvcft+s2UZeugrQ=;
        b=BtwCoG47YAZJcOFXVHX74qfcMGt92NSgKSYKZ/UGOEeJ11HSDJBplq2NxcBbfA5L7z
         SKJJXc6bkz/wHELBPaivXyLPMjQ6waK+58BuF151HVrZyiYcibf4blo+9QjC2msg294O
         vSUMKHpZUxW8c0q0r0aldOzWcl0/nb3rstDdfB7e0NSi9xsNX/l4lSNEJg5ZO7hDa13G
         in8NRKjNrb7LpltHSEJ3yhv0HErkPcXG0TYvYv9heMCbplaZI3jM3fflO/QYdAbB4AoF
         +bPs7cTvtYKsOJhT5Juv5gDpuxhaTP2ezI60516rK0BHC7A5FQXyPqtY5RBbaPfIYhgt
         Yvnw==
X-Gm-Message-State: APjAAAX3HS7Dfd0/M6OGqjUbLgKC+kNM6HOaMIUHYGTCHHSz6XGRbYlv
        NbtdcnJga+ME88aJefQEbLZO3B11jyDABkdXqUtpiA==
X-Google-Smtp-Source: APXvYqza54Dr0KvsczCfcdtqCxOVEepDiGFMeksSaQMetGjXwWWOwHHhvQS47od+fM0InOJx8bRLWRpPUvWsdn3KKb8=
X-Received: by 2002:a67:fd11:: with SMTP id f17mr308174vsr.63.1578619159738;
 Thu, 09 Jan 2020 17:19:19 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk>
In-Reply-To: <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk>
From:   William Morgan <therealbrewer@gmail.com>
Date:   Thu, 9 Jan 2020 19:19:08 -0600
Message-ID: <CALc6PW7276uYYWpL7j2xsFJRy3ayZeeSJ9kNCGHvB6Ndb6m1-Q@mail.gmail.com>
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     "Wol's lists" <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thank you for the encouraging response. I think I would like to
attempt to rescue the smaller array first as the data there is
somewhat less crucial and I may learn something before working with
the more important larger array.

> > md1 consists of 4x 4TB drives:
> >
> > role drive events state
> >   0    sdj    5948  AAAA
> >   1    sdk   38643  .AAA
> >   2    sdl   38643  .AAA
> >   3    sdm   38643  .AAA
>
> This array *should* be easy to recover. Again, use overlays, and
> force-assemble sdk, sdl, and sdm. DO NOT include sdj - this was ejected
> from the array a long time ago, and including it will seriously mess up
> your array. This means you've actually been running a 3-disk raid-0 for
> quite a while, so provided nothing more goes wrong, you'll have a
> perfect recovery, but any trouble and your data is toast. Is there any
> way you can ddrescue these three drives before attempting a recovery?

I do have plenty of additional disk space. If I try ddrescue first,
will that just give me a backup of the array in case something goes
wrong with the force-assemble with overlays? Can you give me some
guidance on what to do with ddrescue?

Thanks,
Bill
