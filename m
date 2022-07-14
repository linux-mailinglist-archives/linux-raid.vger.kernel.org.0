Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A403574559
	for <lists+linux-raid@lfdr.de>; Thu, 14 Jul 2022 08:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiGNGzJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 14 Jul 2022 02:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGNGzI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 14 Jul 2022 02:55:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3052AC53
        for <linux-raid@vger.kernel.org>; Wed, 13 Jul 2022 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657781708; x=1689317708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=01tYuFFW//NTLeqM8BwnxegVqIrmXnDraK8/4SZTdew=;
  b=R71X5qzvUAwzNi8FdKYst8xnZ+2mlShWAmqRom2iGKqzVodq4/37OACs
   XMLW6qVYZAKJbTvWJ4XYpvImoGLwPB5NwvjkdHsWL4N1N3XRYWWMULPZv
   A74fDUYfmKNNce9CYMe2t+VZeiIqegBOSCtps3d4Cw7XV3woXITf8ulEr
   yFmwD16nLxfzgK3s+TPq4vPewoIok6m7z3uSCW/wUsTHe4HADktsCvoTd
   4l3MWXdzPgyZ6e8Y4DW8z2ckb74FST0BAxUnibDUpuSM0cG7fBjvUcYy4
   1JRBNsbdy+gqz6FTdH+C5kctmhHUBsziNRubFIjx6xKZ5nHZGyaCnk2ib
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265845852"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="265845852"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 23:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="570945151"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.102.97])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2022 23:55:06 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de
Subject: [PATCH 0/2] String functions fixes in Monitor
Date:   Thu, 14 Jul 2022 09:02:09 +0200
Message-Id: <20220714070211.9941-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Series of patches which fixes unsafe string functions
used to fill devnames in Monitor.c.

Kinga Tanska (2):
  Monitor: use devname as char array instead of pointer
  Monitor: use snprintf to fill device name

 Monitor.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

-- 
2.26.2

