Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86754EA10
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jun 2022 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378133AbiFPTW7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jun 2022 15:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378392AbiFPTWt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jun 2022 15:22:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FC75622F
        for <linux-raid@vger.kernel.org>; Thu, 16 Jun 2022 12:21:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso2324777pja.2
        for <linux-raid@vger.kernel.org>; Thu, 16 Jun 2022 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TU1cSht9SVsnASQg0daQWMMrpVHc9G/iYZjWHQ8NH2g=;
        b=TZc/kMqNwlndqqpT8nDp8JRC5jDFyeM3YOuwctaZnyYkC0eZoUtnHMIPZCQ9C7Hg8C
         aFr2iQifV+EWi4oooh2zc2INNE7EJEONpc0BKo36UiN5RHNHsy/PleMmbr1loaKbvKG4
         egpgYDzEUNW2dr5epKLThzZzwe1EbiT/siPUYepvuRiyxCoetjdRDoHP5E3lPzwRSqnZ
         9rQ6ZZ5ZnKUqcdhJS+amVZ9nzZq+CuPEJYkPDYZ431915+7TvFxi5WfO93tA+WLK/LF0
         QkfWNhS04KdrOkntewBM7LN0Dfw+fvFH80zhbLzLZ7M/+d/74HcLR8gYysIJ5oTHiomU
         UzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TU1cSht9SVsnASQg0daQWMMrpVHc9G/iYZjWHQ8NH2g=;
        b=3yZ1IfmZWj6Sr+sbu/cCgxggESZgMuig6KInzOfhrq850rNPvp8GWJI9XDgFzitmvI
         aI/ndDcYkWTujpZlfXLhyIwuvnEF/7DJhZy9KUZIcM6K89KVSqUttULgRX0rIZ6AajYz
         Dgb5T64doeZFIO5IJSx88GFm7FZmLfVhT6pb2h8J3Noe2UbsWQ77YDu4GINrSXvddGEi
         sRcvGSEA6tI4CyCgb8tNI1/3NFi4F1h2675XRRwuHlGayXwoMvPQiOKrNKzklGILFjlx
         N/2Sp6Allo4+VPYuiczXmKtDbLCzDPKX4NMNkYSwWm1Jroho+Fss7GaM6ZUCWaMxn/sY
         4R2g==
X-Gm-Message-State: AJIora85+/7SQ5wXswMcA+xNVVl/aVwI/lw8P080ctYWBqR+WS4UvnaX
        AQyk6V/3bbC2ZfBSAZcbv2E/a82AD229fEBV8io=
X-Google-Smtp-Source: AGRyM1s0ADFkrPJ3LryY2VlKH/zLqAzVZMw1In8Es+x65HzYdEZhUcDog/Y8uyMGe7vwFupkQcTGDAcLPi5g0HIrBko=
X-Received: by 2002:a17:903:22c9:b0:163:e49d:648c with SMTP id
 y9-20020a17090322c900b00163e49d648cmr5863445plg.54.1655407304717; Thu, 16 Jun
 2022 12:21:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:4a6:b0:40:fc89:d62d with HTTP; Thu, 16 Jun 2022
 12:21:44 -0700 (PDT)
Reply-To: cecilia.mathurin@aol.com
From:   Cecilia Mathurin <ceciliamathurin3755@gmail.com>
Date:   Thu, 16 Jun 2022 20:21:44 +0100
Message-ID: <CACmM7rG=jS-pQ6cM82yd+mmCzveW1RJRTA2WJwAbKFs95Hj6SA@mail.gmail.com>
Subject: Fru Cecilia Mathurin
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1041 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ceciliamathurin3755[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ceciliamathurin3755[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Fra fru Cecilia Mathurin

K=C3=A6re elskede,

Jeg hilser dig i Guds navn; det er rigtigt, at dette brev kan komme
til dig som en overraskelse, men ikke desto mindre beder jeg dig
ydmygt om at give mig
din opm=C3=A6rksomhed og h=C3=B8r mig godt. Mit navn er fru Cecilia Mathuri=
n. jeg
er 63 =C3=A5r og jeg er gift med Mr. Rodriguez Mathurin og vi var
gift i en periode p=C3=A5 32 =C3=A5r, f=C3=B8r han d=C3=B8de i 2012.

Vi var gift i 32 =C3=A5r uden et barn, og han d=C3=B8de efter kort tid
sygdom og siden hans d=C3=B8d besluttede jeg ikke at gifte mig igen pga. mi=
n
religi=C3=B8s tro og alderdom. Da min afd=C3=B8de mand var i live, han
indsatte summen af =E2=80=8B=E2=80=8B4.500.000,00 (fire millioner, fem hund=
rede tusinde
euro) med en bank her. I =C3=B8jeblikket er disse penge stadig i varet=C3=
=A6gt
af banken. For nylig fortalte min l=C3=A6ge mig, at jeg ikke ville holde ti=
l
n=C3=A6ste fire m=C3=A5neder p=C3=A5 grund af min kr=C3=A6ftsygdom.

Efter at have kendt min tilstand besluttede jeg at donere disse penge
til kirker,
organisationer eller gode mennesker, der vil bruge denne fond, som jeg er
vil instruere for en ordentlig id=C3=A9 om, hvordan denne fond ville blive =
brugt.

Jeg vil have, at du bruger disse penge til velg=C3=B8rende organisationer, =
b=C3=B8rnehjem,
enker og andre mennesker, der er i n=C3=B8d. Jeg tog denne beslutning pga
Jeg har ikke noget barn, der vil arve disse penge. Desuden har vi
Mandens sl=C3=A6gtninge er ikke t=C3=A6t p=C3=A5 mig, da jeg udviklede kr=
=C3=A6ft
sygdom, og det havde v=C3=A6ret deres =C3=B8nske at se mig d=C3=B8d for at =
g=C3=B8re det
muligt for dem
at arve hans rigdom, derfor har vi intet barn. Disse mennesker er ikke
v=C3=A6rdig til denne arv. Det er derfor, jeg tager denne beslutning
kontakte dig og donere denne fond til dig til velg=C3=B8renhedsarbejdet.

S=C3=A5 snart jeg modtager dit svar, vil jeg give dig kontakten til
Bank, hvor denne fond er indsat af min afd=C3=B8de mand f=C3=B8r hans
pludselig d=C3=B8d, ogs=C3=A5 vil jeg instruere vores familieadvokat til at
udstede et brev
autorisation til den bank, som vil pr=C3=A6sentere dig for modtageren af
denne fond, og jeg =C3=B8nsker ogs=C3=A5, at du altid s=C3=A6tter mig i din=
 daglige b=C3=B8n.

Enhver forsinkelse i dit svar kan give mig plads til at lede efter et andet=
 gode
person til samme form=C3=A5l.

Tak og forbliv velsignet.

Din s=C3=B8ster
 Fru Cecilia Mathurin
