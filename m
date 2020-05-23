Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE55F1DF735
	for <lists+linux-raid@lfdr.de>; Sat, 23 May 2020 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbgEWMZW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 23 May 2020 08:25:22 -0400
Received: from troy.meta-dynamic.com ([204.11.35.233]:38154 "EHLO
        mail.meta-dynamic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgEWMZV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 23 May 2020 08:25:21 -0400
Received: from minderbinder.meta-dynamic.com (mandelbrot [192.168.137.138])
        by mail.meta-dynamic.com (Postfix) with ESMTPS id C0C9653E96;
        Sat, 23 May 2020 08:25:20 -0400 (EDT)
Received: by minderbinder.meta-dynamic.com (Postfix, from userid 1000)
        id 5E87A1980272; Sat, 23 May 2020 08:25:20 -0400 (EDT)
From:   dfavro@meta-dynamic.com
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org, David Favro <dfavro@meta-dynamic.com>
Subject: [PATCH] Detect too-small device: error rather than underflow/crash
Date:   Sat, 23 May 2020 08:24:59 -0400
Message-Id: <20200523122459.1151100-2-dfavro@meta-dynamic.com>
X-Mailer: git-send-email 2.26.2.593.gb9946226
In-Reply-To: <20200523122459.1151100-1-dfavro@meta-dynamic.com>
References: <20200523122459.1151100-1-dfavro@meta-dynamic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: David Favro <dfavro@meta-dynamic.com>

For 1.x metadata, when the user requested creation of an array on
component devices that were too small even to hold the superblock,
an undetected integer wraparound (underflow) resulted in an enormous
computed size which resulted in various follow-on errors such as
floating-point exception.

This patch detects this condition, prints a reasonable diagnostic
message, and refuses to continue.

Signed-off-by: David Favro <dfavro@meta-dynamic.com>
---
 super1.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/super1.c b/super1.c
index e0d80be1..76648835 100644
--- a/super1.c
+++ b/super1.c
@@ -2753,6 +2753,7 @@ static int validate_geometry1(struct supertype *st, int level,
 	unsigned long long ldsize, devsize;
 	int bmspace;
 	unsigned long long headroom;
+	unsigned long long overhead;
 	int fd;
 
 	if (level == LEVEL_CONTAINER) {
@@ -2785,10 +2786,6 @@ static int validate_geometry1(struct supertype *st, int level,
 	close(fd);
 
 	devsize = ldsize >> 9;
-	if (devsize < 24) {
-		*freesize = 0;
-		return 0;
-	}
 
 	/* creating:  allow suitable space for bitmap or PPL */
 	if (consistency_policy == CONSISTENCY_POLICY_PPL)
@@ -2829,15 +2826,27 @@ static int validate_geometry1(struct supertype *st, int level,
 	case 0: /* metadata at end.  Round down and subtract space to reserve */
 		devsize = (devsize & ~(4ULL*2-1));
 		/* space for metadata, bblog, bitmap/ppl */
-		devsize -= 8*2 + 8 + bmspace;
+		overhead = 8*2 + 8 + bmspace;
+		if (devsize < overhead) /* detect underflow */
+			goto dev_too_small_err;
+		devsize -= overhead;
 		break;
 	case 1:
 	case 2:
+		if (devsize < data_offset) /* detect underflow */
+			goto dev_too_small_err;
 		devsize -= data_offset;
 		break;
 	}
 	*freesize = devsize;
 	return 1;
+
+/* Error condition, device cannot even hold the overhead. */
+dev_too_small_err:
+	fprintf(stderr, "device %s is too small (%lluK) for "
+			"required metadata!\n", subdev, devsize>>1);
+	*freesize = 0;
+	return 0;
 }
 
 void *super1_make_v0(struct supertype *st, struct mdinfo *info, mdp_super_t *sb0)
-- 
2.26.2.593.gb9946226

