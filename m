Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31474337A3
	for <lists+linux-raid@lfdr.de>; Tue, 19 Oct 2021 15:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhJSNtY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 19 Oct 2021 09:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhJSNtY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 19 Oct 2021 09:49:24 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97628C06161C
        for <linux-raid@vger.kernel.org>; Tue, 19 Oct 2021 06:47:11 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h27so12679037ila.5
        for <linux-raid@vger.kernel.org>; Tue, 19 Oct 2021 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EBHbP83/CZFp2F2gENfmEXu6m8S2pw12piuqN6IlINY=;
        b=ZsAOzwyLlgDVlbVPtDw9FIUwyEcAkGx+TYvLvCLXpxN+DpWGajuXmJTjrVOKSE1fGY
         hkIzcZddQ+t5QUmnlvJ5CSV21VXEL+hRY2bYPUa2uUvaxYkMVeN1XZbbp728niW/BNTP
         lU5Y9Uu/Orpa+FIwgtbJq/vxPhfWIuxGO3YQvr2UDC2L064PGuAEu55cP2bXnqTefKF0
         3VXcAMdnmRtDxRX5eCsfPs66LuVLnGUr2LnsZdQzFaLYEEpdEDUz9OK8iOPyzWcHsIsi
         42lI8GOtxTNSti6WUsaDbMeyOGqXXzpWu20ZcCs9UxOGuU8sNcOwQ+f/lXrGsISCZ/aS
         7DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=EBHbP83/CZFp2F2gENfmEXu6m8S2pw12piuqN6IlINY=;
        b=3CjQpqE8AwYmmXHEjXCkPupdhYgTS7NSvpwO7knS3WetcBL5fDI0wjnL+MMGLMy8lM
         u1hp/bDHuNAKnu8YOc2cD7JqG0I0z8Gsu+HpSOB92g8l7p6cuAEoOEg1Dl4yvahCqLtx
         E2XpsmC3mG2z7t+2/nl8Up0EQfFMNtDBE+/Ii7TOr5OxMICwbZwevrmEZMGpFiQIk8Bg
         iYziKa0zo14kGPoMp5A7C2tGKs9OWnmK65XzmhgcvXIUZpAB7oG7robAZfio4EEhJ16J
         lTe2oPco/nVogdZ9xtoMstmPv4upXYCt3mkUVPu6imu8o+UrMSyZFWdnW2Hqykgq0wJu
         JdVw==
X-Gm-Message-State: AOAM533D4nAiWdlBpPfU8Hpfivb8ohIM5TicMWdWMPWYjd7Z8tTA6TkX
        GFzaqinFava6VkaeZwNeCkcDxVwJU99qyXk3mw==
X-Google-Smtp-Source: ABdhPJzGh69HyLy13sBazdpUAfVrPZ0r4GYUCBkDK6UvheMd9HsUBSNbiVr56B5BGsu6tHssemJPrwF4aSgNJdPTHt0=
X-Received: by 2002:a05:6e02:1bae:: with SMTP id n14mr19571407ili.253.1634651230935;
 Tue, 19 Oct 2021 06:47:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:cf84:0:0:0:0:0 with HTTP; Tue, 19 Oct 2021 06:47:09
 -0700 (PDT)
Reply-To: tonysiruno9@gmail.com
From:   Tony Siruno <tunkaraa7@gmail.com>
Date:   Tue, 19 Oct 2021 13:47:09 +0000
Message-ID: <CAA=Fp1Qvd1NBQj-kGh03PQrSitQOUiiY4=BMchJOt3idJfiV4A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Warum schweigen Sie? Ich hoffe, es geht Ihnen gut, denn jetzt habe ich
Ihnen diese Mail zweimal gesendet, ohne von Ihnen zu h=C3=B6ren. Heute
komme ich von meiner Reise zur=C3=BCck und Sie schweigen =C3=BCber die Post=
, die
ich Ihnen seit letzter Woche gesendet habe. Bitte lassen Sie mich Ich
kenne den Grund, warum Sie geschwiegen haben. Ich habe mir
vorgestellt, warum Sie mir nicht sehr wichtig geantwortet haben.
Bitte, Liebes, ich brauche Ihr ehrliches Vertrauen und Ihre Hilfe. Mit
meiner guten Absicht kann ich Ihnen vertrauen, dass Sie die Summe von
12.500.000,00 Millionen US-Dollar in =C3=BCberweisen Ihr Konto in Ihrem
Land, wenn m=C3=B6glich, melden Sie sich bei mir, um weitere Informationen
zu erhalten. Ich warte auf Ihre Antwort und bitte lassen Sie es mich
wissen, als zu schweigen.

Herr Tony Siruno.
