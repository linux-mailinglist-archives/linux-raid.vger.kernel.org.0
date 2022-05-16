Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6569527FC7
	for <lists+linux-raid@lfdr.de>; Mon, 16 May 2022 10:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiEPIfK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 May 2022 04:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbiEPIfI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 16 May 2022 04:35:08 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23C6E0A8
        for <linux-raid@vger.kernel.org>; Mon, 16 May 2022 01:35:07 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-2f83983782fso144545867b3.6
        for <linux-raid@vger.kernel.org>; Mon, 16 May 2022 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5IPI7ZpNQGvv7cFVa2HPF7Rg3JujxR3HWGdce5Uu9No=;
        b=dNW3hC0JR9C4zuFq7LJH/BmVoCfP47yuEl0nMUaLqStDnI261VPcHV5XiIHBIeVN8M
         D70PbxKKla5RNyBfuVrUKgfvzeKijqDuqnNs4iV8KIxC9+pnPQqwKofKsKFvBJnwyN2Y
         iqivec2VclNuUCGz9RRTLOBkiHWXReLGHDw4Bs16O2pY/ifhP2HE2H6AP2Aistz59sQA
         SiOX/3nlYr3zyAYTNpJta0t/jBEYsgfEhtLUVraMpTEdgNaf1xR5Px2CV3SOlVCr57X6
         DfjCGs1jPpT49mAKTBD73EQMAgPKwbC7E0RQCoiyp2QitO5c1rC+yCXI2UzvaKgUG4lo
         lnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=5IPI7ZpNQGvv7cFVa2HPF7Rg3JujxR3HWGdce5Uu9No=;
        b=stCMYbSru5Cu6CpAVaIW7/NePEqUwPDNotoKzJVHFwild+KwI06o4IRipbpw6fR7iM
         5QbP+en29sZntbjEbwFuPgRYaiQ9l3X64gQ0zR0GwFyDqaq3WCY6iDBWH0soZn9Uzmp6
         J7cZzoyta80uAsin2TJVKbILTHiAOWxoIxxWv6UE5Q5kcR7zUbjW/xfWeBGyvHKE4/Bd
         fyREFkW8YAVJp/9AJZayu2ovkCkhCJomZtMT6kBGmF4g2bt1oqQyhMBpxN1qCA0Pnu3M
         auZ/B/pLBCsF7InbIso38QfSC6iK+h1/ceXXHgEIC8OHBGdywNCyJZjWcUWhOIQQBA0L
         BMoQ==
X-Gm-Message-State: AOAM532jghBluP0XqFueXHjDpPbPIduycGZLDBJlAg1MCenKDlOVsQl8
        OR8rNE3LHTtyDjWW0s546fWR572r86MbWFHFYSM=
X-Google-Smtp-Source: ABdhPJxZNOj34lQcX1GyNrtBgZd6KMtCvOcWfyqgzQUNfjpfClFxXUYvXxPPe2ccKbmXEk04ClnfuXFxhdIZhp+Vvf8=
X-Received: by 2002:a0d:ef03:0:b0:2fa:245:adf3 with SMTP id
 y3-20020a0def03000000b002fa0245adf3mr18970522ywe.100.1652690106768; Mon, 16
 May 2022 01:35:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:6313:0:0:0:0 with HTTP; Mon, 16 May 2022 01:35:06
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   Sgt Kayla <alexnoelegah@gmail.com>
Date:   Mon, 16 May 2022 02:35:06 -0600
Message-ID: <CAJBoYH9pCUyvZ+1=eFPMV_bY41p97uPoZroyK4Y4Gb34xVjmAw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1143 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylam28[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alexnoelegah[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

LS0gDQrQn9GA0LjQstC10YIsDQrQn9C+0LbQsNC70YPQudGB0YLQsCwg0LLRiyDQv9C+0LvRg9GH
0LjQu9C4INC80L7QtSDQv9GA0LXQtNGL0LTRg9GJ0LXQtSDRgdC+0L7QsdGJ0LXQvdC40LU/INCd
0LDQv9C40YjQuCDQvNC90LUNCg==
