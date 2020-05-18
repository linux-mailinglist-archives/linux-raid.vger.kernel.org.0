Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6FC1D8A41
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 23:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgERVxn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 17:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVxn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 17:53:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A69C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 14:53:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so13612030wrt.1
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 14:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TCu29o6eATtSemGL3ZcNFB4wBSzlU9leXrxSYAF3ShY=;
        b=GEYtwxdZ3Lcpf0KC5iM/QamOyzSeCmSEn55EZHYuDf7tlywPbWItsaAz3FQJmzCkc4
         SYz6b0TM/uBmu4TSoVqcRAClnZ3isuArXgnIfZxP1SwpPgjvxaZxLKSAELhWEdSGJVHu
         pwPu3jrHad8fAK5GxSUmjTV8m6hS5B2ijxZ/FSuw5tWZW+dlVK4TH5FUBjEkZ6KpgJN/
         vh5BAHbupogCOeycRXeTSbdLXfM/z5kwTBEv7TMqXf+OGLnX4UnQgsBo9+os1qUd1UAM
         eE0ebwvp8JaR5plZoLam7ZNM8bsORa0nV2vqUpqypVd0anUTkO7qOrzJaridtOyGTV65
         VI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TCu29o6eATtSemGL3ZcNFB4wBSzlU9leXrxSYAF3ShY=;
        b=Dal74nkpnnvxHuJxVVJY0n/Q8H8NsHRjMppimMatSttsws9R7Q2wXyZS5N7na2Pa/T
         LNylA7ReSmicjeFkuSTB4zYtSYiIPmTXDCuhI+P/ozuk67tmc7t8ETyvU/dVkGbbfCgj
         BblZFkyw+HA0c6uJz+6ZOn+mwwZn9WGunMRyFK1CBgbLqkmGKUTnxjSw+EvoqQZK13V0
         EQXcdy9yL6X9tiL9h1d3Em1xzatxpDkljRFWy9Ztwsp0xTgmvOmygSXsKXxfMf5wR/ZX
         tM2o+p/u+54+KA0kIgY3YV5oqIzZfsYQJ5LMq4coZDuTTtWKl/VtVZO1qrme6XpMdfLf
         XKGw==
X-Gm-Message-State: AOAM532rYsqg36cmv1szOF4jzI64TJNjLKW1S8d9t2YOFEM/ApTg1NpR
        zd1QaidnxKU3AcDy7IglTv5vrw==
X-Google-Smtp-Source: ABdhPJw+WUikYOV24UonagymI00vcyM5X6nm/Okby7Mphk3c1QeryIgdefM0iKaFBi1Le/zCdrkjIQ==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr23247491wru.40.1589838821566;
        Mon, 18 May 2020 14:53:41 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:483d:6b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id k5sm17485030wrx.16.2020.05.18.14.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 14:53:40 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 0/2] Fix build issues
Date:   Mon, 18 May 2020 23:53:34 +0200
Message-Id: <20200518215336.29000-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jes,

A new version per your comment, let me know if I still missed something.

V3 Change:
1. check the return value of lseek

V2 Changes:
1. copy the whole license from util.c to uuid.c
2. check the return value of read correctly

Thanks,
Guoqing

Guoqing Jiang (2):
  uuid.c: split uuid stuffs from util.c
  restripe: fix ignoring return value of ‘read’ and lseek

 Makefile   |   6 +--
 restripe.c |  12 +++++-
 util.c     |  87 -----------------------------------------
 uuid.c     | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 92 deletions(-)
 create mode 100644 uuid.c

-- 
2.17.1

