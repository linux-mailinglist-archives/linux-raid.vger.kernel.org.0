Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7D929DAC8
	for <lists+linux-raid@lfdr.de>; Thu, 29 Oct 2020 00:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390501AbgJ1XbG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 28 Oct 2020 19:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgJ1XbE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 28 Oct 2020 19:31:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582C4C0613D1
        for <linux-raid@vger.kernel.org>; Wed, 28 Oct 2020 16:31:03 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k3so774235otp.1
        for <linux-raid@vger.kernel.org>; Wed, 28 Oct 2020 16:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9ZlXToatDcyQe4UfooUu3JrhisJTqzWvPk9UeTaykHI=;
        b=L2xbAiWTTbIrt5K7yoWLPYgbHcR6JA3ygW52PmeYhcPUro9EBJ7jeSZ+LuUceUwi6h
         7oJ0nyVewkcb5K+ygEJWYYMKXhaWMSobBdS26zzBkdJSzJLQfkJ9ORBytL4idG2x8OiJ
         9aarfLTEzGCk1uCjCog7oi7V7msQ35V7eKNBN6lB3Pt0XeZUaZZGqxIfwBcha2zEJ3WN
         kZ9kfFU6h35Lf2aGkBLA0WhEm9MhweORqvnr/qOj6MkqYCWc4yB4rpgdiBoO/86iCgZ7
         IEUBBDYCvLrMJVulHBHcZCHWqbinwfnCxIm8NM7pVPl6asD8IeCh1a7crlyWFtjVbf2K
         AdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ZlXToatDcyQe4UfooUu3JrhisJTqzWvPk9UeTaykHI=;
        b=C75n99BZDDkjBXbHayCj7ZeymWs/X7BAveZPW9Vfvvi1PX7r1bNlchhPNxYQWqPb++
         nVy8PuP/6va797MQffPnI/N7rBk4TulTQ4D9ljOJjQKJLJSEGCr9BBot/DHF/qzVl7sY
         J+w9DTlSFyrhEB4EQel9DgefbyUC/Dre6Bi/m70ZzGIGFZ1+KFaAWl9w0nVAPEPlYrZO
         N/kZiho0y/MIoEznDn3dZ6y5vq9XYYUClI5NbaE6xh0NaVt+q+tZi4wS/CZ9ihQW5o7v
         +PUzHII3FC1LlBM78btPmrBDZLCBDRKQCW+gK7ydX6Z/VliSGnuzor7QDKkT5hSfMeO5
         6gjg==
X-Gm-Message-State: AOAM531tupTD5nlyP2IhZh700WKvJm5JIwBWTFwXXksdKIDAXUHiKaii
        ZYqe98wLYru+TLrWkUEaOtFHY5/thh19dTEB1rWSbtRJXWvOQQ==
X-Google-Smtp-Source: ABdhPJwPEPpN0dIcKBfaGDgutMYF3sOkE6KoP9i1uddB1epbqqtMw2qCiW/gFeatIzJ1+Wk2li1pZyaWC1wQlcX+ghA=
X-Received: by 2002:a25:41d0:: with SMTP id o199mr9520447yba.276.1603885293714;
 Wed, 28 Oct 2020 04:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201026130450.6947-1-gilad@benyossef.com> <20201026130450.6947-4-gilad@benyossef.com>
 <20201026175231.GG858@sol.localdomain> <d07b062c-1405-4d72-b907-1c4dfa97aecb@gmail.com>
 <20201026183936.GJ858@sol.localdomain> <20201026184155.GA6863@gondor.apana.org.au>
 <20201026184402.GA6908@gondor.apana.org.au>
In-Reply-To: <20201026184402.GA6908@gondor.apana.org.au>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed, 28 Oct 2020 13:41:28 +0200
Message-ID: <CAOtvUMf-xv5cHTjExW2Ffx6soLavFztow6DwE6Qo5pffF0N5uw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dm crypt: switch to EBOIV crypto API template
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Milan Broz <gmazyland@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Song Liu <song@kernel.org>, Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Oct 26, 2020 at 8:44 PM Herbert Xu <herbert@gondor.apana.org.au> wr=
ote:
>
> On Tue, Oct 27, 2020 at 05:41:55AM +1100, Herbert Xu wrote:
> >
> > The point is that people rebuilding their kernel can end up with a
> > broken system.  Just set a default on EBOIV if dm-crypt is on.
>
> That's not enough as it's an existing option.  So we need to
> add a new Kconfig option with a default equal to dm-crypt.

Sorry if I'm being daft, but what did you refer to be "an existing
option"? there was no CONFIG_EBOIV before my patchset, it was simply
built as part of dm-crypt so it seems that setting CONFIG_EBOIV
default to dm-crypto Kconfig option value does solves the problem, or
have I missed something?

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
