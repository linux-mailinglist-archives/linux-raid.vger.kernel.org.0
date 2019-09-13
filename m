Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803F6B2683
	for <lists+linux-raid@lfdr.de>; Fri, 13 Sep 2019 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389353AbfIMUPh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Sep 2019 16:15:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42578 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388982AbfIMUPh (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 13 Sep 2019 16:15:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id f16so3141755qkl.9
        for <linux-raid@vger.kernel.org>; Fri, 13 Sep 2019 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hA8BKUjJ9dRDFqpnH636WrEyvGjQOYFndEVFE8VCQNo=;
        b=hiXQNYmvucb53sNEXSVm8GYji0MbbhBFpb5DvuoDIsTmMtxE5IssYbv0x1Ihyq7NzF
         Zirhn0IxiCHRiopNkkI1x+EKHy6YXBrc+PJGBVgLl/YOLfHbfj+lFgTVqpjZPbqhyuVO
         M5bd46SlZABNWQPJBwqItaLI6kArjfU4Kx4JQmlNVkIPZYI1xKn/cEt6P9KGGLW6OGaA
         pTynHvjFnW13xVGT5JZoGq3tSCtlZbEdFuuA5/1QJNBALf1EuVzxkgfwgV9QrIeuZVOW
         apNQ8pX8pGzy+osEeNKAVyrDlMUs37V4dgm6ub7RyyBxNVE8b+OMNNPLNJrYdaE3obda
         mOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hA8BKUjJ9dRDFqpnH636WrEyvGjQOYFndEVFE8VCQNo=;
        b=mwrvXii0dmj4DXwJWkYK5n4KT9+7NitZWmTu5g8ZSmxHLuyvaMJzaRhstUNZ+YswJT
         iN3YVfXbfi4J9AAO57eKOPmua3/HC72MUTzsIb7iuUWScTWe814VRqkAaTWVZQzP/BSP
         oWQQU2HTK8NE5NymfmH2vR7rLlDwjntMg38e8BWdq3eRO0mb1UV+jK9a4CSJ5igGSzjH
         57tlJIbsoDgW0xt0fu9NWGr8+oB2hOzo44Uf15qODcw/Z0eVHAZ4CfeyKtaZl+7RaICH
         b8rPBrH3yilp/9JsPCp2u1Wc3ARr9+OdskPsElZZTc3DEAyVgFevECXtMZpJONPnkBdc
         fqiA==
X-Gm-Message-State: APjAAAUapMpfQVfNqT6rGh0vmX+O5B3RJPNK6FeHCxB5iZbn7UGCXqGd
        nVbSu2S0Khb7E3aoszotXIhhxUwHrAm/vWkJeAA=
X-Google-Smtp-Source: APXvYqy4AgMhGgLj8FkH7KfNqAdJqTM8wpn4CMEGU4q2BJy/8CJTNAscFWSb3ZRV+P/t7LJ+JKZZOcw501Jkdp/K4ZE=
X-Received: by 2002:a37:4c9:: with SMTP id 192mr50666413qke.177.1568405736564;
 Fri, 13 Sep 2019 13:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190912101016.3700-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20190912101016.3700-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 13 Sep 2019 21:15:25 +0100
Message-ID: <CAPhsuW7bBfQKL3ouiAMrDDCv4-ZvnZcvqHxg6eTjZeSunfDJFw@mail.gmail.com>
Subject: Re: [PATCH 0/2] two trivial cleanup for raid5
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Sep 12, 2019 at 11:11 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> Hi,
>
> The first remove the flag which is not used anymore.
> The second uses bio_end_sector to get the end sector.
>
> Thanks,
> Guoqing

Applied. Thanks for the cleanup.
