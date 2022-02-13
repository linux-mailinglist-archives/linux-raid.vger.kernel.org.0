Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142884B3A4D
	for <lists+linux-raid@lfdr.de>; Sun, 13 Feb 2022 09:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiBMItj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 13 Feb 2022 03:49:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBMIth (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 13 Feb 2022 03:49:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6A65EDCD
        for <linux-raid@vger.kernel.org>; Sun, 13 Feb 2022 00:49:32 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w2so4042618edc.8
        for <linux-raid@vger.kernel.org>; Sun, 13 Feb 2022 00:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=RgNQfOJU4KGFJRpxfHG4Kbbmn3T89mmisaSsxlnizAUJ4AmJe68u+A2LYUWBcdNdqg
         PMmZ+qfV326CysbnjM8IOMGZ0OhHILu0wXG0Tge3UFb/FiR0zbCRl4fEzxvMSWXQM7V/
         NnOdqGsiA//vT5sk4Xlnr3gN/BTCfDxLhBoveXiXPJ1tNmceTpKy0BvPNDALaWELH2nu
         ge484iexd2jvNjNhCYyBv+filmdMnv0qAth2IhyT1+vdPqUaGtfLbGXOYyY8oVJkV3Lu
         06RK2+Jjo+jKSglfnajRTk6iF0V/LHrz8ECijrgxexBwscvSUBPEbw+CNBDpQJft20N9
         JUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=siF/ZlRTxuwRsRXURn7exZCg1gG/hcj5ATAFIUww4NyuZ9LaLUWoOLRJGPdvhUAgke
         ACZUfOTFj5jmCDETRH0CWB8YtdnrWVe2zt2W81vZ1F4m1A3DdLfZoG0wgeriGSJu1/ny
         xFHe8M63nggLQSCTQww/IYQhhBz5NNd3fiitRjx2+8kibMAYtFnQAcpj8iRoHMkX1bO0
         c1S66+LD7wDkOLEBAGpcNLUV/DfSKH5VTK1lspbwQU9ic6m8t+YSmA11nOLnKKe78znK
         E36ReykbZ5zRNm3j5nkPcTzK9M8cg+/DRI/PPTnbNUoKQdkLyI1KRv0yGi01FHhZhtvw
         bHIw==
X-Gm-Message-State: AOAM5307hTIvYo5da2/uchg3I4+xOQUXgbdsTdRLnX85dVXh3OZS4D+Z
        onT/oTPTPY3iADLAvS+6qtIubkxNiltVz22uCmw=
X-Google-Smtp-Source: ABdhPJzyFpvnVcaRmG4gX3V7+JjVe8tHVF91YR+WrzD1oOxfZvduLJUINiPoGeZfnhyBoRokKNpzi7stt44R3EMOkVM=
X-Received: by 2002:a50:fb85:: with SMTP id e5mr10042267edq.91.1644742170876;
 Sun, 13 Feb 2022 00:49:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:42d4:0:0:0:0 with HTTP; Sun, 13 Feb 2022 00:49:30
 -0800 (PST)
From:   Ulrica Mica <ulricamica771@gmail.com>
Date:   Sun, 13 Feb 2022 00:49:30 -0800
Message-ID: <CAHHQOPfpZEkSBK1=HW=HJBshef8sjo-99RiWEooZqLb_xWH66Q@mail.gmail.com>
Subject: good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

-- 
Hello dear
Can i talk to you please?
Ulrica
