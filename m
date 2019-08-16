Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0490B8F
	for <lists+linux-raid@lfdr.de>; Sat, 17 Aug 2019 01:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfHPXwZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 19:52:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42521 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfHPXwZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 16 Aug 2019 19:52:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id t12so7925375qtp.9
        for <linux-raid@vger.kernel.org>; Fri, 16 Aug 2019 16:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2XwPO2rxvHV4S6I229vVlykq/Gg7FuNYl4j7sq78W4=;
        b=PHe9giaPxcDNP63GqgYRXkjPUV5/ktGUY0k8kF0n3809m6cv8GHiu6Ua1ncxre0b16
         /PrwyvoJQOHYy50kachrvoHMfEtU+0RU9vMM2KyEWWcQ46g389EQhc4uDpdSWajdGWxv
         dkzmQ4A2q7Y1nshn2ErMqh0Z4eSaqkU00sKm7uRKMcBNlriURz+MhiZptSjruQw//c4U
         Og3IiWt303Iqyk3XdOXJKRQ4lzRArsyOTqaJac2Jh1mJb3u8g3tFubDLJOPXeOZhmkgr
         aS8dm9v/xl3QJdpN0S/OHOGdF7oqzB89NhCD9SNFsUB+Lh0A9l4XviINu8TcbEI84Kdt
         iVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2XwPO2rxvHV4S6I229vVlykq/Gg7FuNYl4j7sq78W4=;
        b=Kw6Z+mfIIumOXw7c/0SutyNJ71gno6dVjdg26C1Fy7FmqsKlpCP8D+TaS/zdi7i01z
         V8LTFo67slpxCG94oX2MVgXGv+YdWED0uZL8AppRQlmrdh4OrU0aBEIaLzGrExnpA3k8
         UHtSBYXc3T7xDBeFMfxG+Ob8IKiWHNxnPmZlTdaOcZ+2FpumdbgQWJrYIINIAxJ4uD1j
         nr4UAxru271YBSxcA4H84KbpuRynU0lZSnQykBAW2rJDOerMBTW27w1WS+lM3isZUnqx
         AYYl9smJsqndmbUg32OWFzcbcon5UNdHXQAM/9eGdRieB2LXg6yLk0S91IE9jN5pkrhr
         sR+A==
X-Gm-Message-State: APjAAAX1vtqVvKWK0Qn/k/4OC5GcuNyvccy33dUVvvH/MvGYx2MVx0bX
        kcz62Sqk3yBHPnGxshsAAik8iY6qtJ8+ErZMtqU=
X-Google-Smtp-Source: APXvYqyxmcjCNMCBuyeUZMiPXl0vVrjWAuvLRSzj+Yv3bLiLsIVL1Q+PtSEUBkiZQY21Jp7YV3Z5tdCnJUx78xvlrsc=
X-Received: by 2002:ac8:3258:: with SMTP id y24mr10937600qta.183.1565999544646;
 Fri, 16 Aug 2019 16:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190812153039.13604-1-ncroxon@redhat.com> <f79ead58-9feb-4b0b-5f29-fd1a4f10342f@redhat.com>
 <CAPhsuW5+vk4Ln84JSe-QEt-O2xee9d63B8aGEpxFLVfZWADEfA@mail.gmail.com>
 <875zmxj3cf.fsf@notabene.neil.brown.name> <9770f0c0-58a3-c283-02c0-25c0f94dc514@redhat.com>
In-Reply-To: <9770f0c0-58a3-c283-02c0-25c0f94dc514@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 16 Aug 2019 16:52:13 -0700
Message-ID: <CAPhsuW4T-ccC_kCycyuYENj2918aUDN9w6kt-eN_-K4761UTPQ@mail.gmail.com>
Subject: Re: [PATCH] raid5 improve too many read errors msg by adding limits
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     NeilBrown <neilb@suse.com>, Xiao Ni <xni@redhat.com>,
        Neil F Brown <nfbrown@suse.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Aug 16, 2019 at 10:02 AM Nigel Croxon <ncroxon@redhat.com> wrote:
>
[...]
> [  +0.000008] md/raid:md127: 793 read_errors, > 781 stripes
> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000018] md/raid:md127: 794 read_errors, > 781 stripes
> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000009] md/raid:md127: 795 read_errors, > 781 stripes
> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000008] md/raid:md127: 796 read_errors, > 781 stripes
> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000018] md/raid:md127: 797 read_errors, > 781 stripes
> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000008] md/raid:md127: 798 read_errors, > 781 stripes
> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000017] md/raid:md127: 799 read_errors, > 781 stripes
> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000008] md/raid:md127: 800 read_errors, > 781 stripes
> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000008] md/raid:md127: 801 read_errors, > 781 stripes
> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000021] md/raid:md127: 802 read_errors, > 781 stripes
> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000009] md/raid:md127: 803 read_errors, > 781 stripes
> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000009] md/raid:md127: 804 read_errors, > 781 stripes
> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.000008] md/raid:md127: 805 read_errors, > 781 stripes
> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
> [  +0.928614] md: md127: requested-resync interrupted.
>
This is a little too noisy. How about we only pr_warn() for
test_bit(Faulty) == 0?
(This is not directly related to this patch, but since we are at it).

Thanks,
Song
