Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9B5996A5
	for <lists+linux-raid@lfdr.de>; Fri, 19 Aug 2022 10:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347357AbiHSIBu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Aug 2022 04:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347225AbiHSIBh (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 19 Aug 2022 04:01:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151CFE42DB
        for <linux-raid@vger.kernel.org>; Fri, 19 Aug 2022 01:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660896096; x=1692432096;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oizT1hApKL2FIufRyaQLsoW7LskswXJjkC+v7InBU2U=;
  b=cag5amqXrIVvb96nxj+3oASVynHT04bZKBiihyZXH9iWyRbJGXaiFBws
   m5M+nCHwoq1TpVHkAvi378SaFCoCxBxpquIlXsQPE4DwQBslH0NxeQ49v
   3eBcjAwIR/+mYURe0cqdPW9PviCmHUO9g9KLiMPOALs7sfMDMfC26JVHN
   hNt+mFWVQlFIjklu6H/Jtsyiro6v1/HJdt/XDnJ8Y/1GxZR5R7WpwzdCU
   Gto4XJ0M8x73QVlHFNC7cn8f3Yw3ASmk2xvbeKaU6yY+JH9loCBpSBSYb
   P15GPaXwVNe2DQF233z19N7eJCUC36OGUVfw4OUA3lZbbpJMXol6r0YNJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="292958959"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="292958959"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 01:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="668478510"
Received: from unknown (HELO unbrick.amr.corp.intel.com) ([10.102.92.203])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2022 00:55:30 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de
Subject: [PATCH v3 0/2] Fix force assemblation
Date:   Fri, 19 Aug 2022 02:55:45 +0200
Message-Id: <20220819005547.17343-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

