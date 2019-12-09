Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 248DA1177D2
	for <lists+linux-raid@lfdr.de>; Mon,  9 Dec 2019 21:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLIUy0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 Dec 2019 15:54:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58408 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIUyZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 Dec 2019 15:54:25 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1ieQ2x-0002SW-Iz
        for linux-raid@vger.kernel.org; Mon, 09 Dec 2019 20:54:23 +0000
Received: by mail-il1-f200.google.com with SMTP id t15so12676806ilh.2
        for <linux-raid@vger.kernel.org>; Mon, 09 Dec 2019 12:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/M6nu1zldDvZEXDMfxTW6wuVYCcQBLrsLx/6JLmlZLc=;
        b=f0p6J6Xe2lY71I5R9Byd98uSxQSnjEqTjm95I7CtRNV80+/Fr32Obp7tp9IZ4Sv6al
         T2Wpbtk/7f3lgaPHLft/hoXoOQDtzXF5tif5ugZb5mNYaY/QQfEq6guGzlQyHWlr+7wc
         s07hoXpegnRlMd5961xptJumdB0/fblP0RRWvCt1hTEdqCOEAj4PtyM0oA82DWFNDh7Q
         OR+/b40Ie4f29ofA1C8UYmrxAElijrp3buwbSdNsnL8yOOu4zI8v08CpfTmkM5cEsce2
         KrdH7OyCC9ymac3utuPYAYJktlv3+LLx+kimN2yJJf0uuHHATnwle9ODLDNP1hPhsuHW
         ZWag==
X-Gm-Message-State: APjAAAUqNBS5NE1lSUWMkqaBsq9v7pCjlm4qNeA4dcnnsxmE8NgaQljs
        qfF8PKUdsQ3nktDvb6eQCQXrHU5reGMPTKlk5yc/Yl1msmOof39kXl5zmtm2r9wWRyE+3PtbjSq
        iuhFxksqeZFHEEI2Il4nnFyyYcgeX8kkz12nV05w=
X-Received: by 2002:a6b:e71a:: with SMTP id b26mr22429574ioh.273.1575924862410;
        Mon, 09 Dec 2019 12:54:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqylVBoLa6PnKeCD9pNYSAxzmihtbwfIn9I1PN0fg7opyntqH6MuyX2mRYS+nj+2cHv5b6X+eg==
X-Received: by 2002:a6b:e71a:: with SMTP id b26mr22429563ioh.273.1575924862155;
        Mon, 09 Dec 2019 12:54:22 -0800 (PST)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id y21sm165010iob.18.2019.12.09.12.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 12:54:21 -0800 (PST)
From:   dann frazier <dann.frazier@canonical.com>
To:     Jes Sorensen <jes@trained-monkey.org>
Cc:     Helmut Grohne <helmut@subdivi.de>, linux-raid@vger.kernel.org
Subject: [PATCH] Respect $(CROSS_COMPILE) when $(CC) is the default
Date:   Mon,  9 Dec 2019 13:54:13 -0700
Message-Id: <20191209205413.6839-1-dann.frazier@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Commit 1180ed5 told make to only respect $(CROSS_COMPILE) when $(CC)
was unset. But that will never be the case, as make provides
a default value for $(CC). Change this logic to respect $(CROSS_COMPILE)
when $(CC) is the default. Patch originally by Helmet Grohne.

Fixes: 1180ed5 ("Makefile: make the CC definition conditional")
Signed-off-by: dann frazier <dann.frazier@canonical.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dfe00b0a..a33319a8 100644
--- a/Makefile
+++ b/Makefile
@@ -46,7 +46,9 @@ ifdef COVERITY
 COVERITY_FLAGS=-include coverity-gcc-hack.h
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
+ifeq ($(origin CC),default)
+CC := $(CROSS_COMPILE)gcc
+endif
 CXFLAGS ?= -ggdb
 CWFLAGS = -Wall -Werror -Wstrict-prototypes -Wextra -Wno-unused-parameter
 ifdef WARN_UNUSED
-- 
2.24.0

