Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D633221B98
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 06:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgGPEyr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 00:54:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31387 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgGPEyq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jul 2020 00:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594875286; x=1626411286;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=rgCjI2vah6WLGpcyHZBso+1JVLm/Eiic85DDcIAXaZ4=;
  b=TL4WTUhNuIjEBHyr/azCC2w3gWMXenQ7pma9277FyaTS9I5NscU/hxIB
   BVwqgH/WBV5uWAO91ZiihBJs1oBQXYpNHXH0sZ3I5aoUZUEysOo2Xuz35
   3h7t6COqpKt789jQ5hK9HBwaqC06pLccsCpfoQ9R4V+EF1jO5vcvlryad
   7KPrxcl79fV+fk8NrSnVtnYxmO4BpUF3+6G4KnDtRP0sLRiqJY4oyxouc
   jBsGvEFXd8kUbPW8thD9W7veXX2SJ46b5nAQ3kpkrxrCs9+Oe4yjAL3Ls
   nLMYdVizFJl1alk24Ckp0y+aUmcGeYw1ki3Oi+pje2MRtAHy60Jj8mNKC
   w==;
IronPort-SDR: dwblKNOL0nSECXZ6qAjaRoA8x8y+MEPs4T2lsd7BXfm8k7LsoWLrySYzlusOsHYo1jlsXkpVr8
 TbWt1dPmsP1pxuSdmxoIWLmDD4NBiF7C861OqQjYRS3QzxBq9R6STuj/HnlHyxao3ZZVD1QOQp
 Pf+VITg7W/3ttEkqlxM1HpEs2mFanE33+qKv7ZrCljAZWJW13yu6g1H3/7QF4vBlsEANIw0LiY
 jLHWVkBHiCGFwQzoAlz7DMKBwXaCI+HELCY4EpS/FNeeT1pD35z8JznX2bkf6aznEneTHApYY5
 4vk=
X-IronPort-AV: E=Sophos;i="5.75,358,1589212800"; 
   d="scan'208";a="142711738"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 12:54:45 +0800
IronPort-SDR: 2dIuBoz0W3qwCI9zMuig+1v5vIDeEJCPPP2r8DSuh+2rvFjAQZe4dRHdrtKhAs5zenyjSoA+0Q
 0eopz37B1Ps3xURVKpompgJFkNg0G2ZBo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 21:42:36 -0700
IronPort-SDR: GS9ZYB63BjL/5X1Ul3SYzspjbE8m9vBqOHe3JuqxgKhLdJocr3E7mpgFjmLFrdZrJFoI1o3Py4
 e+Bn21iKGhEQ==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2020 21:54:45 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH 2/4] md: raid5-cache: Remove set but unused variable
Date:   Thu, 16 Jul 2020 13:54:41 +0900
Message-Id: <20200716045443.662056-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716045443.662056-1-damien.lemoal@wdc.com>
References: <20200716045443.662056-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Remove the variable offset in r5c_tree_index() to avoid a "set but not
used" compilation warning when compiling with W=1.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/raid5-cache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 0bea21d81697..34fd942dad83 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -195,9 +195,7 @@ struct r5l_log {
 static inline sector_t r5c_tree_index(struct r5conf *conf,
 				      sector_t sect)
 {
-	sector_t offset;
-
-	offset = sector_div(sect, conf->chunk_sectors);
+	sector_div(sect, conf->chunk_sectors);
 	return sect;
 }
 
-- 
2.26.2

