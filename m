Return-Path: <linux-raid+bounces-1072-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E686F0FF
	for <lists+linux-raid@lfdr.de>; Sat,  2 Mar 2024 16:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6982F281BDA
	for <lists+linux-raid@lfdr.de>; Sat,  2 Mar 2024 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62751947E;
	Sat,  2 Mar 2024 15:56:41 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F6182CA
	for <linux-raid@vger.kernel.org>; Sat,  2 Mar 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709395001; cv=none; b=ox2y0GGNF6kOvArOQVRh4sTQ8XjGma/ONeivKcGKDSG3JibdIv71cClo04IAfCUEnAl3DHjxZ9IB5CPmQso5a7+2PjymJMv+w1aIPTeg7tJLrmg/oRoyYhC8gojAdquJ9pDvJwAalqwxh1XWRHMO+P8yH3BXxnI/EoRXCEUd98Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709395001; c=relaxed/simple;
	bh=tOzXpNQWLz0juiDSZXUtTc4HgdtWNEWArA6UdqSXuKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUOp5syT294BmTYKzCsY3G2qZQOZNFE1rgTHO3ifu1RYI6M6bpo+iOPfLmIGD++Yhu3UNIIoBi2IkAmtsX5Y+BQO6+GAXaI5fyWq/4Z0d/KjVQNPuyryAAy7KmL4ogPB3P63FF6y1VS0klEbOUrODZfD2fZqCye8ZJNtzHCIJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6861538916cso17438266d6.3
        for <linux-raid@vger.kernel.org>; Sat, 02 Mar 2024 07:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709394999; x=1709999799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icKYTn52wa+mcprh0aki+jO+Yd8UpG0vdGaXhjIHp5s=;
        b=xUeQ02WNXvTGyd3Zrikcd0fCSHB51criSfuKoWs7ZkzI7YjHj5V6m7QMcQ/OLToSmh
         gvV4V4gldvDtKAd36Rox9bAM0ypE2E5RtET0rLcTxYP8NBZyw8tn3hzn2r4U2rR9nQv3
         AgPlwlB+nDl4e/lpf0eYW6EXWGOi9CQ2isxJJYTt1OAGtRbLBbtXhq7mxC8truutm6uG
         oVAAHLRIIKH4f2ASfzPaEwiQ+BtZ3e0OTTpLkt/+gqfRu9aT7FB34udPB7+KFS7ggier
         FblusoVMh37oi70dMo2uuXhuF85fpu1M8q1tyuOBan/eQvLLti4jVJGk5keSkzQn6WPL
         rZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCX2KRDhD6AOY7uFpiF26YYqb4w9pg9eun+8w1Jtder0gh8LvJvJzHSO1zZFpKe9CGbBrl5oLIdLQPrFWMjmvY9JLmIopmjfNIyeVQ==
X-Gm-Message-State: AOJu0Yx+MeEbuaIaZU/brpGNQKvWgThQsIVDl9T2F5/xIG3RIwMv9WBs
	L8DuHOMJqkBBOjnt06cD3VDPfDWuRz7QFwnPQafdeUZkgJvmUQZAc0S0rZ3qYQ==
X-Google-Smtp-Source: AGHT+IEAn6vl09QtIrIrE2pXAETZzU5zEPKFbADR7msfSHAsTteuTr1kQ0suhD2aw3ZxwvOgvWJIdw==
X-Received: by 2002:a0c:9c49:0:b0:690:4c7f:7d57 with SMTP id w9-20020a0c9c49000000b006904c7f7d57mr4795316qve.29.1709394998966;
        Sat, 02 Mar 2024 07:56:38 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id pa7-20020a056214480700b0068f8a21a065sm3103794qvb.13.2024.03.02.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 07:56:38 -0800 (PST)
Date: Sat, 2 Mar 2024 10:56:35 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
	zkabelac@redhat.com, xni@redhat.com, agk@redhat.com,
	mpatocka@redhat.com, dm-devel@lists.linux.dev, yukuai3@huawei.com,
	heinzm@redhat.com, neilb@suse.de, jbrassow@redhat.com,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 0/9] dm-raid, md/raid: fix v6.7 regressions part2
Message-ID: <ZeNMM5mt5Tgpg3MP@redhat.com>
References: <20240301095657.662111-1-yukuai1@huaweicloud.com>
 <CAPhsuW5B8EOakkqeewNL7jXHH-wa=7b=ko3zZ_zcigTV9ptCoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5B8EOakkqeewNL7jXHH-wa=7b=ko3zZ_zcigTV9ptCoA@mail.gmail.com>

On Fri, Mar 01 2024 at  5:36P -0500,
Song Liu <song@kernel.org> wrote:

> On Fri, Mar 1, 2024 at 2:03 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> >
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > link to part1: https://lore.kernel.org/all/CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com/
> >
> > part1 contains fixes for deadlocks for stopping sync_thread
> >
> > This set contains fixes:
> >  - reshape can start unexpected, cause data corruption, patch 1,5,6;
> >  - deadlocks that reshape concurrent with IO, patch 8;
> >  - a lockdep warning, patch 9;
> >
> > I'm runing lvm2 tests with following scripts with a few rounds now,
> >
> > for t in `ls test/shell`; do
> >         if cat test/shell/$t | grep raid &> /dev/null; then
> >                 make check T=shell/$t
> >         fi
> > done
> >
> > There are no deadlock and no fs corrupt now, however, there are still four
> > failed tests:
> >
> > ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
> > ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
> > ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
> > ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
> >
> > And failed reasons are the same:
> >
> > ## ERROR: The test started dmeventd (147856) unexpectedly
> >
> > I have no clue yet, and it seems other folks doesn't have this issue.
> >
> > Yu Kuai (9):
> >   md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume
> >   md: export helpers to stop sync_thread
> >   md: export helper md_is_rdwr()
> >   md: add a new helper reshape_interrupted()
> >   dm-raid: really frozen sync_thread during suspend
> >   md/dm-raid: don't call md_reap_sync_thread() directly
> >   dm-raid: add a new helper prepare_suspend() in md_personality
> >   dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io
> >     concurrent with reshape
> >   dm-raid: fix lockdep waring in "pers->hot_add_disk"
> 
> This set looks good to me and passes the tests: reshape tests from
> lvm2, mdadm tests, and the reboot test that catches some issue in
> Xiao's version.
> 
> DM folks, please help review and test this set. If it looks good, we
> can route it either via the md tree (I am thinking about md-6.8
> branch) or the dm tree.

Please send these changes through md-6.8.

There are a few typos in patch subjects and headers but:

Acked-by: Mike Snitzer <snitzer@kernel.org>

> CC Jens,
> 
> I understand it is already late in the release cycle for 6.8 kernel.
> Please let us know your thoughts on this set. These patches fixes
> a crash when running lvm2 tests that are related to md-raid
> reshape.

Would be good to get these into 6.8, but worst case if they slip to
the 6.9 merge is they'll go to relevant stable kernels (due to
"Fixes:" tags, though not all commits have Fixes).

Mike

