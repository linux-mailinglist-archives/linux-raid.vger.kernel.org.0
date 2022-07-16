Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E8576B69
	for <lists+linux-raid@lfdr.de>; Sat, 16 Jul 2022 05:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiGPDLq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 Jul 2022 23:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGPDLp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 15 Jul 2022 23:11:45 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3A98E4E7
        for <linux-raid@vger.kernel.org>; Fri, 15 Jul 2022 20:11:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657941100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6Sgqxrvdf/3/yjpJqTpJ2sol2fL+Bre4D60T+/hHsWc=;
        b=ALiVHUyvtUbnliMYL/SIUsAjmYfDSRQxn5cGSfpEQ6OVRSekqU3jAvBhT8G8d3Ry5m7YnY
        StyhtJDhUR856oqwH+k1yWU1cDAtdrGATNMjoHtEwqag7Io5Uy2+wWRULo44vd/Ngh4h9j
        e3LkXRS2toaatk9YltDJZ6vxOoTqMOo=
From:   Jackie Liu <liu.yun@linux.dev>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, liu.yun@linux.dev
Subject: [PATCH RESEND] raid5: fix duplicate checks for rdev->saved_raid_disk
Date:   Sat, 16 Jul 2022 11:11:36 +0800
Message-Id: <20220716031136.1426264-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

'first' will always be greater than or equal to 0, it is unnecessary to
repeat the 0 check, clean it up.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/md/raid5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 20e53b167f81..a0b38a0ea9c3 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8063,8 +8063,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 	 * find the disk ... but prefer rdev->saved_raid_disk
 	 * if possible.
 	 */
-	if (rdev->saved_raid_disk >= 0 &&
-	    rdev->saved_raid_disk >= first &&
+	if (rdev->saved_raid_disk >= first &&
 	    rdev->saved_raid_disk <= last &&
 	    conf->disks[rdev->saved_raid_disk].rdev == NULL)
 		first = rdev->saved_raid_disk;
-- 
2.25.1

