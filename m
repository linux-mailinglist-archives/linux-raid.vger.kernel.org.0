Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6241D4F66
	for <lists+linux-raid@lfdr.de>; Fri, 15 May 2020 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEONlH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 May 2020 09:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgEONlG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 15 May 2020 09:41:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004FC05BD09
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 06:41:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so3580446wrt.9
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xLr605v0NBTYaM0tbbk4SHFoT6kSLv9/6s4QP6nnFA=;
        b=Qwwdbkj2G4EuA5EQdMLg57S+k8O5V1boqT4yTKx+K3/9Cnd8FpIfP1KI5LIuUhkU1Q
         SaNDe30eoNFozf/RIGjq+nzxHhMTBUAFRp4/bp28kY1UBZp7yoHMd9vmvmGXrtP0L64I
         uPHWI8zPz4oztuP/E1MaNC/hOQeErF3u1oa163/LBGnDD+mThKCBbEg2Z0MmUwBcne5U
         9IPvHJRPoo2C75kGRmN3i+0O0+p5VRLc/S6pIB9pcqg0cgfWfvnMUpy+3SWjQ4afDIs8
         YOb3pLodkZb12KDkH5vSby18MpLO2lQpX0cTuQVVO31TWMr+uzMNUdoylONlvTRyYlQz
         /sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xLr605v0NBTYaM0tbbk4SHFoT6kSLv9/6s4QP6nnFA=;
        b=iqpK0zzJ6riFC6DWwE+4JUTl6So9tgWQfoSSFKQkAhG7sWUM6DGMgSViMSWus8VlHk
         RpK8Jssf2mFogVBQ9FjlHfdvONfeErJEYrARquUpS93FXSeN9HeUB5UifkC4zjOD+2OG
         xz70fEIAlKuOYZ7zPI/Hb/FxJBIv21gJGsdk51y+5OwsfTsiW0L3pLuRx7DvH31V2bFP
         ARq6uRBk0x7MDSBCdp25+QIH6ybuTnQWyyGrcid8uCD3RXJATSGVl7EzxLuMIIbNDfnb
         RlUsXygcWzV3OQY9Bf7XAMEf0PmLFK0nkbUUbh0Tz7hK3aw151aApjCjCyRJNy6a3lIO
         1hKA==
X-Gm-Message-State: AOAM530qyR9kwgSMMMlO2UQa4X6SsSyJMge+iJQKXsZXLIWetaWsE+ql
        rMNHeFpglvRKYi76lN1n6QB7Ew==
X-Google-Smtp-Source: ABdhPJwSi+UXpZv5esS+y2kBEA1zMqxaKDuBgTPDWURiKhO0xTEyds+rlTEpMIvEjgEWkzMA6U29RQ==
X-Received: by 2002:adf:e5c9:: with SMTP id a9mr4712735wrn.292.1589550063818;
        Fri, 15 May 2020 06:41:03 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:48fe:dd00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id v8sm3918702wrs.45.2020.05.15.06.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 06:41:03 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/2] =?UTF-8?q?restripe:=20fix=20ignoring=20return=20value?= =?UTF-8?q?=20of=20=E2=80=98read=E2=80=99?=
Date:   Fri, 15 May 2020 15:40:26 +0200
Message-Id: <20200515134026.8084-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Got below error when run "make everything".

restripe.c: In function ‘test_stripes’:
restripe.c:870:4: error: ignoring return value of ‘read’, declared with attribute warn_unused_result [-Werror=unused-result]
    read(source[i], stripes[i], chunk_size);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix it by set the return value of ‘read’ to diskP, which should be
harmless since diskP will be set again before it is used.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 restripe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/restripe.c b/restripe.c
index 31b07e8..21c90f5 100644
--- a/restripe.c
+++ b/restripe.c
@@ -867,7 +867,11 @@ int test_stripes(int *source, unsigned long long *offsets,
 
 		for (i = 0 ; i < raid_disks ; i++) {
 			lseek64(source[i], offsets[i]+start, 0);
-			read(source[i], stripes[i], chunk_size);
+			/*
+			 * To resolve "ignoring return value of ‘read’", it
+			 * should be harmless since diskP will be again later.
+			 */
+			diskP = read(source[i], stripes[i], chunk_size);
 		}
 		for (i = 0 ; i < data_disks ; i++) {
 			int disk = geo_map(i, start/chunk_size, raid_disks,
-- 
2.17.1

