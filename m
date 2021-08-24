Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E294F3F5E00
	for <lists+linux-raid@lfdr.de>; Tue, 24 Aug 2021 14:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhHXMbB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 24 Aug 2021 08:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230132AbhHXMa5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 24 Aug 2021 08:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629808213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8heildVPd8mP0xYFhIhBEPaTC5F0AYXa8QSNp+iIiQI=;
        b=AlP1LqRCUQKlPgwIgLFsOCdzkbgqkusH9X9owexZYEY7mnv2rV1zb3466Vs50Xf6hhBNGt
        zo+6yctzKW07xl/9lSf4r8IZpPJdrBSuKJq6UTzfej2rQc11gOXsruqPw536mH6WeShITO
        +VvmNHJt/A/EEEtDOzS5CY9j3xLuPXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-rfiLF01XMsSOle9ErhuXmg-1; Tue, 24 Aug 2021 08:30:09 -0400
X-MC-Unique: rfiLF01XMsSOle9ErhuXmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 611101F2D9;
        Tue, 24 Aug 2021 12:30:08 +0000 (UTC)
Received: from localhost (dhcp-17-75.bos.redhat.com [10.18.17.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 336A91ABD7;
        Tue, 24 Aug 2021 12:30:08 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     neilb@suse.de, jes@trained-monkey.org, xni@redhat.com,
        linux-raid@vger.kernel.org, mariusz.tkaczyk@linux.intel.com
Subject: [PATCH V4] Fix buffer size warning for strcpy
Date:   Tue, 24 Aug 2021 08:30:07 -0400
Message-Id: <20210824123007.2776483-1-ncroxon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

To meet requirements of Common Criteria certification vulnerability
assessment. Static code analysis has been run and found the following
error:
buffer_size_warning: Calling "strncpy" with a maximum size
argument of 16 bytes on destination array "ve->name" of
size 16 bytes might leave the destination string unterminated.

The change is to make the destination size to fit the allocated size.

V4:
Code cleanup of the interim "if" statement.

V3: Doc change only:
The code change from filling ve->name with spaces to filling it with
null-terminated is to comform to the SNIA - Common RAID Disk Data
Format Specification. The format for VD_Name (ve->name) specifies
the field to be either ASCII or UNICODE. Bit 2 of the VD_Type field
MUST be used to determine the Unicode or ASCII format of this field.
If this field is not used, all bytes MUST be set to zero.

V2: Change from zero-terminated to zero-padded on memset and
change from using strncpy to memcpy, feedback from Neil Brown.

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
 super-ddf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/super-ddf.c b/super-ddf.c
index dc8e512f..db2aaa7a 100644
--- a/super-ddf.c
+++ b/super-ddf.c
@@ -2637,9 +2637,9 @@ static int init_super_ddf_bvd(struct supertype *st,
 		ve->init_state = DDF_init_not;
 
 	memset(ve->pad1, 0xff, 14);
-	memset(ve->name, ' ', 16);
+	memset(ve->name, '\0', sizeof(ve->name));
 	if (name)
-		strncpy(ve->name, name, 16);
+		memcpy(ve->name, name, strnlen(ve->name, sizeof(ve->name)));
 	ddf->virt->populated_vdes =
 		cpu_to_be16(be16_to_cpu(ddf->virt->populated_vdes)+1);
 
-- 
2.29.2

