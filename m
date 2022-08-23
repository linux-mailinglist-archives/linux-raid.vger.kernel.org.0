Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1E59EC4A
	for <lists+linux-raid@lfdr.de>; Tue, 23 Aug 2022 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiHWT22 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Aug 2022 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiHWT2N (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Aug 2022 15:28:13 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B20BEEF2C
        for <linux-raid@vger.kernel.org>; Tue, 23 Aug 2022 11:15:38 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j5so16966656oih.6
        for <linux-raid@vger.kernel.org>; Tue, 23 Aug 2022 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=9K7K88FsF8kEbdkhom65oGNYjCLYbs6+n8/9saUSNLQ=;
        b=YonbyMFZtTtCbC+1zsmXeE4UMqMAnd1q2E2yfR06k4ejLcZlWwvVWpfAT5pVpPDiaS
         PSe7eZKCLiZwsP4/dOsyA/PUJPA4EXVcXYEfdKmYhTPwcmSC4cGyBuWPExZRfrbKr59z
         s94ctp68HWHdo27sJ8NgbeNLeMuFd2Pbf0sYd6wVZinkf9+meb2I3ixzEvKtc0hvEUK+
         ModwGHBOtVGI/eJpBMqHi3ic7J2A+7sIWigR7kHoRHjnTiKrMaDc26MnzUBPyUUSx4JJ
         chSzfOGbZIDlL45ZNaPHuAnVQydWcrjKOntUQz8Ha/f2RIUexdjrCVpbJ2jxmSF5Eh5W
         kI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=9K7K88FsF8kEbdkhom65oGNYjCLYbs6+n8/9saUSNLQ=;
        b=DxjQ8sOS8R4Fiq2O4bd4FdyvOsmmsqmpJmXQP52gWhWtoFZ/FCbbv+9YzoS+Ao1Cr4
         GbtNGrTgDZ3lQzy69LlLKQbRJCZ/gBD8MSEOXegkO82s7q9AYD6ciD92y7uSPtjf0bd3
         R2ojvZ+rJH32W9CJ81H8U3geKjEYOJNg7pqHNlrFXBJDsnd+FNFBDt/lcL068RqSjzkC
         RywaGMKju3V5ASYIYxw1S9ndJzuEMYL4iyxx1DI5ls1VLHFfvpiaWmaYU1BanmVuSrsQ
         FG8RfzqET6tg/0wie5lwAXJBQXkbA1ziQoiUbAvWiUx72m3y1eJuOroIi9kZU9n2a2El
         qP1Q==
X-Gm-Message-State: ACgBeo002JXZRF9UzUEUAHoljYJ0rCM9leycYAxCgHufoNcrCAg7SlGf
        0JhJEQUWnQ3mi3Eg5VYVrcR18ynv+tIjvuZzN1I=
X-Google-Smtp-Source: AA6agR7VJ0kv6VTSNAEyR9ldpSjuxqBcShQsKHcRrM9HUxTIQMcFCYl4ayZ4iZ2qqqgGXjAIzRcSzSIQh7AZNkhKMC0=
X-Received: by 2002:a05:6808:130a:b0:344:e23f:811b with SMTP id
 y10-20020a056808130a00b00344e23f811bmr1758301oiv.82.1661278508214; Tue, 23
 Aug 2022 11:15:08 -0700 (PDT)
MIME-Version: 1.0
Sender: davidscottman334@gmail.com
Received: by 2002:a05:6358:880b:b0:b5:9917:7822 with HTTP; Tue, 23 Aug 2022
 11:15:07 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Tue, 23 Aug 2022 21:15:07 +0300
X-Google-Sender-Auth: ApQygC0XgkOtpB-sxrTHlJ7ra-I
Message-ID: <CAB0r4CO1Duf6NF-QweDh7mdcze2DQU9SQ9udkv52jAXRjiv2wA@mail.gmail.com>
Subject: COVID-19 COMPENSATION FUNDS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,LOTTO_DEPT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT: $500,000.00 USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation funds.

You are receiving this correspondence because we have finally reached
a consensus with the UN, IRS, and IMF that your total fund worth
$500,000.00 USD of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$10,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $10,000 levy after you
have received your Covid-19 Compensation total sum of $500,000.00 USD.
We shall proceed with the payment of your bailout grant only if you
agree to the terms and conditions stated.

Contact Dr. Mustafa Ali for more information by email at: (
mustafaliali180@gmail.com ) Your consent in this regard would be
highly appreciated.

Regards,
Mr. Jimmy Moore.
Undersecretary-General United Nations
Office of Internal Oversight-UNIOS.
