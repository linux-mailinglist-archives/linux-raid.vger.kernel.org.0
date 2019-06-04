Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F39352F6
	for <lists+linux-raid@lfdr.de>; Wed,  5 Jun 2019 01:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFDXGA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 4 Jun 2019 19:06:00 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.97]:43973 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfFDXF7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 4 Jun 2019 19:05:59 -0400
X-Greylist: delayed 1298 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 19:05:59 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 3E16F86BDC
        for <linux-raid@vger.kernel.org>; Tue,  4 Jun 2019 17:44:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YIAHhVsO24FKpYIAHhpvK0; Tue, 04 Jun 2019 17:44:21 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.120] (port=44374 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hYIAG-000OFr-Ca; Tue, 04 Jun 2019 17:44:20 -0500
Date:   Tue, 4 Jun 2019 17:44:18 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Shaohua Li <shli@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] md: raid10: Use struct_size() in kmalloc()
Message-ID: <20190604224418.GA23187@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.120
X-Source-L: No
X-Exim-ID: 1hYIAG-000OFr-Ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.120]:44374
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
   int stuff;
   struct boo entry[];
};

instance = kmalloc(size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/md/raid10.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index aea11476fee6..3caafd433163 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4780,8 +4780,7 @@ static int handle_reshape_read_error(struct mddev *mddev,
 	int idx = 0;
 	struct page **pages;
 
-	r10b = kmalloc(sizeof(*r10b) +
-	       sizeof(struct r10dev) * conf->copies, GFP_NOIO);
+	r10b = kmalloc(struct_size(r10b, devs, conf->copies), GFP_NOIO);
 	if (!r10b) {
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 		return -ENOMEM;
-- 
2.21.0

