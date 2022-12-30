Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF9B65203C
	for <lists+linux-raid@lfdr.de>; Tue, 20 Dec 2022 13:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLTMNE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 20 Dec 2022 07:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiLTMNB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 20 Dec 2022 07:13:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91FD186F6
        for <linux-raid@vger.kernel.org>; Tue, 20 Dec 2022 04:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671538380; x=1703074380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yi2WGSnVj61clXqPKQO64QTd/VR0f7M1l8ulqOt3XbY=;
  b=V3sMqDpRbHaKMusxWOTyobfVZ2vihsIGOim5dZaSX6W+NCcFeuzqqV2t
   LSl1FaY0KHd0Nw/In+j8AROnmU9VqVqmk27t67lHfbecIYcASTULPVgbn
   osyGWUu2qPaf6m8SSbXM8FfGD08Xmh3rP/T/DE1tx8Rvk80DyVQGh7uj5
   5BcKhUP3ZqxKzNUi5C2r4aVh3XnxFcncFunysYxt7bRshu88oYe4SNwDY
   5gU7N8V3nNx6nkwPwFkp7LjGgZtHMU1PAq46LEHZk/hv8Bl3rhvDvzR8B
   j+P6Sw65ZRRFi+nmvvl+vAQpGzII3CcYI+pRTagJRt776FDvaJlArWb9V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="405846272"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="405846272"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 04:13:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="628700765"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="628700765"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.92.203])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2022 04:12:59 -0800
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de, xni@redhat.com
Subject: [PATCH 0/2] Incremental mode: remove safety verification
Date:   Tue, 20 Dec 2022 06:14:31 +0100
Message-Id: <20221220051433.14987-1-kinga.tanska@intel.com>
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

