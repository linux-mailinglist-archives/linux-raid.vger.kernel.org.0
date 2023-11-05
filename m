Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DEF7E1744
	for <lists+linux-raid@lfdr.de>; Sun,  5 Nov 2023 23:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjKEWBd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 Nov 2023 17:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjKEWBb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 5 Nov 2023 17:01:31 -0500
X-Greylist: delayed 5244 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 14:01:29 PST
Received: from SMTP-HCRC-200.brggroup.vn (mail.hcrc.vn [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7ACC
        for <linux-raid@vger.kernel.org>; Sun,  5 Nov 2023 14:01:29 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id 7677C19B19;
        Mon,  6 Nov 2023 01:58:22 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id 6FE741999D;
        Mon,  6 Nov 2023 01:58:22 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 0DDD41B82534;
        Mon,  6 Nov 2023 01:58:24 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id n1HpmoL084En; Mon,  6 Nov 2023 01:58:23 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id D0C9C1B8252B;
        Mon,  6 Nov 2023 01:58:23 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn D0C9C1B8252B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210703;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=Za2ZJy3X/ISjQ/P4M+Iv6g97JXvQGag4yMTn+Pz4dJ3wDu5RP4IlCdzEI5ZOo6pg+
         D0RoVXW3pVgb/8ScJwyugnEZgPbagnQCJRw6dmsSghqmWIKLfXIcKbyMiiT4Fok0L7
         ly41hBXgUZQPcWVrWH53utPuPOoqBdZS16YTFLtInfKuSF5GATN/OSFtK6nN3BANwV
         Hwv3ewygBFdCbO1C8/uR1X8uINcGfSAHS5UGo1ojLLFNgx6F3zwVzUsYifANht0O8W
         QxO33gXJbvfeungQ3dipE4mAyOW2lCE3fmzckb1GGfeDYmkKCDjc/ZZsMree5cYNYo
         uJduJYSByZsEA==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dwDP7P8Esolz; Mon,  6 Nov 2023 01:58:23 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id 7E66D1B82534;
        Mon,  6 Nov 2023 01:58:17 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:58:07 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185817.7E66D1B82534@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

