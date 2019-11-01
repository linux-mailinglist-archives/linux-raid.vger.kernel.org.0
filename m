Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D67EC48D
	for <lists+linux-raid@lfdr.de>; Fri,  1 Nov 2019 15:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKAOXJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 1 Nov 2019 10:23:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37552 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKAOXJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 1 Nov 2019 10:23:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id e12so7691407edr.4
        for <linux-raid@vger.kernel.org>; Fri, 01 Nov 2019 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aHcsu9/Y22Ta3x2CMF9TV3qRpq2A+qqx7vhyJuDY0P8=;
        b=cBtx86hmSUWZkd6pDm4HB+mVu/52OL5WTJtqqtK3IetHu1YhjjSHNtaH4I+szwWGUN
         I8PFoA6rZpyW04PKNMJVhmw9PkFJl4BiRmErFcivIvs26HW0vcgpzwreZQujfh7BEwv/
         geARxbS2/9YboQDzSof99SCOGJtxCSBG1lFGbLtxm8+n6ehv3NUV4YvdR9ST+1he0b9v
         cmAwuNct3GTHWTpVRjtNME/wiQ/FcGc/wEqEN00xlE0bgJJ1mzt577w+VvHWdkqOY35p
         Nv5LdICeob2Z6dOPuR8iUz/MPuYOnclCBf5oGo86qxVUuWWTX3d+j7HRvja24qRifXqw
         7USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aHcsu9/Y22Ta3x2CMF9TV3qRpq2A+qqx7vhyJuDY0P8=;
        b=Tlj7gYhiLHpFd6ydTV8fgG1gg9sepG6tblCKY8nDKDZ11nxjvVFvH7x/1A5akiFDGm
         GH9aT/IH2vkraGBxxZQ0wH1YfUWq3U5GEACOiCAKtAaAwiSOG1NOzIMSX0eo0SmtyaAU
         NQei3K3O3q/arcPr3GDpJeIJUm+NWncryOQvuDIdLB5DV0e01t1dMG3rdXuiqgytGyui
         xwhZEXRcaKkFTOZFjFWqkmBGpGiF4DgC7n/epdwmhVR1CKqHuwTErNJ5V6PjnZSQItqM
         dhPIYbL1/gqGolvC5b+7+9DAWUV4zuj5V/44PqcUoAPP8/UGRc6Gd7vJ0a9OngG6TY0S
         WWlg==
X-Gm-Message-State: APjAAAWw+036/hwKTxqo/ZQlVWmnPLkTav7iYER65iltZPytPFIIssgE
        OKFQbdx8KEJC0NGOgwjl3DI=
X-Google-Smtp-Source: APXvYqzDUT1ug45vyvR7hX5eZYPCRi65j6Bz+OvU1NWC5ltsHLNd5hTE7S4epzFLHI9Krf2ZxR0bug==
X-Received: by 2002:a17:906:2f83:: with SMTP id w3mr10082435eji.57.1572618187664;
        Fri, 01 Nov 2019 07:23:07 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f5aa:4cb:6cda:7f55])
        by smtp.gmail.com with ESMTPSA id u10sm179093eds.74.2019.11.01.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:23:06 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/8] raid1 io serialization
Date:   Fri,  1 Nov 2019 15:22:23 +0100
Message-Id: <20191101142231.23359-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

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

Guoqing Jiang (8):
  md: rename wb stuffs
  md: add is_force parameter for some funcs
  md: add serialize_policy sysfs node for raid1
  raid1: serialize the overlap write
  md: don't destroy serial_info_pool if serialize_policy is true
  md: switch from list to rb tree for IO serialization
  md/raid1: use bucket based mechanism for IO serialization
  md/raid1: introduce wait_for_serialization

 drivers/md/md-bitmap.c |  20 ++--
 drivers/md/md.c        | 226 +++++++++++++++++++++++++++++++++--------
 drivers/md/md.h        |  34 ++++---
 drivers/md/raid1.c     | 210 ++++++++++++++++++++++++++++----------
 4 files changed, 369 insertions(+), 121 deletions(-)

-- 
2.17.1

