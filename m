Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B74187BF2
	for <lists+linux-raid@lfdr.de>; Tue, 17 Mar 2020 10:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgCQJVI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Mar 2020 05:21:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:26638 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgCQJVI (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 17 Mar 2020 05:21:08 -0400
IronPort-SDR: 8BjBmtLwZ1fuJLZJ8cotvzqMNVMvs8ODtq4BJ5SPOXRwZFToZpylgtIq+DFQa2I3bmLhkuMvUd
 xkOhy5RGWcPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 02:21:08 -0700
IronPort-SDR: jgX6lzkHD/R238ykI83ietznq0EqPBXSSmM5gobyi3h8WIrGj0SjFDIWSb2obzMZcRXUHIrPt8
 dVO6/NlKPpuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="267899630"
Received: from mbabinsk-mobl.ger.corp.intel.com (HELO apaszkie-desk.igk.intel.com) ([10.249.141.143])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 02:21:07 -0700
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: [PATCH] imsm: show Subarray and Volume ID in --examine output
Date:   Tue, 17 Mar 2020 10:21:03 +0100
Message-Id: <20200317092103.7200-1-artur.paszkiewicz@intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Show the index of the subarray as 'Subarray' and the value of the
my_vol_raid_dev_num field as 'Volume ID'.

Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
---
 super-intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/super-intel.c b/super-intel.c
index 533becb2..c6198dce 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -1579,6 +1579,7 @@ static void print_imsm_dev(struct intel_super *super,
 
 	printf("\n");
 	printf("[%.16s]:\n", dev->volume);
+	printf("       Subarray : %d\n", super->current_vol);
 	printf("           UUID : %s\n", uuid);
 	printf("     RAID Level : %d", get_imsm_raid_level(map));
 	if (map2)
@@ -1683,6 +1684,8 @@ static void print_imsm_dev(struct intel_super *super,
 		printf("Multiple PPLs on journaling drive\n");
 	else
 		printf("<unknown:%d>\n", dev->rwh_policy);
+
+	printf("      Volume ID : %u\n", dev->my_vol_raid_dev_num);
 }
 
 static void print_imsm_disk(struct imsm_disk *disk,
-- 
2.24.0

