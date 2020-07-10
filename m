Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94E21BA5F
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jul 2020 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgGJQKH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Jul 2020 12:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgGJQKH (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 10 Jul 2020 12:10:07 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9774206C3
        for <linux-raid@vger.kernel.org>; Fri, 10 Jul 2020 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594397406;
        bh=hTrfBXoS+BsfhgLYxECEeqTGpyQOJkkxYg85yAgtAHg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cs+cj80nyDAFFEQ0aXTppkJPpST7Zrzj0Cb3FPspSzezA69rM1O9/Br7wdePzmuqK
         rcft83gOQ5zSz11faxjvUfk2qT6n7+wRCQpnkTDKCtuP8XGwhrIjXTH1FRQAAc9gYT
         Q9pPewNFw3pAHT1DQtFbe6h49Bg74E1EWBXT+BKE=
Received: by mail-lf1-f41.google.com with SMTP id m26so3492667lfo.13
        for <linux-raid@vger.kernel.org>; Fri, 10 Jul 2020 09:10:05 -0700 (PDT)
X-Gm-Message-State: AOAM532P2dSj440M4//tCE22xgKQ8XrrkX+V3V1H15vE8T+Rm6P7xdvo
        NuuJofe3oFREe+3+5wG01pqH1zfu2xVUTUSY15g=
X-Google-Smtp-Source: ABdhPJxa/dFdVGvJU+PeADki4tWipkKeecCSPGlU2P+2FNVNRqNnxLmgogl4tJRkbSBxx1pmi/qGZfVa/D5VKYCAp0g=
X-Received: by 2002:a19:7e09:: with SMTP id z9mr43832164lfc.69.1594397404270;
 Fri, 10 Jul 2020 09:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200702120628.777303-1-yuyufen@huawei.com> <CAPhsuW7PgJV-bjaa8v=Zrhd0MqPmjew1dF-Qi0FP6i-809YAQg@mail.gmail.com>
 <0dd1ebed-2802-2bef-48f0-87bbdd2ee8e5@huawei.com> <CAPhsuW7m7qYGe3g2XyZNWZch4Wy0y2URNeUprKAm4si+nyBB8g@mail.gmail.com>
 <21aaf87f-157b-c37a-f16b-4e981268eeda@huawei.com>
In-Reply-To: <21aaf87f-157b-c37a-f16b-4e981268eeda@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jul 2020 09:09:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6XsoxqKZhMR1W8L1K3nVd0gWbT-WqHuzFYqqmpC9+BmA@mail.gmail.com>
Message-ID: <CAPhsuW6XsoxqKZhMR1W8L1K3nVd0gWbT-WqHuzFYqqmpC9+BmA@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] md/raid5: set STRIPE_SIZE as a configurable value
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jul 9, 2020 at 6:27 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
>
>
> On 2020/7/9 7:55, Song Liu wrote:
> > On Wed, Jul 8, 2020 at 6:15 AM Yufen Yu <yuyufen@huawei.com> wrote:
> >>
> >>
> >>
> >> On 2020/7/3 7:00, Song Liu wrote:
> >>> On Thu, Jul 2, 2020 at 5:05 AM Yufen Yu <yuyufen@huawei.com> wrote:
> >>>>
> >>>> Hi, all
> >>>>
> >>>>    For now, STRIPE_SIZE is equal to the value of PAGE_SIZE. That means, RAID5
> >>>>    will issue each bio to disk at least 64KB when PAGE_SIZE is 64KB in arm64.
> >>>>    However, filesystem usually issue bio in the unit of 4KB. Then, RAID5 may
> >>>>    waste resource of disk bandwidth.
> >>>>
> >>>>    To solve the problem, this patchset try to set stripe_size as a configuare
> >>>>    value. The default value is 4096. We will add a new sysfs entry and set it
> >>>>    by writing a new value, likely:
> >>>>
> >>>>           echo 16384 > /sys/block/md1/md/stripe_size
> >>>
> >>> Higher level question: do we need to support page size that is NOT 4kB
> >>> times power
> >>> of 2? Meaning, do we need to support 12kB, 20kB, 24kB, etc. If we only
> >>> supports, 4kB,
> >>> 8kB, 16kB, 32kB, etc. some of the logic can be simpler.
> >>
> >> Yeah, I think we just support 4kb, 8kb, 16kb, 32kb... is enough.
> >> But Sorry that I don't know what logic can be simpler in current implementation.
> >> I mean it also need to allocate page, and record page offset.
> >
> > I was thinking about replacing multiplication/division with bit
> > operations (shift left/right).
> > But I am not very sure how much that matters in modern ARM CPUs. Would you mind
> > running some benchmarks with this?
>
> To test multiplication/division and bit operation, I write a simple test case:
>
> $ cat normal.c
>
> int page_size = 65536;
> int stripe_size = 32768; //32KB
>
> int main(int argc, char *argv[])
> {
>          int i, j, count;
>          int page, offset;
>
>          if (argc != 2)
>                  return -1;
>
>          count = atol(argv[1]);
>
>          for (i = 0; i < count; i++) {
>                  for (j = 0; j < 4; j++) {
>                          page = page_size / stripe_size;
>                          offset = j * stripe_size;
>                  }
>          }
> }
>
> $ cat shift.c
>
> int page_shift = 16; //64KB
> int stripe_shift = 15; //32KB
>
> int main(int argc, char *argv[])
> {
>          int i, j, count;
>          int page, offset;
>
>          if (argc != 2)
>                  return -1;
>
>          count = atol(argv[1]);
>
>          for (i = 0; i < count; i++) {
>                  for (j = 0; j < 4; j++) {
>                          page = 1 << (page_shift - stripe_shift);
>                          offset = j << stripe_shift;
>                  }
>          }
> }
>
> Test them on a arm64 server, the result show there is a minor
> performance gap between multiplication/division and shift operation.
>
> [root@localhost shift]# time ./normal 104857600
>
> real    0m1.199s
> user    0m1.198s
> sys     0m0.000s
>
> [root@localhost shift]# time ./shift 104857600
>
> real    0m1.166s
> user    0m1.166s
> sys     0m0.000s
>
> For our implementation, page address and page offset are just computed
> when allocate stripe_size. After that, we just use the recorded value
> in sh->dev[i].page and sh->dev[i].offset. So, I think current implementation
> may not cause much overhead.

Sounds good. Let's keep this part as-is.

Thanks,
Song
