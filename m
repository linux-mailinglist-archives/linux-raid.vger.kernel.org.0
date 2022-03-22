Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3144E42E6
	for <lists+linux-raid@lfdr.de>; Tue, 22 Mar 2022 16:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiCVPZZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 22 Mar 2022 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiCVPZZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 22 Mar 2022 11:25:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0796324
        for <linux-raid@vger.kernel.org>; Tue, 22 Mar 2022 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647962637; x=1679498637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D4kCD9dS23fdzAzfJsSzrJw6OYtSVQmnG/ODc1dnSyI=;
  b=V+5i9CstdvVitzfmQrVQ7A0sMueaVTJsQUu9zS1VMe/O8OzAk7fPXBTT
   At2FuwSbkZxPIdQlViNjGzx3yuX4j3J2mOSQOXaAeQwkmKx4uFdWLZ9v2
   LwJxtmOUjGWiMy8p3657pVyo0tNhYKaE8JRlwKkxCjwXnN79EMZEz2lP3
   1WWchbGaTjNvmiKZtgn/+uDjkAduNU2NRwJ90sok0hTQDewHVXW+GokuN
   OS+nN/29O7bvvtqjXu5Oty59jigbrW3+P7WZ9ZgLlmNu50BMPgBEsPc1c
   T6jkF8qD2P/xEXUShCmHQFw+PCb/qZT33asuntFNpEEqVMzTtz3mwlMO9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="255409921"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="255409921"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 08:23:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="543732504"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 08:23:54 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, guoqing.jiang@linux.dev
Subject: [PATCH 0/3] Failed array handling improvements
Date:   Tue, 22 Mar 2022 16:23:36 +0100
Message-Id: <20220322152339.11892-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song,
In v4 following changes were made:
- raid1_error and raid10_error description reworked, suggested by Guoqing.
- Error messages for raid0 and linear reworked, suggested by Guoqing.
- check for sync_request replaced by level checks, suggested by Guoqing.

I did manual (mainly on IMSM) tests, here my next TODOs in mdadm:
- broken state handling for redundant arrays in mdadm (it is exposed in sysfs).
  Currently it is working same as before, because broken is not a case for
  redundant arrays in mdadm. It requires to deal with already defined "FAILED"
  state in mdadm.
- Blocking manual removal of devices (#mdadm --set-faulty).

I run following native mdadm tests with and without changes, all passed:
#./test --disks=/dev/nullb[1-5] --tests=00raid1,00raid4,00raid5,00raid6,01r1fail,
01r5fail,01replace,02r1add,05r1failfast,05r1re-add,05r1re-add-nosuper

Mariusz Tkaczyk (3):
  raid0, linear, md: add error_handlers for raid0 and linear
  md: Set MD_BROKEN for RAID1 and RAID10
  raid5: introduce MD_BROKEN

 drivers/md/md-linear.c | 14 +++++++-
 drivers/md/md.c        | 30 +++++++++++-------
 drivers/md/md.h        | 72 ++++++++++++++++++++++--------------------
 drivers/md/raid0.c     | 14 +++++++-
 drivers/md/raid1.c     | 43 +++++++++++++++----------
 drivers/md/raid10.c    | 40 +++++++++++++----------
 drivers/md/raid5.c     | 48 ++++++++++++++--------------
 7 files changed, 155 insertions(+), 106 deletions(-)

-- 
2.26.2

