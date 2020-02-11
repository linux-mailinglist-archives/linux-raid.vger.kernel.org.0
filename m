Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F8215901E
	for <lists+linux-raid@lfdr.de>; Tue, 11 Feb 2020 14:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgBKNiQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Feb 2020 08:38:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728080AbgBKNiQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 11 Feb 2020 08:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581428295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=E2vGbj/LVITcQnUH+5h/J/u6nDTDk/KrOpkH55N/Sv0=;
        b=L5ZWrD3Al1kwK39i97WlDUILS2/08wAHqzYTh8R1w7ZNIa0B4EKvEXtF4ztq0YOKUfgXQI
        JudDNSkfn1TGzR3yRL7Yx6PFvXBWjX4TBytoW/zj1JTJmVEn4YVIRKGXAKnO/evLu8M/mH
        PF0W7QCHn8LSnsoUN+fajHGXqtGtSm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-ZhMEzxjiN52XRnyZG-jyoQ-1; Tue, 11 Feb 2020 08:38:12 -0500
X-MC-Unique: ZhMEzxjiN52XRnyZG-jyoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECB4D477;
        Tue, 11 Feb 2020 13:38:11 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0290387;
        Tue, 11 Feb 2020 13:38:09 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     jes.sorensen@gmail.com
Cc:     ptoscano@redhat.com, ncroxon@redhat.com, linux-raid@vger.kernel.org
Subject: [PATCH 1/1] Remove the legacy whitespace
Date:   Tue, 11 Feb 2020 21:38:05 +0800
Message-Id: <1581428285-12008-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The whitespace between Environment= and the true value causes confusion.
To avoid confusing other people in future, remove the whitespace to keep
it a simple, unambiguous syntax

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 systemd/mdcheck_continue.service | 2 +-
 systemd/mdcheck_start.service    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.7.5

