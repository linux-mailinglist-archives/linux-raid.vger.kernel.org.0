Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E26531E1
	for <lists+linux-raid@lfdr.de>; Wed, 21 Dec 2022 14:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLUNhK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Dec 2022 08:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLUNhI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 21 Dec 2022 08:37:08 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ADDCE9
        for <linux-raid@vger.kernel.org>; Wed, 21 Dec 2022 05:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671629828; x=1703165828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yi2WGSnVj61clXqPKQO64QTd/VR0f7M1l8ulqOt3XbY=;
  b=Cr7FRRrKXH7dnRp+FDtRAfXCxVppN5Tx7fmzBXE/5E7opW8X3EBsMt0q
   OHfJwT0tjRYVKK68gdQ6VAs+GbQ8nIrWJMs9G0n4ylsVjEXrenepnrSuK
   96u3SIayilRd0+1AzM6z/8eoqXXqQinZHF9wICloXDkvEGobRzYXZr+Gi
   ewZvULWNMSYaUtiYQ42KmBx/BsCbeO9eWowRt3rdy4m+hfa2gBQQG8K2I
   dY+PeyfolpIhftVcMVqXFHlWg6ZEV9dBFso8PxWqScNsfQhLK2gouUmJ5
   Q9mtaVdALzhU5i+e/Nr/prSc/ieTuninmjgHJoMIZGWHLhWRNXBBiAbZD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="318566689"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="318566689"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 05:37:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="653515393"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="653515393"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.92.203])
  by fmsmga007.fm.intel.com with ESMTP; 21 Dec 2022 05:37:07 -0800
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de, xni@redhat.com
Subject: [PATCH v2 0/2] Incremental mode: remove safety verification
Date:   Wed, 21 Dec 2022 07:38:44 +0100
Message-Id: <20221221063846.20710-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Changes in incremental mode. Removing verification
if remove is safe, when this mode is triggered. Also
moving commit description to obey kernel coding style.

Kinga Tanska (2):
  incremental, manage: do not verify if remove is safe
  manage: move comment with function description

 Incremental.c |  2 +-
 Manage.c      | 79 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 49 insertions(+), 32 deletions(-)

-- 
2.26.2

