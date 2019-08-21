Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3684398247
	for <lists+linux-raid@lfdr.de>; Wed, 21 Aug 2019 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfHUSDx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Aug 2019 14:03:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44271 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfHUSDx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 21 Aug 2019 14:03:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id d79so2612701qke.11
        for <linux-raid@vger.kernel.org>; Wed, 21 Aug 2019 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4BVtX3Nl2tj62n2bvGi8pYuPdmlt4gqa9bgDOvdEwA=;
        b=CYRCpTfKw9HKcEil4dI4Jr7XiRH2hMkwgvSSK9qsXzBMlIFlQ0/3pDR4XsSPQbUSdl
         vdppIGTvhUFUxiz0qIPoS/jmO5bTYdHDuKWNJNF1iK76iyO4bGviJaSyv63Ddd2L7AJQ
         6OF4iEqmuAF7GtmE+MHCap4CQkxsxggPcKbhYIgfup6wn5RnJ4oxvXEp15d2L7z/Wp0I
         WmdW69y5B5lLNM/bYrBm+Mr9F1Ouk6YVr24qVcoSZLKKuGYdjQmx5O8mQ60E7m+zbIvI
         QGujc5InKQzY/co46GBmrCP8vuNxrtjH4Oz76yq1YkeR0KpmwSBrU9GSQp1p27YmfEAH
         Qg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4BVtX3Nl2tj62n2bvGi8pYuPdmlt4gqa9bgDOvdEwA=;
        b=TGrHfcbcN5VCjkaz+t59QvqwSEZwzxFiyABCXNH/HeMUHn46VpaCCLMGCMlkrBjfTX
         WiBkLdAFsp0pjSfoh8AavtpRXQ4/j7j0QQVKl9ax2ojalmhxhBGkw0otjXIwZg5KHMAD
         T+m8pgGrVv3AwKtuVlfC4/ChYW6j1CL8fcrRgvTNrkDuiEKqWJbFiiJrxHkCQD7C0mrn
         +yavpfhDALUBmIzGnhEEAWsjL6QRV/CDnZ8ZNUbXeLNXuuMCjPJfnRypxNusXRgDOSC+
         CgTAJ7h+m8lMI+5+WguO98UTft1qowtTPkXbzeE+SJbt1TGFw6Lq1+yU+ilbvV0wJ1d9
         GLiA==
X-Gm-Message-State: APjAAAX9RsKe2hA50QBxUJLu7PZiXYrJRB9fODGczispPuybNa4lTmf/
        C7ZTr/44XAihP4Hr6cM3sEiswTp5L5qBr2+fQk4=
X-Google-Smtp-Source: APXvYqyBS/hyWeYNSzUAHy424lq/nVFmSTcZWOWxSqnVgXg6HIAq9g37vVFemdwjeq09LURGl7fojJR3fhEbMoJam7U=
X-Received: by 2002:ae9:e118:: with SMTP id g24mr32864120qkm.378.1566410632304;
 Wed, 21 Aug 2019 11:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <156626036792.15343.14564114570071245486.stgit@noble.brown>
In-Reply-To: <156626036792.15343.14564114570071245486.stgit@noble.brown>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 21 Aug 2019 11:03:41 -0700
Message-ID: <CAPhsuW7cN6uZduEogDkBvigH6a7znjyAUYXbnPz+ULUTmwbRaw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Two md fixes suitable for -stable
To:     NeilBrown <neilb@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Aug 19, 2019 at 5:26 PM NeilBrown <neilb@suse.com> wrote:
>
> Hi,
>  follow two patches fix two unrelated issues in md.
>  The second patch does address a real race, but doesn't completely
>  fix the customers symptom, so there might be a follow-on patch
>  once I understand what is really happening.
>
>  And Song ... have you considered update the MAINTAINERS file
>  with your details - I think that would good!
>
> Thanks,
> NeilBrown
>

Applied both patches. Thanks!

I will send patch to update MAINTAINERS file shortly.

Song
