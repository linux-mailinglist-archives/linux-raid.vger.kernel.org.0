Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEDC3F08F8
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 23:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfKEWDk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 17:03:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41639 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbfKEWDj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 Nov 2019 17:03:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id m125so22696398qkd.8
        for <linux-raid@vger.kernel.org>; Tue, 05 Nov 2019 14:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uk23NQuv3GFa0LiOClOvQWv2cCRKfoCMx6hE1c+vHz4=;
        b=LyQNxx0SQFoeAXfBeTJszf5ML69RnHQxDY0j9742iOvRERvvXMRJls+8bMc20NPTKs
         sp/WgHC/haE8818SlrIydHgGq0c3trCi4J2azNuJsbkktrrYbjrgL7+RZwWnwN4JF0UA
         1N//maGVggM6Zy+plam3yiWgazOPOpn0F81xU98Oq6TklQUOMKHUSLQTRoOp9ju6ku97
         wFZIGPZo9VmDaj7Y6nHgtKqGdQG5FSatRPl52+cOKfy1td4dMjqHgPsPNQDrCW5aFpxp
         HQ6gTaW6ZEbnoO6xEh6nunjjhEHy+1uGVv7wi1G0jS7tHt1rGe1h7L1CfzQkfzPIlS6o
         KM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uk23NQuv3GFa0LiOClOvQWv2cCRKfoCMx6hE1c+vHz4=;
        b=LZ/9dVijXtBzf4OTHvV2SMbbjkm7lUOg1wtFi0zzBRUpbQt3IA1lkAclbRLuGweHel
         X7ae085+XZgQn0nRQlB6mQ8f8YBRlAFrTThRJfe//ls0tV+1Mo/uwk4KBo8sH4JOwev9
         76xlyBaYMq/4jKsBu5CPJFDqC5JHfWjsSpgzAZr4DrAb8UUOkuoExKsV9geqUuObN++i
         XlhxUD0OVk4Q88Y+NxQmhQrdo8sj/Wt+6kHIMS6uCOskUS4IzNwCv5Dy7KDWXCmO3v/L
         2BJDQnnFN7m7jdG8M7BFhn6GaekKFlYPBwDO5eZePwkGQF8PrduGMgub726cysDmJi3N
         GkyQ==
X-Gm-Message-State: APjAAAXTCd7MkHMbJhKOLbcEM6DFRvt3GeeE0EygddnR5qcrKTFOLLv7
        3LaUzDbjOQnPLqP4N8PfPGdeE0+jkX1tplBj67g=
X-Google-Smtp-Source: APXvYqwbJoz9+rpoGcZPucu4sP6u2bQeLYC6T0LotYalFIRfy/lR0cHBJ34skybm7W8CGYa3bp+YC7wyaY5VVBWSY9k=
X-Received: by 2002:ae9:ef06:: with SMTP id d6mr12828749qkg.168.1572991418839;
 Tue, 05 Nov 2019 14:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com> <20191101142231.23359-7-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20191101142231.23359-7-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 5 Nov 2019 14:03:27 -0800
Message-ID: <CAPhsuW4tFUO4UAWyRoMsPTWKBq7=fe0jj-9ojP=r2oF2_OgrQw@mail.gmail.com>
Subject: Re: [PATCH 6/8] md: switch from list to rb tree for IO serialization
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Nov 1, 2019 at 7:23 AM <jgq516@gmail.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> Obviously, IO serialization could cause the degradation of
> performance. In order to reduce the degradation, it is better
> to replace link list with rb tree.
>
> And with the inspiration of drbd_interval.c, a simpler

Can we reuse the logic in drdb_interval.c instead of duplicating it?

Thanks,
Song
