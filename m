Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B132412A
	for <lists+linux-raid@lfdr.de>; Mon, 20 May 2019 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbfETT0j (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 May 2019 15:26:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52972 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfETT0i (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 May 2019 15:26:38 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hSnvg-0003s5-9o
        for linux-raid@vger.kernel.org; Mon, 20 May 2019 19:26:36 +0000
Received: by mail-wr1-f71.google.com with SMTP id p3so7033129wrw.0
        for <linux-raid@vger.kernel.org>; Mon, 20 May 2019 12:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxbg0Zx+exe/5ojq2vGcbLz6N2dA2JR9VJrKe0f54rA=;
        b=tUZE55fkzMiFv5B5NmPYs721LR1QsgbhWolBlTusMketZAps5ez3KPO08J1pnVSVy0
         FO+tGoABnK1evhQe08/8A1n/4+qFruJohOjB/Vn2jviQI0E7DZ+c9TM5mO7PEKmRkUti
         UcutjdjTPiM0XJ/xmjOTIN8FmNDp4GEiJEbUAk5qQsCJtf2eW4Q/L4fmp75UR+2I1HSY
         muCUJO/JdhFWQpcKafG6j8hAKfBwerOyK0zrciQDcB/935TxSYF/LJkqmFoWVSvCnEj3
         cungsAHBeozNvrbiEgxL9SOS3ygjK/CzjqDkP7Lg0Rt1HcFR5kCQrusMB4ON86f1dmvi
         nLew==
X-Gm-Message-State: APjAAAW8606gkCUfmZNtdinnX0MABkyduju//ocbVTRKdkxeFy+LJK/w
        Z819J47dqfGBSQvwQjHSQmeLuorF/M4qmOsbB6ilU80cGZyxCV2si93/KJ/pkyN+GoNAHAiU6Q8
        QzH1BAgC7b37UrJ44wRRrDQqCfFVvSvwU/SQN0ata/oTPX8ntujm0QPY=
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr475700wmj.127.1558380396082;
        Mon, 20 May 2019 12:26:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxJweMgqMgBbY4mcMB78+O5hkcmDDdJ88xym5ZgH6LwviQZapg7tnDsKjXSPPGYbumV/l4HBVtseOW4pY1BAo=
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr475684wmj.127.1558380395603;
 Mon, 20 May 2019 12:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190430223722.20845-1-gpiccoli@canonical.com>
 <20190430223722.20845-2-gpiccoli@canonical.com> <CAPhsuW4SeUhNOJJkEf9wcLjbbc9qX0=C8zqbyCtC7Q8fdL91hw@mail.gmail.com>
 <c8721ba3-5d38-7906-5049-e2b16e967ecf@canonical.com> <CAPhsuW6ahmkUhCgns=9WHPXSvYefB0Gmr1oB7gdZiD86sKyHFg@mail.gmail.com>
 <5CD2A172.4010302@youngman.org.uk> <0ad36b2f-ec36-6930-b587-da0526613567@gpiccoli.net>
 <5CD3096B.4030302@youngman.org.uk> <CALJn8nOTCcOtFJ1SzZAuJxNuxzf2Tq7Yw34h1E5XE-mbn5CUbg@mail.gmail.com>
 <CAPhsuW7AwsWiHiqaW55paqtiCLvt3U9C+sQ50fbBr1v=czATyg@mail.gmail.com>
In-Reply-To: <CAPhsuW7AwsWiHiqaW55paqtiCLvt3U9C+sQ50fbBr1v=czATyg@mail.gmail.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 20 May 2019 16:25:59 -0300
Message-ID: <CAHD1Q_zYXvqAGT3shFx=GcfQ=ZV91LZGEEK1wXsOuBMhrrTyDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] md/raid0: Do not bypass blocking queue entered for
 raid0 bios
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Wols Lists <antlists@youngman.org.uk>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 20, 2019 at 1:24 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Fri, May 17, 2019 at 9:19 AM Guilherme G. Piccoli
>
> I will process it. It was delayed due to the merge window.
>
> Thanks,
> Song


Thank you Song! I'm ready to send a v2, just to match the v2 of patch
"1/2" of this series (but no
change in this one, except rebase to 5.2-rc1).

Cheers,

Guilherme
