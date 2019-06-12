Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2A4261D
	for <lists+linux-raid@lfdr.de>; Wed, 12 Jun 2019 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409121AbfFLMk4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Jun 2019 08:40:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46384 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409117AbfFLMk4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 12 Jun 2019 08:40:56 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hb2Yg-0006O2-E8
        for linux-raid@vger.kernel.org; Wed, 12 Jun 2019 12:40:54 +0000
Received: by mail-wr1-f69.google.com with SMTP id q2so7298757wrr.18
        for <linux-raid@vger.kernel.org>; Wed, 12 Jun 2019 05:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrK+5w6wVdk7h4HwgR7kIxMZIIwMUW/I2VBxJs4ejPI=;
        b=Q/6CcxcQfT0yyTveOMmSfgTUvV7D5cBPpe/vM/GXhJXDorXD4qpo+sITWW9i8L9YM7
         uqw2e+2id/nL5diL/Fwi3Rq52rq3lPLL8uInN7bMPOhVgIF+45bO8pfTlEGr5XgYKcJQ
         K2BBdTbLbQo8k24BqmBCaUI+l+cj9jTDIUKcVM7bDoPEsoPp6gpVB50qrFgkZrwF1cKk
         TkxIzN76pSPO6mdjUmQOM6kbsAC/A5lGiL/mIRMhSFFR59OvpljydrrRK5wMVQGfeCxy
         ejxoYhvO/HfoD/AtFRBi1P1aQ6nD4edRTQrAHRfqcEgN5wzeytL6b4oxDUxZ6V0D/OIE
         oY7Q==
X-Gm-Message-State: APjAAAVmct2pUrbadyHJJgARNkqstg9yWOMHkN9RZy36OB27GcfdJCFJ
        okKR3MIJe2qrch8UNoOobCFDQGsjYIC+sYSvf4sgD9xHx1dJZZrcHcZcc7J4b1z4PuO54FwcjvL
        QCig9jVNgXSfu5GWnpEYRzaPg+JsWjfJngu7fHYhPGX6UINOtcKh8N6I=
X-Received: by 2002:a5d:53d2:: with SMTP id a18mr4871537wrw.98.1560343253834;
        Wed, 12 Jun 2019 05:40:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBvfuiEuBGRitbfJWHXkAkAE1jkdz65wRyMFsexu514qahpb7YWU71NUv1iIYi0hX0WSYub+LVT8liks8ZR0A=
X-Received: by 2002:a5d:53d2:: with SMTP id a18mr4871531wrw.98.1560343253700;
 Wed, 12 Jun 2019 05:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190523172345.1861077-1-songliubraving@fb.com> <20190523172345.1861077-2-songliubraving@fb.com>
In-Reply-To: <20190523172345.1861077-2-songliubraving@fb.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Wed, 12 Jun 2019 09:40:17 -0300
Message-ID: <CAHD1Q_wraiFkLP72pFfGhON+KZe7yo3ktXvsAA40QVcXvzviSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] md/raid0: Do not bypass blocking queue entered for
 raid0 bios
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        sashal@kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Greg and Sasha, is there any news about these patches?
Just checked the stable branches 5.1.y and 5.0.y, they seem not merged.

If there's anything pending from my side, let me know.
Thanks in advance,


Guilherme
