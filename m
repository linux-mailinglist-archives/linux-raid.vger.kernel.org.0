Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1640223184C
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jul 2020 05:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgG2Dsv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 23:48:51 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:55039 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgG2Dsu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Jul 2020 23:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595994527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ohxbgXP3XPFgb1OO+4Lklhc2M5kawelSYSBhMjH+au4=;
        b=JfeghhKQmYiRHRJ9ICX0rLc/uA17V+EwEruz5a6c0kdQOA3mmj5QKspVbglWD64t6TX/AG
        kDJNriITps+SDCF2yUI2GTeH2++Mw8DQN8IsO0ylBVhBSdwwZiDHbno4dr80uyUa26JYf4
        hE9QWK6bd0jNUslBAeKgllN32lRxbO4=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-ToRXAtimPyKyZ1Jsn-_D4A-1; Wed, 29 Jul 2020 05:48:45 +0200
X-MC-Unique: ToRXAtimPyKyZ1Jsn-_D4A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma8OJuTAJ9n3p889nIKMofZGbcL1tjvNehoiDegXAiiVIweeUvekkKqiwNVJfTfrZx9VSq9qnosfoLKjdPMSCUMtMi737P/JS9ikDE7v+BqC8bNVdAFpgOiQ2iqOSRqBqBTNHEv1pLL6JP+Oc3yzfQNWw2cyhNmO0N2/rEv+fZE4O+1+eOVNy0iNWKxZ2j6mRkjiTA/TSeyntBG1cgO2zrB6d4MDAARTjb3EdklPQikl9n2S6JiIVDAmZIy5Y/9znJUpZ9IMhCInI8zRT/4tjsqnCfy7zEVLkr61S8W7y+5Nzb+0fYrJ52qppmJfRtNAo9ZkNt9ChSdqQ91TyqXZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohxbgXP3XPFgb1OO+4Lklhc2M5kawelSYSBhMjH+au4=;
 b=AzIBM9r8KwqpP2bQUkybRFK1Gm7h5dF94fKy1QcHixOoQ7otP0x0DrFlqrd15FIkx+GC95nYiDXfeQjzO+GnkGXFwgFJ/3/GQXTSiyxWpPTMxdrLtR5NQZ8hLgkY0K42Pq7x/tYDAkfU7bBE0i+6n3QgBhd4YE5ubql34vSTVcG+xufT34RPziOOtSszB/zpfHFIvSMTEgwHpUbJuzmCtbnaD0YJr7MYNfjPe1TLZnuomgaDCCzWrlwSxrpqE9HET69IhGrj0XYZX/OLZM5IgF4D4IcjG3Yf49JQuYj+G1xAiXt6BIXBfcggofnXrVib+/sHlWVmmci7FUFqLiC3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB5114.eurprd04.prod.outlook.com (2603:10a6:10:23::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Wed, 29 Jul 2020 03:48:43 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 03:48:43 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com,
        jes@trained-monkey.org
Subject: [PATCH v3] mdadm/Detail: show correct state for cluster-md array
Date:   Wed, 29 Jul 2020 11:48:30 +0800
Message-Id: <1595994510-16161-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0058.apcprd04.prod.outlook.com
 (2603:1096:202:14::26) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.132.131) by HK2PR04CA0058.apcprd04.prod.outlook.com (2603:1096:202:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Wed, 29 Jul 2020 03:48:41 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.132.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a26a9a44-1720-4bb2-15b1-08d8337249e8
X-MS-TrafficTypeDiagnostic: DB7PR04MB5114:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5114D16E5F528C1D7A6FFCFA97700@DB7PR04MB5114.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:44;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ItN4It7ANIicG+uL+Rgc2JBIjnZLbktddYE6AxUmeL4mG7nl5TRp4Tl5hjACEmRMltM+DTUapVYI18W6hBpH5ThAaKNe122WT4C2//bF5tJ8LxiauXAiEOyBxj2hFga6NMWbN25sck2H4+qnhUdJ/PEJFUFMU2th8qHu1cMWMlBtBs4aKfmoKzj67B9Kd6aBJqPz2B/aQKEoWPiOf87pkO3ztmpo7spw5QXtQBtlD0+lnnYQAG2D93zXr8qhz0DyreSwYTCaXlTHfbrEHlKI0gDk3Gn/VxKSw6n0tgBpVBfkU8S0Pri47uHL5+X9y8u+jUjDLRh5tn2lnZMc8sszN4T7yVTSVejKFUeesMIxFWpo9vKbSIIc+iIQRs1xTs/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(6486002)(6666004)(66476007)(66556008)(2906002)(6916009)(4326008)(8676002)(6506007)(498600001)(66946007)(26005)(52116002)(8886007)(6512007)(956004)(186003)(8936002)(16526019)(2616005)(5660300002)(36756003)(83380400001)(86362001)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CKQKUhWt0uGvOybfcvloNPJBx1hnq8IxkP+/rcoltaVvLCeFwehKlXPzRRf4CmL51oZgMJUhi6/C1JfeCO+emJr4u+2V212cq99zSTacB2iz8NFPzJ4E7veWOr8jWgKGc5jgHMqzyjoKrN7P1tTJ2S2cl1whxtRSrXLrGhIK2ORbsUZXBReezM6oCbCihwlKq/u2XLAyGj3WKpyI2rIbUE2d32l2OUaZakqbdDFIQX0ct227YaEJzdjxD38LN3pyCo+ByE2d+rH/FKIWMVy+KF8Iq1pS+Tz9Nbt6mxi6Fb1kxpNiMOnayRjR2lqyvx1IV602UaLQ9Q0K2oxpD0O+QU1edel12fAK27aIQl9YEBHld1theTKfd5e+xM/vGHFUhAA7oCb1Za37gcu2/U+PCnJ4QUdFGCb0T0KMdkR5YNzHWb0fViF2ktnpEZYBlE3K5TVPrWOOH4s0TD6ymIiOqpF7+CL2EEHqK4/ZQsaUM8k=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26a9a44-1720-4bb2-15b1-08d8337249e8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 03:48:43.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9opnq8SLTuuT5HvyaENzryUH9kKEFvPO2I/zVnqmMcGMkUEdnFb8nPwIIDJZbKMgt9yy0t1iG7C9GnnmPIdtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5114
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
v3:
- Detail.c: fix error logic: v2 code didn't check bitmap when dv is null.
v2:
- Detail.c: change to read only one device.
- bitmap.c: modify IsBitmapDirty() to check all bitmap on the selected device.

---
 Detail.c | 20 +++++++++++++++++++-
 bitmap.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mdadm.h  |  1 +
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/Detail.c b/Detail.c
index 24eeba0..a69e5ac 100644
--- a/Detail.c
+++ b/Detail.c
@@ -495,8 +495,26 @@ int Detail(char *dev, struct context *c)
 							  sra->array_state);
 				else
 					arrayst = "clean";
-			} else
+			} else {
 				arrayst = "active";
+				if (array.state & (1<<MD_SB_CLUSTERED)) {
+					for (d = 0; d < max_disks * 2; d++) {
+						char *dv;
+						mdu_disk_info_t disk = disks[d];
+
+						if (d >= array.raid_disks * 2 &&
+							disk.major == 0 && disk.minor == 0)
+							continue;
+						if ((d & 1) && disk.major == 0 && disk.minor == 0)
+							continue;
+						dv = map_dev_preferred(disk.major, disk.minor, 0,
+												c->prefer);
+						if (!dv) continue;
+						arrayst = IsBitmapDirty(dv) ? "active" : "clean";
+						break;
+					}
+				}
+			}
 
 			printf("             State : %s%s%s%s%s%s%s \n",
 			       arrayst, st,
diff --git a/bitmap.c b/bitmap.c
index e38cb96..1095dc8 100644
--- a/bitmap.c
+++ b/bitmap.c
@@ -368,6 +368,61 @@ free_info:
 	return rv;
 }
 
+int IsBitmapDirty(char *filename)
+{
+	/*
+	 * Read the bitmap file
+	 * This function is currently for cluster-md only.
+	 * Return: 1(dirty), 0 (clean), -1(error)
+	 */
+
+	int fd = -1, rv = 0, i;
+	struct supertype *st = NULL;
+	bitmap_info_t *info = NULL;
+	bitmap_super_t *sb = NULL;
+
+	fd = bitmap_file_open(filename, &st, 0);
+	free(st);
+	if (fd < 0)
+		goto out;
+
+	info = bitmap_fd_read(fd, 0);
+	close(fd);
+	if (!info)
+		goto out;
+
+	sb = &info->sb;
+	for (i = 0; i < (int)sb->nodes; i++) {
+		st = NULL;
+		free(info);
+		info = NULL;
+
+		fd = bitmap_file_open(filename, &st, i);
+		free(st);
+		if (fd < 0)
+			goto out;
+
+		info = bitmap_fd_read(fd, 0);
+		close(fd);
+		if (!info)
+			goto out;
+
+		sb = &info->sb;
+		if (sb->magic != BITMAP_MAGIC) { /* invalid bitmap magic */
+			free(info);
+			goto out;
+		}
+
+		if (info->dirty_bits)
+			rv = 1;
+	}
+
+	free(info);
+	return rv;
+out:
+	return -1;
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

