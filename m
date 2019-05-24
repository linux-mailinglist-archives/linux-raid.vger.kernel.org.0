Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A05529AE9
	for <lists+linux-raid@lfdr.de>; Fri, 24 May 2019 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389321AbfEXPWW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 May 2019 11:22:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42009 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389221AbfEXPWV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 May 2019 11:22:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so10434886wrb.9
        for <linux-raid@vger.kernel.org>; Fri, 24 May 2019 08:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLAfcHiBzrD/m6EyMGHXyMitbyQF/jOB14G/tSm/8Zk=;
        b=DUODraw4YP7W9/eWFE3Hn13HTnx9KQEkZYL9+EnpXBgFXxaRgq0GpmXwI/T6w/4GzM
         whNzWJ+TCzAC5a+cDRbf64/O3YotR43lePT2lREeKWtZO5V/z8lZm/tGMT9zfSVGm2fg
         XTK+lFjKzghuER0ahTzLsxm24EmJAdHpwvCiqc2LttkKMwAbEjegc286hVIBWxK3hpL2
         oWgVGYmB9CRtfd8ZfJ+DULWlBobSpuSBTC4aFCf/usIxbp91QFxjgWuU8Ko6PndyJtvQ
         nicK0TPwrAAi+gOqQxDcr45rZ/8iZCg68cH5wMAKMYKIuXZpwKmvtrJYhLDxUltLdeif
         z07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLAfcHiBzrD/m6EyMGHXyMitbyQF/jOB14G/tSm/8Zk=;
        b=Sf54JOCTzbtoF1vmP2mWNcUrN/p/C/HTFfqEY0RwL/cz/EBanRIe4pMrdNiCPPvK7g
         t8mO9E/ffpSvvOm6ZabtSh3DTYUveACbGusSTernvGYXYo8XYHcDN7xzz2jUo2KVZlEg
         u4KZ1OxKdVZ5BmTyKZgLn+RQ99BdXM5uk3LJQhZgm4e7Yo1/FTuzsmtVXtP/zWo+wbRN
         90QJ9nK72cg6u/eXXXrjMAGCnBU8HpTJoXw5m9HBUXL7dzjFqoZbMOi09gj8wOsP8ws0
         rRtWAn/iCKIlzZjO4NQdjLS5BXG8Juxh36qqp0ZBjYdQgyiY+02YhgU/muTs+iWPx3JM
         zNsg==
X-Gm-Message-State: APjAAAVGYlEt7DFOPu6Zj4bNJ2vUMHV7L8amwKHbNsMGWYPGjSU8RugL
        1VwpJ7Qe3WHSRh/MVeTPOZCM6FVr
X-Google-Smtp-Source: APXvYqwzo4VBu/FbULfS3v2YGLo2g3cf+2LPjTv61yCTteyfbiz8jVvfGiPKqeRRws/k3XAD4hxjSA==
X-Received: by 2002:a5d:510c:: with SMTP id s12mr402038wrt.338.1558711339800;
        Fri, 24 May 2019 08:22:19 -0700 (PDT)
Received: from localhost ([88.98.246.218])
        by smtp.gmail.com with ESMTPSA id w18sm1724536wru.15.2019.05.24.08.22.18
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 08:22:18 -0700 (PDT)
From:   luca.boccassi@gmail.com
To:     linux-raid@vger.kernel.org
Subject: [PATCH] mdadm: use pkgconfig to find systemd unit dir
Date:   Fri, 24 May 2019 16:22:12 +0100
Message-Id: <20190524152212.26385-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Luca Boccassi <luca.boccassi@microsoft.com>

Just like it's done for udev, use pkg-config to find the
directory where to install units to, and use the default as a
fallback. Fixes the build on a usrmerge'd system.

Signed-off-by: Luca Boccassi <luca.boccassi@microsoft.com>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dfe00b0..cc015ea 100644
--- a/Makefile
+++ b/Makefile
@@ -88,7 +88,10 @@ MAP_PATH = $(MAP_DIR)/$(MAP_FILE)
 MDMON_DIR = $(RUN_DIR)
 # place for autoreplace cookies
 FAILED_SLOTS_DIR = $(RUN_DIR)/failed-slots
-SYSTEMD_DIR=/lib/systemd/system
+SYSTEMD_DIR := $(shell $(PKG_CONFIG) --variable=systemdsystemunitdir systemd 2>/dev/null)
+ifndef SYSTEMD_DIR
+ SYSTEMD_DIR = /lib/systemd/system
+endif
 LIB_DIR=/usr/libexec/mdadm
 
 COROSYNC:=$(shell [ -d /usr/include/corosync ] || echo -DNO_COROSYNC)
-- 
2.20.1

