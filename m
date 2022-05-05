Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDCD51BA19
	for <lists+linux-raid@lfdr.de>; Thu,  5 May 2022 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347550AbiEEIWn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 May 2022 04:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347941AbiEEIWQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 May 2022 04:22:16 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2949938
        for <linux-raid@vger.kernel.org>; Thu,  5 May 2022 01:18:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651738693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zz0tQRhiJwK3DQTm54W8v/0hXgAEEK/7chkTa4jxoyY=;
        b=lcGWUG7iR+wbSIQpu3xpTU64giWNydYw/7TCgARccGp5SaORw1KlCneuA636m/cV1Cz24p
        GtbEFH6c4yaMh68qsfDYtBX3q6fhk+MMuWNe7xOZWdyIfcQGzvc7nMSdUnXgsXdW7m1fP/
        EunSj1qhz/gjBST7NYBV68b+fVG8G0c=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     song@kernel.org
Cc:     buczek@molgen.mpg.de, linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: [PATCH 0/2] two fixes for md
Date:   Thu,  5 May 2022 16:16:39 +0800
Message-Id: <20220505081641.21500-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

The first patch addressed the issue in the link as reported by Donald.

https://lore.kernel.org/linux-raid/5ed54ffc-ce82-bf66-4eff-390cb23bc1ac@molgen.mpg.de/T/#t

Also add another one per discussion of v2 patch.

Thanks,
Guoqing

Guoqing Jiang (2):
  md: don't unregister sync_thread with reconfig_mutex held
  md: protect md_unregister_thread from reentrancy

 drivers/md/md.c | 24 ++++++++++++++++++------
 drivers/md/md.h |  5 +++++
 2 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.31.1

