Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CA21D1ADB
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389444AbgEMQRb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 12:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730731AbgEMQRb (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 13 May 2020 12:17:31 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11E7C2053B
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589386651;
        bh=iOPBlMkLYoCLZAlRB/W7iDhWz6CKMJ6Su03EaKJYtkQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PpcHJxyI87u4iSP14LhVn9JPvEgphwyUyY20SCkG8caiF7Ytzj5+o99e1fsb6D3+U
         2od8yFxxYpTvN5xv8bNhIPunWPyWhwJxXpLcMA6q8MFiuvKLO2WNGxsjac/oDnC1hw
         tvYeQCRVIXPFFSokFvY1vp+hNnRvy1ylKyLQwQ3w=
Received: by mail-lf1-f48.google.com with SMTP id v5so10043508lfp.13
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 09:17:30 -0700 (PDT)
X-Gm-Message-State: AOAM532XAzn6xEj+nQNP7EvqzVaAHNrLetW8ALFhKcUppbZQr1m/H6ol
        AAtAJ1Gf4Kgfxu+KX52kdcM+FLliDdGiQx7C/1U=
X-Google-Smtp-Source: ABdhPJwqIxrWIx27R0KrmGBJvgAeblPsE7qpj62RmaN8iqu0xcEYxjT4Au6jHHBy1E5FR0gNjH/c0bqCCY0ao8H/lec=
X-Received: by 2002:a19:d07:: with SMTP id 7mr170106lfn.69.1589386648825; Wed,
 13 May 2020 09:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl> <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com> <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl>
In-Reply-To: <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl>
From:   Song Liu <song@kernel.org>
Date:   Wed, 13 May 2020 09:17:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
Message-ID: <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> >
> > Are these captured back to back? I am asking because they showed differ=
ent
> > "Events" number.
>
> Nah, they were captured between reboots. Back to back all event fields sh=
ow identical value (at 56291 now).
>
> >
> > Also, when mdadm -A hangs, could you please capture /proc/$(pidof mdadm=
)/stack ?
> >
>
> The output is empty:
>
> xs22:/=E2=98=A0 ps -eF fww | grep mdadm
> root     10332  9362 97   740  1884  25 12:47 pts/1    R+     6:59  |   \=
_ mdadm -A /dev/md/r5_big /dev/md/r1_journal_big /dev/sdi1 /dev/sdg1 /dev/s=
dj1 /dev/sdh1
> xs22:/=E2=98=A0 cd /proc/10332
> xs22:/proc/10332=E2=98=A0 cat stack
> xs22:/proc/10332=E2=98=A0

Hmm... Could you please share the strace output of "mdadm -A" command? Like

strace mdadm -A /dev/md/r5_big /dev/md/r1_journal_big /dev/xxx ...

Thanks,
Song
