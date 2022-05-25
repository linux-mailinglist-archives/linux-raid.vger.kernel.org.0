Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87584534515
	for <lists+linux-raid@lfdr.de>; Wed, 25 May 2022 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbiEYUkC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 25 May 2022 16:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiEYUjx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 25 May 2022 16:39:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91768B0D36
        for <linux-raid@vger.kernel.org>; Wed, 25 May 2022 13:39:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y13so43217112eje.2
        for <linux-raid@vger.kernel.org>; Wed, 25 May 2022 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LDBqQh/PztHeiDiV9Pr0v62BTTaDnPQyU98FGi1REkw=;
        b=V8ZoB3zlHdgZ2R2A4vgEAj70aKyCnGGpFtRZ9b0oTxUWZCuNT/gtyTwACRo1CCwI4R
         IK4Nm9PfwKHWvA3UrYMHrWxHVZx/Fd1WN7EUywQ1Bx9EGwE2G5w+zQhx2dxTEJx/Qhvx
         kZHC0CLj7Sf9TB4hKuFbYrHXEwFsp8ZlF2JEwj0d8Z6q0YaBJ7Gfmb4lwLJwI4EdSv4O
         UtqL/rx7DREYH1tyNT+z+VgaTm8jRy/Jx3K7Yn8LdMubX2Ahh10T0v0ikCTHCFRQ16rV
         PtrFcIYGMYWfojivKhNlerEa9N1T3tnRrDG9EOuK3KSgvDiYyowahaCPNsF4eF/kmTY3
         r85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LDBqQh/PztHeiDiV9Pr0v62BTTaDnPQyU98FGi1REkw=;
        b=RXnaIJ4umpoo/XETfX3L8w831AJTzwoEKjwrFdQzUbw3MKxJXJ7YfWX4wwU6E7/WsG
         wnImI/rgfvHC+P2d6tAlJ8ST1fxdIP9kUGKPb9YdWGJD1GJwH7/GqDbkCx8MSh2xubs0
         3ObKAHTwNDqd8YLhQGxIKqoz2Cp2yERNkTL0t7cCVBqhlUzoHBiFYlMipbk3kSv7Shr8
         zrGc9rmCYOzLMb7KVk/9K9MZ0YwS7Ee6iYQIAvr2XeR+39Vn66l74ll3U7xceCm0t+2c
         XP8N57EPWx6RgHZ0GJy2Z/PSo+uqR0Z6yuJjYz8lXq1LGKIncTpKQifSRV2IS6wdJ5A4
         ZGPg==
X-Gm-Message-State: AOAM532FHqmt2lnbmosbExG/I9FLmIc801/vEEwVoHs9vwy6v7gTHsDL
        FH6Zgq4aLZJE2MwfIY9RGPdRfP7XkSl6jUlbR54=
X-Google-Smtp-Source: ABdhPJwUsfb5OrQ3vcRS6HNq0+X7djtQ2eKtPHczM9HgH7+6P7FYocdSAR9l/DYJudx0gCT9N+SQNUs9NxBhx4GBA2I=
X-Received: by 2002:a17:906:8301:b0:6e4:896d:59b1 with SMTP id
 j1-20020a170906830100b006e4896d59b1mr29792721ejx.396.1653511190094; Wed, 25
 May 2022 13:39:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:16a0:0:0:0:0 with HTTP; Wed, 25 May 2022 13:39:49
 -0700 (PDT)
From:   Deterin Falcao <falcaodeterin@gmail.com>
Date:   Wed, 25 May 2022 22:39:49 +0200
Message-ID: <CABCO4Z34L5Ob2sRJ+JwD5j-Hmd-m2wJ6TEysrc=k65vmAnA3cw@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Falcao Deterin

falcaodeterin@gmail.com








----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Falcao Deterin

falcaodeterin@gmail.com
