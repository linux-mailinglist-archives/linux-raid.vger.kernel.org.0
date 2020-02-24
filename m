Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5E16A758
	for <lists+linux-raid@lfdr.de>; Mon, 24 Feb 2020 14:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgBXNgf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Feb 2020 08:36:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:42984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgBXNgf (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 24 Feb 2020 08:36:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12990AC67;
        Mon, 24 Feb 2020 13:36:34 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-raid@vger.kernel.org
Cc:     colyli <colyli@suse.coly>, NeilBrown <neilb@suse.com>,
        Petr Vorel <pvorel@suse.cz>, Coly Li <colyli@suse.de>
Subject: [RESENT PATCH 1/1] Makefile: install mdadm_env.sh to /usr/lib/mdadm
Date:   Mon, 24 Feb 2020 14:36:25 +0100
Message-Id: <20200224133625.16050-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: colyli <colyli@suse.coly>

Current Makefile installs mdadm_env.sh to /usr/libexec/mdadm but calls it
from /usr/lib/mdadm. This patch changes the installation directory to
/usr/lib/mdadm to make things working.

Fixes: f93b797 ("Move mdadm_env.sh out of /usr/lib/systemd")

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Coly Li <colyli@suse.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a33319a..0f2fffd 100644
--- a/Makefile
+++ b/Makefile
@@ -91,7 +91,7 @@ MDMON_DIR = $(RUN_DIR)
 # place for autoreplace cookies
 FAILED_SLOTS_DIR = $(RUN_DIR)/failed-slots
 SYSTEMD_DIR=/lib/systemd/system
-LIB_DIR=/usr/libexec/mdadm
+LIB_DIR=/usr/lib/mdadm
 
 COROSYNC:=$(shell [ -d /usr/include/corosync ] || echo -DNO_COROSYNC)
 DLM:=$(shell [ -f /usr/include/libdlm.h ] || echo -DNO_DLM)
-- 
2.25.1

