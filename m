Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7421913D5FE
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jan 2020 09:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgAPIer (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jan 2020 03:34:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:50041 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgAPIer (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Jan 2020 03:34:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 00:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,325,1574150400"; 
   d="scan'208";a="273911187"
Received: from linux-myjy.igk.intel.com ([10.102.102.116])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2020 00:34:46 -0800
From:   Blazej Kucman <blazej.kucman@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
Subject: [PATCH] imsm: Update grow manual.
Date:   Thu, 16 Jan 2020 09:34:44 +0100
Message-Id: <20200116083444.4971-1-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Update --grow option description in manual, according to
the supported grow operations by IMSM.

Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
---
 mdadm.8.in | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mdadm.8.in b/mdadm.8.in
index 6b63bb41..ca02a338 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -481,9 +481,7 @@ still be larger than any replacement.
 This value can be set with
 .B \-\-grow
 for RAID level 1/4/5/6 though
-.B CONTAINER
-based arrays such as those with IMSM metadata may not be able to
-support this.
+DDF arrays may not be able to support this.
 If the array was created with a size smaller than the currently
 active drives, the extra space can be accessed using
 .BR \-\-grow .
@@ -2759,9 +2757,7 @@ container format.  The number of devices in a container can be
 increased - which affects all arrays in the container - or an array
 in a container can be converted between levels where those levels are
 supported by the container, and the conversion is on of those listed
-above.  Resizing arrays in an IMSM container with
-.B "--grow --size"
-is not yet supported.
+above.
 
 .PP
 Notes:
-- 
2.16.4

