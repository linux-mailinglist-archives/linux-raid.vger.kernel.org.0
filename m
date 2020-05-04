Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017C11C3FEA
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgEDQbq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 12:31:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26720 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728655AbgEDQbp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 12:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588609904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QR1racPoMZDKxFUuevWP/o5cHXSy8oQ0vctmkeL5iso=;
        b=OalG0pKM6WcmIZ4WwbwBNc6LVwdXCJ02tdV1hh2ctWFbqgEXThYz0Z6Ib2b3sHxMyaq7VV
        5DrsrIAV/J1xXBbAqq+ziGQlCP766fdb1cTzW91/HpkLppOO3ZCipAtxpNWN2NpFr6j74L
        a2SSUzaYf7xZs9FKIrNJeu0k2mP7ocI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-go_3_EwFPDiA3GhODjw9Ww-1; Mon, 04 May 2020 12:31:40 -0400
X-MC-Unique: go_3_EwFPDiA3GhODjw9Ww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C091800D24;
        Mon,  4 May 2020 16:31:39 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E43A5C1B2;
        Mon,  4 May 2020 16:31:39 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     jes@trained-monkey.org, linux-raid@vger.kernel.org
Subject: [PATCH] allow RAID5 to grow to RAID6 with a backup_file
Date:   Mon,  4 May 2020 12:31:38 -0400
Message-Id: <20200504163138.22787-1-ncroxon@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This problem came in, as the user did not specify a full path with
the backup_file option when growing an RAID5 array to RAID6.
When the full path is specified, the symbolic link is created
properly (/run/mdadm/backup_file-mdX). But the code did not support
the symbolic link when looking for the backup_file. Added two
checks for symlink.

This addresses https://www.spinics.net/lists/raid/msg48910.html
and numerous customer reported problems.

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
 Grow.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Grow.c b/Grow.c
index 764374f..6dce71c 100644
--- a/Grow.c
+++ b/Grow.c
@@ -1135,6 +1135,16 @@ int reshape_open_backup_file(char *backup_file,
 	unsigned int dev;
 	int i;
=20
+	if (lstat(backup_file, &stb) !=3D -1) {
+		switch (stb.st_mode & S_IFMT) {
+		case S_IFLNK:
+			return 1;
+			break;
+		default:
+			break;
+		}
+	}
+
 	*fdlist =3D open(backup_file, O_RDWR|O_CREAT|(restart ? O_TRUNC : O_EXC=
L),
 		       S_IRUSR | S_IWUSR);
 	*offsets =3D 8 * 512;
@@ -5236,8 +5246,17 @@ char *locate_backup(char *name)
 	char *fl =3D make_backup(name);
 	struct stat stb;
=20
-	if (stat(fl, &stb) =3D=3D 0 && S_ISREG(stb.st_mode))
+	lstat(fl, &stb);
+	switch (stb.st_mode & S_IFMT) {
+	case S_IFLNK:
 		return fl;
+		break;
+	case S_IFREG:
+		return fl;
+		break;
+	default:
+		break;
+	}
=20
 	free(fl);
 	return NULL;
--=20
2.20.1

