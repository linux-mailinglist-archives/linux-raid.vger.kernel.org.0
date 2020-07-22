Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC32291CC
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgGVHMI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 03:12:08 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:35194 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbgGVHMH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 03:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595401923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pGGqVu62cf7qQuKy1C3A6Tz/sDrk+amulssP+b60hvI=;
        b=N5Ej25M5wWX1Nd0mvtDZgrRObAVnzkve8YDFwspOqoIqWKxo9RU0+iskxXeWkGTRVE1rBi
        xeXlIXntcLlRJmO8H1BSfg2sVBk90BjM8NgATyGHTJ3Fn6KwM7A9m4FTfP6qlbWnjrzmLO
        DgPgZHf4T3mxXBPo3bHyA4BPOVcLCp8=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-HOKWdRY8Oiu0ZG2RklPRqA-2; Wed, 22 Jul 2020 09:12:02 +0200
X-MC-Unique: HOKWdRY8Oiu0ZG2RklPRqA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV/2wQ0gG5Ad6zUXpb6RZDCj3ii1PNICvP2vZm/n7COK2AKsoOrhmp5B4hUtuDmuBsMhPS4mrTlPbMN7oHG5L3miK/GlgMgEB4FZu+J1xrOEUWwBaOIBNPIHO60wQ2KfTz46JHLadLUQbf8yPsm6lzcmGvEPFaKXhF8EHdxjBVMCpKY2p4LKc7Jkgw822lTC0rim73AsLLNs0qVUU+qNGSR+/ZkFFHyKm7tr879GT9qr0pNxbJ1HZ801O4V1BYQ8GLb6qqcBmI9EzjROKmPg8yMt5fFUbSAYpWzZpJZToVntZRu3TQJWndX4IEkkE1UJeYceT6rKfS2PRfvmW6q8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGGqVu62cf7qQuKy1C3A6Tz/sDrk+amulssP+b60hvI=;
 b=hYhziDIiYIZ/brEUpVLOwdf5BLMscHSbqI0yQD0j4jSAWv5HLQ3OByR/SnJXtcRYyya8vm3/L5SUMjwyeB2JYtEPu36G2zhes5z5mYULumjGXf/wAGmqZAjDDG8cdY5SZo6I79oB+sV0gCsPonltE/rkY1ySZImAC89I6dHEDgsTNyLJJPbMUg5MJPbHilGY7jqqkuaTLCLZbS+JyZ1gQ3XZA5dLrEriG2We/yPz/h6452kN5DqLedza9CiPFGGIEviwHlOCHzsNGNem4OVKgp5rv8LAXyC+wdFJtK+z6R7wdcjc3y7nvjJ6gWJ2qdkh/wQyN3ymfWYVhukKCmVpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB4060.eurprd04.prod.outlook.com (2603:10a6:5:23::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22; Wed, 22 Jul 2020 07:12:00 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 07:11:59 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com,
        jes@trained-monkey.org
Subject: [PATCH v2] mdadm/Detail: show correct state for cluster-md array
Date:   Wed, 22 Jul 2020 15:11:45 +0800
Message-Id: <1595401905-3459-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HK0PR03CA0116.apcprd03.prod.outlook.com (2603:1096:203:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Wed, 22 Jul 2020 07:11:57 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce83fc5d-6de3-4805-ceb9-08d82e0e8683
X-MS-TrafficTypeDiagnostic: DB7PR04MB4060:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4060B1F27D2F7D56B21E2BBB97790@DB7PR04MB4060.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:44;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygG2CzdJWxIu5jWdXn7vx9cq/9FAs2K93AjDj2aiV3/UzaSqwTedg4rc2HSE37Yso5E3VYWQD+OiG0e5ky/sGWc/7hTzWNGdNhnSjHRd+XR4KPZKMOa4T77YlsCK90aA84NOoYRgXZSQfHmwKTZRBpqLXIB0mMCezJVqIi3n2ZgKuJm9LQWBo1/8k8gvfcKQsrTyHmfdoLR4IotMTznuhrmAzr7bphmqxDlEl+Cl2ceObH8TL3YCaU9O6RV0YS+MV5jGajlBuc+57NxxOL6TPUDyCZl1bNQ1gj93onMLbzS+Pmu3aZCPY2ZlsHAElOf72gwWDk/hhrQ/0Rs9M+5bUYqlgLSS4XK9yeRrmEqGjpH09iaIUCSXxzD2j18HJXfE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(136003)(376002)(396003)(346002)(366004)(956004)(2616005)(6512007)(66476007)(66556008)(66946007)(186003)(26005)(16526019)(8886007)(52116002)(6666004)(5660300002)(478600001)(86362001)(6506007)(83380400001)(36756003)(8676002)(6916009)(316002)(4326008)(8936002)(6486002)(2906002)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dhTK9smGaUuE/S+zlxnuk5iNG9e5j6wvFRS5HSlp6BsTp+/pl+QijKnuXRfkEnwX2+zk1w9ju3EaOdNxMUFQ8hVf2Gj8FGwu90S+zIemC4Ro2qkmOSH5FfKiB6f/VLYe9IVhc+SIZhv3TQvzfl548AySLOvLp843ISt7WWwLWcEE53CB4tOOSCO7J9sYaF2sK1KgPw5hcCWEKxUma47SxM5zYFuxOI0vDxeFN9G/5JjkL1NIFR7svleprDwoFeMspqJlqgGlpJU4k6VzkgIDUb1k0zqF8ncuGDH2dq9ATP1m3sslxUOl6bYcPPIGv2JLh5pgm/tPoyVU6cCvPY6fVO9vYDg1ZN8xne5qIcjPs6fD7aBhGZswwYI4K4HWM476UTTxANYE1629dzUX0+Ea9BcRvqIP7ckbMzt9GqTJnZ0fSnZwLgLui1Vv4EkzQGn58SL+Fy7erJ+RkOLIcPZRqOhxTd4V+5XRfEpsFZbz14w=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce83fc5d-6de3-4805-ceb9-08d82e0e8683
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 07:11:59.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x42j52RpctglGHAJoTxo8uCuw3ZvUeQottX3LsdngdUK50CfpxlT8/F1yuvl51vRsjOOHE2q4KRVq0Vd2VmJag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4060
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
v2:
- Detail.c: change to read only one device.
- bitmap.c: modify IsBitmapDirty() to check all bitmap on the selected device.

---
 Detail.c | 20 +++++++++++++++++++-
 bitmap.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mdadm.h  |  1 +
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/Detail.c b/Detail.c
index 24eeba0..cb5ce7d 100644
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
+								disk.major == 0 && disk.minor == 0)
+							continue;
+						if ((d & 1) && disk.major == 0 && disk.minor == 0)
+							continue;
+						dv = map_dev_preferred(disk.major, disk.minor, 0,
+												c->prefer);
+						if (dv && !IsBitmapDirty(dv))
+							arrayst = "clean";
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

