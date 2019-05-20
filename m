Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4D2430C
	for <lists+linux-raid@lfdr.de>; Mon, 20 May 2019 23:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfETVoy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 May 2019 17:44:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34703 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfETVov (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 May 2019 17:44:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id j20so9812271qke.1;
        Mon, 20 May 2019 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3lFbQgJJ+lew9eDTSzlU3Aed2lriWUZ0JF203LqPIM=;
        b=H5c7ix3y9PcxFwWBhnSVlYc2blrkVSxD6MPBNsGgsco+z1pPB10EW6nbvohUisdRzK
         7A32ghihB3rS0dT7b10Whg4vkKNFIBlaVEvefbzYNBcRvInG8r5v6vaowX90douvt8Dq
         NTJGZJArviUZsQm7dIg3st0j355yMuNYci0To0tTudxd8wNbhTLZWpUcfvxvtlv0hRbg
         MPVPuf0045W936I4Q0PTinaQNcUCms65mtxF7VaGJrunsmdEKyK3fepdEDEet/0DY9sD
         04b6Ph6fmIeQKduZxeagODC7M4wZX0/c7KavgjWcJrdaEVOEuMUA/4UFLeuzMK8rBFp3
         GtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3lFbQgJJ+lew9eDTSzlU3Aed2lriWUZ0JF203LqPIM=;
        b=lCMFoVyPxslITsYPWKyvgBLHd/uhOVOM5wXTH/ZyBIKVxfay37owD4fz23HLjM4ri8
         m5mIN3TynRGVggxCJYjN8D52Lu36Yc2VCLBVBtngpIY8D18j0PUv5wQZ1o8Qxc2b7Fcv
         HPYBL1UGtFswGN8j24xuig4cU65paFmB1ZLiHIVQZWa1POW9hQ8noFy8vUXn5JJu7uy7
         9cnJRL3w7lSHDmrid4O+8sFC44oWIZUMFTEgK8ndSzz4kk8BLUPNCIa64mWlbIOy/nrS
         VfSXpm/r4LCXdGvhq17uqs1BIRwvzLsSosKHM2yZCQP5VmspHQSXSSSie8yxFHqvaazS
         z3kg==
X-Gm-Message-State: APjAAAVZUAcmUOIUbtdPZ8XsbKaBv9gieU7UpIVHF9Wb4Na77iB3Y0rQ
        yJIbMgDPBntr/w609JujHE199uLo
X-Google-Smtp-Source: APXvYqzoMAnwa0ujNwGVzOwjA8qqX77j5WHBwUD/YfGtoP0mQ4Vi7xOR6pA/zHmbVnleEGQINXAqzw==
X-Received: by 2002:a37:9ec5:: with SMTP id h188mr59538779qke.90.1558388690274;
        Mon, 20 May 2019 14:44:50 -0700 (PDT)
Received: from localhost.localdomain ([179.185.210.219])
        by smtp.gmail.com with ESMTPSA id t30sm11427530qtc.80.2019.05.20.14.44.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 14:44:49 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT)
Subject: [PATCH 3/4] md: raid0: Return md_integrity_register result directly
Date:   Mon, 20 May 2019 18:44:26 -0300
Message-Id: <20190520214427.18729-4-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520214427.18729-1-marcos.souza.org@gmail.com>
References: <20190520214427.18729-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Commit 0c35bd4723e4a39ba2da4c13a22cb97986ee10c8
("md: fix problems with freeing private data after ->run failure")
removed the check for the result of md_integrity_register, so we don't
need to store it anymore, so return it directly.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/md/raid0.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 42b0287104bd..e72255464c09 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -431,9 +431,7 @@ static int raid0_run(struct mddev *mddev)
 
 	dump_zones(mddev);
 
-	ret = md_integrity_register(mddev);
-
-	return ret;
+	return md_integrity_register(mddev);
 }
 
 static void raid0_free(struct mddev *mddev, void *priv)
-- 
2.21.0

