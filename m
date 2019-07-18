Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E75F96CF6A
	for <lists+linux-raid@lfdr.de>; Thu, 18 Jul 2019 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbfGROD6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 18 Jul 2019 10:03:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfGROD6 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 18 Jul 2019 10:03:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A709C0703A8
        for <linux-raid@vger.kernel.org>; Thu, 18 Jul 2019 14:03:58 +0000 (UTC)
Received: from [10.10.122.202] (ovpn-122-202.rdu2.redhat.com [10.10.122.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 033F7617B0
        for <linux-raid@vger.kernel.org>; Thu, 18 Jul 2019 14:03:57 +0000 (UTC)
To:     linux-raid <linux-raid@vger.kernel.org>
From:   Nigel Croxon <ncroxon@redhat.com>
Subject: mdadm reports two different UUIDs on s390
Message-ID: <217187f9-dbbe-de61-01e5-cf8f1f26f087@redhat.com>
Date:   Thu, 18 Jul 2019 10:03:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 18 Jul 2019 14:03:58 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The problem is:
"mdadm --detail" and "mdadm --detail --export" report two different 
UUIDs for one array, and this happens only on s390x.

The code path for metadata 0.90 calls a common routine fname_from_uuid 
that uses metadata 1.2 (&super1).
The code expects member swapuuid to be setup and usable. But it is only 
setup when using metadata 1.2.
Since the metadata 0.90 did not create swapuuid and set it.
The test (st->ss == &super1) ? 1 : st->ss->swapuuid fails.
The swapuuid is set at compile time based on byte order, for super1 only.
Any call based on metadata 0.90 and on big endian processors, the 
--export uuid will be incorrect.

I looked at adding .swapuuid to the end of the list in superswitch 
super0 (super0.c). But then
in the routine fname_from_uuid (util.c), one would have to figure out 
which metadata is being
used to then use the right address of super0 or super1.

An alternative is the patch below.

-Nigel

---
  util.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/util.c b/util.c
index c26cf5f..64dd409 100644
--- a/util.c
+++ b/util.c
@@ -685,8 +685,12 @@ char *fname_from_uuid(struct supertype *st, struct 
mdinfo *info,
      // work, but can't have it set if we want this printout to match
      // all the other uuid printouts in super1.c, so we force swapuuid
      // to 1 to make our printout match the rest of super1
+#if __BYTE_ORDER == BIG_ENDIAN
+    return __fname_from_uuid(info->uuid, 1, buf, sep);
+#else
      return __fname_from_uuid(info->uuid, (st->ss == &super1) ? 1 :
                   st->ss->swapuuid, buf, sep);
+#endif
  }

  int check_ext2(int fd, char *name)
-- 
2.20.1



