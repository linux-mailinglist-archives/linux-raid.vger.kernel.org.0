Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51443BCBA6
	for <lists+linux-raid@lfdr.de>; Tue, 24 Sep 2019 17:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbfIXPjZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 24 Sep 2019 11:39:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388457AbfIXPjZ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 24 Sep 2019 11:39:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 915143A206;
        Tue, 24 Sep 2019 15:39:25 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 605385D721;
        Tue, 24 Sep 2019 15:39:25 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     jes.sorensen@gmail.com, linux-raid@vger.kernel.org, xni@redhat.com,
        heinzm@redhat.com
Subject: [PATCH] mdadm: force a uuid swap on big endian
Date:   Tue, 24 Sep 2019 11:39:24 -0400
Message-Id: <20190924153924.12503-1-ncroxon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 24 Sep 2019 15:39:25 +0000 (UTC)
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

