Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C414776788A
	for <lists+linux-raid@lfdr.de>; Sat, 29 Jul 2023 00:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjG1Wji (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 28 Jul 2023 18:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG1Wjh (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 28 Jul 2023 18:39:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C595E35A5
        for <linux-raid@vger.kernel.org>; Fri, 28 Jul 2023 15:39:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so48537271fa.0
        for <linux-raid@vger.kernel.org>; Fri, 28 Jul 2023 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690583975; x=1691188775;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=oQREvopisJpG53vYDPvoziSP/6qS9mBhHifQBE401K2wwspcTP56TNyl6YT1xP6PJu
         xnIDdhPxWSdstco3mLrioy4zOYvvMQNeC8Zas+2SWPgh61znfbKj0WYRcYV8S8TycyiS
         mcdOoSC3P6eEK8pIalVbotk06iZ8xMsYFkNK7sE8+OZkcprb9KcXhCx69V7nVsCMFs/q
         TQYaXzga4mKjAuAWVcTv56lrWRwIf0ELlw8osbvVDAY+MHBu5/PmF5d4L6k+oE+9HaAu
         W40OmJ7FT7cCVD78qW22MXFqF6VlsY4SVCSKbiKr8XpzHbYCdxTepVj5FscSp9rqq5sb
         V0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690583975; x=1691188775;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=gfXRpEHfLOPkunp1KXO1YuT98RwVJgjPupaHMb4znsYiGgVVzRWVLS01N0UAZq1qrn
         mQKaMaMM/+plGHUBfHHnUIjX0w5B7K5LGeLaZIlGeRvQLVpRan9LG/euvolx/2/UCICl
         KEd/Zqbskl538dtqv8Fi4S6e+TFUxlqnEVjKuuO0ydHpEAMLTB0lP2JTD5sdAJBDuJrs
         rX0ZwKRzGBwwgnoujcG8n8oKzrV4jcAz5eR817DkX1qKQ6kDuTvCINMEwb3GG1PeJBvy
         WpToujjN+9WeB844RQVYaiNDVJtM/bMaUmtmgi66vzL9Z/rSJDKr+JgRQzgzKgKzvrv8
         M8jA==
X-Gm-Message-State: ABy/qLZ4xinwwjDEj2lE+r6X9QP/tmW8vwpIn8SOHuhHuF2ixHzAqtYa
        rLt4XRpR+kg+0DfyNTS5UtpOATa27OzZ0xiPFME=
X-Google-Smtp-Source: APBJJlHKFTW7z6ld1GmZpNSkt41n+yMq9MEdxUndW12fmh2uz+qqAMfy8gvQS7prGIhhh6qVYEIyhkhZ40MDUQyjmzk=
X-Received: by 2002:a2e:a4c6:0:b0:2b6:fdae:903a with SMTP id
 p6-20020a2ea4c6000000b002b6fdae903amr2362478ljm.5.1690583974790; Fri, 28 Jul
 2023 15:39:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9606:0:b0:2b9:bb2c:a8e7 with HTTP; Fri, 28 Jul 2023
 15:39:34 -0700 (PDT)
Reply-To: berlarbimalik@gmail.com
From:   Malik Berlarbi <malikbarlarbiabranch@gmail.com>
Date:   Fri, 28 Jul 2023 22:39:34 +0000
Message-ID: <CAOeGtAJoGjp9OPAoNAU0tHxz0mwRYhUoJHz2RBaiMPTuLuuKyQ@mail.gmail.com>
Subject: =?UTF-8?Q?Jeg_sikrede_udenlandsk_hjemsendelse_af_pengeoverf=C3=B8r?=
        =?UTF-8?Q?selsforretninger=2E_Kan_du_modtage_kontanter=3F_eller_bankoverf?=
        =?UTF-8?Q?=C3=B8rsel=3F_Mit_navn_er_Berlarbi_Malik_fra_Impact_Investment_Fir?=
        =?UTF-8?Q?m_filial_Ghana=2E_hold_mig_opdateret_for_detaljer_om_overf=C3=B8rs?=
        =?UTF-8?Q?elsprocessen=2E_B=2E_Malik?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:232 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [malikbarlarbiabranch[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


