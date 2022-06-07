Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4853EC19
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jun 2022 19:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiFFK0U (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jun 2022 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiFFK0U (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jun 2022 06:26:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E81C3207E
        for <linux-raid@vger.kernel.org>; Mon,  6 Jun 2022 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654511179; x=1686047179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=69vtZFK4jE4x/DYaExVmhxCs9U+OxosvjVazCjewHUY=;
  b=TbfkL76fhhZm5r5oDQQ2Z+BD3AaEcDOY25lexqQdLPdRDwxR/yz1grsI
   3Qvfte2xv6PSDSVqkMrb2+D8jFlr1saLsnHgvY5hBa7JL+bo+mX9dl47d
   h8j/q2NxdkqBSZw9EwZxR8ulOQadj6+LAVxLWB6FCJYVG3BW06U7d4SUl
   ETdOKYF57eheCWAXuEg0eMtKdITQ0CN+fzoPB98tAehql2MWLrAZVP9mc
   ZV41TvJKXJqCsW8HMd1Qdy4XtRPNPLf01N8DkHO7A8BYGEkN2yjnTOUsu
   Bv1bO1Jr4p4iokG1BMOJgLrUPI5VcDWXNGa6NgEedsFHL/4t42fu0B6S7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276595264"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276595264"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="682193148"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.102.97])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2022 03:26:17 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de, pmenzel@molgen.mpg.de
Subject: [PATCH v4 0/2] Mdmonitor improvements
Date:   Mon,  6 Jun 2022 12:32:11 +0200
Message-Id: <20220606103213.12753-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Changes in v4:
- fix place where is_mddev is calling
- no new changes in "Mdmonitor: Improve logging method" patch

Kinga Tanska (2):
  Mdmonitor: Fix segfault
  Mdmonitor: Improve logging method

 Monitor.c | 36 ++++++++++++++++++++++++------------
 mdadm.h   |  1 +
 mdopen.c  | 17 +++++++++++++++++
 util.c    |  2 +-
 4 files changed, 43 insertions(+), 13 deletions(-)

-- 
2.26.2

