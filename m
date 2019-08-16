Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54DE8FF0A
	for <lists+linux-raid@lfdr.de>; Fri, 16 Aug 2019 11:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfHPJ2x (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 05:28:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:6189 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHPJ2w (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 16 Aug 2019 05:28:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 02:28:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="352497006"
Received: from linux-qgmk.igk.intel.com ([10.102.102.210])
  by orsmga005.jf.intel.com with ESMTP; 16 Aug 2019 02:28:50 -0700
From:   Krzysztof Smolinski <krzysztof.smolinski@intel.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Krzysztof Smolinski <krzysztof.smolinski@intel.com>
Subject: [PATCH] imsm: data offset support during first volume creation
Date:   Fri, 16 Aug 2019 11:26:33 +0200
Message-Id: <20190816092633.12889-1-krzysztof.smolinski@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

When creating first volume in IMSM container --data-offset
parameter can be provided to specify volume data offset (reserve
space preceding volume start). When no value is provided then 1 MiB
default value is used.

Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
---
 mdadm.8.in    | 12 ++++++---
 mdadm.c       | 28 +++++++++++++--------
 mdadm.h       |  7 +++---
 super-intel.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 util.c        |  2 +-
 5 files changed, 101 insertions(+), 28 deletions(-)

diff --git a/mdadm.8.in b/mdadm.8.in
index 9aec9f4f..4060ef07 100644
--- a/mdadm.8.in
+++ b/mdadm.8.in
@@ -820,9 +820,9 @@ being reshaped.
 
 .TP
 .B \-\-data\-offset=
-Arrays with 1.x metadata can leave a gap between the start of the
-device and the start of array data.  This gap can be used for various
-metadata.  The start of data is known as the
+Arrays with 1.x and IMSM metadata can leave a gap between the start
+of the device and the start of array data.  This gap can be used for
+various metadata.  The start of data is known as the
 .IR data\-offset .
 Normally an appropriate data offset is computed automatically.
 However it can be useful to set it explicitly such as when re-creating
@@ -830,6 +830,12 @@ an array which was originally created using a different version of
 .I mdadm
 which computed a different offset.
 
+For IMSM arrays
+.B \-\-data\-offset
+is valid only when creating first volume inside a container.  Default
+.B \-\-data\-offset
+value for such volume is 1 MiB.
+
 Setting the offset explicitly over-rides the default.  The value given
 is in Kilobytes unless a suffix of 'K', 'M' or 'G' is used to explicitly
 indicate Kilobytes, Megabytes or Gigabytes respectively.
diff --git a/mdadm.c b/mdadm.c
index 1fb80860..7fdad606 100644
--- a/mdadm.c
+++ b/mdadm.c
@@ -384,21 +384,27 @@ int main(int argc, char *argv[])
 		case O(CREATE,ChunkSize):
 		case O(BUILD,'c'): /* chunk or rounding */
 		case O(BUILD,ChunkSize): /* chunk or rounding */
+		{
+			unsigned long long tmp_chunk;
+
 			if (s.chunk) {
 				pr_err("chunk/rounding may only be specified once. Second value is %s.\n", optarg);
 				exit(2);
 			}
-			s.chunk = parse_size(optarg);
-			if (s.chunk == INVALID_SECTORS ||
-			    s.chunk < 8 || (s.chunk&1)) {
+			tmp_chunk = parse_size(optarg);
+			if (tmp_chunk == INVALID_SECTORS ||
+			    tmp_chunk > INT_MAX ||
+			    tmp_chunk < 8 ||
+			    (tmp_chunk&1)) {
 				pr_err("invalid chunk/rounding value: %s\n",
 					optarg);
 				exit(2);
 			}
+			s.chunk = (int) tmp_chunk;
 			/* Convert sectors to K */
 			s.chunk /= 2;
 			continue;
-
+		}
 		case O(INCREMENTAL, 'e'):
 		case O(CREATE,'e'):
 		case O(ASSEMBLE,'e'):
@@ -1181,17 +1187,19 @@ int main(int argc, char *argv[])
 		case O(GROW,BitmapChunk):
 		case O(BUILD,BitmapChunk):
 		case O(CREATE,BitmapChunk): /* bitmap chunksize */
-			s.bitmap_chunk = parse_size(optarg);
-			if (s.bitmap_chunk == 0 ||
-			    s.bitmap_chunk == INVALID_SECTORS ||
-			    s.bitmap_chunk & (s.bitmap_chunk - 1)) {
+		{
+			unsigned long long tmp_chunk = parse_size(optarg);
+
+			if (tmp_chunk == INVALID_SECTORS ||
+			    tmp_chunk > INT_MAX / 512 ||
+			    tmp_chunk == 0 || tmp_chunk & (tmp_chunk - 1)) {
 				pr_err("invalid bitmap chunksize: %s\n",
 				       optarg);
 				exit(2);
 			}
-			s.bitmap_chunk = s.bitmap_chunk * 512;
+			s.bitmap_chunk = (int) (tmp_chunk * 512);
 			continue;
-
+		}
 		case O(GROW, WriteBehind):
 		case O(BUILD, WriteBehind):
 		case O(CREATE, WriteBehind): /* write-behind mode */
diff --git a/mdadm.h b/mdadm.h
index 43b07d57..99719c8d 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -45,6 +45,7 @@ extern __off64_t lseek64 __P ((int __fd, __off64_t __offset, int __whence));
 #include	<errno.h>
 #include	<string.h>
 #include	<syslog.h>
+#include	<limits.h>
 /* Newer glibc requires sys/sysmacros.h directly for makedev() */
 #include	<sys/sysmacros.h>
 #ifdef __dietlibc__
@@ -598,7 +599,7 @@ struct mddev_dev {
 	enum flag_mode writemostly;
 	enum flag_mode failfast;
 	int used;		/* set when used */
-	long long data_offset;
+	unsigned long long data_offset;
 	struct mddev_dev *next;
 };
 
@@ -1824,6 +1825,6 @@ char *xstrdup(const char *str);
 /* We want to use unsigned numbers for sector counts, but need
  * a value for 'invalid'.  Use '1'.
  */
-#define INVALID_SECTORS 1
+#define INVALID_SECTORS ULLONG_MAX
 /* And another special number needed for --data_offset=variable */
-#define VARIABLE_OFFSET 3
+#define VARIABLE_OFFSET (ULLONG_MAX-1)
diff --git a/super-intel.c b/super-intel.c
index d7e8a65f..ba80628c 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -292,6 +292,10 @@ static char *map_state_str[] = { "normal", "uninitialized", "degraded", "failed"
 
 #define PPL_ENTRY_SPACE (128 * 1024) /* Size of single PPL, without the header */
 
+#define DEFAULT_VOLUME_DATA_OFFSET (1024*1024) /* First volume created with
+						* default 1M offset
+						*/
+
 struct migr_record {
 	__u32 rec_status;	    /* Status used to determine how to restart
 				     * migration in case it aborts
@@ -1691,6 +1695,11 @@ static void print_imsm_disk(struct imsm_disk *disk,
 	       human_size(sz * 512));
 }
 
+unsigned long long convert_to_4k_data_offset(unsigned long long data_offset)
+{
+	return ROUND_UP(data_offset, IMSM_4K_DIV) / IMSM_4K_DIV;
+}
+
 void convert_to_4k_imsm_migr_rec(struct intel_super *super)
 {
 	struct migr_record *migr_rec = super->migr_rec;
@@ -5395,7 +5404,7 @@ static int check_name(struct intel_super *super, char *name, int quiet)
 static int init_super_imsm_volume(struct supertype *st, mdu_array_info_t *info,
 				  struct shape *s, char *name,
 				  char *homehost, int *uuid,
-				  long long data_offset)
+				  unsigned long long data_offset)
 {
 	/* We are creating a volume inside a pre-existing container.
 	 * so st->sb is already set.
@@ -5485,6 +5494,25 @@ static int init_super_imsm_volume(struct supertype *st, mdu_array_info_t *info,
 		}
 	}
 
+	if (data_offset == VARIABLE_OFFSET) {
+		pr_err("data-offset=variable is not supported by imsm.\n");
+		return 0;
+	}
+
+	if (data_offset != INVALID_SECTORS) {
+		if (super->current_vol > 0) {
+			pr_err("data-offset is only supported for first imsm volume.\n");
+			return 0;
+		}
+		if (sector_size == 4096)
+			super->create_offset = convert_to_4k_data_offset(data_offset);
+		else
+			super->create_offset = data_offset;
+	} else if (data_offset == INVALID_SECTORS && super->current_vol == 0) {
+		// set default data offset for first volume
+		super->create_offset = DEFAULT_VOLUME_DATA_OFFSET / super->sector_size;
+	}
+
 	if (!check_name(super, name, 0))
 		return 0;
 	dv = xmalloc(sizeof(*dv));
@@ -5597,11 +5625,6 @@ static int init_super_imsm(struct supertype *st, mdu_array_info_t *info,
 	size_t mpb_size;
 	char *version;
 
-	if (data_offset != INVALID_SECTORS) {
-		pr_err("data-offset not supported by imsm\n");
-		return 0;
-	}
-
 	if (st->sb)
 		return init_super_imsm_volume(st, info, s, name, homehost, uuid,
 					      data_offset);
@@ -7330,7 +7353,9 @@ static int validate_geometry_imsm_volume(struct supertype *st, int level,
 }
 
 static int imsm_get_free_size(struct supertype *st, int raiddisks,
-			 unsigned long long size, int chunk,
+			 unsigned long long size,
+			 unsigned long long data_offset,
+			 int chunk,
 			 unsigned long long *freesize)
 {
 	struct intel_super *super = st->sb;
@@ -7341,6 +7366,7 @@ static int imsm_get_free_size(struct supertype *st, int raiddisks,
 	struct extent *e;
 	unsigned long long maxsize;
 	unsigned long long minsize;
+	unsigned long long offset_size;
 	int cnt;
 	int used;
 
@@ -7385,6 +7411,27 @@ static int imsm_get_free_size(struct supertype *st, int raiddisks,
 		return 0; /* No enough free spaces large enough */
 	}
 
+	if (mpb->num_raid_devs == 0) {
+		if (super->sector_size == 4096) {
+			data_offset = convert_to_4k_data_offset(data_offset);
+			if (data_offset != INVALID_SECTORS)
+				offset_size = (data_offset*(super->sector_size/1024));
+			else
+				offset_size = DEFAULT_VOLUME_DATA_OFFSET;
+		} else {
+			offset_size = data_offset != INVALID_SECTORS ?
+					(data_offset*2) : DEFAULT_VOLUME_DATA_OFFSET;
+		}
+
+		offset_size *= raiddisks;
+
+		if (offset_size > maxsize) {
+			pr_err("attempting to create first volume with too large data offset. Aborting...\n");
+			return 0;
+		}
+		maxsize -= offset_size;
+	}
+
 	if (size == 0) {
 		size = maxsize;
 		if (chunk) {
@@ -7393,6 +7440,12 @@ static int imsm_get_free_size(struct supertype *st, int raiddisks,
 		}
 		maxsize = size;
 	}
+
+	if (size > maxsize) {
+		pr_err("attempting to create first volume witch exceeds available space. Aborting...\n");
+		return 0;
+	}
+
 	if (!check_env("IMSM_NO_PLATFORM") &&
 	    mpb->num_raid_devs > 0 && size && size != maxsize) {
 		pr_err("attempting to create a second volume with size less then remaining space. Aborting...\n");
@@ -7411,7 +7464,9 @@ static int imsm_get_free_size(struct supertype *st, int raiddisks,
 }
 
 static int reserve_space(struct supertype *st, int raiddisks,
-			 unsigned long long size, int chunk,
+			 unsigned long long size,
+			 unsigned long long data_offset,
+			 int chunk,
 			 unsigned long long *freesize)
 {
 	struct intel_super *super = st->sb;
@@ -7419,7 +7474,8 @@ static int reserve_space(struct supertype *st, int raiddisks,
 	int cnt;
 	int rv = 0;
 
-	rv = imsm_get_free_size(st, raiddisks, size, chunk, freesize);
+	rv = imsm_get_free_size(st, raiddisks, size, data_offset,
+				chunk, freesize);
 	if (rv) {
 		cnt = 0;
 		for (dl = super->disks; dl; dl = dl->next)
@@ -7491,9 +7547,11 @@ static int validate_geometry_imsm(struct supertype *st, int level, int layout,
 					return 0;
 				}
 			}
+
 			if (freesize)
 				return reserve_space(st, raiddisks, size,
-						     *chunk, freesize);
+							data_offset, *chunk,
+							freesize);
 		}
 		return 1;
 	}
@@ -11566,7 +11624,7 @@ enum imsm_reshape_type imsm_analyze_change(struct supertype *st,
 		/* check the maximum available size
 		 */
 		rv =  imsm_get_free_size(st, dev->vol.map->num_members,
-					 0, chunk, &free_size);
+					 0, 0, chunk, &free_size);
 		if (rv == 0)
 			/* Cannot find maximum available space
 			 */
diff --git a/util.c b/util.c
index c26cf5f3..5e4fd5d7 100644
--- a/util.c
+++ b/util.c
@@ -396,7 +396,7 @@ unsigned long long parse_size(char *size)
 	 */
 	char *c;
 	long long s = strtoll(size, &c, 10);
-	if (s > 0) {
+	if (s >= 0) {
 		switch (*c) {
 		case 'K':
 			c++;
-- 
2.16.4

