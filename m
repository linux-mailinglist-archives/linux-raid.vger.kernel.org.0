Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE1A5AE8EE
	for <lists+linux-raid@lfdr.de>; Tue,  6 Sep 2022 15:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiIFM7n (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 6 Sep 2022 08:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiIFM7m (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 6 Sep 2022 08:59:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F30BC1B
        for <linux-raid@vger.kernel.org>; Tue,  6 Sep 2022 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662469182; x=1694005182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HvdeXuVicA9I7FZ/hyS8crXrhAbNqM9BzWZWP3qOQZY=;
  b=GjxIWMSObAb0YDpBlOkLn/spkk0EbP6Y9bf9W8fFp8WlQh2qYxIJJ0tb
   X2ggipoy/t/Sep2OXmV00dklh9Y5RHfUAXkbUo3EizLiHQiyUOPic5dKv
   RpYYQIoZaH579offsRR8tJ6q91+33pwQP89bIQuMiXghm5ClEvGVmw4nf
   j8Bz+yOyEOG8WsfGplAMmKtN5MjRAeVPFf6wN49pxvTwWaOHX+3EKHlsH
   d0udvZQspnDfUg9sPPu4aB0/3kkjqmCazdNf+pz16zdd01UFOQ12+Rcj2
   rFul+gIu38AVqTGisKLIg2QIKkDDk8oB71fLiJPc4DE3ZsK56zz9hoLHU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296585125"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296585125"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:59:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675679146"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.105.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:59:40 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     jes@trained-monkey.org, colyli@suse.de
Cc:     linux-raid@vger.kernel.org, felix.lechner@lease-up.com
Subject: [PATCH 0/2] small fixes from Debian
Date:   Tue,  6 Sep 2022 14:59:30 +0200
Message-Id: <20220906125932.15214-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jes and Coly,
Here we have small Debian customizations worth to be integrated.

Mariusz Tkaczyk (2):
  mdadm: systemd services adjustments
  ReadMe: fix command-line help

 ReadMe.c                             | 2 +-
 systemd/mdadm-grow-continue@.service | 1 +
 systemd/mdadm-last-resort@.service   | 1 +
 systemd/mdcheck_continue.service     | 3 ++-
 systemd/mdcheck_start.service        | 1 +
 systemd/mdmon@.service               | 1 +
 systemd/mdmonitor-oneshot.service    | 1 +
 systemd/mdmonitor.service            | 1 +
 8 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.26.2

