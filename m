Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BAE22902F
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 07:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgGVFzt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 01:55:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727084AbgGVFzt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 01:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595397348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=VTK9Ly69hviqifaymAJqy6rfsWy89i4CIHqXoA2iG70=;
        b=In3mYq0BicqU5NGjWIHehRs/eMUyiSLnomIOAf1Ot2cAA1h4Jk9Pcug7sqLc+ebqqe1Da7
        721O3hsaIPWcSBShduJmngd0FsSxlulnzKlXKkoC+pSGhWuoKM1OzpIGrOMDh9fHDT0e+O
        O/+qdpIi60ye9l8H4OF41Pna6OjHma0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-iACbPbBUMdGDvJyT3cLHqA-1; Wed, 22 Jul 2020 01:55:46 -0400
X-MC-Unique: iACbPbBUMdGDvJyT3cLHqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22C4757;
        Wed, 22 Jul 2020 05:55:45 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-37.pek2.redhat.com [10.72.8.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B18438BEC1;
        Wed, 22 Jul 2020 05:55:42 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org, jes@trained-monkey.org
Cc:     ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH mdadm 1/1] Specify nodes number when updating cluster nodes
Date:   Wed, 22 Jul 2020 13:55:40 +0800
Message-Id: <1595397340-6180-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now it allow updating cluster nodes without specify --nodes. It can write superblock
with zero nodes. It can break the current cluster. Add this check to avoid this problem.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 mdadm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mdadm.c b/mdadm.c
index 51e16f3..884dc48 100644
--- a/mdadm.c
+++ b/mdadm.c
@@ -1341,6 +1341,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (strcmp(c.update, "nodes") == 0 && c.nodes == 0) {
+		pr_err("Please specify nodes number with --nodes\n");
+		exit(1);
+	}
+
 	if (c.backup_file && data_offset != INVALID_SECTORS) {
 		pr_err("--backup-file and --data-offset are incompatible\n");
 		exit(2);
-- 
2.7.5

