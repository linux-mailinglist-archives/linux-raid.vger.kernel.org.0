Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D51D8A43
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 23:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgERVxp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 17:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVxp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 17:53:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9374C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 14:53:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w64so1149302wmg.4
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4uzxdsMKf201XF1dMLHDsPqS9Q9fPt0B1LbSautJCs=;
        b=UvPB+9O8S+vg+WmxeixdNGyKOb00s1THIqJAlEZPchopgI6enUObj4XNmxkIRzJGln
         Rib9iO5qiP5ygWYEXySW9oftFJNlv5rTSltR8uJzpTZGDsss4XMtXMN33YHiwdC2eIH9
         7qR8r0ExycJCzssUMbIO2mpmsuwnv73VyEm2jjSxE22PIIvCB/I6oG5oohN9YQmwwTbT
         osA6HOc/57vc1R5DphWUNFMhsmSh/aR2jnZQkhKTIuYCe6AauRsvk5HR1J0SyHhdTdC/
         5yrLyM34e4cvmiv0CC44Crb9BWqjql+EgsFvbKtIWLbpk0quzgEeZOl7ftW44RlvM4cj
         Em/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4uzxdsMKf201XF1dMLHDsPqS9Q9fPt0B1LbSautJCs=;
        b=f2IK4gDnHsfO51Xl9wpXpqhetJfaeHzJYHdCLPAEfmQ3hWD33n90HIcrD4PTQ/IU8N
         Kg9bMFwJV9eMRM/iosMDEvJM0tP5D1s4yLxk/u9V26X1rBnNNHgK9Z+rWr2Tknl3kbXT
         7kYp3cGjzdN7k3XTaInGhODdiV+ccQsBVXaD37c7u6Ad4rYeLg4Eo0/+evgqIEVz6046
         My3TCu8LsResLFdIyp5+pvJhwNTqd6m8hfcDbIsyWvdAHCWAay8VYBCiD2t++I0rfuer
         ieyZcdKD6sgSskEkt1jHmo0WxX+YOSi0vynOxJv1611X4BH5O0MhkNmw4Fv1rEekkq4f
         LZNA==
X-Gm-Message-State: AOAM530jKxS27Jn5hn/wixgxAzgLa3vZ08nChhpjxAQKgL7ftYM5cjp5
        KmIRJIzv0/wWp/3B/kfR1SXU4g==
X-Google-Smtp-Source: ABdhPJycpwt5qO7WpX2tEb1dJujuhkW9/h+DcFDv3HkzkqgjFewtG2LHxHNN78Y8gM6p5lmRuaP3BA==
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr1619721wma.38.1589838823492;
        Mon, 18 May 2020 14:53:43 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:483d:6b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id k5sm17485030wrx.16.2020.05.18.14.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 14:53:42 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: =?UTF-8?q?=5BPATCH=20V3=202/2=5D=20restripe=3A=20fix=20ignoring=20return=20value=20of=20=E2=80=98read=E2=80=99=20and=20lseek?=
Date:   Mon, 18 May 2020 23:53:36 +0200
Message-Id: <20200518215336.29000-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518215336.29000-1-guoqing.jiang@cloud.ionos.com>
References: <20200518215336.29000-1-guoqing.jiang@cloud.ionos.com>
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

And check the return value of lseek as well per Jes's comment.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 restripe.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/restripe.c b/restripe.c
index 31b07e8..86e1d00 100644
--- a/restripe.c
+++ b/restripe.c
@@ -866,8 +866,16 @@ int test_stripes(int *source, unsigned long long *offsets,
 		int disk;
 
 		for (i = 0 ; i < raid_disks ; i++) {
-			lseek64(source[i], offsets[i]+start, 0);
-			read(source[i], stripes[i], chunk_size);
+			if ((lseek64(source[i], offsets[i]+start, 0) < 0) ||
+			    (read(source[i], stripes[i], chunk_size) !=
+			     chunk_size)) {
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

