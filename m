Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E7A136BB2
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jan 2020 12:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgAJLHi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Jan 2020 06:07:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:50274 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbgAJLHi (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 10 Jan 2020 06:07:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 03:07:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,416,1571727600"; 
   d="scan'208";a="304140849"
Received: from linux-3rn9.igk.intel.com ([10.102.102.97])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2020 03:07:36 -0800
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
Subject: [PATCH] Add support for Tebibytes
Date:   Fri, 10 Jan 2020 12:10:46 +0100
Message-Id: <20200110111046.1802-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Adding support for Tebibytes enables display size of
volumes in Tebibytes and Terabytes when they are
bigger than 2048 GiB (or GB).

Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
---
 mdadm.8.in | 20 ++++++++++----------
 util.c     | 47 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/mdadm.8.in b/mdadm.8.in
index 9aec9f4..ad7a0aa 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -467,8 +467,8 @@ If this is not specified
 size, though if there is a variance among the drives of greater than 1%, a warning is
 issued.
 
-A suffix of 'K', 'M' or 'G' can be given to indicate Kilobytes, Megabytes or
-Gigabytes respectively.
+A suffix of 'K', 'M', 'G' or 'T' can be given to indicate Kilobytes,
+Megabytes, Gigabytes or Terabytes respectively.
 
 Sometimes a replacement drive can be a little smaller than the
 original drives though this should be minimised by IDEMA standards.
@@ -534,8 +534,8 @@ problems the array can be made bigger again with no loss with another
 .B "\-\-grow \-\-array\-size="
 command.
 
-A suffix of 'K', 'M' or 'G' can be given to indicate Kilobytes, Megabytes or
-Gigabytes respectively.
+A suffix of 'K', 'M', 'G' or 'T' can be given to indicate Kilobytes,
+Megabytes, Gigabytes or Terabytes respectively.
 A value of
 .B max
 restores the apparent size of the array to be whatever the real
@@ -553,8 +553,8 @@ This is only meaningful for RAID0, RAID4, RAID5, RAID6, and RAID10.
 RAID4, RAID5, RAID6, and RAID10 require the chunk size to be a power
 of 2.  In any case it must be a multiple of 4KB.
 
-A suffix of 'K', 'M' or 'G' can be given to indicate Kilobytes, Megabytes or
-Gigabytes respectively.
+A suffix of 'K', 'M', 'G' or 'T' can be given to indicate Kilobytes,
+Megabytes, Gigabytes or Terabytes respectively.
 
 .TP
 .BR \-\-rounding=
@@ -741,8 +741,8 @@ When using an
 bitmap, the chunksize defaults to 64Meg, or larger if necessary to
 fit the bitmap into the available space.
 
-A suffix of 'K', 'M' or 'G' can be given to indicate Kilobytes, Megabytes or
-Gigabytes respectively.
+A suffix of 'K', 'M', 'G' or 'T' can be given to indicate Kilobytes,
+Megabytes, Gigabytes or Terabytes respectively.
 
 .TP
 .BR \-W ", " \-\-write\-mostly
@@ -831,8 +831,8 @@ an array which was originally created using a different version of
 which computed a different offset.
 
 Setting the offset explicitly over-rides the default.  The value given
-is in Kilobytes unless a suffix of 'K', 'M' or 'G' is used to explicitly
-indicate Kilobytes, Megabytes or Gigabytes respectively.
+is in Kilobytes unless a suffix of 'K', 'M', 'G' or 'T' is used to explicitly
+indicate Kilobytes, Megabytes, Gigabytes or Terabytes respectively.
 
 Since Linux 3.4,
 .B \-\-data\-offset
diff --git a/util.c b/util.c
index 64dd409..1986d9f 100644
--- a/util.c
+++ b/util.c
@@ -389,7 +389,7 @@ int mdadm_version(char *version)
 unsigned long long parse_size(char *size)
 {
 	/* parse 'size' which should be a number optionally
-	 * followed by 'K', 'M', or 'G'.
+	 * followed by 'K', 'M'. 'G' or 'T'.
 	 * Without a suffix, K is assumed.
 	 * Number returned is in sectors (half-K)
 	 * INVALID_SECTORS returned on error.
@@ -411,6 +411,10 @@ unsigned long long parse_size(char *size)
 			c++;
 			s *= 1024 * 1024 * 2;
 			break;
+		case 'T':
+			c++;
+			s *= 1024 * 1024 * 1024 * 2L;
+			break;
 		case 's': /* sectors */
 			c++;
 			break;
@@ -893,13 +897,14 @@ char *human_size(long long bytes)
 {
 	static char buf[47];
 
-	/* We convert bytes to either centi-M{ega,ibi}bytes or
-	 * centi-G{igi,ibi}bytes, with appropriate rounding,
-	 * and then print 1/100th of those as a decimal.
+	/* We convert bytes to either centi-M{ega,ibi}bytes,
+	 * centi-G{igi,ibi}bytes or centi-T{era,ebi}bytes
+	 * with appropriate rounding, and then print
+	 * 1/100th of those as a decimal.
 	 * We allow upto 2048Megabytes before converting to
-	 * gigabytes, as that shows more precision and isn't
+	 * gigabytes and 2048Gigabytes before converting to
+	 * terabytes, as that shows more precision and isn't
 	 * too large a number.
-	 * Terabytes are not yet handled.
 	 */
 
 	if (bytes < 5000*1024)
@@ -909,11 +914,16 @@ char *human_size(long long bytes)
 		long cMB  = (bytes / ( 1000000LL / 200LL ) +1) /2;
 		snprintf(buf, sizeof(buf), " (%ld.%02ld MiB %ld.%02ld MB)",
 			cMiB/100, cMiB % 100, cMB/100, cMB % 100);
-	} else {
+	} else if (bytes < 2*1024LL*1024LL*1024LL*1024LL) {
 		long cGiB = (bytes * 200LL / (1LL<<30) +1) / 2;
 		long cGB  = (bytes / (1000000000LL/200LL ) +1) /2;
 		snprintf(buf, sizeof(buf), " (%ld.%02ld GiB %ld.%02ld GB)",
 			cGiB/100, cGiB % 100, cGB/100, cGB % 100);
+	} else {
+		long cTiB = (bytes * 200LL / (1LL<<40) + 1) / 2;
+		long cTB  = (bytes / (1000000000000LL / 200LL) + 1) / 2;
+		snprintf(buf, sizeof(buf), " (%ld.%02ld TiB %ld.%02ld TB)",
+			cTiB/100, cTiB % 100, cTB/100, cTB % 100);
 	}
 	return buf;
 }
@@ -922,13 +932,14 @@ char *human_size_brief(long long bytes, int prefix)
 {
 	static char buf[30];
 
-	/* We convert bytes to either centi-M{ega,ibi}bytes or
-	 * centi-G{igi,ibi}bytes, with appropriate rounding,
-	 * and then print 1/100th of those as a decimal.
+	/* We convert bytes to either centi-M{ega,ibi}bytes,
+	 * centi-G{igi,ibi}bytes or centi-T{era,ebi}bytes
+	 * with appropriate rounding, and then print
+	 * 1/100th of those as a decimal.
 	 * We allow upto 2048Megabytes before converting to
-	 * gigabytes, as that shows more precision and isn't
+	 * gigabytes and 2048Gigabytes before converting to
+	 * terabytes, as that shows more precision and isn't
 	 * too large a number.
-	 * Terabytes are not yet handled.
 	 *
 	 * If prefix == IEC, we mean prefixes like kibi,mebi,gibi etc.
 	 * If prefix == JEDEC, we mean prefixes like kilo,mega,giga etc.
@@ -941,10 +952,14 @@ char *human_size_brief(long long bytes, int prefix)
 			long cMiB = (bytes * 200LL / (1LL<<20) +1) /2;
 			snprintf(buf, sizeof(buf), "%ld.%02ldMiB",
 				 cMiB/100, cMiB % 100);
-		} else {
+		} else if (bytes < 2*1024LL*1024LL*1024LL*1024LL) {
 			long cGiB = (bytes * 200LL / (1LL<<30) +1) /2;
 			snprintf(buf, sizeof(buf), "%ld.%02ldGiB",
 				 cGiB/100, cGiB % 100);
+		} else {
+			long cTiB = (bytes * 200LL / (1LL<<40) + 1) / 2;
+			snprintf(buf, sizeof(buf), "%ld.%02ldTiB",
+				 cTiB/100, cTiB % 100);
 		}
 	}
 	else if (prefix == JEDEC) {
@@ -952,10 +967,14 @@ char *human_size_brief(long long bytes, int prefix)
 			long cMB  = (bytes / ( 1000000LL / 200LL ) +1) /2;
 			snprintf(buf, sizeof(buf), "%ld.%02ldMB",
 				 cMB/100, cMB % 100);
-		} else {
+		} else if (bytes < 2*1024LL*1024LL*1024LL*1024LL) {
 			long cGB  = (bytes / (1000000000LL/200LL ) +1) /2;
 			snprintf(buf, sizeof(buf), "%ld.%02ldGB",
 				 cGB/100, cGB % 100);
+		} else {
+			long cTB  = (bytes / (1000000000000LL / 200LL) + 1) / 2;
+			snprintf(buf, sizeof(buf), "%ld.%02ldTB",
+				 cTB/100, cTB % 100);
 		}
 	}
 	else
-- 
2.16.4

