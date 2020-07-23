Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1189422AD86
	for <lists+linux-raid@lfdr.de>; Thu, 23 Jul 2020 13:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgGWLUQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 23 Jul 2020 07:20:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44457 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728536AbgGWLUQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 23 Jul 2020 07:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595503215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=d6rLNp6Y3Fj/tyiwMmPQ/yXL3oC+qi3Kc1rnQ+xtEmU=;
        b=HgYfD7yT30GO26dlaMh3FARfD/v0jTEN+xHJS+2mDfppWozzBFROOfDdf5TilIccoWb5yT
        FYc9dX7Abx9cs2Bk5mWCqLnnDZ9mD16UWBOfaJ8ZbOaEm7vHKgmCK6polsnXSSTz4BOhiN
        /KVnKDVkYQdoQzgAiXNAaZhKWf88Bo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-VTLJw1h_P5u0hYk9dXysLw-1; Thu, 23 Jul 2020 07:20:12 -0400
X-MC-Unique: VTLJw1h_P5u0hYk9dXysLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0274019253C4;
        Thu, 23 Jul 2020 11:20:12 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5B755D9F1;
        Thu, 23 Jul 2020 11:20:07 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org, jes@trained-monkey.org
Cc:     ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH v2 mdadm 1/1] Specify nodes number when updating cluster nodes
Date:   Thu, 23 Jul 2020 19:20:05 +0800
Message-Id: <1595503205-11129-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now it allow updating cluster nodes without specify --nodes. It can write superblock
with zero nodes. It can break the current cluster. Add this check to avoid this problem.

v2: It needs check c.update first to void NULL pointer reference

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 mdadm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mdadm.c b/mdadm.c
index 51e16f3..e6f0e0b 100644
--- a/mdadm.c
+++ b/mdadm.c
@@ -1341,6 +1341,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (c.update && strcmp(c.update, "nodes") == 0 && c.nodes == 0) {
+		pr_err("Please specify nodes number with --nodes\n");
+		exit(1);
+	}
+
 	if (c.backup_file && data_offset != INVALID_SECTORS) {
 		pr_err("--backup-file and --data-offset are incompatible\n");
 		exit(2);
-- 
2.7.5

