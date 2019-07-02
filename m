Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965B85CE68
	for <lists+linux-raid@lfdr.de>; Tue,  2 Jul 2019 13:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGBL3x (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 2 Jul 2019 07:29:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:34494 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfGBL3x (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 2 Jul 2019 07:29:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 04:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,443,1557212400"; 
   d="scan'208";a="174564619"
Received: from rsobans-desk.igk.intel.com ([10.102.102.26])
  by orsmga002.jf.intel.com with ESMTP; 02 Jul 2019 04:29:51 -0700
From:   Roman Sobanski <roman.sobanski@intel.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Roman Sobanski <roman.sobanski@intel.com>
Subject: [PATCH] Enable probe_roms to scan more than 6 roms.
Date:   Tue,  2 Jul 2019 13:29:27 +0200
Message-Id: <20190702112927.22733-1-roman.sobanski@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

In some cases if more than 6 oroms exist, resource for particular
controller may not be found. Change method for storing
adapter_rom_resources from array to list.

Signed-off-by: Roman Sobanski <roman.sobanski@intel.com>
---
 probe_roms.c | 98 ++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 56 insertions(+), 42 deletions(-)

diff --git a/probe_roms.c b/probe_roms.c
index b0b08833..7ea04c7a 100644
--- a/probe_roms.c
+++ b/probe_roms.c
@@ -35,6 +35,9 @@ static const int rom_len = 0xf0000 - 0xc0000; /* option-rom memory region */
 static int _sigbus;
 static unsigned long rom_align;
 
+static void roms_deinit(void);
+static int roms_init(void);
+
 static void sigbus(int sig)
 {
 	_sigbus = 1;
@@ -75,6 +78,7 @@ void probe_roms_exit(void)
 		munmap(rom_mem, rom_len);
 		rom_mem = MAP_FAILED;
 	}
+	roms_deinit();
 }
 
 int probe_roms_init(unsigned long align)
@@ -91,6 +95,9 @@ int probe_roms_init(unsigned long align)
 	else
 		return -1;
 
+	if (roms_init())
+		return -1;
+
 	if (signal(SIGBUS, sigbus) == SIG_ERR)
 		rc = -1;
 	if (rc == 0) {
@@ -131,6 +138,7 @@ struct resource {
 	unsigned long end;
 	unsigned long data;
 	const char *name;
+	struct resource *next;
 };
 
 static struct resource system_rom_resource = {
@@ -147,37 +155,7 @@ static struct resource extension_rom_resource = {
 	.end	= 0xeffff,
 };
 
-static struct resource adapter_rom_resources[] = { {
-	.name	= "Adapter ROM",
-	.start	= 0xc8000,
-	.data   = 0,
-	.end	= 0,
-}, {
-	.name	= "Adapter ROM",
-	.start	= 0,
-	.data   = 0,
-	.end	= 0,
-}, {
-	.name	= "Adapter ROM",
-	.start	= 0,
-	.data   = 0,
-	.end	= 0,
-}, {
-	.name	= "Adapter ROM",
-	.start	= 0,
-	.data   = 0,
-	.end	= 0,
-}, {
-	.name	= "Adapter ROM",
-	.start	= 0,
-	.data   = 0,
-	.end	= 0,
-}, {
-	.name	= "Adapter ROM",
-	.start	= 0,
-	.data   = 0,
-	.end	= 0,
-} };
+static struct resource *adapter_rom_resources;
 
 static struct resource video_rom_resource = {
 	.name	= "Video ROM",
@@ -186,8 +164,35 @@ static struct resource video_rom_resource = {
 	.end	= 0xc7fff,
 };
 
+static int roms_init(void)
+{
+	adapter_rom_resources = malloc(sizeof(struct resource));
+	if (adapter_rom_resources == NULL)
+		return 1;
+	adapter_rom_resources->name = "Adapter ROM";
+	adapter_rom_resources->start = 0xc8000;
+	adapter_rom_resources->data = 0;
+	adapter_rom_resources->end = 0;
+	adapter_rom_resources->next = NULL;
+	return 0;
+}
+
+static void roms_deinit(void)
+{
+	struct resource *res;
+
+	res = adapter_rom_resources;
+	while (res) {
+		struct resource *tmp = res;
+
+		res = res->next;
+		free(tmp);
+	}
+}
+
 #define ROMSIGNATURE 0xaa55
 
+
 static int romsignature(const unsigned char *rom)
 {
 	const unsigned short * const ptr = (const unsigned short *)rom;
@@ -208,16 +213,14 @@ static int romchecksum(const unsigned char *rom, unsigned long length)
 int scan_adapter_roms(scan_fn fn)
 {
 	/* let scan_fn examing each of the adapter roms found by probe_roms */
-	unsigned int i;
+	struct resource *res = adapter_rom_resources;
 	int found;
 
 	if (rom_fd < 0)
 		return 0;
 
 	found = 0;
-	for (i = 0; i < ARRAY_SIZE(adapter_rom_resources); i++) {
-		struct resource *res = &adapter_rom_resources[i];
-
+	while (res) {
 		if (res->start) {
 			found = fn(isa_bus_to_virt(res->start),
 				   isa_bus_to_virt(res->end),
@@ -226,6 +229,7 @@ int scan_adapter_roms(scan_fn fn)
 				break;
 		} else
 			break;
+		res = res->next;
 	}
 
 	return found;
@@ -241,14 +245,14 @@ void probe_roms(void)
 	const void *rom;
 	unsigned long start, length, upper;
 	unsigned char c;
-	unsigned int i;
+	struct resource *res = adapter_rom_resources;
 	__u16 val=0;
 
 	if (rom_fd < 0)
 		return;
 
 	/* video rom */
-	upper = adapter_rom_resources[0].start;
+	upper = res->start;
 	for (start = video_rom_resource.start; start < upper; start += rom_align) {
 		rom = isa_bus_to_virt(start);
 		if (!romsignature(rom))
@@ -283,8 +287,9 @@ void probe_roms(void)
 			upper = extension_rom_resource.start;
 	}
 
+	struct resource *prev_res = res;
 	/* check for adapter roms on 2k boundaries */
-	for (i = 0; i < ARRAY_SIZE(adapter_rom_resources) && start < upper; start += rom_align) {
+	for (; start < upper; start += rom_align) {
 		rom = isa_bus_to_virt(start);
 		if (!romsignature(rom))
 			continue;
@@ -308,10 +313,19 @@ void probe_roms(void)
 		if (!length || start + length > upper || !romchecksum(rom, length))
 			continue;
 
-		adapter_rom_resources[i].start = start;
-		adapter_rom_resources[i].data = start + (unsigned long) val;
-		adapter_rom_resources[i].end = start + length - 1;
+		if (res == NULL) {
+			res = calloc(1, sizeof(struct resource));
+			if (res == NULL)
+				return;
+			prev_res->next = res;
+		}
+
+		res->start = start;
+		res->data = start + (unsigned long)val;
+		res->end = start + length - 1;
 
-		start = adapter_rom_resources[i++].end & ~(rom_align - 1);
+		start = res->end & ~(rom_align - 1);
+		prev_res = res;
+		res = res->next;
 	}
 }
-- 
2.16.4

