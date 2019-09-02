Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4080A54D5
	for <lists+linux-raid@lfdr.de>; Mon,  2 Sep 2019 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfIBLaa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Sep 2019 07:30:30 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45524 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfIBLaa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Sep 2019 07:30:30 -0400
Received: by mail-ed1-f52.google.com with SMTP id f19so1366592eds.12
        for <linux-raid@vger.kernel.org>; Mon, 02 Sep 2019 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9CowtJ8J/YFtSA1kSwQmb4fH6JPfFIM4ILUUj31h7hY=;
        b=cOt/ZDn+oEIOej10KrGYg8XwsWUmsmpeVqGp0rxTTvxaehsIiW4qUboEAxi0oFlihg
         2jpUcfwv1McfqZlRR3/A273gvCJTW646n3seQ3LjvUau8dzgPYUKUEqkN9vrEpdpchiO
         zquTjQ3uMvuRjC8D8JUaezaN2gcevC2PJac3PEVEphpud1go9nvI8gb0wTjBTj1YHIOA
         NM5JOunlM7aYGF510fq/P8nVi6eK9/UQLsgrPBD9Rbwo0QOCYLmnuueZ20Vx0xiOzntr
         rny3xVeuTxO//kvmxYRhkhwjZvJsUj1OK1BwunqwRmd+alyaiFG3PIEuNWJ27dsgit63
         kS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9CowtJ8J/YFtSA1kSwQmb4fH6JPfFIM4ILUUj31h7hY=;
        b=nLF7CVxKFXyZ3ZNC32zxJHBFnkPo7X/lF8ciyNO9ORfFsrMLLx9OrkHz2pOQU2KB3y
         rlE7aiQhlG3guKcHdmc3FAin0wTPolPda2pEddci8CPbwCy9QNd1y32MZekUCGKo+Pfe
         yadEPW/O38zDxL5wqAzicrD6/nACNNHuvJOMS8DA+lPH1WL7rRfzgK1h8ocJf67cT5nj
         ZuvzaIT6ae5fT/xk2zkouVrWY2qrRDotqSN4shYoqT+QaE+IEqDkUAx4ne7/CZh4oR5O
         2iW01Kd4ZJG+sNIg7xng1CGgsxynA9jxfSyrIeN+XF8F3N9xfz8HeQ7zw7WrYV9MbDdz
         obVg==
X-Gm-Message-State: APjAAAUBlpCHSinu3TMgQRugwMLoHv15tef5Cb54CS596gZbC4YYzNFU
        KyDQTn0DD+TxYO2zcVCuNLyGEkbNWNVFD6Mglhb0+Q==
X-Google-Smtp-Source: APXvYqxCNGs9z+5uy6nAQDsLjHSuY62QtcVYhg0mp4CWIoIzQx/QQPotrCi8nNuXEf8igo4uYcV47LW4MtRqXKJTK9s=
X-Received: by 2002:a17:906:7715:: with SMTP id q21mr7513798ejm.236.1567423828905;
 Mon, 02 Sep 2019 04:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
 <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com> <5D6CF46B.8090905@youngman.org.uk>
In-Reply-To: <5D6CF46B.8090905@youngman.org.uk>
From:   =?UTF-8?Q?Krzysztof_Jak=C3=B3bczyk?= <krzysiek.jakobczyk@gmail.com>
Date:   Mon, 2 Sep 2019 13:30:02 +0200
Message-ID: <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com>
Subject: Re: Fwd: mdadm RAID5 to RAID6 migration thrown exceptions, access to
 data lost
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Phil Turmel <philip@turmel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thank you for your input and I'll wait with further steps until confirmatio=
n!

Best regards,
Krzysztof Jakobczyk

pon., 2 wrz 2019 o 12:52 Wols Lists <antlists@youngman.org.uk> napisa=C5=82=
(a):
>
> On 02/09/19 11:05, Krzysztof Jak=C3=B3bczyk wrote:
> > My questions are the following:
> >
> > What to do in order to move the reshape process forward?
>
> I'll leave that to others, but my gut reaction is just to restart it
> (don't follow my advice! Wait for someone else to say it's safe :-)
> >
> > Do you think the data on the md0 is safe?
>
> Yes I do.
> >
> > How to access the data on md0 if I cannot cd to it?
> >
> Wait for the system to (be) recover(ed).
>
> > What are those stack traces in the dmesg output?
> >
> > Help will be greatly appreciated.
> >
> MAKE SURE you've got a rescue disk with the latest mdadm and an
> up-to-date kernel. I strongly suspect you've got an out-of-date system -
> mdadm 3.2.2 is pretty ancient. This sounds to me like a well-known
> problem from back then, and if I'm right the fix is as simple as booting
> into a up-to-date recovery system, letting the reshape complete, and
> then booting back into the old system.
>
> Can someone else confirm, please!!!
>
> Cheers,
> Wol
>
