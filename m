Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA05221B99
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 06:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgGPEyr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 00:54:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43610 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgGPEyq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jul 2020 00:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594875286; x=1626411286;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7tnQt+NPIkirfZjQPoKyrgvtujZL2C/ArKUV9BU3CTk=;
  b=HLVBFQeWxYdmqBqeoGnqYykA3BDfWLOAskMgV46hbT0LTQG0ngbvGmf6
   wDYfI7LIvDinYUAlOPbvU8XP0pQrG6YpQFvsygSSa/dwM/myhoGdD/KdY
   laUYdhAUwZl5Ew64BQMLE+kOR8N69ZJr/DLuBhJcobHL/ZyWIV0UUYZAb
   t3aYIww0tcne8391mghKehxDG2y1jLmqUoKSjtPgABw5tMTqQRQrrxtU9
   ccZb3oD1aXwqyZF0yShWrmq0VU3w8slTlNSlK793Jsrno7XO293qNEIPU
   Qas0wAkxC6BINDDTn1VgUdrp7GHBU3e9AZskEQAxjvNgSFTp26iVc2zSB
   g==;
IronPort-SDR: 46hn27gUVRfdKPORUernIEMnr0kOe9ZpsFrAgrd3erR1wdL1xkxyaBLujuoHpCh0C8g5M6JXWB
 eehwBqq9XYuzqULj1xHqDAualpn6maxHDVW1pHSYP5SZ3fxTQJbSNT9jZG26mIHg0xAnci6j0B
 w8w0/yMYzWvVWhg6bP90Ga3L/gc372rUijS0GQkgY0VGGtcKsDW0ZQ1VVquMGCfFe3OxWYAoMa
 vHU3NueEImlwCf9bvsH27WaYSmappkaBOKiC20nvrsrd0WlksCJGLWdn91V2SaSUpk2//JEuWo
 Gk8=
X-IronPort-AV: E=Sophos;i="5.75,358,1589212800"; 
   d="scan'208";a="251842275"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 12:54:46 +0800
IronPort-SDR: BBJW3FdWWsCymayb0xI2bzrgh5hFWVdQYM1G2AENsZZW3Q9PolTJ+i4U6tVP/nE8W9X1XcprWL
 xP9U3MtWz63+6BFjCStFEkmFxHZ94v0RQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 21:42:37 -0700
IronPort-SDR: Y1H4ggXzZcsCmVM4VupQ5nMFKPQwyhjqAYHtaA3LWP8POoB3fXqcSPuen7HOccmlmFQdiO5wP0
 RMxkJ9tQKJsg==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2020 21:54:46 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH 3/4] md: raid5: Fix compilation warning
Date:   Thu, 16 Jul 2020 13:54:42 +0900
Message-Id: <20200716045443.662056-4-damien.lemoal@wdc.com>
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
the compilation warning "suggest braces around empty body in an ‘if’
statement" when compiling with W=1.

Also fix function description comments to avoid kdoc format warnings.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/raid5.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index a4fbafa5b8f8..2dad541a60da 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2217,9 +2217,9 @@ static int grow_stripes(struct r5conf *conf, int num)
 /**
  * scribble_alloc - allocate percpu scribble buffer for required size
  *		    of the scribble region
- * @percpu - from for_each_present_cpu() of the caller
- * @num - total number of disks in the array
- * @cnt - scribble objs count for required size of the scribble region
+ * @percpu: from for_each_present_cpu() of the caller
+ * @num: total number of disks in the array
+ * @cnt: scribble objs count for required size of the scribble region
  *
  * The scribble buffer size must be enough to contain:
  * 1/ a struct page pointer for each device in the array +2
@@ -3710,7 +3710,7 @@ static int fetch_block(struct stripe_head *sh, struct stripe_head_state *s,
 	return 0;
 }
 
-/**
+/*
  * handle_stripe_fill - read or compute data to satisfy pending requests.
  */
 static void handle_stripe_fill(struct stripe_head *sh,
@@ -7944,8 +7944,8 @@ static int raid5_start_reshape(struct mddev *mddev)
 					else
 						rdev->recovery_offset = 0;
 
-					if (sysfs_link_rdev(mddev, rdev))
-						/* Failure here is OK */;
+					/* Failure here is OK */
+					sysfs_link_rdev(mddev, rdev);
 				}
 			} else if (rdev->raid_disk >= conf->previous_raid_disks
 				   && !test_bit(Faulty, &rdev->flags)) {
-- 
2.26.2

