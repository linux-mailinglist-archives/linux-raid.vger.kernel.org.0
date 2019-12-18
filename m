Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA14A123FCA
	for <lists+linux-raid@lfdr.de>; Wed, 18 Dec 2019 07:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfLRGq3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 18 Dec 2019 01:46:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55385 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725797AbfLRGq3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 18 Dec 2019 01:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576651588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=DMunPiXDGsswR2ED7amyW8S789pl3mo5xYrsVrOqiAs=;
        b=Tt0cVru/LMdYRapI5BSvLrlTQfz1hmmGRLH5TMdDauD0vroypXJZGLAgETdUZUQr/07Olf
        hzSkDLC84Llbk/n+ay2ivmK9An2FqL2dlHoGoAo7K6QSgUJy1+62dKErfJmzRy5K8/YeO3
        GJ35SfrufxAkXAO6GQ+xONduCNcDbso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-1CVuJj82MemQBq_PUZ5l5g-1; Wed, 18 Dec 2019 01:46:26 -0500
X-MC-Unique: 1CVuJj82MemQBq_PUZ5l5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDACC189CD00;
        Wed, 18 Dec 2019 06:46:25 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 938A019757;
        Wed, 18 Dec 2019 06:46:23 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org
Subject: [mdadm PATCH 1/1] mdcheck service can't start succesfully because of syntax error
Date:   Wed, 18 Dec 2019 14:46:21 +0800
Message-Id: <1576651581-5135-1-git-send-email-xni@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

It reports error when starting mdcheck_start and mdcheck_continue service.
Invalid environment assignment, ignoring: MDADM_CHECK_DURATION="6 hours"

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 systemd/mdcheck_continue.service | 2 +-
 systemd/mdcheck_start.service    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/systemd/mdcheck_continue.service b/systemd/mdcheck_continue.service
index deac695..aa02dde 100644
--- a/systemd/mdcheck_continue.service
+++ b/systemd/mdcheck_continue.service
@@ -11,7 +11,7 @@ ConditionPathExistsGlob = /var/lib/mdcheck/MD_UUID_*
 
 [Service]
 Type=oneshot
-Environment= MDADM_CHECK_DURATION="6 hours"
+Environment= "MDADM_CHECK_DURATION=6 hours"
 EnvironmentFile=-/run/sysconfig/mdadm
 ExecStartPre=-/usr/lib/mdadm/mdadm_env.sh
 ExecStart=/usr/share/mdadm/mdcheck --continue --duration ${MDADM_CHECK_DURATION}
diff --git a/systemd/mdcheck_start.service b/systemd/mdcheck_start.service
index f17f1aa..da62d5f 100644
--- a/systemd/mdcheck_start.service
+++ b/systemd/mdcheck_start.service
@@ -11,7 +11,7 @@ Wants=mdcheck_continue.timer
 
 [Service]
 Type=oneshot
-Environment= MDADM_CHECK_DURATION="6 hours"
+Environment= "MDADM_CHECK_DURATION=6 hours"
 EnvironmentFile=-/run/sysconfig/mdadm
 ExecStartPre=-/usr/lib/mdadm/mdadm_env.sh
 ExecStart=/usr/share/mdadm/mdcheck --duration ${MDADM_CHECK_DURATION}
-- 
2.7.5

