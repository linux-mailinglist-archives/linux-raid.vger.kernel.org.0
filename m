Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E7D635AF3
	for <lists+linux-raid@lfdr.de>; Wed, 23 Nov 2022 12:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiKWLEU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 23 Nov 2022 06:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbiKWLD6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 23 Nov 2022 06:03:58 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23A12D23
        for <linux-raid@vger.kernel.org>; Wed, 23 Nov 2022 03:00:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l24so11749104edj.8
        for <linux-raid@vger.kernel.org>; Wed, 23 Nov 2022 03:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=cIOG5ZDiCrgD7AZ13BEWrnYVz7xO/rdANSTRMp38BAoYaQhbgiOr3fRNGv8Hji/kY+
         txPz/BaS6q5QWIEuCoiSi5Ybo/RRbNGAgWUb3jSiwFjvpKLJT3TqbpiCMkj/rsmRLPvB
         SXQwmQjZw6CVCUHtG3YweBsH5fOPl8C+3udiblItW1M3BrEtz5y2lwn7Qk+JZ/kwiddy
         ba3GlDhglutZpAmljTV4KzkctKK0HhEDRWogkccFEwcwXlDWRE66PLkAA9MmjWyEJnJT
         /n8E7oJ/mlN65ZQIaRRV9Heas5Cz2YsbJkAAbYB9TO+NUAfUsAMH+Fcoe4bISnLuxlTc
         7d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=JytrDSSuIVocNJsCuaGyKgOjVRlFuidDlpx/tL9UjVPBfFXsGtKPNKnf1qml2WXxkO
         q+eFf9Rcb13+ltaFHIovz2tSlxF+sVK6tF7vR2YVvRdSgmIhrHH/W57gLoNCMcwq1u1z
         SmBiNMl+paRGNVTL29F3dUEuDWpK1ZlxyaqVYUaqXLkYrPblz+kUmkkE2WqJJcFZ8vkV
         7mQIemr2tjJvnQ0eb15ZzRf94TR54A3NnO1MLtuO9E7ylyqRotktQRfIM7h2QXnrylIa
         aTUMDc8tExl3VvLSfS+N5qDNt9QPsIcfwMTvFhgl1IHvd3czgBSTi8wR/6BAhhn80oM7
         AnFw==
X-Gm-Message-State: ANoB5pmXaIgTTV9YYsDOkC61fIdSJvI02lyGscn3l2+MR9zk3vB7zfBJ
        txKp06yDBVro9DlgSIlx+/RKGcwBI72I426HvxY=
X-Google-Smtp-Source: AA0mqf7QR5YoEddEBUw1vdHIweUVEEdAn116+c0tneN6JuGtfJsNTiXt/PMRonVtRki6mns2RUNxz6TTqja0No/RSJ8=
X-Received: by 2002:a05:6402:181:b0:461:ea0c:e151 with SMTP id
 r1-20020a056402018100b00461ea0ce151mr10850563edv.376.1669201229565; Wed, 23
 Nov 2022 03:00:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:4097:b0:26:957f:2a0f with HTTP; Wed, 23 Nov 2022
 03:00:28 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <sokportina@gmail.com>
Date:   Wed, 23 Nov 2022 03:00:28 -0800
Message-ID: <CANEE7CobmmK524J3WVb+ePr9a_8sWHb9dv2H0JGLuH8HQpYERA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
