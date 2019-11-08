Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D5FF5BCB
	for <lists+linux-raid@lfdr.de>; Sat,  9 Nov 2019 00:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKHXVB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 8 Nov 2019 18:21:01 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46355 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHXVA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 8 Nov 2019 18:21:00 -0500
Received: by mail-qv1-f67.google.com with SMTP id w11so2863760qvu.13
        for <linux-raid@vger.kernel.org>; Fri, 08 Nov 2019 15:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+UurfLLdpVW1ndMNpPaWeE31OflCO14KEtDJo6ofFI=;
        b=GVywqR/oAVJB47TxbWkkNcRsMMu21A0EfPWFd/m7XUeFwfUvQ1kASVgCSG26+Im4uW
         jE+YXGI4xU4Vxw8fLlxrmjeH6bxkCgEud6ZvwdTwSlrFpB/gTQvHIwL1wW9YoM1zq/9l
         zZLrzOadKLHuPZZj9NKscDWGOWpWOTbj5W4Z03Dd4qHxyuTXpzy5NRvd1MuTcl1wdUKR
         HU1IJ1S5wzkZBQg2o+K/V6CrsZFOlrhC1JQ5g/l+30KlSXTcGTf1ItWUQeSquET1Deb9
         Br9IEOS/MGF9ZimO1owiIdJUeEvDiLWxzG8t2VE3K254k8NmkmFgEpOaQU4WE454FBNC
         CC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+UurfLLdpVW1ndMNpPaWeE31OflCO14KEtDJo6ofFI=;
        b=q6uRK0FiBLitb67Se0pxBYzWzzcd1bKfp7ff0PigpJRkfRUwe91TaZZSvaaby/2zZ5
         n/nSUS8lrZXj0zgAOKiTlQBQONRVZcrRLrtpCRbIqFovpKLmDxAD0Zzabq/vcJozc93s
         R81vp4QZ3NfIcoGe7qQALELN4QPgM3d+w9rvIeHJHK8u2kcxKXQpXvAoQyGTKt0zopEt
         47Rqrea2PtKqBxT8VRFG/6hVlyufOAe34UhNc52ROpcuoWjKXOAXXuDhTSVBUKgKHO4K
         HfnLW3VpBbHs+37Oy9NkrF0xZcuYP4rOVlbF4BjuN+RfgfOVqZi/PZ5oIs/Hz/MBaGZd
         39EQ==
X-Gm-Message-State: APjAAAVhvEMuX1BWF29d1J1ZeVbBoirGjL5QbDE7BcnF1kbc7p9P197G
        CH+PWVe1Cj9Rg8nW/Tu5IUAGUlfuMfTD8QeoZKopqw==
X-Google-Smtp-Source: APXvYqxZsyyfdyj5woLa0FcF1rGIXZovc/oH2/urIU4P/o/Jz6sP9CP0UbwB4AcK7IXJ0InSoUtJEHxoSQ8ojPXDXCo=
X-Received: by 2002:a05:6214:13e4:: with SMTP id ch4mr11962857qvb.242.1573255259975;
 Fri, 08 Nov 2019 15:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
 <20191101142231.23359-7-guoqing.jiang@cloud.ionos.com> <CAPhsuW4tFUO4UAWyRoMsPTWKBq7=fe0jj-9ojP=r2oF2_OgrQw@mail.gmail.com>
 <961f17f4-77bc-f9c7-035d-4333b11a60ee@cloud.ionos.com>
In-Reply-To: <961f17f4-77bc-f9c7-035d-4333b11a60ee@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 8 Nov 2019 15:20:48 -0800
Message-ID: <CAPhsuW5tSEFpbUKJ-EP_RyabmsRQzBTX18Mkbw6WyUG+M2rkVQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] md: switch from list to rb tree for IO serialization
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Nov 6, 2019 at 2:43 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 11/5/19 11:03 PM, Song Liu wrote:
> > On Fri, Nov 1, 2019 at 7:23 AM <jgq516@gmail.com> wrote:
> >> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >>
> >> Obviously, IO serialization could cause the degradation of
> >> performance. In order to reduce the degradation, it is better
> >> to replace link list with rb tree.
> >>
> >> And with the inspiration of drbd_interval.c, a simpler
> > Can we reuse the logic in drdb_interval.c instead of duplicating it?
> >
>
> Yes, I thought about it, but we need to move the logic from drbd to
> a common place before we can reuse it. And seems pat_rbtree.c
> has the similar implementation, so we can reduce a lot duplication.
>
> But it definitely needs more efforts to put the logic to a common place
> since it involves different subsystems,  which means we have to wait it
> for a longer time. Or we just add the logic here, then try to refactor the
> common code later.

I would prefer we at least try the move. If we got push back from drbd
maintainers, we can go back to current approach.

This set is not likely to make the upcoming merge window. So we should
have time to do some clean up.

Thanks,
Song
