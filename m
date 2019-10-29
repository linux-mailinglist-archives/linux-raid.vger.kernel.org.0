Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1691EE87B1
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 13:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfJ2MFR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 08:05:17 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:34032 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfJ2MFQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 29 Oct 2019 08:05:16 -0400
Received: by mail-oi1-f182.google.com with SMTP id l202so695239oig.1
        for <linux-raid@vger.kernel.org>; Tue, 29 Oct 2019 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4xsSpMCo7qBQ2wo+N5qQmU1NbY7oANVQ8scXyWAa2I=;
        b=mhFToE+M8IU9wZ9MjsLWRvg/gVTCPViMeh+loXKnv6C2y9rVxrm6Xmxag0tpKtiAdX
         TWsmcQezIUX7fxlFjUAuqXtav3MHvJaUs1p8L5oz+mnlT5p9n6e4KMP+OkrZ2mnbPPqe
         gNyRkL2gP64SISZMsLzqp2zFsvV0nPtQIOYZIEeKfr7AMlwHmA561YHlC+QPNz4iYfhI
         0fBvNBADLElw1S34YBmrcGFjFzKCbIRjTIjX+R5KYpBacLS577Tu6QfZZnxV8IKGb53u
         qlJg9tFQ1PrAzJpqoDeoCKOgOlSuRCxyCqhQVzQeTcVzuxGkLjNsYZ0jwpDxZUzqk6Gu
         SrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4xsSpMCo7qBQ2wo+N5qQmU1NbY7oANVQ8scXyWAa2I=;
        b=JGGLYUCC4ViAdqjIPJHOv7Ye6fqKnGppkM3hmX+2NsLkLCeQq9lPf2GxSP1zuGFmg9
         gR3o3q8SnknTiK+0l9SYPx/Uuf757IKj6dNRkJFQDsp7QR4K5SlsrkRVlMo9z2jTJf8/
         yUGCKxVLggwLOv22/rwJh21KG8Qlx4CJBiAuYK+nVYpuX2Jjy0zy5yOcdIUdXRWWCPs6
         c9uW4QQGDG/VpGkZ89PY+uprirfStcZlZeddjdTvRpJw4Nu8WkxzWrSQFeIQaSEDHPGw
         eJwJQd5sQo9SJyzQeLxO283abuRC9tvamCjk5NCT625VfeFe5iWf8Wxkwbr5JJyaShcW
         b5yg==
X-Gm-Message-State: APjAAAVYNz1lLQPYxlTcFsLGJHQPvVPH5qgv0DmHG++EpnnEofzVVdIA
        waZbOizlv8603fsv/uWwKZwiEeu4jHpIzo3nBpBaRHgXolY=
X-Google-Smtp-Source: APXvYqx9yoNnikM/Voe9eeErD3AJsyk24D/Y4gZLogleZeKfKHBRWWB8mFSXsaLr4Nm+8aWuPsLTpUedBdNw/n/8G+c=
X-Received: by 2002:aca:1b18:: with SMTP id b24mr3656303oib.15.1572350714547;
 Tue, 29 Oct 2019 05:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191028202732.GV15771@merlins.org> <eb24a24e-c268-0f3c-742a-5bde650c18dc@buttersideup.com>
In-Reply-To: <eb24a24e-c268-0f3c-742a-5bde650c18dc@buttersideup.com>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Tue, 29 Oct 2019 12:05:02 +0000
Message-ID: <CAHzMYBSAzB+rjixTx9DSgs48WOHkGybFGyGOEy3b7mtqnLHLgQ@mail.gmail.com>
Subject: Re: Cannot fix Current_Pending_Sector even after check and repair
To:     Tim Small <tim@buttersideup.com>
Cc:     Marc MERLIN <marc@merlins.org>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Oct 29, 2019 at 11:50 AM Tim Small <tim@buttersideup.com> wrote:

> I've seen this a few times.  Sometimes there is a pending sector, but
> it's not user-addressable, sometimes the firmware seems to get the count
> wrong.
>
Same, especially with WD drives, they appear to be false positives, if
you can take the disk offline a full disk write will usually get rid
of them.
