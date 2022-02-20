Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4858A4BD217
	for <lists+linux-raid@lfdr.de>; Sun, 20 Feb 2022 22:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiBTVj7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 20 Feb 2022 16:39:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiBTVj6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 20 Feb 2022 16:39:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B121A51E58
        for <linux-raid@vger.kernel.org>; Sun, 20 Feb 2022 13:39:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id x5so18980582wrg.13
        for <linux-raid@vger.kernel.org>; Sun, 20 Feb 2022 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=FyG0ATSkb5fmrso4VuDc0KiEUJrvvMWML2pstdAYUxY=;
        b=puf1Mdd+31r8/R8xZDBm2pzqp0tZROohaTJn7hs385ZG0Q0L8XAyGvhumNHbMOwZO3
         wosImDCPKzMX3Xo2cSIHOcJ7+WckB5oR2Q+k+AYO9EkcQ+Urj8vqOt1+rJZVdvuQ8c42
         22pQDxSWAIBPOm824eC3a50hcYPpKKClroMzGeBdHXGQ0nNg6FNvjCbxIFdkRWZTTGxg
         hoFV+f9kXpb9y5T3x3+ZADi79W5nc4tHclyC3M0UMJIBlF0rhzFJKfNFovtdf+ypDcZI
         HpqRCAPnHTd1Ml/PQ57AUQGLlOkSJPcILzHbfWKOSDatAhrQsJte18EJwPyWjkNWvAqp
         NWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=FyG0ATSkb5fmrso4VuDc0KiEUJrvvMWML2pstdAYUxY=;
        b=heLpM35T0rygswVWZ9GPOEDEgGQrdMEjEVjo+qbrOLCSSisiCxJ1tK68seg+WdvyNa
         z7edGAo+uWZEn7LdPOFQCjC4QNDiafXHi6IpbPRew6NtZ6jEckzTD24v/TBkXdAc3LGJ
         yMflKybQDLOSBcEQZmai45QH15m951Ux11OkzKZ3HM3aCu/OBGEbONFqG13kLxhA0ojg
         V1LT/K9ho229dzjo+OCC/bL7R/VobChITe3NAcWEmVQnjvAtmqg4baJfJ1uvAu2hdJDE
         JNT0py//ag2ZepswzAlS6lKOS9QvDJl2TydtsKLR+zp4u47dCwTsaJJZcut43WSYKR9c
         906Q==
X-Gm-Message-State: AOAM533zmcu2net0KEavczOERyrDnKTI5qPHkqBaPs2bbDmVxyY+vmXg
        GFDhzVwg8xmn6szCo6gB9r8SRyvzkZ0=
X-Google-Smtp-Source: ABdhPJx8OLN36iYar64UlKabhZNUoBdtFY77JWgoDUJUZLWYLFMCkqMXhio4ZX2sCkXkpVq9pEBn4A==
X-Received: by 2002:adf:f608:0:b0:1e3:1ee5:ee6 with SMTP id t8-20020adff608000000b001e31ee50ee6mr13591164wrp.460.1645393175120;
        Sun, 20 Feb 2022 13:39:35 -0800 (PST)
Received: from [192.168.0.133] ([5.193.8.34])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm5832802wms.24.2022.02.20.13.39.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Feb 2022 13:39:34 -0800 (PST)
Message-ID: <6212b516.1c69fb81.39f0b.3720@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <donationreed@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Mon, 21 Feb 2022 01:39:27 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TO_MALFORMED,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen zu geben
der Rest von 25% geht dieses Jahr 2021 an Einzelpersonen. Ich habe mich ent=
schlossen, Ihnen 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende in=
teressiert sind, kontaktieren Sie mich f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den untenstehenden Link mehr =FCber mich lesen


https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email: mariaeisaeth001@gmail.com=20
