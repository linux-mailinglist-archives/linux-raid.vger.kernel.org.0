Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF37926E2BA
	for <lists+linux-raid@lfdr.de>; Thu, 17 Sep 2020 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgIQRn7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 17 Sep 2020 13:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgIQRni (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 17 Sep 2020 13:43:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D6AC061788
        for <linux-raid@vger.kernel.org>; Thu, 17 Sep 2020 10:43:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so2966814wrp.8
        for <linux-raid@vger.kernel.org>; Thu, 17 Sep 2020 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wON0dKFle54/Y2jT4odl53a7vPSakIOfhvPMR/qdfZM=;
        b=0U5E2y74/NgCBUF32OQkOzDHBQpyrwFh1SIRnf2O44YCfzRhHRvUDT+Al//2GmPOk2
         cOKadKAvcVK+/JcHRU112AWWLrw88Uqk0wjRLN0W3mx3WKQsIiNVfGaBkko8IVdfEjKT
         LcQgKi+hsR2vCqHut2dj2ROFmojwKLXb9Hleuv5KXofEj/amTTS0csKABfuqX5oU0P8C
         uHfd9UfQeLU33F1oCi+CCVW3+rARqpZBUc780xDrCukgN1lOFwJHCA2FU6T8y2UM6Mvc
         2BTd1aUXcQ8w66xPxqxK+pJSl+RGH3ip1VBvqMIOSmpM14V0JwEPLU9z+VkCt9OL6X4z
         R3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wON0dKFle54/Y2jT4odl53a7vPSakIOfhvPMR/qdfZM=;
        b=GTUaHIkz6WvGMNTYG3CtytFA/mLZ7SmHSRe+EzSMw1JhKN3FRoRmaKxgsh97qWA0i0
         PCnEyDopHjwOQwyyeC9Kli5iK43x56nEmr2oQSlqWDC2Y4FGq/fLGi8XV0vj6dwwGTDB
         1zZNBPnTkiy6jhDUJ3+/nroou+zlKXhkUVdhQHZE6u1dqOFDquckXQ+K0LqJerimfGGe
         EOGNTpgwfNftnebKF25Uu8y5BjvmqOZdZdk5At2F8wyr7CX0FWYvyaVPa6XEF+1Y2UQh
         Au+4pTWDPP8FSRE4s4kBzzHCUZ7f40K9NWUOGSu6iNZ9Ij3taCHCLc/DNokvja94bFLr
         pCag==
X-Gm-Message-State: AOAM533WYf8v+acpYvSB5wCBaZp1oQ8E9tlQB5CsmTBJrawgvz5XcAGh
        ABI8nLtLqVTyC5BcXluBThcteLtvRgKnwKbMCTCyaw==
X-Google-Smtp-Source: ABdhPJxlzZ/5cKjv3zYTIETJG3QeH9/okYQv6QOZh8IVXdbdp2iDyXieTem9Ya0HI9hx9oylH+cblYAnVCMv2mM8aAg=
X-Received: by 2002:a5d:4811:: with SMTP id l17mr34678059wrq.252.1600364615961;
 Thu, 17 Sep 2020 10:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
 <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz> <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
 <695936b4-67a2-c862-9cb6-5545b4ab3c42@xmyslivec.cz> <CAJCQCtQWNSd123OJ_Rp8NO0=upY2Mn+SE7pdMqmyizJP028Yow@mail.gmail.com>
 <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz> <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
 <4b0dd0aa-f77b-16c8-107b-0182378f34e6@xmyslivec.cz> <CAJCQCtQWh2JBAL_SDRG-gMd9Z1TXad7aKjZVUGdY1Akj7fn5Qg@mail.gmail.com>
 <5e79d1f8-7632-48ef-de56-9e79cba87434@xmyslivec.cz>
In-Reply-To: <5e79d1f8-7632-48ef-de56-9e79cba87434@xmyslivec.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 17 Sep 2020 11:43:20 -0600
Message-ID: <CAJCQCtTR1JZTLr+xTEZxrwh8xSfb+zpKjc+_S2tJGFofVMUdSQ@mail.gmail.com>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Vojtech Myslivec <vojtech@xmyslivec.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Song Liu <songliubraving@fb.com>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

[Mon Aug 31 15:31:55 2020] sysrq: Show Blocked State
[Mon Aug 31 15:31:55 2020]   task                        PC stack   pid father

[Mon Aug 31 15:31:55 2020] md1_reclaim     D    0   806      2 0x80004000
[Mon Aug 31 15:31:55 2020] Call Trace:
[Mon Aug 31 15:31:55 2020]  __schedule+0x2dd/0x710
[Mon Aug 31 15:31:55 2020]  ? finish_wait+0x80/0x80
[Mon Aug 31 15:31:55 2020]  ? wbt_exit+0x30/0x30
[Mon Aug 31 15:31:55 2020]  ? __wbt_done+0x30/0x30
[Mon Aug 31 15:31:55 2020]  schedule+0x40/0xb0
[Mon Aug 31 15:31:55 2020]  io_schedule+0x12/0x40
[Mon Aug 31 15:31:55 2020]  rq_qos_wait+0xfa/0x170
[Mon Aug 31 15:31:55 2020]  ? karma_partition+0x1e0/0x1e0
[Mon Aug 31 15:31:55 2020]  ? wbt_exit+0x30/0x30
[Mon Aug 31 15:31:55 2020]  wbt_wait+0x98/0xe0
[Mon Aug 31 15:31:55 2020]  __rq_qos_throttle+0x23/0x30
[Mon Aug 31 15:31:55 2020]  blk_mq_make_request+0x12a/0x5d0
[Mon Aug 31 15:31:55 2020]  generic_make_request+0xcf/0x310
[Mon Aug 31 15:31:55 2020]  submit_bio+0x42/0x1c0
[Mon Aug 31 15:31:55 2020]  ? md_super_write.part.70+0x98/0x120 [md_mod]
[Mon Aug 31 15:31:55 2020]  md_update_sb.part.71+0x3c0/0x8f0 [md_mod]
[Mon Aug 31 15:31:55 2020]  r5l_do_reclaim+0x32a/0x3b0 [raid456]
[Mon Aug 31 15:31:55 2020]  ? schedule_timeout+0x162/0x340
[Mon Aug 31 15:31:55 2020]  ? prepare_to_wait_event+0xb6/0x140
[Mon Aug 31 15:31:55 2020]  ? md_register_thread+0xd0/0xd0 [md_mod]
[Mon Aug 31 15:31:55 2020]  md_thread+0x94/0x150 [md_mod]
[Mon Aug 31 15:31:55 2020]  ? finish_wait+0x80/0x80
[Mon Aug 31 15:31:55 2020]  kthread+0x112/0x130
[Mon Aug 31 15:31:55 2020]  ? kthread_park+0x80/0x80
[Mon Aug 31 15:31:55 2020]  ret_from_fork+0x22/0x40


*shrug*

These SSDs should be able to handle > 500MB/s. And > 130K IOPS. Swap
would have to be pretty heavy to slow down journal writes.

I'm not sure I have any good advise. My remaining ideas involve
changing configuration just to see if the problem goes away, rather
than actually understanding the cause of the problem.

---
Chris Murphy
