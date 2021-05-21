Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E61E38BB0D
	for <lists+linux-raid@lfdr.de>; Fri, 21 May 2021 02:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhEUA5t (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 May 2021 20:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhEUA5t (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 20 May 2021 20:57:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D7BC061574
        for <linux-raid@vger.kernel.org>; Thu, 20 May 2021 17:56:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so6423420pjt.1
        for <linux-raid@vger.kernel.org>; Thu, 20 May 2021 17:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+M3bbBUyXX05vfzT5qDXy306Y2NVP5FnnFrMu3zMkg=;
        b=WnEBZ3UzVNxTJh7aYKFNBgrdxfKVHYNc7FcBU+FQyQTpH0T0Gn6AhQ2ZMu3fglYY02
         m/WCJ3sVR/6ISrq1CmCnh4hI+/swx5HoqS44h3/7cbF+7XCzTpHWxa1O/5fde81dHtKD
         yLwujpKctHsVl2WzCY8//WnzoBiqqthlhIGUZafzMNgAiq7GWasssQrE/vdrHpeKjlkQ
         iyjyhWzwAs6DHituhp2Acd4is3GRE8cEfU6SKa3nSLntPQ95Ts+PgcASzYTeb+VM/O32
         LZ6qNeAHGrVzwuakbHF2sEN9nW7vMB0WVSLEGQ8bCYqzrmaSjof6koGuiY5QNEP5fAmW
         aMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+M3bbBUyXX05vfzT5qDXy306Y2NVP5FnnFrMu3zMkg=;
        b=OEbQazKBRzdOrLZTZmOkhsWDDgCmhsQ7LmL6EqYaELsGlAkmCd1Fn1M4gybm1Tc9ZH
         iM3XIdcGv1AE9LBCbXNN6jhlKQp+cl4T0nja0rYZtVePh5fWwHNQX2Hde/yWITvTxeXU
         ghYWoFRBEvOy65o45mhm1O2c5Nzk4jUYKSZfpgo+hTXDgh1iWtCqYbXAyh9DUtKkE/2J
         +fVFlm4CIwIcLnUKQTxgZJzFWsWJYh2jqCtwfoTlPwEWkUf1y5g+Y6qabFw/hEPbYJfu
         w3pjMPBq8u+MB9ItaYGV1kFufZxjB92J3aSaRP/62nVhp6FGTLOMWtwqK8WeotKLaAqH
         pafA==
X-Gm-Message-State: AOAM531pyEd+9T1EV1L+3jD4sl+AJPBkSgjYWbGyRp+7+fLPaJqFhkAH
        2QBIgXCi5QyHzZPq+DfQawQ=
X-Google-Smtp-Source: ABdhPJy1EbYLHTLmU+I4b36JkTd/Cf6vNLdAM5MbNRk5xXVvGhq4mIcGUSutBoQXfdCzAwwOc67ccQ==
X-Received: by 2002:a17:90a:5649:: with SMTP id d9mr7656538pji.163.1621558585568;
        Thu, 20 May 2021 17:56:25 -0700 (PDT)
Received: from localhost.localdomain ([89.187.161.155])
        by smtp.gmail.com with ESMTPSA id 5sm7405945pjo.17.2021.05.20.17.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 17:56:24 -0700 (PDT)
From:   Guoqing Jiang <jgq516@gmail.com>
X-Google-Original-From: Guoqing Jiang <jiangguoqing@kylinos.cn>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, artur.paszkiewicz@intel.com
Subject: [PATCH V2 0/7] md: io stats accounting
Date:   Fri, 21 May 2021 08:55:14 +0800
Message-Id: <20210521005521.713106-1-jiangguoqing@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

V2 changes:

1. add accounting_bio to md_personality.
2. cleanup in case bioset_integrity_create fails.
3. use bio_end_io_acct.
4. remove patch for enable io accounting for multipath.
5. add one patch to rename print_msg.
6. add one patch to deprecate linear, multipath and faulty.

Artur Paszkiewicz (1):
  md: the latest try for improve io stats accounting

Guoqing Jiang (6):
  md: revert io stats accounting
  md: add accounting_bio for raid0 and raid5
  md/raid1: rename print_msg with r1bio_existed
  md/raid1: enable io accounting
  md/raid10: enable io accounting
  md: mark some personalities as deprecated

 drivers/md/Kconfig        |  6 ++--
 drivers/md/md-faulty.c    |  2 +-
 drivers/md/md-linear.c    |  2 +-
 drivers/md/md-multipath.c |  2 +-
 drivers/md/md.c           | 66 ++++++++++++++++++++++-----------------
 drivers/md/md.h           |  4 ++-
 drivers/md/raid0.c        | 14 +++++++++
 drivers/md/raid1.c        | 15 ++++++---
 drivers/md/raid1.h        |  1 +
 drivers/md/raid10.c       |  6 ++++
 drivers/md/raid10.h       |  1 +
 drivers/md/raid5.c        | 17 ++++++++++
 12 files changed, 97 insertions(+), 39 deletions(-)

-- 
2.25.1

