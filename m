Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2237F4E1A62
	for <lists+linux-raid@lfdr.de>; Sun, 20 Mar 2022 07:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbiCTG3x (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 20 Mar 2022 02:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiCTG3w (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 20 Mar 2022 02:29:52 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C849F6F7
        for <linux-raid@vger.kernel.org>; Sat, 19 Mar 2022 23:28:29 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so15658186oot.11
        for <linux-raid@vger.kernel.org>; Sat, 19 Mar 2022 23:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=CNNPGySxSq7bZ1La6vvay1kp1T7RaMnfdFjrr49KhAk=;
        b=RSyJ1oD4Fs9XEHIt2Ee3OUpJhLbT/+j4Hd6p3ojngXBP9PDYvrpuWKQW2VNPPYlN49
         gi08Ej7onWYM+v0SyFwXq0DZ6w7joySTi8ibG3ZvG3xViutrnQouSg5/gDKf+6tnV8Ob
         IuNUZxsPvTw4/sWl5Lz2uLW2k71ww0YstjhQ4N671c2IIUpt6vGQgmOgEgMkA/oDFD1Z
         fWbwg/xDJWwBEf6umMEl3tGNEOLJajAEAoavCBHdrEEB2WHuvXx3riVsuUmtx3zl+ryt
         qIfq9wfKItiLn2KhYH4yrkGdDJoW8qg+EKqO43SDy5z77DqiuJMwVKv6tW6V6qmQyavf
         3Q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=CNNPGySxSq7bZ1La6vvay1kp1T7RaMnfdFjrr49KhAk=;
        b=pCJx3b/7F6Lnl6mKbpGQPDCfFTs22KxigVlMwG+xjyUvYaK7NIJdUvomecZzBTPk/Q
         mK7Pqu8OUloWVpZf336ThuWae4LxedbTmElwriRGIXwBgxYw1+vQrMiEvUFf3cE86BWv
         CgCy/nA1SmvjQ0GKMzsnzGqpCu/KXHDNlUNESdueH8WkHzoBgZw8YxgCmCHVdkvIEs+a
         Bkj8SoExlBx0hyDxo/scQgCmNLDMfKJ6/KtZ5YL9dYOCltqqUoW5a9kGZCnvzoCXIMSI
         pH48FcCrWeGGSsjhPWndpbUsWSTJP6JMOiVfHjuBtNL/qjz4BI55ZekGavQg/oOHWGpO
         CDNQ==
X-Gm-Message-State: AOAM533RHeCwx7WQVzoXYACiVNqZsg2E8xDJEuNT71m4wIIA+KYM0IEm
        /x1VQqjtcmus8hx0+5kMr/UPeHsGjgekLu60gEU=
X-Google-Smtp-Source: ABdhPJxdKbQvYY1rmVHXsRJjCmWYr5vWJOHrRj52ZxMUhh2vSuy6GrFto1McVH8GJyPXiNJiWQSt4bt6cMpktFXwbgA=
X-Received: by 2002:a05:6870:d10b:b0:dd:b6ec:2c90 with SMTP id
 e11-20020a056870d10b00b000ddb6ec2c90mr6444261oac.261.1647757709206; Sat, 19
 Mar 2022 23:28:29 -0700 (PDT)
MIME-Version: 1.0
Sender: mrslila88haber@gmail.com
Received: by 2002:a4a:e08f:0:0:0:0:0 with HTTP; Sat, 19 Mar 2022 23:28:28
 -0700 (PDT)
From:   "Dr. Nance Terry Lee" <nance173terry@gmail.com>
Date:   Sun, 20 Mar 2022 06:28:28 +0000
X-Google-Sender-Auth: oFt77leiXJcbhQSXKQ-PT5iFCtw
Message-ID: <CAODWenZV2YaNpibsGOJEnZMuym3Om5G2EPOnjuD5UusNPNeZRg@mail.gmail.com>
Subject: Hello My Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nance173terry[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  3.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello My Dear Friend,

I am Dr. Nance Terry Lee, the United Nations Representative Washington
-DC - USA.
I hereby inform you that your UN pending compensation funds the sum of
$4.2million has been approved to be released to you through Diplomatic
Courier Service.

In the light of the above, you are advised to send your full receiving
information as below:

1. Your full name
2. Full receiving address
3. Your mobile number
4. Nearest airport

Upon the receipt of the above information, I will proceed with the
delivery process of your compensation funds to your door step through
our special agent, if you have any questions, don't hesitate to ask
me.

Kindly revert back to this office immediately.

Thanks.
Dr. Nance Terry Lee.
United Nations Representative
Washington-DC USA.
Tel: +1-703-9877 5463
Fax: +1-703-9268 5422
