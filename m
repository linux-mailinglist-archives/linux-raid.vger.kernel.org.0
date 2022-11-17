Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0662CF0F
	for <lists+linux-raid@lfdr.de>; Thu, 17 Nov 2022 00:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiKPXq5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Nov 2022 18:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiKPXqp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 16 Nov 2022 18:46:45 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03C6266E
        for <linux-raid@vger.kernel.org>; Wed, 16 Nov 2022 15:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Vs88+o17X8gJhTh4HNSRTOQqoUl4H5167igPUxm1Fns=; b=cmwJlwuY40mWHt361ZQI/kKjPS
        vUR6FmxkJ3zlSC9roXdCBFZPg4iyMfzClbvWo+73pgBeLM7ROd+XY8M0oH1Gcy12TNxRTEhhTQ6Su
        d3mpb3zPP4FNZ4K4Cy9IoHBuuBvlksOwZSsP6HL3o4VVIeYlTmFKIwBX7igY3tGSUin39DdwrC/xh
        qyfuXogwYRcv7WA+77F+CldTUDLf61EBEzyt1HvcXaDHWrAGXe9Sg3uhJhmUBwS8b+E4ZnvBodv3R
        GqrD2fWwD9uCStSbJO3/Sre3FzhKh27lpGKU4DpSprLkxukEkPjJV+dB1YNWkE2J+NwAO2xNW600/
        8o+eJN/Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ovS70-0043vR-V7; Wed, 16 Nov 2022 16:46:35 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ovS6w-000KgR-S6; Wed, 16 Nov 2022 16:46:30 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-raid@vger.kernel.org, Jes Sorensen <jes@trained-monkey.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, Xiao Ni <xni@redhat.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Coly Li <colyli@suse.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jonmichael Hands <jm@chia.net>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Kinga Tanska <kinga.tanska@linux.intel.com>
Date:   Wed, 16 Nov 2022 16:46:15 -0700
Message-Id: <20221116234617.79441-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116234617.79441-1-logang@deltatee.com>
References: <20221116234617.79441-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-raid@vger.kernel.org, jes@trained-monkey.org, guoqing.jiang@linux.dev, xni@redhat.com, colyli@suse.de, chaitanyak@nvidia.com, jm@chia.net, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, mariusz.tkaczyk@linux.intel.com, kinga.tanska@linux.intel.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH mdadm v5 4/7] mdadm: Introduce pr_info()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Feedback was given to avoid informational pr_err() calls that print
to stderr, even though that's done all through out the code.

Using printf() directly doesn't maintain the same format (an "mdadm"
prefix on every line.

So introduce pr_info() which prints to stdout with the same format
and use it for a couple informational pr_err() calls in Create().

Future work can make this call used in more cases.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Kinga Tanska <kinga.tanska@linux.intel.com>
---
 Create.c | 7 ++++---
 mdadm.h  | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Create.c b/Create.c
index 6a0446644e04..4acda30c5256 100644
--- a/Create.c
+++ b/Create.c
@@ -984,11 +984,12 @@ int Create(struct supertype *st, char *mddev,
 
 			mdi = sysfs_read(-1, devnm, GET_VERSION);
 
-			pr_err("Creating array inside %s container %s\n",
+			pr_info("Creating array inside %s container %s\n",
 				mdi?mdi->text_version:"managed", devnm);
 			sysfs_free(mdi);
 		} else
-			pr_err("Defaulting to version %s metadata\n", info.text_version);
+			pr_info("Defaulting to version %s metadata\n",
+				info.text_version);
 	}
 
 	map_update(&map, fd2devnm(mdfd), info.text_version,
@@ -1145,7 +1146,7 @@ int Create(struct supertype *st, char *mddev,
 			ioctl(mdfd, RESTART_ARRAY_RW, NULL);
 		}
 		if (c->verbose >= 0)
-			pr_err("array %s started.\n", mddev);
+			pr_info("array %s started.\n", mddev);
 		if (st->ss->external && st->container_devnm[0]) {
 			if (need_mdmon)
 				start_mdmon(st->container_devnm);
diff --git a/mdadm.h b/mdadm.h
index 3673494e560b..18c24915e94c 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -1798,6 +1798,8 @@ static inline int xasprintf(char **strp, const char *fmt, ...) {
 #endif
 #define cont_err(fmt ...) fprintf(stderr, "       " fmt)
 
+#define pr_info(fmt, args...) printf("%s: "fmt, Name, ##args)
+
 void *xmalloc(size_t len);
 void *xrealloc(void *ptr, size_t len);
 void *xcalloc(size_t num, size_t size);
-- 
2.30.2

