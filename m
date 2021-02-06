Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EFA311DF7
	for <lists+linux-raid@lfdr.de>; Sat,  6 Feb 2021 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBFOwZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 6 Feb 2021 09:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBFOwY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 6 Feb 2021 09:52:24 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00DC061356
        for <linux-raid@vger.kernel.org>; Sat,  6 Feb 2021 06:51:53 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id f14so17621034ejc.8
        for <linux-raid@vger.kernel.org>; Sat, 06 Feb 2021 06:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=feZdFRPD56q997lBF1inxzL6tpJ5HySC+zB7qnpTiGVNwQidNZP2LrFSDXMZaE54WB
         3D3sQ+nkRQgxX5J4voZy+pdvd1fnrshS7MUq2V8gy0UtwmtkLu7lBg+74rl2iejAlIjx
         d7YH6tlG+LYqzdk7QO6FfPSlPVDytANoOXSrdLOHjDSTRCPYSsIzYvbH0gVGnerU4f1c
         RmOGGHl91r2qmTCiEfI+l0NogCdZ2bd49ixcIkH9zfA4JP1hrEavd/qjZ1h05XMwYCRq
         dFNTBMET9RfnX7nYrpMTQKbCqX+URR92kl1uj4UfeK9y+Lr6Bs6Usl7JJcGLo/tbiQ/I
         sxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=g4PbgufuKkMhGI8PhMXywqMf/yxXfRc2862Fj3r/78KPWM8KRZgBPnHiX+5i0fA8gU
         XPzjAhf6Ofo8IyECTG6l/lnYgSa2YtMs9thqwjKiTFhn1vQXJdy85S5v/Yy9qbamTPLd
         oA7kN8Vkf5Vv0uP2y6kNCRbVJ1BkVXJxF4kBiCxlE2OzIkwmsUjdrDWlEz+QE6U155eL
         oxlAY5Q/w0f4v8QQkbsf9/mF9ZSYJbfO26pvrnycKtXhmF+6OIIJas1NpT7BSyMbnF8P
         dP1EujyW202+7CC29nafaYYhr49yBx2oZmBW4zss7ODTl3sqDkNn4J+3fUVthnHiqAMN
         wzug==
X-Gm-Message-State: AOAM532V+hJP6u+mSTcW/VtQfnG488nNWdmehYnhS2JnBTh3WfjTLayT
        tLn7SgZjuLpS90dBkoUC4ewAUW88d755WWn1ZCY=
X-Google-Smtp-Source: ABdhPJwwpWd3HUX3uttPmVXj5LGvficFt7WqKB8tmfGxM80WTX6yXvmDzPq50v2d8We/4YxWEcECuDiAa2NBeCpnCtg=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr9409893ejb.138.1612623112159;
 Sat, 06 Feb 2021 06:51:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:51:51
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:51:51 +0100
Message-ID: <CAGSHw-DYBkRefVUZ5e29CJnEjdwJ+rcbSw+61YD_EBaXyZNWxg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
