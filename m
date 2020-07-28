Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F045230726
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 12:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgG1KCO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 06:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgG1KCN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 06:02:13 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393C0C061794
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:13 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so14351861edy.1
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V60/6IDK9L2iyzMfMFaYWNV4LWpAqCVaHIEXV4H7h9I=;
        b=DvUX887nLly+M7a/tB8NvU/R80bxy3nG68hSXgjmjLhtvYjgeXH/1VYxtOdIgdzFwj
         y1jHJ/4Vs5mi/RNYryEknHT6A+gFqeScNizSopMAn0YFJNce8x+u5iYtpmtjZvrmaDJE
         BcNADsJa0xHPz3Cbmbi7yklXkKHjREKbBhbCIbyWStQWwuGdvqTvP2LP31aQRSEDOPmK
         6i+/UGuJFnUEWH9bw0k349j8QK62w0ZMthH9B9Q+IowTnLzH3KncwlqcGCsyvVL7Mmrs
         EfI0JlpyfX/v5jcMJ2dE6xiQdZRmjQQZvPfOE3fHtONAlq1IHNfM5MF9gg4j3Z6ElEZr
         qPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V60/6IDK9L2iyzMfMFaYWNV4LWpAqCVaHIEXV4H7h9I=;
        b=gGprMSmhAM4yZ5IWR6ImlVDW5lV+iOuGM9VvIdpYcdfoSUOBG+L08TdlaZNPmaPiXr
         NHH5tbzfvYc8UIeM66cppMhu2mP4PrH38kXNikhxzptqX/4HrENOEU9+3fauo8OHgYXS
         SCznw+dmRtfZ6Yu25Aoj/vnN3j1fxxaLVOqkJJ8GDSTiJrS3MJaGCVze5k0dpoh0iHP1
         bvTZEmABOD3nHA0DcUatLgFbJp6PA0NkgWH1bVtfY4tTkOOhZV1ct1EM7fUDW1jsxQ0m
         nVFI8OhF+YMVJLS1YdUIW4R2ySTEwjUQJD+V2wXk6iFBl3i6vFwI3GTFzx80ZpRbZxKi
         GQQg==
X-Gm-Message-State: AOAM531RGmvxTgLk981zzzlXCJGSgaeN34N9WSyceGTVo9cmoHJLOIQh
        S3Il2G05TCT5MAd2pTG9+/q+PA==
X-Google-Smtp-Source: ABdhPJy4f5H/4LynmJyJnz2+spOwCNgTmTHME+AVB9bEmAZtlA7FL6Z4yUUexk+cxcER36uO1x4VIg==
X-Received: by 2002:a50:bece:: with SMTP id e14mr24796903edk.190.1595930531975;
        Tue, 28 Jul 2020 03:02:11 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:34cb:1cd0:d3a5:9c35])
        by smtp.gmail.com with ESMTPSA id b24sm9929530edn.33.2020.07.28.03.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:02:11 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 3/5] md: print errno in super_written
Date:   Tue, 28 Jul 2020 12:01:41 +0200
Message-Id: <20200728100143.17813-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
References: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

It is better to print errno instead of bi_status.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0c2a0e65b4f1..8f9a89b4c7ba 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -978,7 +978,8 @@ static void super_written(struct bio *bio)
 	struct mddev *mddev = rdev->mddev;
 
 	if (bio->bi_status) {
-		pr_err("md: super_written gets error=%d\n", bio->bi_status);
+		pr_err("md: %s gets error=%d\n", __func__,
+		       blk_status_to_errno(bio->bi_status));
 		md_error(mddev, rdev);
 		if (!test_bit(Faulty, &rdev->flags)
 		    && (bio->bi_opf & MD_FAILFAST)) {
-- 
2.17.1

