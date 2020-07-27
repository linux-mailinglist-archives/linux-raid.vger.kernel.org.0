Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0989322E39C
	for <lists+linux-raid@lfdr.de>; Mon, 27 Jul 2020 03:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgG0BO3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 Jul 2020 21:14:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22228 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726636AbgG0BO3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 26 Jul 2020 21:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595812468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ITHH0El0cqLgwzhHT1r13fFxwNQwyY+LhSaSyQymD78=;
        b=cwMpA0trRNYO3ckNllocXW3K9bES/izzn2iLt3eUo32Z69Yi+sQc+H3D7co2/Q7EhEuuX8
        CSuJM5iUO2KVvfp9Rb1Ql35EhoD8pu/YJeTOKXtMzLKA5rE6M8aig/GAXJRuB4ks1Yt918
        E+QYwpFPhiIWqGtgwVZ9jtZEOw/pKN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-4Z2uzM7UNJmSxmcKqjbRnA-1; Sun, 26 Jul 2020 21:14:26 -0400
X-MC-Unique: 4Z2uzM7UNJmSxmcKqjbRnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD3091270;
        Mon, 27 Jul 2020 01:14:25 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 535B310013C0;
        Mon, 27 Jul 2020 01:14:21 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org, jes@trained-monkey.org
Cc:     antlists@youngman.org.uk, ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH v3 mdadm 1/1] Specify nodes number when updating cluster nodes
Date:   Mon, 27 Jul 2020 09:14:20 +0800
Message-Id: <1595812460-3929-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Now it allows updating cluster nodes without specify --nodes. It can write superblock
with zero nodes. It can break the current cluster. Add this check to avoid this problem.

v2: It needs check c.update first to avoid NULL pointer reference
v3: Wol points the typo error

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 mdadm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mdadm.c b/mdadm.c
index 13dc24e..1b3467f 100644
--- a/mdadm.c
+++ b/mdadm.c
@@ -1433,6 +1433,11 @@ int main(int argc, char *argv[])
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

