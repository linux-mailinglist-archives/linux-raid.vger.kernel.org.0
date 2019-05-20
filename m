Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D0B24309
	for <lists+linux-raid@lfdr.de>; Mon, 20 May 2019 23:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfETVot (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 May 2019 17:44:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37762 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfETVot (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 May 2019 17:44:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so18153152qtp.4;
        Mon, 20 May 2019 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlLT+WTpg4Ps+1NlfgmXWXguRYE2vt+4vNZDcCDsGuk=;
        b=B6BgC624TuG8vr8uEAvfu+E9iiP0MurLKToNipaxXTA0mpX/QPc190Xudvw7KV1+8I
         Xw7KV/itYIV3CXpgPp88cn5POSYCGpa/zJMAJRXYHYX86v2H+S81V0EqXbxmuCL3v2n8
         JAOsp8m55sIdKUTOdbjH8BqHXPgxsFPvsWJQTyFZ6qiZGxJRKAL0mbc/aiVYKhGY1cBP
         xkPGlAApBlE0tTznDGFpcooy1VYk2JSKZ4+ygiKHhB0qBZHHu+nFtPRIglXPyjy49Prw
         59bKCxNlG369TIOPfa0BiNmtySV6HuZPN1nnD1yvkqQ4NEFFvK/Zvq8N0hyOEJp0UZ2J
         z1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlLT+WTpg4Ps+1NlfgmXWXguRYE2vt+4vNZDcCDsGuk=;
        b=EOwqdWrkSpur02hRGIppb6lbWJ3c9fB45zXrcwSUJOGXKi22QvLtsFm+Ey1iBrw6Ok
         CK0kzj+c0Z5ZYHQDvIYKzTAtDVubucG89rXGJC305sxRVATAwCatjIReWt1y2oJgTh6s
         RSLgzFPjv7RT82712Z2OAzBtvxlIjGc0/qynWEin6n4b3iIosbIVF3HSzFPZGJmohRyt
         /92o7jopKpuuGmJ0nJ6No48fL06i+EKHbF8jH6jlj+E/nxoYMnpJ8KQM/yAp3js/Xtyx
         gSsMUGE44fLfcvrHBDHB1OKrdgIToLAeBFiV322NfnGQM6zl0vOx+IkuYGTtqY1/9trF
         qeiQ==
X-Gm-Message-State: APjAAAUCmqumSgcEwlSriQxf5ZQqOGRZ903mb4aQyX16jswkLu5e4zLb
        ujDMp4BRm3+kL3gHWftRQ5Qe2HSO
X-Google-Smtp-Source: APXvYqx9szbxpwlUBIx9mvr0e3EtrqeX22V6bFsQ+d1WLIUcrjL4S+iIq3ZFEVoZ3U42tBkPqIS6Fg==
X-Received: by 2002:ac8:2c7d:: with SMTP id e58mr25168374qta.243.1558388687823;
        Mon, 20 May 2019 14:44:47 -0700 (PDT)
Received: from localhost.localdomain ([179.185.210.219])
        by smtp.gmail.com with ESMTPSA id t30sm11427530qtc.80.2019.05.20.14.44.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 14:44:46 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT)
Subject: [PATCH 2/4] md: raid0: Remove return statement from void function
Date:   Mon, 20 May 2019 18:44:25 -0300
Message-Id: <20190520214427.18729-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520214427.18729-1-marcos.souza.org@gmail.com>
References: <20190520214427.18729-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This return statement was introduced in commit
1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2") and can be
safely removed.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/md/raid0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f3fb5bb8c82a..42b0287104bd 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -609,7 +609,6 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 static void raid0_status(struct seq_file *seq, struct mddev *mddev)
 {
 	seq_printf(seq, " %dk chunks", mddev->chunk_sectors / 2);
-	return;
 }
 
 static void *raid0_takeover_raid45(struct mddev *mddev)
-- 
2.21.0

