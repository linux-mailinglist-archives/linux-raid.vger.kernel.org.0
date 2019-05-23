Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14338277BE
	for <lists+linux-raid@lfdr.de>; Thu, 23 May 2019 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfEWIN3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 23 May 2019 04:13:29 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:50142 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWIN2 (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Thu, 23 May 2019 04:13:28 -0400
Received: from linux-2xn2.suse.asia (prva10-snat226-1.provo.novell.com [137.65.226.35])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 23 May 2019 02:13:24 -0600
From:   Guoqing Jiang <gqjiang@suse.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        NeilBrown <neilb@suse.com>
Subject: [RFC PATCH] mdadm/md.4: add the descriptions for bitmap sysfs nodes
Date:   Thu, 23 May 2019 16:32:02 +0800
Message-Id: <20190523083202.12294-1-gqjiang@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The sysfs nodes under bitmap are not recorded in md.4,
add them based on md.rst and kernel source code.

Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
---
Hi,

Please feel free to correct the descriptions since my understanding
could be wrong.

Thanks,
Guoqing

 md.4 | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/md.4 b/md.4
index 3a1d6777e5b7..e81f38e40e77 100644
--- a/md.4
+++ b/md.4
@@ -1101,6 +1101,63 @@ stripe that requires some "prereading".  For fairness this defaults to
 maximizes sequential-write throughput at the cost of fairness to threads
 doing small or random writes.
 
+.TP
+.B md/bitmap/backlog
+This is only available on RAID1. when write-mostly devices are active,
+write requests to those devices proceed in the background.
+
+This variable sets a limit on the number of concurrent background writes,
+the valid values are 0 to 256, 0 means that write-behind is not allowed,
+while any other number means it can happen. If there are more write request
+than the number, new writes will by synchronous.
+
+.TP
+.B md/bitmap/can_clear
+Write 'true' to 'bitmap/can_clear' will allow bits in the bitmap to be
+cleared again, write 'false' means bits in the bitmap don't need to be
+cleared.
+
+.TP
+.B md/bitmap/chunksize
+The bitmap chunksize can only be changed when no bitmap is active, and
+the value should be power of 2 and bigger than 512.
+
+.TP
+.B md/bitmap/location
+This indicates where the write-intent bitmap for the array is stored.
+
+Write 'none' to 'bitmap/location' will clear bitmap, and the previous
+location value must be write to it to restore bitmap.
+
+.TP
+.B md/bitmap/max_backlog_used
+This keeps track of the maximum number of concurrent write-behind requests
+for an md array, writing any value to this file will clear it.
+
+.TP
+.B md/bitmap/metadata
+This can be either 'internal' or 'external'. 'internal' is set by default,
+which means the metadata for bitmap is stored in the first 256 bytes of
+the bitmap space. 'external' means that bitmap metadata is managed externally
+to the kernel.
+
+.TP
+.B md/bitmap/space
+This shows the space (in sectors) which is available at md/bitmap/location,
+and allows the kernel to know when it is safe to resize the bitmap to match
+a resized array. It should big enough to contain the total bytes in the bitmap.
+
+For 1.0 metadata, assume we can use up to the superblock if before, else
+to 4K beyond superblock. For other metadata versions, assume no change is
+possible.
+
+.TP
+.B md/bitmap/time_base
+This shows the time (in seconds) between disk flushes, and is used to looking
+for bits in the bitmap to be cleared.
+
+The default value is 5 seconds, and it should be an unsigned long value.
+
 .SS KERNEL PARAMETERS
 
 The md driver recognised several different kernel parameters.
-- 
2.12.3

