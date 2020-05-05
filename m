Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF31C602E
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgEESfy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 14:35:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30878 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726618AbgEESfy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 14:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588703753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=brsrfvKteFRiX2im/bGla0KOj4eL2cwYVCGqV7eY18E=;
        b=CAaZJi6Od99DbA+uYep96I244v/LtEER+BRvzo3JP9w0pJu991JdCtH5NzMfIhrJWy2Iz6
        MyeBcZwfOi5Fda+bOHjQQgZl443+uZemN4S4i5uc/A1B5l0ACLhIZZzocTU+6DVkNra2TI
        +j0gQ4goVndeHtiEoa2gL32ol/lirsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-us4lxTlvMjmNhzvM-1TIjg-1; Tue, 05 May 2020 14:35:47 -0400
X-MC-Unique: us4lxTlvMjmNhzvM-1TIjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6556100A614;
        Tue,  5 May 2020 18:35:46 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4C1A9080;
        Tue,  5 May 2020 18:35:46 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     jes@trained-monkey.org, linux-raid@vger.kernel.org
Subject: [PATCH V2] allow RAID5 to grow to RAID6 with a backup_file
Date:   Tue,  5 May 2020 14:35:45 -0400
Message-Id: <20200505183545.26291-1-ncroxon@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

V2:
- Removed unneeded break; in both case-statements
- Returned the error checking on call to lstat

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
 Grow.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Grow.c b/Grow.c
index 764374f..53245d7 100644
--- a/Grow.c
+++ b/Grow.c
@@ -1135,6 +1135,15 @@ int reshape_open_backup_file(char *backup_file,
 	unsigned int dev;
 	int i;
=20
+	if (lstat(backup_file, &stb) !=3D -1) {
+		switch (stb.st_mode & S_IFMT) {
+		case S_IFLNK:
+			return 1;
+		default:
+			break;
+		}
+	}
+
 	*fdlist =3D open(backup_file, O_RDWR|O_CREAT|(restart ? O_TRUNC : O_EXC=
L),
 		       S_IRUSR | S_IWUSR);
 	*offsets =3D 8 * 512;
@@ -5236,8 +5245,16 @@ char *locate_backup(char *name)
 	char *fl =3D make_backup(name);
 	struct stat stb;
=20
-	if (stat(fl, &stb) =3D=3D 0 && S_ISREG(stb.st_mode))
-		return fl;
+	if (lstat(fl, &stb) =3D=3D 0) {
+		switch (stb.st_mode & S_IFMT) {
+		case S_IFLNK:
+			return fl;
+		case S_IFREG:
+			return fl;
+		default:
+			break;
+		}
+	}
=20
 	free(fl);
 	return NULL;
--=20
2.20.1

