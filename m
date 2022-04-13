Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3119A4FF035
	for <lists+linux-raid@lfdr.de>; Wed, 13 Apr 2022 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiDMG4d (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 Apr 2022 02:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiDMG42 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 13 Apr 2022 02:56:28 -0400
Received: from smtp-delay1.nerim.net (mailhost-t6-m3.nerim.net [78.40.49.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 949902C667
        for <linux-raid@vger.kernel.org>; Tue, 12 Apr 2022 23:54:06 -0700 (PDT)
Received: from maiev.nerim.net (smtp-152-tuesday.nerim.net [194.79.134.152])
        by smtp-delay1.nerim.net (Postfix) with ESMTP id 8B863C65E7
        for <linux-raid@vger.kernel.org>; Wed, 13 Apr 2022 08:54:03 +0200 (CEST)
Received: from [192.168.0.252] (plouf.fr.eu.org [213.41.155.166])
        by maiev.nerim.net (Postfix) with ESMTP id 0A10F2E009;
        Wed, 13 Apr 2022 08:53:57 +0200 (CEST)
Message-ID: <7ffe1f1e-1054-6119-83a8-53edd89a902b@plouf.fr.eu.org>
Date:   Wed, 13 Apr 2022 08:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Subject: [PATCH v2] md/raid0: Ignore RAID0 layout if the second zone has only
 one device
To:     Song Liu <song@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org
Content-Language: en-US
Organization: Plouf !
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The RAID0 layout is irrelevant if all members have the same size so the
array has only one zone. It is *also* irrelevant if the array has two
zones and the second zone has only one device, for example if the array
has two members of different sizes.

So in that case it makes sense to allow assembly even when the layout is
undefined, like what is done when the array has only one zone.

Reviewed-By: NeilBrown <neilb@suse.de>
Signed-off-by: Pascal Hambourg <pascal@plouf.fr.eu.org>
---

Changes since v1:
- add missing Signed-off-by
- add missing subsystem maintainer in recipients

---
  drivers/md/raid0.c | 31 ++++++++++++++++---------------
  1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index b21e101183f4..7623811cc11c 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -128,21 +128,6 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
  	pr_debug("md/raid0:%s: FINAL %d zones\n",
  		 mdname(mddev), conf->nr_strip_zones);

-	if (conf->nr_strip_zones == 1) {
-		conf->layout = RAID0_ORIG_LAYOUT;
-	} else if (mddev->layout == RAID0_ORIG_LAYOUT ||
-		   mddev->layout == RAID0_ALT_MULTIZONE_LAYOUT) {
-		conf->layout = mddev->layout;
-	} else if (default_layout == RAID0_ORIG_LAYOUT ||
-		   default_layout == RAID0_ALT_MULTIZONE_LAYOUT) {
-		conf->layout = default_layout;
-	} else {
-		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting\n",
-		       mdname(mddev));
-		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
-		err = -ENOTSUPP;
-		goto abort;
-	}
  	/*
  	 * now since we have the hard sector sizes, we can make sure
  	 * chunk size is a multiple of that sector size
@@ -273,6 +258,22 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
  			 (unsigned long long)smallest->sectors);
  	}

+	if (conf->nr_strip_zones == 1 || conf->strip_zone[1].nb_dev == 1) {
+		conf->layout = RAID0_ORIG_LAYOUT;
+	} else if (mddev->layout == RAID0_ORIG_LAYOUT ||
+		   mddev->layout == RAID0_ALT_MULTIZONE_LAYOUT) {
+		conf->layout = mddev->layout;
+	} else if (default_layout == RAID0_ORIG_LAYOUT ||
+		   default_layout == RAID0_ALT_MULTIZONE_LAYOUT) {
+		conf->layout = default_layout;
+	} else {
+		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting\n",
+		       mdname(mddev));
+		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
+		err = -ENOTSUPP;
+		goto abort;
+	}
+
  	pr_debug("md/raid0:%s: done.\n", mdname(mddev));
  	*private_conf = conf;

-- 
2.11.0

