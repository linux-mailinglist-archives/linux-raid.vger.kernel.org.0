Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F202CBB6
	for <lists+linux-raid@lfdr.de>; Tue, 28 May 2019 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfE1QVQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 May 2019 12:21:16 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:39494 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE1QVQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 May 2019 12:21:16 -0400
Received: by mail-qk1-f179.google.com with SMTP id i125so21372690qkd.6
        for <linux-raid@vger.kernel.org>; Tue, 28 May 2019 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTfcynAZde8cTgOQBtzaA3BOumVYeSQfSfF64fLGRoU=;
        b=bo5bWdaeoj4H39qib9u5e5ifzhQQRhJm5wD1IFkwNDpCBJmSVSLoMsjn9SbQ+eiqnh
         KLC+jpFXwPq19lc35iIeLL9wJqNydu/UhAKLG7+S/eD3FfUqcVdQjZzj1H+Gd8I75EN4
         5A0OPOAg2jjKgUXJzSvahpfuT+q8qTPIUmz+I/mbZHExULyX7QsGDT+wyOok1bn3vAeX
         eu4m1k2qhp8fJR9G4FFN4R/35e+CbObqD3E90UbtGdQBBNuO5/mOUUCiextYDPB5EWoA
         p7TkQZ3PoS0+rtNZtlhpjxrgtvbjypZC2A6rewfwrI44/2iQUF9eAZB0Jz2bkO70JFb5
         aL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTfcynAZde8cTgOQBtzaA3BOumVYeSQfSfF64fLGRoU=;
        b=eiyGqBq0O+mckx5NxoQbGDp5jpEuGpQJm7FPszHIB98C8olT03WidLP1rWwoRnfY5y
         nXu6iQC3TFd/5waP1KcXmtL6moq/e+uhj1SM/oDMuWEWANJV2xaxbpS4siIcTgS75+X2
         5WJrhBrNMrG3zV/QnU7Pz8kuobmZ5DMSSwe6AOmM69q2ecFKaTIXU6lS2+KmLNZ1gBeQ
         4MhdU14Zng0w7QV6gZi3IP89KSAMyo2blyipHaA+0NxaD6xbN8ay4tEYGLL/q2157h1d
         uQRvVlT06h4SYNA/1uZpaISXgSU0+6US9gBdpwsdA0rJ3Jv/geu/0V5jPoeNUhjffXAx
         bhaQ==
X-Gm-Message-State: APjAAAW5KgSsqBetzGd83CW+/OhLiLwGrXyuQ66tzCgupot0Sqty3UfO
        wzQv3mqtujblQafLc06hCzt2rAtD1Cv83U5g1iODKErT
X-Google-Smtp-Source: APXvYqxZKJDSidKyaKHm5/6HeWVh83kfqhQ4GoX/ZCIBNshwWcXvdsFbt3VlmpJEC8XWU8g1zxMpbk84Egjb/vQWK0U=
X-Received: by 2002:a05:620a:12f8:: with SMTP id f24mr7763303qkl.202.1559060475122;
 Tue, 28 May 2019 09:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <3a28d64f-9f13-277a-a8f9-3cdf87034200@moore.sydney>
In-Reply-To: <3a28d64f-9f13-277a-a8f9-3cdf87034200@moore.sydney>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 28 May 2019 09:21:03 -0700
Message-ID: <CAPhsuW5ngOxnddZp37nKe0KtsRTYxi-N1O2ARUqBbHbYJ=ASSg@mail.gmail.com>
Subject: Re: Optimising raid on 4k devices
To:     Matthew Moore <matthew@moore.sydney>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, May 26, 2019 at 2:27 AM Matthew Moore <matthew@moore.sydney> wrote:
>
> Hi all,
>
> I'm setting up a RAID6 array on 8 * 8TB drives, which are obviously
> using 4k sectors.  The high-level view is XFS-on-LUKS-on-mdraid6.

Are these driver 4kB native or 512e?

For 4kB native, you don't need to do anything.

For 512e, just make sure NOT to create RAID on top of non-4kB-aligned
partitions.

Thanks,
Song

>
> I've traditionally used partitions appropriately aligned to 4k sectors,
> however my understanding is that modern utilities properly recognise and
> align to the underlying disk structure.
>
> Can I simply create the array on top of the physical disks, do I need to
> tell mdadm to offset/align, or do I need to continue to use partitions
> on the physical disks to get the best performance from this setup?
>
> Many thanks in advance.
>
