Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D0A221B97
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 06:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgGPEyq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 00:54:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31387 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgGPEyp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jul 2020 00:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594875285; x=1626411285;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=t2eV18TdcFxz6dSNgvoqPBV3dNmOwnqIfqTlXa+RL9o=;
  b=OybBouzO/QYeHSgvydBtNRBd5ibdkYwZ+mU2W+aeiEppNmqDAQgYbHvo
   BCFi0UfbsALy4Twz2z3PU68rh/sRUGXcD4eRFDp0VMA8LwhMunJhvJgYG
   vw7oFM2T4gHlXOkHdslEAf7Pzp+kvO3eEiG3foy+2QeG3jCBSvwQka3iH
   WVKV8OSkglt/jBNnIpMQ1JCqSHH50gb0GawXVBU1HHrdKlUWNjsuLcdL4
   odC5XgElfv+7bYB9Slk8k3CtKUWK4TdDsuIHBk/uuQhELw5FPISStlrGF
   z4DR9GBr+s0CKRSP5bsEwACYU8DSf4OOl01Zgiop8EmIBg6wqxvJpjoBb
   g==;
IronPort-SDR: 7TBS+foR4/wqI7iceqV9XOJaNOvdVewn5EpfxTd/3UJFPyku8/XUa1MxWPs+ZAFlIT4YXDO/+k
 D3WIAi63It0LkaNLE1+QVES0mYWdEeaq58nPjkUXPgJdn4W3XSWYLIsEmJpHFZnTWzgXISxHl8
 qGCInPdXI9MvXBobQxBBXWPlA9a0iTOKWm1nmnNp+3Ne3BoW1fjoEx68w7RcsnXqEjwHxpxSPW
 XDpbF4LaT19jkBBdC0d79kot+N57YEEepMf7daDqxgHMs7faj0iul4CVm/4vt8kJDfHB2G6AsV
 NUk=
X-IronPort-AV: E=Sophos;i="5.75,358,1589212800"; 
   d="scan'208";a="142711737"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 12:54:45 +0800
IronPort-SDR: rF5bUjDARWjHiwPgKQaNHaoMipZt2MtG41VIOtKcz2jhUYZV0OWyLGzQAo3xPV8Gg6ccT2EiSh
 dtguyxo8Zf/OHQ7WZEGYuxkN0d3KcmkQI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 21:42:36 -0700
IronPort-SDR: Vr7qdtgK2z5KmmZDE0ICq1kSEwQK8Jbkt/xPBePpDsRqULpOSZcfIDsIVf2/ySH8bUk7iOoDEq
 KQuunzQR0sew==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2020 21:54:44 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH 1/4] md: Fix compilation warning
Date:   Thu, 16 Jul 2020 13:54:40 +0900
Message-Id: <20200716045443.662056-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716045443.662056-1-damien.lemoal@wdc.com>
References: <20200716045443.662056-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Remove the if statement around the calls to sysfs_link_rdev() to avoid
the compilation warnings:

warning: suggest braces around empty body in an ‘if’ statement

when compiling with W=1. For the call to sysfs_create_link() generating
the same warning, use the err variable to store the function result,
avoiding triggering another warning as the function is declared
as 'warn_unused_result'.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/md.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fc33f2f8a415..9d740e4181ff 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2469,8 +2469,8 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 		goto fail;
 
 	ko = &part_to_dev(rdev->bdev->bd_part)->kobj;
-	if (sysfs_create_link(&rdev->kobj, ko, "block"))
-		/* failure here is OK */;
+	/* failure here is OK */
+	err = sysfs_create_link(&rdev->kobj, ko, "block");
 	rdev->sysfs_state = sysfs_get_dirent_safe(rdev->kobj.sd, "state");
 	rdev->sysfs_unack_badblocks =
 		sysfs_get_dirent_safe(rdev->kobj.sd, "unacknowledged_bad_blocks");
@@ -3238,8 +3238,8 @@ slot_store(struct md_rdev *rdev, const char *buf, size_t len)
 			return err;
 		} else
 			sysfs_notify_dirent_safe(rdev->sysfs_state);
-		if (sysfs_link_rdev(rdev->mddev, rdev))
-			/* failure here is OK */;
+		/* failure here is OK */;
+		sysfs_link_rdev(rdev->mddev, rdev);
 		/* don't wakeup anyone, leave that to userspace. */
 	} else {
 		if (slot >= rdev->mddev->raid_disks &&
@@ -9113,8 +9113,8 @@ static int remove_and_add_spares(struct mddev *mddev,
 			rdev->recovery_offset = 0;
 		}
 		if (mddev->pers->hot_add_disk(mddev, rdev) == 0) {
-			if (sysfs_link_rdev(mddev, rdev))
-				/* failure here is OK */;
+			/* failure here is OK */
+			sysfs_link_rdev(mddev, rdev);
 			if (!test_bit(Journal, &rdev->flags))
 				spares++;
 			md_new_event(mddev);
-- 
2.26.2

