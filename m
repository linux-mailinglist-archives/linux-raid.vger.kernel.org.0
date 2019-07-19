Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8664A6E2D6
	for <lists+linux-raid@lfdr.de>; Fri, 19 Jul 2019 10:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfGSIsS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Jul 2019 04:48:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfGSIsR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 19 Jul 2019 04:48:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF5E430821C0;
        Fri, 19 Jul 2019 08:48:17 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 554DF5DA38;
        Fri, 19 Jul 2019 08:48:14 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com, ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH 1/1] Don't allow create ddf container on partitioned devices
Date:   Fri, 19 Jul 2019 16:48:12 +0800
Message-Id: <1563526092-17731-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 19 Jul 2019 08:48:17 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 super-ddf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/super-ddf.c b/super-ddf.c
index c095e8a..49f7d94 100644
--- a/super-ddf.c
+++ b/super-ddf.c
@@ -3469,6 +3469,9 @@ validate_geometry_ddf_container(struct supertype *st,
 			       dev, strerror(errno));
 		return 0;
 	}
+	if (test_partition(fd))
+		/* DDF is not allowed on partitions */
+		return 1;
 	if (!get_dev_size(fd, dev, &ldsize)) {
 		close(fd);
 		return 0;
-- 
2.7.5

