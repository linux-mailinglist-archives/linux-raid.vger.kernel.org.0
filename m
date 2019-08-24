Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120209BEEC
	for <lists+linux-raid@lfdr.de>; Sat, 24 Aug 2019 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfHXRAZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 24 Aug 2019 13:00:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34397 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHXRAZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 24 Aug 2019 13:00:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id m10so10988567qkk.1
        for <linux-raid@vger.kernel.org>; Sat, 24 Aug 2019 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1rtUdMu8a64Mr7Fk6bobbdpKQQ+RjVeYijOLc32ds6Y=;
        b=r6V3Tr/TpKNIQZ4k00k+P70JPvriMT/9Pf8MhA+G78BisOX4MXgmUlR6DnTontjUtz
         GRdmp0TIBsw39cw+kBO+PtF3kGrop4kr4K+gId31TX7qPX8UtzADJvTy8L4AmEv4YQBW
         mCDixTg5EpFEshngojMsKynPT7/p7s8zCksDD0fI5huN0LkB4XWSRy98dscguvZnJLJf
         JR5lcudMKgAF4ci3kNlAGWsTWT3vc78FRNgrCbMnQJj6a7kYcmwV3RSUNkKKKxO0PDIa
         JOP+NNYTj97XjrTY2bkqOLZ67A8g2NkktrK1PpCHDKB/dAHqzXFTNGvaxo98V1X4iaQm
         ZpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1rtUdMu8a64Mr7Fk6bobbdpKQQ+RjVeYijOLc32ds6Y=;
        b=W2VIwn63lIkiUkiYh1Embv1IUlYWxfHJ2/ic4xMCLOZFrqfHUJnK7EtgdqRZZB5FI7
         kGGag+sbpMM8PuJWOhjcv12NJNV4LlMw493/4ja/EtkyU+bYvW+GP8qwrdyBxWyKNmEb
         f3B0ptBjwq9UJZU9Pglkkin+XrMZNfTORsRkY+pxRbqsUlGYAox3B+aeJgxzcSLybx1A
         L5PXoJS33XTdHri2Kxsy5OZz+0h3060zsz+5hUhkg5ZmRGWg//XW2wv1YM8UzzRXg+KD
         m5nxHSuHvRYNtrxCKuVWySsZYwIPfehrPGAAwzebl+MaqlugPpQ0M5eQpvdXOFlCYDgs
         FHmQ==
X-Gm-Message-State: APjAAAWK6AGna802CTGo5qH6lcf1nTFUB9uojmxDaX3hljuwkkKKD8s9
        nuRKhdk51g9R00fUMxe2dw13bbKZ
X-Google-Smtp-Source: APXvYqz+FLQqtJyZC5BK75J5ey5fk9zHL4WNFBCU8bi9ES5cY5LvwgGqmfqXjXh3eZk5QR6sCYsp0Q==
X-Received: by 2002:ae9:e00c:: with SMTP id m12mr9536692qkk.268.1566666023549;
        Sat, 24 Aug 2019 10:00:23 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::1041? ([2620:10d:c091:480::4f1])
        by smtp.gmail.com with ESMTPSA id 136sm3497762qkg.96.2019.08.24.10.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2019 10:00:22 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] md: update MAINTAINERS info
To:     NeilBrown <neilb@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <songliubraving@fb.com>, linux-raid@vger.kernel.org
References: <20190821184525.1459041-1-songliubraving@fb.com>
 <51398ca1-44de-3b80-6381-54f594b6c251@kernel.dk>
 <87h86aghmo.fsf@notabene.neil.brown.name>
Openpgp: preference=signencrypt
Autocrypt: addr=Jes.Sorensen@gmail.com; keydata=
 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 WQ==
Message-ID: <3f87b52c-70b5-99e4-dd51-716d1cfa33f4@gmail.com>
Date:   Sat, 24 Aug 2019 13:00:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87h86aghmo.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/21/19 8:37 PM, NeilBrown wrote:
> On Wed, Aug 21 2019, Jens Axboe wrote:
> 
>> On 8/21/19 12:45 PM, Song Liu wrote:
>>> I haven't been reviewing patches for md in the past few months. So I
>>     ^^^^^^^
>>
>> have?
>>
>>> guess I should just be the maintainer.
>>
>> I'm fine with it. Neil?
> 
> I'm very happy that Song has stepped up here.  He appears to be
> appropriately responsive and competent at review - neither too accepting
> or too dismissive.
> I support his request to officially be maintainer.

I agree, I think Song is doing a good job!

Jes
