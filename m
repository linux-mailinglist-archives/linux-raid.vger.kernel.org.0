Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC8F6EA3F9
	for <lists+linux-raid@lfdr.de>; Fri, 21 Apr 2023 08:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDUGrp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 21 Apr 2023 02:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjDUGro (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 21 Apr 2023 02:47:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3C8E74
        for <linux-raid@vger.kernel.org>; Thu, 20 Apr 2023 23:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682059663; x=1713595663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sApTg0dA9XKTX7g+K7fS+iS3sanx13QRLeq7iLKIQi4=;
  b=Ka3jeROEx2UzFv94UcjFMPYu4lv14NYZLS8O9YkI08D/XxjjlA4KwEOA
   YOXWN0N4lZkU+409anhwI/gF2N78DJUAYHdQPfc68debPWQJbgm1IdZft
   BCk2A/BRVW2c2ecCvpUbMPzkgcOoCFCl3PEnVIU9uXYbIc6mqU3lxqSNj
   CMx+qKR8M0MicWRgqq4mxumrz/WWJWkqUMK5UzIrGeGufkLd0dzHJmgjE
   c+IwPHtxPHRZGDGOC5JvVY7jb5QjkLc/u2o5w342ZaSXJwYrDVBTXkbr6
   0WpFm8w6z4FkCbENvUp6REATTT/mEdDo95hZfsmqTGqUK9r29wwxnqF89
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="330128180"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="330128180"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 23:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="685641214"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="685641214"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.92.203])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2023 23:47:42 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de
Subject: [PATCH 0/2] Fix unsafe string functions
Date:   Fri, 21 Apr 2023 01:46:56 +0200
Message-Id: <20230420234658.367-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
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

