Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61481A243E
	for <lists+linux-raid@lfdr.de>; Wed,  8 Apr 2020 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgDHOpt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Apr 2020 10:45:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:27620 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbgDHOpt (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 8 Apr 2020 10:45:49 -0400
IronPort-SDR: ObhR+oUkNF6RiUWgR/gPHrNF/6FN1Z8VgK6PZ1LaoARzui+YYapE/tea7+VE2VO2QIcsVnkQ0G
 1K6tUWgZKTcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 07:45:49 -0700
IronPort-SDR: yk/9ckYHzLS5vgf7FrV31eaSHWkDEzrU80tT9ynY1rOEBXY+oJefqT5iYmPQ1+iRt3K3VZvJW/
 eEGtRGDEicgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,358,1580803200"; 
   d="scan'208";a="452835132"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by fmsmga006.fm.intel.com with ESMTP; 08 Apr 2020 07:45:48 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] udev: Ignore change event for imsm
Date:   Wed,  8 Apr 2020 16:44:52 +0200
Message-Id: <20200408144452.19275-1-mariusz.tkaczyk@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When adding a device to a container mdadm has to close its file
descriptor before sysfs_add_disk(). This generates change event.
There is race possibility because metadata is already written and other
-I process can place drive differently. As a result device can be added
to two containers simultaneously.
From IMSM perspective there is no need to react for change event. IMSM
doesn't support stacked devices.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
---
 udev-md-raid-assembly.rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/udev-md-raid-assembly.rules b/udev-md-raid-assembly.rules
index 9f055ed0..d668cddd 100644
--- a/udev-md-raid-assembly.rules
+++ b/udev-md-raid-assembly.rules
@@ -23,7 +23,7 @@ IMPORT{cmdline}="nodmraid"
 ENV{nodmraid}=="?*", GOTO="md_inc_end"
 ENV{ID_FS_TYPE}=="ddf_raid_member", GOTO="md_inc"
 ENV{noiswmd}=="?*", GOTO="md_inc_end"
-ENV{ID_FS_TYPE}=="isw_raid_member", GOTO="md_inc"
+ENV{ID_FS_TYPE}=="isw_raid_member", ACTION!="change", GOTO="md_inc"
 GOTO="md_inc_end"
 
 LABEL="md_inc"
-- 
2.25.0

