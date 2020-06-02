Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5697C1EC0CF
	for <lists+linux-raid@lfdr.de>; Tue,  2 Jun 2020 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBRQh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 2 Jun 2020 13:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgFBRQh (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 2 Jun 2020 13:16:37 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 617BC206C3
        for <linux-raid@vger.kernel.org>; Tue,  2 Jun 2020 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591118196;
        bh=HHTpaBR+oqnGmZTzoSS9BVE8UE2THITxuakh7jIHBag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xf1jGmi4XKzdL/Y2MtNP1uxSQ4wE5bZilzznoHmqk9dD/ITGggh2hRL6f+BzHZNTc
         Tt6qBeMau51ClezgV2MZ04EqxhoVfwMBzubcZxe8Jhu2fEzg871DGYqMdQYKRJ2vFE
         reF9yk23LxPScFFE012I7E3CWLvXE+yduI5nhLX0=
Received: by mail-lj1-f182.google.com with SMTP id o9so13533270ljj.6
        for <linux-raid@vger.kernel.org>; Tue, 02 Jun 2020 10:16:36 -0700 (PDT)
X-Gm-Message-State: AOAM533mGq+tuBuDU6U/xGfELBIOOcexJslZ0LyyxJl0tyMeWT44I3uI
        dSofme0BsAFdYcivVWCxxrmymkJJ23iPTGuBZJI=
X-Google-Smtp-Source: ABdhPJzacMed97wZ9oRwIT99XEgglqkXGK7na/I/O75ogTSJZIBfN/yIfROTiMStC79ezetuD1JmBZbS77nVSTPoRQ4=
X-Received: by 2002:a2e:9242:: with SMTP id v2mr77749ljg.41.1591118194728;
 Tue, 02 Jun 2020 10:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200601161256.27718-1-artur.paszkiewicz@intel.com>
 <CAPhsuW4fjc4NgFGQUPuAKSvtWvtzyPor876anj64NF=nqaPo5g@mail.gmail.com> <26d5f5c7-9a20-e7f9-617f-0353c5d9bb2e@intel.com>
In-Reply-To: <26d5f5c7-9a20-e7f9-617f-0353c5d9bb2e@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 2 Jun 2020 10:16:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6JNjnGQg6BARGGzb+ohOrcLKaTvs4bAm60NzAwQ-svpw@mail.gmail.com>
Message-ID: <CAPhsuW6JNjnGQg6BARGGzb+ohOrcLKaTvs4bAm60NzAwQ-svpw@mail.gmail.com>
Subject: Re: [PATCH] md: improve io stats accounting
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 2, 2020 at 4:47 AM Artur Paszkiewicz
<artur.paszkiewicz@intel.com> wrote:
>
> On 6/2/20 8:48 AM, Song Liu wrote:
> >> +               clone = bio_clone_fast(bio, GFP_NOIO, &mddev->md_io_bs);
> >
> > Handle clone == NULL?
>
> I think this should never fail - bio_alloc_bioset() guarantees that. It
> is used in a similar manner in raid1 and raid10. How about
> BUG_ON(clone == NULL)?

I misread the code. Current version is fine.

>
> > Also, have you done benchmarks with this change?
>
> I tested 4k random reads on a raid0 (4x P4510 2TB) and it was 2550k vs
> 2567k IOPS, that's slower only by about 0.66%:

Thanks for the test. I will do some more tests and process the patch
after the merge
window.

Song
