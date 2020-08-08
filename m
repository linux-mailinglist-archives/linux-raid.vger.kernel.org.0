Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CF923F702
	for <lists+linux-raid@lfdr.de>; Sat,  8 Aug 2020 11:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgHHJBp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 8 Aug 2020 05:01:45 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:29942 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbgHHJBp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 8 Aug 2020 05:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1596877301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XYvfb9iqPR3uDGF8Wl6RANpaQlfyI2jFJu9kvNofClQ=;
        b=BIw84ELW+AYFC4j94ArTu+LS/aoa8O8mNKIzaF3uBV/8TerlwF+6ALY70Cd4ypxVw8i9F6
        FhxcWISFTtEv2xcgB+aIQWieVGvM45nXFoqduXzroU78bAfYgv+HXmuCwvG13jgAckf4ta
        i+FTtEPA3tagbILtEMbsbWBCnhQZ1+o=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-vvDPPZmjPPa0Pcp33_7bYw-1; Sat, 08 Aug 2020 11:01:40 +0200
X-MC-Unique: vvDPPZmjPPa0Pcp33_7bYw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDwr2fZ9kQlL9KAZGNc3tY/Zwxc4DztP4mjdSVmt4l/n7Y0a/gLWdtXFukEFfTv6jjUSTQ6I9mWjzdL6xrN5pzHrqzzBS30fxnWT9W33ZZL03UImdiyMVLu7QiZOoL5pLpExltPF7JxJUHSSrf0qpktZ4unbi4uk3meS95Quq9ZPvo3cnS9GmbhPeP07zSFMTjNG3ASHjtzAXDHWpTFeckJXVQgYOVqonFqiFJVz7WyELU1uI0/xrshOBmNoNbWdymPp8pLDLArD600KTmDqeVw+eAzWTfqB7oLmfo04OBE9PUUatucI5OWtCHRz+n9ZMYELot18mj1f2mw7KflIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYvfb9iqPR3uDGF8Wl6RANpaQlfyI2jFJu9kvNofClQ=;
 b=R0Cj4ULTAUIpkh22mJ3lbJRaVZqOXxPmwDPzjV55sJ65BzM0Jj/ifIFE3ggAzEzHQAZlc9O9f71CEpCuLW+ADFme9uM+fPQEdgmUmLhi4rEB3G/A5NRdVv2tah3KifhYZBu/hVP/GH6Ne0PgYwE3qt+DVoB8cGXBgWV5RE1ti/Waj8JCh9elbe8E4DmIIoRWq1xy1Ig+Rl/V/nEBqg+f2shvZfSNdflTCFgvUojcA2zSSIT9glC8/Hb2cMLHUdCTpt9iHB2rz7O4uMcBS9FB2LudIbXOGLOX6kIFbEU7i/eCewqrCXXlrbjQ7b5wvReQBMoz7JReykWgjWjlcntSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4671.eurprd04.prod.outlook.com (2603:10a6:803:71::11)
 by VI1PR04MB7071.eurprd04.prod.outlook.com (2603:10a6:800:128::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Sat, 8 Aug
 2020 09:01:38 +0000
Received: from VI1PR04MB4671.eurprd04.prod.outlook.com
 ([fe80::14fd:7720:b1ff:e756]) by VI1PR04MB4671.eurprd04.prod.outlook.com
 ([fe80::14fd:7720:b1ff:e756%6]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 09:01:38 +0000
From:   Zhao Heming <heming.zhao@suse.com>
To:     linux-raid@vger.kernel.org, jes@trained-monkey.org
Cc:     Zhao Heming <heming.zhao@suse.com>, neilb@suse.com
Subject: [PATCH v4] mdadm/Detail: show correct state for cluster-md array
Date:   Sat,  8 Aug 2020 17:01:19 +0800
Message-Id: <1596877279-21355-1-git-send-email-heming.zhao@suse.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:202:17::28) To VI1PR04MB4671.eurprd04.prod.outlook.com
 (2603:10a6:803:71::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c73.home (123.123.132.145) by HK2PR03CA0058.apcprd03.prod.outlook.com (2603:1096:202:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.6 via Frontend Transport; Sat, 8 Aug 2020 09:01:35 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [123.123.132.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8277c766-c58d-4039-1a31-08d83b79a870
X-MS-TrafficTypeDiagnostic: VI1PR04MB7071:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB70712859D69BE105C56D828697460@VI1PR04MB7071.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:44;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTfEMIbS9/q+xlb/kGDhsXBicUiVuSbfhxrSpXI5pKA2R7Xn/ijLfydqhL5EWaVV6bA+R5k97VjM8W8Hr59HrxJL1ivMuuAbtD2X4gmqnxcXGjPdJ02cNa6kZqNvLbSi84yHP370wX1HgvoUQOstB6prhhOcflrMcrAPGqZ6+PDQgh77GELcxlMKcpf/54FEHy4cw72xc32m79z4t/EJTJa6D3bmNVuQsXZ05SsU6JZSMwH9OIDH7qTw+GAyvJKTvS2/wAtBqN5YsN2gLU29+cfPq24HIkjV83eVt0DcotQGyB37TnvCcg1d5YoNZMdui4xB4vz1J4hnkrPKCQ4J6Mg+hK7/NNsmQg2KPJndIwCPEhvNxhfjp23XZ432ud3X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(396003)(346002)(39860400002)(366004)(8886007)(2616005)(478600001)(52116002)(956004)(2906002)(6512007)(6486002)(107886003)(316002)(6666004)(83380400001)(86362001)(66946007)(4326008)(8936002)(6506007)(66556008)(36756003)(66476007)(186003)(26005)(16526019)(5660300002)(8676002)(9126004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: O4zE/cBHHl13qWg4YEj31uWG2mJXJEiV+fTk0r3BVo4+/STp+tseUyLvcHF4ZoEahblNZugo/+E0u6GDGYR0+sQagG4lzhGHdq0soiT6+w+MvL8a9LJ+N/zH2QICNPxUFga5409CBNeTm5KYWgQbi/vai+XMvbiCrV/AAySYPdPlOAi1wRUfc8CweAVZ8FPSpP+IygzGr7mJrryuEjyP5F0j170PBITEpMuS4ldHjoFuQ3Pmm8DwzsvyFZMIXxlMML7HwwPgUh+VqEzrYIAO2jiT3ae7iDlv8EVtKCZZVXDKzr2VZmqNRHIAgtNBuWHODjweiZ4DjL2VM3xqwhfGDTsmwq1cBqKKLrIE3UMdGAqzrry4CqKmGKAFOFSBA11FqlpdbS+MJO/YQh2JcItAlq6iqX3jdImIQELkCAptlb+5Sm4bc5QljWAAgsMuRR4ANUXq6GDqsmjaqjgOg4P+gT+XYbZrifQP7elgv9ZL/Y+JuH4QAyPOARIx2YEokjvzxCufTiA7i3N1tSCLld/2FwzEuDBvvu0kpMBOtWu9JeyQUfnFJ8qSXPIPO76X0m9sAm6EOa1QazL8hX+Ms4/7133wRxK7xIGzpX6WSkzy9kpPotoqN3jKgSU9j/z5BBj1CRpATbaTPzLUukIEUUzOmg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8277c766-c58d-4039-1a31-08d83b79a870
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 09:01:37.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XXLXwtBl/9x2hvanJsHmuBBTbm6YVrbj00Y8Qkb2Q9x2+Sz6laV2GqT4REkg6nDRoKQWOZ0OUBbuRWnAhgX/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7071
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
v4:
- Detail.c: follow Jes comment, split if into 2 lines
v3:
- Detail.c: fix error logic: v2 code didn't check bitmap when dv is null.
v2:
- Detail.c: change to read only one device.
- bitmap.c: modify IsBitmapDirty() to check all bitmap on the selected device.

---
 Detail.c | 21 ++++++++++++++++++++-
 bitmap.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mdadm.h  |  1 +
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Detail.c b/Detail.c
index 24eeba0..2682e87 100644
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
+						if (!dv)
+							continue;
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

