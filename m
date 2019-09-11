Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01329B05D2
	for <lists+linux-raid@lfdr.de>; Thu, 12 Sep 2019 00:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfIKW7X (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Sep 2019 18:59:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37785 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbfIKW7X (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Sep 2019 18:59:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so19686876qkd.4
        for <linux-raid@vger.kernel.org>; Wed, 11 Sep 2019 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhZos980lS0G8QbxLzs6QnP157PxVsJoTC+IKjVU2m8=;
        b=r1naAFIIm9BWEcJBXb57cnReBXFKG2mU48eFUweQqOxwFaOXs+gI+v4+io9dHJvqxO
         Vj10y20Vg1Jm708kl20ED7vJsqG02d8qUuIbPeuMCWhJUtlVru2OFhktzCxHRjeTwzI3
         6Sd4N2a0j5kGAtkm9eVFYdS2lsJFZjs3EpM11maaMdT9nXrSOldHawcPkgDWe6ugMbEL
         TrrMLw9DaR+Np6/JPlfw+sYfp7F+PySVMWwLPW1H2lWuDCBv6sOdEq8CvW5ao0egO9Rn
         lwXOsPtt1F7IFQWeIY8WCRmLtW6Poi1PSqZiHMf9W7Qkyxtqia2o00bsdR4oOBGUKYCN
         7NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhZos980lS0G8QbxLzs6QnP157PxVsJoTC+IKjVU2m8=;
        b=DXkZrHZdRuVIUhBX6KuQynV0qhB1zJuWwyeHhn+NsGHw0i3Tl9EsB26r1Tk03Jlljt
         cUAYNBxAsMw3LHUECbyonIORbYN5Swd+IuqpCI4ypFneFAOShEp0UfdxE38/nUYIcWWx
         tcRSIjkY/Ttu+v76EUBnAE9M5wAegTYYqaIf3uR6dajOHS3ESAwtIkw6ZCh96nknoIR7
         5Tz4hKErWoZAhKrsDNbAep80AxOvohxDfpIc4OzHfG2Ypn3F1WqqhsCCX+kQPCAgmVa7
         0Um1JWXuJGrdQe2GBgbu/ReuzXrVEDSFnX8m0KXFm1s86F6kzJic6L5t3qsGKWtcF45u
         TWJA==
X-Gm-Message-State: APjAAAVhLo2q9UHLsVmgzWz6816CTDvKrZqihXH/WJYDlUKfTGQrxSrC
        dF2bxmpRvELcaNDCew5ITkFZfRykdTwE21yjwa8=
X-Google-Smtp-Source: APXvYqy+kBHs3zyJPjTJbrUFKK24z+4YJ2OSIAB+APdZax5H5pwWk3A24oHapTYIYuqlmKXWKn7rLcRNNvuKEsQeTro=
X-Received: by 2002:a37:aac9:: with SMTP id t192mr37788933qke.31.1568242760915;
 Wed, 11 Sep 2019 15:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190911030142.49105-1-yuyufen@huawei.com> <CAPhsuW7Q=YsMkMQGMS54vskTRjM24oRMWP7534n_pkOhyGvJUA@mail.gmail.com>
 <3c5a5ede-d1a1-dd55-2dde-73b72a9c475d@huawei.com>
In-Reply-To: <3c5a5ede-d1a1-dd55-2dde-73b72a9c475d@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 11 Sep 2019 23:59:09 +0100
Message-ID: <CAPhsuW73B=MX_pCEb313h7HWsDj4raWDOhD5M_PqWtbqP8PtsA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] skip spare disk as freshest disk
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Sep 11, 2019 at 12:21 PM Yufen Yu <yuyufen@huawei.com> wrote:
>
>
>
> On 2019/9/11 17:38, Song Liu wrote:
> > On Wed, Sep 11, 2019 at 3:44 AM Yufen Yu <yuyufen@huawei.com> wrote:
> >> Hi,
> >>          For this patchset , we add a new entry .disk_is_spare in super_type
> >>          to check if the disk is in 'spare' state. If a disk is in spare,
> >>          analyze_sbs() should skip the disk to be freshest disk. Otherwise,
> >>          it may cause md run fail. There is a fail example in the second patch.
> >>
> > I think we need go a different path. I am sorry that some of early comments
> > are misleading.
> >
> > We can extend the output of load_super() to have "2" for spares. And this
> > _should_ make the code simpler.
> >
> > Does this make sense?
> >
>
> I think we don't need to add extra output value '2'.
>
> For now, only analyze_sbs() use the output of load_super(). The others
> caller just
> check whether load_super() have failed, which will return a negative value.
>
> My first version patch directly modify load_super() and return '0' for
> 'spare' disk.
> Then analyze_sbs() can skip the spare disk as fresher disk. I think it
> does work.
> https://www.spinics.net/lists/raid/msg63136.html
>
> BTW, I don't know how to return '2' from load_super(), which pass events
> test as
> you say in the first patch. At the same time , it does not affect the
> other caller.
>

You are right that we don't really need output value '2'.

I think v1 is closer to the best solution. Let me comment on that again.

Song
