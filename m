Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23558517FBC
	for <lists+linux-raid@lfdr.de>; Tue,  3 May 2022 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiECIcZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 May 2022 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiECIcY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 May 2022 04:32:24 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C243205B
        for <linux-raid@vger.kernel.org>; Tue,  3 May 2022 01:28:52 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id h10so897146ybc.4
        for <linux-raid@vger.kernel.org>; Tue, 03 May 2022 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=imkzOOm11fZfVhhu7YTad+xkt2EA3V5dXbkEnDE5CzQ=;
        b=OB6FeGakm9xfiRTee7LE/PcQtegVqt0O+d2RTupQPpCUuuqa66t7cWtvMJxdeirwKU
         pp6QLJ9U8UYvOZYqzLiImEDweSXTPMDtF61oRV58b0fKRyfcMWZFAlVcmuIjjqqJCnZg
         dohAfdMN2u3Ml9xW6qqJ58OeD8O1G5TP+FGqEyHKmHUEbG0JO9ImzDbmhh2NQi4KYf1K
         F0sxP+yLe6vHwsoDMbt9rAdl7f7Z/pf4ADIWytFr7iETicZnUXyMBaDw0Rab0mIvZG7G
         hFImabd1scnfPrAzQgmzJb1Wg+Rfo3FKMylEpkKU3oZ3moMtx92SHhoAWi1BWHIJHswL
         2Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=imkzOOm11fZfVhhu7YTad+xkt2EA3V5dXbkEnDE5CzQ=;
        b=GabI37ZPp6ebIO2xhMkqez8WqI7Ot/KyJsSqOTBZtr4fhtbYMusGvVF5ThYGTRClVT
         /050oHrIbUXs5EZ590xxwFZuAAPkZkq3Cq6kfMbRa8daHZvMRbYag7ZLMg4Wa0NPDVqa
         xpVl8YQ2jCb66Evx68eYK2oiap+FcEkMAwMKAqyhnEKGrI1+xfxcCfzhHTI2URiTlsKO
         MOgvR3fXmVz/Hcd9bRiCqn+LcnFigYE4UzAKLjJzQUVNGoY4DLk/2AlIj7FS5SliqOGS
         WN00E2IwwViA8xSx66nntHOj9JXxzKj5xW+6WwrU3MMdEc6KmDoSUxn8as6k1WmUV3yy
         yqSA==
X-Gm-Message-State: AOAM530Q0biJdvGjQIg/8GvBArAQw9XLBisG0zT2vshXXoAJEsnvMKN/
        yKS56H+nYlTAfYZH4pjpdOshl/h9KU0PTTgBI+A=
X-Google-Smtp-Source: ABdhPJzfuFmTkrOU7h0ujfk9tMY1oJ4PICZa4P5mIxjjskNbBdXJgMlkAhLuOu5oz03Fl50Z0tBC+aBOaxMr68f51Y0=
X-Received: by 2002:a25:cfc5:0:b0:647:39d4:49f5 with SMTP id
 f188-20020a25cfc5000000b0064739d449f5mr13034064ybg.595.1651566531457; Tue, 03
 May 2022 01:28:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:7019:b0:173:e2d7:681d with HTTP; Tue, 3 May 2022
 01:28:51 -0700 (PDT)
Reply-To: katelordloancompany90@gmail.com
From:   kate lord <katelordloancompany90@gmail.com>
Date:   Tue, 3 May 2022 01:28:51 -0700
Message-ID: <CAG1K+31AsNfLRgFqGedAX+ZaqXx4W57ftY-0LVB6XT8zZZ8NWA@mail.gmail.com>
Subject: =?UTF-8?B?0J7RhNC10YDRgtCwINC30LAg0LfQsNC10Lw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

0JfQtNGA0LDQstC10LnRgtC1Lg0KDQrQotC+0LLQsCDQuNC80LAg0LfQsCDRhtC10Lsg0LTQsCDQ
uNC90YTQvtGA0LzQuNGA0LAg0YjQuNGA0L7QutCw0YLQsCDQvtCx0YnQtdGB0YLQstC10L3QvtGB
0YIsINGH0LUgTXJzLkthdGUgTG9yZCwNCtGH0LDRgdGC0LXQvSDQt9Cw0LXQvCDQvtGCINC60YDQ
tdC00LjRgtC+0YAsINC+0YLQstC+0YDQuCDQuNC60L7QvdC+0LzQuNGH0LXRgdC60LAg0LLRitC3
0LzQvtC20L3QvtGB0YIg0LfQsCDRgtC10LfQuCwg0LrQvtC40YLQvg0K0YHQtSDQvdGD0LbQtNCw
0Y/RgiDQvtGCINGE0LjQvdCw0L3RgdC+0LLQsCDQv9C+0LzQvtGJLiDQndC40LUg0L7RgtC/0YPR
gdC60LDQvNC1INC30LDQtdC80Lgg0L3QsCDRhNC40LfQuNGH0LXRgdC60Lgg0LvQuNGG0LAsDQrR
hNC40YDQvNC4INC4INGE0LjRgNC80Lgg0L/RgNC4INGP0YHQvdC4INC4INGA0LDQt9Cx0LjRgNCw
0LXQvNC4INGD0YHQu9C+0LLQuNGPINGBINC70LjRhdCy0LAg0L7RgiDRgdCw0LzQviAzJS4NCtGB
0LLRitGA0LbQtdGC0LUg0YHQtSDRgSDQvdCw0YEg0LTQvdC10YEg0YfRgNC10Lcg0LjQvNC10LnQ
uzogKCBrYXRlbG9yZGxvYW5jb21wYW55OTBAZ21haWwuY29tKSwNCtC30LAg0LTQsCDQvNC+0LbQ
tdC8INC00LAg0LLQuCDQv9GA0LXQtNC+0YHRgtCw0LLQuNC8INC90LDRiNC40YLQtSDRg9GB0LvQ
vtCy0LjRjyDQt9CwINC30LDQtdC8Lg0KDQrQmNCd0KTQntCg0JzQkNCm0JjQryDQutGK0Lwg0LrR
gNC10LTQuNGC0L7Qv9C+0LvRg9GH0LDRgtC10LvRjw0KDQoxKSDQmNC80LU6IC4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLiAuLi4uDQoNCjIpINCU0YrRgNC2
0LDQstCwOiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uIC4N
Cg0KMykg0JDQtNGA0LXRgTogLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLiAuDQoNCjQpINCf0L7QuzogLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uIC4uLi4uDQoNCjUpINCh0LXQvNC10LnQvdC+INC/0L7Qu9C+0LbQtdC9
0LjQtTogLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KDQo2KSDQn9GA
0L7RhNC10YHQuNGPOiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uDQoNCjcpINCi0LXQu9C10YTQvtC9OiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4NCg0KOCkg0JrQsNC90LTQuNC00LDRgtGB0YLQstCw0LvQuCDQ
u9C4INGB0YLQtSDQv9GA0LXQtNC4IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0K
DQo5KSDQnNC10YHQtdGH0LXQvSDQtNC+0YXQvtC0OiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQoNCjEwKSDQndC10L7QsdGF0L7QtNC40LzQsCDRgdGD
0LzQsCDQvdCwINC30LDQtdC80LA6IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
DQoNCjExKSDQn9GA0L7QtNGK0LvQttC40YLQtdC70L3QvtGB0YIg0L3QsCDQt9Cw0LXQvNCwOiAu
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQoNCjEyKSDQptC1
0Lsg0L3QsCDQt9Cw0LXQvNCwOiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4NCg0KMTMpINCg0LXQu9C40LPQuNGPOiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uIC4NCg0K0JfQsCDQstGA0YrQt9C60LA6ICgga2F0ZWxv
cmRsb2FuY29tcGFueTkwQGdtYWlsLmNvbSApIHdoYXRzYXBwOyArMjM0NzAzMjkwOTcyOA0KDQoN
CtCR0LvQsNCz0L7QtNCw0YDRjywNCtCTLdC20LAg0JrQtdC50YIg0JvQvtGA0LQNCg==
