Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0854A1251A7
	for <lists+linux-raid@lfdr.de>; Wed, 18 Dec 2019 20:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfLRTQD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 18 Dec 2019 14:16:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43819 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfLRTQD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 18 Dec 2019 14:16:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so2499356qke.10
        for <linux-raid@vger.kernel.org>; Wed, 18 Dec 2019 11:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGsMC2EUOxJMrTy1juHn/7HEpPLwN0yUA3w9hbJYPJ0=;
        b=V3jxU4tNP1OZUgkTpauo+0r9hrYWv7rZJHXbxNgi0HbmrVfjaer5O8rztQth46XP5X
         CJkRUJtsgFdvLLMCdkt21WcFUR14JESd1wkkkLZXijAZ3IPPBvN01ppCqEB9mlg4nNif
         Rt7+TKxw6u7iCewAwFZebaKXCygkuWZCcyTfH5B7lrlpso00gOCaPr8CPsguzGSb/L2J
         ueuu42bJhkAQwmv3YgFgoMDBGjHgzsM1DxinlIDf2y0lxvu2uMLbRtEkWc6A8C/j8geN
         BEoG7smEOtTID1QCKtraGGRq7AN9Vs8qlJ03DkjIdC6WA0cambgct8PyA4im2CzxB5Jb
         iB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGsMC2EUOxJMrTy1juHn/7HEpPLwN0yUA3w9hbJYPJ0=;
        b=BMRuCsZ+QoSehq+RNSSbt/L3xVSTC11JslabkI7sMK0kG2KVqFeApH/MD1U6qG0bhq
         mAtd1vHPrBJjOPB5oMf5MfNphNh0dQBx0Xwh3SaBrsRrn+MqvmvocbEkzGJ1wukOb+oP
         8nV7DWf1YvtD7z/3f9bVu+VsdARvYJ+IVxJMhnaIy4st5bqi7rnBcR//hTG2/2vh0rDJ
         uL1PigmO9U/Fq5/Yp3sKmLiWkRlrM9Vk6majrFFkW2RO4Z+NGfaG1wa0SPLQOxOkUnyH
         nUde/rWPYenqTPCwSebYoLFEAuVUgnEOacW5m3HSK1MXv+CJw46DBtuINgMUWkeCZ/sw
         5/VA==
X-Gm-Message-State: APjAAAW7SDqaG+sjnvR7hbYxU800mZqTpAzkD2XPI2phy+sMPcuN6WRn
        hEDecTpY/6rXBzicm+of9ScWEp38lRrfzsaK6FGOyw==
X-Google-Smtp-Source: APXvYqzAgNkIzr4DUiptSbiBf53uCkRRXAUS9VPCJDJHjJvRB8kkm8Thdo/CdUCPM5QMcRN33X2rsyhvu0U4Og2wDUw=
X-Received: by 2002:a37:8b85:: with SMTP id n127mr4363527qkd.353.1576696562096;
 Wed, 18 Dec 2019 11:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com> <20191121103728.18919-8-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191121103728.18919-8-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 18 Dec 2019 11:15:51 -0800
Message-ID: <CAPhsuW6e451GhHaTXt8_o=PeV4WGeBKKjn0qvG+tq213SXTr5g@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] md: introduce a new struct for IO serialization
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Nov 21, 2019 at 2:37 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> Obviously, IO serialization could cause the degradation of
> performance a lot. In order to reduce the degradation, so a
> rb interval tree is added in raid1 to speed up the check of
> collision.

Could you please share some performance measurement with and
without the new data structure?

Otherwise, the set looks good to me.

Thanks,
Song
