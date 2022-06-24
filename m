Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C2D559A81
	for <lists+linux-raid@lfdr.de>; Fri, 24 Jun 2022 15:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiFXNi4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 Jun 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXNiz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 Jun 2022 09:38:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF50811157
        for <linux-raid@vger.kernel.org>; Fri, 24 Jun 2022 06:38:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e40so3545228eda.2
        for <linux-raid@vger.kernel.org>; Fri, 24 Jun 2022 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=PbHHGzXHXs/62jL0Vm6V4tlSbNcUpgOnXAgvNg6LZS8=;
        b=pmO+VYS6yvRIk/q7qMteNcD94ivF3WCIqHwMMOjcWuKi2ssv5cDaAN/gu73uOGa+cd
         scNTnmNIFWVaTdghGcmixMSLnQXzqcPvm6k7rkzj0oxiu1dWRpmaVFvt1MOVsSjsHmIp
         7QcxL4kB3E1z0NwLZc6t3QNv9JL4TXvDATg/9hkjNR9E4WW34grqHJ1zIjv6MklPUWqb
         2DYjZpRbgfSGYk+j86jsUhYoq1lmEqiL2MGqs1F2mc0/AX04dqbQUu3KjA0XNQ6sJaWI
         I/Q1HrGeWDPTWrK8zFXV5AXSH+nyGf45VwxUpOY5Pbpkr4s3UV4MKDlWvPIWNjFTX4d4
         tWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PbHHGzXHXs/62jL0Vm6V4tlSbNcUpgOnXAgvNg6LZS8=;
        b=DbLNBb6qsLlBnuNYIPiIiJqNgHfILEjsi7cf6Gq1e7+mCqPuF3Jm9LOJR/LBTEmVE0
         dkzBADJG43KBdL9WbEvRIG4A0BrTqFRCnQ9azMrSJLJcoR3ua4GdmCXUHhjtmSu/Ct3f
         F/zuV5PvPg2MbndUeroaXTjXXfKspU3/j1ScnG9KHipi/mSBe9rU9n5QFiDd97CuD2+o
         9BzzQedFf/wwX7TZyVlsZBbbrMmQqQTSkPnYctoPB7mnoiycPWK6Xy8two7sLodvBK4w
         EuQEPKdDqII0dgvjRvLRdQuCfNUjU486sKCuKhOf8PbnLKYlmI1PCvG+uAAJWK73WzAN
         +OFQ==
X-Gm-Message-State: AJIora/AS7NZYXHj0SSM/aYX5L4zpkNjSMvZ4cpKtsqYtu/UL7ghAPEq
        gGRliIkVImJTNGnh14ZnFzE+/t8Aw5OQP4HWDECgXZXWnrE=
X-Google-Smtp-Source: AGRyM1uyK78gFG24xlaIy/vYdP2RlZXZVC+Fk0FORiH++8JCQhGeywTeMNSWrIOYke4l8PFA8iFyjCQW15dr1YR24UI=
X-Received: by 2002:aa7:d795:0:b0:435:7fc8:2d1b with SMTP id
 s21-20020aa7d795000000b004357fc82d1bmr17830527edq.201.1656077931034; Fri, 24
 Jun 2022 06:38:51 -0700 (PDT)
MIME-Version: 1.0
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Fri, 24 Jun 2022 08:38:14 -0500
Message-ID: <CAPpdf595_7eW8amX8eueMxgjaWvLW-hWHh1SHHaGAt8YyP7yDw@mail.gmail.com>
Subject: moving a working array
To:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Greetings

I have a working (no issues) raid-10 array in one box.

Want to move it to another (new) box.

Please - - - a list of the software steps?

(the physical moving is the easy part - - - the new box has room
for a lot of drives and is ready for these 4 easily)

Just don't want a fubar situation because I've taken the wrong order
or even wrong steps.

The section 'using the array' has information but I'm not sure how
that will work moving from one box to the other.

(One question would be if the uuid of the array will remain the same
as that would make things easier - - - I could copy the uuid from the
existing and then just do the # mdadm --scan --assemble --uuid= blahblah )

TIA
