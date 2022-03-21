Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9364E22FF
	for <lists+linux-raid@lfdr.de>; Mon, 21 Mar 2022 10:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbiCUJMg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 21 Mar 2022 05:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiCUJMf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 21 Mar 2022 05:12:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EAE2E08B
        for <linux-raid@vger.kernel.org>; Mon, 21 Mar 2022 02:11:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q8so8362806wrc.0
        for <linux-raid@vger.kernel.org>; Mon, 21 Mar 2022 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=hJ6vnRkGqf7o3va/KYBtaxPfYuk6B8FxppLseSIcVuI=;
        b=lQvRMtcl3qcBL7hMkPoAosHbBlM/h4uosEDw0vSBaIFyE3cGnVHbqctG6iYFNSYVjN
         GA5QyZGMERnVD2iKMETCFooMYaN9GsF5Nhvy+9DpgBUFAilZenjs/BDx3rFzCKeC7jd0
         BmtxCRlELJfF2mIJSKbajBit/KojCulsyzms82LPm764TZMZQdgIAT5ELCC+3so47091
         SxejfugkNSBUN9A8ds4PopEs3ql518kN7V4y/aoHocsXbIdDm57xeelP+bI1zpSCX+K9
         hHyc2uUMJbnjgT/H1n0PLqtV+sObism0v8vU0lIYX7fF7ScEQl72xX7kpOEpnw42MDpP
         mSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=hJ6vnRkGqf7o3va/KYBtaxPfYuk6B8FxppLseSIcVuI=;
        b=e6qaObG92coYfLzjMn6DB+Is8FjlO4uqBK+W4WXpyWBtEGmTjxc6BccYNkRJkTLtjr
         rOSy/Wida9kXWV+XTL/1Lr1A6jKnSd21fbIvU930X3ATcCpwukcpV1fW8GzVgwjv4miv
         TRc99SIjkjp4HVPmiHJmNWB46O5H3OFfX1SkPuv7m16Y7PgtHncQrpKki8bHxak7IZgU
         fmaFKFCKbY8jYhmHfRU5OGb05z/sznbIWTAnPCHRqE5bgC8XvemAQD6T1vZ8NElMpCn2
         vAcKMOK2fAcXQCmT9dMdk0rAaH97LW7tNVW4jimd9MKi4J1l9hYphHhwnAjIBR8A70R/
         WVXw==
X-Gm-Message-State: AOAM530qnoA73ptKwqciNzak9ROuHzfuuX1RTEwEwi+/sX/Pi2vhZUoc
        MhG1sLQHpxKJloIKVXQr8oA=
X-Google-Smtp-Source: ABdhPJwp546fzJeHdKNNPaHHGrlWKF76dFCC3AVse1qihUxUfoqTAUB5rV5sBXyuot860my3C+5Aww==
X-Received: by 2002:a5d:6581:0:b0:203:f786:f9f6 with SMTP id q1-20020a5d6581000000b00203f786f9f6mr11952427wru.702.1647853869507;
        Mon, 21 Mar 2022 02:11:09 -0700 (PDT)
Received: from [192.168.43.30] ([197.211.61.62])
        by smtp.gmail.com with ESMTPSA id k9-20020adfd849000000b00203d18bf389sm12318100wrl.17.2022.03.21.02.11.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 21 Mar 2022 02:11:09 -0700 (PDT)
Message-ID: <6238412d.1c69fb81.dcd56.d9f6@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: meine Spende
To:     ricehajara@gmail.com
From:   ricehajara@gmail.com
Date:   Mon, 21 Mar 2022 02:10:56 -0700
Reply-To: mariaelisabethschaeffler70@gmail.com
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschieden, 1.500.=
000,00 Euro an Sie zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich f=FCr weitere Informationen.

Unter folgendem Link k=F6nnen Sie auch mehr =FCber mich erfahren

https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria Elisabeth Schaeffler
E-Mail: mariaelisabethschaeffler702@gmail.com
