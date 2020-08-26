Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8129253649
	for <lists+linux-raid@lfdr.de>; Wed, 26 Aug 2020 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHZSH4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 26 Aug 2020 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHZSHy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 26 Aug 2020 14:07:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3192C061574
        for <linux-raid@vger.kernel.org>; Wed, 26 Aug 2020 11:07:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b18so2758604wrs.7
        for <linux-raid@vger.kernel.org>; Wed, 26 Aug 2020 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvL1cBvsu7eOptlkTDuIxEaAxqB74Ubc6D2niJ6Bdmo=;
        b=aS5vEatZ+xTwHE1jD2b28ZAfzpPF0cja49mzl6PKiAmIPA/ejL1lDdV+oWIKKDfPHj
         L6K1xe0W9H0U+EA7d1TMhJSKt4E+1jHjL/tUNdqHSt1NwE3DME0F7L8VsMHGJ4w9Dq0D
         Se6ZrtSbrccf/StGKczewvQAeCh3sfyk470YP4GX4kvY5CwRnmt6e7CEUryXaS9gPKi4
         zNr81OHJ+nkymUlZZXyVJsnmb6hci6APRKlhM/7YOPb548hJkfDCHctX62cSeAJyk83u
         lNMS42Fl7RP2Y5JZaqkTXZZH8sJxuHB5g4W4Pd70z+wd0kClrAtbvpLzimwDhCPW08VM
         yVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvL1cBvsu7eOptlkTDuIxEaAxqB74Ubc6D2niJ6Bdmo=;
        b=PzP0gEGzSYsZCjuq5VrYXm84wGNPqJk8o+dbSWnbrtnxRKc6nMm41iQgGBsJo5ytIp
         MG+qTfGyzDV2M2xBO+F4azGxt1ma3XXMzQcBYCp8gku3ju72hOkDpi7Pzzm8fsKJHHN0
         rHLyCgX6vPjYAmbP6fjwZHgrb2XhagHp0rbL7GqlirT5Q8tEVbO2YbZOdw/j7NpVrUHq
         O9NerSzzHFgNlop+pLbaQ6pzylncv/fd/lpadhRB0FaBzVpcIiu6PwWcMvLstnx3L7Fl
         kcpGg4U5A/kJWJBAdd/vuRbIl8/yP5cysaR7s6OEXd4VDsVqachaK7m1aWP5SlPFWXzp
         t15Q==
X-Gm-Message-State: AOAM531uAYw1XJ0ZBZd7BZtakTfdI+DX7Jp3ZxqLewDCs9VWfxQX0zuw
        jCh7rDGzGH2FqD9a9yOQNrMCQANFZHE40ak6fpNHZ/V9d7ruI+G+
X-Google-Smtp-Source: ABdhPJz3qoS9iwFMFvt+DUYB9nrXX6ARmqo5yU1ReziTNjisoNNWuhmKGDRB62j1pX1oq0d0BD982QxekXA9TiY4JlE=
X-Received: by 2002:adf:8401:: with SMTP id 1mr16385913wrf.274.1598465266460;
 Wed, 26 Aug 2020 11:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
 <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz> <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
 <695936b4-67a2-c862-9cb6-5545b4ab3c42@xmyslivec.cz> <CAJCQCtQWNSd123OJ_Rp8NO0=upY2Mn+SE7pdMqmyizJP028Yow@mail.gmail.com>
 <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz> <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
 <4b0dd0aa-f77b-16c8-107b-0182378f34e6@xmyslivec.cz>
In-Reply-To: <4b0dd0aa-f77b-16c8-107b-0182378f34e6@xmyslivec.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Aug 2020 12:07:02 -0600
Message-ID: <CAJCQCtQWh2JBAL_SDRG-gMd9Z1TXad7aKjZVUGdY1Akj7fn5Qg@mail.gmail.com>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Vojtech Myslivec <vojtech@xmyslivec.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Song Liu <songliubraving@fb.com>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

OK so from the attachments..

cat /proc/<pid>/stack for md1_raid6

[<0>] rq_qos_wait+0xfa/0x170
[<0>] wbt_wait+0x98/0xe0
[<0>] __rq_qos_throttle+0x23/0x30
[<0>] blk_mq_make_request+0x12a/0x5d0
[<0>] generic_make_request+0xcf/0x310
[<0>] submit_bio+0x42/0x1c0
[<0>] md_update_sb.part.71+0x3c0/0x8f0 [md_mod]
[<0>] r5l_do_reclaim+0x32a/0x3b0 [raid456]
[<0>] md_thread+0x94/0x150 [md_mod]
[<0>] kthread+0x112/0x130
[<0>] ret_from_fork+0x22/0x40


Btrfs snapshot flushing might instigate the problem but it seems to me
there's some kind of contention or blocking happening within md, and
that's why everything stalls. But I can't tell why.

Do you have any iostat output at the time of this problem? I'm
wondering if md is waiting on disks. If not, try `iostat -dxm 5` and
share a few minutes before and after the freeze/hang.


--
Chris Murphy
