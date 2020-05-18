Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9911D8840
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgERTb0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 15:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgERTbZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 15:31:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B826C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 12:31:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j5so13250892wrq.2
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/3ZtGlD6oHxeDIolgKaawGsXHPHr8Aj/aiezI1KHIIc=;
        b=h0/G2KMDANMeatea9b1YAarWTHQxrQMBMAWhmdNZQ8QzMQBxmLFqo5W4bvdBpxdnu7
         hqw8Rmu+OAKLArZuNRD+ovtqQqXwrcYWI2McnyNVKAfacQITcBeOECOqlwZyozCYUJ/B
         EuT75nrjBkun3lVQvmzRjxt7381M/pkZOpWEJZYr8bDCWNhWAFzPi0d4Je0yes0rkmRc
         UzNV6qBFutAkC1QyU0mdNfRUBJirwod4qQft1m6toHlOucBsKi/k1j0gflpAya0m0V5W
         rvetRiQ3KJWADaHHYKlM/kp8CqaSJujXYMneeD0jTqx0MLo5W/j19smjZZHtzH1+MkJg
         MvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/3ZtGlD6oHxeDIolgKaawGsXHPHr8Aj/aiezI1KHIIc=;
        b=qA4LGkNM0TpPpbmQw/lRX2lNRulglnYjyEDDCEMYgm9XrMIAYyR6+PpwY70RFVD0dP
         gaXm3VTRt0HrxEQ6xMaZc57QQz47+OZWlY+lEs1QYAufi/dhxem3AzzuqjiymfsEWiIT
         JQs9foFrFkymtykoDSJkAozQqVvtOX9aVNAglgYGbfFRd3k5osLvu3RnzKCo52wM06iw
         5o4t371rs6Jk/ZKdhVnK3FeFSOSfa0fY6Jr0qIMM+3i2w3xzLs6skuAjfDdCm9ZKmh4g
         pI3v6pgGyygk1QsOPTGyIl6kPbhzP5DDzs28I8NCf7+zaeooNXG7FdrDrcL6PCEbsVjQ
         K2Nw==
X-Gm-Message-State: AOAM532eg0eDUjnZBXgJUaYqD83qwWN2nhqtYqzT227PfzdQJvpiGLmd
        dJLYjIy2etpsswNx1ImQXWIY3g==
X-Google-Smtp-Source: ABdhPJxe3PtoNx26t4mScXicUda7XzN7Pt2uedHbE2DzKpfhLl9EqC/CA55egjivdIzF3P9FjWmSxA==
X-Received: by 2002:a5d:6943:: with SMTP id r3mr20980911wrw.113.1589830283724;
        Mon, 18 May 2020 12:31:23 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:483d:6b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id u65sm736299wmg.8.2020.05.18.12.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:31:23 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 1/2] uuid.c: split uuid stuffs from util.c
Date:   Mon, 18 May 2020 21:31:07 +0200
Message-Id: <20200518193108.26102-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518193108.26102-1-guoqing.jiang@cloud.ionos.com>
References: <20200518193108.26102-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Currently, 'make raid6check' is build broken since commit b06815989
("mdadm: load default sysfs attributes after assemblation").

/usr/bin/ld: sysfs.o: in function `sysfsline':
sysfs.c:(.text+0x2707): undefined reference to `parse_uuid'
/usr/bin/ld: sysfs.c:(.text+0x271a): undefined reference to `uuid_zero'
/usr/bin/ld: sysfs.c:(.text+0x2721): undefined reference to `uuid_zero'

Apparently, the compile of mdadm or raid6check are coupled with uuid
functions inside util.c. However, we can't just add util.o to CHECK_OBJS
which raid6check is needed, because it caused other worse problems.

So, let's introduce a uuid.c file which is indenpended file to fix the
problem, all the contents are splitted from util.c.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Makefile |   6 +--
 util.c   |  87 ------------------------------------------
 uuid.c   | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 90 deletions(-)
 create mode 100644 uuid.c

diff --git a/Makefile b/Makefile
index a33319a..d13030c 100644
--- a/Makefile
+++ b/Makefile
@@ -139,7 +139,7 @@ else
 	ECHO=:
 endif
 
-OBJS =  mdadm.o config.o policy.o mdstat.o  ReadMe.o util.o maps.o lib.o \
+OBJS =  mdadm.o config.o policy.o mdstat.o  ReadMe.o uuid.o util.o maps.o lib.o \
 	Manage.o Assemble.o Build.o \
 	Create.o Detail.o Examine.o Grow.o Monitor.o dlink.o Kill.o Query.o \
 	Incremental.o Dump.o \
@@ -148,13 +148,13 @@ OBJS =  mdadm.o config.o policy.o mdstat.o  ReadMe.o util.o maps.o lib.o \
 	restripe.o sysfs.o sha1.o mapfile.o crc32.o sg_io.o msg.o xmalloc.o \
 	platform-intel.o probe_roms.o crc32c.o
 
-CHECK_OBJS = restripe.o sysfs.o maps.o lib.o xmalloc.o dlink.o
+CHECK_OBJS = restripe.o uuid.o sysfs.o maps.o lib.o xmalloc.o dlink.o
 
 SRCS =  $(patsubst %.o,%.c,$(OBJS))
 
 INCL = mdadm.h part.h bitmap.h
 
-MON_OBJS = mdmon.o monitor.o managemon.o util.o maps.o mdstat.o sysfs.o \
+MON_OBJS = mdmon.o monitor.o managemon.o uuid.o util.o maps.o mdstat.o sysfs.o \
 	policy.o lib.o \
 	Kill.o sg_io.o dlink.o ReadMe.o super-intel.o \
 	super-mbr.o super-gpt.o \
diff --git a/util.c b/util.c
index 07f9dc3..579dd42 100644
--- a/util.c
+++ b/util.c
@@ -306,43 +306,6 @@ int md_get_disk_info(int fd, struct mdu_disk_info_s *disk)
 	return ioctl(fd, GET_DISK_INFO, disk);
 }
 
-/*
- * Parse a 128 bit uuid in 4 integers
- * format is 32 hexx nibbles with options :.<space> separator
- * If not exactly 32 hex digits are found, return 0
- * else return 1
- */
-int parse_uuid(char *str, int uuid[4])
-{
-	int hit = 0; /* number of Hex digIT */
-	int i;
-	char c;
-	for (i = 0; i < 4; i++)
-		uuid[i] = 0;
-
-	while ((c = *str++) != 0) {
-		int n;
-		if (c >= '0' && c <= '9')
-			n = c-'0';
-		else if (c >= 'a' && c <= 'f')
-			n = 10 + c - 'a';
-		else if (c >= 'A' && c <= 'F')
-			n = 10 + c - 'A';
-		else if (strchr(":. -", c))
-			continue;
-		else return 0;
-
-		if (hit<32) {
-			uuid[hit/8] <<= 4;
-			uuid[hit/8] += n;
-		}
-		hit++;
-	}
-	if (hit == 32)
-		return 1;
-	return 0;
-}
-
 int get_linux_version()
 {
 	struct utsname name;
@@ -611,56 +574,6 @@ int enough(int level, int raid_disks, int layout, int clean, char *avail)
 	}
 }
 
-const int uuid_zero[4] = { 0, 0, 0, 0 };
-
-int same_uuid(int a[4], int b[4], int swapuuid)
-{
-	if (swapuuid) {
-		/* parse uuids are hostendian.
-		 * uuid's from some superblocks are big-ending
-		 * if there is a difference, we need to swap..
-		 */
-		unsigned char *ac = (unsigned char *)a;
-		unsigned char *bc = (unsigned char *)b;
-		int i;
-		for (i = 0; i < 16; i += 4) {
-			if (ac[i+0] != bc[i+3] ||
-			    ac[i+1] != bc[i+2] ||
-			    ac[i+2] != bc[i+1] ||
-			    ac[i+3] != bc[i+0])
-				return 0;
-		}
-		return 1;
-	} else {
-		if (a[0]==b[0] &&
-		    a[1]==b[1] &&
-		    a[2]==b[2] &&
-		    a[3]==b[3])
-			return 1;
-		return 0;
-	}
-}
-
-void copy_uuid(void *a, int b[4], int swapuuid)
-{
-	if (swapuuid) {
-		/* parse uuids are hostendian.
-		 * uuid's from some superblocks are big-ending
-		 * if there is a difference, we need to swap..
-		 */
-		unsigned char *ac = (unsigned char *)a;
-		unsigned char *bc = (unsigned char *)b;
-		int i;
-		for (i = 0; i < 16; i += 4) {
-			ac[i+0] = bc[i+3];
-			ac[i+1] = bc[i+2];
-			ac[i+2] = bc[i+1];
-			ac[i+3] = bc[i+0];
-		}
-	} else
-		memcpy(a, b, 16);
-}
-
 char *__fname_from_uuid(int id[4], int swap, char *buf, char sep)
 {
 	int i, j;
diff --git a/uuid.c b/uuid.c
new file mode 100644
index 0000000..94b5abd
--- /dev/null
+++ b/uuid.c
@@ -0,0 +1,112 @@
+/*
+ * mdadm - manage Linux "md" devices aka RAID arrays.
+ *
+ * Copyright (C) 2001-2013 Neil Brown <neilb@suse.de>
+ *
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *    Author: Neil Brown
+ *    Email: <neilb@suse.de>
+ */
+
+#include	<string.h>
+
+const int uuid_zero[4] = { 0, 0, 0, 0 };
+
+int same_uuid(int a[4], int b[4], int swapuuid)
+{
+	if (swapuuid) {
+		/* parse uuids are hostendian.
+		 * uuid's from some superblocks are big-ending
+		 * if there is a difference, we need to swap..
+		 */
+		unsigned char *ac = (unsigned char *)a;
+		unsigned char *bc = (unsigned char *)b;
+		int i;
+		for (i = 0; i < 16; i += 4) {
+			if (ac[i+0] != bc[i+3] ||
+			    ac[i+1] != bc[i+2] ||
+			    ac[i+2] != bc[i+1] ||
+			    ac[i+3] != bc[i+0])
+				return 0;
+		}
+		return 1;
+	} else {
+		if (a[0]==b[0] &&
+		    a[1]==b[1] &&
+		    a[2]==b[2] &&
+		    a[3]==b[3])
+			return 1;
+		return 0;
+	}
+}
+
+void copy_uuid(void *a, int b[4], int swapuuid)
+{
+	if (swapuuid) {
+		/* parse uuids are hostendian.
+		 * uuid's from some superblocks are big-ending
+		 * if there is a difference, we need to swap..
+		 */
+		unsigned char *ac = (unsigned char *)a;
+		unsigned char *bc = (unsigned char *)b;
+		int i;
+		for (i = 0; i < 16; i += 4) {
+			ac[i+0] = bc[i+3];
+			ac[i+1] = bc[i+2];
+			ac[i+2] = bc[i+1];
+			ac[i+3] = bc[i+0];
+		}
+	} else
+		memcpy(a, b, 16);
+}
+
+/*
+ * Parse a 128 bit uuid in 4 integers
+ * format is 32 hexx nibbles with options :.<space> separator
+ * If not exactly 32 hex digits are found, return 0
+ * else return 1
+ */
+int parse_uuid(char *str, int uuid[4])
+{
+	int hit = 0; /* number of Hex digIT */
+	int i;
+	char c;
+	for (i = 0; i < 4; i++)
+		uuid[i] = 0;
+
+	while ((c = *str++) != 0) {
+		int n;
+		if (c >= '0' && c <= '9')
+			n = c-'0';
+		else if (c >= 'a' && c <= 'f')
+			n = 10 + c - 'a';
+		else if (c >= 'A' && c <= 'F')
+			n = 10 + c - 'A';
+		else if (strchr(":. -", c))
+			continue;
+		else return 0;
+
+		if (hit<32) {
+			uuid[hit/8] <<= 4;
+			uuid[hit/8] += n;
+		}
+		hit++;
+	}
+	if (hit == 32)
+		return 1;
+	return 0;
+}
-- 
2.17.1

