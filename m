Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031EF8058B
	for <lists+linux-raid@lfdr.de>; Sat,  3 Aug 2019 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbfHCJZe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 3 Aug 2019 05:25:34 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:21284 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388126AbfHCJZd (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 3 Aug 2019 05:25:33 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 1C984A2213;
        Sat,  3 Aug 2019 11:25:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id yZ-fnTDszare; Sat,  3 Aug 2019 11:25:21 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     neilb@suse.de, Jes.Sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [mdadm PATCH] Add missing include file sys/sysmacros.h
Date:   Sat,  3 Aug 2019 11:25:01 +0200
Message-Id: <20190803092501.5429-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This include file is needed for makedev(), major() and minor() which are
used in these functions. In musl 1.1.23 sys/sysmacros.h is not included
indirectly any more and mdadm fails to compile.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 Assemble.c       | 1 +
 Build.c          | 1 +
 Create.c         | 1 +
 Detail.c         | 1 +
 Grow.c           | 1 +
 Incremental.c    | 1 +
 Manage.c         | 1 +
 Monitor.c        | 1 +
 Query.c          | 1 +
 lib.c            | 1 +
 mapfile.c        | 1 +
 mdadm.c          | 1 +
 mdopen.c         | 1 +
 platform-intel.c | 1 +
 policy.c         | 1 +
 super-ddf.c      | 1 +
 super-intel.c    | 1 +
 sysfs.c          | 1 +
 util.c           | 1 +
 19 files changed, 19 insertions(+)

diff --git a/Assemble.c b/Assemble.c
index b2e6914..f610636 100644
--- a/Assemble.c
+++ b/Assemble.c
@@ -24,6 +24,7 @@
 
 #include	"mdadm.h"
 #include	<ctype.h>
+#include	<sys/sysmacros.h>
 
 static int name_matches(char *found, char *required, char *homehost, int require_homehost)
 {
diff --git a/Build.c b/Build.c
index 962c2e3..1c85d34 100644
--- a/Build.c
+++ b/Build.c
@@ -23,6 +23,7 @@
  */
 
 #include "mdadm.h"
+#include <sys/sysmacros.h>
 
 int Build(char *mddev, struct mddev_dev *devlist,
 	  struct shape *s, struct context *c)
diff --git a/Create.c b/Create.c
index 292f92a..268b862 100644
--- a/Create.c
+++ b/Create.c
@@ -26,6 +26,7 @@
 #include	"md_u.h"
 #include	"md_p.h"
 #include	<ctype.h>
+#include	<sys/sysmacros.h>
 
 static int round_size_and_verify(unsigned long long *size, int chunk)
 {
diff --git a/Detail.c b/Detail.c
index 20ea03a..48a8b52 100644
--- a/Detail.c
+++ b/Detail.c
@@ -27,6 +27,7 @@
 #include	"md_u.h"
 #include	<ctype.h>
 #include	<dirent.h>
+#include	<sys/sysmacros.h>
 
 static int cmpstringp(const void *p1, const void *p2)
 {
diff --git a/Grow.c b/Grow.c
index 764374f..5ec355a 100644
--- a/Grow.c
+++ b/Grow.c
@@ -27,6 +27,7 @@
 #include	<stddef.h>
 #include	<stdint.h>
 #include	<signal.h>
+#include	<sys/sysmacros.h>
 #include	<sys/wait.h>
 
 #if ! defined(__BIG_ENDIAN) && ! defined(__LITTLE_ENDIAN)
diff --git a/Incremental.c b/Incremental.c
index 98dbcd9..76924d8 100644
--- a/Incremental.c
+++ b/Incremental.c
@@ -29,6 +29,7 @@
  */
 
 #include	"mdadm.h"
+#include	<sys/sysmacros.h>
 #include	<sys/wait.h>
 #include	<dirent.h>
 #include	<ctype.h>
diff --git a/Manage.c b/Manage.c
index 21536f5..0806c3c 100644
--- a/Manage.c
+++ b/Manage.c
@@ -26,6 +26,7 @@
 #include "md_u.h"
 #include "md_p.h"
 #include <ctype.h>
+#include <sys/sysmacros.h>
 
 int Manage_ro(char *devname, int fd, int readonly)
 {
diff --git a/Monitor.c b/Monitor.c
index 036103f..4417d9a 100644
--- a/Monitor.c
+++ b/Monitor.c
@@ -25,6 +25,7 @@
 #include	"mdadm.h"
 #include	"md_p.h"
 #include	"md_u.h"
+#include	<sys/sysmacros.h>
 #include	<sys/wait.h>
 #include	<signal.h>
 #include	<limits.h>
diff --git a/Query.c b/Query.c
index 23fbf8a..6b94d74 100644
--- a/Query.c
+++ b/Query.c
@@ -25,6 +25,7 @@
 #include	"mdadm.h"
 #include	"md_p.h"
 #include	"md_u.h"
+#include	<sys/sysmacros.h>
 
 int Query(char *dev)
 {
diff --git a/lib.c b/lib.c
index 60890b9..454a561 100644
--- a/lib.c
+++ b/lib.c
@@ -25,6 +25,7 @@
 #include	"mdadm.h"
 #include	"dlink.h"
 #include	<ctype.h>
+#include	<sys/sysmacros.h>
 
 /* This fill contains various 'library' style function.  They
  * have no dependency on anything outside this file.
diff --git a/mapfile.c b/mapfile.c
index 8d7acb3..aa11322 100644
--- a/mapfile.c
+++ b/mapfile.c
@@ -44,6 +44,7 @@
  */
 #include	"mdadm.h"
 #include	<sys/file.h>
+#include	<sys/sysmacros.h>
 #include	<ctype.h>
 
 #define MAP_READ 0
diff --git a/mdadm.c b/mdadm.c
index 25a1abd..7432c69 100644
--- a/mdadm.c
+++ b/mdadm.c
@@ -28,6 +28,7 @@
 #include "mdadm.h"
 #include "md_p.h"
 #include <ctype.h>
+#include <sys/sysmacros.h>
 
 static int scan_assemble(struct supertype *ss,
 			 struct context *c,
diff --git a/mdopen.c b/mdopen.c
index 98c54e4..298e475 100644
--- a/mdopen.c
+++ b/mdopen.c
@@ -25,6 +25,7 @@
 #include "mdadm.h"
 #include "md_p.h"
 #include <ctype.h>
+#include <sys/sysmacros.h>
 
 void make_parts(char *dev, int cnt)
 {
diff --git a/platform-intel.c b/platform-intel.c
index 04bffc5..ebfca4c 100644
--- a/platform-intel.c
+++ b/platform-intel.c
@@ -28,6 +28,7 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <limits.h>
 
 static int devpath_to_ll(const char *dev_path, const char *entry,
diff --git a/policy.c b/policy.c
index 3c53bd3..f1887dc 100644
--- a/policy.c
+++ b/policy.c
@@ -26,6 +26,7 @@
 #include <dirent.h>
 #include <fnmatch.h>
 #include <ctype.h>
+#include <sys/sysmacros.h>
 #include "dlink.h"
 /*
  * Policy module for mdadm.
diff --git a/super-ddf.c b/super-ddf.c
index c095e8a..357179b 100644
--- a/super-ddf.c
+++ b/super-ddf.c
@@ -31,6 +31,7 @@
 #include "sha1.h"
 #include <values.h>
 #include <stddef.h>
+#include <sys/sysmacros.h>
 
 /* a non-official T10 name for creation GUIDs */
 static char T10[] = "Linux-MD";
diff --git a/super-intel.c b/super-intel.c
index d7e8a65..207c734 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -24,6 +24,7 @@
 #include "platform-intel.h"
 #include <values.h>
 #include <scsi/sg.h>
+#include <sys/sysmacros.h>
 #include <ctype.h>
 #include <dirent.h>
 
diff --git a/sysfs.c b/sysfs.c
index c313781..b47d6a9 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -26,6 +26,7 @@
 #include	"mdadm.h"
 #include	<dirent.h>
 #include	<ctype.h>
+#include	<sys/sysmacros.h>
 #include	"dlink.h"
 
 #define MAX_SYSFS_PATH_LEN	120
diff --git a/util.c b/util.c
index c26cf5f..3b1a558 100644
--- a/util.c
+++ b/util.c
@@ -29,6 +29,7 @@
 #include	<sys/wait.h>
 #include	<sys/un.h>
 #include	<sys/resource.h>
+#include	<sys/sysmacros.h>
 #include	<sys/vfs.h>
 #include	<sys/mman.h>
 #include	<linux/magic.h>
-- 
2.20.1

