Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B424F8197
	for <lists+linux-raid@lfdr.de>; Thu,  7 Apr 2022 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbiDGOag (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 Apr 2022 10:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343955AbiDGOaf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 Apr 2022 10:30:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE41947B9
        for <linux-raid@vger.kernel.org>; Thu,  7 Apr 2022 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649341700; x=1680877700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bNwCwjRX2b6QTfd5oBrij6L2UnXO/UqJVXDfRZ9+Oi8=;
  b=gztItPDrUKIz8UKMOAVM25uW5o1bQ+YSSVjbA6R+qAwthf0eSuw6WNTQ
   Naov3E5DgWvKuH1CXNNN2sCVLcMYondaS+bdkncR6BGbFLfyBCQGH7HlC
   4eeX53HvuGDWneAPOBLl/bkK2luEskJ6mOE++CN5sx49ITiHj/Ah01RTq
   UK/G8zoG1gOk2E4pPn7uLVQfzTH5/dcG2z6XbxLJ3VbtWjJnG9oLLYG6o
   VL56R7v0XuYayMb01FrmfvkLlXOBLGC6gVhOHEwgoxXKqOakDoQJPeUOO
   E34Dl2/IgTYEFsakLhlmfg0s0b3Lvil+HTCMh+/tBbwqt6O+TNWhudKfc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="261513355"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="261513355"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 07:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="659077507"
Received: from unknown (HELO gklab-109-9.igk.intel.com) ([10.102.109.9])
  by orsmga004.jf.intel.com with ESMTP; 07 Apr 2022 07:28:18 -0700
From:   Lukasz Florczak <lukasz.florczak@linux.intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de, pmenzel@molgen.mpg.de
Subject: [PATCH v2 0/2] mdadm: Fix array size mismatch after grow
Date:   Thu,  7 Apr 2022 16:27:37 +0200
Message-Id: <20220407142739.60198-1-lukasz.florczak@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Changes in v2:
- split commit into two,
- explain dead code part,
- reformat commit body to wrap text after 72 characters.

Lukasz Florczak (2):
  mdadm: Fix array size mismatch after grow
  mdadm: Remove dead code in imsm_fix_size_mismatch

 super-intel.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.27.0

