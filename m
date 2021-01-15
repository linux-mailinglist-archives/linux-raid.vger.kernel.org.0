Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C2E2F7C8D
	for <lists+linux-raid@lfdr.de>; Fri, 15 Jan 2021 14:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbhAON0e (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 Jan 2021 08:26:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:10822 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732159AbhAON0e (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 15 Jan 2021 08:26:34 -0500
IronPort-SDR: gCvbiUOUNsILBGPyyzPXhgTf6OnVtDMuDg/1BXWpAv7PZzyt1ummT2dhLlW8+3EyNHAmg7cTBK
 32UWrbyw1ucQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166216115"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="166216115"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 05:25:20 -0800
IronPort-SDR: JKJs3KHkTRcfwBkGbcCreLVz7fsRVRSDmmyQVEJXnyZ+HIzyWc5hH7ZC6ZCG27lHksshL5IUsJ
 oMn/ymeSDJBA==
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="425312389"
Received: from unknown (HELO localhost.igk.intel.com) ([10.237.126.111])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 05:25:19 -0800
From:   Jakub Radtke <jakub.radtke@linux.intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH 0/8] Write-intent bitmap support for IMSM metadata 
Date:   Fri, 15 Jan 2021 00:46:53 -0500
Message-Id: <20210115054701.92064-1-jakub.radtke@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This patchset is aimed to add write-intent bitmap support for IMSM
metadata.

Additional function in the superswitch (set_bitmap) is proposed as
a place where the internal bitmaps configuration for non-native
metadata can be performed (through sysfs).

Adding the bitmap to existing volumes is implemented similarly like
for the PPL functionality (through --update-subarray).

The patchset was tested on HW and qemu.

Jakub Radtke (8):
  Modify mdstat parsing for volumes with the bitmap
  Enable bitmap support for external metadata
  imsm: Write-intent bitmap support
  imsm: Adding a spare to an existing array with bitmap
  Add "bitmap" to allowed command-line values
  imsm: Update-subarray for write-intent bitmap
  Create: Block automatic enabling bitmap for external metadata
  Grow: Block reshape when external metadata and write-intent bitmap

 Assemble.c    |   6 +
 Create.c      |  11 +
 Grow.c        |  24 +-
 mdadm.8.in    |  13 +-
 mdadm.c       |   4 +-
 mdadm.h       |   3 +
 mdstat.c      |   6 +
 super-intel.c | 679 +++++++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 725 insertions(+), 21 deletions(-)

-- 
2.26.2

