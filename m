Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACB36188C0
	for <lists+linux-raid@lfdr.de>; Thu,  3 Nov 2022 20:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKCT02 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Nov 2022 15:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiKCT0Y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 3 Nov 2022 15:26:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD811129
        for <linux-raid@vger.kernel.org>; Thu,  3 Nov 2022 12:26:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id t10so3528283ljj.0
        for <linux-raid@vger.kernel.org>; Thu, 03 Nov 2022 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gO37JDtP/8vBFvPBdBNf1boDLrRmfcP+qSqSTBrttho=;
        b=RP6ha3FtVKIruU6YJ5DeggWR4M4NEnTm9kHiXuRMa39miimkpvaW5lqn9Skfh2qDfF
         NvWLet/RcCH4hZAK0YXeGz7ZGuG9qPK2PzUim24Amq0fMNiRt5Kw089IjKoSoDMB9DHl
         rOIflIm/F3kIv2pdwyYBs5z2bGqw3AzrfmM88mvy/eRoySVRpAnb3n8WVrkzld7RDebC
         QNvr79U6vbJ4tciJEKOv2E/bhkDt8ZE5AjIvTA4b2VTGsl2K4RzhMbRnS8vFM4jibnDf
         W5DFwoh7fUJE6AoRWsMudTP1snECv6y6cp3m9fH9hSg7FtHR93eNiCspDcmLi14rQpiE
         2ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gO37JDtP/8vBFvPBdBNf1boDLrRmfcP+qSqSTBrttho=;
        b=z7sITMfnSf6u6hNyjCRnHte8Mswus0tHkFTwKS7B2z/lthmv6IlbuVCcbdczdwbWJj
         Ezh3+vyWm2bEFNG22Ni2Ny9IlRnI9GPzZPgdEE5BwBwbm4eA29RzilA/Dy0yQb+0C9jJ
         pu5DIAstZjZMGNHaZpZsPt/OxJmLLtupnLXwAwTJXGikxEAMTV7tFfk/OM11IsIqzG0Q
         4ne0k2HYpqi0148mlsqm/semm+DrzEu5D8nAjTNaCB6gnrhcz6FF9Zxj+tGShFOkYsYj
         dmGZhMJVzQvh3n8gG7ShPgtqCNtHLA9mH0egsS5aTwrFJvpYLO4Pb1PjAUfDNasVJHZh
         lKCw==
X-Gm-Message-State: ACrzQf1EQ4vT1Cl3RrYYrauG3pEHcFSZK5qc4lDdi6nlGdNUqT2TPb5B
        Cb1titPAcJaVRKJpkJ0sIkYesLnCTXyHl830qqc=
X-Google-Smtp-Source: AMsMyM7RRpCcODI3BsAq28CV/5vfL+WfaRyB+k93j105Sq002ALK1c0xasiCMKwUGWjYa2Kp9UUyCPU62O6gLrI1kes=
X-Received: by 2002:a05:651c:239b:b0:277:5175:4fa0 with SMTP id
 bk27-20020a05651c239b00b0027751754fa0mr9874271ljb.327.1667503580957; Thu, 03
 Nov 2022 12:26:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:812:b0:22a:97d0:b58a with HTTP; Thu, 3 Nov 2022
 12:26:20 -0700 (PDT)
Reply-To: georgebrown0004@gmail.com
From:   george brown <eddywilliam6659@gmail.com>
Date:   Thu, 3 Nov 2022 20:26:20 +0100
Message-ID: <CAPdfmQLjD0XjsiW5XQpNRD=u9xx-bf6qZQF7gu3pXbnCR90mbw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Ahoj

Jmenuji se George Brown. Povol=C3=A1n=C3=ADm jsem pr=C3=A1vn=C3=ADk. R=C3=
=A1d bych v=C3=A1m nab=C3=ADdl
nejbli=C5=BE=C5=A1=C3=AD p=C5=99=C3=ADbuzn=C3=BD m=C3=A9ho klienta. Zd=C4=
=9Bd=C3=ADte =C4=8D=C3=A1stku (8,5 milionu dolar=C5=AF).
Dolary, kter=C3=A9 m=C5=AFj klient nechal v bance, ne=C5=BE zem=C5=99el.

M=C5=AFj klient je ob=C4=8Dan va=C5=A1=C3=AD zem=C4=9B, kter=C3=BD byl zabi=
t p=C5=99i autonehod=C4=9B se svou =C5=BEenou.
a jedin=C3=BD syn. M=C3=A1m n=C3=A1rok na 50 % z celkov=C3=A9ho fondu, zat=
=C3=ADmco n=C3=A1rok m=C3=A1m na 50 %.
b=C3=BDt pro tebe
Kontaktujte m=C5=AFj soukrom=C3=BD e-mail zde pro v=C3=ADce podrobnost=C3=
=AD:
georgebrown0004@gmail.com

D=C3=ADky p=C5=99edem,
pane george brown,
