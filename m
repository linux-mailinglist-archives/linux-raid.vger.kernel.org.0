Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99010509D
	for <lists+linux-raid@lfdr.de>; Thu, 21 Nov 2019 11:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKUKhk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 Nov 2019 05:37:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34603 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfKUKhk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 Nov 2019 05:37:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id b72so2378705edf.1
        for <linux-raid@vger.kernel.org>; Thu, 21 Nov 2019 02:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hioRSS16588Xth6ROWnwU8eInUskBsxsljXyckGZ61o=;
        b=LKAIpZHNCLRDYkgfS3NnvOKFCT1riTOwLBsst6VoWYUXRan4TqtwXQXqmS10cezVoL
         NXmbczc7C+pJqXboHt1ZMQDJ3psARAK3w5R+K8pwduflRq04gGV/1JPjmlCkJ48FqMkU
         Mwhf2iE8QkBqfUjEUqXJvVWB96tzV3oaEdnngCtkCGNbBlYAV9615v0GdYVUIl/GnabE
         dTZX3Q/3+5bRKguXbtuhbgoA5/bQ0Ecjj1JzF7hD0+ylmo8Vjwo9kDXtxOm52mSt3goe
         +AKyREw1ogHi7y4kNBwAIuhlzrhpXhIYAGDv4cRHAtFFswdIrCJNO4OscVIhT6jmuZyg
         Yb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hioRSS16588Xth6ROWnwU8eInUskBsxsljXyckGZ61o=;
        b=MIPQ1wOzkPMeOP2h8UgyMDPKZgHOo4pN8uLsBMVb5H+O2BfC1JGlrVb7scxyBKjnHD
         1Kxfu4Mv3TtWszP56ZD7yLHmcBjdCxa4tr4ccp4rrptxa8FYAKks8dp3CMvYffiJL1Hq
         pTNUi7a3ZdZnzVOPOWjTwexMmajWs8lTlaJ3kGw6gLDlQmQyzVxswJoE7grG56ysw+7p
         c9YLvJb5SBBsdU8oZg3pkeEYLEAlhMIC35EpbB1K8wU/Yc5WFS/y1t/a/IkLB/2BVSUV
         VEGvelEieBOZ0f4FguStVQfrJglWXTXPEeve/XjUQFR80CvAN14DMvm5RJbo2hwkzDnY
         yP/A==
X-Gm-Message-State: APjAAAX0PWfI1d9MqjImWwhfKMh8MbKB4i+NeFiADe5DLZDL8+9mQNbo
        y/g0ey/IEQ4PY7/QJfzpA9c=
X-Google-Smtp-Source: APXvYqwsB9y/ZpgQndOFz0Pxi1fsSyMtB8Mwu9gR7VIxkB7kqNcG+7UpZSi/aWevfV0rxD5Qe3zuGw==
X-Received: by 2002:a17:906:4304:: with SMTP id j4mr12812880ejm.10.1574332658102;
        Thu, 21 Nov 2019 02:37:38 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:4465:ea1d:c50c:3d03])
        by smtp.gmail.com with ESMTPSA id x29sm87441edi.20.2019.11.21.02.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:37:37 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH v2 0/9] raid1 io serialization
Date:   Thu, 21 Nov 2019 11:37:19 +0100
Message-Id: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Major changes:

1. rename 0002 patch and change the patch header accordingly.
2. show "n/a" for non raid1 in serialize_policy_show in 0003.
3. 0004 patch is introduced to make two scenarios (both of them could
   enable serialization) can coexists.
4. use generical rb interval tree and introduce struct serial_in_rdev
   in 0007.

----------------------------------- v1 --------------------------------------
Hi,

If asynchronous write io happened in raid1 array, data could be inconsistent
among member devices though usually people would think the data should always
be the same in each devices for raid1.

And since we had addressed data inconsistency issue for write behind device
if it is a multiqueue device, then it is possible and straightforward to extend
the same mechanism to address similar issue.

with this patchset, we can enable io serialization for write. Of course, the
performance is not better than before, it could drop around 10% during my
tests.

Patch 1 just renames all the write-behind stuffs, no function change.
Patch 2 adds is_force parameter to mddev_create/destroy_serial_pool.
Patch 3 serialize_policy sysfs node is added to enable/disable serialization.
Patch 4 serializes the overlap write.
Patch 5 makes serial_info_pool still available if serialize_policy is true.
Patch 6 replaces list with rb tree for performance reason.
Patch 7 uses bucket based mechanism to improve performance further.
Patch 8 reorgnizes code.

Thanks,
Guoqing

Guoqing Jiang (9):
  md: rename wb stuffs
  md: prepare for enable raid1 io serialization
  md: add serialize_policy sysfs node for raid1
  md: reorgnize mddev_create/destroy_serial_pool
  raid1: serialize the overlap write
  md: don't destroy serial_info_pool if serialize_policy is true
  md: introduce a new struct for IO serialization
  md/raid1: use bucket based mechanism for IO serialization
  md/raid1: introduce wait_for_serialization

 drivers/md/md-bitmap.c |  20 ++--
 drivers/md/md.c        | 249 ++++++++++++++++++++++++++++++++---------
 drivers/md/md.h        |  45 +++++---
 drivers/md/raid1.c     | 111 +++++++++---------
 4 files changed, 295 insertions(+), 130 deletions(-)

-- 
2.17.1

