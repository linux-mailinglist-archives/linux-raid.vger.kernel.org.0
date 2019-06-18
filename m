Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B771349868
	for <lists+linux-raid@lfdr.de>; Tue, 18 Jun 2019 06:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfFRElR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Jun 2019 00:41:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36528 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRElR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 18 Jun 2019 00:41:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id p15so13727191qtl.3
        for <linux-raid@vger.kernel.org>; Mon, 17 Jun 2019 21:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTb/edku730zWmb4La0e/IBKyBWxviMzv8WRfNbIESg=;
        b=NpQIauRsD/3c1nY1Ym999ByEAene7sl/T1kI3zhMMJPDtEduVGoUKMqmockMeTYeGH
         oKcoG16fwilLOu8d3sqUu376BSFbeuLo9ZkmgZ6im33rC/O6m/AtgNGC7cPe9OwwUWvB
         A/G1283rgQgbYoYk1yIe96WobagNkP87u05IwSl1CfQDy80JI4vDUj0lpCi6vpNYkqV6
         7OffoDzs7MZ4GNAZTesn0/GATcsicTpYoONN2tE8GD037UDxnxwt2KVV6gkYhXGH0szS
         PHFrnO51g+h3YsD0afpYhgqU0QsYzPRnx+klRf/CPVj1Kv7Zw5+qzzTyTg5Nvh4ZFHU6
         Y2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTb/edku730zWmb4La0e/IBKyBWxviMzv8WRfNbIESg=;
        b=EH2KCdDtlYxxydwgVv4d2xqdU0XJhmm8jgMQNuEIwggLRz22WJcyzQyLG704eUTai6
         q+kF3pxq/WFzU0wXuwAmmJ/mCDx4Fa+ugDPo3tC/HWPVZjG1geOBXr5Bv/D/SVceyNX5
         SXQGeYhvG8GaiisjiFGXnOrfAA2bMpjJZdwepWBz7UbsdMgYZKeFpijOpa28md6ULxOw
         6tLoGHvqBYaPw6330oPl8em74G0i9OtLdBJe7BuwHuLSQqJ/eepUgxnBx7xjykLQ8bd0
         niwGTHnyZMHqjA8pxkpi2p8/iDRsaL8A0V82fIdJjCyvqp5sgxAJtcAcvksqVThXIrSb
         mlaA==
X-Gm-Message-State: APjAAAUjB/TIyHgke6bIA4wvjJS6vPW1sSuRolmn2tigLQftVHmn4bng
        0wlB0DZ3SmvW5IcDoV5gV/sDiW4Tq4TcSB2XB5UojA==
X-Google-Smtp-Source: APXvYqzXFw5g1ae1nG6aVj2CHosSTiQhdwX+vfkb9+07/jr20ZnfJFKyt6Cmx2k6Sb7yZYF7gAv+UOffRC5ZAvf9k8M=
X-Received: by 2002:ac8:25e7:: with SMTP id f36mr86336778qtf.139.1560832875911;
 Mon, 17 Jun 2019 21:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190614091039.32461-1-gqjiang@suse.com> <20190614091039.32461-2-gqjiang@suse.com>
 <CAPhsuW6eYaqxmHzHeu8UzXXx+DH-2FkEtQcWfvHp-YKTVe2U6Q@mail.gmail.com> <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com>
In-Reply-To: <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 17 Jun 2019 21:41:05 -0700
Message-ID: <CAPhsuW4YqH46jiSH9OEzUMf3rBCoJPa_=+ekVEi5s==sx=SWRQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] md/raid1: fix potential data inconsistency issue with
 write behind device
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jun 17, 2019 at 8:41 PM Guoqing Jiang <gqjiang@suse.com> wrote:
>

<snip>

> >> +};
> > Have we measured the performance overhead of this?
> > The linear search for every IO worries me.
>
>  From array's view, I think the performance will not be impacted,
> because write IO is complete
> after it reached all the non-writemostly devices.
>

Hmm... How about the cpu utilization rate? Have you got chance
to do some simple benchmarking?

Thanks,
Song

<snip>
