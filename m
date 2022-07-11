Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA952566A26
	for <lists+linux-raid@lfdr.de>; Tue,  5 Jul 2022 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiGELvh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Jul 2022 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGELvf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 Jul 2022 07:51:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519F4175BE
        for <linux-raid@vger.kernel.org>; Tue,  5 Jul 2022 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657021895; x=1688557895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oizT1hApKL2FIufRyaQLsoW7LskswXJjkC+v7InBU2U=;
  b=dZJdo6P3rWEyAmBqvnjFZ3AG1jgE98FEprzbsale650QfARBZYvV0ThH
   4vPOv5Z8QbXzrqeKJIq+dTxpTveVw8aJxOoERXxNmq1QKjPKmuCY9xBBT
   /ur6KFJXGxN/n4fLnyKHgsuHBN9g9sDuGD0YBteXMJ6fW2smn/bNOecJS
   9NpvFCFVgczCxScNksf1AUjPoSdw512849mjsWEcJNuuo4JZwTNVmoUXX
   32UZfQ9Gl/VmXITR0V5yDWCr/uGabv9Sn/vb+sbZxG8y7VOxR2QPNb0Tz
   dHhy/2KuSaaVNJAEGaXylpM8x8JW8qlJ0mazs0n+LY6mhvoyIf/0SYGcW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="284065276"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="284065276"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 04:51:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="619800186"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.102.97])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2022 04:51:34 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de
Subject: [PATCH v3 0/2] Fix force assemblation
Date:   Tue,  5 Jul 2022 13:58:10 +0200
Message-Id: <20220705115812.6946-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Series of patches contains fix to prevent update operation
for container, when force assemblation is triggered. To unify all
uses of checking array level, inline function was introduced and
propagated.

Kinga Tanska (2):
  Assemble: check if device is container before scheduling force-clean
    update
  mdadm: replace container level checking with inline

 Assemble.c    | 10 ++++------
 Create.c      |  6 +++---
 Grow.c        |  6 +++---
 Incremental.c |  4 ++--
 mdadm.h       | 14 ++++++++++++++
 super-ddf.c   |  6 +++---
 super-intel.c |  4 ++--
 super0.c      |  2 +-
 super1.c      |  2 +-
 sysfs.c       |  2 +-
 10 files changed, 34 insertions(+), 22 deletions(-)

-- 
2.26.2

