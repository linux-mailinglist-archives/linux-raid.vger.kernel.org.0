Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B481D4F65
	for <lists+linux-raid@lfdr.de>; Fri, 15 May 2020 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEONlH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 May 2020 09:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgEONlF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 15 May 2020 09:41:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF17C061A0C
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 06:41:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m12so2383791wmc.0
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nlU5yubYRI6sHckKZ9gT5PU6/Yq1sRyHRe8WG0thIV8=;
        b=fqh7qU4SnKsDljVVEXb5BOMeCtHz6XGL7dpXWtuRkFH61rXBRSRloAfRrJD9ZU8bYX
         n8+Z2+pyLY+iaxeaLv42ZKvGqTVYTaAwlQnnx/QnBrsqnLPfJ2PU60P++i1Vwl/Hh4XA
         h3XUF648W02AuFf1VB1gHdh6Y/jUCmr+utF4KsaZvmE+XEPnwKENGBYTHu5Rry1aec4c
         n8qwC6y9WmSeYEvsoWhDql2PMQbTQYVvLvHfsvt8Tv0+GWSA4Vj0ZKxKGN1J5FYKsDjv
         qioB70xanXdf0bpW3gC4HPtyX3JH/lweONFzrgbImGZ0qBuUEqXH/17R3CwzsecJITXc
         KSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nlU5yubYRI6sHckKZ9gT5PU6/Yq1sRyHRe8WG0thIV8=;
        b=jR0Y9ijCMNbkH5dO/kuQWpPf/JmXIP3NplWN0pytSU8ihu1cdDrK1NstFIid7U1ew9
         4KYD2DWRmmacn+p2KrRWTGuWvmiUpCrDGxiMP2YEh0jEjAbEBAHGHQjjaSbhe/O+zNfX
         zAWPild7ho2UfgM6FljviFc+me11QVsoSJTMDwKltq2znpqfX1AWlnw43AearQ4EgbZ2
         Kjnh31hkuereHOIWyBDfTU3XuIsZcVvDUXDQLdov6NNqp3+vBcEwdloD7/9KfOCycOVJ
         GVH56ctrwlhsmUK+TjOT1Aa/49N1g3pbC2Dy+rrhDO+Kwhn8T/qiiAvtN5WyIh/2afam
         LkSQ==
X-Gm-Message-State: AOAM533yZGkooTCO0pIaJmLmnPhMdVZovkR6wKUtkUG4iqsiJLR93WCE
        kBYXt6gp/+taFDkZpxx1zF/AaA==
X-Google-Smtp-Source: ABdhPJwDM7vyqBoG+/uYKKlz0ethScxlZhzjnmBar7h8ZKlPwfZ4fd406LScYxD8m10pMpzxYMj3pg==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr4099545wmh.75.1589550062917;
        Fri, 15 May 2020 06:41:02 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:48fe:dd00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id v8sm3918702wrs.45.2020.05.15.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 06:41:02 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Wolfgang Denk <wd@denx.de>
Subject: [PATCH 1/2] uuid.c: split uuid stuffs from util.c
Date:   Fri, 15 May 2020 15:40:25 +0200
Message-Id: <20200515134026.8084-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
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

Cc: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc: Wolfgang Denk <wd@denx.de>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Makefile |  6 ++--
 util.c   | 87 -----------------------------------------------------
 uuid.c   | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 90 deletions(-)
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
index 0000000..5b29e16
--- /dev/null
+++ b/uuid.c
@@ -0,0 +1,92 @@
+/*
+ * Splited from util.c, so uuid.c shares the same copyright of it,
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

