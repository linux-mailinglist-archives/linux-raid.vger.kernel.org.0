Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B231DA01D
	for <lists+linux-raid@lfdr.de>; Tue, 19 May 2020 20:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgESS7T (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 19 May 2020 14:59:19 -0400
Received: from troy.meta-dynamic.com ([204.11.35.233]:60446 "EHLO
        mail.meta-dynamic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgESS7T (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 19 May 2020 14:59:19 -0400
Received: from minderbinder.meta-dynamic.com (mandelbrot [192.168.137.138])
        by mail.meta-dynamic.com (Postfix) with ESMTPS id 76DE253E96;
        Tue, 19 May 2020 14:59:18 -0400 (EDT)
Received: by minderbinder.meta-dynamic.com (Postfix, from userid 1000)
        id ADB831980177; Tue, 19 May 2020 14:59:17 -0400 (EDT)
From:   dfavro@meta-dynamic.com
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org, David Favro <dfavro@meta-dynamic.com>
Subject: [PATCH] Detect too-small device: error rather than underflow/crash
Date:   Tue, 19 May 2020 14:58:12 -0400
Message-Id: <20200519185812.979553-2-dfavro@meta-dynamic.com>
X-Mailer: git-send-email 2.26.2.593.gb9946226
In-Reply-To: <20200519185812.979553-1-dfavro@meta-dynamic.com>
References: <8c7c42f8-2040-859b-d558-0b523f7092d8@trained-monkey.org>
 <20200519185812.979553-1-dfavro@meta-dynamic.com>
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
 super1.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/super1.c b/super1.c
index e0d80be1..1e12198d 100644
--- a/super1.c
+++ b/super1.c
@@ -2785,10 +2785,6 @@ static int validate_geometry1(struct supertype *st, int level,
 	close(fd);
 
 	devsize = ldsize >> 9;
-	if (devsize < 24) {
-		*freesize = 0;
-		return 0;
-	}
 
 	/* creating:  allow suitable space for bitmap or PPL */
 	if (consistency_policy == CONSISTENCY_POLICY_PPL)
@@ -2829,15 +2825,27 @@ static int validate_geometry1(struct supertype *st, int level,
 	case 0: /* metadata at end.  Round down and subtract space to reserve */
 		devsize = (devsize & ~(4ULL*2-1));
 		/* space for metadata, bblog, bitmap/ppl */
-		devsize -= 8*2 + 8 + bmspace;
+		const unsigned long long required = 8*2 + 8 + bmspace;
+		if ( devsize < required ) /* detect underflow */
+			goto dev_too_small_err;
+		devsize -= required;
 		break;
 	case 1:
 	case 2:
+		if ( devsize < data_offset ) /* detect underflow */
+			goto dev_too_small_err;
 		devsize -= data_offset;
 		break;
 	}
 	*freesize = devsize;
 	return 1;
+
+	/* Error condition, device cannot even hold the overhead. */
+	dev_too_small_err:
+		fprintf( stderr, "device %s is too small (%lluK) for "
+				"required metadata!\n", subdev, devsize>>1 );
+		*freesize = 0;
+		return 0;
 }
 
 void *super1_make_v0(struct supertype *st, struct mdinfo *info, mdp_super_t *sb0)
-- 
2.26.2.593.gb9946226

