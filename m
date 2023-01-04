Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA865D359
	for <lists+linux-raid@lfdr.de>; Wed,  4 Jan 2023 13:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbjADMz2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Jan 2023 07:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbjADMyz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 4 Jan 2023 07:54:55 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0371DDE5
        for <linux-raid@vger.kernel.org>; Wed,  4 Jan 2023 04:54:53 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id pe2so16230721qkn.1
        for <linux-raid@vger.kernel.org>; Wed, 04 Jan 2023 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=BQfo1+41q2NZR57Q7BFlMODaOza2AgrRvUpAp3daCd4t1w84OEhFtXAM1g7CkVTr/y
         mvXWkJvXCDM96Iy3cSf9E37Th3uZX5TzmwlIsHFzK3DAyLuSjJ8d3uR9drr/ahkzPGkt
         iW+sw+gZOJCd7bumtfoM4UR2xOfXz6tdmGq2f+IJJhoSBazdofAm5Gs9PxuweXnk264c
         knSGf1CtrqZScdeov1GoaGbl2sApMUXYjJGPCObPVA0UTlHx2t6+wdp4VOKHmsqLWM8X
         lQt15zqigA6uJCG+q37n0r4mLK1MKtsniT1i9jhRA9qlN9E2Mf0sYN4W9Jd0n+39BoCK
         yzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=iFMHr74HFZ2R6TefZeVMGO07anPfrPlc3PqbhPmRmrcYd1pOkyYbxB65PwagzWM1og
         fmPIU1A0ziq0fU/NI0FADG936PPXZA9KzZnygKEwuXdz9PpK5WUTvBqh5nuYbhWlne75
         ggZ6dPHo4WxzapR5Sll31rP/4oI9FtrZ0jvPwAn3qsVZ58ErKL5No4dI9pfw6zFwHlsk
         5IPjpnD4Di8BkJ8AMP90z5qU9hugpLB7OG0JQKszL1Mdj+UK6qmdaniuxGI5vM4y9vg0
         0fpz999ct7RzXLluyH9XrJSj8rDGy+60WdWmsdoo4w64RWI0PKjQJKUwvpuqhgYm3aMD
         v/nQ==
X-Gm-Message-State: AFqh2krHqS9vPChqCNqqOBRG2NQ7kr+d76KldfUUnrfXNg6hskguJvAv
        zThU30k9EPG9qeDaMAr4PYw1pLI/3UOjYHF+8EzngqMEvy0=
X-Google-Smtp-Source: AMrXdXuKXTvNK0aSB9vnyjtdhrZfKmRzvU9Jw1W0zhcD7x19AMFVNgTh5oL+8ilZBOfTDf/bL64QVz1mYULxa/ftADs=
X-Received: by 2002:ac8:568a:0:b0:3a9:688d:fad2 with SMTP id
 h10-20020ac8568a000000b003a9688dfad2mr1976067qta.646.1672836882017; Wed, 04
 Jan 2023 04:54:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6200:5d91:b0:4a5:78e9:2012 with HTTP; Wed, 4 Jan 2023
 04:54:41 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <mzsophie@gmail.com>
Date:   Wed, 4 Jan 2023 12:54:41 +0000
Message-ID: <CAEoj5=ZpJ15GRz-U33Ocbu5-P3Va+3bNv3476+mmJJ52cwx7tA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Seasons Greetings!

This will remind you again that I have not yet received your reply to
my last message to you.
