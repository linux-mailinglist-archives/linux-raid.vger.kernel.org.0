Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EE32E789
	for <lists+linux-raid@lfdr.de>; Fri,  5 Mar 2021 13:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCEMBr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 5 Mar 2021 07:01:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:5458 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhCEMBk (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 5 Mar 2021 07:01:40 -0500
IronPort-SDR: /NvC6g/iAzNk+viRQgeSTNKKtUiS1LyVxYUdT3t3nta2fhgQxAtSBVUVsWIdgBhetPK3Dep+Aw
 QaSaEE8ojz9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="166898474"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="166898474"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 04:01:36 -0800
IronPort-SDR: RSur1iCJ7EXtKBfQNpdaSvyNve5VbsRRLeq5RC88UIIOVv0fJVZ9zxJ37TI6+HL3gxXQf1s0O4
 GboSx5CRkYyA==
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="401656533"
Received: from unknown (HELO localhost.igk.intel.com) ([10.237.126.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 04:01:34 -0800
From:   Jakub Radtke <jakub.radtke@linux.intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH 0/8] Write-intent bitmap support for IMSM metadata 
Date:   Thu, 24 Sep 2020 20:02:56 -0400
Message-Id: <20200925000304.169728-1-jakub.radtke@linux.intel.com>
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

