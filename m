Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7F1D8841
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgERTb2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 15:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgERTb2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 15:31:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D95C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 12:31:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w7so13149819wre.13
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 12:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/fTfBEjzCTUQwn7pNdmrmXX20hsCUUDHLeGmcWeApsA=;
        b=QCuEZKx7UFrT1TdV7aDjY9dHw3SfVrl5Y2KNpTI+1Hglc7/ikuua+tVPATYv5VoLn9
         VAPWf22CnH/h10+02g23XtwLge12XWFwgJRF/n6RPNNZQY2m6Yk4tN5UqYdPWsP1UDhh
         jrSXrO7+TD2Sdfg/oOd1eE3DRGNEdCPg+dQKMzgx3E8cBGwvtgHgldOC19z4xnPZ8nci
         gdsXi0DmIuXhMVZqgfo0xcz8JT/ge+pzxAzHnZvDd8pq1i6Rxr+SJfGWKRCwGq+4a+Fd
         WQuHN7FoHIy/x3e0HLUjmhSpUyq0FMfgtORk/LzyooxuxevsBn0SlB+SQu9+zoJMYyDb
         yjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/fTfBEjzCTUQwn7pNdmrmXX20hsCUUDHLeGmcWeApsA=;
        b=ghhgUjR7cmMnf5E/7/SjmbVoE0Q6dGipnjcPTvyonek8Rys7LRoOWoZSjaY2H2QO4x
         lAtSaYBw2VijRbXupk+Xov3nQJcWBbAs2bOprjyZOiigh9FOZNP0jKfB1UI9jBFfo7BX
         eB5LFAeidts2WGosT5YIga4U1dDId3Jq/anpQXnstndfK/T/70UrKxPi8ci1dZffxsGu
         v3bV+vLwFpmI/M1y2Y+1i5hqAErmZZFy5NBCP9V8guYK77A9Vu7Tgwp0txwSEVyXxXdo
         fjjZ6B77CJUot+0YHLse9nfhFJ2X5Asfp34Tx3wiT9P12BLgrEdP01mnNEBGPO4E9fpR
         aJww==
X-Gm-Message-State: AOAM532yzw8YNGPV7zLqxD9jw8upJt/cUe1KDFNoZ15dWUe4HdALLPlm
        dItHDmkV/+kWvZ6xuPkFPUjRZw==
X-Google-Smtp-Source: ABdhPJyV6isBybl4hj35x4SKh0hxC9w3lWyZRMRybUuA/P7jyAkwczzBCL4gPAUXeY/1Cu0t2K8XZg==
X-Received: by 2002:adf:f446:: with SMTP id f6mr20990926wrp.75.1589830285215;
        Mon, 18 May 2020 12:31:25 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:483d:6b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id u65sm736299wmg.8.2020.05.18.12.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:31:24 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 2/2] =?UTF-8?q?restripe:=20fix=20ignoring=20return=20va?= =?UTF-8?q?lue=20of=20=E2=80=98read=E2=80=99?=
Date:   Mon, 18 May 2020 21:31:08 +0200
Message-Id: <20200518193108.26102-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518193108.26102-1-guoqing.jiang@cloud.ionos.com>
References: <20200518193108.26102-1-guoqing.jiang@cloud.ionos.com>
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

Fix it by check the return value of ‘read’, and free memory
in the failure case.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 restripe.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/restripe.c b/restripe.c
index 31b07e8..48c6506 100644
--- a/restripe.c
+++ b/restripe.c
@@ -867,7 +867,15 @@ int test_stripes(int *source, unsigned long long *offsets,
 
 		for (i = 0 ; i < raid_disks ; i++) {
 			lseek64(source[i], offsets[i]+start, 0);
-			read(source[i], stripes[i], chunk_size);
+			if (read(source[i], stripes[i], chunk_size) !=
+			    chunk_size) {
+				free(q);
+				free(p);
+				free(blocks);
+				free(stripes);
+				free(stripe_buf);
+				return -1;
+			}
 		}
 		for (i = 0 ; i < data_disks ; i++) {
 			int disk = geo_map(i, start/chunk_size, raid_disks,
-- 
2.17.1

