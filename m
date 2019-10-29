Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1314FE93B7
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 00:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfJ2XdN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 19:33:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfJ2XdN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 29 Oct 2019 19:33:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 205E2B42A;
        Tue, 29 Oct 2019 23:33:12 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Wed, 30 Oct 2019 10:32:41 +1100
Subject: [PATCH 2/3] mdcheck: use ${} to pass variable to mdcheck
Cc:     linux-raid@vger.kernel.org
Message-ID: <157239196161.30065.10335916105410622244.stgit@noble.brown>
In-Reply-To: <157239190470.30065.4500556456316521334.stgit@noble.brown>
References: <157239190470.30065.4500556456316521334.stgit@noble.brown>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

$MDADM_CHECK_DURATION allows the value to be split on spaces.
${MDADM_CHECK_DURATION} avoids such splitting.

Making this change removes the need for double quoting when setting
the default Environment, and means that double quoting isn't needed
in the EnvironmentFile.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 systemd/mdcheck_continue.service |    5 ++---
 systemd/mdcheck_start.service    |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/systemd/mdcheck_continue.service b/systemd/mdcheck_continue.service
index 592c60798f82..deac695485b0 100644
--- a/systemd/mdcheck_continue.service
+++ b/systemd/mdcheck_continue.service
@@ -11,8 +11,7 @@ ConditionPathExistsGlob = /var/lib/mdcheck/MD_UUID_*
 
 [Service]
 Type=oneshot
-Environment= MDADM_CHECK_DURATION='"6 hours"'
+Environment= MDADM_CHECK_DURATION="6 hours"
 EnvironmentFile=-/run/sysconfig/mdadm
 ExecStartPre=-/usr/lib/mdadm/mdadm_env.sh
-ExecStart=/usr/share/mdadm/mdcheck --continue --duration $MDADM_CHECK_DURATION
-
+ExecStart=/usr/share/mdadm/mdcheck --continue --duration ${MDADM_CHECK_DURATION}
diff --git a/systemd/mdcheck_start.service b/systemd/mdcheck_start.service
index 812141bb5c9a..f17f1aaec217 100644
--- a/systemd/mdcheck_start.service
+++ b/systemd/mdcheck_start.service
@@ -11,7 +11,7 @@ Wants=mdcheck_continue.timer
 
 [Service]
 Type=oneshot
-Environment= MDADM_CHECK_DURATION='"6 hours"'
+Environment= MDADM_CHECK_DURATION="6 hours"
 EnvironmentFile=-/run/sysconfig/mdadm
 ExecStartPre=-/usr/lib/mdadm/mdadm_env.sh
-ExecStart=/usr/share/mdadm/mdcheck --duration $MDADM_CHECK_DURATION
+ExecStart=/usr/share/mdadm/mdcheck --duration ${MDADM_CHECK_DURATION}


