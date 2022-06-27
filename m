Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE19355D0F2
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jun 2022 15:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbiF0Ry6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Jun 2022 13:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiF0Ry5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 27 Jun 2022 13:54:57 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6BBD130
        for <linux-raid@vger.kernel.org>; Mon, 27 Jun 2022 10:54:57 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id i186so9677534vsc.9
        for <linux-raid@vger.kernel.org>; Mon, 27 Jun 2022 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=EkK5he22cArD31S1FWdO3o3DXZtvDz8oa7QkTdvxOcg=;
        b=dt368d8ugxF7QFl34RRdU8BFJ677GKE1Xuyf3PVFzvODmvGyuJQenjzR9B7hfPiHua
         czmzctg2wIHFKmz4i94nxQ3GcVWdRiDdGJIt5W0WnXCmpFC3Pl8JId9WeteC3912IL45
         0TZZhpxGImjPkwcZerc8dliLjj9Avdliu7YTlsJcv09Gfq6kioMbIxWbj1o5EwH7ECaZ
         a8tt57DegereJBcTpxRtg5zz4Kkp3Zh/HIxKcOOJM7TLxx2z49YmyqmeP/BeX+kaveWS
         7GUqLYqgaK/+dexA/9eDejyec2R8OGpOV/vwfWUXh2a02p9F1Pc/t/uxyPHqLi2DgR68
         0Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=EkK5he22cArD31S1FWdO3o3DXZtvDz8oa7QkTdvxOcg=;
        b=Gki09ZQXLEr0zNnPZGdcjq3N1aD4lSJfpYT23o8FWWdDHCwRzlsg1ccTYfmmNDvvsc
         SlWlincLtB1Ny/IaOhrgKEq/YWA5Q2YwUNvmtbOBKU/BdoD4FdMQAmPCD5Ts9VI6Ay1s
         T5kYzYZbr1Ohg4MWECBcigerbNSuTmqzJrCwlXTOimzoRVULF2zXn0Wgwh8cUVKrbDWl
         +gdq7VDPG5xRWnTT2meDNG5n2YD7x6BzQ1ck/vlGQOeDtc6dePxXRL+w3Bz14X/QD6H+
         H2IV/L5S6xaL8UYbodAvdYttwDwgUBTRtJyvh8GAK16YntN3+CULNNBrDyDqk+WKvugf
         i5Fg==
X-Gm-Message-State: AJIora+vVcUoZK/zmvS/7yrSy5LdtMCsW8ks3IKgrFoFPcjPCpegOIJ7
        Y2WNgf63H9rOG+iyIJZYU0u5FWs87XT6SgHly7s=
X-Google-Smtp-Source: AGRyM1szxoIYNTdoXEnA/FlU5/bFXb1yivcRVPQTJbC6Z7JHq8XbVkRSa7sHKSCr3ByRX1GpHOfZGGV9SGnGsxyLgsI=
X-Received: by 2002:a05:6102:4408:b0:356:27ed:edf3 with SMTP id
 df8-20020a056102440800b0035627ededf3mr4941838vsb.25.1656352496434; Mon, 27
 Jun 2022 10:54:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6102:54aa:0:0:0:0 with HTTP; Mon, 27 Jun 2022 10:54:56
 -0700 (PDT)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <kennethokonchambers@gmail.com>
Date:   Mon, 27 Jun 2022 17:54:56 +0000
Message-ID: <CAFDu3HX020e2psTBsRzpb-7dDLwg=1t7G8b_KSLagSrJvFGk2g@mail.gmail.com>
Subject: reDid you receive the email I sent for you?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Did you receive the email I sent for you?
