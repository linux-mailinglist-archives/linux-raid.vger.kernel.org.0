Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294B8C2048
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfI3MBR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 08:01:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:4450 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfI3MBR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Sep 2019 08:01:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 05:01:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; 
   d="scan'208";a="392046089"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by fmsmga006.fm.intel.com with ESMTP; 30 Sep 2019 05:01:10 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH, RESEND] imsm: close removed drive fd.
Date:   Mon, 30 Sep 2019 14:01:04 +0200
Message-Id: <20190930120104.6876-1-mariusz.tkaczyk@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When member drive fails, managemon prepares metadata update and adds
the drive to disk_mgmt_list with DISK_REMOVE flag. It fills only
minor and major. It is enough to recognize the device later.

Monitor thread while processing this update will remove the drive from
super only if it is a spare. It never removes failed member from disks list.
As a result, it still keeps opened descriptor to non-existing device.

If removed drive is not a spare fill fd in disk_cfg structure
(prepared by managemon), monitor will close fd while freeing it.

Also set this drive fd to -1 in super to avoid double closing because
monitor will close the fd (if needed) while replacing removed
drive in array.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
---
 super-intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/super-intel.c b/super-intel.c
index 39264bef..e02bbd7a 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -9202,6 +9202,9 @@ static int add_remove_disk_update(struct intel_super *super)
 					remove_disk_super(super,
 							  disk_cfg->major,
 							  disk_cfg->minor);
+				} else {
+					disk_cfg->fd = disk->fd;
+					disk->fd = -1;
 				}
 			}
 			/* release allocate disk structure */
-- 
2.16.4

