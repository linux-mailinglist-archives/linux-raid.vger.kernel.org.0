Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBFE660B32
	for <lists+linux-raid@lfdr.de>; Sat,  7 Jan 2023 02:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjAGBEG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 6 Jan 2023 20:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjAGBEA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 6 Jan 2023 20:04:00 -0500
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E661B83187
        for <linux-raid@vger.kernel.org>; Fri,  6 Jan 2023 17:03:59 -0800 (PST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-1441d7d40c6so3400657fac.8
        for <linux-raid@vger.kernel.org>; Fri, 06 Jan 2023 17:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=Ui1nZAQwen1JZHhk/UNb1oDDJUikJKWwSFDQT7fDxIdrjTsFTfnr65aD0MQpJxZuMF
         RmyXYHMc9Ky4LUKKCV35cfXeVKg9kcUaSr4tiVZgaqF5EFPOnEzUzKBi95ahnFWEJuB/
         wikAeNAEQCrGUuHayT33w+2rQ4+HBUUxhxKBasC1xNVeOOKwbrPJi4n0XGoiGNV0Ta5k
         CclCoy5QAcIdpNT2BCRseJKd9epac9YGs66Cgc9nZMojVBhKvtImHmE+ZbhBIfigRiBi
         98nZh86gtiJqweGJlylRyzSsCuKNMTFPzlfmr38W444ZCFDfVUVeCB+li6CwVFx/Asvw
         l86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=XTZSFj8VmhUQZAF/pdRPOxsLkQ4U5Q8IGlaorcXZI/FAfNUWnj/c7YM39rbTmegqmR
         iMRYbEFKUU3bfkAkFXuIoS6KWLZ7DCgET39EN9Amdwp500x55FOfU3V8Y8rNW0uKVE7i
         d5YyeOi4fy88wHyeDTCznt60IeGIWoMwwp0754ax5ScYpPZT/wPKnHx4as6NptMdc4Yy
         dzw+ct7bGTuyCiDUqvf0o9qDpLB8usqIfHJqxkHcOqnKR+X5UrpaR9DETteyVtCvyZg4
         fw9e0IlrHtQZ2jor75W0BSGrG4Uwakr3Xki74avgavFyZfcLfexWEPw1petagsGRqbsi
         xoMA==
X-Gm-Message-State: AFqh2kr5xc63DRMOOUmb5Y+R4pdpukD3cVtC620cfqqrDFNqyhBbvvZu
        cPo0p6FUs3kiUAwzoP+k91HpRvUBUI5MUvHBwj0=
X-Google-Smtp-Source: AMrXdXuy6RV5DBW3idauFhx1utsKIy/tzX1PwuIHZiENrh5zCMKQgqD9oBX+tZBveG7/3LbSFusOjNssMxTFlJ2Y1NU=
X-Received: by 2002:a05:6870:4b8d:b0:14f:d35e:b7fa with SMTP id
 lx13-20020a0568704b8d00b0014fd35eb7famr3510003oab.222.1673053439258; Fri, 06
 Jan 2023 17:03:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6808:2387:0:0:0:0 with HTTP; Fri, 6 Jan 2023 17:03:58
 -0800 (PST)
Reply-To: jamesaissy13@gmail.com
From:   James AISSY <samueltia200@gmail.com>
Date:   Fri, 6 Jan 2023 17:03:58 -0800
Message-ID: <CAOD2y7mxfJEiJcw8zGx8n6ktU0yeDj2shbDio9PsogOVj9NGZQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Hello My Dear,

I hope this message finds you in good Health.

My name is Mr. James AISSY. I am looking for a partner who is willing to
team up with me for potential investment opportunities. I shall provide the
FUND for the investment, and upon your acknowledgment of receiving this
Message I will therefore enlighten you with the Full Details of my
investment proposal.

I'm awaiting your Response.

My regards,
Mr. James AISSY.
