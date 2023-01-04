Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1B65E0F0
	for <lists+linux-raid@lfdr.de>; Thu,  5 Jan 2023 00:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjADX1a (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Jan 2023 18:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjADX1K (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 4 Jan 2023 18:27:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493431C412
        for <linux-raid@vger.kernel.org>; Wed,  4 Jan 2023 15:27:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so2328432pjb.0
        for <linux-raid@vger.kernel.org>; Wed, 04 Jan 2023 15:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/5j0HMIROp/JxV6/R9sjnLWhlmItvlsfO7Z4TUm1OQ=;
        b=a3bfWfEv6ILrN2PRlQUfewcOfEar5b4AsXAzrxi9n9fBjzDw2/5hnkybB/+odJ/ohA
         65S6PzdA8DpOVfEjQEiiL5H26QC0RBH49QJQIOGpYecmnGA+nEOoaKHS62C4ufJ8VyNx
         dc7N5shoulOx2X66RJR9tujxWyltmUdAyssx6CicB/I0ycHLPFluaK7KDVASTlsxfCla
         iOqcRlfyIQr1/GKtTPw7QNeqG4Amgjhnn3pJqsPQ1xGucrHW5GZGinGyZH67xofxhXSM
         zoX+QWges9grhZKlheNJxihnnaTX04g8aOGk9D7FEc5btz6QXj5kL/lmUCFT/1tFNmGP
         sGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/5j0HMIROp/JxV6/R9sjnLWhlmItvlsfO7Z4TUm1OQ=;
        b=UI1WeqKt+1vLAHPaMKBy8CY96BCl0831eGrCeO2TXN+cMDoMoRlgagAQ7NfQSsXyvH
         FkvfUHaA5cXsfjeHFOLaN6Tr/7AjHN62KwzP9GMKCFSO03ZDW3rX54+5ykI9l8mKNxlT
         pjx6jezQBJ6+kGkkgkV2/Vy03RyY6GnJKSPrg+fNtcAfcJCU1rYtWlsepE8u4+9YfNzn
         DGq8Jv7MOUiiKxSLYAkppRAAPO0jrPTZ8y49wgtch5De4RyRkbpcG0Idrd3gSJZPcpJb
         FmL588pNr6jO49morbwrAcD1wAmSxrGZaFi1bEUKuMTHzfEP9BeWEdBVJQ150CfVP0sB
         chfQ==
X-Gm-Message-State: AFqh2kpX8vJM/7u9XT3QNF+jev/I+ltGcEBUGP2i93+vFA0ufSaJlWQY
        Gi6+K8IBiA7QdiojgTW0ujm0+yEdTBDwPLia6YA=
X-Google-Smtp-Source: AMrXdXvLNBgEv25uQ9FV9ilN/NVaSESZDTSCn37lTsUvlhk0BfGcpuezz/T8fGib/m8PAB9meuvCpNgSlG0Ei0WDSgY=
X-Received: by 2002:a17:90b:302:b0:219:455a:f232 with SMTP id
 ay2-20020a17090b030200b00219455af232mr3787684pjb.140.1672874826842; Wed, 04
 Jan 2023 15:27:06 -0800 (PST)
MIME-Version: 1.0
Sender: gabriellealgernon20@gmail.com
Received: by 2002:a05:6a11:c9a8:b0:378:e553:a6d1 with HTTP; Wed, 4 Jan 2023
 15:27:06 -0800 (PST)
From:   Hamza Kabore <mr.hamzak252@gmail.com>
Date:   Wed, 4 Jan 2023 15:27:06 -0800
X-Google-Sender-Auth: FpgqH3dj1AMpd6AqKF5xMZ8Iyxc
Message-ID: <CANofRNuOCQpjYCmwgRkJWPq5dp_UwHrudOPoRqKJLv1z5Tm3iQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,NA_DOLLARS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

I am Hamza Kabore and a Banker, I want you to cooperate with me for
the transfer of a deceased customer's funds which is to the ton of
Twenty Five Million Five Hundred Thousand US Dollars.  Please contact
me for more details.

Kind Regards
