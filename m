Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8003FEA7E8
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 00:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfJ3X4r (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 19:56:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:37870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727700AbfJ3X4q (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 30 Oct 2019 19:56:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCD9CB308;
        Wed, 30 Oct 2019 23:56:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Thu, 31 Oct 2019 10:56:04 +1100
Subject: [PATCH 2/2] Assemble: add support for RAID0 layouts.
Cc:     linux-raid@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>
Message-ID: <157247976452.8013.2396485247609220571.stgit@noble.brown>
In-Reply-To: <157247951643.8013.12020039865359474811.stgit@noble.brown>
References: <157247951643.8013.12020039865359474811.stgit@noble.brown>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

If you have a RAID0 array with varying sized devices
on a kernel before 5.4, you cannot assembling it on
5.4 or later without explicitly setting the layout.
This is now possible with
  --update=layout-original (For 3.13 and earlier kernels)
or
  --update=layout-alternate (for 3.15 and later kernels)

Signed-off-by: NeilBrown <neilb@suse.de>
---
 Assemble.c |    8 ++++++++
 md.4       |    7 +++++++
 mdadm.8.in |   17 +++++++++++++++++
 mdadm.c    |    4 ++++
 super1.c   |   12 +++++++++++-
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Assemble.c b/Assemble.c
index b2e69144f1a2..4066f93e977f 100644
--- a/Assemble.c
+++ b/Assemble.c
@@ -1031,6 +1031,11 @@ static int start_array(int mdfd,
 				pr_err("failed to add %s to %s: %s\n",
 				       devices[j].devname, mddev,
 				       strerror(errno));
+				if (errno == EINVAL && content->array.level == 0 &&
+				    content->array.layout != 0) {
+					cont_err("Possibly your kernel doesn't support RAID0 layouts.\n");
+					cont_err("Please upgrade.\n");
+				}
 				if (i < content->array.raid_disks * 2 ||
 				    i == bestcnt)
 					okcnt--;
@@ -1220,6 +1225,9 @@ static int start_array(int mdfd,
 			return 0;
 		}
 		pr_err("failed to RUN_ARRAY %s: %s\n", mddev, strerror(errno));
+		if (errno == 524 /* ENOTSUP */ &&
+		    content->array.level == 0 && content->array.layout == 0)
+			cont_err("Pleasse use --update=layout-original or --update=layout=alternate\n");
 
 		if (!enough(content->array.level, content->array.raid_disks,
 			    content->array.layout, 1, avail))
diff --git a/md.4 b/md.4
index 6fe275541abd..0712af255dd5 100644
--- a/md.4
+++ b/md.4
@@ -208,6 +208,13 @@ array,
 will record the chosen layout in the metadata in a way that allows newer
 kernels to assemble the array without needing a module parameter.
 
+To assemble an old array on a new kernel without using the module parameter,
+use either the
+.B "--update=layout-original"
+option or the
+.B "--update=layout-alternate"
+option.
+
 .SS RAID1
 
 A RAID1 array is also known as a mirrored set (though mirrors tend to
diff --git a/mdadm.8.in b/mdadm.8.in
index ea07c429e668..7240d461bdc9 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -1213,6 +1213,8 @@ argument given to this flag can be one of
 .BR no\-bbl ,
 .BR ppl ,
 .BR no\-ppl ,
+.BR layout\-original ,
+.BR layout\-alternate ,
 .BR metadata ,
 or
 .BR super\-minor .
@@ -1364,6 +1366,21 @@ The
 .B no\-ppl
 option will disable PPL in the superblock.
 
+The
+.B layout\-original
+and
+.B layout\-alternate
+options are for RAID0 arrays is use before Linux 5.4.  If the array was being
+used with Linux 3.13 or earlier, then the assemble the array on a new kernel,
+.B \-\-update=layout\-original
+must be given.  If the array was created and used with a kernel from Linux 3.14 to
+Linux 5.3, then
+.B \-\-update=layout\-alternate
+must be given.  This only needs to be given once.  Subsequent assembly of the array
+will happen normally.
+For more information, so
+.IR md (4).
+
 .TP
 .BR \-\-freeze\-reshape
 Option is intended to be used in start-up scripts during initrd boot phase.
diff --git a/mdadm.c b/mdadm.c
index e438f9c864da..256a97ef07f5 100644
--- a/mdadm.c
+++ b/mdadm.c
@@ -795,6 +795,9 @@ int main(int argc, char *argv[])
 				continue;
 			if (strcmp(c.update, "revert-reshape") == 0)
 				continue;
+			if (strcmp(c.update, "layout-original") == 0 ||
+			    strcmp(c.update, "layout-alternate") == 0)
+				continue;
 			if (strcmp(c.update, "byteorder") == 0) {
 				if (ss) {
 					pr_err("must not set metadata type with --update=byteorder.\n");
@@ -825,6 +828,7 @@ int main(int argc, char *argv[])
 		"     'summaries', 'homehost', 'home-cluster', 'byteorder', 'devicesize',\n"
 		"     'no-bitmap', 'metadata', 'revert-reshape'\n"
 		"     'bbl', 'no-bbl', 'force-no-bbl', 'ppl', 'no-ppl'\n"
+		"     'layout-original', 'layout-alternate'\n"
 				);
 			exit(outf == stdout ? 0 : 2);
 
diff --git a/super1.c b/super1.c
index 312303fecbe1..d8f4403f0388 100644
--- a/super1.c
+++ b/super1.c
@@ -1550,7 +1550,17 @@ static int update_super1(struct supertype *st, struct mdinfo *info,
 		sb->devflags |= FailFast1;
 	else if (strcmp(update, "nofailfast") == 0)
 		sb->devflags &= ~FailFast1;
-	else
+	else if (strcmp(update, "layout-original") == 0 ||
+		 strcmp(update, "layout-alternate") == 0) {
+		if (__le32_to_cpu(sb->level) != 0) {
+			pr_err("%s: %s only supported for RAID0\n",
+			       devname?:"", update);
+			rv = -1;
+		} else {
+			sb->feature_map |= __cpu_to_le32(MD_FEATURE_RAID0_LAYOUT);
+			sb->layout = __cpu_to_le32(update[7] == 'o' ? 1 : 2);
+		}
+	} else
 		rv = -1;
 
 	sb->sb_csum = calc_sb_1_csum(sb);


