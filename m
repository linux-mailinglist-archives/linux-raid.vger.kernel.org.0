Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA186509AD
	for <lists+linux-raid@lfdr.de>; Mon, 19 Dec 2022 10:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiLSJ7M (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 19 Dec 2022 04:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiLSJ7L (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 19 Dec 2022 04:59:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D32185
        for <linux-raid@vger.kernel.org>; Mon, 19 Dec 2022 01:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671443950; x=1702979950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C154G6reXDyqGeUPewzQkEEjXGgesyUdgCtRwq3hPMw=;
  b=gHsOeEWwNiGgg8YuuGNpTsvGiuybjbBf/hjSShdjiwBsQwrqwpmOx3ZX
   ePlqibmKcRSKRIvRLxVY5H0wSxFqs36BYBSNi+OqrMOwcsO1vMSXdh9bB
   hnBWOVklT510eDIrMkNBHi84ydifRM0jn0hJVu9k093sDNMt71mcb6I4F
   GdyjoZ6M3kN2xVPdQ+8OWkSs6PRWWSat/nNVx2Dtvj9fCIwREcTmVTyt0
   SrHE2/4iWxU81fdtjP2vEdNHsZ4+o/+XWCEbBFmDkxODRf8/z1QXlZpzc
   jSUSs6bdL+iUXAb2YbUpf2BTmDmkbdex2n/dBhJnS9usrhjXdWJX3WffM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="306990574"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="306990574"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 01:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="774860943"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="774860943"
Received: from linux-myjy.igk.intel.com ([10.102.108.92])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2022 01:59:09 -0800
From:   Blazej Kucman <blazej.kucman@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de
Subject: [PATCH 0/2] Changes in Monitor
Date:   Mon, 19 Dec 2022 10:58:33 +0100
Message-Id: <20221219095835.686-1-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi, Jes, Coly
In first patch blocked is starting monitor when
--scan mode and MD devices list are combiened,
to prevent undefined behaviors.
Second patch containst monitor manual update.

Blazej Kucman (2):
  Monitor: block if monitor modes are combined.
  Update mdadm Monitor manual.

 Monitor.c  |  7 +++++-
 mdadm.8.in | 71 ++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 56 insertions(+), 22 deletions(-)

-- 
2.35.3

