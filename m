Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895F1AF9E8
	for <lists+linux-raid@lfdr.de>; Wed, 11 Sep 2019 12:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfIKKGo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Sep 2019 06:06:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40412 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfIKKGn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Sep 2019 06:06:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so24541435qtq.7
        for <linux-raid@vger.kernel.org>; Wed, 11 Sep 2019 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TDsHwFaqeLPUP+aN+GOzvJWkdinR+TKu4EJVVJVf9k=;
        b=SepWo+gv3rgUeQnHQmxEikQowVMsHLa/4Kf9ueKZn73euaOvhf+uyoN+E0V9kieoFw
         Sb47YaNct+/r6traWamkJ4wyjIFpmwruXwq6CZgQ49yFGLBhmQLoPo637mWrQHx58T25
         QPOLG481xmwX1SRI4sqKhQtlII5HMg9vtwPiuSa9iCM1+Vhd59qxZc82Ds9qATWtTafw
         /OPDPKwxGtK+RJVGYOGqy8bFbtHfsmZSceHfGKSMMMjkMKL0yiDs7S8sAa+F1Ey7inbh
         rAPOlpXd9jy5RqccbJcaBglzgU0kWN20gVoxk2DTyufXhLRMPShzk+XCz+PtYmCNofOU
         N1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TDsHwFaqeLPUP+aN+GOzvJWkdinR+TKu4EJVVJVf9k=;
        b=I97cszXZ0iBKPgBxkLgzc9dkKS/JaB3Kuvn7eVWBri+Tj47WJykMyWIkednB82zjQJ
         GJks5LZ8NsAlX6+yrIdcqs5H6kHLgVo4+ajsp0i11Cu26kEw9A1KYAsdVcIl6hIwPUnH
         7yOvmc7q4SwQawkqazbpClUGDM/27Smd2NEZmsL4Ff6MWqoyAa5S2vjY8Ss46xC+A8BT
         LhaNW0tBOK5YWFKGAkioHiViy3TKY5y2KUvG5aMMmPDefjsNc8o8xMB43ELAidXI1Sz2
         IqS3YSiSA00vD/XG0qZgzoPQzqoRNzAroSAu5FvJGU3cVKpAIYgBio0TcCrFoh8wOxRO
         5e+g==
X-Gm-Message-State: APjAAAUJeEFfRULvZRwHS1cWv9hEGponufhPqWYA4Gw4v1u4K0d7VE7I
        LayyyP48z2C9Z0W1XqJyYR6NbRaBKMFAf84WfOc=
X-Google-Smtp-Source: APXvYqwgDDmwDkQnc9XlAXcUo0uU0fAlcQ3LwJijD7Q+h0NbWbymM1PvemLN5Uet33/dW7Lavxx1HFSYIqJeaxPpC3Y=
X-Received: by 2002:a05:6214:15d1:: with SMTP id p17mr21789551qvz.74.1568196402217;
 Wed, 11 Sep 2019 03:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190911080629.5180-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20190911080629.5180-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 11 Sep 2019 11:06:31 +0100
Message-ID: <CAPhsuW4yU880QGa5ZDXoW0R60q6Cwbyqfe6HyfHg+rqXK17pDA@mail.gmail.com>
Subject: Re: [PATCH] raid5: don't set STRIPE_HANDLE to stripe which is in
 batch list
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Sep 11, 2019 at 9:07 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> If stripe in batch list is set with STRIPE_HANDLE flag, then the stripe
> could be set with STRIPE_ACTIVE by the handle_stripe function. And if
> error happens to the batch_head at the same time, break_stripe_batch_list
> is called, then below warning could happen (the same report in [1]), it
> means a member of batch list was set with STRIPE_ACTIVE.
>
> [7028915.431770] stripe state: 2001
> [7028915.431815] ------------[ cut here ]------------
> [7028915.431828] WARNING: CPU: 18 PID: 29089 at drivers/md/raid5.c:4614 break_stripe_batch_list+0x203/0x240 [raid456]
> [...]
> [7028915.431879] CPU: 18 PID: 29089 Comm: kworker/u82:5 Tainted: G           O    4.14.86-1-storage #4.14.86-1.2~deb9
> [7028915.431881] Hardware name: Supermicro SSG-2028R-ACR24L/X10DRH-iT, BIOS 3.1 06/18/2018
> [7028915.431888] Workqueue: raid5wq raid5_do_work [raid456]
> [7028915.431890] task: ffff9ab0ef36d7c0 task.stack: ffffb72926f84000
> [7028915.431896] RIP: 0010:break_stripe_batch_list+0x203/0x240 [raid456]
> [7028915.431898] RSP: 0018:ffffb72926f87ba8 EFLAGS: 00010286
> [7028915.431900] RAX: 0000000000000012 RBX: ffff9aaa84a98000 RCX: 0000000000000000
> [7028915.431901] RDX: 0000000000000000 RSI: ffff9ab2bfa15458 RDI: ffff9ab2bfa15458
> [7028915.431902] RBP: ffff9aaa8fb4e900 R08: 0000000000000001 R09: 0000000000002eb4
> [7028915.431903] R10: 00000000ffffffff R11: 0000000000000000 R12: ffff9ab1736f1b00
> [7028915.431904] R13: 0000000000000000 R14: ffff9aaa8fb4e900 R15: 0000000000000001
> [7028915.431906] FS:  0000000000000000(0000) GS:ffff9ab2bfa00000(0000) knlGS:0000000000000000
> [7028915.431907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [7028915.431908] CR2: 00007ff953b9f5d8 CR3: 0000000bf4009002 CR4: 00000000003606e0
> [7028915.431909] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [7028915.431910] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [7028915.431910] Call Trace:
> [7028915.431923]  handle_stripe+0x8e7/0x2020 [raid456]
> [7028915.431930]  ? __wake_up_common_lock+0x89/0xc0
> [7028915.431935]  handle_active_stripes.isra.58+0x35f/0x560 [raid456]
> [7028915.431939]  raid5_do_work+0xc6/0x1f0 [raid456]
>
> Also commit 59fc630b8b5f9f ("RAID5: batch adjacent full stripe write")
> said "If a stripe is added to batch list, then only the first stripe
> of the list should be put to handle_list and run handle_stripe."
>
> So don't set STRIPE_HANDLE to stripe which is already in batch list,
> otherwise the stripe could be put to handle_list and run handle_stripe,
> then the above warning could be triggered.
>
> [1]. https://www.spinics.net/lists/raid/msg62552.html
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Applied. Thanks!
