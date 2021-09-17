Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C7940FC8C
	for <lists+linux-raid@lfdr.de>; Fri, 17 Sep 2021 17:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbhIQPgl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Sep 2021 11:36:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:53507 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242886AbhIQPgh (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 Sep 2021 11:36:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="308364468"
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="308364468"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 08:35:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="546463846"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 08:35:12 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH 0/2] Use MD_BROKEN for redundant arrays
Date:   Fri, 17 Sep 2021 17:34:50 +0200
Message-Id: <20210917153452.5593-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song,
This patchset adds usage of MD_BROKEN for each redundant level.
This should simplify IO failure stack when md device is failed and
fixes raid456 bug..

Mariusz Tkaczyk (2):
  md: Set MD_BROKEN for RAID1 and RAID10
  raid5: introduce MD_BROKEN

 drivers/md/md.c     | 16 ++++++++++------
 drivers/md/md.h     |  4 ++--
 drivers/md/raid1.c  |  1 +
 drivers/md/raid10.c |  1 +
 drivers/md/raid5.c  | 34 ++++++++++++++++------------------
 5 files changed, 30 insertions(+), 26 deletions(-)

-- 
2.26.2

