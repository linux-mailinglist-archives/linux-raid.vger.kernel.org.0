Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6CD1F75B8
	for <lists+linux-raid@lfdr.de>; Fri, 12 Jun 2020 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgFLJJz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 12 Jun 2020 05:09:55 -0400
Received: from mail.synology.com ([211.23.38.101]:45886 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgFLJJz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 12 Jun 2020 05:09:55 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 05:09:54 EDT
Received: from localhost.localdomain (unknown [10.17.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 61948CE7821B;
        Fri, 12 Jun 2020 17:00:58 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1591952458; bh=0DqghRP5VZsuXuWx7+SrZxxzTFudP/NH4KuSF9JQi0M=;
        h=From:To:Cc:Subject:Date;
        b=awMWLp/nh2Mg5nmSgkblTZvYJy+hQIwivU7JdXXwPvmVGD4sCBM8qn2wZbnYNVorQ
         UUkJ3I4GDZluLCSdMrvYklUSKXnZS2+NmAA7RW0UiIT4gHj9Y4bGkG9fZOeTSjchT4
         X/3sZi1HvLUshnnbfw5HhlibPqQ6P7NBqkjBKXH4=
From:   allenpeng <allenpeng@synology.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com, allenpeng <allenpeng@synology.com>
Subject: [PATCH] mdadm/Grow: prevent md's fd from being occupied during delayed time
Date:   Fri, 12 Jun 2020 17:00:39 +0800
Message-Id: <1591952439-8768-1-git-send-email-allenpeng@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

If we start reshaping on md which shares sub-devices with another
resyncing md, it may be forced to wait for others to complete. mdadm
occupies the md's fd during this time, which causes the md can not be
stopped and the filesystem can not be mounted on the md. We can close
md's fd earlier to solve this problem.

Reproducible Steps:

1. create two partitions on sda, sdb, sdc, sdd
2. create raid1 with sda1, sdb1
mdadm -C /dev/md1 --assume-clean -l1 -n2 /dev/sda1 /dev/sdb1
3. create raid5 with sda2, sdb2, sdc2
mdadm -C /dev/md2 --assume-clean -l5 -n3 /dev/sda2 /dev/sdb2 /dev/sdc2
4. start resync at md1
echo repair > /sys/block/md1/md/sync_action
5. reshape raid5 to raid6
mdadm -a /dev/md2 /dev/sdd2
mdadm --grow /dev/md2 -n4 -l6 --backup-file=/root/md2-backup

Now mdadm is occupying the fd of md2, causing md2 unable to be stopped

6.Try to stop md2, an error message shows
mdadm -S /dev/md2
mdadm: Cannot get exclusive access to /dev/md3:Perhaps a running process,
mounted filesystem or active volume group?

Reviewed-by: Alex Wu <alexwu@synology.com>
Reviewed-by: BingJing Chang <bingjingc@synology.com>
Reviewed-by: Danny Shih <dannyshih@synology.com>
Signed-off-by: ChangSyun Peng <allenpeng@synology.com>
---
 Grow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Grow.c b/Grow.c
index a4be7e7..5b8f774 100644
--- a/Grow.c
+++ b/Grow.c
@@ -3514,6 +3514,7 @@ started:
 			return 0;
 		}
 
+	close(fd);
 	/* Now we just need to kick off the reshape and watch, while
 	 * handling backups of the data...
 	 * This is all done by a forked background process.
@@ -3566,7 +3567,6 @@ started:
 			mdstat_wait(30 - (delayed-1) * 25);
 	} while (delayed);
 	mdstat_close();
-	close(fd);
 	if (check_env("MDADM_GROW_VERIFY"))
 		fd = open(devname, O_RDONLY | O_DIRECT);
 	else
-- 
2.7.4

