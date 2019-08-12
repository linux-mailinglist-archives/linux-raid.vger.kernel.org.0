Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5399B8A825
	for <lists+linux-raid@lfdr.de>; Mon, 12 Aug 2019 22:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfHLUKO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 12 Aug 2019 16:10:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41533 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfHLUKO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 12 Aug 2019 16:10:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so25187901qtj.8
        for <linux-raid@vger.kernel.org>; Mon, 12 Aug 2019 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7dfKaWW4Pz72U0iWiExuHBPoVpMTqKcxDigJBweNJd8=;
        b=oSsnoCTenXSBMvVBBC6lgCp3fLHo3bNeHVgoC7ksHwHZ161DbY3Siqfm0rSvY0AZiF
         g+zSvWlrzKsCePtuflCWDKKQZtpjhcIKZuYc0yEw5YukauRjG+4sqVT//wpYQMbw1L1O
         NJSjuxHq43vnxsO2GHnCeGgRgikwkO4pl4DX0NoO4/9eClyciVMwjBPmlQyydWDJqwBr
         5PsxcHyjP3Ohyu//Ujvop4zm5sKdEWkF95vW9CFtP7ytDfEcJsoXC2Np1KHo2Rc/DJEC
         BqpprEBLEk42VyZ9EfEuOIx2Gwbex6uF8tRDj4A9MKsd3Y+7GKzfi5537gTqOSsEFdqe
         O9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7dfKaWW4Pz72U0iWiExuHBPoVpMTqKcxDigJBweNJd8=;
        b=OujPv6EA/xMmz/Hh6KgxJJlgpRS7QmUSuQQF6lHCqFZuVlROD4P5Dz5CyUw1U29ZkD
         mxMYy+spXXLARGqdFn81iLGOebmfDW05YiuRviZGhIHx3y6YLGr8/Mj21G7VyFhogzEJ
         +q70BBcD2JSlYpl+nKo0eqU4X7O1eL5yPa+3kixGECTAdDoolblXzgcHUQw2K7ghZ+CN
         iZePre/A702hhhifsv1eShkShqs+6KOOcVBIoSqsYtqirbO4urgheAQr1zZTj10x43zQ
         T7QLdtlef1HmUYrNNv3G1A1Nr2HtAwx8PI3FXZBVGGUFhNHHtHbcBbkxgTaWXTzYrFeR
         O9MA==
X-Gm-Message-State: APjAAAWTa7z/bXKZ/k0vltL+LNy2EynK+N6uF0tBFL4D8qLY9cvUBqNX
        s3O5/dPy1YeU1yk0GiRzawMF2N4O
X-Google-Smtp-Source: APXvYqxzQiIpqlNammtEsvomepmlNpTmoZXHzMcx6Ex7B4ZvkIoZTH7LAGfLOSv3YLzEdiPryIOZrg==
X-Received: by 2002:a0c:a8d1:: with SMTP id h17mr31426013qvc.117.1565640612726;
        Mon, 12 Aug 2019 13:10:12 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1085? ([2620:10d:c091:480::d0c4])
        by smtp.gmail.com with ESMTPSA id u126sm47382927qkf.132.2019.08.12.13.10.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 13:10:12 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] mdadm.h: include sysmacros.h unconditionally
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-raid@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
References: <6c781ad75d92c6f65832810c44afcba1b2dffc41.1565096723.git.baruch@tkos.co.il>
Message-ID: <a729bd46-e16f-1aa5-8449-3bebc84d0fa6@gmail.com>
Date:   Mon, 12 Aug 2019 16:10:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6c781ad75d92c6f65832810c44afcba1b2dffc41.1565096723.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/6/19 9:05 AM, Baruch Siach wrote:
> musl libc now also requires sys/sysmacros.h for the major/minor macros.
> All supported libc implementations carry sys/sysmacros.h, including
> diet-libc, klibc, and uclibc-ng.
> 
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  mdadm.h | 2 --
>  1 file changed, 2 deletions(-)

Applied!

Thanks
Jes

