Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14CECEA7AE
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 00:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfJ3XUV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 19:20:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43400 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfJ3XUV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 30 Oct 2019 19:20:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id c26so5822331qtj.10
        for <linux-raid@vger.kernel.org>; Wed, 30 Oct 2019 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7l5AkuqzM7u8krBCKTjk4uI8dLgPXuuk2jOQbr6BiNs=;
        b=R53OYf24aWYkrDpKSN/kwMLo2SsutmUD2/0j/hc00ycerxxzQqz39U7hkdbs39JaFk
         0dKzv2RA+xf15gPOYlVO16ylvoZbqpvR9nwr+2hBgRKJjK5cih04ibBKdh8oVDUK6qeT
         Ib9IZk5gBOvE9JG4RHD/Hr852ZWDHLCn+p6WcgI+f5WzyqNVs9b+zSG5UZp147eYWb7Q
         0HV9ULpDWPxgQJ/eKqQJs/AWBH1KuJlmWr3sp5CacY9mLxm/wg1R2fN3xtoJ6+YlRTwP
         cABcjQQkLfYeMfZz8aWjal8ZdeOvedYT2Wz9Oskwy3O6xQVQh4YM4MGLhmlJE5fuBea4
         ciQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7l5AkuqzM7u8krBCKTjk4uI8dLgPXuuk2jOQbr6BiNs=;
        b=FpIOMf6F/mfjABz6tUfzqxre5e3t+BhJaZwxxhx5TIMpIw9uG6YuxHk/qOlCno3e+2
         eSiDkx7ySYQW8Rby0HYJQXx2r6Nqal6MGgrTI0VI7dGq/34Y3tvLMGd5Jehm8jsr+tZU
         BArAQ9jR+f9B+tdb0ULwh8iSwk2MG4cZBBOD0uoXXUxGwdtQFUMoIovhAw46ZUZSVz6e
         uCJVDgR2gUPXfQ0oMHmrHk8U9KFKvsz5cEzCYvG1I+oGEEsoSB/Sf+n8UTJzemxUfo0b
         DWV/MggDp3cljo9UlhHx/4Do8vVC0lL8UR/mAtWN5+X4+fImJrap9zgohMOTcZHYEE3m
         6dGg==
X-Gm-Message-State: APjAAAWqiiXTY2ytAeE45v5KcAvtQ78sg16tXkDkO503VeppiLgrkIqI
        qd7vMz/xQQPUVN4FVh/IFmC71taLipSFhph1M6gvDg==
X-Google-Smtp-Source: APXvYqxiwf7NtsVEm+G+pigqs16sI6VJErYewj6yfjZXVXBhrLPog4QAMUR9l6kqdQR3sYxAWRW9p3Yw++Bn74Q5Myc=
X-Received: by 2002:ad4:50a8:: with SMTP id d8mr1725570qvq.8.1572477620045;
 Wed, 30 Oct 2019 16:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191030104702.3640-1-yuyufen@huawei.com>
In-Reply-To: <20191030104702.3640-1-yuyufen@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 30 Oct 2019 16:20:08 -0700
Message-ID: <CAPhsuW42mg4fo7LvO-t=tdgii8b=u1_b9=05jwZPP4b4eaA97g@mail.gmail.com>
Subject: Re: [PATCH v2] md: avoid invalid memory access for array sb->dev_roles
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Oct 30, 2019 at 3:29 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
> we need to gurantee 'desc_nr' valid before access array
> of sb->dev_roles.
>
> In addition, we should avoid .load_super always return '0'
> when level is LEVEL_MULTIPATH, which is not expected.
>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1487373 ("Memory - illegal accesses")
> Fixes: 6a5cb53aaa4e ("md: no longer compare spare disk superblock events in super_load")
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Applied to md-next. Thanks for the fix!

Song
