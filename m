Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8268DC75
	for <lists+linux-raid@lfdr.de>; Tue,  7 Feb 2023 16:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjBGPHq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Feb 2023 10:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjBGPHp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 Feb 2023 10:07:45 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C904490
        for <linux-raid@vger.kernel.org>; Tue,  7 Feb 2023 07:07:41 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id g25so437735vkk.11
        for <linux-raid@vger.kernel.org>; Tue, 07 Feb 2023 07:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hZCrZKTJaKHFkgYbRknNmliNod7nxAZfgWs4NlP6H28=;
        b=BNDgpD67jepvnBTdC2YGoVtTvDu78AN81TLJwE1menCZt6z56dR+vMxjlUl0e3Ga5C
         36QLSvAXdYpLqsXvjKjvuKJPYQVlM736v9wNoW4rDMlvmD0//K78xCB+veR6dJwHrzra
         GmamWCQMQA3pbUeaMHrvyTV4O5ehOxF0NXTb3Qk6/g1qYliHnm4a7NAmqzbRTL3StzaQ
         gdXIFuOHtcKVQQ6HCwlhpWFArIiPdCPwhcxjY1LK1WQZJg/6SXas1huDdm/kLYq7SLuj
         gWiDUB80m/sABWBQVMOIJ4Zg+LU8MQ7CZ11u1wvQJFH/MhJtw8YagxREPHyi4vVhhhJ0
         sEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZCrZKTJaKHFkgYbRknNmliNod7nxAZfgWs4NlP6H28=;
        b=VJg/+vD4bD0764Om5D1G/EfWu+joehm6h/AF/QDaZe5L3tNJwFxdMxKSBXVSm4OfiA
         fSFnLpZAqzCNwj+ix2HKh94ZYa/Ra+sEem9chKW2T/v8E4vg9FQiP6n4LiXcclaQ0gnv
         BzbqkLld9i0keWBF73uqvMre3EJZTK2K4M8I5HiZvk4hVYgbXPXoEPc6BTxmIubkbapV
         5t1DqsbrQ3iQmXH2slU//xJorx8zelt24eQvimRDXZtFzPrHS2UIeXJt+5eVVZzLe7l9
         Bq5RPlKll5DbJwFgpknN01dDJ/+ooWZCbdiAwSQrj0JG37ia+R4RwkT0rYtwkUobtXKE
         iu1Q==
X-Gm-Message-State: AO0yUKUwn6X0qxAUiBHM3XKpyvvR8fCi3dXRVLqpSl1pGp7sSBX9x9uX
        L/609hFMrqBZ0cLqosAEkfVS7NEW/ImSUJXucag=
X-Google-Smtp-Source: AK7set8/9jrENWAsSR/anTjmf67dPxxRr0m8dTKwZF+j+PSc4gWNRMjv1nt9YdIyxyBOsVkk2Y/AtHOPHeUayjvgp1w=
X-Received: by 2002:a1f:abd0:0:b0:3e9:ffc0:fb54 with SMTP id
 u199-20020a1fabd0000000b003e9ffc0fb54mr531404vke.9.1675782460752; Tue, 07 Feb
 2023 07:07:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:c145:0:b0:37e:13d1:8774 with HTTP; Tue, 7 Feb 2023
 07:07:40 -0800 (PST)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <david12aketi@gmail.com>
Date:   Tue, 7 Feb 2023 15:07:40 +0000
Message-ID: <CAEqccGGZnn30Q0+6=iEguqd7E+zoe-zNSRP0xJGM=7S_NGt4hw@mail.gmail.com>
Subject: Jeg er stadig overrasket over
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

De bedste =C3=B8nsker til dig og din familie. Jeg er stadig overrasket
over, hvorfor du besluttede at opgive din familiearvefond. Jeg vil
blot informere dig om, at bankmyndigheden ikke er glad for det.

Jeg venter i =C3=B8jeblikket p=C3=A5 at h=C3=B8re fra dig for flere detalje=
r.

Venlig hilsen,
Ken Lawson
