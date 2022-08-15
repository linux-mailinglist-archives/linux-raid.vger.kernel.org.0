Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3005941C0
	for <lists+linux-raid@lfdr.de>; Mon, 15 Aug 2022 23:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349238AbiHOVmy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 15 Aug 2022 17:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349697AbiHOVlo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 15 Aug 2022 17:41:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39105C9D8
        for <linux-raid@vger.kernel.org>; Mon, 15 Aug 2022 12:29:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso8243472wma.3
        for <linux-raid@vger.kernel.org>; Mon, 15 Aug 2022 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=Pk0lndCs1Bsv7Vzz7KkYpvP0/Q3YOhQIYRP6EPyT3Jg=;
        b=dvV8s3puBvl+dC5Q4RL0QgmRh90W/lNNXs8nqy6BkeuMHvoHaXbl/vPnwe2J0ZHw16
         4F3P9m3i/u8L50KSDv7kC389+lFm5KJEVy4KxpAWFqhHY17sUQZW8eI+ZxZLYe6BUBY0
         6PPmTzxv8MJMvLO3yz0xUPIySZxvBI5SFKlb97Cv2lG5DzATg02NZx9RcxypAzzNHal8
         3QVGTTWTmMFOJGmJsv7NrfhHo8oxm8klSrXVv3bpWKFdc8R7z86T2T3LZCwPjhlR7WC8
         6h0sSzJNC7I5FYHp4lEjqySuATbVnQA5qE3DR3zaankqorb+Baf19NZ8ja1TvchwU5bk
         vsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Pk0lndCs1Bsv7Vzz7KkYpvP0/Q3YOhQIYRP6EPyT3Jg=;
        b=HwT9qE4W6jR23ZNJvnJdtqHvwM7ESSaXvZa4aOiUloIKZeoVDNEfcS4mJVv/fZ7W7n
         Hbq40evw9r/VEfUwXy1dKtllOcsocxhw2eLs6aJpSM0+YvlH2Xue5lt/2q5Y+3W4thuw
         z1FKyBQU0hXEHqIF6QF3ayUSZA/do+5E4lMEgjWSdDG6GisY2a7lOB+GZMF59tGcCWVc
         n59KjvEWAlaHjf18Z7ypQlr6WtFz7LngTse3fTjIeWpVK9UAEjc73rSrOAt3e7CbRDVy
         1ejLFzCizsXAIqdSqlVwU6EuqXtnM5tHKql3+0g01zRFb7eTx5PxuAD7uO5bjgBiLRHJ
         R+Qw==
X-Gm-Message-State: ACgBeo2OhRe0y58L3MnjyUlpgvv1EbjFUHqm5YKLix/sP8OMc+9O2mAb
        QSv6siUY3eD73Kvg1TPjXGQ5zspI3Emb3QAeAxU=
X-Google-Smtp-Source: AA6agR6kgOGfrsOS7GxwSt+ALlLFRJlPs+E2WylJrV0xh+1SVfgRCxtHkgCM0N8SwSDct7s+071d/LW4EdTYhdFjd90=
X-Received: by 2002:a05:600c:58a:b0:3a6:4a1:78d1 with SMTP id
 o10-20020a05600c058a00b003a604a178d1mr541197wmd.78.1660591765574; Mon, 15 Aug
 2022 12:29:25 -0700 (PDT)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: pr.yesmine@gmail.com
Received: by 2002:a1c:7308:0:0:0:0:0 with HTTP; Mon, 15 Aug 2022 12:29:24
 -0700 (PDT)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Mon, 15 Aug 2022 12:29:24 -0700
X-Google-Sender-Auth: z-j8IdsrjjMF5Upra56D0kchGMk
Message-ID: <CAMZmgdY97dWpGuoxdEt_+uMbefh_58aGsR909vTUnL4kH7M2uw@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32d listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9477]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [salkavar2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [salkavar2[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.7 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  1.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

You will take 45% 10% will be shared to Charity in both countries and
45% will be for me. I have decided to confide in you and share with
you this confidential business.

Yours Faithful,
Mr.Sal Kavar.
