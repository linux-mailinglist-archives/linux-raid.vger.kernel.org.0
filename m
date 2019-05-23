Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58F428B8B
	for <lists+linux-raid@lfdr.de>; Thu, 23 May 2019 22:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbfEWUbb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 23 May 2019 16:31:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58853 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387544AbfEWUbb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 23 May 2019 16:31:31 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hTuN7-0007wB-3k
        for linux-raid@vger.kernel.org; Thu, 23 May 2019 20:31:29 +0000
Received: by mail-wr1-f70.google.com with SMTP id z15so698306wrv.21
        for <linux-raid@vger.kernel.org>; Thu, 23 May 2019 13:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dW+h03iOHL9hXzrG72krYhdVbEtg0vyFtbtFz1jJYI=;
        b=rR3+koV7RNim8wPYjHkPwUA4ZHWK5EwyVqTRmMniqquz44tRAnH3oNRbVnfcYKHijh
         N0K+Rug6yX/s7Tarcwglkm+Zsnhim8Y2QUXGbSFKBD+AzdxeUhDhw2IRlH7ndUwOS3bz
         iZU7lxfa4ZXW90/CJLabvXo2sCh5GX249qFPdhLw7eXQzincwq4wX6Vg/i5X5J3ECUZm
         m1DFW4VinpUyXSgEe5JD80WGbrRcRel/v8MLeOKmu6aQOvb3HLOTAiGoXAg4CxNrqVpX
         sze4kTVft6PZnaCtUsT4mnaN3ADQqBaLXchL3h3fGrcsPzDU71c/d0qKwx2lZae9TN00
         +dnw==
X-Gm-Message-State: APjAAAXcjZsUeAQ55rlG/6OQ7qoWncKcKsiLv56RyTNCqarOJ13onPyA
        0oa4MyIWCyHyQRy4AvdyBt/wXFwOap2Md437n7dUDid6ZTxdeMbvfh5x2w/FvjNXIZzAmmvnyyc
        syuXuGt43sTGUF3SDRlfVm5KrwG+RQQkQMWM6sWQbgg5z+H0M+BzYYgA=
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr12828723wmc.129.1558643488520;
        Thu, 23 May 2019 13:31:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzZrVtJmlEUBWpf3yRAcENU+Y5IToKvqA0uAnb6p0nV/TUnSml7P2OrLKKphRhi6bSed9/gBVCt8Ff7XZ2eEU=
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr12828709wmc.129.1558643488390;
 Thu, 23 May 2019 13:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220911.25192-1-gpiccoli@canonical.com>
 <CAPhsuW6KayaNR-0eFHpvPG-LVuPFL_1OFjvZpOcnapVFe2vC9Q@mail.gmail.com>
 <3e583b2d-742a-3238-69ed-7a2e6cce417b@canonical.com> <CAPhsuW7o9bj5DYnUDkCqDeW7NnfNTSBBWJC5_ZVxhoomDEEJcg@mail.gmail.com>
In-Reply-To: <CAPhsuW7o9bj5DYnUDkCqDeW7NnfNTSBBWJC5_ZVxhoomDEEJcg@mail.gmail.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Thu, 23 May 2019 17:30:52 -0300
Message-ID: <CAHD1Q_zCkmiDN24Njjr5Nfuc11hSxN5fgw98MX9j5LJoiwgXPA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] block: Fix a NULL pointer dereference in generic_make_request()
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        Jens Axboe <axboe@kernel.dk>,
        Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, May 23, 2019 at 2:06 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
>
> Sorry for the confusion and delay. I will send patches to stable@.
>
> Song


Hi Song, no problem at all! Thanks a lot for the clarification.
Cheers,


Guilherme
