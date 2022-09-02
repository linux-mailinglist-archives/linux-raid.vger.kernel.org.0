Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92FF5AB358
	for <lists+linux-raid@lfdr.de>; Fri,  2 Sep 2022 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiIBOXR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 2 Sep 2022 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbiIBOW7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 2 Sep 2022 10:22:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958332A943
        for <linux-raid@vger.kernel.org>; Fri,  2 Sep 2022 06:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662126548; x=1693662548;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FcheTaAFQ081j97k+kf47a17YZuQH7u/I5GWbbRw008=;
  b=lKC9jBk7ZtuWMDhx4CKL6Xl7NMwrFEdp9QTRNTOvD98ifu3JRyslTg85
   uUE/Xdy6T7tz895jzSNj1w3WSiPGkv7+GZVlAqfVzwrRVP0y3Ef9QiEFT
   JMBdPPs4gQl/IyCmz0V8s0LTdpjip8jKkMpDVE0XdLQwdWycz+9foQqOG
   vj9Ad1SsWqU4r+NGq9DHGvjzudt+kmms2DfrYkC8gjy9iM+Ua6Xtz8hYM
   RzZhXTAqu78fI98kcFrUVt9ej3aTxsfQhlEryVXjbPxDY6LF9kuquW86b
   dD8NS6Tw0/3hvYpg7/5Is6vFmScg/j30PP+1IM5Oe9f3++XzkyNC/E0lF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="276384706"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="276384706"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 06:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="590074922"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.92.203])
  by orsmga006.jf.intel.com with ESMTP; 02 Sep 2022 06:49:06 -0700
From:   Kinga Tanska <kinga.tanska@intel.com>
To:     linux-raid@vger.kernel.org
Cc:     jes@trained-monkey.org, colyli@suse.de
Subject: [PATCH v4] mdadm: replace container level checking with inline
Date:   Fri,  2 Sep 2022 08:49:23 +0200
Message-Id: <20220902064923.19955-1-kinga.tanska@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

To unify all containers checks in code, is_container() function is
added and propagated.

Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
---
 Assemble.c    |  7 +++----
 Create.c      |  6 +++---
 Grow.c        |  6 +++---
 Incremental.c |  4 ++--
 mdadm.h       | 14 ++++++++++++++
 super-ddf.c   |  6 +++---
 super-intel.c |  4 ++--
 super0.c      |  2 +-
 super1.c      |  2 +-
 sysfs.c       |  2 +-
 10 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/Assemble.c b/Assemble.c
index 1dd82a8c..8b0af0c9 100644
--- a/Assemble.c
+++ b/Assemble.c
@@ -1120,7 +1120,7 @@ static int start_array(int mdfd,
 			       i/2, mddev);
 	}
 
-	if (content->array.level == LEVEL_CONTAINER) {
+	if (is_container(content->array.level)) {
 		sysfs_rules_apply(mddev, content);
 		if (c->verbose >= 0) {
 			pr_err("Container %s has been assembled with %d drive%s",
@@ -1549,8 +1549,7 @@ try_again:
 			 */
 			trustworthy = LOCAL;
 
-		if (name[0] == 0 &&
-		    content->array.level == LEVEL_CONTAINER) {
+		if (!name[0] && is_container(content->array.level)) {
 			name = content->text_version;
 			trustworthy = METADATA;
 		}
@@ -1809,7 +1808,7 @@ try_again:
 		}
 #endif
 	}
-	if (c->force && !clean && content->array.level != LEVEL_CONTAINER &&
+	if (c->force && !clean && !is_container(content->array.level) &&
 	    !enough(content->array.level, content->array.raid_disks,
 		    content->array.layout, clean, avail)) {
 		change += st->ss->update_super(st, content, "force-array",
diff --git a/Create.c b/Create.c
index e06ec2ae..953e7372 100644
--- a/Create.c
+++ b/Create.c
@@ -487,7 +487,7 @@ int Create(struct supertype *st, char *mddev,
 			    st->minor_version >= 1)
 				/* metadata at front */
 				warn |= check_partitions(fd, dname, 0, 0);
-			else if (s->level == 1 || s->level == LEVEL_CONTAINER ||
+			else if (s->level == 1 || is_container(s->level) ||
 				 (s->level == 0 && s->raiddisks == 1))
 				/* partitions could be meaningful */
 				warn |= check_partitions(fd, dname, freesize*2, s->size*2);
@@ -997,7 +997,7 @@ int Create(struct supertype *st, char *mddev,
 			 * again returns container info.
 			 */
 			st->ss->getinfo_super(st, &info_new, NULL);
-			if (st->ss->external && s->level != LEVEL_CONTAINER &&
+			if (st->ss->external && !is_container(s->level) &&
 			    !same_uuid(info_new.uuid, info.uuid, 0)) {
 				map_update(&map, fd2devnm(mdfd),
 					   info_new.text_version,
@@ -1040,7 +1040,7 @@ int Create(struct supertype *st, char *mddev,
 	map_unlock(&map);
 	free(infos);
 
-	if (s->level == LEVEL_CONTAINER) {
+	if (is_container(s->level)) {
 		/* No need to start.  But we should signal udev to
 		 * create links */
 		sysfs_uevent(&info, "change");
diff --git a/Grow.c b/Grow.c
index 0f07a894..e362403a 100644
--- a/Grow.c
+++ b/Grow.c
@@ -2175,7 +2175,7 @@ size_change_error:
 					devname, s->size);
 		}
 		changed = 1;
-	} else if (array.level != LEVEL_CONTAINER) {
+	} else if (!is_container(array.level)) {
 		s->size = get_component_size(fd)/2;
 		if (s->size == 0)
 			s->size = array.size;
@@ -2231,7 +2231,7 @@ size_change_error:
 	info.component_size = s->size*2;
 	info.new_level = s->level;
 	info.new_chunk = s->chunk * 1024;
-	if (info.array.level == LEVEL_CONTAINER) {
+	if (is_container(info.array.level)) {
 		info.delta_disks = UnSet;
 		info.array.raid_disks = s->raiddisks;
 	} else if (s->raiddisks)
@@ -2344,7 +2344,7 @@ size_change_error:
 				printf("layout for %s set to %d\n",
 				       devname, array.layout);
 		}
-	} else if (array.level == LEVEL_CONTAINER) {
+	} else if (is_container(array.level)) {
 		/* This change is to be applied to every array in the
 		 * container.  This is only needed when the metadata imposes
 		 * restraints of the various arrays in the container.
diff --git a/Incremental.c b/Incremental.c
index 4d0cd9d6..5a5f4c4c 100644
--- a/Incremental.c
+++ b/Incremental.c
@@ -244,7 +244,7 @@ int Incremental(struct mddev_dev *devlist, struct context *c,
 		c->autof = ci->autof;
 
 	name_to_use = info.name;
-	if (name_to_use[0] == 0 && info.array.level == LEVEL_CONTAINER) {
+	if (name_to_use[0] == 0 && is_container(info.array.level)) {
 		name_to_use = info.text_version;
 		trustworthy = METADATA;
 	}
@@ -472,7 +472,7 @@ int Incremental(struct mddev_dev *devlist, struct context *c,
 
 	/* 7/ Is there enough devices to possibly start the array? */
 	/* 7a/ if not, finish with success. */
-	if (info.array.level == LEVEL_CONTAINER) {
+	if (is_container(info.array.level)) {
 		char devnm[32];
 		/* Try to assemble within the container */
 		sysfs_uevent(sra, "change");
diff --git a/mdadm.h b/mdadm.h
index 941a5f38..3673494e 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -1924,3 +1924,17 @@ enum r0layout {
  * This is true for native and DDF, IMSM allows 16.
  */
 #define MD_NAME_MAX 32
+
+/**
+ * is_container() - check if @level is &LEVEL_CONTAINER
+ * @level: level value
+ *
+ * return:
+ * 1 if level is equal to &LEVEL_CONTAINER, 0 otherwise.
+ */
+static inline int is_container(const int level)
+{
+	if (level == LEVEL_CONTAINER)
+		return 1;
+	return 0;
+}
diff --git a/super-ddf.c b/super-ddf.c
index 949e7d15..9d1e3b94 100644
--- a/super-ddf.c
+++ b/super-ddf.c
@@ -3325,7 +3325,7 @@ validate_geometry_ddf_container(struct supertype *st,
 	int fd;
 	unsigned long long ldsize;
 
-	if (level != LEVEL_CONTAINER)
+	if (!is_container(level))
 		return 0;
 	if (!dev)
 		return 1;
@@ -3371,7 +3371,7 @@ static int validate_geometry_ddf(struct supertype *st,
 
 	if (level == LEVEL_NONE)
 		level = LEVEL_CONTAINER;
-	if (level == LEVEL_CONTAINER) {
+	if (is_container(level)) {
 		/* Must be a fresh device to add to a container */
 		return validate_geometry_ddf_container(st, level, raiddisks,
 						       data_offset, dev,
@@ -3488,7 +3488,7 @@ static int validate_geometry_ddf_bvd(struct supertype *st,
 	struct dl *dl;
 	unsigned long long maxsize;
 	/* ddf/bvd supports lots of things, but not containers */
-	if (level == LEVEL_CONTAINER) {
+	if (is_container(level)) {
 		if (verbose)
 			pr_err("DDF cannot create a container within an container\n");
 		return 0;
diff --git a/super-intel.c b/super-intel.c
index 4d82af3d..b0565610 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -6727,7 +6727,7 @@ static int validate_geometry_imsm_container(struct supertype *st, int level,
 	struct intel_super *super = NULL;
 	int rv = 0;
 
-	if (level != LEVEL_CONTAINER)
+	if (!is_container(level))
 		return 0;
 	if (!dev)
 		return 1;
@@ -7692,7 +7692,7 @@ static int validate_geometry_imsm(struct supertype *st, int level, int layout,
 	 * if given unused devices create a container
 	 * if given given devices in a container create a member volume
 	 */
-	if (level == LEVEL_CONTAINER)
+	if (is_container(level))
 		/* Must be a fresh device to add to a container */
 		return validate_geometry_imsm_container(st, level, raiddisks,
 							data_offset, dev,
diff --git a/super0.c b/super0.c
index 37f595ed..93876e2e 100644
--- a/super0.c
+++ b/super0.c
@@ -1273,7 +1273,7 @@ static int validate_geometry0(struct supertype *st, int level,
 	if (get_linux_version() < 3001000)
 		tbmax = 2;
 
-	if (level == LEVEL_CONTAINER) {
+	if (is_container(level)) {
 		if (verbose)
 			pr_err("0.90 metadata does not support containers\n");
 		return 0;
diff --git a/super1.c b/super1.c
index 58345e68..0b505a7e 100644
--- a/super1.c
+++ b/super1.c
@@ -2830,7 +2830,7 @@ static int validate_geometry1(struct supertype *st, int level,
 	unsigned long long overhead;
 	int fd;
 
-	if (level == LEVEL_CONTAINER) {
+	if (is_container(level)) {
 		if (verbose)
 			pr_err("1.x metadata does not support containers\n");
 		return 0;
diff --git a/sysfs.c b/sysfs.c
index 0d98a65f..ca1d888f 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -763,7 +763,7 @@ int sysfs_add_disk(struct mdinfo *sra, struct mdinfo *sd, int resume)
 
 	rv = sysfs_set_num(sra, sd, "offset", sd->data_offset);
 	rv |= sysfs_set_num(sra, sd, "size", (sd->component_size+1) / 2);
-	if (sra->array.level != LEVEL_CONTAINER) {
+	if (!is_container(sra->array.level)) {
 		if (sra->consistency_policy == CONSISTENCY_POLICY_PPL) {
 			rv |= sysfs_set_num(sra, sd, "ppl_sector", sd->ppl_sector);
 			rv |= sysfs_set_num(sra, sd, "ppl_size", sd->ppl_size);
-- 
2.26.2

