Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E05C1A2FF7
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 09:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgDIHZ1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 03:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgDIHZ0 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 Apr 2020 03:25:26 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426B920753
        for <linux-raid@vger.kernel.org>; Thu,  9 Apr 2020 07:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586417126;
        bh=gFT31tbOY9MoFI1az4f28ScjEKLhaoP7njY1y8Yo1M8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0J9ppr5M245+XU0DE4LuE0IhGP9P74dd+p3m41SwqPK6eonJZneCc8p7LVW85vk1Z
         TTD+2nNeIXOEISETqKpramDrmNYfE4qg4y5468XgdgeUYF1FVn/52eAifCDbfx6TWm
         +fTUYxqn59jr8LC57Cu7ew3sNDS6IxOWTaQbLIuY=
Received: by mail-lf1-f41.google.com with SMTP id x23so7137051lfq.1
        for <linux-raid@vger.kernel.org>; Thu, 09 Apr 2020 00:25:26 -0700 (PDT)
X-Gm-Message-State: AGi0PubJF2Q4+3p63ozygYQXKQOAGQ7YlrOd/QfSkQXxmzMwQABxe6Hu
        ZZkpUlRP3Q9hTZlrF7zszR/dyl0gVfYdMN8Ay58=
X-Google-Smtp-Source: APiQypIPm1vD+Kuv6apSZMdbAd7kkWCbrvHOi/LY90e4AUCN4/J6u60ZAcDosZLBAPYxndc3asVykijHEqeIvqpPG+w=
X-Received: by 2002:a05:6512:1c5:: with SMTP id f5mr6609559lfp.138.1586417124432;
 Thu, 09 Apr 2020 00:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 9 Apr 2020 00:25:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4rWa_ZCX=3eW9Xk_jtZdu+uKX4HZtbfEJfS9ms4a+OSg@mail.gmail.com>
Message-ID: <CAPhsuW4rWa_ZCX=3eW9Xk_jtZdu+uKX4HZtbfEJfS9ms4a+OSg@mail.gmail.com>
Subject: Re: [PATCH 0/4] md: fix lockdep warning
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks for the fix!

On Sat, Apr 4, 2020 at 3:01 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Hi,
>
> After LOCKDEP is enabled, we can see some deadlock issues, this patchset
> makes workqueue is flushed only necessary, and the last patch is a cleanup.
>
> Thanks,
> Guoqing
>
> Guoqing Jiang (5):
>   md: add checkings before flush md_misc_wq
>   md: add new workqueue for delete rdev
>   md: don't flush workqueue unconditionally in md_open
>   md: flush md_rdev_misc_wq for HOT_ADD_DISK case
>   md: remove the extra line for ->hot_add_disk

I think we will need a new workqueue (2/5). But I am not sure about
whether we should
do 1/5 and 3/5. It feels like we are hiding errors from lock_dep. With
some quick grep,
I didn't find code pattern like

       if (work_pending(XXX))
               flush_workqueue(XXX);

Is it possible to fix the issue without these workaround?

Thanks,
Song
