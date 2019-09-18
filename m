Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D90B6BDA
	for <lists+linux-raid@lfdr.de>; Wed, 18 Sep 2019 21:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfIRTPa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 18 Sep 2019 15:15:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfIRTP3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 18 Sep 2019 15:15:29 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84C217FDCD
        for <linux-raid@vger.kernel.org>; Wed, 18 Sep 2019 19:15:29 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id n8so1220346ioh.23
        for <linux-raid@vger.kernel.org>; Wed, 18 Sep 2019 12:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xv3sp+Pux8s4oM5fbW+IThAko5zE0cP1zvxQk6wtn7M=;
        b=m4j/NvFpcaDpcIi1lNbI/1EyCVZudUWF8sKo0+w4gBia3f6SSw6Mvmkh0Nl2dovY5V
         P8iO8eKGEoftxEXouLgG8WJjoK2X4M5b87fGSNVa8WOMWrORMf+o9RPLv+P4EELrhrEf
         N/0WZKcVQR+3iqAzQPTdzTsi5DES9WJK7svHkZv9ODa0UyaEtjAJ8B2NNTYZdEKWVyIL
         htJmadAVSnBBtWjAsczL2u7X8MRqE2c6bEw+cYyXRJRIjYFYfIvzzT88rE7ylC97b7nf
         VSxBRbDHmgIB14+16czSR4TkddpAbHUMephClhQsjv/T3wr1ONON18OR9+tbCCLmKmC6
         oZhw==
X-Gm-Message-State: APjAAAU9XPF4wz6fSXePG7Ykx9lrNcRPJUEKiYVCa10xljSNbvmnFGTV
        pcsnljU2AxWBcgRipDKRj2V/nLXKEo1BhJebSgFS+c1bnf4R1LrNuhdjE1dcT2tfEXVNn6nonAN
        iXFlULwMxJu9X/aqv6ImlVTHHl0rZmXc8A+GoHQ==
X-Received: by 2002:a6b:8b8b:: with SMTP id n133mr4659781iod.34.1568834129010;
        Wed, 18 Sep 2019 12:15:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqc0mo2fRChoeB7OQOpohdwUpBnxQIA7DJqKxU0ywk5ZwzGxMPq5kl5Br6994H+x5gWOJXZzPYWdKC1VJILNA=
X-Received: by 2002:a6b:8b8b:: with SMTP id n133mr4659750iod.34.1568834128703;
 Wed, 18 Sep 2019 12:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <1568627145-14210-1-git-send-email-xni@redhat.com>
 <20190916171514.GA1970@redhat> <b7271fd2-5fea-092f-860c-a129d43c3a7a@redhat.com>
In-Reply-To: <b7271fd2-5fea-092f-860c-a129d43c3a7a@redhat.com>
From:   David Jeffery <djeffery@redhat.com>
Date:   Wed, 18 Sep 2019 15:15:17 -0400
Message-ID: <CA+-xHTEaYtctDGfY=hq_XuxTW01+sriNb6xyS5-aqtvAkkrZNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Call md_handle_request directly in md_flush_request
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid@vger.kernel.org, ncroxon@redhat.com, heinzm@redhat.com,
        neilb@suse.de, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Sep 17, 2019 at 11:21 PM Xiao Ni <xni@redhat.com> wrote:
>
> md_flush_request returns false when one flush bio has data and
> pers->make_request function go
> on handling it. For example the raid device is raid1. md_flush_request
> returns false, raid1_make_request
> go on handling the bio. If raid1_make_request fails, the bio is still
> lost. Now it looks like only md_handle_request
> checks the return value of pers->make_request and go on handling the bio
> if pers->make_request fails.

But the bio isn't lost.  Using raid1 as an example, the calling sequence is
md_handle_request -> raid1_make_request -> md_flush_request.
raid1_make_request is already wrapped by md_handle_request.  So this
earlier call to md_handle_request will re-submit the bio if raid1_make_request
returns false after md_flush_request returns false.  Anything which calls an
mddev->pers->make_request function (only md_handle_request after patch)
must already handle a return of false or it would also have a bug allowing I/O
to be lost.

>
> There should not be a deadlock if it calls md_handle_request directly.
> Am I right? If there is a risk, we
> can put those bios into a list and queue a work in workqueue to handle
> them. Is it a better way?

I don't see a deadlock with calling md_handle_request from md_flush_request.
It's just more stack and overhead when we could instead let the first calls to
these functions advance the I/O instead of recursing into new instances.

>
> Regards
> Xiao

David Jeffery
