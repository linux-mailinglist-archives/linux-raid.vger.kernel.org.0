Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047307B3EEE
	for <lists+linux-raid@lfdr.de>; Sat, 30 Sep 2023 10:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjI3IFL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 30 Sep 2023 04:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjI3IFK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 30 Sep 2023 04:05:10 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC9E6
        for <linux-raid@vger.kernel.org>; Sat, 30 Sep 2023 01:05:08 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so3847293a12.0
        for <linux-raid@vger.kernel.org>; Sat, 30 Sep 2023 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696061107; x=1696665907; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQmcG0PhXG0UkauFZ2tR7iCsRk7FCdRiSqPhAfmvbuo=;
        b=mbCTseysw8GgZKJs7PSui6McDux9lcc8lK5rbX4T2k7TawfepDAEjHJjLTUcQij3Xe
         jP8BoURML7b0lo1IFAYFvn0sJSgMxsB8RPmzQsDUKdVHX69mQzH6PvYp4aP4auleQPJA
         R9+7qkgkeOOYZ4p2iJcUT6BSRhvpyuuZIu+aaXYD/aW05a36fn9WnxaJXf9baag35ZaD
         o3bpuRN+b4BcB0NYLodCR8/oBwyqs8jsJvAsw1BEOFQtz0peRBwzfH/SlgLDrU5PqSA0
         EGSAz3UTwvOyOna2ydUpI1U58S1oxEt585UYz3q8gZTFxF31MU+4ZaujeSRfHxUcghQk
         /HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696061107; x=1696665907;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQmcG0PhXG0UkauFZ2tR7iCsRk7FCdRiSqPhAfmvbuo=;
        b=RQG4xyYGiPNcAoPH/MK77wuBNvSGMapMCs2hByZR74cSZ5P2om91foELQq7vKhtXCg
         C2KUP4aq1969BDxI+FCC7TafplfUH8gh27yWzr3+T7/NsgcDV37K3roEHJXJwEkxuBt7
         3FIqEV9+WMmbkXkmjr+hVLkphK14Pr0cF7cUCvdeZAcjwUoiR7uP/JzGXHtoWLapx4Ca
         yWMc8dCI8lpZ5k4WYb5av8q4/bS8bGfWzBZsEBHj8CvSoCpTR9beucNhk/YgnDfC2JUa
         SxeZDixuLc5NZOR7zIGm4mSIeDOdn0LL1DfkYfvoPtJJqkTP4XHgTBYhYuHfUrb7Ex2c
         Bm4Q==
X-Gm-Message-State: AOJu0Yw6zaICiwCVKxTfoD7QbaLA1vyYUeH8CHbPsgVFj8nBGA1aROt1
        z/djyIcGf8SKM+Q0FHrsE4tm70uABsKyTHZpGwU=
X-Google-Smtp-Source: AGHT+IERKUuERGPdAG9R0mKALVVrheMxMY4N3c1bZFXBta2rJVSJ3rbydw35/DM9QJAUFf72UepVY0/YshwbkW68x1U=
X-Received: by 2002:a17:907:788d:b0:9b2:717a:c0ec with SMTP id
 ku13-20020a170907788d00b009b2717ac0ecmr5966220ejc.69.1696061106482; Sat, 30
 Sep 2023 01:05:06 -0700 (PDT)
MIME-Version: 1.0
Sender: justicethomson1@gmail.com
Received: by 2002:a05:6f02:c252:b0:5b:e7cf:1540 with HTTP; Sat, 30 Sep 2023
 01:05:05 -0700 (PDT)
From:   "Dr. Thomsom Jack." <jackthomsom7@gmail.com>
Date:   Sat, 30 Sep 2023 10:05:05 +0200
X-Google-Sender-Auth: bP0TTnKqM4BPV4jbq6rOJX9omlw
Message-ID: <CAH0Xq2+AgBZBNYyxGw6c+aTu-jtjTpnzphPJDgHCXBkNeMJEhA@mail.gmail.com>
Subject: : Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Good Day,

I have a good news for you.Please contact me for more details. Sorry
if
you received this letter in your spam, Due to recent connection error
here in my country.a

Looking forward for your immediate response to me through my private

e-mail id: (jackthomsom7@gmail.com)


Best Regards,

Regards,
Dr. Thomsom Jack.
My Telephone number
+226-67 -44 - 42- 36
