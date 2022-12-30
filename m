Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1FD659980
	for <lists+linux-raid@lfdr.de>; Fri, 30 Dec 2022 15:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiL3OvT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 30 Dec 2022 09:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbiL3OvS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 30 Dec 2022 09:51:18 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27711A3BB
        for <linux-raid@vger.kernel.org>; Fri, 30 Dec 2022 06:51:16 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so51844040ejc.4
        for <linux-raid@vger.kernel.org>; Fri, 30 Dec 2022 06:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ShM4D9zrO/l9vlRJr4GjItrMAMbHERXsnMH9h5W3eA=;
        b=PjfvgoAtrOlN8nuMOYB/ZVbcYgMFTFc2lQwhd0SgMW6Ui2YdR+wVPNQQpBuFYFm7e5
         ji7cSiopMaWlost3TONRRMlUq5XvIhAbSE0tV1gB1h31eRM0DNJ2biJ+zCKHdokKha5n
         MKenrHtmiSaEUyhq+3aETencKkkQy5PJGJoN/cpYvFG26TqkEQPgHbrqxBALL60tK2Si
         Cw0UUKS7mcFsffB7BR/gPQzSw8gWqjFqQRG2P/eeYh6LFdcLnHiCfVIaw7WxbXBELAry
         RBUpBOFAozRBFP8xvqwbtP6kbqRq94DM/oT5eZ/kUronTf/Xbj3mkPQ2GebDyVZmbU/S
         ewoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ShM4D9zrO/l9vlRJr4GjItrMAMbHERXsnMH9h5W3eA=;
        b=AiJL44ORAXJm8F3CWLyMUcpAGtKtTBUnlzdDCsMRjbMNQx377HDaveb0JqoWrWFNw9
         BAQfrwpuS+APqvPleAE5TPHYfBV2GBWxPJKwP5i5epLJ0tuRcrMs1Ykt2lsydk36J28f
         2DqtyHg+V3OBg5QvNG/C/HOw5ouQMQV2gzbD2VzfOxX2LY0f0EJGvrLi2bRytzRAAQH+
         u13ZbupZ4MUJsP4ldyqTAWrbg8+zF7OWTc+DabUiDbW9rjpUm7HPZ8u9opz/sfOVk8DD
         9abjoNYcjk3+e+Q3/6p7FgRus1uAZY+G5tuMVS8nUiuoWJl60t8gk/kX97+zKi9wOqGy
         qDEw==
X-Gm-Message-State: AFqh2koUvYZlBPVnAUfQflkqU5pCLCFxuqBQaSuGrAYQw0pVheshjpfL
        f6JzIPZ5ovoWzaKwK2JenTFV6Gmb5sZ6FXBW6ZM=
X-Google-Smtp-Source: AMrXdXsLFCkdD1hvQiwWm7g8ItNj0Qe3Vn6hrMmfDJW1KPQqYt4mReBRvHgD7veBgITehGTzqDlQKwkqceyoICDWfIM=
X-Received: by 2002:a17:906:4f12:b0:77f:9082:73c7 with SMTP id
 t18-20020a1709064f1200b0077f908273c7mr1721808eju.517.1672411874984; Fri, 30
 Dec 2022 06:51:14 -0800 (PST)
MIME-Version: 1.0
Sender: goodw771@gmail.com
Received: by 2002:a05:640c:1a0c:b0:189:ab5b:3d94 with HTTP; Fri, 30 Dec 2022
 06:51:13 -0800 (PST)
From:   DB HM <mimiabdulhassan39@gmail.com>
Date:   Fri, 30 Dec 2022 14:51:13 +0000
X-Google-Sender-Auth: 9lcIS3KwSXNG_57-zP7JFVtlGT0
Message-ID: <CAM0SVCaw_CA7PdtcpGT9iedXkGHMyiyfw9ZFt69+9Amz1_90Uw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

If you are interested to use the sum US17.3Million to help the
orphans around the world and invest it in your country, kindly get
back to me for more information On how you can contact the company and
tell them to deliver the consignment box to your care on behalf of me,
Warm
Regards,
Mrs Mimi Hassan Abdul Mohammad
