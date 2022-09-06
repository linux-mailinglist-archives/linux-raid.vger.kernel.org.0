Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D310B5AEF04
	for <lists+linux-raid@lfdr.de>; Tue,  6 Sep 2022 17:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiIFPjQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 6 Sep 2022 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiIFPi1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 6 Sep 2022 11:38:27 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977901F626
        for <linux-raid@vger.kernel.org>; Tue,  6 Sep 2022 07:48:00 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1278a61bd57so10184735fac.7
        for <linux-raid@vger.kernel.org>; Tue, 06 Sep 2022 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=2AFvyrObCHkvwVcACFedAi4cW+Lxc7JfD/cB4klOo0k=;
        b=aktBp2EvguF7PvmLKwQg9WSnM2UUyYfhtB7Ym1qWxY1DdlQ2LKSl1LLUTGZAv0l8rB
         kFcHeeJ2kRoK/Gk8Zr7wafpjuI0zy2JWqdtxJBypp/8f9Eo3gpAhyUwPXkBGOxtYC8RG
         QqCIg1Y6g0h72d6vQ1fHJ4xOJmQk5JD/A38EOZetUOL23OYU8Zdac0VlAzLA8dUTdfqx
         KSvjAXKXpN0PRPJLgT2q8lwuzLnwOeHZf0gRCD7FC+yYJJblV+2Odt4dQcr5a+VWJ43q
         vSGnJUt+Sz2qhvO6Tsp4iw+7e5Ls7jTCimqRS+gshf6CiEXNhQp1dMAbFCnt8IoXaf9J
         rXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2AFvyrObCHkvwVcACFedAi4cW+Lxc7JfD/cB4klOo0k=;
        b=Yc3S632t7LtkX3pxUETcrZQX5eHQPnVz7rcIfgp0yY5psVicFEy/PrXDwowsfOI1ZP
         4kCnd6+ZTj4D9CSQx+Yd2Or1r0gY2eJmsFG69+kw1UmA7rjUiQ0k8QeNlc34ygHcfGMU
         fAC+PUoUBhKctF+EuTOPC0qdXfkKoftNMgQyEvDrCsLocvguJAv/us9YvNygvJ/B3OVu
         lSf9sZ1gY7BScbLhvA+7VlpvwUzIGWJH8H4XWSJf6rlE3Q6L+ovR/LfZIa3Mt2b9vgsq
         JVAydYlFruuJXjvIK9x5xqUPJ+Ltf8Roiwcd3YVzRPSpSzDQZU3CdPj9+/sOKP86jPHk
         ZaVA==
X-Gm-Message-State: ACgBeo2NzxyK12/Mq7XuDlIWk4ejZ5tlR5krma4Bw9pBTKkl3sB87XYU
        WiZv6X9aB2Y5vz3CKHgcxyWTu/lPaAiikhf07WE=
X-Google-Smtp-Source: AA6agR7atoTsBOmoPg2sPRihKbVa9hy5WiSZ85gP1xIzA+OZ1+isNKtHbue7DIR8gkAmYqVFeTRxvdZNymy28fAVPds=
X-Received: by 2002:a05:6870:f105:b0:11e:87ca:cd50 with SMTP id
 k5-20020a056870f10500b0011e87cacd50mr12652785oac.22.1662475678861; Tue, 06
 Sep 2022 07:47:58 -0700 (PDT)
MIME-Version: 1.0
Sender: 1joypeters@gmail.com
Received: by 2002:a4a:bf15:0:0:0:0:0 with HTTP; Tue, 6 Sep 2022 07:47:58 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Tue, 6 Sep 2022 14:47:58 +0000
X-Google-Sender-Auth: PZn3-FxVWq9Db4Xd5_Csj0qj30Y
Message-ID: <CA+F+MbZ1zV=81wnbOhEeMHihBUt+=SrWDbfqVgnznX8caJ21Dg@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:36 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9019]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dinamckenna1894[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello My Dear,

Please do not feel disturbed for contacting =C2=A0you in this regards, It
was based on the critical health condition I found myself. =C2=A0My names
are Mrs. Dina Mckenna Howley A widow and am suffering from brain tumor
disease and this illness has gotten to a very bad stage, I
 married my husband for Ten years without any child. =C2=A0My husband died
after a brief illness that lasted for few  days.
Since the death of my husband, I decided not to remarry again, When my
late husband was alive he deposited the sum of =C2=A0($ 11,000,000.00,
Eleven Million Dollars) with the Bank. Presently this money is still
in bank. And My  Doctor told me that I don't have much time to live
because my illness has gotten to a very bad stage, Having known my
condition I  decided to entrust over the deposited fund under your
custody to take care of the less-privileged ones therein your country
or position,
which i believe that you will utilize this money the way I am going to
instruct herein.

However all I need and required from you is your sincerity and ability
to carry out the transaction successfully and fulfill my final wish in
implementing the charitable project as it requires absolute trust and
devotion without any failure and I will be glad to see that the bank
finally release and transfer the fund into your bank account in your
country even before I die here in the hospital, because my present
health condition is very critical at the moment everything needs to be
process rapidly as soon as possible..

It will be my pleasure to compensate you as my Investment
Manager/Partner with 35 % percent of the total fund for your effort in
 handling the transaction, 5 % percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country
for the mutual benefit of the orphans and the less privileges ones.
Meanwhile I am waiting for your prompt respond, if only you are
interested for further details of the transaction and execution of
this  humanitarian project for the glory and honor of God the merciful
compassionate.
May God bless you and your family.

Regards,
Mrs. Dina Mckenna Howley.
written from Hospital.
