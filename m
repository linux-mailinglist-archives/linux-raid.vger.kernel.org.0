Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD53C224297
	for <lists+linux-raid@lfdr.de>; Fri, 17 Jul 2020 19:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgGQRvb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Jul 2020 13:51:31 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:22297 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgGQRvb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 Jul 2020 13:51:31 -0400
X-Greylist: delayed 33409 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2020 13:51:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595008286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/b/CInnOoZtVac5XXh/9NtbxC0mIATWwwdk89OF9H6w=;
        b=foaNiKR3m/S1EqhPRIy4nDJA4pj9q5b02aBiHfAiFhcz82K4/9wqXlsUTghCfVEDLTlcxD
        SzRAxRZLpdX5zLHZuyliO4qmGqv1q9Nsv4rjV+Q1dCeWs2RuNtzsUNP4BQJQarfuCArc30
        zhTelSkDNXs3Vm80l4xwif67l88CxmE=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2053.outbound.protection.outlook.com [104.47.2.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-9-Sf5oRB-nPZSNFfW0m3MadA-1;
 Fri, 17 Jul 2020 19:51:25 +0200
X-MC-Unique: Sf5oRB-nPZSNFfW0m3MadA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVK9yv9e6Eu4KS9FL7Gl6z/5aJx2SnD3tQ4ysfAOoS4M5S555uIidCZCr9ACSZeiiaiKeal0qxGbIIw1zwCbkuKrGGxlrgHxrcKy0NlSqcHgvJDtWbWK2ho6Xq6SxM5LcNeAax2ngQYfH+aIWKZRjlKlpdxA1eSx47YYQLdXe6T8YTFgCwQgnGqBlYGmdTnFlF2X7RIK948DOS5e7LRyWC3I/FxuDZQvpbNClD7mcvtcFE3g89xE+qFE/wDhg9S1la3LMsQioi7X5kRlsqX1hIxDbGJr3F8eAD/HMK8ADTXP4zQbyrkJoxrnNhBWZvhouGits9oGJj52UrEJebGsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/b/CInnOoZtVac5XXh/9NtbxC0mIATWwwdk89OF9H6w=;
 b=oVZDrVyKpK3MLQOA9Eux+RLHTNMhh3i0F3kG9fGx+DyKzwmxRe2KDz4dgGIMVcFDl7uqy3fRa2GNnX68xXwDCaMy2QL6hO8u1dnan/7S/RiiwHH/owV5sHQE60dZrMwj1z5eGGNFQ36nUCDB3wz9yqskhpL22WORPDNw3RLhdPbrX4bygTgobbLzq6YWXeNLE/twuxMYPUji5upMZN/T6g1HrC4Es5z0jfKJt5+nrrCGfBhuPo88ZRZsWAUVsXNEK1akdcMYNSiGrT6PlPf767kajcbmbFv7TkGh/mjOWCfyAGuvlv4WwR9mT2OhV6ciIoLabCS3XKvlcTdWBLLPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:2b::14) by
 DB7PR04MB4265.eurprd04.prod.outlook.com (2603:10a6:5:1c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Fri, 17 Jul 2020 17:51:24 +0000
Received: from DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa]) by DB7PR04MB4666.eurprd04.prod.outlook.com
 ([fe80::b01a:d99f:8b27:a5aa%4]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 17:51:24 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com,
        jes@trained-monkey.org
Subject: [PATCH] mdadm/Detail: show correct state for cluster-md array
Date:   Sat, 18 Jul 2020 01:51:11 +0800
Message-Id: <1595008271-3234-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:c8::20) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:2b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.133.50) by HKAPR03CA0015.apcprd03.prod.outlook.com (2603:1096:203:c8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend Transport; Fri, 17 Jul 2020 17:51:22 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.133.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b3f69d1-c550-4b81-d0e8-08d82a7a0568
X-MS-TrafficTypeDiagnostic: DB7PR04MB4265:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4265F040D4C31C07B92A73A4977C0@DB7PR04MB4265.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50aOQrzRa+bCHc9Chuv6Gs7c0jaVmdg2CfufcP7fIhlfVGS4gkWT1/NFIa9+MGa6l2+Vu3ToAN8fgQajZzKGxCmnM1RSCbfgRMXAst/WtKdGtQ/gLCgX8j9cs1ve5tChCQfOXhUzl0KoqXTbRX9XIVAG8pdWxZUVoREIrgX739o29/h+Glr4/ekcqmFxi57OsO+Rknoqr0G9ArvFvk0REvY80ACjAcejHo/sBrEVk6HpKoNJrybcWbhGjCtIJoX7lzDptF9KulxJgclH3xV0wo9gdKXECh2XBTXwiW1mgnD92BTAUPj7wUCzPHjFvyZQyuVzP8QbLT/q1lIrdSWotK11rAljbLDYeIs8tdrwEcYNZP3bTiFMv/kv2fQ/ySQE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4666.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(346002)(39860400002)(396003)(136003)(2906002)(86362001)(8886007)(16526019)(52116002)(6506007)(186003)(6916009)(26005)(316002)(2616005)(6666004)(5660300002)(956004)(8676002)(8936002)(66946007)(83380400001)(36756003)(4326008)(66556008)(6486002)(478600001)(66476007)(6512007)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Il7JnWQCGTXIo3BKQsjgDcuuaAgiQG9Ki5tb6WxpdWpw5O+8d5q52RGVty1hNxCzXqXC3UWdbfWNsKZLsiiSOYrLbOqBF0uqmqlHgpE44I3NqbyOj5bcYIUro5TUE3hlkQw3p0UUCxHPO1NYsvq9bs9dE2NATvXgQpAJIEFSmXxXFCKnOKHmOxQzatNwlmo9GroozeWEkgIhfGKW2ttn3gWAwCCk9TpVTyn5gSPIl09nvQGT74VZ5Cy83Ca31VA4h1pGwt1LnrbyqGjouQ3uo5enmrCbY1ZC3p/W7K/N2Ib2FiTOkTct97zTs6RC0/BBqKRyA2ac1dXCR+122MNY3qrcIIRsS3wmmTQDzu/HeQoP8cMz155+2JfjnIkh7PqPqCN1jLmeGcmZuBS7KhMCsjHVFRqUc+bEpLm+oLgrb7pV9oaBmcBpVCr0C5i+5xnV9KPjzjmvul8ZPD+taaVucec0smd0vd0IynaRDG0fVpc=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3f69d1-c550-4b81-d0e8-08d82a7a0568
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:51:24.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KvnxYWcFbrZ4dRnhsq9wWrg649Y0uEin2XL61qwZEpCIwgdtxzmBvEaIho5/br2maJ/Ybahsl0v3AruyW9+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4265
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
 bitmap.c | 22 ++++++++++++++++++++++
 mdadm.h  |  1 +
 3 files changed, 43 insertions(+), 1 deletion(-)

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
index e38cb96..10c2045 100644
--- a/bitmap.c
+++ b/bitmap.c
@@ -368,6 +368,28 @@ free_info:
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
+	if (!info)
+		return rv;
+	close(fd);
+	return info->dirty_bits ? 1 : 0;
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

