Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822087CF25
	for <lists+linux-raid@lfdr.de>; Wed, 31 Jul 2019 22:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfGaUyp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 31 Jul 2019 16:54:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32842 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfGaUyp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 31 Jul 2019 16:54:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so50282214qkc.0;
        Wed, 31 Jul 2019 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qF4tGpJO+oK5K2osSj6rmmJJTPjFwIzb6Lh5sd1YwA=;
        b=ibWW8wcl0YLanci1GOKAETLRNr1Ujpz1/b5Cv9arl51Wv9RQfxo/NF3Zf/MFmSovOv
         cqfZEeG6Nkw0EVAZf/py1o6gvsCL+nuqPRUQltw5KiPx10IFjp7iGMtw2T1WBkEEt8Q7
         3AGeyiU2sZ+9dh8+pORvUXgRK/MVQgTVBLuI0Y8I12pFrIqeSHyUmlPPWxmBxmS6H2gz
         ov9aLgoh9yPJmdkwoj9cB+1r5VlmiaHggJfzu+PJVb+9yFqvWAUbrqz0hNUJxjGb9MZT
         Qsx3OvaN7/TMzc+oveTeqprZjjOoqGrGAXqlfl3HdfHEWCp8SnIgtO097cdtV6hJaGb5
         8gtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qF4tGpJO+oK5K2osSj6rmmJJTPjFwIzb6Lh5sd1YwA=;
        b=lcEsWi+X3c65bYuD3poVl9CR5lL7rroCZC7UjHvwHD1bvG20c9xJqfbDGVD8oguSml
         Ctag7OZbaCs3Q51ObuipZ7dqIQxKFcP1wqv/478Wi71m/zzBxne8syip8tyMNh38esAu
         qSpWiGqHeXm/W70EgJ+SWPz0L1Y4oyvO4NLRtYS+h38alNKZcKDz7j1WWgpE7b8yPPBc
         JGtQ5g60FNozk45y1NuMeBcarCiCkX22UN+/1g9WxFk5OibskNy1EvDBBcmX1Gz7f0uG
         +6KoqChIxpTIX5VrZAchSHWamSJ+oXyRNRXUjy+g3a7JbiEexLj5Uk7Zl7COtF6zHehP
         +K1A==
X-Gm-Message-State: APjAAAUSMr7Ks3ZDVwHOnZXOvFhZ+mOi58P/jKwovfIXu7AUosIK5mBw
        5+7+zjf4OrN8hN2humQ1XrlyfeD/vF9oF5pLI64=
X-Google-Smtp-Source: APXvYqyIKs1+Lq5q4E0qnv32HLecgdXzO9/tGvSeOiKnh1u5kf0c/ZJTZp4EEhEvtIP77agZoBZPDPvzLVbfIPYqRiE=
X-Received: by 2002:ae9:e40f:: with SMTP id q15mr76096900qkc.241.1564606484528;
 Wed, 31 Jul 2019 13:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190727060258.63036-1-houtao1@huawei.com>
In-Reply-To: <20190727060258.63036-1-houtao1@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 31 Jul 2019 13:54:33 -0700
Message-ID: <CAPhsuW7c5vBbYtb9_ZeeEzBRMWOoR-tPs8mA6u-cSwbJdfWBqw@mail.gmail.com>
Subject: Re: [PATCH] raid1: factor out a common routine to handle the
 completion of sync write
To:     Hou Tao <houtao1@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jul 26, 2019 at 10:57 PM Hou Tao <houtao1@huawei.com> wrote:
>
> It's just code clean-up.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Applied to my local branch. Thanks for the clean up.

Song
