Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8E2242ED
	for <lists+linux-raid@lfdr.de>; Fri, 17 Jul 2020 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgGQSKR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Jul 2020 14:10:17 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:32767 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgGQSKQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 Jul 2020 14:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595009413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=GYee9gF1nWefC9S3BLtphQ17bbzINBPDBs32rhvNU8M=;
        b=LBiVX+qw4tMkVBGm5p1//strmxCtz0/6bVRw2aJEN13M533A3FXFrEtuhK9VXqUNDHgLo3
        gy/uy7Gm7pj6ZZLOBM71wCHzS67yKmSOC6N5JXeVsI8xc1uDC5/wdqBAXgZwV1fXRTEEDq
        aWb3ger/GQedD4ktaMPZ5L3K5+O9ZRU=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-_-X7wWw9PgmSel-I8E40CA-1; Fri, 17 Jul 2020 20:10:12 +0200
X-MC-Unique: _-X7wWw9PgmSel-I8E40CA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cuxi7Pv2NcJnt9/SAlPW4Oy5MW6wnVSLMHcnKyXnEdHcZVXoXzRjfMoatSxOwobLTZ+RU/y+ej/jjWkdkwqov69R4xer40+20fGr2/W6IacQhaZ+sf32o2s+tprOHqWLa9kEXYw00KvaiTbz0q2lkHB7xn0gKHUK5yb87sNMv+1ggWxQ6f86eNnVBMHEW6gX/wDESB1gNL6m9/kuGKJoYI9M3KUZKP9VQTkPl8uYJGueGU7rtFL1FzTJa8KCr1Bdc0ca1Yw+zp9OMhc3iy04fAc8nqnjT0GzM/WcGrBK57k7fCQgsB9q+n7A0qtuXAQFbsVNwsTRjRByONBjY4D/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYee9gF1nWefC9S3BLtphQ17bbzINBPDBs32rhvNU8M=;
 b=AwXrhp8UtAnTsc8c+B+kUlbOc06STPCotOxjoElAjw0qUg0ADJj3ZqbsDXD5aQ6EP3qusy1aS1eQ3V56+vXtKPei1eaSJUtyjhvyOm0tgwKo2CjhdaX1bWZgQMdHZ22DD+TicR1SoaOdu/Gu3ONj7rMNX7CpR7iwQvRZlO+mNzdf+GBg9P1tMvrsShyE1LKcqm8ZC7EJnvJtjbk3XBfh0imRpPzBYwlxfFYh0BbtRLYhsRflbiHba6LdfCUYIFRwLLm8sm/VSNIDrUj9MCnWujDKvGnT09aoTE3UnoZ7Io1CsTPbVDEYM8lmdI6WaaQRkpFxlh2WnQv6Xk1E7jC/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB6PR0401MB2437.eurprd04.prod.outlook.com (2603:10a6:4:35::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Fri, 17 Jul 2020 18:10:11 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 18:10:11 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com,
        jes@trained-monkey.org
Subject: [PATCH] mdadm/Detail: show correct state for cluster-md array
Date:   Sat, 18 Jul 2020 02:09:58 +0800
Message-Id: <1595009398-5069-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK2PR04CA0081.apcprd04.prod.outlook.com (2603:1096:202:15::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 18:10:09 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 185d8420-90f2-4cc3-6361-08d82a7ca503
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2437:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB24371A8CD0EEFA33A03E454B977C0@DB6PR0401MB2437.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AifvO3s9ETqnsQF5+Ie8Y3lhoTeIHNPIq2bXGV4KTAZBEXRncmROy6qWySgjKB9g8umUZ0XhcCqPjcE7W5B5R0V0m6CiY5eBFxgq4p9gbi7bufRLQyfMcJiOlDYret9ar4nEVM1lIljckLwmYwZk0ah60X6SQ0VvtzuEmDPHHxarLCnULlFllgdrCtIACuqCOJtzIwR3DlnBVjWHv6wPPczT+weXboumSA9axS2ghZNOJLGVlwdoskYPP+vtndNUZTH87Y2EG7KUjWy6fBM/Ndtd003ZbLWsM3tYTlo14nZ75vIeZYA9CON6rbwhHeZMhWAgZgXs/Qg5Pc88sshgQoMIP+OuHg+6sFT3/vN1ieke4baQWKb/AcmFgQ19xKNO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(136003)(39860400002)(366004)(6506007)(8936002)(186003)(6512007)(26005)(478600001)(316002)(66556008)(66476007)(66946007)(36756003)(4326008)(2616005)(52116002)(2906002)(6916009)(83380400001)(86362001)(5660300002)(6666004)(956004)(6486002)(8676002)(16526019)(8886007)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DeSKEAFO0rCz3lilawk6iUM9JVi3Dnutq8LIXKLO4SdsmfieSq8PSTBB14MBFpMCuByG+H50g+SKe75IzFTSuM/VtaFep93woI7uXXl1ag/gLvAiKDegyvir0Hu5BvQz/rlWCO6UzrHYWNUrWyPN87OYKYZ3BcPM4r72OJn5Hk4QmGKipaOnGd45LHR4tQXuj6U8t7dltd1UF4+J3H8kgKK7NMs9FNZNo9Z2NaNXCu8Qb+qsWuphO1gZE+5CPrylyZGlJXcTVm/A9tD20CFMjKPM5d5w0ClvPsU+XHzXwDyLeRxBjiwgQpYpBEJVKn5vcNH1WgwmvWnj40TIzuoY4PNpGIEdTzzQTgZL4kTVzuW28gfEA9eCisSfpzL2iBm35rW7L5zNufCff5l/WgAWKpuadQKcHGLhH1mZLalJCqB8VeTlcR6DlINlYBwjensWrAYcBPWfJZMux8D0ibVBVOv8z/mkYnGEC2kYx7+lehI=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185d8420-90f2-4cc3-6361-08d82a7ca503
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 18:10:10.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRuVoQmIjJtTBTvZxF9+OzPtS9XGr/24EEmdWwEkaGhEKCglZk+vCEF5R8mv5VivyzbxK6fod2iIQowPhBcxUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2437
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

After kernel md module commit 480523feae581, in md-cluster env,
mddev->in_sync always zero, it will make array.state never set
up MD_SB_CLEAN. it causes "mdadm -D /dev/mdX" show state 'active'
all the time.

bitmap.c: add a new API IsBitmapDirty() to support inquiry bitmap
dirty or clean.

Signed-off-by: Zhao Heming <heming.zhao@suse.com>
---
 Detail.c | 21 ++++++++++++++++++++-
 bitmap.c | 27 +++++++++++++++++++++++++++
 mdadm.h  |  1 +
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Detail.c b/Detail.c
index 24eeba0..fd580a3 100644
--- a/Detail.c
+++ b/Detail.c
@@ -495,8 +495,27 @@ int Detail(char *dev, struct context *c)
 							  sra->array_state);
 				else
 					arrayst = "clean";
-			} else
+			} else {
 				arrayst = "active";
+				if (array.state & (1<<MD_SB_CLUSTERED)) {
+					int dirty = 0;
+					for (d = 0; d < max_disks * 2; d++) {
+						char *dv;
+						mdu_disk_info_t disk = disks[d];
+
+						if (d >= array.raid_disks * 2 &&
+								disk.major == 0 && disk.minor == 0)
+							continue;
+						if ((d & 1) && disk.major == 0 && disk.minor == 0)
+							continue;
+						dv = map_dev_preferred(disk.major, disk.minor, 0, c->prefer);
+						if (dv != NULL)
+							if ((dirty = IsBitmapDirty(dv))) break;
+					}
+					if (dirty == 0)
+						arrayst = "clean";
+				}
+			}
 
 			printf("             State : %s%s%s%s%s%s%s \n",
 			       arrayst, st,
diff --git a/bitmap.c b/bitmap.c
index e38cb96..90ad932 100644
--- a/bitmap.c
+++ b/bitmap.c
@@ -368,6 +368,33 @@ free_info:
 	return rv;
 }
 
+int IsBitmapDirty(char *filename)
+{
+	/*
+	 * Read the bitmap file
+	 * return: 1(dirty), 0 (clean), -1(error)
+	 */
+
+	struct supertype *st = NULL;
+	bitmap_info_t *info;
+	int fd = -1, rv = -1;
+
+	fd = bitmap_file_open(filename, &st, 0);
+	if (fd < 0)
+		return rv;
+
+	info = bitmap_fd_read(fd, 0);
+	if (!info) {
+		goto out;
+	}
+	rv = info->dirty_bits ? 1 : 0;
+	free(info);
+out:
+	close(fd);
+	free(st);
+	return rv;
+}
+
 int CreateBitmap(char *filename, int force, char uuid[16],
 		 unsigned long chunksize, unsigned long daemon_sleep,
 		 unsigned long write_behind,
diff --git a/mdadm.h b/mdadm.h
index 399478b..ba8ba91 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -1447,6 +1447,7 @@ extern int CreateBitmap(char *filename, int force, char uuid[16],
 			unsigned long long array_size,
 			int major);
 extern int ExamineBitmap(char *filename, int brief, struct supertype *st);
+extern int IsBitmapDirty(char *filename);
 extern int Write_rules(char *rule_name);
 extern int bitmap_update_uuid(int fd, int *uuid, int swap);
 
-- 
2.25.0

