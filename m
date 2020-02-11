Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD915902C
	for <lists+linux-raid@lfdr.de>; Tue, 11 Feb 2020 14:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgBKNoZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Feb 2020 08:44:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727923AbgBKNoZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Feb 2020 08:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581428664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=wsuePtNOgrVHW53P1l50QKblbKXspJBnWolSJgxDLB0=;
        b=i7fkxh+IHqxIDm0fJXRJxoIKAiO9VcYKMZFpgfhwO4Gk/x7705Jlr/C0ATtb7a66sNQ3xg
        hRIfTZUDu4yJwuFdI3Na6DpxPh4upBYkg0+lZLaNEu62bdsqN893H+RpjxJ2smy0IIfnJi
        D36r2P8DZhC4O4H/etK5IW1Kb032zCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265--lU3JB-8OZ-W8ntxSHcxZg-1; Tue, 11 Feb 2020 08:44:20 -0500
X-MC-Unique: -lU3JB-8OZ-W8ntxSHcxZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C41C6805BF5;
        Tue, 11 Feb 2020 13:44:19 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 785C41001B00;
        Tue, 11 Feb 2020 13:44:17 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     jes.sorensen@gmail.com
Cc:     ptoscano@redhat.com, ncroxon@redhat.com, linux-raid@vger.kernel.org
Subject: [PATCH 1/1] Remove the legacy whitespace
Date:   Tue, 11 Feb 2020 21:44:15 +0800
Message-Id: <1581428655-12316-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The whitespace between Environment= and the true value causes confusion.
To avoid confusing other people in future, remove the whitespace to keep
it a simple, unambiguous syntax

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 systemd/mdcheck_continue.service  | 2 +-
 systemd/mdcheck_start.service     | 2 +-
 systemd/mdmonitor-oneshot.service | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/systemd/mdcheck_continue.service b/systemd/mdcheck_continue.service
index aa02dde..854317f 100644
--- a/systemd/mdcheck_continue.service
+++ b/systemd/mdcheck_continue.service
@@ -11,7 +11,7 @@ ConditionPathExistsGlob = /var/lib/mdcheck/MD_UUID_*
 
 [Service]
 Type=oneshot
-Environment= "MDADM_CHECK_DURATION=6 hours"
+Environment="MDADM_CHECK_DURATION=6 hours"
 EnvironmentFile=-/run/sysconfig/mdadm
 ExecStartPre=-/usr/lib/mdadm/mdadm_env.sh
 ExecStart=/usr/share/mdadm/mdcheck --continue --duration ${MDADM_CHECK_DURATION}
diff --git a/systemd/mdcheck_start.service b/systemd/mdcheck_start.service
index da62d5f..3bb3d13 100644
--- a/systemd/mdcheck_start.service
+++ b/systemd/mdcheck_start.service
@@ -11,7 +11,7 @@ Wants=mdcheck_continue.timer
 
 [Service]
 Type=oneshot
-Environment= "MDADM_CHECK_DURATION=6 hours"
+Environment="MDADM_CHECK_DURATION=6 hours"
 EnvironmentFile=-/run/sysconfig/mdadm
 ExecStartPre=-/usr/lib/mdadm/mdadm_env.sh
 ExecStart=/usr/share/mdadm/mdcheck --duration ${MDADM_CHECK_DURATION}
diff --git a/systemd/mdmonitor-oneshot.service b/systemd/mdmonitor-oneshot.service
index fd469b1..373955a 100644
--- a/systemd/mdmonitor-oneshot.service
+++ b/systemd/mdmonitor-oneshot.service
@@ -9,7 +9,7 @@
 Description=Reminder for degraded MD arrays
 
 [Service]
-Environment=  MDADM_MONITOR_ARGS=--scan
+Environment=MDADM_MONITOR_ARGS=--scan
 EnvironmentFile=-/run/sysconfig/mdadm
 ExecStartPre=-/usr/lib/mdadm/mdadm_env.sh
 ExecStart=BINDIR/mdadm --monitor --oneshot $MDADM_MONITOR_ARGS
-- 
2.7.5

