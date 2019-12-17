Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA04F123AFD
	for <lists+linux-raid@lfdr.de>; Wed, 18 Dec 2019 00:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfLQXjK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 18:39:10 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:44119 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfLQXjJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 18:39:09 -0500
Received: by mail-qk1-f181.google.com with SMTP id w127so9883304qkb.11
        for <linux-raid@vger.kernel.org>; Tue, 17 Dec 2019 15:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yh6Rx/uAoHqShzXRqwWwo0U18YqcgTMe9gBfxxSW9sw=;
        b=ch2e4Z2iUexs2jTIEzhpY10ANoxXrJ9a7clQbxub67cg8bq54gGgPQXOSRebYn+30m
         CFZCDak+YrCuHh/32MM+vQB/RSBp4Mon4bhKeq+K8YWTssSHnMQ8Nn9jdVsERtLWpMwS
         ICRbg/ecdCtkwn52cO1EMfOLulM+th7ayf2d6Ti6/GqCya1KyuxH+REAb6/l4bpZ7FPt
         dZZvbHbnHOi6xEFGhV1kXfXRUEY9hCpmzoukNdEIii4qI9TD000BlGaQ2qxJZsXR+G4K
         aPLhCFAOB4OL+8cOin7lt9O18l7Az45AIHcUEVH6k5naTcx7IcbP7GJ64WEJgeLPwa8K
         8uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yh6Rx/uAoHqShzXRqwWwo0U18YqcgTMe9gBfxxSW9sw=;
        b=Ytm+bz19QQuSD7ULtBn2j8AQyKkrC/jGmghyadHtiQPz4ZlXy6+YOsAf7mKdL5Wexc
         4RtRCDDm45RMxf7PKtbKQSQGUvjWEelMBS1y6InWBwBzL/VZ2ZhoJpaovTrH+SvOD+nK
         vCywBi0PRI/bU1T9cMSLl9s/hkAxTrqAx1g6EHT3Yc/rR4XIljFfeqzwgduDKvZ1Zgq3
         jpkPPwQNfwM9eAWwud79bKYu1vmRTgVK8BhDtpWS5tUY/vhjHhaxzUvam4ZjRQqc/ZkD
         p0pVN1zR0LSqWzlm+ldyEyROqSOxZEO8r7oYZdg84yf97QOn28AZlASTUsiR+2tBzcvG
         4AmQ==
X-Gm-Message-State: APjAAAUByaYBrQg49t5W14qVvkVeeYIex1i4nLcwlo5q0i0tTXyAQYwJ
        z0PWV7n6UEPlJ5XX98+3tjM0W1uGcBYsw9314EM=
X-Google-Smtp-Source: APXvYqzGBkfs6nVTmKrFp/cTz7/HR+P5R7MmF8YMattzwVameGtzZjl6hZ6wo7KLaypkyBAJlAgu6ku0JxelF6eEdC8=
X-Received: by 2002:a37:7b43:: with SMTP id w64mr617200qkc.203.1576625948342;
 Tue, 17 Dec 2019 15:39:08 -0800 (PST)
MIME-Version: 1.0
References: <b0701f30-5df9-059e-95f1-74a887782528@huawei.com>
 <f684ec06-cb01-b296-33bd-0e429af01077@huawei.com> <CAPhsuW5raVXg3BrVpinQ6x-pZgskEMQmd5=uxS+nBk=wO4mrDg@mail.gmail.com>
In-Reply-To: <CAPhsuW5raVXg3BrVpinQ6x-pZgskEMQmd5=uxS+nBk=wO4mrDg@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 17 Dec 2019 15:38:57 -0800
Message-ID: <CAPhsuW4FD8vm8-nfBGiC1K-UvqgnGZN5YNpxACb564WjmDvTQw@mail.gmail.com>
Subject: Re: [PATCH] md-bitmap: small cleanups
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, guiyao@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Dec 13, 2019 at 10:08 AM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Wed, Dec 11, 2019 at 6:39 PM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
> >
> > Friendly ping...
>
> Sorry for the delay. This looks good to me. I will apply it to md-next.
>
> Song
>

Applied to md-next.

I changed "Author" from "liuzhiqiang (I) <liuzhiqiang26@huawei.com>"
to "Zhiqiang Liu <liuzhiqiang26@huawei.com>".

Thanks,
Song
