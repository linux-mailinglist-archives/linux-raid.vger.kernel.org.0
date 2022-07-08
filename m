Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F356BA84
	for <lists+linux-raid@lfdr.de>; Fri,  8 Jul 2022 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiGHNS7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 8 Jul 2022 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiGHNS7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 8 Jul 2022 09:18:59 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7CE25E89
        for <linux-raid@vger.kernel.org>; Fri,  8 Jul 2022 06:18:58 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n66so17843499oia.11
        for <linux-raid@vger.kernel.org>; Fri, 08 Jul 2022 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PyRJFiYa2Q6GxXJ1rLXMHLpoIeSVASHW8xNtHb2y0Dw=;
        b=GCcHR5r8jVB4ulbweCGDGlfvjWEyo++zQAlKEcHdqRfQdBviw+lyuXbWZNSID2UtVP
         bToQncu6mOff2Qn29SvXadKwAkXdk5Vb25Nbkc7EpKZHh8MBzj7GMiubzMSbc6O4KP6x
         surEXRRsjF600+zRCmOJGdaYCa+Ean2G3XtJEken8B3Q3za7JCD44sILMd7XtGfJb0Qi
         n1oHnf4KL188atdO1DfgcPddVAOANU4Zx8IjcgvzpgdXGc6E9EWFvAyGPvS1FxXEXKwA
         kMI67Teex2wyfNdY/2s0VZM7gEy2OMD9vIBoA0W6gCrMCrHk1eUBbInDtC87ZJvkiGAO
         usiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=PyRJFiYa2Q6GxXJ1rLXMHLpoIeSVASHW8xNtHb2y0Dw=;
        b=KffzBT+ANRBCtEIrHBhttfCGHWDxFGc8iLXnayOI8vezO6vtfOeqOUvCLeFY0xVaVW
         F84nQapwHS2T6bDG5bwQeKsE6G9wzm5DElfQ9eHLkkJzN7LK9lGoN9HQAzZzc/IZOXfv
         uFqjD7RECg/Am2VPL8HdrnIsANlZOWc0YDsBtTIBIBgf4VJ5NOUDKQpMVDInokx/Xs6q
         xDYsiIzpRIhRQzxK/+fUBXdCfLvyWTYloIvjp5Zs7WOyJPOcMKEF0F6cUcGQ8rvCjMTt
         YIxu1Sg5V87u9C20Zb6mvIemlJkZ2rA7xC8FW++xNnYegnWgPN+ADZDajv7HBAfFcMnw
         P7YQ==
X-Gm-Message-State: AJIora+ehDTIaO4bnIR/u4uwF+YebXuxcgRTEx4Y/zkZnZdQVW7eX2Cx
        +Hv3YkBBpTqQ+imcMuWn4EX0gTzb4dHFiFW2Tgc=
X-Google-Smtp-Source: AGRyM1ua2yW2ovo45HsX4TWtWNls3CToUBhUss3TCcEu9Pscg/ymp0pkx7CXXe0bxVYaYkFcyqojNwpg3GenOcDccsA=
X-Received: by 2002:a05:6808:1481:b0:335:864d:9765 with SMTP id
 e1-20020a056808148100b00335864d9765mr5720335oiw.270.1657286337739; Fri, 08
 Jul 2022 06:18:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6841:122b:b0:c78:b8e6:8696 with HTTP; Fri, 8 Jul 2022
 06:18:57 -0700 (PDT)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <kelchachambers@gmail.com>
Date:   Fri, 8 Jul 2022 06:18:57 -0700
Message-ID: <CABbsWSvZcyfOeRWOatrKVN1kYUzDUYi6-KDDj_jfYbp6Ua7tkg@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Oppmerksomhet takk,

Jeg er Mr. Abraham Morrison, hvordan har du det, jeg h=C3=A5per du er frisk
og frisk? Dette er for =C3=A5 informere deg om at jeg har fullf=C3=B8rt
transaksjonen vellykket ved hjelp av en ny partner fra India, og at
fondet n=C3=A5 er overf=C3=B8rt til India til bankkontoen til den nye partn=
eren.

I mellomtiden har jeg bestemt meg for =C3=A5 kompensere deg med summen av
=E2=82=AC500 000,00 (kun fem hundre tusen euro) p=C3=A5 grunn av din tidlig=
ere
innsats, selv om du skuffet meg langs linjen. Men likevel er jeg
veldig glad for den vellykkede avslutningen av transaksjonen uten
problemer, og det er grunnen til at jeg har bestemt meg for =C3=A5
kompensere deg med summen av =E2=82=AC500 000,00 slik at du vil dele gleden
med meg.

Jeg anbefaler deg =C3=A5 kontakte sekret=C3=A6ren min for et minibankkort p=
=C3=A5
=E2=82=AC500 000,00, som jeg beholdt for deg. Kontakt henne n=C3=A5 uten
forsinkelser.

Navn: Linda Koffi
E-post: koffilinda785@gmail.com


Vennligst bekreft til henne f=C3=B8lgende informasjon nedenfor:

Ditt fulle navn:........
Adressen din:..........
Ditt land:..........
Din alder:.........
Ditt yrke:..........
Ditt mobiltelefonnummer: ..........
Ditt pass eller f=C3=B8rerkort:.........

Merk at hvis du ikke har sendt henne informasjonen ovenfor
fullstendig, vil hun ikke gi ut minibankkortet til deg fordi hun m=C3=A5
v=C3=A6re sikker p=C3=A5 at det er deg. Be henne sende deg den totale summe=
n av
(=E2=82=AC500 000,00) minibankkort, som jeg beholdt for deg.

Med vennlig hilsen,

Mr. Abraham Morrison
