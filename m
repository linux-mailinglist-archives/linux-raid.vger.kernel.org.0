Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790558519B
	for <lists+linux-raid@lfdr.de>; Wed,  7 Aug 2019 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388852AbfHGRE1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 7 Aug 2019 13:04:27 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:40408 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388488AbfHGRE1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 7 Aug 2019 13:04:27 -0400
Received: by mail-qt1-f179.google.com with SMTP id a15so89035881qtn.7
        for <linux-raid@vger.kernel.org>; Wed, 07 Aug 2019 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9NtSLATsyIJqcTdqa4EZw+KJZAgPINayxOPR2AmzZM=;
        b=MO6kxaGePnV+wVsh3GAN0pYcr6VbHiBQthDWc+8XjM/4vdk7/SRKj3lYhdY8x91Wou
         hZh2t9TvFF8tbTvhFv2SfMdT/SP6hcZl+T0inQZ7C6+o5WJW63cBiiYNznwpZjz35/+H
         ashfiNUkc2w0yzB1hKmOQJ/H8agHa+2UyoNhP4dsRgJQUXVz8i9Gj/BBxPMS4DrO8lLe
         koriSaiC9z8JblFSUVek+gc7oc6vLE2g2gqYbcjDdbr1Pd9o6ttV1oGPU44fc14eMJfN
         kT63ec5nu21rh/b8gQW4XWzNiOLh5k7JOmO05bnh6Hzng8f3TGYIP2X9Z3239NrlVL8p
         YzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9NtSLATsyIJqcTdqa4EZw+KJZAgPINayxOPR2AmzZM=;
        b=GWwTrQYsSDY/5vP0mdCN/zecSnCcboBa2htxQN+8XF++N2S4vZAwEN5udUVd2xUcA7
         35GZekdKJOV10BlccWp9KFcZ13cLkO1+KEhtEM15WidnCwhWk2L0CIEcCjz/6mi/x047
         bOfWsyvoa1frbgKWmQkI/9aSliLLD4qE6iRkN3KqLBQd1rA74Beb8fzOSABldsFvJgsP
         xuXS+K/cEkFFOzm0ockXLZ6fTQgRm1/gkxpCo0ebhObkEfQODmCrZiL6czGVn7hO3JrB
         eobn34sCEaSxw/pJzqwR+H/SEVlBf6ZKgPCyIfybmrG6acgcE/oFt7UewHaBMK+V5u6C
         SUMQ==
X-Gm-Message-State: APjAAAUFbJ23LoP7sNmbH+opIjN1xQaBUaH9tiiMg4RwymrG+fzW0b8z
        BlJhuQ+D7VyDZZvXEv2R2AdJAuzlon/TL3nprX0CJLfF
X-Google-Smtp-Source: APXvYqxbc6+3ZimbGFzaptOhLryokPAYKU9k5AEyKBfcxhE+gXCLf6GUKVIp+zBxx+nCcMgbhJ9cAN181WZTa60zJ8Y=
X-Received: by 2002:ac8:25e7:: with SMTP id f36mr9061688qtf.139.1565197466731;
 Wed, 07 Aug 2019 10:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <8006bdd5-55df-f5f6-9e2e-299a7fd1e64a@gmail.com>
 <019fb3fb-38e3-4080-2198-d5049a9cb46e@thelounge.net> <0658bed2-ebc1-5de1-c2fa-4beb8d488972@gmail.com>
In-Reply-To: <0658bed2-ebc1-5de1-c2fa-4beb8d488972@gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 7 Aug 2019 10:04:15 -0700
Message-ID: <CAPhsuW7f9pg6GLee5Mpp6Wjix8jSJmiUZazkMwuuU8-af44+nA@mail.gmail.com>
Subject: Re: Raid5 2 drive failure (and my spare failed too)
To:     Ryan Heath <gaauuool@gmail.com>
Cc:     Reindl Harald <h.reindl@thelounge.net>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Aug 5, 2019 at 6:33 PM Ryan Heath <gaauuool@gmail.com> wrote:
>
> So this is the approximately response I expected however I do want to
> pose a few additional queries:
>
> So if I read the output correctly it appears that /dev/sdb is the most
> recent drive to fail it does appear that it is only slightly out of sync
> with the rest four drives that are currently functioning, what is it
> exactly that keeps things from being forced back online?
>
> If as I suspect /dev/sdb was the last drive to fail... I have looked at
> it via smartctl and the drive still appears to be functional so wouldn't
> recreating be an option? I think this is the area which I was suspecting
> I might need guidance.

Yes, recreating is an option. But you need to be careful. Please consider
Andreas Klauer's suggestion on overlays:

Use overlays for experiments:

https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID#Making_the_harddisks_read-only_using_an_overlay_file

Overlays require working drives, so if your drives have partial failure,
ddrescue to new drives first!
