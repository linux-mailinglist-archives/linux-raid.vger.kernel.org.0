Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8E1293BD
	for <lists+linux-raid@lfdr.de>; Mon, 23 Dec 2019 10:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLWJtL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Dec 2019 04:49:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35543 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfLWJtL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Dec 2019 04:49:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so14795422edv.2
        for <linux-raid@vger.kernel.org>; Mon, 23 Dec 2019 01:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MMj0MJMS9l3BkBBAFF8ghVey9UotNTwnkq9i5/l1C74=;
        b=YoXK85QEsZrKOJQArJDHQUtXfI7bleIu1cXuAjTtVe2IifE9QnGm/GRklNbKmC0JTj
         TvQ67Ql/mP0DzxfEicAVDmNPJ39w4mQi7WQapZWfqM0pXqFVz9extE7hrXJhlClzhRY+
         mwBuJOKkPb9VmS1CChhRBLdPW48ZDI0z7AMN1cm5hn9DBv81gs8SIWOA8/2bYk5pj0Gb
         6oBqGxBcvF7kBrPwvVkZ189rCIKTE2dED5CGoLvF50vWZp0SbnJ4yfy1nSKNy42yVjEI
         VPDamkUB0Ib40lWgaxiFtQ64DCFvk4wTqpxOkKQCowA4ztCyeKIL6gDxR9NStX7t5RRF
         MVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MMj0MJMS9l3BkBBAFF8ghVey9UotNTwnkq9i5/l1C74=;
        b=d5WDH/Jb6Xmi2kLzzp9j9HqNCd/CFFzADX4TkcrD+vVYqJ6mpNzs/V/62uQK/V5KC4
         Q5fMK1+pkQ4Ms1Li0DtfyiNr9tlBXlQwL0qkLp+ByEa6gl5o6kfRaQzS9sgDTD34592S
         sl0lblHDDStaqXQ9zBVz+EXkb+fxjlawne4zwMavsQU2kBgJEt7REVNdizKI8RKTOJGL
         TL+VhpemoTBHLNgPclnNMfvyzQgNZB3iRWPnmKWzAxvE3Wi7zBgVMmMgVC4tFVCXzyYy
         qNmQuPgji8tpMo99glxMZVdB8MsfiGVVmQhAnUct84iP3enoQETta5coz0h0pD+3W+dC
         85cw==
X-Gm-Message-State: APjAAAXn070mD9NVZkOH66AS0BLLcDhJElu6m3rg1DN9amaZZEnIeh+y
        ZGCl/snzWrBQyFatRQ/58ko=
X-Google-Smtp-Source: APXvYqwZoDpt13pJ3Nk6PaDh/lf0MLkXjS7PVqlGGKRGykXP5UltK9pmfXSKo8Yk3f6jPsieZpVgKw==
X-Received: by 2002:a50:d69a:: with SMTP id r26mr32596320edi.148.1577094549082;
        Mon, 23 Dec 2019 01:49:09 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a04e:c36f:204b:a84d])
        by smtp.gmail.com with ESMTPSA id b13sm1059461ejl.5.2019.12.23.01.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:49:08 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 00/10] raid1 io serialization
Date:   Mon, 23 Dec 2019 10:48:52 +0100
Message-Id: <20191223094902.12704-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

---------------------------------- v3 -------------------------------------
Major changes:
1. remove 'is_force' argument from md_create/destroy_serial_pool.
2. add 0002 for typo fix.

---------------------------------- v2 -------------------------------------
Major changes:

1. rename 0002 patch and change the patch header accordingly.
2. show "n/a" for non raid1 in serialize_policy_show in 0003.
3. 0004 patch is introduced to make two scenarios (both of them could
   enable serialization) can coexists.
4. use generical rb interval tree and introduce struct serial_in_rdev
   in 0007.

---------------------------------- v1 -------------------------------------
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

Guoqing Jiang (10):
  md: rename wb stuffs
  md: fix a typo s/creat/create
  md: prepare for enable raid1 io serialization
  md: add serialize_policy sysfs node for raid1
  md: reorgnize mddev_create/destroy_serial_pool
  raid1: serialize the overlap write
  md: don't destroy serial_info_pool if serialize_policy is true
  md: introduce a new struct for IO serialization
  md/raid1: use bucket based mechanism for IO serialization
  md/raid1: introduce wait_for_serialization

 drivers/md/md-bitmap.c |  20 ++--
 drivers/md/md.c        | 254 ++++++++++++++++++++++++++++++++---------
 drivers/md/md.h        |  45 +++++---
 drivers/md/raid1.c     | 111 ++++++++++--------
 4 files changed, 297 insertions(+), 133 deletions(-)

-- 
2.17.1

