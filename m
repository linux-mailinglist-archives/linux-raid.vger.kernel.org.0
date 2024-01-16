Return-Path: <linux-raid+bounces-339-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6AA82EDA6
	for <lists+linux-raid@lfdr.de>; Tue, 16 Jan 2024 12:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8346A1C22308
	for <lists+linux-raid@lfdr.de>; Tue, 16 Jan 2024 11:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5641B7FC;
	Tue, 16 Jan 2024 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtBIIPB2"
X-Original-To: linux-raid@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077691B7F9
	for <linux-raid@vger.kernel.org>; Tue, 16 Jan 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705404350; x=1736940350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KH/lreDIYz1akb/UEE2T3wPH0f1vsrlZr2KB6DCu3Rw=;
  b=CtBIIPB2mj/D1AA334w5fylIpvPGKnsRZnFe4mV1G7m7iRj+hM7RN9y6
   11nrfqBEoCKETQ6HA4G3ggkvkOQdfRV8DC20H5otXXxpmgbm7NQtqDA3Q
   A7/Oog/4OLkB3TsOe7in1G2lD/sQXUmeyNJm3b8vV4qwsX/9H0fRciB5P
   tLz/eHvgBFv6T14OgavDvmi9K+34vOoYkLRrLxZkU7foLRs7OjcIyit2G
   yUJjWey+yPLtp2ahDJB8sKvdsKHPiVflQwcMLkaqa5dC8+uC3Tt2fW7PN
   n31TapIlTtaIM/1adQvGXNwuuuRGVUl8NxVhLJ/mEoKNDu+l5ZqYd5Tf4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="21307264"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="21307264"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 03:25:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="26111622"
Received: from patodeveloperka.igk.intel.com ([10.102.109.29])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jan 2024 03:25:48 -0800
From: Mateusz Kusiak <mateusz.kusiak@intel.com>
To: linux-raid@vger.kernel.org
Cc: jes@trained-monkey.org,
	mariusz.tkaczyk@linux.intel.com
Subject: [PATCH 3/8] Super-intel: Fix first checkpoint restart
Date: Tue, 16 Jan 2024 12:24:29 +0100
Message-Id: <20240116112434.30705-4-mateusz.kusiak@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240116112434.30705-1-mateusz.kusiak@intel.com>
References: <20240116112434.30705-1-mateusz.kusiak@intel.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When imsm based array is stopped after reaching first checkpoint and
then assembled, first checkpoint is reported as 0.

This behaviour is valid only for initial checkpoint, if the array was
stopped while performing some action.

Last checkpoint value is not taken from metadata but always starts
with 0 and it's incremented when sync_completed in sysfs changes.

In simplification, read_and_act() is responsible for checkpoint updates
and is executed each time sysfs checkpoint update happens. For first
checkpoint it is executed twice and due to marking checkpoint before
triggering any action on the array, it is impossible to read
sync_completed from sysfs in just two iterations.

The workaround to this is not marking any checkpoint for first
sysfs checkpoint after RAID assembly, to preserve checkpoint value
stored in metadata.

Signed-off-by: Mateusz Kusiak <mateusz.kusiak@intel.com>
---
 super-intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/super-intel.c b/super-intel.c
index 77b0066fc470..5e4c08fb7854 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -8818,6 +8818,9 @@ static int imsm_set_array_state(struct active_array *a, int consistent)
 		super->updates_pending++;
 	}
 
+	if (a->prev_action == idle)
+		goto skip_mark_checkpoint;
+
 mark_checkpoint:
 	/* skip checkpointing for general migration,
 	 * it is controlled in mdadm
-- 
2.35.3


