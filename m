Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B754E4ED9
	for <lists+linux-raid@lfdr.de>; Wed, 23 Mar 2022 10:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiCWJFj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 23 Mar 2022 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiCWJFi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 23 Mar 2022 05:05:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6119C65CC
        for <linux-raid@vger.kernel.org>; Wed, 23 Mar 2022 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648026249; x=1679562249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FPBq2LbSplbHiIBLJWxZ2upn9te1HoaZB2wZw3iqfeI=;
  b=OfBSLvz9l7fZP5FrdrHcDG1tb75TsnpMsJ/ojW9EF17SP1dN+heAfiwL
   UzbZJ3VS9bR/de+0hZH1ZvvE++FALr2Ys6cAjT8Ol6fndJ5z0PJnG5EuN
   imb4i6XEly726dAiRJngdf6vwc6MyKS80+FEFM+Ehw4TnQfmlwlaYLWPG
   6WcL5jh4NnmbwPAi1apTYM1OtVzWStxB9k/5DPMR3E59OOajPHzVX5KRg
   TcUskqruHqV2VER56hVlLAuAwZ2eccKBaCB/+rubh2cn5ApYb0XSjehxK
   6pD/MsBEMiVvzYqVatrbwmzdwXph1hK3nIbLAXffa0bBvfpkXoT2FTf9I
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="240221864"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="240221864"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 02:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="560808752"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.102.97])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2022 02:04:07 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     pmenzel@molgen.mpg.de, jes@trained-monkey.org, colyli@suse.de
Subject: [PATCH 0/2] Mdmonitor improvements
Date:   Wed, 23 Mar 2022 10:07:42 +0100
Message-Id: <20220323090744.26716-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Series of patches contains fix segfault for running
monitor for devices different than md devices. Also
logging was improved to have informations about monitor
in verbose mode.

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

