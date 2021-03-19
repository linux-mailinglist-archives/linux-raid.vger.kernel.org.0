Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7DA342918
	for <lists+linux-raid@lfdr.de>; Sat, 20 Mar 2021 00:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCSXQi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Mar 2021 19:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhCSXQV (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 19 Mar 2021 19:16:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32D3E6198C
        for <linux-raid@vger.kernel.org>; Fri, 19 Mar 2021 23:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616195781;
        bh=bDlEZevEAxmzo0071y2Tah9AQ1bO6uiPNg3nUuRFzCI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FG4BxVuj69zyPGSLI6eFfYsG+bimDsC6USd9voYNhOEfUuBWRuRhuvQr9a9jYOh1k
         DLenPJfhj3RLbMzB7MgAYZVQbpCiCnpq/vq139Ey8qVhnqUoSMAhCkjeRUAFj6ez/1
         b4SybzZ8Ohg03mvOZoOEGvOO9oWD7w+MFY+dvUCG6HESIkroNMlU9o/lh1zdoOS/aw
         lSPQp5UiXS2xS1HObJqTIFkU5uO7CljQsiARTb3UQFwnAv5AMVewt8UIITxo9CDpF6
         Sq0jhbJq3OIx6QOYkLau5q+PjYavq8VmueZ4LS4ZwCavO6Cih2JLhl5ktSrVh+s/uS
         LsjrNpuePc/Og==
Received: by mail-lj1-f177.google.com with SMTP id z8so13837993ljm.12
        for <linux-raid@vger.kernel.org>; Fri, 19 Mar 2021 16:16:21 -0700 (PDT)
X-Gm-Message-State: AOAM533LqA3KQ2nsO6eNiDyE1lDr0EMt4n43myhwnjdVpYN42rNw3sCR
        9pJ3KoRQQUioYkIFBzb5Y7A9EosdJT3fWFpQGEA=
X-Google-Smtp-Source: ABdhPJwzc2OZlw+6t5h6ucnY4HOXl7jFJIimPB/Kq8KqrQjnHCfCCYOCQ6wsc0lF3z3ugCtZJtYK1Mt/4YJSbqapcK0=
X-Received: by 2002:a05:651c:200b:: with SMTP id s11mr2172765ljo.177.1616195779532;
 Fri, 19 Mar 2021 16:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <DAEB6C2F-3AE0-4EBE-8775-7C6292F8749A@snapdragon.cc>
In-Reply-To: <DAEB6C2F-3AE0-4EBE-8775-7C6292F8749A@snapdragon.cc>
From:   Song Liu <song@kernel.org>
Date:   Fri, 19 Mar 2021 16:16:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4=XoyQV_HNVnFnMWS2PvvU1+Rtbh9SJB-FQTO3haa3ig@mail.gmail.com>
Message-ID: <CAPhsuW4=XoyQV_HNVnFnMWS2PvvU1+Rtbh9SJB-FQTO3haa3ig@mail.gmail.com>
Subject: Re: [PATCH] md: warn about using another MD array as write journal
To:     Manuel Riel <manu@snapdragon.cc>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>,
        Vojtech Myslivec <vojtech@xmyslivec.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Mar 16, 2021 at 9:39 PM Manuel Riel <manu@snapdragon.cc> wrote:
>
> To follow up on a previous discussion[1] about stuck RAIDs, I'd like to propose adding a warning
> about this to the relevant docs. Specifically users shouldn't add other MD arrays as journal device.
>
> Ideally mdadm would check for this, but having it in the docs is useful too.
>
> 1: https://lore.kernel.org/linux-btrfs/d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz/
>
> ---
>
> diff --git a/Documentation/driver-api/md/raid5-cache.rst b/Documentation/driver-api/md/raid5-cache.rst
> index d7a15f44a..128044018 100644
> --- a/Documentation/driver-api/md/raid5-cache.rst
> +++ b/Documentation/driver-api/md/raid5-cache.rst
> @@ -17,7 +17,10 @@ And switch it back to write-through mode by::
>         echo "write-through" > /sys/block/md0/md/journal_mode
>
>  In both modes, all writes to the array will hit cache disk first. This means
> -the cache disk must be fast and sustainable.
> +the cache disk must be fast and sustainable. The cache disk also can't be
> +another MD RAID array, since such a nested setup can cause problems when
> +assembling an array or lead to the primary array getting stuck during
> +operation.

Sorry for being late on this issue.

Manuel and Vojtech, are we confident that this issue only happens when we use
another md array as the journal device?

Thanks,
Song

>
>  write-through mode
>  ==================
