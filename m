Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ACF6FEF7D
	for <lists+linux-raid@lfdr.de>; Thu, 11 May 2023 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjEKJ50 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 11 May 2023 05:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbjEKJ44 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 11 May 2023 05:56:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48BD06E
        for <linux-raid@vger.kernel.org>; Thu, 11 May 2023 02:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683799002; x=1715335002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sApTg0dA9XKTX7g+K7fS+iS3sanx13QRLeq7iLKIQi4=;
  b=Ax2QOmGp1ky1UEcfCYeKVodbfzTK9YYsMp/qh2tZxZz4MqxIXBDA87ti
   AX/zQ9V1X8NQaYcko3aYd++JsrYKmy12E7TE5JCOXJMh6EZZAlss8gyhW
   +Y4P/JD6418MKxe9+jd4kxM+X+AwZQYnDs6ow9vowNtK70Oadi9RcAcoD
   8jVGaZY6WRWRt8HJszOn+PIeEA0j/0GivU4WrX4xsUWE+hZG4UDumrT0q
   wS3Vv+2HFP5nzVfM7ph9ghwRlDrY1zMhXMxg9xz4z71HY3luZmwUDod8w
   qPkd17gE3VdzduIv/XaWNatpQZ7v2LcWnUap5rv+dU2WjLT8IYSrhuyEg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="334936764"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="334936764"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 02:54:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="946073691"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="946073691"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.92.203])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2023 02:54:18 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de
Subject: [PATCH v2 0/2] Fix unsafe string functions
Date:   Thu, 11 May 2023 04:55:11 +0200
Message-Id: <20230511025513.13783-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This series of patches contains fixes for unsafe string
functions usings. Unsafe functions were replaced with
new ones that limites the input length.

Kinga Tanska (2):
  Fix unsafe string functions
  platform-intel: limit guid length

 mdmon.c          | 6 +++---
 mdopen.c         | 4 ++--
 platform-intel.c | 5 +----
 platform-intel.h | 5 ++++-
 super-intel.c    | 6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.26.2

