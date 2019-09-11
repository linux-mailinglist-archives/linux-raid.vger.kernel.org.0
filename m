Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B705AFBDE
	for <lists+linux-raid@lfdr.de>; Wed, 11 Sep 2019 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfIKLug (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Sep 2019 07:50:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfIKLug (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 11 Sep 2019 07:50:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15F7720E1;
        Wed, 11 Sep 2019 11:50:36 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D82A85DD61;
        Wed, 11 Sep 2019 11:50:35 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     linux-raid@vger.kernel.org, jes.sorensen@gmail.com, xni@redhat.com
Subject: [PATCH] mdadm: force a uuid swap on big endian
Date:   Wed, 11 Sep 2019 07:50:35 -0400
Message-Id: <20190911115035.9507-1-ncroxon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Wed, 11 Sep 2019 11:50:36 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The code path for metadata 0.90 calls a common routine
fname_from_uuid that uses metadata 1.2. The code expects member
swapuuid to be setup and usable. But it is only setup when using
metadata 1.2. Since the metadata 0.90 did not create swapuuid
and set it. The test (st->ss == &super1) ? 1 : st->ss->swapuuid
fails. The swapuuid is set at compile time based on byte order.
Any call based on metadata 0.90 and on big endian processors,
the --export uuid will be incorrect.

Signed-Off-by: Nigel Croxon <ncroxon@redhat.com>
---
 util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/util.c b/util.c
index c26cf5f..64dd409 100644
--- a/util.c
+++ b/util.c
@@ -685,8 +685,12 @@ char *fname_from_uuid(struct supertype *st, struct mdinfo *info,
 	// work, but can't have it set if we want this printout to match
 	// all the other uuid printouts in super1.c, so we force swapuuid
 	// to 1 to make our printout match the rest of super1
+#if __BYTE_ORDER == BIG_ENDIAN
+	return __fname_from_uuid(info->uuid, 1, buf, sep);
+#else
 	return __fname_from_uuid(info->uuid, (st->ss == &super1) ? 1 :
 				 st->ss->swapuuid, buf, sep);
+#endif
 }
 
 int check_ext2(int fd, char *name)
-- 
2.20.1

